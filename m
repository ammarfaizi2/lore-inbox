Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261861AbVCUU1U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261861AbVCUU1U (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Mar 2005 15:27:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261860AbVCUU0x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Mar 2005 15:26:53 -0500
Received: from amsfep18-int.chello.nl ([213.46.243.13]:794 "EHLO
	amsfep18-int.chello.nl") by vger.kernel.org with ESMTP
	id S261861AbVCUUZ6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Mar 2005 15:25:58 -0500
Date: Mon, 21 Mar 2005 21:25:50 +0100
Message-Id: <200503212025.j2LKPoaM011317@anakin.of.borg>
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 543] Zorro: replace printk() with pr_info() in drivers/zorro/zorro.c
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Zorro: This fixes the only printk() in drivers/zorro that has no KERN_*
constant.

Signed-off-by: James Nelson <james4765@gmail.com>
Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>

--- linux-2.6.12-rc1/drivers/zorro/zorro.c	2005-01-20 16:33:13.246088014 -0500
+++ linux-m68k-2.6.12-rc1/drivers/zorro/zorro.c	2005-01-20 20:11:38.268850722 -0500
@@ -134,7 +134,7 @@
     if (!MACH_IS_AMIGA || !AMIGAHW_PRESENT(ZORRO))
 	return 0;
 
-    printk("Zorro: Probing AutoConfig expansion devices: %d device%s\n",
+    pr_info("Zorro: Probing AutoConfig expansion devices: %d device%s\n",
 	   zorro_num_autocon, zorro_num_autocon == 1 ? "" : "s");
 
     /* Initialize the Zorro bus */

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
