Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315971AbSHFVE0>; Tue, 6 Aug 2002 17:04:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315919AbSHFVDX>; Tue, 6 Aug 2002 17:03:23 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:1273 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S315709AbSHFVCM>; Tue, 6 Aug 2002 17:02:12 -0400
Date: Tue, 6 Aug 2002 23:05:44 +0200 (CEST)
From: Adrian Bunk <bunk@fs.tum.de>
X-X-Sender: bunk@mimas.fachschaften.tu-muenchen.de
To: Marcelo Tosatti <marcelo@conectiva.com.br>, <davem@nuts.ninka.net>
cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.20-pre1
In-Reply-To: <Pine.LNX.4.44.0208051938380.6811-100000@freak.distro.conectiva>
Message-ID: <Pine.NEB.4.44.0208062302190.27501-100000@mimas.fachschaften.tu-muenchen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The changes to drivers/net/tg3.c in -pre1 broke the compilation:

<--  snip  -->

...
gcc -D__KERNEL__ -I/home/bunk/linux/kernel-2.4/linux-2.4.19-full/include
-Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing
-fno-common -pipe -mpreferred-stack-boundary=2 -march=k6   -nostdinc -I
/usr/lib/gcc-lib/i386-linux/2.95.4/include -DKBUILD_BASENAME=tg3  -c -o
tg3.o tg3.c
In file included from tg3.c:25:
/home/bunk/linux/kernel-2.4/linux-2.4.19-full/include/linux/if_vlan.h: In
function `__vlan_hwaccel_rx':
/home/bunk/linux/kernel-2.4/linux-2.4.19-full/include/linux/if_vlan.h:186:
warning: implicit declaration of function `netif_receive_skb'
tg3.c: In function `tg3_poll':
tg3.c:1936: structure has no member named `quota'
tg3.c:1937: structure has no member named `quota'
tg3.c:1942: structure has no member named `quota'
tg3.c:1949: warning: implicit declaration of function `netif_rx_complete'
tg3.c: In function `tg3_interrupt_main_work':
tg3.c:1976: warning: implicit declaration of function
`netif_rx_schedule_prep'
tg3.c:1979: warning: implicit declaration of function
`__netif_rx_schedule'
tg3.c: In function `tg3_init_one':
tg3.c:5991: structure has no member named `poll'
tg3.c:5992: structure has no member named `weight'
make[3]: *** [tg3.o] Error 1
make[3]: Leaving directory `/home/bunk/linux/kernel-2.4/linux-2.4.19-full/drivers/net'

<--  snip  -->

cu
Adrian

-- 

You only think this is a free country. Like the US the UK spends a lot of
time explaining its a free country because its a police state.
								Alan Cox

