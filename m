Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261570AbUJaKkW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261570AbUJaKkW (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Oct 2004 05:40:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261540AbUJaKjg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Oct 2004 05:39:36 -0500
Received: from nl-ams-slo-l4-01-pip-7.chellonetwork.com ([213.46.243.25]:24592
	"EHLO amsfep16-int.chello.nl") by vger.kernel.org with ESMTP
	id S261542AbUJaKDr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Oct 2004 05:03:47 -0500
Date: Sun, 31 Oct 2004 11:03:46 +0100
Message-Id: <200410311003.i9VA3kVi009718@anakin.of.borg>
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 519] Sun 3: Fix modular XFS by exporting vmalloc_end
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sun 3: Fix modular XFS by exporting vmalloc_end

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>

--- linux-2.6.10-rc1/arch/m68k/sun3/mmu_emu.c	2004-05-24 11:13:22.000000000 +0200
+++ linux-m68k-2.6.10-rc1/arch/m68k/sun3/mmu_emu.c	2004-10-28 21:18:57.000000000 +0200
@@ -13,6 +13,7 @@
 #include <linux/delay.h>
 #include <linux/bootmem.h>
 #include <linux/bitops.h>
+#include <linux/module.h>
 
 #include <asm/setup.h>
 #include <asm/traps.h>
@@ -46,6 +47,8 @@ extern void prom_reboot (char *) __attri
 */
 
 unsigned long vmalloc_end;
+EXPORT_SYMBOL(vmalloc_end);
+
 unsigned long pmeg_vaddr[PMEGS_NUM];
 unsigned char pmeg_alloc[PMEGS_NUM];
 unsigned char pmeg_ctx[PMEGS_NUM];

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
