Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261696AbVCOSMh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261696AbVCOSMh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Mar 2005 13:12:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261703AbVCOSMY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Mar 2005 13:12:24 -0500
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:43403 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S261696AbVCOSIS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Mar 2005 13:08:18 -0500
Date: Tue, 15 Mar 2005 11:07:59 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Paul Mackerras <paulus@samba.org>
Subject: [PATCH] ppc32: Lindent include/asm-ppc/dma.h
Message-ID: <20050315180758.GS8345@smtp.west.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This originally came from Paul, back in July of 2003.  Run Lindent over
include/asm-ppc/dma.h

Signed-off-by: Tom Rini <trini@kernel.crashing.org>

--- linux-2.6.11/include/asm-ppc/dma.h~	2005-03-02 00:38:25.000000000 -0700
+++ linux-2.6.11/include/asm-ppc/dma.h	2005-03-15 10:37:08.000000000 -0700
@@ -25,7 +25,6 @@
  * with a grain of salt.
  */
 
-
 #ifndef _ASM_DMA_H
 #define _ASM_DMA_H
 
@@ -192,9 +191,9 @@
 /* enable/disable a specific DMA channel */
 static __inline__ void enable_dma(unsigned int dmanr)
 {
-	unsigned char ucDmaCmd=0x00;
+	unsigned char ucDmaCmd = 0x00;
 
-	if (dmanr != 4)	{
+	if (dmanr != 4) {
 		dma_outb(0, DMA2_MASK_REG);	/* This may not be enabled */
 		dma_outb(ucDmaCmd, DMA2_CMD_REG);	/* Enable group */
 	}
@@ -244,60 +243,58 @@
  */
 static __inline__ void set_dma_page(unsigned int dmanr, int pagenr)
 {
-	switch(dmanr) {
-		case 0:
-			dma_outb(pagenr, DMA_LO_PAGE_0);
-			dma_outb(pagenr >> 8, DMA_HI_PAGE_0);
-			break;
-		case 1:
-			dma_outb(pagenr, DMA_LO_PAGE_1);
-			dma_outb(pagenr >> 8, DMA_HI_PAGE_1);
-			break;
-		case 2:
-			dma_outb(pagenr, DMA_LO_PAGE_2);
-			dma_outb(pagenr >> 8, DMA_HI_PAGE_2);
-			break;
-		case 3:
-			dma_outb(pagenr, DMA_LO_PAGE_3);
-			dma_outb(pagenr >> 8, DMA_HI_PAGE_3);
-			break;
-		case 5:
-			if (SND_DMA1 == 5 || SND_DMA2 == 5)
-				dma_outb(pagenr, DMA_LO_PAGE_5);
-			else
-				dma_outb(pagenr & 0xfe, DMA_LO_PAGE_5);
-			dma_outb(pagenr >> 8, DMA_HI_PAGE_5);
-			break;
-		case 6:
-			if (SND_DMA1 == 6 || SND_DMA2 == 6)
-				dma_outb(pagenr, DMA_LO_PAGE_6);
-			else
-				dma_outb(pagenr & 0xfe, DMA_LO_PAGE_6);
-			dma_outb(pagenr >> 8, DMA_HI_PAGE_6);
-			break;
-		case 7:
-			if (SND_DMA1 == 7 || SND_DMA2 == 7)
-				dma_outb(pagenr, DMA_LO_PAGE_7);
-			else
-				dma_outb(pagenr & 0xfe, DMA_LO_PAGE_7);
-			dma_outb(pagenr >> 8, DMA_HI_PAGE_7);
-			break;
+	switch (dmanr) {
+	case 0:
+		dma_outb(pagenr, DMA_LO_PAGE_0);
+		dma_outb(pagenr >> 8, DMA_HI_PAGE_0);
+		break;
+	case 1:
+		dma_outb(pagenr, DMA_LO_PAGE_1);
+		dma_outb(pagenr >> 8, DMA_HI_PAGE_1);
+		break;
+	case 2:
+		dma_outb(pagenr, DMA_LO_PAGE_2);
+		dma_outb(pagenr >> 8, DMA_HI_PAGE_2);
+		break;
+	case 3:
+		dma_outb(pagenr, DMA_LO_PAGE_3);
+		dma_outb(pagenr >> 8, DMA_HI_PAGE_3);
+		break;
+	case 5:
+		if (SND_DMA1 == 5 || SND_DMA2 == 5)
+			dma_outb(pagenr, DMA_LO_PAGE_5);
+		else
+			dma_outb(pagenr & 0xfe, DMA_LO_PAGE_5);
+		dma_outb(pagenr >> 8, DMA_HI_PAGE_5);
+		break;
+	case 6:
+		if (SND_DMA1 == 6 || SND_DMA2 == 6)
+			dma_outb(pagenr, DMA_LO_PAGE_6);
+		else
+			dma_outb(pagenr & 0xfe, DMA_LO_PAGE_6);
+		dma_outb(pagenr >> 8, DMA_HI_PAGE_6);
+		break;
+	case 7:
+		if (SND_DMA1 == 7 || SND_DMA2 == 7)
+			dma_outb(pagenr, DMA_LO_PAGE_7);
+		else
+			dma_outb(pagenr & 0xfe, DMA_LO_PAGE_7);
+		dma_outb(pagenr >> 8, DMA_HI_PAGE_7);
+		break;
 	}
 }
 
-
 /* Set transfer address & page bits for specific DMA channel.
  * Assumes dma flipflop is clear.
  */
 static __inline__ void set_dma_addr(unsigned int dmanr, unsigned int phys)
 {
 	if (dmanr <= 3) {
-		dma_outb(phys & 0xff, ((dmanr & 3) << 1) + IO_DMA1_BASE );
+		dma_outb(phys & 0xff, ((dmanr & 3) << 1) + IO_DMA1_BASE);
 		dma_outb((phys >> 8) & 0xff, ((dmanr & 3) << 1) + IO_DMA1_BASE);
 	} else if (dmanr == SND_DMA1 || dmanr == SND_DMA2) {
-		dma_outb(phys  & 0xff, ((dmanr & 3) << 2) + IO_DMA2_BASE );
-		dma_outb((phys >> 8)  & 0xff, ((dmanr & 3) << 2) +
-				IO_DMA2_BASE);
+		dma_outb(phys & 0xff, ((dmanr & 3) << 2) + IO_DMA2_BASE);
+		dma_outb((phys >> 8) & 0xff, ((dmanr & 3) << 2) + IO_DMA2_BASE);
 		dma_outb((dmanr & 3), DMA2_EXT_REG);
 	} else {
 		dma_outb((phys >> 1) & 0xff, ((dmanr & 3) << 2) + IO_DMA2_BASE);
@@ -306,7 +303,6 @@
 	set_dma_page(dmanr, phys >> 16);
 }
 
-
 /* Set transfer size (max 64k for DMA1..3, 128k for DMA5..7) for
  * a specific DMA channel.
  * You must ensure the parameters are valid.
@@ -321,16 +317,16 @@
 	if (dmanr <= 3) {
 		dma_outb(count & 0xff, ((dmanr & 3) << 1) + 1 + IO_DMA1_BASE);
 		dma_outb((count >> 8) & 0xff, ((dmanr & 3) << 1) + 1 +
-				IO_DMA1_BASE);
+			 IO_DMA1_BASE);
 	} else if (dmanr == SND_DMA1 || dmanr == SND_DMA2) {
-		dma_outb( count & 0xff, ((dmanr & 3) << 2) + 2 + IO_DMA2_BASE);
-		dma_outb( (count >> 8) & 0xff, ((dmanr & 3) << 2) + 2 +
-				IO_DMA2_BASE);
+		dma_outb(count & 0xff, ((dmanr & 3) << 2) + 2 + IO_DMA2_BASE);
+		dma_outb((count >> 8) & 0xff, ((dmanr & 3) << 2) + 2 +
+			 IO_DMA2_BASE);
 	} else {
 		dma_outb((count >> 1) & 0xff, ((dmanr & 3) << 2) + 2 +
-				IO_DMA2_BASE);
+			 IO_DMA2_BASE);
 		dma_outb((count >> 9) & 0xff, ((dmanr & 3) << 2) + 2 +
-				IO_DMA2_BASE);
+			 IO_DMA2_BASE);
 	}
 }
 
@@ -345,8 +341,8 @@
 static __inline__ int get_dma_residue(unsigned int dmanr)
 {
 	unsigned int io_port = (dmanr <= 3) ?
-		((dmanr & 3) << 1) + 1 + IO_DMA1_BASE
-		: ((dmanr & 3) << 2) + 2 + IO_DMA2_BASE;
+	    ((dmanr & 3) << 1) + 1 + IO_DMA1_BASE
+	    : ((dmanr & 3) << 2) + 2 + IO_DMA2_BASE;
 
 	/* using short to get 16-bit wrap around */
 	unsigned short count;
@@ -355,14 +351,14 @@
 	count += dma_inb(io_port) << 8;
 
 	return (dmanr <= 3 || dmanr == SND_DMA1 || dmanr == SND_DMA2)
-		? count : (count<<1);
+	    ? count : (count << 1);
 
 }
 
 /* These are in kernel/dma.c: */
 
 /* reserve a DMA channel */
-extern int request_dma(unsigned int dmanr, const char * device_id);
+extern int request_dma(unsigned int dmanr, const char *device_id);
 /* release it again */
 extern void free_dma(unsigned int dmanr);
 
@@ -371,5 +367,5 @@
 #else
 #define isa_dma_bridge_buggy	(0)
 #endif
-#endif /* _ASM_DMA_H */
-#endif /* __KERNEL__ */
+#endif				/* _ASM_DMA_H */
+#endif				/* __KERNEL__ */

-- 
Tom Rini
http://gate.crashing.org/~trini/
