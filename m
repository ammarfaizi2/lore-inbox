Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030461AbWBHGex@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030461AbWBHGex (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Feb 2006 01:34:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030569AbWBHGex
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Feb 2006 01:34:53 -0500
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36]:711 "EHLO
	fgwmail6.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S1030461AbWBHGew (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Feb 2006 01:34:52 -0500
Message-ID: <43E99128.6090202@jp.fujitsu.com>
Date: Wed, 08 Feb 2006 15:35:20 +0900
From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
CC: user-mode-linux-devel@lists.sourceforge.net
Subject: [PATCH] unify pfn_to_page take 2 [23/25] uml funcs
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

UML can use generic funcs.

Signed-Off-By: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>

Index: test-layout-free-zone/include/asm-um/page.h
===================================================================
--- test-layout-free-zone.orig/include/asm-um/page.h
+++ test-layout-free-zone/include/asm-um/page.h
@@ -106,9 +106,6 @@ extern unsigned long uml_physmem;
  #define __pa(virt) to_phys((void *) (unsigned long) (virt))
  #define __va(phys) to_virt((unsigned long) (phys))

-#define page_to_pfn(page) ((page) - mem_map)
-#define pfn_to_page(pfn) (mem_map + (pfn))
-
  #define phys_to_pfn(p) ((p) >> PAGE_SHIFT)
  #define pfn_to_phys(pfn) ((pfn) << PAGE_SHIFT)


