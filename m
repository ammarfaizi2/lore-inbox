Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263429AbUGMHea@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263429AbUGMHea (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jul 2004 03:34:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263540AbUGMHe3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jul 2004 03:34:29 -0400
Received: from TYO202.gate.nec.co.jp ([202.32.8.202]:23508 "EHLO
	tyo202.gate.nec.co.jp") by vger.kernel.org with ESMTP
	id S263429AbUGMHe2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jul 2004 03:34:28 -0400
To: Linus Torvalds <torvalds@osdl.org>
Subject: [PATCH] v850: Define find_first_bit
Cc: linux-kernel@vger.kernel.org
From: Miles Bader <miles@gnu.org>
Message-Id: <20040713073416.62F99444@mctpc71>
Date: Tue, 13 Jul 2004 16:34:16 +0900 (JST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Miles Bader <miles@gnu.org>

 include/asm-v850/bitops.h |    6 ++++++
 1 files changed, 6 insertions(+)

diff -ruN -X../cludes linux-2.6.8-rc1-moo/include/asm-v850/bitops.h linux-2.6.8-rc1-moo-v850-20040713/include/asm-v850/bitops.h
--- linux-2.6.8-rc1-moo/include/asm-v850/bitops.h	2004-07-13 10:39:36 +0900
+++ linux-2.6.8-rc1-moo-v850-20040713/include/asm-v850/bitops.h	2004-07-13 16:20:12 +0900
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
