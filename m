Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262914AbSJBBTV>; Tue, 1 Oct 2002 21:19:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262917AbSJBBTV>; Tue, 1 Oct 2002 21:19:21 -0400
Received: from byterapers.com ([195.156.109.210]:44949 "EHLO byterapers.com")
	by vger.kernel.org with ESMTP id <S262914AbSJBBTU>;
	Tue, 1 Oct 2002 21:19:20 -0400
Date: Wed, 2 Oct 2002 04:24:47 +0300 (EEST)
From: <jhakala@byterapers.com>
To: linux-kernel@vger.kernel.org
Subject: 2.5.40 FB_RIVA broken
Message-ID: <Pine.LNX.4.21.0210020410230.28657-100000@byterapers.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Using framebuffer-driver for "nVidia Riva" causes compile to fail.
(in .config: CONFIG_FB_RIVA=y)
-----------------
 gcc -Wp,-MD,./.accel.o.d -D__KERNEL__ -I/usr/src/linux-2.5.40/include
-Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer
-fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2
-march=athlon  -I/usr/src/linux-2.5.40/arch/i386/mach-generic -nostdinc
-iwithprefix include    -DKBUILD_BASENAME=accel   -c -o accel.o accel.c
drivers/video/riva/accel.c: In function `fbcon_riva8_setup':
drivers/video/riva/accel.c:165: structure has no member named
`line_length'
drivers/video/riva/accel.c:165: structure has no member named
`line_length'
drivers/video/riva/accel.c: In function `fbcon_riva16_setup':
drivers/video/riva/accel.c:271: structure has no member named
`line_length'
drivers/video/riva/accel.c:271: structure has no member named
`line_length'
drivers/video/riva/accel.c: In function `fbcon_riva32_setup':
drivers/video/riva/accel.c:358: structure has no member named
`line_length'
drivers/video/riva/accel.c:358: structure has no member named
`line_length'
  ld -m elf_i386  -r -o rivafb.o fbdev.o riva_hw.o accel.o
ld: cannot open fbdev.o: No such file or directory
make[3]: *** [rivafb.o] Error 1
make[3]: Leaving directory `/usr/src/linux-2.5.40/drivers/video/riva'
make[2]: *** [riva] Error 2
make[2]: Leaving directory `/usr/src/linux-2.5.40/drivers/video'
make[1]: *** [video] Error 2
make[1]: Leaving directory `/usr/src/linux-2.5.40/drivers'
make: *** [drivers] Error 2
----------------

the complete .config -file is available from
http://byterapers.com/~jhakala/config2540_riva

Compiler was unofficial RedHatted GCC version 2.96-81. (shame on me)


