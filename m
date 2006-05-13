Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932454AbWEMPtP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932454AbWEMPtP (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 May 2006 11:49:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932456AbWEMPtO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 May 2006 11:49:14 -0400
Received: from e6.ny.us.ibm.com ([32.97.182.146]:9445 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932454AbWEMPtO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 May 2006 11:49:14 -0400
Date: Sat, 13 May 2006 08:49:07 -0700
From: Nishanth Aravamudan <nacc@us.ibm.com>
To: akpm@osdl.org
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] typo in i386/init.c [BugMe #6538]
Message-ID: <20060513154907.GC4220@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Operating-System: Linux 2.6.17-rc4 (x86_64)
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

Description: Fix a small typo in arch/i386/mm/init.c. Confirmed to fix
BugMe #6538.

Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>

diff -urpN 2.6.17-rc4/arch/i386/mm/init.c 2.6.17-rc4-dev/arch/i386/mm/init.c
--- 2.6.17-rc4/arch/i386/mm/init.c	2006-05-12 10:26:59.000000000 -0700
+++ 2.6.17-rc4-dev/arch/i386/mm/init.c	2006-05-12 13:49:38.000000000 -0700
@@ -651,7 +651,7 @@ void __init mem_init(void)
  * Specifically, in the case of x86, we will always add
  * memory to the highmem for now.
  */
-#ifdef CONFIG_HOTPLUG_MEMORY
+#ifdef CONFIG_MEMORY_HOTPLUG
 #ifndef CONFIG_NEED_MULTIPLE_NODES
 int add_memory(u64 start, u64 size)
 {

-- 
Nishanth Aravamudan <nacc@us.ibm.com>
IBM Linux Technology Center
