Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932101AbWHHD0T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932101AbWHHD0T (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Aug 2006 23:26:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932129AbWHHD0T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Aug 2006 23:26:19 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:51082 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S932101AbWHHD0S (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Aug 2006 23:26:18 -0400
Subject: [PATCH 2 of 2] cpumask: use EXPORT_SYMBOL_GPL for new exports
From: Greg Banks <gnb@melbourne.sgi.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Linux NFS Mailing List <nfs@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Organization: Silicon Graphics Inc, Australian Software Group.
Message-Id: <1155007561.29877.217.camel@hole.melbourne.sgi.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Tue, 08 Aug 2006 13:26:01 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

cpumask: use EXPORT_SYMBOL_GPL instead of EXPORT_SYMBOL to export
cpu_possible_map and cpu_online_map.  Thanks to Zwane Mwaikambo
for pointing this out.

Signed-off-by: Greg Banks <gnb@melbourne.sgi.com>
---

 arch/arm/kernel/smp.c           |    4 ++--
 arch/cris/arch-v32/kernel/smp.c |    2 +-
 arch/sh/kernel/smp.c            |    2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

Index: linux-2.6.18-rc2/arch/arm/kernel/smp.c
===================================================================
--- linux-2.6.18-rc2.orig/arch/arm/kernel/smp.c
+++ linux-2.6.18-rc2/arch/arm/kernel/smp.c
@@ -36,9 +36,9 @@
  * The online bitmask indicates that the CPU is up and running.
  */
 cpumask_t cpu_possible_map;
-EXPORT_SYMBOL(cpu_possible_map);
+EXPORT_SYMBOL_GPL(cpu_possible_map);
 cpumask_t cpu_online_map;
-EXPORT_SYMBOL(cpu_online_map);
+EXPORT_SYMBOL_GPL(cpu_online_map);
 
 /*
  * as from 2.5, kernels no longer have an init_tasks structure
Index: linux-2.6.18-rc2/arch/cris/arch-v32/kernel/smp.c
===================================================================
--- linux-2.6.18-rc2.orig/arch/cris/arch-v32/kernel/smp.c
+++ linux-2.6.18-rc2/arch/cris/arch-v32/kernel/smp.c
@@ -28,7 +28,7 @@ spinlock_t cris_atomic_locks[] = { [0 ..
 
 /* CPU masks */
 cpumask_t cpu_online_map = CPU_MASK_NONE;
-EXPORT_SYMBOL(cpu_online_map);
+EXPORT_SYMBOL_GPL(cpu_online_map);
 cpumask_t phys_cpu_present_map = CPU_MASK_NONE;
 EXPORT_SYMBOL(phys_cpu_present_map);
 
Index: linux-2.6.18-rc2/arch/sh/kernel/smp.c
===================================================================
--- linux-2.6.18-rc2.orig/arch/sh/kernel/smp.c
+++ linux-2.6.18-rc2/arch/sh/kernel/smp.c
@@ -42,7 +42,7 @@ cpumask_t cpu_possible_map;
 EXPORT_SYMBOL(cpu_possible_map);
 
 cpumask_t cpu_online_map;
-EXPORT_SYMBOL(cpu_online_map);
+EXPORT_SYMBOL_GPL(cpu_online_map);
 static atomic_t cpus_booted = ATOMIC_INIT(0);
 
 /* These are defined by the board-specific code. */


Greg.
-- 
Greg Banks, R&D Software Engineer, SGI Australian Software Group.
I don't speak for SGI.


