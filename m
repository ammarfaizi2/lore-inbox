Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751094AbWBFLQ6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751094AbWBFLQ6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Feb 2006 06:16:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750780AbWBFLQ5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Feb 2006 06:16:57 -0500
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:11952 "EHLO
	fgwmail5.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S1750770AbWBFLQ4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Feb 2006 06:16:56 -0500
Message-ID: <43E7305C.7070308@jp.fujitsu.com>
Date: Mon, 06 Feb 2006 20:17:48 +0900
From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [RFC][PATCH] unify pfn_to_page [20/25]  uml  pfn_to_page/page_to_pfn
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

UML can use generic ones.

Signed-Off-By: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>

Index: cleanup_pfn_page/include/asm-um/page.h
===================================================================
--- cleanup_pfn_page.orig/include/asm-um/page.h
+++ cleanup_pfn_page/include/asm-um/page.h
@@ -106,9 +106,6 @@ extern unsigned long uml_physmem;
  #define __pa(virt) to_phys((void *) (unsigned long) (virt))
  #define __va(phys) to_virt((unsigned long) (phys))

-#define page_to_pfn(page) ((page) - mem_map)
-#define pfn_to_page(pfn) (mem_map + (pfn))
-
  #define phys_to_pfn(p) ((p) >> PAGE_SHIFT)
  #define pfn_to_phys(pfn) ((pfn) << PAGE_SHIFT)


