Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264942AbSJ3Wwa>; Wed, 30 Oct 2002 17:52:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264943AbSJ3Wwa>; Wed, 30 Oct 2002 17:52:30 -0500
Received: from smtpzilla3.xs4all.nl ([194.109.127.139]:31502 "EHLO
	smtpzilla3.xs4all.nl") by vger.kernel.org with ESMTP
	id <S264942AbSJ3Wwa>; Wed, 30 Oct 2002 17:52:30 -0500
Date: Wed, 30 Oct 2002 23:58:46 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@serv
To: Bob Billson <reb@bhive.dhs.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: lkc 1.2: make xmenu error
In-Reply-To: <20021030223843.GF4186@etain.bhive.dhs.org>
Message-ID: <Pine.LNX.4.44.0210302355150.13257-100000@serv>
References: <20021030223843.GF4186@etain.bhive.dhs.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, 30 Oct 2002, Bob Billson wrote:

> [reb@etain]:~/kernel/linux-2.5.44$ make xconfig
> make -f scripts/Makefile 
> make -f scripts/kconfig/Makefile scripts/kconfig/qconf
>   gcc -Wp,-MD,scripts/kconfig/.conf.o.d -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer   -c -o scripts/kconfig/conf.o scripts/kconfig/conf.c
>   gcc -Wp,-MD,scripts/kconfig/.kconfig_load.o.d -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer   -c -o scripts/kconfig/kconfig_load.o scripts/kconfig/kconfig_load.c
>   gcc -Wp,-MD,scripts/kconfig/.mconf.o.d -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer   -c -o scripts/kconfig/mconf.o scripts/kconfig/mconf.c
> /usr/share/qt/bin/moc -i scripts/kconfig/qconf.h -o scripts/kconfig/qconf.moc
> make[1]: /usr/share/qt/bin/moc: Command not found
> make[1]: *** [scripts/kconfig/qconf.moc] Error 127
> make: *** [scripts/kconfig/qconf] Error 2
> 
> This is on a Debian (testing tree) box with the libqt3-dev package
> installed.  moc is there, just not in /usr/share/qt/bin:
> 
> [reb@etain]:~/kernel/linux-2.5.44$ whereis moc
> moc: /usr/bin/moc /usr/share/man/man1/moc.1.gz

Debian creates symlinks in /usr/share/qt/bin, which point to /usr/bin, so 
this should work (at least it does here :) ). How does your 
/usr/share/qt/bin look like?

bye, Roman

