Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750780AbWBFLR5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750780AbWBFLR5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Feb 2006 06:17:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750893AbWBFLR5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Feb 2006 06:17:57 -0500
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:20913 "EHLO
	fgwmail5.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S1750780AbWBFLR4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Feb 2006 06:17:56 -0500
Message-ID: <43E730A3.1000906@jp.fujitsu.com>
Date: Mon, 06 Feb 2006 20:18:59 +0900
From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [RFC][PATCH] unify pfn_to_page [21/25]    v850 pfn_to_page/page_to_pfn
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

v850 can use generic ones.

Signed-Off-By: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>

Index: cleanup_pfn_page/include/asm-v850/page.h
===================================================================
--- cleanup_pfn_page.orig/include/asm-v850/page.h
+++ cleanup_pfn_page/include/asm-v850/page.h
@@ -111,8 +111,7 @@ typedef unsigned long pgprot_t;
  #define page_to_virt(page) \
    ((((page) - mem_map) << PAGE_SHIFT) + PAGE_OFFSET)

-#define pfn_to_page(pfn)	virt_to_page (pfn_to_virt (pfn))
-#define page_to_pfn(page)	virt_to_pfn (page_to_virt (page))
+#define ARCH_PFN_OFFSET		(PAGE_OFFSET >> PAGE_SHIFT)
  #define pfn_valid(pfn)	        ((pfn) < max_mapnr)

  #define	virt_addr_valid(kaddr)						\

