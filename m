Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932454AbVKGHxS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932454AbVKGHxS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Nov 2005 02:53:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932455AbVKGHxS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Nov 2005 02:53:18 -0500
Received: from ozlabs.org ([203.10.76.45]:18661 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S932454AbVKGHxS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Nov 2005 02:53:18 -0500
Date: Mon, 7 Nov 2005 18:51:28 +1100
From: Anton Blanchard <anton@samba.org>
To: akpm@osdl.org
Cc: mingo@elte.hu, linux-kernel@vger.kernel.org
Subject: [PATCH] quieten softlockup at boot
Message-ID: <20051107075128.GM12353@krispykreme>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On a large SMP box we get a lot of softlockup thread XX started lines.
Any objections if we remove them?

Signed-off-by: Anton Blanchard <anton@samba.org>
---

Index: build/kernel/softlockup.c
===================================================================
--- build.orig/kernel/softlockup.c	2005-09-15 17:33:50.000000000 +1000
+++ build/kernel/softlockup.c	2005-10-06 21:52:14.000000000 +1000
@@ -75,8 +75,6 @@
 	struct sched_param param = { .sched_priority = 99 };
 	int this_cpu = (long) __bind_cpu;
 
-	printk("softlockup thread %d started up.\n", this_cpu);
-
 	sched_setscheduler(current, SCHED_FIFO, &param);
 	current->flags |= PF_NOFREEZE;
 
