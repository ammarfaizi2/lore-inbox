Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264918AbUAAUui (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jan 2004 15:50:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264916AbUAAUtZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jan 2004 15:49:25 -0500
Received: from amsfep15-int.chello.nl ([213.46.243.28]:853 "EHLO
	amsfep15-int.chello.nl") by vger.kernel.org with ESMTP
	id S264918AbUAAUDf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jan 2004 15:03:35 -0500
Date: Thu, 1 Jan 2004 21:03:33 +0100
Message-Id: <200401012003.i01K3XsP031914@callisto.of.borg>
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 380] M68k has no VGA/MDA
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

M68k has no VGA or MDA consoles

--- linux-2.6.0/drivers/video/console/Kconfig	2003-09-28 09:36:22.000000000 +0200
+++ linux-m68k-2.6.0/drivers/video/console/Kconfig	2003-11-18 11:54:40.000000000 +0100
@@ -6,7 +6,7 @@
 
 config VGA_CONSOLE
 	bool "VGA text console" if EMBEDDED || !X86
-	depends on !ARCH_ACORN && !ARCH_EBSA110 && !4xx && !8xx && !SPARC32 && !SPARC64
+	depends on !ARCH_ACORN && !ARCH_EBSA110 && !4xx && !8xx && !SPARC32 && !SPARC64 && !M68K
 	default y
 	help
 	  Saying Y here will allow you to use Linux in text mode through a
@@ -43,6 +43,7 @@
 	  about the Video mode selection support. If unsure, say N.
 
 config MDA_CONSOLE
+	depends on !M68K
 	tristate "MDA text console (dual-headed) (EXPERIMENTAL)"
 	---help---
 	  Say Y here if you have an old MDA or monochrome Hercules graphics

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
