Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318912AbSHEWlW>; Mon, 5 Aug 2002 18:41:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318913AbSHEWlW>; Mon, 5 Aug 2002 18:41:22 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:47822 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S318912AbSHEWlV>; Mon, 5 Aug 2002 18:41:21 -0400
Date: Tue, 6 Aug 2002 00:44:51 +0200 (CEST)
From: Adrian Bunk <bunk@fs.tum.de>
X-X-Sender: bunk@mimas.fachschaften.tu-muenchen.de
To: Alan Cox <alan@redhat.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.19-ac4
In-Reply-To: <200208051147.g75Blh720012@devserv.devel.redhat.com>
Message-ID: <Pine.NEB.4.44.0208060039100.27501-100000@mimas.fachschaften.tu-muenchen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alan,

trying to compile a kernel with CONFIG_BLK_DEV_HD enabled fails with the
following error:

<--  snip  -->

...
gcc -D__KERNEL__
-I/home/bunk/linux/kernel-2.4/linux-2.4.19-full-nohotplug/inclu
de -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing
-fno-common
 -pipe -mpreferred-stack-boundary=2 -march=k6   -nostdinc -I
/usr/lib/gcc-lib/i386-linux/2.95.4/include -DKBUILD_BASENAME=hd  -c -o hd.o hd.c
hd.c: In function `dump_status':
hd.c:210: warning: implicit declaration of function `IN_BYTE'
...
        --end-group \
        -o vmlinux
drivers/ide/idedriver.o: In function `dump_status':
drivers/ide/idedriver.o(.text+0x68): undefined reference to `IN_BYTE'
drivers/ide/idedriver.o: In function `reset_controller':
drivers/ide/idedriver.o(.text+0x55e): undefined reference to `IN_BYTE'
make: *** [vmlinux] Error 1

<--  snip  -->


cu
Adrian

-- 

You only think this is a free country. Like the US the UK spends a lot of
time explaining its a free country because its a police state.
								Alan Cox

