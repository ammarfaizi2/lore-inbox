Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932176AbWIGPzm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932176AbWIGPzm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Sep 2006 11:55:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932228AbWIGPzl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Sep 2006 11:55:41 -0400
Received: from smtp.osdl.org ([65.172.181.4]:50649 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932176AbWIGPzk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Sep 2006 11:55:40 -0400
Subject: [PATCH] sh: Fix typo in page.h
From: Mark Haverkamp <markh@osdl.org>
To: Andrew Morton <akpm@osdl.org>, linux-kernel <linux-kernel@vger.kernel.org>,
       lethal@linux-sh.org, kkojima@rr.iij4u.or.jp
Content-Type: text/plain
Date: Thu, 07 Sep 2006 08:55:29 -0700
Message-Id: <1157644529.1162.36.camel@markh3.pdx.osdl.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 (2.6.3-1.fc5.5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There appears to be a typo in asm-sh/page.h
It was noticed while doing a cross compile test.

Signed-off-by: Mark Haverkamp <markh@osdl.org>

---

--- linux-2.6.orig/include/asm-sh/page.h	2006-06-21 11:49:14.000000000 -0700
+++ linux-2.6/include/asm-sh/page.h	2006-09-07 08:50:53.000000000 -0700
@@ -104,7 +104,7 @@
 
 /* PFN start number, because of __MEMORY_START */
 #define PFN_START		(__MEMORY_START >> PAGE_SHIFT)
-#define ARCH_PFN_OFFSET		(FPN_START)
+#define ARCH_PFN_OFFSET		(PFN_START)
 #define virt_to_page(kaddr)	pfn_to_page(__pa(kaddr) >> PAGE_SHIFT)
 #define pfn_valid(pfn)		(((pfn) - PFN_START) < max_mapnr)
 #define virt_addr_valid(kaddr)	pfn_valid(__pa(kaddr) >> PAGE_SHIFT)

-- 
Mark Haverkamp <markh@osdl.org>

