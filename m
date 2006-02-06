Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932079AbWBFLMP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932079AbWBFLMP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Feb 2006 06:12:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932080AbWBFLMP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Feb 2006 06:12:15 -0500
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36]:59615 "EHLO
	fgwmail6.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S932079AbWBFLMN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Feb 2006 06:12:13 -0500
Message-ID: <43E72F69.404@jp.fujitsu.com>
Date: Mon, 06 Feb 2006 20:13:45 +0900
From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [RFC][PATCH] unify pfn_to_page [17/25]  s390  pfn_to_page/page_to_pfn
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

s390 can use generic ones.

Signed-Off-By: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
Index: cleanup_pfn_page/include/asm-s390/page.h
===================================================================
--- cleanup_pfn_page.orig/include/asm-s390/page.h
+++ cleanup_pfn_page/include/asm-s390/page.h
@@ -181,8 +181,6 @@ page_get_storage_key(unsigned long addr)
  #define PAGE_OFFSET             0x0UL
  #define __pa(x)                 (unsigned long)(x)
  #define __va(x)                 (void *)(unsigned long)(x)
-#define pfn_to_page(pfn)	(mem_map + (pfn))
-#define page_to_pfn(page)	((unsigned long)((page) - mem_map))
  #define virt_to_page(kaddr)	pfn_to_page(__pa(kaddr) >> PAGE_SHIFT)

  #define pfn_valid(pfn)		((pfn) < max_mapnr)

