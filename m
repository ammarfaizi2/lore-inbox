Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319324AbSH2UDb>; Thu, 29 Aug 2002 16:03:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319326AbSH2UDb>; Thu, 29 Aug 2002 16:03:31 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:52896 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S319324AbSH2UDa>;
	Thu, 29 Aug 2002 16:03:30 -0400
Subject: [TRIVIAL][PATCH] fix __FUNCTION__ pasting in wd7000.c
From: Paul Larson <plars@linuxtestproject.org>
To: Trivial Patch Monkey <trivial@rustcorp.com.au>,
       lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.5 
Date: 29 Aug 2002 14:56:53 -0500
Message-Id: <1030651016.5180.55.camel@plars.austin.ibm.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Trivial fix for __FUNCTION__ pasting in wd7000.c against current bk tree.

-Paul Larson

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.556   -> 1.557  
#	drivers/scsi/wd7000.c	1.8     -> 1.9    
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/08/29	plars@austin.ibm.com	1.557
# fix __FUNCTION__ pasting in wd7000
# --------------------------------------------
#
diff -Nru a/drivers/scsi/wd7000.c b/drivers/scsi/wd7000.c
--- a/drivers/scsi/wd7000.c	Thu Aug 29 15:25:10 2002
+++ b/drivers/scsi/wd7000.c	Thu Aug 29 15:25:10 2002
@@ -621,16 +621,16 @@
 	(void)get_options(str, ARRAY_SIZE(ints), ints);
 
 	if (wd7000_card_num >= NUM_CONFIGS) {
-		printk(KERN_ERR __FUNCTION__
-			": Too many \"wd7000=\" configurations in "
-			"command line!\n");
+		printk(KERN_ERR
+			"%s: Too many \"wd7000=\" configurations in "
+			"command line!\n", __FUNCTION__);
 		return 0;
 	}
 
 	if ((ints[0] < 3) || (ints[0] > 5)) {
-		printk(KERN_ERR __FUNCTION__ ": Error in command line!  "
+		printk(KERN_ERR "%s: Error in command line!  "
 			"Usage: wd7000=<IRQ>,<DMA>,IO>[,<BUS_ON>"
-			"[,<BUS_OFF>]]\n");
+			"[,<BUS_OFF>]]\n", __FUNCTION__ );
 	} else {
 		for (i = 0; i < NUM_IRQS; i++)
 			if (ints[1] == wd7000_irq[i])
@@ -1743,8 +1743,8 @@
 	    ip[2] = info[2];
 
 	    if (info[0] == 255)
-		printk(KERN_INFO __FUNCTION__ ": current partition table is "
-			"using extended translation.\n");
+		printk(KERN_INFO "%s: current partition table is "
+			"using extended translation.\n", __FUNCTION__ );
 	}
     }
 

