Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318464AbSGSIfN>; Fri, 19 Jul 2002 04:35:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318472AbSGSIfN>; Fri, 19 Jul 2002 04:35:13 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.176.19]:32464 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S318464AbSGSIfM>; Fri, 19 Jul 2002 04:35:12 -0400
Date: Fri, 19 Jul 2002 10:38:10 +0200 (CEST)
From: Adrian Bunk <bunk@fs.tum.de>
X-X-Sender: bunk@mimas.fachschaften.tu-muenchen.de
To: Alan Cox <alan@redhat.com>, <kirk@braille.uwo.ca>
cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.19-rc2-ac2
In-Reply-To: <200207181935.g6IJZrZ06774@devserv.devel.redhat.com>
Message-ID: <Pine.NEB.4.44.0207191030440.17300-100000@mimas.fachschaften.tu-muenchen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



There's the following compile error in 2.4.19-rc2-ac2:

<--  snip  -->

...
gcc -D__KERNEL__
-I/home/bunk/linux/kernel-2.4/linux-full-nohotplug/include -Wall
-Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common
-pipe -mpreferred-stack-boundary=2 -march=k6   -nostdinc -I
/usr/lib/gcc-lib/i386-linux/2.95.4/include
-DKBUILD_BASENAME=speakup_drvcommon  -c -o speakup_drvcommon.o
speakup_drvcommon.c
In file included from
/usr/lib/gcc-lib/i386-linux/2.95.4/include/syslimits.h:7,
                 from
/usr/lib/gcc-lib/i386-linux/2.95.4/include/limits.h:11,
                 from speakup_drvcommon.c:163:
/usr/lib/gcc-lib/i386-linux/2.95.4/include/limits.h:117: No include path
in which to find limits.h
make[4]: *** [speakup_drvcommon.o] Error 1
make[4]: Leaving directory
`/home/bunk/linux/kernel-2.4/linux-full-nohotplug/drivers/char/speakup'

<--   snip  -->


speakup_drvcommon.c does #include <limits.h> and this is not a typo, it
tries to use USHRT_MAX later...


cu
Adrian

-- 

You only think this is a free country. Like the US the UK spends a lot of
time explaining its a free country because its a police state.
								Alan Cox

