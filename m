Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265905AbUFTR1U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265905AbUFTR1U (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Jun 2004 13:27:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265802AbUFTRYK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Jun 2004 13:24:10 -0400
Received: from nl-ams-slo-l4-01-pip-5.chellonetwork.com ([213.46.243.21]:35400
	"EHLO amsfep14-int.chello.nl") by vger.kernel.org with ESMTP
	id S265801AbUFTRVC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Jun 2004 13:21:02 -0400
Date: Sun, 20 Jun 2004 19:20:56 +0200
Message-Id: <200406201720.i5KHKuYP001349@anakin.of.borg>
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 156] Mac IOP
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mac IOP: Fix copy-and-paste bug (found by OPERA, reported by Zhenmin Li,
confirmed by Brad Boyer)

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>

--- linux-2.4.27-rc1/arch/m68k/mac/iop.c	2004-05-24 11:13:22.000000000 +0200
+++ linux-m68k-2.4.27-rc1/arch/m68k/mac/iop.c	2004-05-26 14:49:09.000000000 +0200
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
