Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262869AbSJLKPS>; Sat, 12 Oct 2002 06:15:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262870AbSJLKPS>; Sat, 12 Oct 2002 06:15:18 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:16071 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S262869AbSJLKPS>; Sat, 12 Oct 2002 06:15:18 -0400
Date: Sat, 12 Oct 2002 12:21:00 +0200 (CEST)
From: Adrian Bunk <bunk@fs.tum.de>
X-X-Sender: bunk@mimas.fachschaften.tu-muenchen.de
To: Ingo Molnar <mingo@elte.hu>
cc: linux-kernel@vger.kernel.org
Subject: 2.5.42: stallion.c doesn't compile
Message-ID: <Pine.NEB.4.44.0210121215370.8340-100000@mimas.fachschaften.tu-muenchen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ingo,

the following compile error in stallion.c seems to be a result of your
Workqueue Abstraction patch:

<--  snip  -->

...
  gcc -Wp,-MD,drivers/char/.stallion.o.d -D__KERNEL__ -Iinclude -Wall
-Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer
-fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2
-march=k6 -Iarch/i386/mach-generic -nostdinc -iwithprefix include
-DKBUILD_BASENAME=stallion   -c -o drivers/char/stallion.o
drivers/char/stallion.c
...
drivers/char/stallion.c: In function `stl_initports':
drivers/char/stallion.c:2294: structure has no member named `routine'
...
make[2]: *** [drivers/char/stallion.o] Error 1

<--  snip  -->

Could you provide a fix for this?

TIA
Adrian

-- 

"Is there not promise of rain?" Ling Tan asked suddenly out
of the darkness. There had been need of rain for many days.
"Only a promise," Lao Er said.
                                Pearl S. Buck - Dragon Seed

