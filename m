Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262389AbVC3Sfc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262389AbVC3Sfc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Mar 2005 13:35:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262388AbVC3Sfc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Mar 2005 13:35:32 -0500
Received: from mail-relay-3.tiscali.it ([213.205.33.43]:52102 "EHLO
	mail-relay-3.tiscali.it") by vger.kernel.org with ESMTP
	id S262386AbVC3SfQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Mar 2005 13:35:16 -0500
Subject: [patch 1/3] fix defined but unused warning
To: torvalds@osdl.org
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, blaisorblade@yahoo.it
From: blaisorblade@yahoo.it
Date: Wed, 30 Mar 2005 19:32:07 +0200
Message-Id: <20050330173212.0851AE0735@zion>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Fix "defined but unused" warning in kernel/sched.c.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 linux-2.6.11-paolo/kernel/sched.c |    2 ++
 1 files changed, 2 insertions(+)

diff -puN kernel/sched.c~fix-def-notused-warn kernel/sched.c
--- linux-2.6.11/kernel/sched.c~fix-def-notused-warn	2005-03-27 22:14:49.000000000 +0200
+++ linux-2.6.11-paolo/kernel/sched.c	2005-03-27 22:15:00.000000000 +0200
@@ -314,7 +314,9 @@ static inline void task_rq_unlock(runque
 static int show_schedstat(struct seq_file *seq, void *v)
 {
 	int cpu;
+#ifdef CONFIG_SMP
 	enum idle_type itype;
+#endif
 
 	seq_printf(seq, "version %d\n", SCHEDSTAT_VERSION);
 	seq_printf(seq, "timestamp %lu\n", jiffies);
_
