Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261216AbUBTNQL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Feb 2004 08:16:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261226AbUBTNNK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Feb 2004 08:13:10 -0500
Received: from amsfep14-int.chello.nl ([213.46.243.22]:46631 "EHLO
	amsfep14-int.chello.nl") by vger.kernel.org with ESMTP
	id S261216AbUBTMwt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Feb 2004 07:52:49 -0500
Date: Fri, 20 Feb 2004 13:46:44 +0100
Message-Id: <200402201246.i1KCkiAN004241@callisto.of.borg>
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 402] arch/m68k/mm/Makefile cleanup
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Clean up arch/m68k/mm/Makefile logic

--- linux-2.6.3/arch/m68k/mm/Makefile	2004-01-25 16:59:57.000000000 +0100
+++ linux-m68k-2.6.3/arch/m68k/mm/Makefile	2004-01-25 17:20:45.000000000 +0100
@@ -4,8 +4,5 @@
 
 obj-y		:= cache.o init.o fault.o hwtest.o
 
-ifndef CONFIG_SUN3
-obj-y		+= kmap.o memory.o motorola.o
-else
-obj-y		+= sun3kmap.o sun3mmu.o
-endif
+obj-$(CONFIG_MMU_MOTOROLA)	+= kmap.o memory.o motorola.o
+obj-$(CONFIG_MMU_SUN3)		+= sun3kmap.o sun3mmu.o

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
