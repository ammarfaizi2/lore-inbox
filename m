Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262605AbUFFBfM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262605AbUFFBfM (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Jun 2004 21:35:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261479AbUFFBfM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Jun 2004 21:35:12 -0400
Received: from cantor.suse.de ([195.135.220.2]:36743 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S262634AbUFFBfB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Jun 2004 21:35:01 -0400
Date: Sun, 6 Jun 2004 03:32:38 +0200
From: Andi Kleen <ak@suse.de>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Disable scheduler debugging
Message-Id: <20040606033238.4e7d72fc.ak@suse.de>
X-Mailer: Sylpheed version 0.9.11 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The domain scheduler spews out a lot of information at boot up, but it looks
mostly redundant because it's just a transformation of what is in /proc/cpuinfo
anyways. Also it is well tested now. Disable it.

diff -u linux/kernel/sched.c-o linux/kernel/sched.c
--- linux/kernel/sched.c-o	2004-06-01 19:19:58.000000000 +0200
+++ linux/kernel/sched.c	2004-06-01 19:26:56.000000000 +0200
@@ -3641,7 +3641,7 @@
 #endif /* CONFIG_NUMA_SCHED */
 #endif /* ARCH_HAS_SCHED_DOMAIN */
 
-#define SCHED_DOMAIN_DEBUG
+#undef SCHED_DOMAIN_DEBUG
 #ifdef SCHED_DOMAIN_DEBUG
 void sched_domain_debug(void)
 {
