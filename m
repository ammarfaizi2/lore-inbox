Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266245AbUGUC1F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266245AbUGUC1F (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jul 2004 22:27:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266436AbUGUC1F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jul 2004 22:27:05 -0400
Received: from TYO202.gate.nec.co.jp ([202.32.8.202]:35533 "EHLO
	tyo202.gate.nec.co.jp") by vger.kernel.org with ESMTP
	id S266245AbUGUC1C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jul 2004 22:27:02 -0400
To: Linus Torvalds <torvalds@osdl.org>
Subject: [PATCH] v850: Define find_first_bit
Cc: linux-kernel@vger.kernel.org
From: Miles Bader <miles@gnu.org>
Message-Id: <20040721022651.9EF85493@mctpc71>
Date: Wed, 21 Jul 2004 11:26:51 +0900 (JST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Miles Bader <miles@gnu.org>

 include/asm-v850/bitops.h |    6 ++++++
 1 files changed, 6 insertions(+)

diff -ruN -X../cludes linux-2.6.8-rc2-moo/include/asm-v850/bitops.h linux-2.6.8-rc2-moo-v850-20040721/include/asm-v850/bitops.h
--- linux-2.6.8-rc2-moo/include/asm-v850/bitops.h	2004-07-20 17:12:46 +0900
+++ linux-2.6.8-rc2-moo-v850-20040721/include/asm-v850/bitops.h	2004-07-21 11:05:45 +0900
@@ -267,6 +267,12 @@
 	return result + generic_ffs_for_find_next_bit(tmp);
 }
 
+/*
+ * find_first_bit - find the first set bit in a memory region
+ */
+#define find_first_bit(addr, size) \
+	find_next_bit((addr), (size), 0)
+
 
 #define ffs(x) generic_ffs (x)
 #define fls(x) generic_fls (x)
