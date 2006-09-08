Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751239AbWIHWyp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751239AbWIHWyp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Sep 2006 18:54:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751237AbWIHWyp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Sep 2006 18:54:45 -0400
Received: from tetsuo.zabbo.net ([207.173.201.20]:16011 "EHLO tetsuo.zabbo.net")
	by vger.kernel.org with ESMTP id S1751236AbWIHWyo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Sep 2006 18:54:44 -0400
From: Zach Brown <zach.brown@oracle.com>
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Message-Id: <20060908225443.9340.32666.sendpatchset@kaori.pdx.zabbo.net>
In-Reply-To: <20060908225438.9340.69862.sendpatchset@kaori.pdx.zabbo.net>
References: <20060908225438.9340.69862.sendpatchset@kaori.pdx.zabbo.net>
Subject: [PATCH 1/10] futex: remove extra pr_debug format specifications
Date: Fri,  8 Sep 2006 15:54:43 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

futex: remove extra pr_debug format specifications

Signed-off-by: Zach Brown <zach.brown@oracle.com>
---

 kernel/futex.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

Index: 2.6.18-rc6-debug-args/kernel/futex.c
===================================================================
--- 2.6.18-rc6-debug-args.orig/kernel/futex.c
+++ 2.6.18-rc6-debug-args/kernel/futex.c
@@ -1359,7 +1359,7 @@ static long futex_lock_pi_restart(struct
 			(u64) restart->arg0;
 	}
 
-	pr_debug("lock_pi restart: %p, %d (%d)\n",
+	pr_debug("lock_pi restart: %p, %d\n",
 		 (u32 __user *)restart->arg0, current->pid);
 
 	ret = do_futex_lock_pi((u32 __user *)restart->arg0, restart->arg1,
@@ -1396,7 +1396,7 @@ static int futex_lock_pi(u32 __user *uad
 	if (ret != -EINTR)
 		return ret;
 
-	pr_debug("lock_pi interrupted: %p, %d (%d)\n", uaddr, current->pid);
+	pr_debug("lock_pi interrupted: %p, %d\n", uaddr, current->pid);
 
 	restart = &current_thread_info()->restart_block;
 	restart->fn = futex_lock_pi_restart;
