Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272520AbTHRQhF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Aug 2003 12:37:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272535AbTHRQhF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Aug 2003 12:37:05 -0400
Received: from [203.145.184.221] ([203.145.184.221]:40969 "EHLO naturesoft.net")
	by vger.kernel.org with ESMTP id S272520AbTHRQhB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Aug 2003 12:37:01 -0400
From: "Krishnakumar. R" <krishnakumar@naturesoft.net>
Reply-To: krishnakumar@naturesoft.net
Organization: Naturesoft
To: trivial@rustcorp.com.au
Subject: [TRIVIAL][PATCH-2.6.0-test3]more unused variable fixes.
Date: Mon, 18 Aug 2003 22:10:05 +0530
User-Agent: KMail/1.5
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200308182210.05846.krishnakumar@naturesoft.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The following patch removes the 'unused variable' error
from the files:

1. drivers/net/wan/sdlamain.c
2. drivers/video/tridentfb.c


Regards
KK

=========================================
diffstat output:

net/wan/sdlamain.c |    1 -
video/tridentfb.c      |    2 +-
2 files changed, 1 insertion(+), 2 deletions(-)

=========================================

The patch is as follows:

--- linux-2.6.0-test3/drivers/net/wan/sdlamain.orig.c	2003-08-18 21:44:12.000000000 +0530
+++ linux-2.6.0-test3/drivers/net/wan/sdlamain.c	2003-08-18 21:45:07.000000000 +0530
@@ -1029,7 +1029,6 @@
 STATIC irqreturn_t sdla_isr (int irq, void* dev_id, struct pt_regs *regs)
 {
 #define	card	((sdla_t*)dev_id)
-	int handled = 0;
 
 	if(card->hw.type == SDLA_S514) {	/* handle interrrupt on S514 */
                 u32 int_status;
--- linux-2.6.0-test3/drivers/video/tridentfb.orig.c	2003-08-18 22:02:56.000000000 +0530
+++ linux-2.6.0-test3/drivers/video/tridentfb.c	2003-08-18 22:03:36.000000000 +0530
@@ -454,7 +454,7 @@
 static void tridentfb_fillrect(struct fb_info * info, const struct fb_fillrect *fr)
 {
 	int bpp = info->var.bits_per_pixel;
-	int dx,dy,w,h,col;
+	int col;
 	
 	switch (bpp) {
 		case 8: col = fr->color;






