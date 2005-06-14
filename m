Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261190AbVFNOhg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261190AbVFNOhg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Jun 2005 10:37:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261155AbVFNOhg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Jun 2005 10:37:36 -0400
Received: from users.ccur.com ([208.248.32.211]:40335 "EHLO gamx.iccur.com")
	by vger.kernel.org with ESMTP id S261249AbVFNOc1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Jun 2005 10:32:27 -0400
Date: Tue, 14 Jun 2005 10:32:13 -0400
From: Joe Korty <joe.korty@ccur.com>
To: mingo@elte.hu
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: [PATCH] possible error in EXIT_DEAD transformation
Message-ID: <20050614143213.GA2059@tsunami.ccur.com>
Reply-To: joe.korty@ccur.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This assignment may have been missed, when TASK_DEAD was
converted over to EXIT_DEAD.

Signed-off-by: Joe Korty <joe.korty@ccur.com>


 2.6.12-rc6-git7-jak/kernel/sched.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

diff -puNa kernel/sched.c~possibly.erronous.task_state.assignment kernel/sched.c
--- 2.6.12-rc6-git7/kernel/sched.c~possibly.erronous.task_state.assignment	2005-06-14 10:25:49.000000000 -0400
+++ 2.6.12-rc6-git7-jak/kernel/sched.c	2005-06-14 10:26:05.000000000 -0400
@@ -2664,7 +2664,7 @@ need_resched_nonpreemptible:
 	spin_lock_irq(&rq->lock);
 
 	if (unlikely(prev->flags & PF_DEAD))
-		prev->state = EXIT_DEAD;
+		prev->exit_state = EXIT_DEAD;
 
 	switch_count = &prev->nivcsw;
 	if (prev->state && !(preempt_count() & PREEMPT_ACTIVE)) {

_
