Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261189AbUBTMt2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Feb 2004 07:49:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261185AbUBTMrl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Feb 2004 07:47:41 -0500
Received: from amsfep12-int.chello.nl ([213.46.243.18]:42779 "EHLO
	amsfep12-int.chello.nl") by vger.kernel.org with ESMTP
	id S261184AbUBTMqy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Feb 2004 07:46:54 -0500
Date: Fri, 20 Feb 2004 13:46:40 +0100
Message-Id: <200402201246.i1KCkerW004205@callisto.of.borg>
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 396] Atari name clashes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Atari Falcon: Prepend falcon_ to some Atari Falcon definitions to solve name
clashes in some drivers

--- linux-2.6.3/arch/m68k/atari/config.c	2003-05-27 19:02:32.000000000 +0200
+++ linux-m68k-2.6.3/arch/m68k/atari/config.c	2004-01-10 18:22:50.000000000 +0100
@@ -344,7 +344,7 @@
 	ATARIHW_SET(PCM_8BIT);
         printk( "PCM " );
     }
-    if (!MACH_IS_HADES && hwreg_present( &codec.unused5 )) {
+    if (!MACH_IS_HADES && hwreg_present( &falcon_codec.unused5 )) {
 	ATARIHW_SET(CODEC);
         printk( "CODEC " );
     }
--- linux-2.6.3/include/asm-m68k/atarihw.h	2002-07-25 12:54:07.000000000 +0200
+++ linux-m68k-2.6.3/include/asm-m68k/atarihw.h	2004-01-10 18:18:17.000000000 +0100
@@ -376,7 +376,7 @@
   u_char external_frequency_divider;
   u_char internal_frequency_divider;
 };
-#define matrix (*(volatile struct MATRIX *)MATRIX_BASE)
+#define falcon_matrix (*(volatile struct MATRIX *)MATRIX_BASE)
 
 #define CODEC_BASE (0xffff8936)
 struct CODEC
@@ -405,7 +405,7 @@
   u_char unused6;
   u_char gpio_data;
 };
-#define codec (*(volatile struct CODEC *)CODEC_BASE)
+#define falcon_codec (*(volatile struct CODEC *)CODEC_BASE)
 
 /*
 ** Falcon Blitter

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
