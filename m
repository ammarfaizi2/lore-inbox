Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265889AbUFTRf5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265889AbUFTRf5 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Jun 2004 13:35:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263851AbUFTRcu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Jun 2004 13:32:50 -0400
Received: from nl-ams-slo-l4-01-pip-3.chellonetwork.com.243.46.213.in-addr.arpa ([213.46.243.17]:2065 "EHLO amsfep12-int.chello.nl")
	by vger.kernel.org with ESMTP id S265889AbUFTR1D (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Jun 2004 13:27:03 -0400
Date: Sun, 20 Jun 2004 19:27:04 +0200
Message-Id: <200406201727.i5KHR4Pe001554@anakin.of.borg>
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 457] Mac IOP
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mac IOP: Fix copy-and-paste bug (found by OPERA, reported by Zhenmin Li,
confirmed by Brad Boyer)

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>

--- linux-2.6.7/arch/m68k/mac/iop.c	2004-05-24 11:13:22.000000000 +0200
+++ linux-m68k-2.6.7/arch/m68k/mac/iop.c	2004-05-26 14:49:09.000000000 +0200
@@ -261,7 +261,7 @@ void __init iop_preinit(void)
 		} else {
 			iop_base[IOP_NUM_ISM] = (struct mac_iop *) ISM_IOP_BASE_QUADRA;
 		}
-		iop_base[IOP_NUM_SCC]->status_ctrl = 0;
+		iop_base[IOP_NUM_ISM]->status_ctrl = 0;
 		iop_ism_present = 1;
 	} else {
 		iop_base[IOP_NUM_ISM] = NULL;

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
