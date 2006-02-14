Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750865AbWBNKBP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750865AbWBNKBP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Feb 2006 05:01:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750907AbWBNKBP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Feb 2006 05:01:15 -0500
Received: from fgwmail7.fujitsu.co.jp ([192.51.44.37]:29346 "EHLO
	fgwmail7.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S1750865AbWBNKBO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Feb 2006 05:01:14 -0500
Message-ID: <43F1AAB5.8050202@jp.fujitsu.com>
Date: Tue, 14 Feb 2006 19:02:29 +0900
From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
CC: linuxppc-dev@ozlabs.org, Andrew Morton <akpm@osdl.org>
Subject: [PATCH] unify pfn_to_page take3 [4/23] powerpc pfn_to_page
References: <43F1A753.2020003@jp.fujitsu.com>
In-Reply-To: <43F1A753.2020003@jp.fujitsu.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

PowerPC can use generic ones.

Signed-Off-By: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>

Index: testtree/include/asm-powerpc/page.h
===================================================================
--- testtree.orig/include/asm-powerpc/page.h
+++ testtree/include/asm-powerpc/page.h
@@ -69,8 +69,6 @@
  #endif

  #ifdef CONFIG_FLATMEM
-#define pfn_to_page(pfn)	(mem_map + (pfn))
-#define page_to_pfn(page)	((unsigned long)((page) - mem_map))
  #define pfn_valid(pfn)		((pfn) < max_mapnr)
  #endif

@@ -200,6 +198,7 @@ extern void copy_user_page(void *to, voi
  		struct page *p);
  extern int page_is_ram(unsigned long pfn);

+#include <asm-generic/memory_model.h>
  #endif /* __ASSEMBLY__ */

  #endif /* __KERNEL__ */

