Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263854AbTE0TOV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 May 2003 15:14:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263986AbTE0TOV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 May 2003 15:14:21 -0400
Received: from web11804.mail.yahoo.com ([216.136.172.158]:21377 "HELO
	web11804.mail.yahoo.com") by vger.kernel.org with SMTP
	id S263854AbTE0TOT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 May 2003 15:14:19 -0400
Message-ID: <20030527192733.81025.qmail@web11804.mail.yahoo.com>
Date: Tue, 27 May 2003 21:27:33 +0200 (CEST)
From: =?iso-8859-1?q?Etienne=20Lorrain?= <etienne_lorrain@yahoo.fr>
Subject: Re: menuconfig .config snooping (was Re: 2.5.69 doesn't boot)
To: Kernel Newbies <kernelnewbies@nl.linux.org>, linux-kernel@vger.kernel.org
Cc: Ed L Cashin <ecashin@uga.edu>
In-Reply-To: <87d6i8tfk0.fsf@cs.uga.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[etienne@localhost linux-2.5.68]$ cat /etc/redhat-release
Red Hat Linux release 9 (Shrike)
[etienne@localhost linux]$ tar -xzf linux-2.5.68.tar.gz
[etienne@localhost linux]$ cd linux-2.5.68
[etienne@localhost linux-2.5.68]$ make menuconfig > log
/boot/config-2.4.20-8:28: trying to assign nonexistent symbol
MAX_USER_RT_PRIO
/boot/config-2.4.20-8:29: trying to assign nonexistent symbol MAX_RT_PRIO
/boot/config-2.4.20-8:42: trying to assign nonexistent symbol HIGHIO
/boot/config-2.4.20-8:65: trying to assign nonexistent symbol AMD_PM768
........ edited ...........
[etienne@localhost linux-2.5.68]$ tail -3 log
# using defaults found in /boot/config-2.4.20-8
#
interrupted


 Maybe linux-2.5 shall not use defaults of linux-2.4 ?
 Repeat solution (not that intuitive):
cp arch/i386/defconfig  .config

 Etienne.

............................................
 --- Ed L Cashin writes:
> Etienne writes:
> 
>>>> # Character devices
>>>> #
>>>> # CONFIG_VT is not set
>>>> # CONFIG_SERIAL_NONSTANDARD is not set
>>>
>>>No VT console is set.
>>
>>  Did someone noticed that if a user want to test Linux-2.5,
>>  he downloads for the first time a 2.5 kernel, extract and type
>> make menuconfig
>>  and that takes its default (.config) from the only kernel
>>  available on his (really standard) distribution - a 2.4.* kernel.
> 
> That isn't true is it?  In the absence of a .config file, does
> menuconfig really look for a configuration somewhere other than its
> own kernel source tree?  Looks to me like it's getting the
> configuration from the defaults.
> 
>   ecashin@meili bk-linux$ make menuconfig 
>   make -f scripts/Makefile.build obj=scripts
>     gcc -Wp,-MD,scripts/.fixdep.d -Wall -Wstrict-prototypes -O2
> -fomit-frame-pointer    -o scripts/fixdep scripts/fixdep.c
> ...
>   ./scripts/kconfig/mconf arch/i386/Kconfig
>   #
>   # using defaults found in arch/i386/defconfig
>   #


___________________________________________________________
Do You Yahoo!? -- Une adresse @yahoo.fr gratuite et en français !
Yahoo! Mail : http://fr.mail.yahoo.com
