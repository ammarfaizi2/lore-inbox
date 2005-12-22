Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965077AbVLVE64@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965077AbVLVE64 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Dec 2005 23:58:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965075AbVLVEuc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Dec 2005 23:50:32 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:25040 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S965070AbVLVEuZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Dec 2005 23:50:25 -0500
To: linux-m68k@vger.kernel.org
Subject: [PATCH 16/36] m68k: bogus function argument types (sun3_pgtable.h)
Cc: linux-kernel@vger.kernel.org
Message-Id: <E1EpIPI-0004rr-JP@ZenIV.linux.org.uk>
From: Al Viro <viro@ftp.linux.org.uk>
Date: Thu, 22 Dec 2005 04:50:24 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Al Viro <viro@zeniv.linux.org.uk>
Date: 1133443075 -0500

function arguments can't be inline, TYVM...

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

---

 include/asm-m68k/sun3_pgtable.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

7f0c01e49dc11366a0916e0f82cbd162ebe47482
diff --git a/include/asm-m68k/sun3_pgtable.h b/include/asm-m68k/sun3_pgtable.h
index e974bb0..5156a28 100644
--- a/include/asm-m68k/sun3_pgtable.h
+++ b/include/asm-m68k/sun3_pgtable.h
@@ -211,7 +211,7 @@ static inline unsigned long pte_to_pgoff
 	return pte.pte & SUN3_PAGE_PGNUM_MASK;
 }
 
-static inline pte_t pgoff_to_pte(inline unsigned off)
+static inline pte_t pgoff_to_pte(unsigned off)
 {
 	pte_t pte = { off + SUN3_PAGE_ACCESSED };
 	return pte;
-- 
0.99.9.GIT

