Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261354AbUL2PXs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261354AbUL2PXs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Dec 2004 10:23:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261357AbUL2PXs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Dec 2004 10:23:48 -0500
Received: from dbl.q-ag.de ([213.172.117.3]:50820 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id S261354AbUL2PXr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Dec 2004 10:23:47 -0500
Date: Wed, 29 Dec 2004 16:23:26 +0100 (CET)
From: Manfred Spraul <manfred@colorfullife.com>
X-X-Sender: manfred@dbl.q-ag.de
To: akpm@osdl.org
cc: bunk@susta.de, <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/2 2.6.10] rcu: make two internal structs static
Message-ID: <Pine.LNX.4.44.0412291621090.7011-100000@dbl.q-ag.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch below makes two needlessly global structs static.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

Tested with 2.6.10, no rediff required.
Signed-off-by: Manfred Spraul <manfred@colorfullife.com>

--- linux-2.6.10-rc2-mm4-full/kernel/rcupdate.c.old	2004-12-12 03:13:54.000000000 +0100
+++ linux-2.6.10-rc2-mm4-full/kernel/rcupdate.c	2004-12-12 03:14:15.000000000 +0100
@@ -60,9 +60,9 @@
 	                              /* for current batch to proceed.        */
 };

-struct rcu_state rcu_state ____cacheline_maxaligned_in_smp =
+static struct rcu_state rcu_state ____cacheline_maxaligned_in_smp =
 	  {.lock = SPIN_LOCK_UNLOCKED, .cpumask = CPU_MASK_NONE };
-struct rcu_state rcu_bh_state ____cacheline_maxaligned_in_smp =
+static struct rcu_state rcu_bh_state ____cacheline_maxaligned_in_smp =
 	  {.lock = SPIN_LOCK_UNLOCKED, .cpumask = CPU_MASK_NONE };

 DEFINE_PER_CPU(struct rcu_data, rcu_data) = { 0L };

