Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261612AbVCFXt0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261612AbVCFXt0 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Mar 2005 18:49:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261597AbVCFXsb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Mar 2005 18:48:31 -0500
Received: from coderock.org ([193.77.147.115]:64943 "EHLO trashy.coderock.org")
	by vger.kernel.org with ESMTP id S261575AbVCFWhK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Mar 2005 17:37:10 -0500
Subject: [patch 12/14] drivers/dmapool: use TASK_UNINTERRUPTIBLE instead of TASK_INTERRUPTIBLE
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, domen@coderock.org, nacc@us.ibm.com
From: domen@coderock.org
Date: Sun, 06 Mar 2005 23:36:53 +0100
Message-Id: <20050306223654.3EE871EC90@trashy.coderock.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



use TASK_UNINTERRUPTIBLE  instead of TASK_INTERRUPTIBLE

Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>
Signed-off-by: Domen Puncer <domen@coderock.org>
---


 kj-domen/drivers/base/dmapool.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

diff -puN drivers/base/dmapool.c~task_unint-drivers_base_dmapool drivers/base/dmapool.c
--- kj/drivers/base/dmapool.c~task_unint-drivers_base_dmapool	2005-03-05 16:11:21.000000000 +0100
+++ kj-domen/drivers/base/dmapool.c	2005-03-05 16:11:21.000000000 +0100
@@ -293,7 +293,7 @@ restart:
 		if (mem_flags & __GFP_WAIT) {
 			DECLARE_WAITQUEUE (wait, current);
 
-			current->state = TASK_INTERRUPTIBLE;
+			set_current_state(TASK_UNINTERRUPTIBLE);
 			add_wait_queue (&pool->waitq, &wait);
 			spin_unlock_irqrestore (&pool->lock, flags);
 
_
