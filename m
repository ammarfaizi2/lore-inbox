Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751063AbWBFKvG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751063AbWBFKvG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Feb 2006 05:51:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751070AbWBFKvG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Feb 2006 05:51:06 -0500
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:21129 "EHLO
	fgwmail5.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S1751069AbWBFKvF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Feb 2006 05:51:05 -0500
Message-ID: <43E72A64.4060601@jp.fujitsu.com>
Date: Mon, 06 Feb 2006 19:52:20 +0900
From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [RFC][PATCH] unify pfn_to_page [4/25] arm26 pfn_to_page/page_to_pfn
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

arm26 can use generic ones.

Signed-Off-By: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>

Index: cleanup_pfn_page/include/asm-arm26/memory.h
===================================================================
--- cleanup_pfn_page.orig/include/asm-arm26/memory.h
+++ cleanup_pfn_page/include/asm-arm26/memory.h
@@ -81,9 +81,7 @@ static inline void *phys_to_virt(unsigne
   *  virt_to_page(k)	convert a _valid_ virtual address to struct page *
   *  virt_addr_valid(k)	indicates whether a virtual address is valid
   */
-#define page_to_pfn(page)	(((page) - mem_map) + PHYS_PFN_OFFSET)
-#define pfn_to_page(pfn)	((mem_map + (pfn)) - PHYS_PFN_OFFSET)
-#define pfn_valid(pfn)		((pfn) >= PHYS_PFN_OFFSET && (pfn) < (PHYS_PFN_OFFSET + max_mapnr))
+#define ARCH_PFN_OFFSET		(PHYS_PFN_OFFSET)

  #define virt_to_page(kaddr)	(pfn_to_page(__pa(kaddr) >> PAGE_SHIFT))
  #define virt_addr_valid(kaddr)	((int)(kaddr) >= PAGE_OFFSET && (int)(kaddr) < (unsigned long)high_memory)

