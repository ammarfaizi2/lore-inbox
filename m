Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266905AbUIXDSw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266905AbUIXDSw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Sep 2004 23:18:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266864AbUIWUf0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Sep 2004 16:35:26 -0400
Received: from baikonur.stro.at ([213.239.196.228]:37818 "EHLO
	baikonur.stro.at") by vger.kernel.org with ESMTP id S266905AbUIWU2g
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Sep 2004 16:28:36 -0400
Subject: [patch 4/4]  fix-typo-arm-dma arch/arm26/machine/dma.c
To: akpm@digeo.com
Cc: linux-kernel@vger.kernel.org, janitor@sternwelten.at, domen@coderock.org
From: janitor@sternwelten.at
Date: Thu, 23 Sep 2004 22:28:34 +0200
Message-ID: <E1CAaCg-0000fr-Hy@sputnik>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



untested, but it seems to be a clear typo:
s/loacl_save_flags_cli()/local_save_flags_cli()/
caught by Domen Puncer <domen@coderock.org>

Signed-off-by: Maximilian Attems <janitor@sternwelten.at>

---

 linux-2.6.9-rc2-bk7-max/arch/arm26/machine/dma.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

diff -puN arch/arm26/machine/dma.c~fix-typo-arm-dma arch/arm26/machine/dma.c
--- linux-2.6.9-rc2-bk7/arch/arm26/machine/dma.c~fix-typo-arm-dma	2004-09-21 20:51:50.000000000 +0200
+++ linux-2.6.9-rc2-bk7-max/arch/arm26/machine/dma.c	2004-09-21 20:51:50.000000000 +0200
@@ -47,7 +47,7 @@ static void arc_floppy_data_enable_dma(d
 			&fdc1772_dma_read_end - &fdc1772_dma_read);
 		fdc1772_setupdma(dma->buf.length, dma->buf.__address); /* Sets data pointer up */
 		enable_fiq(FIQ_FLOPPYDATA);
-		loacl_irq_restore(flags);
+		local_irq_restore(flags);
 	   }
 	   break;
 
_
