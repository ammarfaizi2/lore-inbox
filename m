Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161001AbWBHGZr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161001AbWBHGZr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Feb 2006 01:25:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161002AbWBHGZr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Feb 2006 01:25:47 -0500
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36]:17082 "EHLO
	fgwmail6.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S1161001AbWBHGZq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Feb 2006 01:25:46 -0500
Message-ID: <43E98F38.20704@jp.fujitsu.com>
Date: Wed, 08 Feb 2006 15:27:04 +0900
From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
CC: linuxsh-shmedia-dev@lists.sourceforge.net
Subject: [PATCH]  unify pfn_to_page take 2 [20/25] sh64 funcs
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

sh64 can use generic funcs.

Signed-Off-By: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>

Index: test-layout-free-zone/include/asm-sh64/page.h
===================================================================
--- test-layout-free-zone.orig/include/asm-sh64/page.h
+++ test-layout-free-zone/include/asm-sh64/page.h
@@ -105,9 +105,7 @@ typedef struct { unsigned long pgprot; }

  /* PFN start number, because of __MEMORY_START */
  #define PFN_START		(__MEMORY_START >> PAGE_SHIFT)
-
-#define pfn_to_page(pfn)	(mem_map + (pfn) - PFN_START)
-#define page_to_pfn(page)	((unsigned long)((page) - mem_map) + PFN_START)
+#define ARCH_PFN_OFFSET		(PFN_START)
  #define virt_to_page(kaddr)	pfn_to_page(__pa(kaddr) >> PAGE_SHIFT)
  #define pfn_valid(pfn)		(((pfn) - PFN_START) < max_mapnr)
  #define virt_addr_valid(kaddr)	pfn_valid(__pa(kaddr) >> PAGE_SHIFT)

