Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964871AbWACXkz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964871AbWACXkz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jan 2006 18:40:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964975AbWACXkv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jan 2006 18:40:51 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:60891 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S965059AbWACX1l
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jan 2006 18:27:41 -0500
To: torvalds@osdl.org
Subject: [PATCH 15/41] m68k: bogus function argument types (sun3_pgtable.h)
Cc: linux-kernel@vger.kernel.org, linux-m68k@vger.kernel.org
Message-Id: <E1EtvZ6-0003Me-Ib@ZenIV.linux.org.uk>
From: Al Viro <viro@ftp.linux.org.uk>
Date: Tue, 03 Jan 2006 23:27:40 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Al Viro <viro@zeniv.linux.org.uk>
Date: 1133443075 -0500

function arguments can't be inline, TYVM...

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

---

 include/asm-m68k/sun3_pgtable.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

16aa5c5cb320fc995d5b7647e6fb82c55055ef6a
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

