Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262027AbSI3LsN>; Mon, 30 Sep 2002 07:48:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262028AbSI3LsM>; Mon, 30 Sep 2002 07:48:12 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:14540 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S262027AbSI3LsM>; Mon, 30 Sep 2002 07:48:12 -0400
Date: Mon, 30 Sep 2002 13:53:33 +0200 (CEST)
From: Adrian Bunk <bunk@fs.tum.de>
X-X-Sender: bunk@mimas.fachschaften.tu-muenchen.de
To: Dave Jones <davej@codemonkey.org.uk>
cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: i8k.c doesn't compile in 2.5.39-dj2
Message-ID: <Pine.NEB.4.44.0209301346470.12605-100000@mimas.fachschaften.tu-muenchen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


FYI:

i8k.c doesn't compile in 2.5.39-dj2 (kbd_ll.h is no longer present in
2.5.39):

<--  snip  -->

...
  gcc -Wp,-MD,./.i8k.o.d -D__KERNEL__
-I/home/bunk/linux/kernel-2.5/linux-2.5.39-full/include -Wall
-Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common
-pipe -mpreferred-stack-boundary=2 -march=k6
-I/home/bunk/linux/kernel-2.5/linux-2.5.39-full/arch/i386/mach-generic
-nostdinc -iwithprefix include    -DKBUILD_BASENAME=i8k   -c -o i8k.o i8k.c
i8k.c:26: linux/kbd_ll.h: No such file or directory
i8k.c: In function `i8k_keys_poll':
i8k.c:546: warning: implicit declaration of function `handle_scancode'
make[2]: *** [i8k.o] Error 1
make[2]: Leaving directory `/home/bunk/linux/kernel-2.5/linux-2.5.39-full/drivers/char'

<--  snip  -->

cu
Adrian

-- 

You only think this is a free country. Like the US the UK spends a lot of
time explaining its a free country because its a police state.
								Alan Cox



