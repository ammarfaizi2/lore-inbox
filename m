Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932309AbWCPDhF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932309AbWCPDhF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Mar 2006 22:37:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932341AbWCPDhF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Mar 2006 22:37:05 -0500
Received: from fgwmail7.fujitsu.co.jp ([192.51.44.37]:1452 "EHLO
	fgwmail7.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S932309AbWCPDhC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Mar 2006 22:37:02 -0500
Date: Thu, 16 Mar 2006 12:35:40 +0900
From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>
Subject: [PATCH] for_each_possible_cpu [16/19] sparc
Message-Id: <20060316123540.e9e94a43.kamezawa.hiroyu@jp.fujitsu.com>
Organization: Fujitsu
X-Mailer: Sylpheed version 2.2.0 (GTK+ 2.6.7; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch replaces for_each_cpu with for_each_possible_cpu.

Signed-Off-By: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>


Index: linux-2.6.16-rc6-mm1/arch/sparc/kernel/smp.c
===================================================================
--- linux-2.6.16-rc6-mm1.orig/arch/sparc/kernel/smp.c
+++ linux-2.6.16-rc6-mm1/arch/sparc/kernel/smp.c
@@ -243,7 +243,7 @@ int setup_profiling_timer(unsigned int m
 		return -EINVAL;
 
 	spin_lock_irqsave(&prof_setup_lock, flags);
-	for_each_cpu(i) {
+	for_each_possible_cpu(i) {
 		load_profile_irq(i, lvl14_resolution / multiplier);
 		prof_multiplier(i) = multiplier;
 	}
