*** Settings ***
Library     SeleniumLibrary
Documentation       Suite description #automated tests for scout website

*** Variables ***

${LOGIN URL}        https://scouts-test.futbolkolektyw.pl/en
${BROWSER}      Chrome
${SIGNINBUTTON}     xpath=//*[@type='submit']/span[1]
${LOGININPUT}       xpath=//*[@id='login']
${PASSWORDINPUT}        xpath=//*[@id='password']
${PAGELOGODASHBOARD}     xpath=(//div[contains(@class, 'MuiToolbar-root')])/h6
${SIGNOUTBUTTON}        xpath=(//ul[contains(@class, 'MuiList-root')])[2]/div[2]/div/span
${PAGELOGOLOGIN}        xpath=//*[contains(@class, 'MuiTypography-root MuiTypography-h5')]
${INCORRECTLOGINDATAMESSAGE}        xpath=//span[contains(@class, 'MuiTypography-root')]
${REMINDPASSWORDLINK}       xpath=//a[contains(@class, 'MuiTypography-root')]
${BACKTOSIGNINLINK}         xpath=//a[contains(@class, 'MuiTypography-root')]
${EMAILINPUT}       xpath=//*[@name='email']
${ADDPLAYERLINK}        xpath=(//div[contains(@class, 'MuiPaper-root')])[7]/div/a
${PLAYERNAME}       xpath=//input[@name='name']
${PLAYERSURNAME}    xpath=//input[@name='surname']
${PLAYERAGE}        xpath=//input[@name='age']
${PLAYERLEG}        xpath=//*[@id='mui-component-select-leg']
${PLAYERLEFTLEG}        xpath=//li[@data-value='left']
${PLAYERMAINPOSITION}       xpath=//input[@name='mainPosition']
${SUBMITBUTTON}     xpath=//button[@type='submit']/span[1]
${PLAYERNAMEINMENU}     xpath=//ul[2]/div[1]/div/span[contains(text(),'David Beckham')]
${REMINDLOGO}       xpath=//h5[contains(@class, 'MuiTypography-root')]
${ADDPLAYERLOGO}        xpath=//span[contains(@class, 'MuiTypography-h5')]




*** Test Cases ***
Login to the system
    Open login page
    Type in login
    Type in password
    Click on the Send button
    Assert Dashboard
    [Teardown]      Close Browser

Login out of the system
    Open login page
    Type in login
    Type in password
    Click on the Send button
    Assert Dashboard
    Click on Sign out button
    Assert Login page
    [Teardown]      Close Browser

Incorrect Login
    Open login page
    Type incorrect login
    Type in password
    Click on the Send button
    Assert Login page
    Assert incorrect login message
    [Teardown]      Close Browser

Empty Password
    Open login page
    Type in login
    Type empty password
    Click on the Send button
    Assert Login page
    Assert empty password message
    [Teardown]      Close Browser

Remind Password
    Open login page
    Click on Remind password
    Type in email
    Click on the Send button
    Click on Back to sign in
    Assert Login page
    [Teardown]      Close Browser

Add New Player
    Open login page
    Type in login
    Type in password
    Click on the Send button
    Assert Dashboard
    Click on Add Player
    Type in name
    Type in surname
    Select age
    Select left leg
    Type in main position
    Click on the Submit button
    Assert new player in menu
    [Teardown]      Close Browser

*** Keywords ***
Open login page
    Open Browser        ${LOGIN URL}    ${BROWSER}
    Title Should be     Scouts panel - sign in
Type in login
    Input Text      ${LOGININPUT}   user07@getnada.com
Type in password
    Input Text      ${PASSWORDINPUT}    Test-1234
Click on the Send button
    Click Element   ${SIGNINBUTTON}
Assert Dashboard
    wait until element is visible   ${PAGELOGODASHBOARD}
    title Should be     Scouts panel
    capture page screenshot     alert.png
Click on Sign out button
    Click Element       ${SIGNOUTBUTTON}
Assert Login page
    wait until element is visible   ${PAGELOGOLOGIN}
    title Should be     Scouts panel - sign in
    capture page screenshot     alert2.png
Type incorrect login
    Input Text      ${LOGININPUT}   test
Assert incorrect login message
    wait until element is visible   ${INCORRECTLOGINDATAMESSAGE}
    element text should be   ${INCORRECTLOGINDATAMESSAGE}    Identifier or password invalid.
    capture page screenshot     alert3.png
Type empty password
    Input Text      ${PASSWORDINPUT}    ${EMPTY}
Assert empty password message
    wait until element is visible   ${INCORRECTLOGINDATAMESSAGE}
    element text should be    ${INCORRECTLOGINDATAMESSAGE}     Please provide your password.
    capture page screenshot     alert4.png
Click on Remind password
    Click Element       ${REMINDPASSWORDLINK}
    wait until element is visible       ${REMINDLOGO}
Type in email
    Input Text      ${EMAILINPUT}   user07@getnada.com
Click on Back to sign in
    Click Element       ${BACKTOSIGNINLINK}
Click on Add Player
    Click Element       ${ADDPLAYERLINK}
    wait until element is visible       ${ADDPLAYERLOGO}
Type in name
    Input Text      ${PLAYERNAME}       David
Type in surname
    Input Text      ${PLAYERSURNAME}       Beckham
Select age
    Input Text      ${PLAYERAGE}        12/12/1972
Select left leg
    Click Element       ${PLAYERLEG}
    Click Element       ${PLAYERLEFTLEG}
Type in main position
    Input Text      ${PLAYERMAINPOSITION}       captain
Click on the Submit button
    Click Element       ${SUBMITBUTTON}
Assert new player in menu
    wait until element is visible   ${PLAYERNAMEINMENU}
    element text should be    ${PLAYERNAMEINMENU}     David Beckham
    capture page screenshot     alert5.png