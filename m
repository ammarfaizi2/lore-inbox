Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266839AbUJFDxj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266839AbUJFDxj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Oct 2004 23:53:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266838AbUJFDxj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Oct 2004 23:53:39 -0400
Received: from mail.renesas.com ([202.234.163.13]:57545 "EHLO
	mail02.idc.renesas.com") by vger.kernel.org with ESMTP
	id S266839AbUJFDxb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Oct 2004 23:53:31 -0400
Date: Wed, 06 Oct 2004 12:53:20 +0900 (JST)
Message-Id: <20041006.125320.579639469.takata.hirokazu@renesas.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, takata@linux-m32r.org
Subject: [PATCH 2.6.9-rc3-mm2] [m32r] Update include/asm-m32r/m32102.h
From: Hirokazu Takata <takata@linux-m32r.org>
X-Mailer: Mew version 3.3 on XEmacs 21.4.15 (Security Through Obscurity)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here is a patch to update include/asm-m32r/m32102.h.
Please apply.

     * include/asm-m32r/m32102.h:
     - Add macro definitions for DMA controller.
     - Cosmetics; rearrange indentations.

Thanks.

Signed-off-by: Hirokazu Takata <takata@linux-m32r.org>
---

 include/asm-m32r/m32102.h |  112 ++++++++++++++++++++++++++++------------------
 1 files changed, 70 insertions(+), 42 deletions(-)


--- a/include/asm-m32r/m32102.h	2004-10-05 12:39:39.000000000 +0900
+++ b/include/asm-m32r/m32102.h	2004-10-06 12:49:03.000000000 +0900
@@ -23,6 +23,34 @@
 #define M32R_CPM_PLLCR_PORTL     (0x08+M32R_CPM_OFFSET)
 
 /*
+ * DMA Controller registers.
+ */
+#define M32R_DMA_OFFSET		(0x000F8000+M32R_SFR_OFFSET)
+
+#define M32R_DMAEN_PORTL	(0x000+M32R_DMA_OFFSET)
+#define M32R_DMAISTS_PORTL	(0x004+M32R_DMA_OFFSET)
+#define M32R_DMAEDET_PORTL	(0x008+M32R_DMA_OFFSET)
+#define M32R_DMAASTS_PORTL	(0x00c+M32R_DMA_OFFSET)
+
+#define M32R_DMA0CR0_PORTL	(0x100+M32R_DMA_OFFSET)
+#define M32R_DMA0CR1_PORTL	(0x104+M32R_DMA_OFFSET)
+#define M32R_DMA0CSA_PORTL	(0x108+M32R_DMA_OFFSET)
+#define M32R_DMA0RSA_PORTL	(0x10c+M32R_DMA_OFFSET)
+#define M32R_DMA0CDA_PORTL	(0x110+M32R_DMA_OFFSET)
+#define M32R_DMA0RDA_PORTL	(0x114+M32R_DMA_OFFSET)
+#define M32R_DMA0CBCUT_PORTL	(0x118+M32R_DMA_OFFSET)
+#define M32R_DMA0RBCUT_PORTL	(0x11c+M32R_DMA_OFFSET)
+
+#define M32R_DMA1CR0_PORTL	(0x200+M32R_DMA_OFFSET)
+#define M32R_DMA1CR1_PORTL	(0x204+M32R_DMA_OFFSET)
+#define M32R_DMA1CSA_PORTL	(0x208+M32R_DMA_OFFSET)
+#define M32R_DMA1RSA_PORTL	(0x20c+M32R_DMA_OFFSET)
+#define M32R_DMA1CDA_PORTL	(0x210+M32R_DMA_OFFSET)
+#define M32R_DMA1RDA_PORTL	(0x214+M32R_DMA_OFFSET)
+#define M32R_DMA1CBCUT_PORTL	(0x218+M32R_DMA_OFFSET)
+#define M32R_DMA1RBCUT_PORTL	(0x21c+M32R_DMA_OFFSET)
+
+/*
  * Multi Function Timer registers.
  */
 #define M32R_MFT_OFFSET        (0x000FC000+M32R_SFR_OFFSET)
@@ -121,15 +149,15 @@
  */
 #define M32R_SIO_OFFSET  (0x000FD000+M32R_SFR_OFFSET)
 
-#define M32R_SIO0_CR_PORTL     (0x000+M32R_SIO_OFFSET)
-#define M32R_SIO0_MOD0_PORTL   (0x004+M32R_SIO_OFFSET)
-#define M32R_SIO0_MOD1_PORTL   (0x008+M32R_SIO_OFFSET)
-#define M32R_SIO0_STS_PORTL    (0x00C+M32R_SIO_OFFSET)
-#define M32R_SIO0_TRCR_PORTL   (0x010+M32R_SIO_OFFSET)
-#define M32R_SIO0_BAUR_PORTL   (0x014+M32R_SIO_OFFSET)
-#define M32R_SIO0_RBAUR_PORTL  (0x018+M32R_SIO_OFFSET)
-#define M32R_SIO0_TXB_PORTL    (0x01C+M32R_SIO_OFFSET)
-#define M32R_SIO0_RXB_PORTL    (0x020+M32R_SIO_OFFSET)
+#define M32R_SIO0_CR_PORTL    (0x000+M32R_SIO_OFFSET)
+#define M32R_SIO0_MOD0_PORTL  (0x004+M32R_SIO_OFFSET)
+#define M32R_SIO0_MOD1_PORTL  (0x008+M32R_SIO_OFFSET)
+#define M32R_SIO0_STS_PORTL   (0x00C+M32R_SIO_OFFSET)
+#define M32R_SIO0_TRCR_PORTL  (0x010+M32R_SIO_OFFSET)
+#define M32R_SIO0_BAUR_PORTL  (0x014+M32R_SIO_OFFSET)
+#define M32R_SIO0_RBAUR_PORTL (0x018+M32R_SIO_OFFSET)
+#define M32R_SIO0_TXB_PORTL   (0x01C+M32R_SIO_OFFSET)
+#define M32R_SIO0_RXB_PORTL   (0x020+M32R_SIO_OFFSET)
 
 /*
  * Interrupt Control Unit registers.
@@ -201,41 +229,41 @@
 #define M32R_ICUCR_ILEVEL6  (6UL<<0)   /* b29-b31: Interrupt priority level 6 */
 #define M32R_ICUCR_ILEVEL7  (7UL<<0)   /* b29-b31: Disable interrupt */
 
-#define  M32R_IRQ_INT0    (1)   /* INT0 */
-#define  M32R_IRQ_INT1    (2)   /* INT1 */
-#define  M32R_IRQ_INT2    (3)   /* INT2 */
-#define  M32R_IRQ_INT3    (4)   /* INT3 */
-#define  M32R_IRQ_INT4    (5)   /* INT4 */
-#define  M32R_IRQ_INT5    (6)   /* INT5 */
-#define  M32R_IRQ_INT6    (7)   /* INT6 */
-#define  M32R_IRQ_MFT0    (16)  /* MFT0 */
-#define  M32R_IRQ_MFT1    (17)  /* MFT1 */
-#define  M32R_IRQ_MFT2    (18)  /* MFT2 */
-#define  M32R_IRQ_MFT3    (19)  /* MFT3 */
-#define  M32R_IRQ_MFT4    (20)  /* MFT4 */
-#define  M32R_IRQ_MFT5    (21)  /* MFT5 */
-#define  M32R_IRQ_DMA0    (32)  /* DMA0 */
-#define  M32R_IRQ_DMA1    (33)  /* DMA1 */
-#define  M32R_IRQ_SIO0_R  (48)  /* SIO0 send    */
-#define  M32R_IRQ_SIO0_S  (49)  /* SIO0 receive */
-#define  M32R_IRQ_SIO1_R  (50)  /* SIO1 send    */
-#define  M32R_IRQ_SIO1_S  (51)  /* SIO1 receive */
-#define  M32R_IRQ_SIO2_R  (52)  /* SIO2 send    */
-#define  M32R_IRQ_SIO2_S  (53)  /* SIO2 receive */
-#define  M32R_IRQ_SIO3_R  (54)  /* SIO3 send    */
-#define  M32R_IRQ_SIO3_S  (55)  /* SIO3 receive */
-#define  M32R_IRQ_SIO4_R  (56)  /* SIO4 send    */
-#define  M32R_IRQ_SIO4_S  (57)  /* SIO4 receive */
+#define M32R_IRQ_INT0    (1)   /* INT0 */
+#define M32R_IRQ_INT1    (2)   /* INT1 */
+#define M32R_IRQ_INT2    (3)   /* INT2 */
+#define M32R_IRQ_INT3    (4)   /* INT3 */
+#define M32R_IRQ_INT4    (5)   /* INT4 */
+#define M32R_IRQ_INT5    (6)   /* INT5 */
+#define M32R_IRQ_INT6    (7)   /* INT6 */
+#define M32R_IRQ_MFT0    (16)  /* MFT0 */
+#define M32R_IRQ_MFT1    (17)  /* MFT1 */
+#define M32R_IRQ_MFT2    (18)  /* MFT2 */
+#define M32R_IRQ_MFT3    (19)  /* MFT3 */
+#define M32R_IRQ_MFT4    (20)  /* MFT4 */
+#define M32R_IRQ_MFT5    (21)  /* MFT5 */
+#define M32R_IRQ_DMA0    (32)  /* DMA0 */
+#define M32R_IRQ_DMA1    (33)  /* DMA1 */
+#define M32R_IRQ_SIO0_R  (48)  /* SIO0 send    */
+#define M32R_IRQ_SIO0_S  (49)  /* SIO0 receive */
+#define M32R_IRQ_SIO1_R  (50)  /* SIO1 send    */
+#define M32R_IRQ_SIO1_S  (51)  /* SIO1 receive */
+#define M32R_IRQ_SIO2_R  (52)  /* SIO2 send    */
+#define M32R_IRQ_SIO2_S  (53)  /* SIO2 receive */
+#define M32R_IRQ_SIO3_R  (54)  /* SIO3 send    */
+#define M32R_IRQ_SIO3_S  (55)  /* SIO3 receive */
+#define M32R_IRQ_SIO4_R  (56)  /* SIO4 send    */
+#define M32R_IRQ_SIO4_S  (57)  /* SIO4 receive */
 
 #ifdef CONFIG_SMP
-#define M32R_IRQ_IPI0 (56)
-#define M32R_IRQ_IPI1 (57)
-#define M32R_IRQ_IPI2 (58)
-#define M32R_IRQ_IPI3 (59)
-#define M32R_IRQ_IPI4 (60)
-#define M32R_IRQ_IPI5 (61)
-#define M32R_IRQ_IPI6 (62)
-#define M32R_IRQ_IPI7 (63)
+#define M32R_IRQ_IPI0    (56)
+#define M32R_IRQ_IPI1    (57)
+#define M32R_IRQ_IPI2    (58)
+#define M32R_IRQ_IPI3    (59)
+#define M32R_IRQ_IPI4    (60)
+#define M32R_IRQ_IPI5    (61)
+#define M32R_IRQ_IPI6    (62)
+#define M32R_IRQ_IPI7    (63)
 #define M32R_CPUID_PORTL (0xffffffe0)
 
 #define M32R_FPGA_TOP (0x000F0000+M32R_SFR_OFFSET)

--
Hirokazu Takata <takata@linux-m32r.org>
Linux/M32R Project:  http://www.linux-m32r.org/

