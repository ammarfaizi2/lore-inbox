Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278810AbRKSNsq>; Mon, 19 Nov 2001 08:48:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278911AbRKSNsg>; Mon, 19 Nov 2001 08:48:36 -0500
Received: from ns.suse.de ([213.95.15.193]:33555 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S278810AbRKSNsZ>;
	Mon, 19 Nov 2001 08:48:25 -0500
Date: Mon, 19 Nov 2001 14:48:24 +0100 (CET)
From: Dave Jones <davej@suse.de>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] Use OOSTORE for Winchips.
Message-ID: <Pine.LNX.4.30.0111191444520.22614-100000@Appserv.suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Linus,
 Patch below adds necessary bits to Winchip configuration
to make them use the out-of-order stores.

Hand-editted diff, still applies to pre6

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
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs

