Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932069AbWBFLFQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932069AbWBFLFQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Feb 2006 06:05:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932076AbWBFLFP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Feb 2006 06:05:15 -0500
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:31647 "EHLO
	fgwmail5.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S932069AbWBFLFN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Feb 2006 06:05:13 -0500
Message-ID: <43E72DC1.80209@jp.fujitsu.com>
Date: Mon, 06 Feb 2006 20:06:41 +0900
From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [RFC][PATCH] unify pfn_to_page [12/25]  m68knommu  pfn_to_page/page_to_pfn
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Complicated.
don't use generic ones. (but maye can use....??)

Signed-Off-By: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>

Index: cleanup_pfn_page/include/asm-m68knommu/page.h
===================================================================
--- cleanup_pfn_page.orig/include/asm-m68knommu/page.h
+++ cleanup_pfn_page/include/asm-m68knommu/page.h
@@ -68,6 +68,7 @@ extern unsigned long memory_end;
  #define virt_to_page(addr)	(mem_map + (((unsigned long)(addr)-PAGE_OFFSET) >> PAGE_SHIFT))
  #define page_to_virt(page)	((((page) - mem_map) << PAGE_SHIFT) + PAGE_OFFSET)

+#define ARCH_HAS_PFN_PAGE
  #define pfn_to_page(pfn)	virt_to_page(pfn_to_virt(pfn))
  #define page_to_pfn(page)	virt_to_pfn(page_to_virt(page))
  #define pfn_valid(pfn)	        ((pfn) < max_mapnr)

