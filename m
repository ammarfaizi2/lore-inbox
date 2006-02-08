Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030571AbWBHGUN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030571AbWBHGUN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Feb 2006 01:20:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030570AbWBHGUN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Feb 2006 01:20:13 -0500
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:43912 "EHLO
	fgwmail5.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S1030560AbWBHGUL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Feb 2006 01:20:11 -0500
Message-ID: <43E98DED.2020902@jp.fujitsu.com>
Date: Wed, 08 Feb 2006 15:21:33 +0900
From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
CC: linux390@de.ibm.com
Subject: [PATCH] unify pfn_to_page take 2 [18/25] s390 funcs
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

s390 can use generic ones.

Signed-Off-By: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>

Index: test-layout-free-zone/include/asm-s390/page.h
===================================================================
--- test-layout-free-zone.orig/include/asm-s390/page.h
+++ test-layout-free-zone/include/asm-s390/page.h
@@ -181,8 +181,6 @@ page_get_storage_key(unsigned long addr)
  #define PAGE_OFFSET             0x0UL
  #define __pa(x)                 (unsigned long)(x)
  #define __va(x)                 (void *)(unsigned long)(x)
-#define pfn_to_page(pfn)	(mem_map + (pfn))
-#define page_to_pfn(page)	((unsigned long)((page) - mem_map))
  #define virt_to_page(kaddr)	pfn_to_page(__pa(kaddr) >> PAGE_SHIFT)

  #define pfn_valid(pfn)		((pfn) < max_mapnr)

