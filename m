Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263088AbTJQCRn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Oct 2003 22:17:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263277AbTJQCRn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Oct 2003 22:17:43 -0400
Received: from fmr05.intel.com ([134.134.136.6]:56035 "EHLO
	hermes.jf.intel.com") by vger.kernel.org with ESMTP id S263088AbTJQCRm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Oct 2003 22:17:42 -0400
Date: Thu, 16 Oct 2003 19:17:00 -0700
Message-Id: <200310170217.h9H2H0WK016382@penguin.co.intel.com>
From: Rusty Lynch <rusty@linux.co.intel.com>
To: eranian@hpl.hp.com
CC: linux-kernel@vger.kernel.org
Subject: [2.6.0-test7 PATCH] Itanium build broke
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Your latest change to perfmon.c has a typo that breaks itanium builds.

Here is a quick patch. 

--- arch/ia64/kernel/perfmon.c.orig	2003-10-16 19:09:38.000000000 -0700
+++ arch/ia64/kernel/perfmon.c	2003-10-16 19:08:35.000000000 -0700
@@ -6000,7 +6000,7 @@
 		/*
 		 * will replay the PMU interrupt
 		 */
-		DRPINT(("perfmon: resend irq for [%d]\n", task->pid));
+		DPRINT(("perfmon: resend irq for [%d]\n", task->pid));
 		hw_resend_irq(NULL, IA64_PERFMON_VECTOR);
 #endif
 		pfm_stats[smp_processor_id()].pfm_replay_ovfl_intr_count++;
@@ -6144,7 +6144,7 @@
 		/*
 		 * will replay the PMU interrupt
 		 */
-		DRPINT(("perfmon: resend irq for [%d]\n", task->pid));
+		DPRINT(("perfmon: resend irq for [%d]\n", task->pid));
 		hw_resend_irq(NULL, IA64_PERFMON_VECTOR);
 #endif
 		pfm_stats[smp_processor_id()].pfm_replay_ovfl_intr_count++;
