Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267047AbTASQua>; Sun, 19 Jan 2003 11:50:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267671AbTASQu3>; Sun, 19 Jan 2003 11:50:29 -0500
Received: from postfix4-1.free.fr ([213.228.0.62]:37013 "EHLO
	postfix4-1.free.fr") by vger.kernel.org with ESMTP
	id <S267047AbTASQu0>; Sun, 19 Jan 2003 11:50:26 -0500
Message-ID: <3E2AD8FB.2000101@free.fr>
Date: Sun, 19 Jan 2003 17:57:31 +0100
From: Arnaud Quette <arnaud.quette@free.fr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021226 Debian/1.2.1-9
X-Accept-Language: en
MIME-Version: 1.0
To: Sampson Fung <sampson106@i-cable.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Problem 2.5.59:SiS framebuffer failed to compile while Intel810
 is OK.
References: <00cd01c2bfda$df42fc00$febca8c0@noelpc>
In-Reply-To: <00cd01c2bfda$df42fc00$febca8c0@noelpc>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


this problem is already logged in Kernel Bugzilla
http://bugzilla.kernel.org/show_bug.cgi?id=138
Build error: drivers/video/sis/sis_main.h:299: parse error before "sisfbinfo
since 2.5.50, not yet resolved

Arnaud

Sampson Fung wrote:

>I tested Intel810fb in kernel 2.5.59 with a success result.  MPlayer can
>use fb to play vcd on my Intel Mainboard now.
>
>Then, I want to test the DVD playback in my SiS mainboard that has a DVD
>drive installed.  So I modify the .config to include SiS Framebuffer
>support and failed to compile with errors below:
>=================
>
>make -f scripts/Makefile.build obj=drivers/video/sis
>  gcc -Wp,-MD,drivers/video/sis/.sis_main.o.d -D__KERNEL__ -Iinclude
>-Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing
>-fno-common -pipe -mpreferred-stack-boundary=2 -march=pentium3
>-Iinclude/asm-i386/mach-default -nostdinc -iwithprefix include
>-DKBUILD_BASENAME=sis_main -DKBUILD_MODNAME=sisfb   -c -o
>drivers/video/sis/sis_main.o drivers/video/sis/sis_main.c
>drivers/video/sis/sis_main.c:49:25: video/fbcon.h: No such file or
>directory
>drivers/video/sis/sis_main.c:50:30: video/fbcon-cfb8.h: No such file or
>directory
>drivers/video/sis/sis_main.c:51:31: video/fbcon-cfb16.h: No such file or
>directory
>drivers/video/sis/sis_main.c:52:31: video/fbcon-cfb24.h: No such file or
>directory
>drivers/video/sis/sis_main.c:53:31: video/fbcon-cfb32.h: No such file or
>directory
>In file included from drivers/video/sis/sis_main.c:57:
>drivers/video/sis/sis_main.h:251: warning: excess elements in array
>initializer
>drivers/video/sis/sis_main.h:251: warning: (near initialization for
>`default_var.reserved')
>drivers/video/sis/sis_main.h:281: redeclaration of `enum _VGA_ENGINE'
>drivers/video/sis/sis_main.h:282: conflicting types for `UNKNOWN_VGA'
>include/linux/sisfb.h:47: previous declaration of `UNKNOWN_VGA'
>drivers/video/sis/sis_main.h:283: conflicting types for `SIS_300_VGA'
>include/linux/sisfb.h:48: previous declaration of `SIS_300_VGA'
>drivers/video/sis/sis_main.h:284: conflicting types for `SIS_315_VGA'
>include/linux/sisfb.h:49: previous declaration of `SIS_315_VGA'
>drivers/video/sis/sis_main.c: In function `sis_get_glyph':
>drivers/video/sis/sis_main.c:250: `fb_display' undeclared (first use in
>this function)
>drivers/video/sis/sis_main.c:250: (Each undeclared identifier is
>reported only once
>drivers/video/sis/sis_main.c:250: for each function it appears in.)
>drivers/video/sis/sis_main.c:259: warning: implicit declaration of
>function `fontheight'
>drivers/video/sis/sis_main.c:260: warning: implicit declaration of
>function `fontwidth'
>drivers/video/sis/sis_main.c:263: dereferencing pointer to incomplete
>type
>drivers/video/sis/sis_main.c:265: dereferencing pointer to incomplete
>type
>drivers/video/sis/sis_main.c:267: dereferencing pointer to incomplete
>type
>drivers/video/sis/sis_main.c: In function `sisfb_set_disp':
>drivers/video/sis/sis_main.c:657: `fb_display' undeclared (first use in
>this function)
>drivers/video/sis/sis_main.c:666: dereferencing pointer to incomplete
>type
>drivers/video/sis/sis_main.c:667: dereferencing pointer to incomplete
>type
>drivers/video/sis/sis_main.c:668: dereferencing pointer to incomplete
>type
>drivers/video/sis/sis_main.c:669: dereferencing pointer to incomplete
>type
>drivers/video/sis/sis_main.c:670: dereferencing pointer to incomplete
>type
>drivers/video/sis/sis_main.c:671: dereferencing pointer to incomplete
>type
>drivers/video/sis/sis_main.c:672: dereferencing pointer to incomplete
>type
>drivers/video/sis/sis_main.c:673: dereferencing pointer to incomplete
>type
>drivers/video/sis/sis_main.c:674: dereferencing pointer to incomplete
>type
>drivers/video/sis/sis_main.c:675: dereferencing pointer to incomplete
>type
>drivers/video/sis/sis_main.c:677: warning: implicit declaration of
>function `save_flags'
>drivers/video/sis/sis_main.c:704: `fbcon_dummy' undeclared (first use in
>this function)
>drivers/video/sis/sis_main.c:707: dereferencing pointer to incomplete
>type
>drivers/video/sis/sis_main.c:707: dereferencing pointer to incomplete
>type
>drivers/video/sis/sis_main.c:707: dereferencing pointer to incomplete
>type
>drivers/video/sis/sis_main.c:708: dereferencing pointer to incomplete
>type
>drivers/video/sis/sis_main.c:709: warning: implicit declaration of
>function `restore_flags'
>drivers/video/sis/sis_main.c:711: dereferencing pointer to incomplete
>type
>drivers/video/sis/sis_main.c:711: `SCROLL_YREDRAW' undeclared (first use
>in this function)
>drivers/video/sis/sis_main.c:712: invalid use of undefined type `struct
>display_switch'
>drivers/video/sis/sis_main.c:712: `fbcon_redraw_bmove' undeclared (first
>use in this function)
>drivers/video/sis/sis_main.c: In function `sisfb_do_install_cmap':
>drivers/video/sis/sis_main.c:721: `fb_display' undeclared (first use in
>this function)
>drivers/video/sis/sis_main.c: In function `sisfb_get_fix':
>drivers/video/sis/sis_main.c:2313: structure has no member named
>`modename'
>drivers/video/sis/sis_main.c: In function `sisfb_get_var':
>drivers/video/sis/sis_main.c:2354: `fb_display' undeclared (first use in
>this function)
>drivers/video/sis/sis_main.c: In function `sisfb_set_var':
>drivers/video/sis/sis_main.c:2370: `fb_display' undeclared (first use in
>this function)
>drivers/video/sis/sis_main.c:2384: structure has no member named
>`changevar'
>drivers/video/sis/sis_main.c:2385: structure has no member named
>`changevar'
>drivers/video/sis/sis_main.c:2394: warning: implicit declaration of
>function `vc_resize_con'
>drivers/video/sis/sis_main.c: In function `sisfb_get_cmap':
>drivers/video/sis/sis_main.c:2407: warning: implicit declaration of
>function `fb_get_cmap'
>drivers/video/sis/sis_main.c:2408: `fb_display' undeclared (first use in
>this function)
>drivers/video/sis/sis_main.c: In function `sisfb_set_cmap':
>drivers/video/sis/sis_main.c:2421: `fb_display' undeclared (first use in
>this function)
>drivers/video/sis/sis_main.c: At top level:
>drivers/video/sis/sis_main.c:2563: unknown field `fb_get_fix' specified
>in initializer
>drivers/video/sis/sis_main.c:2563: warning: initialization from
>incompatible pointer type
>drivers/video/sis/sis_main.c:2564: unknown field `fb_get_var' specified
>in initializer
>drivers/video/sis/sis_main.c:2564: warning: initialization from
>incompatible pointer type
>drivers/video/sis/sis_main.c:2565: unknown field `fb_set_var' specified
>in initializer
>drivers/video/sis/sis_main.c:2565: warning: initialization from
>incompatible pointer type
>drivers/video/sis/sis_main.c:2566: unknown field `fb_get_cmap' specified
>in initializer
>drivers/video/sis/sis_main.c:2566: warning: initialization from
>incompatible pointer type
>drivers/video/sis/sis_main.c:2567: unknown field `fb_set_cmap' specified
>in initializer
>drivers/video/sis/sis_main.c:2567: warning: initialization from
>incompatible pointer type
>drivers/video/sis/sis_main.c:2570: warning: initialization from
>incompatible pointer type
>drivers/video/sis/sis_main.c:2572: warning: initialization from
>incompatible pointer type
>drivers/video/sis/sis_main.c: In function `sisfb_switch':
>drivers/video/sis/sis_main.c:2588: `fb_display' undeclared (first use in
>this function)
>drivers/video/sis/sis_main.c: In function `sisfb_setup':
>drivers/video/sis/sis_main.c:2650: structure has no member named
>`fontname'
>drivers/video/sis/sis_main.c:2664: structure has no member named
>`fontname'
>drivers/video/sis/sis_main.c: In function `sisfb_init':
>drivers/video/sis/sis_main.c:2742: structure has no member named
>`modename'
>drivers/video/sis/sis_main.c:2774: structure has no member named
>`modename'
>drivers/video/sis/sis_main.c:3346: structure has no member named
>`changevar'
>drivers/video/sis/sis_main.c:3357: structure has no member named `disp'
>drivers/video/sis/sis_main.c:3358: structure has no member named
>`switch_con'
>drivers/video/sis/sis_main.c:3359: structure has no member named
>`updatevar'
>drivers/video/sis/sis_main.c:3394: structure has no member named
>`modename'
>include/linux/pci.h: At top level:
>drivers/video/sis/sis_main.h:219: storage size of `disp' isn't known
>drivers/video/sis/sis_main.h:223: storage size of `sisfb_sw' isn't known
>drivers/video/sis/sis_main.h:267: warning: `fbcon_cmap' defined but not
>used
>drivers/video/sis/sis_main.h:275: warning: `currcon' defined but not
>used
>make[3]: *** [drivers/video/sis/sis_main.o] Error 1
>make[2]: *** [drivers/video/sis] Error 2
>make[1]: *** [drivers/video] Error 2
>make: *** [drivers] Error 2
>
>=================
>
>What is the status of SiS fb support in 2.5?  Where can I find patches?
>
>Thanks in advance!
>
>Sampson Fung
>A New Comer to Kernel Testing.
>
>
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>
>
>  
>


