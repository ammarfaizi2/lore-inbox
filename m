Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751082AbWBFLED@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751082AbWBFLED (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Feb 2006 06:04:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751085AbWBFLED
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Feb 2006 06:04:03 -0500
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36]:8660 "EHLO
	fgwmail6.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S1751082AbWBFLEC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Feb 2006 06:04:02 -0500
Message-ID: <43E72D5A.1020703@jp.fujitsu.com>
Date: Mon, 06 Feb 2006 20:04:58 +0900
From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [RFC][PATCH] unify pfn_to_page [11/25]  m68k pfn_to_page/page_to_pfn
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Complicated....memmap is not in order ?
Don't use generic ones by defining ARCH_HAS_PFN_PAGE

Signed-Off-By: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>

Index: cleanup_pfn_page/include/asm-m68k/page.h
===================================================================
--- cleanup_pfn_page.orig/include/asm-m68k/page.h
+++ cleanup_pfn_page/include/asm-m68k/page.h
@@ -159,6 +159,7 @@ static inline void *__va(unsigned long x
   * TODO: implement (fast) pfn<->pgdat_idx conversion functions, this makes lots
   * of the shifts unnecessary.
   */
+#define ARCH_HAS_PFN_PAGE
  #define virt_to_pfn(kaddr)	(__pa(kaddr) >> PAGE_SHIFT)
  #define pfn_to_virt(pfn)	__va((pfn) << PAGE_SHIFT)


