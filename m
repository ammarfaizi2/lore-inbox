Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262125AbSJARjX>; Tue, 1 Oct 2002 13:39:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262118AbSJARia>; Tue, 1 Oct 2002 13:38:30 -0400
Received: from h66-38-216-165.gtconnect.net ([66.38.216.165]:46091 "HELO
	innerfire.net") by vger.kernel.org with SMTP id <S262125AbSJARh6>;
	Tue, 1 Oct 2002 13:37:58 -0400
Date: Tue, 1 Oct 2002 13:43:25 -0400 (EDT)
From: Gerhard Mack <gmack@innerfire.net>
To: linux-kernel@vger.kernel.org
Subject: kernel 2.5.40 fails to compile
Message-ID: <Pine.LNX.4.44.0210011340540.6176-100000@innerfire.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

aty128fb.c and radeonfb.c still fail to compile I have also noticed that
it doesn't stop on compile error anymore.


make[2]: Entering directory `/root/linux-2.3.40/drivers/video'
  gcc -Wp,-MD,./.aty128fb.o.d -D__KERNEL__ -I/root/linux-2.3.40/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=i686 -I/root/linux-2.3.40/arch/i386/mach-generic -nostdinc -iwithprefix include    -DKBUILD_BASENAME=aty128fb   -c -o aty128fb.o aty128fb.c
drivers/video/aty128fb.c:419: unknown field `fb_get_fix' specified in initializer
drivers/video/aty128fb.c:419: warning: initialization from incompatible pointer type
drivers/video/aty128fb.c:420: unknown field `fb_get_var' specified in initializer
drivers/video/aty128fb.c:420: warning: initialization from incompatible pointer type
drivers/video/aty128fb.c: In function `aty128fb_set_var':
drivers/video/aty128fb.c:1379: structure has no member named `visual'
drivers/video/aty128fb.c:1380: structure has no member named `type'
drivers/video/aty128fb.c:1381: structure has no member named `type_aux'
drivers/video/aty128fb.c:1382: structure has no member named `ypanstep'
drivers/video/aty128fb.c:1383: structure has no member named `ywrapstep'
drivers/video/aty128fb.c:1384: structure has no member named `line_length'
  gcc -Wp,-MD,./.radeonfb.o.d -D__KERNEL__ -I/root/linux-2.3.40/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=i686 -I/root/linux-2.3.40/arch/i386/mach-generic -nostdinc -iwithprefix include    -DKBUILD_BASENAME=radeonfb   -c -o radeonfb.o radeonfb.c
drivers/video/radeonfb.c:605: unknown field `fb_get_fix' specified in initializer
drivers/video/radeonfb.c:605: warning: initialization from incompatible pointer type
drivers/video/radeonfb.c:606: unknown field `fb_get_var' specified in initializer
drivers/video/radeonfb.c:606: warning: initialization from incompatible pointer type
drivers/video/radeonfb.c: In function `radeon_set_dispsw':
drivers/video/radeonfb.c:1385: structure has no member named `type'
drivers/video/radeonfb.c:1386: structure has no member named `type_aux'
drivers/video/radeonfb.c:1387: structure has no member named `ypanstep'
drivers/video/radeonfb.c:1388: structure has no member named `ywrapstep'
drivers/video/radeonfb.c:1397: structure has no member named `visual'
drivers/video/radeonfb.c:1398: structure has no member named `line_length'
drivers/video/radeonfb.c:1405: structure has no member named `visual'
drivers/video/radeonfb.c:1406: structure has no member named `line_length'
drivers/video/radeonfb.c:1413: structure has no member named `visual'
drivers/video/radeonfb.c:1414: structure has no member named `line_length'
drivers/video/radeonfb.c:1421: structure has no member named `visual'
drivers/video/radeonfb.c:1422: structure has no member named `line_length'
drivers/video/radeonfb.c: In function `radeonfb_get_fix':
drivers/video/radeonfb.c:1514: structure has no member named `type'
drivers/video/radeonfb.c:1515: structure has no member named `type_aux'
drivers/video/radeonfb.c:1516: structure has no member named `visual'
drivers/video/radeonfb.c:1522: structure has no member named `line_length'
drivers/video/radeonfb.c: In function `radeonfb_set_var':
drivers/video/radeonfb.c:1578: structure has no member named `line_length'
drivers/video/radeonfb.c:1579: structure has no member named `visual'
drivers/video/radeonfb.c:1590: structure has no member named `line_length'
drivers/video/radeonfb.c:1591: structure has no member named `visual'
drivers/video/radeonfb.c:1606: structure has no member named `line_length'
drivers/video/radeonfb.c:1607: structure has no member named `visual'
drivers/video/radeonfb.c:1619: structure has no member named `line_length'
drivers/video/radeonfb.c:1620: structure has no member named `visual'
drivers/video/radeonfb.c: At top level:
drivers/video/radeonfb.c:2487: warning: `fbcon_radeon8' defined but not used
drivers/video/radeonfb.c:598: warning: `radeon_read_OF' declared `static' but never defined
drivers/video/radeonfb.c:1710: warning: `radeonfb_set_cmap' defined but not used
   ld -m elf_i386  -r -o built-in.o dummycon.o vgacon.o font_8x8.o font_8x16.o fbmem.o fbcmap.o modedb.o fbcon.o fonts.o fbgen.o aty128fb.o radeonfb.o fbcon-cfb8.o fbcon-cfb16.o fbcon-cfb24.o fbcon-cfb32.o

--
Gerhard Mack

gmack@innerfire.net

<>< As a computer I find your faith in technology amusing.

