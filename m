Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261375AbSKIRH2>; Sat, 9 Nov 2002 12:07:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261433AbSKIRH2>; Sat, 9 Nov 2002 12:07:28 -0500
Received: from stb-mail-01.adept.za.net ([196.44.32.35]:38366 "EHLO
	stb-mail.adept.za.net") by vger.kernel.org with ESMTP
	id <S261375AbSKIRH0>; Sat, 9 Nov 2002 12:07:26 -0500
Date: Sat, 9 Nov 2002 19:04:05 +0200
From: Neilen Marais <brick@adept.co.za>
To: linux-kernel@vger.kernel.org
Subject: aty128fb.c does not compile in linux 2.5.46
Message-ID: <20021109190405.A17671@brickbox.egghead>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
Content-Transfer-Encoding: 7BIT
X-Mailer: Balsa 1.2.4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

I don't know if its currently considered important, but just for the 
record.
Please CC any replies to me, since I am not subscribed to the list.

I'm running an AMD Duron/Via kt133, with Debian testing.  Nothing 
unusual that
I am aware of.  If I choose to use the ATI Rage128 framebuffer console, 
I get
the following compile error:

gcc -Wp,-MD,drivers/video/.aty128fb.o.d -D__KERNEL__ -Iinclude -Wall 
-Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer 
-fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 
-march=i686 -malign-functions=4 -Iarch/i386/mach-generic
-nostdinc -iwithprefix include    -DKBUILD_BASENAME=aty128fb   -c -o 
drivers/video/aty128fb.o drivers/video/aty128fb.c
drivers/video/aty128fb.c:419: unknown field `fb_get_fix' specified in 
initializer
drivers/video/aty128fb.c:419: warning: initialization from incompatible 
pointer type
drivers/video/aty128fb.c:420: unknown field `fb_get_var' specified in 
initializer
drivers/video/aty128fb.c:420: warning: initialization from incompatible 
pointer type
drivers/video/aty128fb.c: In function `aty128fb_set_var':
drivers/video/aty128fb.c:1379: structure has no member named `visual'
drivers/video/aty128fb.c:1380: structure has no member named `type'
drivers/video/aty128fb.c:1381: structure has no member named `type_aux'
drivers/video/aty128fb.c:1382: structure has no member named `ypanstep'
drivers/video/aty128fb.c:1383: structure has no member named `ywrapstep'
drivers/video/aty128fb.c:1384: structure has no member named 
`line_length'
make[2]: *** [drivers/video/aty128fb.o] Error 1
make[1]: *** [drivers/video] Error 2
make: *** [drivers] Error 2

Cheers
Neilen
