Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261702AbSJAPA0>; Tue, 1 Oct 2002 11:00:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261703AbSJAPA0>; Tue, 1 Oct 2002 11:00:26 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:16624 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S261702AbSJAPA0>; Tue, 1 Oct 2002 11:00:26 -0400
Date: Tue, 1 Oct 2002 17:05:46 +0200 (CEST)
From: Adrian Bunk <bunk@fs.tum.de>
X-X-Sender: bunk@mimas.fachschaften.tu-muenchen.de
To: Alan Cox <alan@redhat.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.20-pre8-ac3
In-Reply-To: <200209302029.g8UKTfG12427@devserv.devel.redhat.com>
Message-ID: <Pine.NEB.4.44.0210011704410.10143-100000@mimas.fachschaften.tu-muenchen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


FYI:

hd.c still doesn't compile:


<--  snip  -->

...
gcc -D__KERNEL__ -I/home/bunk/linux/kernel-2.4/linux-2.4.19-full/include
-Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common
-pipe -mpreferred-stack-boundary=2 -march=k6  -I../ -nostdinc -iwithprefix include
-DKBUILD_BASENAME=hd  -c -o hd.o hd.c
hd.c:78: conflicting types for `recal_intr'
/home/bunk/linux/kernel-2.4/linux-2.4.19-full/include/linux/ide.h:1478:
previous declaration of `recal_intr'
hd.c: In function `dump_status':
hd.c:171: `QUEUE_EMPTY' undeclared (first use in this function)
hd.c:171: (Each undeclared identifier is reported only once
hd.c:171: for each function it appears in.)
hd.c:171: `CURRENT' undeclared (first use in this function)
hd.c:169: warning: `devc' might be used uninitialized in this function
hd.c: In function `hd_out':
hd.c:284: `DEVICE_INTR' undeclared (first use in this function)
hd.c:284: `TIMEOUT_VALUE' undeclared (first use in this function)
hd.c: In function `do_reset_hd':
...
make[4]: *** [hd.o] Error 1
make[4]: Leaving directory `/home/bunk/linux/kernel-2.4/linux-2.4.19-full/drivers/ide/legacy'

<--  snip  -->

cu
Adrian

-- 

You only think this is a free country. Like the US the UK spends a lot of
time explaining its a free country because its a police state.
								Alan Cox

