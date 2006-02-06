Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751072AbWBFKwO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751072AbWBFKwO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Feb 2006 05:52:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751073AbWBFKwO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Feb 2006 05:52:14 -0500
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36]:27842 "EHLO
	fgwmail6.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S1751070AbWBFKwO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Feb 2006 05:52:14 -0500
Message-ID: <43E72AAC.8030502@jp.fujitsu.com>
Date: Mon, 06 Feb 2006 19:53:32 +0900
From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [RFC][PATCH] unify pfn_to_page [5/25] cris pfn_to_page/page_to_pfn
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Use generic ones.
Signed-Off-By: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>

Index: cleanup_pfn_page/include/asm-cris/page.h
===================================================================
--- cleanup_pfn_page.orig/include/asm-cris/page.h
+++ cleanup_pfn_page/include/asm-cris/page.h
@@ -43,8 +43,7 @@ typedef struct { unsigned long pgprot; }

  /* On CRIS the PFN numbers doesn't start at 0 so we have to compensate */
  /* for that before indexing into the page table starting at mem_map    */
-#define pfn_to_page(pfn)	(mem_map + ((pfn) - (PAGE_OFFSET >> PAGE_SHIFT)))
-#define page_to_pfn(page)	((unsigned long)((page) - mem_map) + (PAGE_OFFSET >> PAGE_SHIFT))
+#define ARCH_PFN_OFFSET		(PAGE_OFFSET >> PAGE_SHIFT)
  #define pfn_valid(pfn)		(((pfn) - (PAGE_OFFSET >> PAGE_SHIFT)) < max_mapnr)

  /* to index into the page map. our pages all start at physical addr PAGE_OFFSET so

