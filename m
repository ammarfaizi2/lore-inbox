Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030334AbWBHG3h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030334AbWBHG3h (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Feb 2006 01:29:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030561AbWBHG3h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Feb 2006 01:29:37 -0500
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:64148 "EHLO
	fgwmail5.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S1030334AbWBHG3g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Feb 2006 01:29:36 -0500
Message-ID: <43E98FE3.3010005@jp.fujitsu.com>
Date: Wed, 08 Feb 2006 15:29:55 +0900
From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
CC: wli@holomorphy.com
Subject: [PATCH]  unify pfn_to_page take 2 [21/25] sparc funcs
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

sparc can use generic funcs by defining ARCH_PFN_OFFSET as pfh_base

Signed-Off-By: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>

Index: test-layout-free-zone/include/asm-sparc/page.h
===================================================================
--- test-layout-free-zone.orig/include/asm-sparc/page.h
+++ test-layout-free-zone/include/asm-sparc/page.h
@@ -152,8 +152,7 @@ extern unsigned long pfn_base;
  #define virt_to_phys		__pa
  #define phys_to_virt		__va

-#define pfn_to_page(pfn)	(mem_map + ((pfn)-(pfn_base)))
-#define page_to_pfn(page)	((unsigned long)(((page) - mem_map) + pfn_base))
+#define ARCH_PFN_OFFSET		(pfn_base)
  #define virt_to_page(kaddr)	(mem_map + ((((unsigned long)(kaddr)-PAGE_OFFSET)>>PAGE_SHIFT)))

  #define pfn_valid(pfn)		(((pfn) >= (pfn_base)) && (((pfn)-(pfn_base)) < max_mapnr))

