Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932255AbWCPDaX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932255AbWCPDaX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Mar 2006 22:30:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932259AbWCPDaX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Mar 2006 22:30:23 -0500
Received: from fgwmail7.fujitsu.co.jp ([192.51.44.37]:4775 "EHLO
	fgwmail7.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S932255AbWCPDaW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Mar 2006 22:30:22 -0500
Date: Thu, 16 Mar 2006 12:28:45 +0900
From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>
Subject: [PATCH] for_each_possible_cpu [8/19] for arm
Message-Id: <20060316122845.54a6197c.kamezawa.hiroyu@jp.fujitsu.com>
Organization: Fujitsu
X-Mailer: Sylpheed version 2.2.0 (GTK+ 2.6.7; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch replaces for_each_cpu with for_each_possible_cpu.

Signed-Off-By: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>

Index: linux-2.6.16-rc6-mm1/arch/arm/kernel/setup.c
===================================================================
--- linux-2.6.16-rc6-mm1.orig/arch/arm/kernel/setup.c
+++ linux-2.6.16-rc6-mm1/arch/arm/kernel/setup.c
@@ -799,7 +799,7 @@ static int __init topology_init(void)
 {
 	int cpu;
 
-	for_each_cpu(cpu)
+	for_each_possible_cpu(cpu)
 		register_cpu(&per_cpu(cpu_data, cpu).cpu, cpu, NULL);
 
 	return 0;
