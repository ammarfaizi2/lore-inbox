Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932176AbWEPRnl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932176AbWEPRnl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 May 2006 13:43:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932225AbWEPRnl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 May 2006 13:43:41 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:64775 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932176AbWEPRnk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 May 2006 13:43:40 -0400
Date: Tue, 16 May 2006 19:43:39 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: alex@shark-linux.de, rmk@arm.linux.org.uk, linux-kernel@vger.kernel.org
Subject: [2.6 patch] arch/arm/kernel/dma-isa.c: named initializers
Message-ID: <20060516174339.GB10077@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch converts struct dma_resources to named initializers.

Besides fixing a compile error in -mm, it didn't sound like a bad idea.

Signed-off-by: Adrian Bunk <bunk@stusta.de>
Acked-by: Alexander Schulz <alex@shark-linux.de>

---

This patch was already sent on:
- 1 May 2006

--- linux-2.6.17-rc2-mm1-shark/arch/arm/kernel/dma-isa.c.old	2006-04-27 22:44:38.000000000 +0200
+++ linux-2.6.17-rc2-mm1-shark/arch/arm/kernel/dma-isa.c	2006-04-27 22:44:23.000000000 +0200
@@ -143,12 +143,23 @@
 	.residue	= isa_get_dma_residue,
 };
 
-static struct resource dma_resources[] = {
-	{ "dma1",		0x0000, 0x000f },
-	{ "dma low page", 	0x0080, 0x008f },
-	{ "dma2",		0x00c0, 0x00df },
-	{ "dma high page",	0x0480, 0x048f }
-};
+static struct resource dma_resources[] = { {
+	.name	= "dma1",
+	.start	= 0x0000,
+	.end	= 0x000f
+}, {
+	.name	= "dma low page",
+	.start	= 0x0080,
+	.end 	= 0x008f
+}, {
+	.name	= "dma2",
+	.start	= 0x00c0,
+	.end	= 0x00df
+}, {
+	.name	= "dma high page",
+	.start	= 0x0480,
+	.end	= 0x048f
+} };
 
 void __init isa_init_dma(dma_t *dma)
 {

