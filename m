Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965170AbVKBSR7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965170AbVKBSR7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Nov 2005 13:17:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965174AbVKBSR6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Nov 2005 13:17:58 -0500
Received: from zeus2.kernel.org ([204.152.191.36]:52924 "EHLO zeus2.kernel.org")
	by vger.kernel.org with ESMTP id S965170AbVKBSR5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Nov 2005 13:17:57 -0500
Date: Wed, 2 Nov 2005 19:15:49 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Jens Axboe <axboe@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] drivers/block/ll_rw_blk.c: make a function static
Message-ID: <20051102181549.GD4272@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch makes a needlessly global function static.


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.14-rc5-mm1-full/drivers/block/ll_rw_blk.c.old	2005-11-02 18:41:30.000000000 +0100
+++ linux-2.6.14-rc5-mm1-full/drivers/block/ll_rw_blk.c	2005-11-02 18:41:59.000000000 +0100
@@ -2314,9 +2314,9 @@
  *    Insert a fully prepared request at the back of the io scheduler queue
  *    for execution.  Don't wait for completion.
  */
-void blk_execute_rq_nowait(request_queue_t *q, struct gendisk *bd_disk,
-			   struct request *rq, int at_head,
-			   void (*done)(struct request *))
+static void blk_execute_rq_nowait(request_queue_t *q, struct gendisk *bd_disk,
+				  struct request *rq, int at_head,
+				  void (*done)(struct request *))
 {
 	int where = at_head ? ELEVATOR_INSERT_FRONT : ELEVATOR_INSERT_BACK;
 

