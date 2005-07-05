Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261658AbVGEUDs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261658AbVGEUDs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Jul 2005 16:03:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261736AbVGEUDr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Jul 2005 16:03:47 -0400
Received: from mx1.redhat.com ([66.187.233.31]:64702 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261658AbVGEUDo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Jul 2005 16:03:44 -0400
From: David Howells <dhowells@redhat.com>
To: torvalds@osdl.org, akpm@osdl.org
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Fix printk format vs argument warning
X-Mailer: MH-E 7.82; nmh 1.0.4; GNU Emacs 22.0.50.4
Date: Tue, 05 Jul 2005 21:03:39 +0100
Message-ID: <1284.1120593819@warthog.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The attached patch makes the argument to this printk in
calibrate_migration_costs() always long to match the format string.

Signed-Off-By: David Howells <dhowells@redhat.com>
---
warthog>diffstat -p1 format-arg-size-2612mm1-10.diff 
 kernel/sched.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

diff -uNrp linux-2.6.12-mm1/kernel/sched.c linux-2.6.12-mm1-cachefs-wander/kernel/sched.c
--- linux-2.6.12-mm1/kernel/sched.c	2005-06-22 13:54:08.000000000 +0100
+++ linux-2.6.12-mm1-cachefs-wander/kernel/sched.c	2005-06-22 14:10:57.000000000 +0100
@@ -5572,7 +5572,7 @@ void __devinit calibrate_migration_costs
 	printk("| migration cost matrix (max_cache_size: %d, cpu: %ld MHz):\n",
 			max_cache_size,
 #ifdef CONFIG_X86
-			cpu_khz/1000
+			cpu_khz/1000L
 #else
 			-1L
 #endif
