Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751872AbWEPQus@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751872AbWEPQus (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 May 2006 12:50:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751873AbWEPQus
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 May 2006 12:50:48 -0400
Received: from e35.co.us.ibm.com ([32.97.110.153]:53736 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751872AbWEPQuq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 May 2006 12:50:46 -0400
Date: Tue, 16 May 2006 09:50:40 -0700
From: Nishanth Aravamudan <nacc@us.ibm.com>
To: akpm@osdl.org
Cc: haveblue@us.ibm.com, LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] typo in i386/init.c [BugMe #6538]
Message-ID: <20060516165040.GA4341@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

Resending, since I haven't heard anything back yet.

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
