Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261914AbVAYLnI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261914AbVAYLnI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jan 2005 06:43:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261908AbVAYLez
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jan 2005 06:34:55 -0500
Received: from [220.225.34.50] ([220.225.34.50]:39373 "EHLO
	ganesha.intranet.calsoftinc.com") by vger.kernel.org with ESMTP
	id S261909AbVAYLeS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jan 2005 06:34:18 -0500
From: Amit Gud <amitg@calsoftinc.com>
Organization: Calsoft Pvt. Ltd.
To: linux-kernel@vger.kernel.org
Subject: [PATCH] Unified spinlock initialization include/linux/wait.h
Date: Tue, 25 Jan 2005 17:05:53 +0530
User-Agent: KMail/1.5
Cc: kernel-janitors@lists.osdl.org, gud@eth.net
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200501251705.58234.amitg@calsoftinc.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Unify the spinlock initialization as far as possible.

Do consider applying.

Signed-off-by: Amit Gud <gud@eth.net>

--- orig/include/linux/wait.h	2005-01-20 20:06:42.000000000 +0530
+++ linux-2.6.11-rc2/include/linux/wait.h	2005-01-25 16:41:31.000000000 +0530
@@ -79,7 +79,7 @@ typedef struct __wait_queue_head wait_qu
 
 static inline void init_waitqueue_head(wait_queue_head_t *q)
 {
-	q->lock = SPIN_LOCK_UNLOCKED;
+	spin_lock_init(&q->lock);
 	INIT_LIST_HEAD(&q->task_list);
 }
 

