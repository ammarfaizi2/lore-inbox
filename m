Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293680AbSHOHBN>; Thu, 15 Aug 2002 03:01:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311885AbSHOHBN>; Thu, 15 Aug 2002 03:01:13 -0400
Received: from spheno.jokeslayer.com ([66.28.117.177]:51101 "HELO
	spheno.jokeslayer.com") by vger.kernel.org with SMTP
	id <S293680AbSHOHBM>; Thu, 15 Aug 2002 03:01:12 -0400
Date: Thu, 15 Aug 2002 00:05:01 -0700
From: Billy Tiemann <maxinux@bigfoot.com.com>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.5.0/2.5.31 wont compile if you enable frame buffer for voodoo3 cards
Message-ID: <20020815070501.GA16436@spheno.jokeslayer.com>
Mail-Followup-To: Billy Tiemann <maxinux@bigfoot.com.com>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.24i
X-My-PGP-Fingerprint: D256 84C7 2BCF 86DB CA99 C975 F1B1 538A 1DB1 123C
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here are the exact errors as promised:

make[1]: Entering directory `/usr/src/linux-2.5.30/init'
Generating /usr/src/linux-2.5.30/include/linux/compile.h (updated)
gcc -Wp,-MD,./.version.o.d -D__KERNEL__
-I/usr/src/linux-2.5.30/include -Wall
-Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer
-fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2
-march=i686 -nostdinc -iwithprefix include
-DKBUILD_BASENAME=version   -c -o version.o version.c
ld -m elf_i386  -r -o init.o main.o version.o do_mounts.o
make[1]: Leaving directory `/usr/src/linux-2.5.30/init'
ld -m elf_i386 -T arch/i386/vmlinux.lds -e stext
arch/i386/kernel/head.o arch/i386/kernel/init_task.o
init/init.o --start-group arch/i386/kernel/kernel.o
arch/i386/mm/mm.o kernel/kernel.o mm/mm.o fs/fs.o ipc/ipc.o
security/built-in.o /usr/src/linux-2.5.30/arch/i386/lib/lib.a
lib/lib.a /usr/src/linux-2.5.30/arch/i386/lib/lib.a
drivers/built-in.o sound/sound.o arch/i386/pci/pci.o
net/network.o --end-group -o vmlinux
drivers/built-in.o(.data+0x94f4): undefined reference to `local
symbols in discarded section .text.exit'
make: *** [vmlinux] Error 1

The only things changed (litterally) is that I did not enable CONFIG_FB

--- .config     Wed Aug 14 23:41:31 2002
+++ .config.old Wed Aug 14 23:17:29 2002
@@ -721,33 +721,7 @@
#
# Frame-buffer support
#
-CONFIG_FB=y
-CONFIG_DUMMY_CONSOLE=y
-# CONFIG_FB_CLGEN is not set
-# CONFIG_FB_PM2 is not set
-# CONFIG_FB_CYBER2000 is not set
-# CONFIG_FB_VESA is not set
-# CONFIG_FB_VGA16 is not set
-# CONFIG_VIDEO_SELECT=y
-# CONFIG_FB_RIVA is not set
-# CONFIG_FB_MATROX is not set
-# CONFIG_FB_ATY is not set
-# CONFIG_FB_RADEON is not set
-# CONFIG_FB_ATY128 is not set
-# CONFIG_FB_SIS is not set
-# CONFIG_FB_NEOMAGIC is not set
-CONFIG_FB_3DFX=y
-# CONFIG_FB_VOODOO1 is not set
-# CONFIG_FB_TRIDENT is not set
-# CONFIG_FB_PM3 is not set
-# CONFIG_FB_VIRTUAL is not set
-# CONFIG_FBCON_ADVANCED is not set
-CONFIG_FBCON_ACCEL=y
-# CONFIG_FBCON_FONTWIDTH8_ONLY is not set
-# CONFIG_FBCON_FONTS is not set
-CONFIG_FONT_8x8=y
-CONFIG_FONT_8x16=y
+# CONFIG_FB is not set

Help me get the 800x600 console we all strive for =)
Billy Tiemann

-- 
Imperious, choleric, irascible, extreme in everything, with a dissolute imagination the like of which has never been seen, atheistic to the point of fanaticism, there you have me in a nutshell.... Kill me again or take me as I am, for I shall not change." 
