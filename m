Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030547AbWBHFyr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030547AbWBHFyr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Feb 2006 00:54:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030548AbWBHFyr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Feb 2006 00:54:47 -0500
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:463 "EHLO
	fgwmail5.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S1030547AbWBHFyq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Feb 2006 00:54:46 -0500
Message-ID: <43E987EC.60902@jp.fujitsu.com>
Date: Wed, 08 Feb 2006 14:55:56 +0900
From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
CC: mikael.starvik@axis.com
Subject: [PATCH] unify pfn_to_page take 2 [8/25] cris funcs
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

cris can use generic funcs.

Signed-Off-By: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>

Index: test-layout-free-zone/include/asm-cris/page.h
===================================================================
--- test-layout-free-zone.orig/include/asm-cris/page.h
+++ test-layout-free-zone/include/asm-cris/page.h
@@ -43,8 +43,7 @@ typedef struct { unsigned long pgprot; }

  /* On CRIS the PFN numbers doesn't start at 0 so we have to compensate */
  /* for that before indexing into the page table starting at mem_map    */
-#define pfn_to_page(pfn)	(mem_map + ((pfn) - (PAGE_OFFSET >> PAGE_SHIFT)))
-#define page_to_pfn(page)	((unsigned long)((page) - mem_map) + (PAGE_OFFSET >> PAGE_SHIFT))
+#define ARCH_PFN_OFFSET		(PAGE_OFFSET >> PAGE_SHIFT)
  #define pfn_valid(pfn)		(((pfn) - (PAGE_OFFSET >> PAGE_SHIFT)) < max_mapnr)

  /* to index into the page map. our pages all start at physical addr PAGE_OFFSET so

