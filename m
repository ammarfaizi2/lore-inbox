Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030572AbWBHGiS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030572AbWBHGiS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Feb 2006 01:38:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030569AbWBHGiS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Feb 2006 01:38:18 -0500
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36]:47563 "EHLO
	fgwmail6.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S1030572AbWBHGiR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Feb 2006 01:38:17 -0500
Message-ID: <43E9920A.9020505@jp.fujitsu.com>
Date: Wed, 08 Feb 2006 15:39:06 +0900
From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
CC: uclinux-v850@lsi.nec.co.jp
Subject: [PATCH] unify pfn_to_page take 2 [24/25] v850 funcs
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

v850 can use generic ones.

Signed-Off-By: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>

Index: test-layout-free-zone/include/asm-v850/page.h
===================================================================
--- test-layout-free-zone.orig/include/asm-v850/page.h
+++ test-layout-free-zone/include/asm-v850/page.h
@@ -111,8 +111,7 @@ typedef unsigned long pgprot_t;
  #define page_to_virt(page) \
    ((((page) - mem_map) << PAGE_SHIFT) + PAGE_OFFSET)

-#define pfn_to_page(pfn)	virt_to_page (pfn_to_virt (pfn))
-#define page_to_pfn(page)	virt_to_pfn (page_to_virt (page))
+#define ARCH_PFN_OFFSET		(PAGE_OFFSET >> PAGE_SHIFT)
  #define pfn_valid(pfn)	        ((pfn) < max_mapnr)

  #define	virt_addr_valid(kaddr)						\

