Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261877AbULLT6q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261877AbULLT6q (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Dec 2004 14:58:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262102AbULLT6Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Dec 2004 14:58:25 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:22034 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S262121AbULLT5O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Dec 2004 14:57:14 -0500
Date: Sun, 12 Dec 2004 20:56:59 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Dipankar Sarma <dipankar@in.ibm.com>,
       Manfred Spraul <manfred@colorfullife.com>
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] kernel/rcupdate.c: make two struct static.
Message-ID: <20041212195659.GL22324@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch below makes two needlessly global structs static.


Signed-off-by: Adrian Bunk <bunk@stusta.de>

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

