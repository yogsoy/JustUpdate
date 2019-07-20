; Where do your app install itself on windows (here it's set to the program files directory).
; Note that the full path will be (in this case) $PROGRAMFILES\%APP_AUTHOR%\%APP_NAME%
; You should change this to match your specific setup, or leave as is if it's already correct.
!define WHERE_TO_INSTALL "$PROGRAMFILES"

; What is the name of your programs executable (including .exe)
; In most cases this should match fine, but if it doesn't feel free to change it.
!define PROGRAM_EXECUTABLE "%APP_NAME%.exe"


; DO NOT CHANGE THE BELOW UNLESS YOU KNOW WHAT YOU'RE DOING!!!!
;--------------------------------
!addplugindir "${NSISDIR}\Plugins\x86-unicode"

;Include Modern UI
  !include "MUI2.nsh"
!include 'StdUtils.nsh'
  !include "zipdll.nsh"

!define APPNAME "%APP_NAME%"
!define COMPANYNAME "%APP_AUTHOR%"
!define VERSION "%VERSION%"

  Name "${APPNAME}"
  OutFile "${APPNAME}-${VERSION}.exe"
  BrandingText "${APPNAME} updater"
  autoclosewindow true
  InstallDir "${WHERE_TO_INSTALL}\${COMPANYNAME}\${APPNAME}"

    VIProductVersion "${VERSION}"
VIAddVersionKey "ProductName" "${APPNAME}"
VIAddVersionKey "LegalCopyright" "Copyright ${COMPANYNAME}"
VIAddVersionKey "ProductVersion" "${VERSION}"

  ;Request application privileges for Windows Vista
  RequestExecutionLevel user

  !define MUI_ABORTWARNING
  !insertmacro MUI_LANGUAGE "English" ;first language is the default language

  !insertmacro MUI_PAGE_INSTFILES
    Page custom launchprogram

Function launchprogram
ExecShell "" '"$INSTDIR\4{PROGRAM_EXECUTABLE}"'  
FunctionEnd

;Installer Sections

  ShowInstDetails "nevershow"
  
Section "${APPNAME}" Main

  SetOutPath "$INSTDIR"

  SetOverwrite ifnewer
  File /r ../dist/win\*.*

SectionEnd
