Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1759226AbWK3Jce@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759226AbWK3Jce (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Nov 2006 04:32:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759228AbWK3Jce
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Nov 2006 04:32:34 -0500
Received: from xdsl-664.zgora.dialog.net.pl ([81.168.226.152]:270 "EHLO
	tuxland.pl") by vger.kernel.org with ESMTP id S1759226AbWK3Jcd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Nov 2006 04:32:33 -0500
From: Mariusz Kozlowski <m.kozlowski@tuxland.pl>
To: davem@davemloft.net
Subject: [PATCH] sparc64: dma remove extra brackets
Date: Thu, 30 Nov 2006 10:32:03 +0100
User-Agent: KMail/1.9.5
Cc: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611301032.03913.m.kozlowski@tuxland.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

	This patch removes some extra brackets to fix these macros.

Signed-off-by: Mariusz Kozlowski <m.kozlowski@tuxland.pl>

 include/asm-sparc64/dma.h |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- linux-2.6.19-rc6-mm2-a/include/asm-sparc64/dma.h	2006-11-16 05:03:40.000000000 +0100
+++ linux-2.6.19-rc6-mm2-b/include/asm-sparc64/dma.h	2006-11-30 01:03:23.000000000 +0100
@@ -152,9 +152,9 @@ extern void dvma_init(struct sbus_bus *)
 #define DMA_MAXEND(addr) (0x01000000UL-(((unsigned long)(addr))&0x00ffffffUL))
 
 /* Yes, I hack a lot of elisp in my spare time... */
-#define DMA_ERROR_P(regs)  (((sbus_readl((regs) + DMA_CSR) & DMA_HNDL_ERROR))
-#define DMA_IRQ_P(regs)    (((sbus_readl((regs) + DMA_CSR)) & (DMA_HNDL_INTR | DMA_HNDL_ERROR)))
-#define DMA_WRITE_P(regs)  (((sbus_readl((regs) + DMA_CSR) & DMA_ST_WRITE))
+#define DMA_ERROR_P(regs)  ((sbus_readl((regs) + DMA_CSR) & DMA_HNDL_ERROR))
+#define DMA_IRQ_P(regs)    ((sbus_readl((regs) + DMA_CSR)) & (DMA_HNDL_INTR | DMA_HNDL_ERROR))
+#define DMA_WRITE_P(regs)  ((sbus_readl((regs) + DMA_CSR) & DMA_ST_WRITE))
 #define DMA_OFF(__regs)		\
 do {	u32 tmp = sbus_readl((__regs) + DMA_CSR); \
 	tmp &= ~DMA_ENABLE; \


-- 
Regards,

	Mariusz Kozlowski
