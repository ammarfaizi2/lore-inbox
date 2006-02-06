Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932077AbWBFLLE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932077AbWBFLLE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Feb 2006 06:11:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932079AbWBFLLD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Feb 2006 06:11:03 -0500
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:17832 "EHLO
	fgwmail5.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S932077AbWBFLLB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Feb 2006 06:11:01 -0500
Message-ID: <43E72EF0.4070505@jp.fujitsu.com>
Date: Mon, 06 Feb 2006 20:11:44 +0900
From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [RFC][PATCH] unify pfn_to_page [16/25]  ppc pfn_to_page/page_to_pfn
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ppc can use generic ones.

Signed-Off-By: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>

Index: cleanup_pfn_page/include/asm-ppc/page.h
===================================================================
--- cleanup_pfn_page.orig/include/asm-ppc/page.h
+++ cleanup_pfn_page/include/asm-ppc/page.h
@@ -149,8 +149,7 @@ extern int page_is_ram(unsigned long pfn
  #define __pa(x) ___pa((unsigned long)(x))
  #define __va(x) ((void *)(___va((unsigned long)(x))))

-#define pfn_to_page(pfn)	(mem_map + ((pfn) - PPC_PGSTART))
-#define page_to_pfn(page)	((unsigned long)((page) - mem_map) + PPC_PGSTART)
+#define ARCH_PFN_OFFSET		PPC_PGSTART
  #define virt_to_page(kaddr)	pfn_to_page(__pa(kaddr) >> PAGE_SHIFT)
  #define page_to_virt(page)	__va(page_to_pfn(page) << PAGE_SHIFT)


