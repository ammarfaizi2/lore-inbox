Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030568AbWBHGSK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030568AbWBHGSK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Feb 2006 01:18:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030565AbWBHGSK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Feb 2006 01:18:10 -0500
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36]:5041 "EHLO
	fgwmail6.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S1030568AbWBHGSJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Feb 2006 01:18:09 -0500
Message-ID: <43E98D7B.2000401@jp.fujitsu.com>
Date: Wed, 08 Feb 2006 15:19:39 +0900
From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
CC: linuxppc-dev@ozlabs.org
Subject: [PATCH] unify pfn_to_page take 2 [17/25] ppc funcs
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ppc can use generic funcs.

Signed-Off-By: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>

Index: test-layout-free-zone/include/asm-ppc/page.h
===================================================================
--- test-layout-free-zone.orig/include/asm-ppc/page.h
+++ test-layout-free-zone/include/asm-ppc/page.h
@@ -148,9 +148,7 @@ extern int page_is_ram(unsigned long pfn

  #define __pa(x) ___pa((unsigned long)(x))
  #define __va(x) ((void *)(___va((unsigned long)(x))))
-
-#define pfn_to_page(pfn)	(mem_map + ((pfn) - PPC_PGSTART))
-#define page_to_pfn(page)	((unsigned long)((page) - mem_map) + PPC_PGSTART)
+#define ARCH_PFN_OFFSET		PPC_PGSTART
  #define virt_to_page(kaddr)	pfn_to_page(__pa(kaddr) >> PAGE_SHIFT)
  #define page_to_virt(page)	__va(page_to_pfn(page) << PAGE_SHIFT)


