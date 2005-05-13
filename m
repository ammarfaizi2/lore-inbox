Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262586AbVEMWks@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262586AbVEMWks (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 May 2005 18:40:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262578AbVEMWj7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 May 2005 18:39:59 -0400
Received: from coderock.org ([193.77.147.115]:55701 "EHLO trashy.coderock.org")
	by vger.kernel.org with ESMTP id S262590AbVEMWZD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 May 2005 18:25:03 -0400
Message-Id: <20050513222409.165372000@nd47.coderock.org>
Date: Sat, 14 May 2005 00:24:07 +0200
From: domen@coderock.org
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, Christophe Lucas <clucas@rotomalug.org>,
       domen@coderock.org
Subject: [patch 2/3] drivers/char/hw_random.c: replace direct assignment with set_current_state()
Content-Disposition: inline; filename=set_current_state-drivers_char_hw_random
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Christophe Lucas <clucas@rotomalug.org>



Use set_current_state() instead of direct assignment of
current->state.

Signed-off-by: Christophe Lucas <clucas@rotomalug.org>
Signed-off-by: Domen Puncer <domen@coderock.org>


---
 hw_random.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

Index: quilt/drivers/char/hw_random.c
===================================================================
--- quilt.orig/drivers/char/hw_random.c
+++ quilt/drivers/char/hw_random.c
@@ -514,7 +514,7 @@ static ssize_t rng_dev_read (struct file
 
 		if(need_resched())
 		{
-			current->state = TASK_INTERRUPTIBLE;
+			set_current_state(TASK_INTERRUPTIBLE);
 			schedule_timeout(1);
 		}
 		else

--
