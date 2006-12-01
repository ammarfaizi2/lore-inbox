Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1758957AbWLAOL1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758957AbWLAOL1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Dec 2006 09:11:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758954AbWLAOL0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Dec 2006 09:11:26 -0500
Received: from xdsl-664.zgora.dialog.net.pl ([81.168.226.152]:44818 "EHLO
	tuxland.pl") by vger.kernel.org with ESMTP id S1758520AbWLAOLZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Dec 2006 09:11:25 -0500
From: Mariusz Kozlowski <m.kozlowski@tuxland.pl>
To: Willy Tarreau <wtarreau@hera.kernel.org>
Subject: [2.4 PATCH] arm: dma-arc add missing parenthesis
Date: Fri, 1 Dec 2006 15:10:57 +0100
User-Agent: KMail/1.9.5
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200612011510.58990.m.kozlowski@tuxland.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

	This patch adds missing parenthesis in arc_floppy_data_enable_dma() code.

Signed-off-by: Mariusz Kozlowski <m.kozlowski@tuxland.pl>

 arch/arm/kernel/dma-arc.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff -upr linux-2.4.34-pre6-a/arch/arm/kernel/dma-arc.c linux-2.4.34-pre6-b/arch/arm/kernel/dma-arc.c
--- linux-2.4.34-pre6-a/arch/arm/kernel/dma-arc.c	2003-08-25 13:44:39.000000000 +0200
+++ linux-2.4.34-pre6-b/arch/arm/kernel/dma-arc.c	2006-12-01 12:31:39.000000000 +0100
@@ -55,7 +55,7 @@ static void arc_floppy_data_enable_dma(d
 		memcpy ((void *)0x1c, (void *)&fdc1772_dma_write,
 			&fdc1772_dma_write_end - &fdc1772_dma_write);
 		fdc1772_setupdma(dma->buf.length, dma->buf.address); /* Sets data pointer up */
-		enable_fiq(FIQ_FLOPPYDATA;
+		enable_fiq(FIQ_FLOPPYDATA);
 
 		local_irq_restore(flags);
 	    }

-- 
Regards,

	Mariusz Kozlowski
