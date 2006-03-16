Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932614AbWCPDor@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932614AbWCPDor (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Mar 2006 22:44:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932615AbWCPDor
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Mar 2006 22:44:47 -0500
Received: from fgwmail7.fujitsu.co.jp ([192.51.44.37]:63920 "EHLO
	fgwmail7.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S932614AbWCPDoq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Mar 2006 22:44:46 -0500
Date: Thu, 16 Mar 2006 12:43:33 +0900
From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>
Subject: [PATCH/DOC ] for_each_possible_cpu  documentaion [1/1]
Message-Id: <20060316124333.6fe40a86.kamezawa.hiroyu@jp.fujitsu.com>
Organization: Fujitsu
X-Mailer: Sylpheed version 2.2.0 (GTK+ 2.6.7; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch replaces for_each_cpu with for_each_possible_cpu.

Modifies occurences in documentaion.

for_each_cpu in whatisRCU.txt should be for_each_online_cpu ???
(I'm not sure..)

Signed-Off-By: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>


Index: linux-2.6.16-rc6-mm1/Documentation/RCU/whatisRCU.txt
===================================================================
--- linux-2.6.16-rc6-mm1.orig/Documentation/RCU/whatisRCU.txt
+++ linux-2.6.16-rc6-mm1/Documentation/RCU/whatisRCU.txt
@@ -605,7 +605,7 @@ are the same as those shown in the prece
 	{
 		int cpu;
 
-		for_each_cpu(cpu)
+		for_each_possible_cpu(cpu)
 			run_on(cpu);
 	}
 
Index: linux-2.6.16-rc6-mm1/Documentation/cpu-hotplug.txt
===================================================================
--- linux-2.6.16-rc6-mm1.orig/Documentation/cpu-hotplug.txt
+++ linux-2.6.16-rc6-mm1/Documentation/cpu-hotplug.txt
@@ -97,13 +97,13 @@ at which time hotplug is disabled.
 
 You really dont need to manipulate any of the system cpu maps. They should
 be read-only for most use. When setting up per-cpu resources almost always use
-cpu_possible_map/for_each_cpu() to iterate.
+cpu_possible_map/for_each_possible_cpu() to iterate.
 
 Never use anything other than cpumask_t to represent bitmap of CPUs.
 
 #include <linux/cpumask.h>
 
-for_each_cpu              - Iterate over cpu_possible_map
+for_each_possible_cpu     - Iterate over cpu_possible_map
 for_each_online_cpu       - Iterate over cpu_online_map
 for_each_present_cpu      - Iterate over cpu_present_map
 for_each_cpu_mask(x,mask) - Iterate over some random collection of cpu mask.
