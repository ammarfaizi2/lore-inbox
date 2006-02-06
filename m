Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750745AbWBFLPQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750745AbWBFLPQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Feb 2006 06:15:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750780AbWBFLPP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Feb 2006 06:15:15 -0500
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:14766 "EHLO
	fgwmail5.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S1750745AbWBFLPO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Feb 2006 06:15:14 -0500
Message-ID: <43E73005.5090901@jp.fujitsu.com>
Date: Mon, 06 Feb 2006 20:16:21 +0900
From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [RFC][PATCH] unify pfn_to_page [19/25]  sh64  pfn_to_page/page_to_pfn
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

sh64 can use generic ones.

Signed-Off-By: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>

Index: cleanup_pfn_page/include/asm-sh64/page.h
===================================================================
--- cleanup_pfn_page.orig/include/asm-sh64/page.h
+++ cleanup_pfn_page/include/asm-sh64/page.h
@@ -105,9 +105,8 @@ typedef struct { unsigned long pgprot; }

  /* PFN start number, because of __MEMORY_START */
  #define PFN_START		(__MEMORY_START >> PAGE_SHIFT)
+#define ARCH_PFN_OFFSET		PFN_START

-#define pfn_to_page(pfn)	(mem_map + (pfn) - PFN_START)
-#define page_to_pfn(page)	((unsigned long)((page) - mem_map) + PFN_START)
  #define virt_to_page(kaddr)	pfn_to_page(__pa(kaddr) >> PAGE_SHIFT)
  #define pfn_valid(pfn)		(((pfn) - PFN_START) < max_mapnr)
  #define virt_addr_valid(kaddr)	pfn_valid(__pa(kaddr) >> PAGE_SHIFT)

