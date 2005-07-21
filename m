Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261738AbVGUKV1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261738AbVGUKV1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Jul 2005 06:21:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261741AbVGUKV1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Jul 2005 06:21:27 -0400
Received: from TYO202.gate.nec.co.jp ([210.143.35.52]:38823 "EHLO
	tyo202.gate.nec.co.jp") by vger.kernel.org with ESMTP
	id S261738AbVGUKV0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Jul 2005 06:21:26 -0400
To: Linus Torvalds <torvalds@osdl.org>
Subject: [PATCH] v850: Add pte_file
Cc: linux-kernel@vger.kernel.org
From: Miles Bader <miles@gnu.org>
Message-Id: <20050721102121.CD5324BC@mctpc71>
Date: Thu, 21 Jul 2005 19:21:21 +0900 (JST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Miles Bader <miles@gnu.org>

 include/asm-v850/pgtable.h |    2 ++
 1 files changed, 2 insertions(+)

diff -ruN -X../cludes linux-2.6.12-uc0/include/asm-v850/pgtable.h linux-2.6.12-uc0-v850-20050721/include/asm-v850/pgtable.h
--- linux-2.6.12-uc0/include/asm-v850/pgtable.h	2005-03-04 11:34:09.605536000 +0900
+++ linux-2.6.12-uc0-v850-20050721/include/asm-v850/pgtable.h	2005-07-21 16:23:19.930669000 +0900
@@ -23,6 +23,8 @@
 #define __pte_to_swp_entry(pte)	((swp_entry_t) { pte_val(pte) })
 #define __swp_entry_to_pte(x)	((pte_t) { (x).val })
 
+static inline int pte_file (pte_t pte) { return 0; }
+
 
 /* These mean nothing to !CONFIG_MMU.  */
 #define PAGE_NONE		__pgprot(0)
