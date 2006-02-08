Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030539AbWBHFrp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030539AbWBHFrp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Feb 2006 00:47:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030540AbWBHFrp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Feb 2006 00:47:45 -0500
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36]:9603 "EHLO
	fgwmail6.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S1030539AbWBHFro (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Feb 2006 00:47:44 -0500
Message-ID: <43E9863C.1080700@jp.fujitsu.com>
Date: Wed, 08 Feb 2006 14:48:44 +0900
From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
CC: linuxppc-dev@ozlabs.org
Subject: PATCH] unify pfn_to_page take 2 [4/25] powerpc funcs
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It looks powerpc doesn't have DISCONTIGMEM config.
Just replace FLATMEM ver.

Signed-Off-By: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>

Index: test-layout-free-zone/include/asm-powerpc/page.h
===================================================================
--- test-layout-free-zone.orig/include/asm-powerpc/page.h
+++ test-layout-free-zone/include/asm-powerpc/page.h
@@ -69,8 +69,6 @@
  #endif

  #ifdef CONFIG_FLATMEM
-#define pfn_to_page(pfn)	(mem_map + (pfn))
-#define page_to_pfn(page)	((unsigned long)((page) - mem_map))
  #define pfn_valid(pfn)		((pfn) < max_mapnr)
  #endif


