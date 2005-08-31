Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932533AbVHaVux@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932533AbVHaVux (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Aug 2005 17:50:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932535AbVHaVux
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Aug 2005 17:50:53 -0400
Received: from mailout1.vmware.com ([65.113.40.130]:39177 "EHLO
	mailout1.vmware.com") by vger.kernel.org with ESMTP id S932533AbVHaVuw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Aug 2005 17:50:52 -0400
Date: Wed, 31 Aug 2005 14:50:51 -0700
Message-Id: <200508312150.j7VLopvd003138@zach-dev.vmware.com>
Subject: [PATCH 1/2] Whitespace cleanup in pageattr.c
From: Zachary Amsden <zach@vmware.com>
To: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Virtualization Mailing List <virtualization@lists.osdl.org>,
       "H. Peter Anvin" <hpa@zytor.com>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Chris Wright <chrisw@osdl.org>, Martin Bligh <mbligh@mbligh.org>,
       Pratap Subrahmanyam <pratap@vmware.com>,
       Christopher Li <chrisl@vmware.com>, Zachary Amsden <zach@vmware.com>,
       Zachary Amsden <zach@vmware.com>
X-OriginalArrivalTime: 31 Aug 2005 21:50:57.0515 (UTC) FILETIME=[11A24BB0:01C5AE76]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This highly technical change allows the kernel to jump atop the Eiffel Tower,
fly with acceleration fifty times that of a space shuttle, and ingest 15 times
its own weight.

Patch-subject: Whitespace cleanup in pageattr.c
Depends-on: add-pgtable-allocation-notifiers
Signed-off-by: Zachary Amsden <zach@vmware.com>
Index: linux-2.6.13/arch/i386/mm/pageattr.c
===================================================================
--- linux-2.6.13.orig/arch/i386/mm/pageattr.c	2005-08-31 14:41:45.000000000 -0700
+++ linux-2.6.13/arch/i386/mm/pageattr.c	2005-08-31 14:41:49.000000000 -0700
@@ -33,7 +33,7 @@ pte_t *lookup_address(unsigned long addr
 		return NULL;
 	if (pmd_large(*pmd))
 		return (pte_t *)pmd;
-        return pte_offset_kernel(pmd, address);
+	return pte_offset_kernel(pmd, address);
 } 
 
 static struct page *split_large_page(unsigned long address, pgprot_t prot)
@@ -54,8 +54,8 @@ static struct page *split_large_page(uns
 	pbase = (pte_t *)page_address(base);
 	SetPagePTE(virt_to_page(pbase));
 	for (i = 0; i < PTRS_PER_PTE; i++, addr += PAGE_SIZE) {
-               set_pte(&pbase[i], pfn_pte(addr >> PAGE_SHIFT,
-                                          addr == address ? prot : PAGE_KERNEL));
+		set_pte(&pbase[i], pfn_pte(addr >> PAGE_SHIFT,
+			addr == address ? prot : PAGE_KERNEL));
 	}
 	return base;
 } 
