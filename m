Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030543AbWBHFwu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030543AbWBHFwu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Feb 2006 00:52:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030544AbWBHFwu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Feb 2006 00:52:50 -0500
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:55500 "EHLO
	fgwmail5.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S1030543AbWBHFwt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Feb 2006 00:52:49 -0500
Message-ID: <43E98784.1070604@jp.fujitsu.com>
Date: Wed, 08 Feb 2006 14:54:12 +0900
From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
CC: spyro@f2s.com
Subject: [PATCH] unify pfn_to_page take 2 [7/25] arm26 funcs
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

arm26 can use generic funcs.

Signed-Off-By: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>

Index: test-layout-free-zone/include/asm-arm26/memory.h
===================================================================
--- test-layout-free-zone.orig/include/asm-arm26/memory.h
+++ test-layout-free-zone/include/asm-arm26/memory.h
@@ -81,8 +81,7 @@ static inline void *phys_to_virt(unsigne
   *  virt_to_page(k)	convert a _valid_ virtual address to struct page *
   *  virt_addr_valid(k)	indicates whether a virtual address is valid
   */
-#define page_to_pfn(page)	(((page) - mem_map) + PHYS_PFN_OFFSET)
-#define pfn_to_page(pfn)	((mem_map + (pfn)) - PHYS_PFN_OFFSET)
+#define ARCH_PFN_OFFSET		(PHYS_PFN_OFFSET)
  #define pfn_valid(pfn)		((pfn) >= PHYS_PFN_OFFSET && (pfn) < (PHYS_PFN_OFFSET + max_mapnr))

  #define virt_to_page(kaddr)	(pfn_to_page(__pa(kaddr) >> PAGE_SHIFT))

