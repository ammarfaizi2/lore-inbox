Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932069AbWHHD0M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932069AbWHHD0M (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Aug 2006 23:26:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932101AbWHHD0L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Aug 2006 23:26:11 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:49802 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S932069AbWHHD0K (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Aug 2006 23:26:10 -0400
Subject: [PATCH 1 of 2] cpumask: use EXPORT_SYMBOL_GPL for new exports
From: Greg Banks <gnb@melbourne.sgi.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Linux NFS Mailing List <nfs@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Organization: Silicon Graphics Inc, Australian Software Group.
Message-Id: <1155007534.29877.215.camel@hole.melbourne.sgi.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Tue, 08 Aug 2006 13:25:34 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

cpumask: use EXPORT_SYMBOL_GPL instead of EXPORT_SYMBOL to export
node_2_cpu_mask.  Thanks to Zwane Mwaikambo for pointing this out.

Signed-off-by: Greg Banks <gnb@melbourne.sgi.com>
---

 arch/i386/kernel/smpboot.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

Index: linux-2.6.18-rc2/arch/i386/kernel/smpboot.c
===================================================================
--- linux-2.6.18-rc2.orig/arch/i386/kernel/smpboot.c
+++ linux-2.6.18-rc2/arch/i386/kernel/smpboot.c
@@ -609,7 +609,7 @@ extern struct {
 /* which logical CPUs are on which nodes */
 cpumask_t node_2_cpu_mask[MAX_NUMNODES] __read_mostly =
 				{ [0 ... MAX_NUMNODES-1] = CPU_MASK_NONE };
-EXPORT_SYMBOL(node_2_cpu_mask);
+EXPORT_SYMBOL_GPL(node_2_cpu_mask);
 /* which node each logical CPU is on */
 int cpu_2_node[NR_CPUS] __read_mostly = { [0 ... NR_CPUS-1] = 0 };
 EXPORT_SYMBOL(cpu_2_node);


Greg.
-- 
Greg Banks, R&D Software Engineer, SGI Australian Software Group.
I don't speak for SGI.


