Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261425AbREUNOX>; Mon, 21 May 2001 09:14:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261426AbREUNOO>; Mon, 21 May 2001 09:14:14 -0400
Received: from tomts8.bellnexxia.net ([209.226.175.52]:64400 "EHLO
	tomts8-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id <S261425AbREUNN5>; Mon, 21 May 2001 09:13:57 -0400
From: "Justin Slootsky" <slootsky@bigfoot.com>
To: <mec@shout.net>, <linux-kernel@vger.kernel.org>
Subject: kernel-source-2.2.19 - error in menuconfig
Date: Mon, 21 May 2001 09:14:52 -0400
Message-ID: <001101c0e1f8$05a4cf80$0602a8c0@chase.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook 8.5, Build 4.71.2173.0
X-MimeOLE: Produced By Microsoft MimeOLE V5.00.2615.200
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I downloaded the .deb package for kernel-source-2.2.19.

I tried to run make menuconfig and the following happened...

> bash-2.05# make menuconfig
> rm -f include/asm
> ( cd include ; ln -sf asm-i386 asm)
> make -C scripts/lxdialog all
> make[1]: Entering directory
`/usr/src/kernel-source-2.2.19/scripts/lxdialog'
> make[1]: Leaving directory
`/usr/src/kernel-source-2.2.19/scripts/lxdialog'
> /bin/sh scripts/Menuconfig arch/i386/config.in
> Using defaults found in .config
> Preparing scripts: functions, parsingawk: cannot open "MCmenu19" for
output (Too many open files)
> Awk died with error code 2. Giving up.
> .scripts/Menuconfig: ./MCmenu0: line 34: syntax error near unexpected
token `}'
> scripts/Menuconfig: ./MCmenu0: line 34: `}'
> .....scripts/Menuconfig: ./MCmenu13: line 89: syntax error: unexpected end
of file
> .............done.

then the following error showed up, so I'm reporting it as requested.

| Menuconfig has encountered a possible error in one of the kernel's
| configuration files and is unable to continue.  Here is the error
| report:
|
|  Q> scripts/Menuconfig: MCmenu0: command not found
|
| Please report this to the maintainer <mec@shout.net>.  You may also
| send a problem report to <linux-kernel@vger.kernel.org>.
|
| Please indicate the kernel version you are trying to configure and
| which menu you were trying to enter when this error occurred.
|
| make: *** [menuconfig] Error



Justin Slootsky
slootsky@bigfoot.com


