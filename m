Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750832AbWBFLT4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750832AbWBFLT4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Feb 2006 06:19:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750892AbWBFLT4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Feb 2006 06:19:56 -0500
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36]:52713 "EHLO
	fgwmail6.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S1750832AbWBFLTz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Feb 2006 06:19:55 -0500
Message-ID: <43E7312F.9060107@jp.fujitsu.com>
Date: Mon, 06 Feb 2006 20:21:19 +0900
From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [RFC][PATCH] unify pfn_to_page [23/25]  xtensa  pfn_to_page/page_to_pfn
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

xtensa can use generic ones.

Signed-Off-By: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>

Index: cleanup_pfn_page/include/asm-xtensa/page.h
===================================================================
--- cleanup_pfn_page.orig/include/asm-xtensa/page.h
+++ cleanup_pfn_page/include/asm-xtensa/page.h
@@ -109,10 +109,7 @@ void copy_user_page(void *to,void* from,
  #define __pa(x)			((unsigned long) (x) - PAGE_OFFSET)
  #define __va(x)			((void *)((unsigned long) (x) + PAGE_OFFSET))
  #define pfn_valid(pfn)		((unsigned long)pfn < max_mapnr)
-#ifndef CONFIG_DISCONTIGMEM
-# define pfn_to_page(pfn)	(mem_map + (pfn))
-# define page_to_pfn(page)	((unsigned long)((page) - mem_map))
-#else
+#ifdef CONFIG_DISCONTIGMEM
  # error CONFIG_DISCONTIGMEM not supported
  #endif


