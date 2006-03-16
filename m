Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932346AbWCPDgF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932346AbWCPDgF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Mar 2006 22:36:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932309AbWCPDgF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Mar 2006 22:36:05 -0500
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36]:39112 "EHLO
	fgwmail6.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S932341AbWCPDgC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Mar 2006 22:36:02 -0500
Date: Thu, 16 Mar 2006 12:34:47 +0900
From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>
Subject: [PATCH] for_each_possible_cpu [15/19] sh
Message-Id: <20060316123447.0440b081.kamezawa.hiroyu@jp.fujitsu.com>
Organization: Fujitsu
X-Mailer: Sylpheed version 2.2.0 (GTK+ 2.6.7; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch replaces for_each_cpu with for_each_possible_cpu.

Signed-Off-By: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>

Index: linux-2.6.16-rc6-mm1/arch/sh/kernel/setup.c
===================================================================
--- linux-2.6.16-rc6-mm1.orig/arch/sh/kernel/setup.c
+++ linux-2.6.16-rc6-mm1/arch/sh/kernel/setup.c
@@ -404,7 +404,7 @@ static int __init topology_init(void)
 {
 	int cpu_id;
 
-	for_each_cpu(cpu_id)
+	for_each_possible_cpu(cpu_id)
 		register_cpu(&cpu[cpu_id], cpu_id, NULL);
 
 	return 0;
