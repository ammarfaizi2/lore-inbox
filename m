Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261590AbSKCDwS>; Sat, 2 Nov 2002 22:52:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261593AbSKCDwR>; Sat, 2 Nov 2002 22:52:17 -0500
Received: from nessie.weebeastie.net ([61.8.7.205]:42625 "EHLO
	theirongiant.weebeastie.net") by vger.kernel.org with ESMTP
	id <S261590AbSKCDwP>; Sat, 2 Nov 2002 22:52:15 -0500
Date: Sun, 3 Nov 2002 14:58:31 +1100
From: CaT <cat@zip.com.au>
To: linux-kernel@vger.kernel.org
Subject: 2.5.45 / fb vga16fb build error
Message-ID: <20021103035831.GW619@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Organisation: Furball Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

gcc -Wp,-MD,drivers/video/.vga16fb.o.d -D__KERNEL__ -Iinclude -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=i686 -Iarch/i386/mach-generic -nostdinc -iwithprefix include -DKBUILD_BASENAME=vga16fb -c -o drivers/video/vga16fb.o drivers/video/vga16fb.c
drivers/video/vga16fb.c: In function `vga16fb_set_disp':
drivers/video/vga16fb.c:177: structure has no member named `visual'
drivers/video/vga16fb.c:178: structure has no member named `type'
drivers/video/vga16fb.c:179: structure has no member named `type_aux'
drivers/video/vga16fb.c:180: structure has no member named `ypanstep'
drivers/video/vga16fb.c:181: structure has no member named `ywrapstep'
drivers/video/vga16fb.c:182: structure has no member named `line_length'
drivers/video/vga16fb.c: In function `vga_vesa_blank':
drivers/video/vga16fb.c:664: warning: implicit declaration of function `cli'
drivers/video/vga16fb.c:671: warning: implicit declaration of function `sti'
drivers/video/vga16fb.c: At top level:
drivers/video/vga16fb.c:814: unknown field `fb_get_fix' specified in initializer
drivers/video/vga16fb.c:814: warning: initialization from incompatible pointer type
drivers/video/vga16fb.c:815: unknown field `fb_get_var' specified in initializer
drivers/video/vga16fb.c:815: warning: initialization from incompatible pointer type
make[2]: *** [drivers/video/vga16fb.o] Error 1
make[1]: *** [drivers/video] Error 2
make: *** [drivers] Error 2

FB .config section:

#
# Frame-buffer support
# 
CONFIG_FB=y
CONFIG_DUMMY_CONSOLE=y
# CONFIG_FB_CLGEN is not set
# CONFIG_FB_PM2 is not set
# CONFIG_FB_CYBER2000 is not set
# CONFIG_FB_ATY is not set
CONFIG_FB_VGA16=y
CONFIG_FB_VESA=y
# CONFIG_FB_HGA is not set
# CONFIG_FB_RIVA is not set
# CONFIG_FB_MATROX is not set
# CONFIG_FB_RADEON is not set
# CONFIG_FB_ATY128 is not set
# CONFIG_FB_SIS is not set
# CONFIG_FB_NEOMAGIC is not set
# CONFIG_FB_3DFX is not set
# CONFIG_FB_VOODOO1 is not set
# CONFIG_FB_TRIDENT is not set
# CONFIG_FB_PM3 is not set
# CONFIG_FB_VIRTUAL is not set
# CONFIG_FBCON_ADVANCED is not set
CONFIG_FBCON_CFB24=y
CONFIG_FBCON_ACCEL=y
CONFIG_FBCON_VGA_PLANES=y
# CONFIG_FBCON_FONTWIDTH8_ONLY is not set
# CONFIG_FBCON_FONTS is not set
CONFIG_FONT_8x8=y
CONFIG_FONT_8x16=y

Only mod to the source was a patch to let me use menuconfig without
having the qt devel setup.

-- 
        All people are equal,
        But some are more equal then others.
            - George W. Bush Jr, President of the United States
              September 21, 2002 (Abridged version of security speech)
