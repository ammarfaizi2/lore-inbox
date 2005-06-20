Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261721AbVFUGTy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261721AbVFUGTy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Jun 2005 02:19:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261726AbVFTVym
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Jun 2005 17:54:42 -0400
Received: from coderock.org ([193.77.147.115]:58264 "EHLO trashy.coderock.org")
	by vger.kernel.org with ESMTP id S261709AbVFTVyQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Jun 2005 17:54:16 -0400
Message-Id: <20050620215124.471979000@nd47.coderock.org>
Date: Mon, 20 Jun 2005 23:51:24 +0200
From: domen@coderock.org
To: dmo@osdl.org
Cc: linux-kernel@vger.kernel.org, Christophe Lucas <clucas@rotomalug.org>,
       domen@coderock.org
Subject: [patch 2/2] printk : drivers/block/DAC960.c
Content-Disposition: inline; filename=printk-drivers_block_DAC960.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Christophe Lucas <clucas@rotomalug.org>



printk() calls should include appropriate KERN_* constant.

Signed-off-by: Christophe Lucas <clucas@rotomalug.org>
Signed-off-by: Domen Puncer <domen@coderock.org>
---
 DAC960.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

Index: quilt/drivers/block/DAC960.c
===================================================================
--- quilt.orig/drivers/block/DAC960.c
+++ quilt/drivers/block/DAC960.c
@@ -2536,7 +2536,7 @@ static boolean DAC960_RegisterBlockDevic
 	/* for now, let all request queues share controller's lock */
   	RequestQueue = blk_init_queue(DAC960_RequestFunction,&Controller->queue_lock);
   	if (!RequestQueue) {
-		printk("DAC960: failure to allocate request queue\n");
+		printk(KERN_WARNING "DAC960: failure to allocate request queue\n");
 		continue;
   	}
   	Controller->RequestQueue[n] = RequestQueue;
@@ -3610,7 +3610,7 @@ static void DAC960_V1_ProcessCompletedCo
 
 #ifdef FORCE_RETRY_FAILURE_DEBUG
       if (!(++retry_count % 10000)) {
-	      printk("V1 error retry failure test\n");
+	      printk(KERN_DEBUG "V1 error retry failure test\n");
 	      normal_completion = false;
               DAC960_V1_ReadWriteError(Command);
       }
@@ -4698,7 +4698,7 @@ static void DAC960_V2_ProcessCompletedCo
 
 #ifdef FORCE_RETRY_FAILURE_DEBUG
       if (!(++retry_count % 10000)) {
-	      printk("V2 error retry failure test\n");
+	      printk(KERN_DEBUG "V2 error retry failure test\n");
 	      normal_completion = false;
 	      DAC960_V2_ReadWriteError(Command);
       }

--
