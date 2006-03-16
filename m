Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932268AbWCPDck@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932268AbWCPDck (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Mar 2006 22:32:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932269AbWCPDck
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Mar 2006 22:32:40 -0500
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:3006 "EHLO
	fgwmail5.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S932270AbWCPDcj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Mar 2006 22:32:39 -0500
Date: Thu, 16 Mar 2006 12:31:35 +0900
From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>
Subject: [PATCH] for_each_possible_cpu [11/19] mips
Message-Id: <20060316123135.4ac81f9e.kamezawa.hiroyu@jp.fujitsu.com>
Organization: Fujitsu
X-Mailer: Sylpheed version 2.2.0 (GTK+ 2.6.7; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch replaces for_each_cpu with for_each_possible_cpu.
BTW, mips doesn't support HOTPLUC_CPU...

Signed-Off-By: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>


Index: linux-2.6.16-rc6-mm1/arch/mips/kernel/smp.c
===================================================================
--- linux-2.6.16-rc6-mm1.orig/arch/mips/kernel/smp.c
+++ linux-2.6.16-rc6-mm1/arch/mips/kernel/smp.c
@@ -432,7 +432,7 @@ static int __init topology_init(void)
 	int cpu;
 	int ret;
 
-	for_each_cpu(cpu) {
+	for_each_possible_cpu(cpu) {
 		ret = register_cpu(&per_cpu(cpu_devices, cpu), cpu, NULL);
 		if (ret)
 			printk(KERN_WARNING "topology_init: register_cpu %d "
