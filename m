Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932071AbWBFLJE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932071AbWBFLJE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Feb 2006 06:09:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932077AbWBFLJD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Feb 2006 06:09:03 -0500
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:21157 "EHLO
	fgwmail5.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S932071AbWBFLJC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Feb 2006 06:09:02 -0500
Message-ID: <43E72EA5.5020401@jp.fujitsu.com>
Date: Mon, 06 Feb 2006 20:10:29 +0900
From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [RFC][PATCH] unify pfn_to_page [15/25]  powerpc pfn_to_page/page_to_pfn
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It looks powerpc never uses CONFIG_DISCONTIGMEM( uses SPARSEMEM ).
just replace FLATMEM case.

Signed-Off-By: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>

Index: cleanup_pfn_page/include/asm-powerpc/page.h
===================================================================
--- cleanup_pfn_page.orig/include/asm-powerpc/page.h
+++ cleanup_pfn_page/include/asm-powerpc/page.h
@@ -69,8 +69,6 @@
  #endif

  #ifdef CONFIG_FLATMEM
-#define pfn_to_page(pfn)	(mem_map + (pfn))
-#define page_to_pfn(page)	((unsigned long)((page) - mem_map))
  #define pfn_valid(pfn)		((pfn) < max_mapnr)
  #endif


