Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280897AbRKCArP>; Fri, 2 Nov 2001 19:47:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280898AbRKCArF>; Fri, 2 Nov 2001 19:47:05 -0500
Received: from deviant.impure.org.uk ([195.82.120.238]:3768 "EHLO
	deviant.impure.org.uk") by vger.kernel.org with ESMTP
	id <S280897AbRKCAqs>; Fri, 2 Nov 2001 19:46:48 -0500
Date: Sat, 3 Nov 2001 00:47:00 +0000 (GMT)
From: Dave Jones <davej@suse.de>
X-X-Sender: <davej@noodles.codemonkey.org.uk>
To: Linus Torvalds <torvalds@transmeta.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] Use OOSTORE.
Message-ID: <Pine.LNX.4.33.0111030044070.25694-100000@noodles.codemonkey.org.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Linus,
 Now that the OOSTORE bits are merged into your tree, it makes
sense to use them, the patch below changes the build options
for Winchips.

regards,

Dave.

diff -urN --exclude-from=/home/davej/.exclude linux-2.4.14-pre6/arch/i386/config.in linux-2.4.13-ac6/arch/i386/config.in
--- linux-2.4.14-pre6/arch/i386/config.in	Sun Oct 21 03:17:19 2001
+++ linux-2.4.13-ac6/arch/i386/config.in	Sat Nov  3 00:24:55 2001
@@ -135,18 +144,21 @@
    define_int  CONFIG_X86_L1_CACHE_SHIFT 5
    define_bool CONFIG_X86_ALIGNMENT_16 y
    define_bool CONFIG_X86_USE_PPRO_CHECKSUM y
+   define_bool CONFIG_X86_OOSTORE y
 fi
 if [ "$CONFIG_MWINCHIP2" = "y" ]; then
    define_int  CONFIG_X86_L1_CACHE_SHIFT 5
    define_bool CONFIG_X86_ALIGNMENT_16 y
    define_bool CONFIG_X86_TSC y
    define_bool CONFIG_X86_USE_PPRO_CHECKSUM y
+   define_bool CONFIG_X86_OOSTORE y
 fi
 if [ "$CONFIG_MWINCHIP3D" = "y" ]; then
    define_int  CONFIG_X86_L1_CACHE_SHIFT 5
    define_bool CONFIG_X86_ALIGNMENT_16 y
    define_bool CONFIG_X86_TSC y
    define_bool CONFIG_X86_USE_PPRO_CHECKSUM y
+   define_bool CONFIG_X86_OOSTORE y
 fi
 tristate 'Toshiba Laptop support' CONFIG_TOSHIBA


-- 
| Dave Jones.                    http://www.codemonkey.org.uk
| SuSE Labs .

