Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263768AbTH1Fqx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Aug 2003 01:46:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263734AbTH1FqU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Aug 2003 01:46:20 -0400
Received: from TYO201.gate.nec.co.jp ([210.143.35.51]:30343 "EHLO
	TYO201.gate.nec.co.jp") by vger.kernel.org with ESMTP
	id S263772AbTH1FQ2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Aug 2003 01:16:28 -0400
To: Linus Torvalds <torvalds@osdl.org>
Subject: [PATCH][v850]  Guard some symbol exports with #ifdef CONFIG_MMU
Cc: linux-kernel@vger.kernel.org
Reply-To: Miles Bader <miles@gnu.org>
Message-Id: <20030828051553.8E6203718@mcspd15.ucom.lsi.nec.co.jp>
Date: Thu, 28 Aug 2003 14:15:53 +0900 (JST)
From: miles@lsi.nec.co.jp (Miles Bader)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus, please apply.

diff -ruN -X../cludes linux-2.6.0-test4-uc0/kernel/ksyms.c linux-2.6.0-test4-uc0-v850-20030827/kernel/ksyms.c
--- linux-2.6.0-test4-uc0/kernel/ksyms.c	2003-08-25 13:23:54.000000000 +0900
+++ linux-2.6.0-test4-uc0-v850-20030827/kernel/ksyms.c	2003-08-26 11:43:52.000000000 +0900
@@ -120,7 +120,9 @@
 EXPORT_SYMBOL(max_mapnr);
 #endif
 EXPORT_SYMBOL(high_memory);
+#ifdef CONFIG_MMU
 EXPORT_SYMBOL_GPL(invalidate_mmap_range);
+#endif
 EXPORT_SYMBOL(vmtruncate);
 EXPORT_SYMBOL(find_vma);
 EXPORT_SYMBOL(get_unmapped_area);
@@ -198,7 +200,9 @@
 EXPORT_SYMBOL(invalidate_inode_pages);
 EXPORT_SYMBOL_GPL(invalidate_inode_pages2);
 EXPORT_SYMBOL(truncate_inode_pages);
+#ifdef CONFIG_MMU
 EXPORT_SYMBOL(install_page);
+#endif
 EXPORT_SYMBOL(fsync_bdev);
 EXPORT_SYMBOL(permission);
 EXPORT_SYMBOL(vfs_permission);
