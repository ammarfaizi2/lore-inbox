Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318341AbSGYFyn>; Thu, 25 Jul 2002 01:54:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318342AbSGYFyn>; Thu, 25 Jul 2002 01:54:43 -0400
Received: from mortar.viawest.net ([216.87.64.7]:18113 "EHLO
	mortar.viawest.net") by vger.kernel.org with ESMTP
	id <S318341AbSGYFym>; Thu, 25 Jul 2002 01:54:42 -0400
Date: Wed, 24 Jul 2002 22:57:51 -0700
From: A Guy Called Tyketto <tyketto@wizard.com>
To: linux-kernel@vger.kernel.org
Subject: 2.5.28: aty128fb.c:1752: incompatible type
Message-ID: <20020725055751.GA5875@wizard.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-Operating-System: Linux/2.5.25 (i686)
X-uptime: 10:50pm  up 3 days,  5:46,  2 users,  load average: 1.57, 1.04, 0.53
X-RSA-KeyID: 0xE9DF4D85
X-DSA-KeyID: 0xE319F0BF
X-GPG-Keys: see http://www.wizard.com/~tyketto/pgp.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


        Roll of 2.5.28:

  gcc -Wp,-MD,./.aty128fb.o.d -D__KERNEL__ -I/usr/src/linux-2.5.25/include 
-Wall -Wstrict-prototypes -Wno-trigraphs -O2 -g -fomit-frame-pointer 
-fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 
-march=i686 -malign-functions=4  -nostdinc -iwithprefix include    
-DKBUILD_BASENAME=aty128fb   -c -o aty128fb.o aty128fb.c
aty128fb.c: In function `aty128fb_set_var':
aty128fb.c:1406: warning: implicit declaration of function `do_install_cmap'
aty128fb.c: In function `aty128_init':
aty128fb.c:1752: incompatible type for argument 1 of `fb_alloc_cmap'
make[2]: *** [aty128fb.o] Error 1
make[2]: Leaving directory `/usr/src/linux-2.5.25/drivers/video'
make[1]: *** [video] Error 2
make[1]: Leaving directory `/usr/src/linux-2.5.25/drivers'
make: *** [drivers] Error 2

        I can live with 1406. it'll get cleaned up towards code freeze time. 
1752 is:

fb_alloc_cmap(info->fb_info.cmap, size, 0);

        Commenting this out resolves the compilation issue, but I don't think 
is the right solution.

CONFIG_FB_ATY=y
CONFIG_FB_ATY_CT=y
CONFIG_FB_RADEON=y
CONFIG_FB_ATY128=y
CONFIG_FBCON_ADVANCED=y
CONFIG_FBCON_CFB8=y
CONFIG_FBCON_CFB16=y
CONFIG_FBCON_CFB24=y
CONFIG_FBCON_CFB32=y
CONFIG_FONT_8x8=y
CONFIG_FONT_8x16=y

                                                        BL.
-- 
Brad Littlejohn                         | Email:        tyketto@wizard.com
Unix Systems Administrator,             |           tyketto@ozemail.com.au
Web + NewsMaster, BOFH.. Smeghead! :)   |   http://www.wizard.com/~tyketto
  PGP: 1024D/E319F0BF 6980 AAD6 7329 E9E6 D569  F620 C819 199A E319 F0BF

