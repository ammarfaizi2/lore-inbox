Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261602AbSJBCFh>; Tue, 1 Oct 2002 22:05:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261604AbSJBCFh>; Tue, 1 Oct 2002 22:05:37 -0400
Received: from postoffice2.mail.cornell.edu ([132.236.56.10]:36520 "EHLO
	postoffice2.mail.cornell.edu") by vger.kernel.org with ESMTP
	id <S261602AbSJBCFg>; Tue, 1 Oct 2002 22:05:36 -0400
Content-Type: text/plain;
  charset="us-ascii"
From: Ivan Gyurdiev <ivg2@cornell.edu>
Reply-To: ivg2@cornell.edu
Organization: ( )
To: LKML <linux-kernel@vger.kernel.org>
Subject: Nvidia framebuffer in 2.5 
Date: Tue, 1 Oct 2002 22:11:59 -0400
User-Agent: KMail/1.4.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <200210012211.59573.ivg2@cornell.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This stopped working many kernels ago, and I thought perhaps it's being 
converted to a different API... but it hasn't been fixed yet..is it a bug?

This is 2.5.40.
=========================================
make[3]: Entering directory `/usr/src/linux-2.5.40/drivers/video/riva'
  gcc -Wp,-MD,./.fbdev.o.d -D__KERNEL__ -I/usr/src/linux-2.5.40/include -Wall 
-Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer 
-fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 
-march=athlon  -I/usr/src/linux-2.5.40/arch/i386/mach-generic -nostdinc 
-iwithprefix include    -DKBUILD_BASENAME=fbdev   -c -o fbdev.o fbdev.c
drivers/video/riva/fbdev.c: In function `riva_set_dispsw':
drivers/video/riva/fbdev.c:665: structure has no member named `type'
drivers/video/riva/fbdev.c:666: structure has no member named `type_aux'
drivers/video/riva/fbdev.c:667: structure has no member named `ypanstep'
drivers/video/riva/fbdev.c:668: structure has no member named `ywrapstep'
drivers/video/riva/fbdev.c:657: warning: unused variable `accel'
drivers/video/riva/fbdev.c: In function `rivafb_setcolreg':
drivers/video/riva/fbdev.c:1202: warning: unused variable `chip'
drivers/video/riva/fbdev.c: In function `rivafb_get_fix':
drivers/video/riva/fbdev.c:1294: structure has no member named `type'
drivers/video/riva/fbdev.c:1295: structure has no member named `type_aux'
drivers/video/riva/fbdev.c:1296: structure has no member named `visual'
drivers/video/riva/fbdev.c:1302: structure has no member named `line_length'
drivers/video/riva/fbdev.c: In function `rivafb_pan_display':
drivers/video/riva/fbdev.c:1611: structure has no member named `line_length'
drivers/video/riva/fbdev.c: At top level:
drivers/video/riva/fbdev.c:1748: unknown field `fb_get_fix' specified in 
initializer
drivers/video/riva/fbdev.c:1748: warning: initialization from incompatible 
pointer type
drivers/video/riva/fbdev.c:1749: unknown field `fb_get_var' specified in 
initializer
drivers/video/riva/fbdev.c:1749: warning: initialization from incompatible 
pointer type
drivers/video/riva/fbdev.c:732: warning: `riva_wclut' defined but not used
  gcc -Wp,-MD,./.riva_hw.o.d -D__KERNEL__ -I/usr/src/linux-2.5.40/include 
-Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer 
-fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 
-march=athlon  -I/usr/src/linux-2.5.40/arch/i386/mach-generic -nostdinc 
-iwithprefix include    -DKBUILD_BASENAME=riva_hw   -c -o riva_hw.o riva_hw.c
  gcc -Wp,-MD,./.accel.o.d -D__KERNEL__ -I/usr/src/linux-2.5.40/include -Wall 
-Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer 
-fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 
-march=athlon  -I/usr/src/linux-2.5.40/arch/i386/mach-generic -nostdinc 
-iwithprefix include    -DKBUILD_BASENAME=accel   -c -o accel.o accel.c
drivers/video/riva/accel.c: In function `fbcon_reverse_order':
drivers/video/riva/accel.c:111: warning: operation on `a' may be undefined
drivers/video/riva/accel.c: At top level:
drivers/video/riva/accel.c:56: warning: `fbcon_riva_bmove' defined but not 
used
drivers/video/riva/accel.c:74: warning: `riva_clear_margins' defined but not 
used
drivers/video/riva/accel.c:119: warning: `fbcon_riva_writechr' defined but not 
used
  ld -m elf_i386  -r -o rivafb.o fbdev.o riva_hw.o accel.o
ld: cannot open fbdev.o: No such file or directory
make[3]: *** [rivafb.o] Error 1
make[3]: Leaving directory `/usr/src/linux-2.5.40/drivers/video/riva'
make[2]: *** [riva] Error 2
make[2]: Leaving directory `/usr/src/linux-2.5.40/drivers/video'
make[1]: *** [video] Error 2
make[1]: Leaving directory `/usr/src/linux-2.5.40/drivers'
make: *** [drivers] Error 2
