Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261986AbULHBQb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261986AbULHBQb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Dec 2004 20:16:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261989AbULHBP5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Dec 2004 20:15:57 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:19730 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261983AbULHBOn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Dec 2004 20:14:43 -0500
Date: Wed, 8 Dec 2004 02:14:39 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>, Ingo Molnar <mingo@elte.hu>,
       linux-kernel@vger.kernel.org
Subject: [2.6 patch] sched.c: remove an unused function (fwd)
Message-ID: <20041208011439.GJ5496@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch forwarded below (slightly adopted for 2.6.10-rc2-mm4) still 
applies.

Please apply.


----- Forwarded message from Adrian Bunk <bunk@stusta.de> -----

Date:	Fri, 29 Oct 2004 02:25:38 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] sched.c: remove an unused function

The patch below removes an unused function from kernel/sched.c


diffstat output:
 kernel/sched.c |    5 -----
 1 files changed, 5 deletions(-)


Signed-off-by: Adrian Bunk <bunk@stusta.de>
Acked-by: Ingo Molnar <mingo@elte.hu>

--- linux-2.6.10-rc2-mm4-full/kernel/sched.c.old	2004-12-08 00:23:37.000000000 +0100
+++ linux-2.6.10-rc2-mm4-full/kernel/sched.c	2004-12-08 01:19:02.000000000 +0100
@@ -446,12 +440,6 @@
 	return rq;
 }
 
-static inline void rq_unlock(runqueue_t *rq)
-	__releases(rq->lock)
-{
-	spin_unlock_irq(&rq->lock);
-}
-
 #ifdef CONFIG_SCHED_SMT
 static int cpu_and_siblings_are_idle(int cpu)
 {
