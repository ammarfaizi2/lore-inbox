Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964808AbVHYFVO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964808AbVHYFVO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Aug 2005 01:21:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964804AbVHYFVM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Aug 2005 01:21:12 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:56779 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S1751537AbVHYFU4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Aug 2005 01:20:56 -0400
To: geert@linux-m68k.org, torvalds@osdl.org
Subject: [PATCH] (4/22) bogus function argument types (sun3_pgtable.h)
Cc: linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org
Message-Id: <E1E8ADZ-0005ay-3r@parcelfarce.linux.theplanet.co.uk>
From: Al Viro <viro@www.linux.org.uk>
Date: Thu, 25 Aug 2005 06:24:01 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

function arguments can not be inline, TYVM...

Signed-off-by: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
----
diff -urN RC13-rc7-sun3ints/include/asm-m68k/sun3_pgtable.h RC13-rc7-sun3_pgtable/include/asm-m68k/sun3_pgtable.h
--- RC13-rc7-sun3ints/include/asm-m68k/sun3_pgtable.h	2005-06-17 15:48:29.000000000 -0400
+++ RC13-rc7-sun3_pgtable/include/asm-m68k/sun3_pgtable.h	2005-08-25 00:54:07.000000000 -0400
@@ -211,7 +211,7 @@
 	return pte.pte & SUN3_PAGE_PGNUM_MASK;
 }
 
-static inline pte_t pgoff_to_pte(inline unsigned off)
+static inline pte_t pgoff_to_pte(unsigned off)
 {
 	pte_t pte = { off + SUN3_PAGE_ACCESSED };
 	return pte;
