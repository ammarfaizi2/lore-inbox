Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751587AbWDYQjl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751587AbWDYQjl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Apr 2006 12:39:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751610AbWDYQjf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Apr 2006 12:39:35 -0400
Received: from www.osadl.org ([213.239.205.134]:48512 "EHLO mail.tglx.de")
	by vger.kernel.org with ESMTP id S1751603AbWDYQjN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Apr 2006 12:39:13 -0400
Message-Id: <20060425162421.522613000@localhost.localdomain>
References: <20060425162414.896662000@localhost.localdomain>
Date: Tue, 25 Apr 2006 16:41:07 -0000
From: Thomas Gleixner <tglx@linutronix.de>
To: Andrew Morton <akpm@osdl.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>
Subject: [patch 3/4] rtmutex debug: printk correct task information
Content-Disposition: inline; filename=rtmutex-debug-print-current-fix.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Print the information of the current task rather than some random picked
task information.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Ingo Molnar <mingo@elte.hu>

 kernel/rtmutex.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: linux-2.6.17-rc1-mm3/kernel/rtmutex.c
===================================================================
--- linux-2.6.17-rc1-mm3.orig/kernel/rtmutex.c
+++ linux-2.6.17-rc1-mm3/kernel/rtmutex.c
@@ -180,7 +180,7 @@ static int rt_mutex_adjust_prio_chain(ta
 			prev_max = max_lock_depth;
 			printk(KERN_WARNING "Maximum lock depth %d reached "
 			       "task: %s (%d)\n", max_lock_depth,
-			       task->comm, task->pid);
+			       current->comm, current->pid);
 		}
 		put_task_struct(task);
 

--

