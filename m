Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751083AbWBFLVP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751083AbWBFLVP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Feb 2006 06:21:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751085AbWBFLVP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Feb 2006 06:21:15 -0500
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36]:55019 "EHLO
	fgwmail6.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S1751083AbWBFLVO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Feb 2006 06:21:14 -0500
Message-ID: <43E7316D.4080804@jp.fujitsu.com>
Date: Mon, 06 Feb 2006 20:22:21 +0900
From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [RFC][PATCH] unify pfn_to_page [24/25]  xtensa  pfn_to_page/page_to_pfn
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

sparc can use generic ones by defining ARCH_PFN_OFFSET as pfn_base

Signed-Off-By: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>

Index: cleanup_pfn_page/include/asm-sparc/page.h
===================================================================
--- cleanup_pfn_page.orig/include/asm-sparc/page.h
+++ cleanup_pfn_page/include/asm-sparc/page.h
@@ -152,8 +152,7 @@ extern unsigned long pfn_base;
  #define virt_to_phys		__pa
  #define phys_to_virt		__va

-#define pfn_to_page(pfn)	(mem_map + ((pfn)-(pfn_base)))
-#define page_to_pfn(page)	((unsigned long)(((page) - mem_map) + pfn_base))
+#define ARCH_PFN_OFFSET		(pfn_base)
  #define virt_to_page(kaddr)	(mem_map + ((((unsigned long)(kaddr)-PAGE_OFFSET)>>PAGE_SHIFT)))

  #define pfn_valid(pfn)		(((pfn) >= (pfn_base)) && (((pfn)-(pfn_base)) < max_mapnr))

