Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317521AbSHYULt>; Sun, 25 Aug 2002 16:11:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317525AbSHYULt>; Sun, 25 Aug 2002 16:11:49 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:27642 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S317521AbSHYULs>; Sun, 25 Aug 2002 16:11:48 -0400
Date: Sun, 25 Aug 2002 22:15:57 +0200 (CEST)
From: Adrian Bunk <bunk@fs.tum.de>
X-X-Sender: bunk@mimas.fachschaften.tu-muenchen.de
To: Alan Cox <alan@redhat.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.20-pre4-ac1
In-Reply-To: <200208231046.g7NAk2914276@devserv.devel.redhat.com>
Message-ID: <Pine.NEB.4.44.0208252214030.2879-100000@mimas.fachschaften.tu-muenchen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alan,

the inclusion of linux/ide.h in hd.c causes the following compile error:

<--  snip  -->

...
gcc -D__KERNEL__
-I/home/bunk/linux/kernel-2.4/linux-2.4.19-full-nohotplug/include -Wall
-Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common
-pipe -mpreferred-stack-boundary=2 -march=k6  -I../ -nostdinc -iwithprefix
include -DKBUILD_BASENAME=hd  -c -o hd.o hd.c
hd.c:88: conflicting types for `recal_intr'
/home/bunk/linux/kernel-2.4/linux-2.4.19-full-nohotplug/include/linux/ide.h:1496:
previous declaration of `recal_intr'
hd.c: In function `dump_status':
hd.c:181: `QUEUE_EMPTY' undeclared (first use in this function)
hd.c:181: (Each undeclared identifier is reported only once
hd.c:181: for each function it appears in.)
hd.c:181: `CURRENT' undeclared (first use in this function)
hd.c:179: warning: `devc' might be used uninitialized in this function
hd.c: In function `hd_out':
hd.c:294: `DEVICE_INTR' undeclared (first use in this function)
hd.c:294: `TIMEOUT_VALUE' undeclared (first use in this function)
...
make[4]: *** [hd.o] Error 1
make[4]: Leaving directory
`/home/bunk/linux/kernel-2.4/linux-2.4.19-full-nohotplug/drivers/ide/legacy'

<--  snip  -->

cu
Adrian

-- 

You only think this is a free country. Like the US the UK spends a lot of
time explaining its a free country because its a police state.
								Alan Cox

