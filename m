Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262021AbVCEPjr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262021AbVCEPjr (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Mar 2005 10:39:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262008AbVCEPiV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Mar 2005 10:38:21 -0500
Received: from coderock.org ([193.77.147.115]:45987 "EHLO trashy.coderock.org")
	by vger.kernel.org with ESMTP id S262131AbVCEPfv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Mar 2005 10:35:51 -0500
Subject: [patch 08/12] Unified spinlock initialization include/linux/wait.h
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, domen@coderock.org, amitg@calsoftinc.com,
       gud@eth.net
From: domen@coderock.org
Date: Sat, 05 Mar 2005 16:35:32 +0100
Message-Id: <20050305153532.87B281F1F0@trashy.coderock.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Unify the spinlock initialization as far as possible.

Do consider applying.

Signed-off-by: Amit Gud <gud@eth.net>
Signed-off-by: Domen Puncer <domen@coderock.org>
---


 kj-domen/include/linux/wait.h |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

diff -puN include/linux/wait.h~spin_lock_init-include_linux_wait.h include/linux/wait.h
--- kj/include/linux/wait.h~spin_lock_init-include_linux_wait.h	2005-03-05 16:11:51.000000000 +0100
+++ kj-domen/include/linux/wait.h	2005-03-05 16:11:51.000000000 +0100
@@ -79,7 +79,7 @@ typedef struct __wait_queue_head wait_qu
 
 static inline void init_waitqueue_head(wait_queue_head_t *q)
 {
-	q->lock = SPIN_LOCK_UNLOCKED;
+	spin_lock_init(&q->lock);
 	INIT_LIST_HEAD(&q->task_list);
 }
 
_
