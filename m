Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263665AbTDTSYP (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Apr 2003 14:24:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263671AbTDTSYO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Apr 2003 14:24:14 -0400
Received: from hera.cwi.nl ([192.16.191.8]:47034 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id S263665AbTDTSXQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Apr 2003 14:23:16 -0400
From: Andries.Brouwer@cwi.nl
Date: Sun, 20 Apr 2003 20:35:15 +0200 (MEST)
Message-Id: <UTC200304201835.h3KIZFv18207.aeb@smtp.cwi.nl>
To: torvalds@transmeta.com
Subject: [SPELLING PATCH] s/allready/already/
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -u --recursive --new-file -X /linux/dontdiff a/arch/mips/baget/vacserial.c b/arch/mips/baget/vacserial.c
--- a/arch/mips/baget/vacserial.c	Mon Feb 24 23:02:45 2003
+++ b/arch/mips/baget/vacserial.c	Sun Apr 20 19:21:05 2003
@@ -124,7 +124,7 @@
  * UART
  */
 static struct serial_uart_config uart_config[] = {
-        { "unknown",  1, 0 },  /* Must go first  --  used as unasigned */
+        { "unknown",  1, 0 },  /* Must go first  --  used as unassigned */
         { "VAC UART", 1, 0 }
 }; 
 #define VAC_UART_TYPE 1   /* Just index in above array */
diff -u --recursive --new-file -X /linux/dontdiff a/drivers/isdn/hisax/callc.c b/drivers/isdn/hisax/callc.c
--- a/drivers/isdn/hisax/callc.c	Sat Jan 18 23:54:28 2003
+++ b/drivers/isdn/hisax/callc.c	Sun Apr 20 19:21:05 2003
@@ -1209,7 +1209,7 @@
 			kfree(csta->channel[i].b_st);
 			csta->channel[i].b_st = NULL;
 		} else
-			printk(KERN_WARNING "CallcFreeChan b_st ch%d allready freed\n", i);
+			printk(KERN_WARNING "CallcFreeChan b_st ch%d already freed\n", i);
 		if (i || test_bit(FLG_TWO_DCHAN, &csta->HW_Flags)) {
 			release_d_st(csta->channel + i);
 		} else
diff -u --recursive --new-file -X /linux/dontdiff a/drivers/isdn/hisax/tei.c b/drivers/isdn/hisax/tei.c
--- a/drivers/isdn/hisax/tei.c	Sat Jan 18 23:54:28 2003
+++ b/drivers/isdn/hisax/tei.c	Sun Apr 20 19:21:05 2003
@@ -145,7 +145,7 @@
 
 	if (st->l2.tei != -1) {
 		st->ma.tei_m.printdebug(&st->ma.tei_m,
-			"assign request for allready asigned tei %d",
+			"assign request for already assigned tei %d",
 			st->l2.tei);
 		return;
 	}
diff -u --recursive --new-file -X /linux/dontdiff a/drivers/isdn/hisax/teleint.c b/drivers/isdn/hisax/teleint.c
--- a/drivers/isdn/hisax/teleint.c	Tue Mar 18 11:48:20 2003
+++ b/drivers/isdn/hisax/teleint.c	Sun Apr 20 19:21:05 2003
@@ -95,7 +95,7 @@
 	register int max_delay = 20000;
 	register int i;
 	
-	/* fifo write without cli because it's allready done  */
+	/* fifo write without cli because it's already done  */
 	byteout(ale, off);
 	for (i = 0; i<size; i++) {
 		ret = HFC_BUSY & bytein(ale);
diff -u --recursive --new-file -X /linux/dontdiff a/drivers/isdn/hysdn/hycapi.c b/drivers/isdn/hysdn/hycapi.c
--- a/drivers/isdn/hysdn/hycapi.c	Wed Mar  5 10:47:21 2003
+++ b/drivers/isdn/hysdn/hycapi.c	Sun Apr 20 19:21:05 2003
@@ -227,7 +227,7 @@
 		return;
 	}
 	if(chk == 1) {
-		printk(KERN_INFO "HYSDN: apl %d allready registered\n", appl);
+		printk(KERN_INFO "HYSDN: apl %d already registered\n", appl);
 		return;
 	}
 	MaxBDataBlocks = rp->datablkcnt > CAPI_MAXDATAWINDOW ? CAPI_MAXDATAWINDOW : rp->datablkcnt;
diff -u --recursive --new-file -X /linux/dontdiff a/drivers/media/video/zr36067.c b/drivers/media/video/zr36067.c
--- a/drivers/media/video/zr36067.c	Wed Mar  5 10:47:21 2003
+++ b/drivers/media/video/zr36067.c	Sun Apr 20 19:21:05 2003
@@ -282,7 +282,7 @@
 	for (i = 0; i < v4l_nbufs; i++) {
 		if (zr->v4l_gbuf[i].fbuffer)
 			printk(KERN_WARNING
-			       "%s: v4l_fbuffer_alloc: buffer %d allready allocated ???\n",
+			       "%s: v4l_fbuffer_alloc: buffer %d already allocated ???\n",
 			       zr->name, i);
 
 		//udelay(20);
@@ -415,7 +415,7 @@
 	for (i = 0; i < zr->jpg_nbufs; i++) {
 		if (zr->jpg_gbuf[i].frag_tab)
 			printk(KERN_WARNING
-			       "%s: jpg_fbuffer_alloc: buffer %d allready allocated ???\n",
+			       "%s: jpg_fbuffer_alloc: buffer %d already allocated ???\n",
 			       zr->name, i);
 
 		/* Allocate fragment table for this buffer */
@@ -447,7 +447,7 @@
 			for (off = 0; off < zr->jpg_bufsize; off += PAGE_SIZE)
 				mem_map_reserve(MAP_NR(mem + off));
 		} else {
-			/* jpg_bufsize is allreay page aligned */
+			/* jpg_bufsize is already page aligned */
 			for (j = 0; j < zr->jpg_bufsize / PAGE_SIZE; j++) 
 			{
 				mem = get_zeroed_page(GFP_KERNEL);
@@ -937,7 +937,7 @@
 				fmt);
 
 		/* Start and length of each line MUST be 4-byte aligned.
-		   This should be allready checked before the call to this routine.
+		   This should be already checked before the call to this routine.
 		   All error messages are internal driver checking only! */
 
 		/* video display top and bottom registers */
@@ -3241,7 +3241,7 @@
 	case 0:
 		if (zr->user > 1) {
 			DEBUG1(printk(KERN_WARNING
-			       "%s: zoran_open: Buz is allready in use\n",
+			       "%s: zoran_open: Buz is already in use\n",
 			       zr->name));
 			return -EBUSY;
 		}
@@ -4066,7 +4066,7 @@
 
 			if (zr->jpg_buffers_allocated) {
 				DEBUG1(printk(KERN_ERR
-				       "%s: BUZIOC_REQBUFS: buffers allready allocated\n",
+				       "%s: BUZIOC_REQBUFS: buffers already allocated\n",
 				       zr->name));
 				return -EINVAL;
 			}
diff -u --recursive --new-file -X /linux/dontdiff a/drivers/video/amifb.c b/drivers/video/amifb.c
--- a/drivers/video/amifb.c	Tue Mar 25 04:54:39 2003
+++ b/drivers/video/amifb.c	Sun Apr 20 19:21:05 2003
@@ -254,7 +254,7 @@
         moved to optimize use of dma (useful for OCS/ECS overscan displays)
       - ddfstop is ddfstrt+ddfsize-fetchsize
       - If C= didn't change anything for AGA, then at following positions the
-        dma bus is allready used:
+        dma bus is already used:
         ddfstrt <  48 -> memory refresh
                 <  96 -> disk dma
                 < 160 -> audio dma
diff -u --recursive --new-file -X /linux/dontdiff a/drivers/video/fbmem.c b/drivers/video/fbmem.c
--- a/drivers/video/fbmem.c	Sun Apr 20 12:59:32 2003
+++ b/drivers/video/fbmem.c	Sun Apr 20 19:21:05 2003
@@ -945,7 +945,7 @@
 int
 fb_blank(struct fb_info *info, int blank)
 {	
-	/* ??? Varible sized stack allocation.  */
+	/* ??? Variable sized stack allocation. */
 	u16 black[info->cmap.len];
 	struct fb_cmap cmap;
 	
@@ -992,7 +992,8 @@
 			return -EFAULT;
 		return 0;
 	case FBIOGET_FSCREENINFO:
-		return copy_to_user((void *) arg, &info->fix, sizeof(fix)) ? -EFAULT : 0;
+		return copy_to_user((void *) arg, &info->fix,
+				    sizeof(fix)) ? -EFAULT : 0;
 	case FBIOPUTCMAP:
 		if (copy_from_user(&cmap, (void *) arg, sizeof(cmap)))
 			return -EFAULT;
