Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262735AbVDHIAX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262735AbVDHIAX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Apr 2005 04:00:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262740AbVDHH6X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Apr 2005 03:58:23 -0400
Received: from coderock.org ([193.77.147.115]:19168 "EHLO trashy.coderock.org")
	by vger.kernel.org with ESMTP id S262745AbVDHHv6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Apr 2005 03:51:58 -0400
Subject: [patch 1/1] printk : drivers/block/DAC960.c
To: dmo@osdl.org
Cc: linux-kernel@vger.kernel.org, domen@coderock.org, clucas@rotomalug.org
From: domen@coderock.org
Date: Fri, 08 Apr 2005 09:51:50 +0200
Message-Id: <20050408075151.775901F39A@trashy.coderock.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



printk() calls should include appropriate KERN_* constant.

Signed-off-by: Christophe Lucas <clucas@rotomalug.org>
Signed-off-by: Domen Puncer <domen@coderock.org>
---


 kj-domen/drivers/block/DAC960.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff -puN drivers/block/DAC960.c~printk-drivers_block_DAC960 drivers/block/DAC960.c
--- kj/drivers/block/DAC960.c~printk-drivers_block_DAC960	2005-04-05 12:57:58.000000000 +0200
+++ kj-domen/drivers/block/DAC960.c	2005-04-05 12:57:58.000000000 +0200
@@ -2496,7 +2496,7 @@ static boolean DAC960_RegisterBlockDevic
 	/* for now, let all request queues share controller's lock */
   	RequestQueue = blk_init_queue(DAC960_RequestFunction,&Controller->queue_lock);
   	if (!RequestQueue) {
-		printk("DAC960: failure to allocate request queue\n");
+		printk(KERN_WARNING "DAC960: failure to allocate request queue\n");
 		continue;
   	}
   	Controller->RequestQueue[n] = RequestQueue;
@@ -3534,7 +3534,7 @@ static void DAC960_V1_ProcessCompletedCo
 
 #ifdef FORCE_RETRY_FAILURE_DEBUG
       if (!(++retry_count % 10000)) {
-	      printk("V1 error retry failure test\n");
+	      printk(KERN_DEBUG "V1 error retry failure test\n");
 	      normal_completion = false;
               DAC960_V1_ReadWriteError(Command);
       }
@@ -4622,7 +4622,7 @@ static void DAC960_V2_ProcessCompletedCo
 
 #ifdef FORCE_RETRY_FAILURE_DEBUG
       if (!(++retry_count % 10000)) {
-	      printk("V2 error retry failure test\n");
+	      printk(KERN_DEBUG "V2 error retry failure test\n");
 	      normal_completion = false;
 	      DAC960_V2_ReadWriteError(Command);
       }
_
