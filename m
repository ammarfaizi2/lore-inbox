Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264479AbTEPQIK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 May 2003 12:08:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264480AbTEPQIK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 May 2003 12:08:10 -0400
Received: from siaab1ab.compuserve.com ([149.174.40.2]:40129 "EHLO
	siaab1ab.compuserve.com") by vger.kernel.org with ESMTP
	id S264479AbTEPQIF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 May 2003 12:08:05 -0400
Date: Fri, 16 May 2003 12:15:21 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: The disappearing sys_call_table export.
To: Mike Touloumtzis <miket@bluemug.com>
Cc: Ahmed Masud <masud@googgun.com>, Jesse Pollard <jesse@cats-chateau.net>,
       linux-kernel@vger.kernel.org, Yoav Weiss <ml-lkml@unpatched.org>
Message-ID: <200305161219_MC3-1-3938-C302@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mike Touloumtzis wrote:

> No Unix (even a "secure" one) is designed to run all security-critical
> code in the kernel.  That would be a bad design anyway, since it would
> run lots of code at an unwarranted privilege level.  "login" is not
> part of the kernel.  "su" is not part of the kernel".

  Yes, but "elsewhere" I can audit the system and see which programs
and subsystems are authorized to logon users and the authentication
methods they can use.  Note that the below output is not from some
"security enhanced" or "server" version of the OS but rather from
a $179 upgrade I bought at the local Staples store:


2003-05-16      05:06:25        Security        Success Audit   System Event    515     NT AUTHORITY\SYSTEM
"A trusted logon process has registered with the Local Security Authority.
 This logon process will be trusted to submit logon requests. 
 Logon Process Name:    Protected Storage Service "

2003-05-16      05:06:24        Security        Success Audit   System Event    515     NT AUTHORITY\SYSTEM
"A trusted logon process has registered with the Local Security Authority.
 This logon process will be trusted to submit logon requests. 
 Logon Process Name:    LAN Manager Workstation Service "

2003-05-16      05:06:17        Security        Success Audit   System Event    518     NT AUTHORITY\SYSTEM
"An notification package has been loaded by the Security Account Manager.
 This package will be notified of any account or password changes. 
 Notification Package Name:     scecli "

2003-05-16      05:06:17        Security        Success Audit   System Event    515     NT AUTHORITY\SYSTEM
"A trusted logon process has registered with the Local Security Authority.
 This logon process will be trusted to submit logon requests. 
 Logon Process Name:    Service Control Manager "

2003-05-16      05:06:17        Security        Success Audit   System Event    515     NT AUTHORITY\SYSTEM
"A trusted logon process has registered with the Local Security Authority.
 This logon process will be trusted to submit logon requests. 
 Logon Process Name:    Winlogon\MSGina "

2003-05-16      05:06:17        Security        Success Audit   System Event    515     NT AUTHORITY\SYSTEM
"A trusted logon process has registered with the Local Security Authority.
 This logon process will be trusted to submit logon requests. 
 Logon Process Name:    KSecDD "

2003-05-16      05:06:17        Security        Success Audit   System Event    514     NT AUTHORITY\SYSTEM
"An authentication package has been loaded by the Local Security Authority.
 This authentication package will be used to authenticate logon attempts. 
 Authentication Package Name:   D:\WINNT\system32\msv1_0.dll : MICROSOFT_AUTHENTICATION_PACKAGE_V1_0 "

2003-05-16      05:06:17        Security        Success Audit   System Event    514     NT AUTHORITY\SYSTEM
"An authentication package has been loaded by the Local Security Authority.
 This authentication package will be used to authenticate logon attempts. 
 Authentication Package Name:   D:\WINNT\system32\schannel.dll : Microsoft Unified Security Protocol Provider "

2003-05-16      05:06:17        Security        Success Audit   System Event    514     NT AUTHORITY\SYSTEM
"An authentication package has been loaded by the Local Security Authority.
 This authentication package will be used to authenticate logon attempts. 
 Authentication Package Name:   D:\WINNT\system32\msv1_0.dll : NTLM "

2003-05-16      05:06:17        Security        Success Audit   System Event    514     NT AUTHORITY\SYSTEM
"An authentication package has been loaded by the Local Security Authority.
 This authentication package will be used to authenticate logon attempts. 
 Authentication Package Name:   D:\WINNT\system32\kerberos.dll : Kerberos "

2003-05-16      05:06:17        Security        Success Audit   System Event    514     NT AUTHORITY\SYSTEM
"An authentication package has been loaded by the Local Security Authority.
 This authentication package will be used to authenticate logon attempts. 
 Authentication Package Name:   D:\WINNT\system32\LSASRV.dll : Negotiate "


