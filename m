Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261446AbUKSQI2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261446AbUKSQI2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Nov 2004 11:08:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261450AbUKSQI2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Nov 2004 11:08:28 -0500
Received: from mo00.iij4u.or.jp ([210.130.0.19]:23795 "EHLO mo00.iij4u.or.jp")
	by vger.kernel.org with ESMTP id S261446AbUKSQI0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Nov 2004 11:08:26 -0500
Date: Sat, 20 Nov 2004 01:08:05 +0900
From: Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
To: Andrew Morton <akpm@osdl.org>
Cc: yuasa@hh.iij4u.or.jp, Ralf Baechle <ralf@linux-mips.org>,
       linux-kernel@vger.kernel.org
Subject: [PATCH 2.6.10-rc2-mm1] fixed PMD_ORDER for MIPS
Message-Id: <20041120010805.1fd04cab.yuasa@hh.iij4u.or.jp>
X-Mailer: Sylpheed version 0.9.99 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch is fixed PMD_ORDER for MIPS.

Signed-off-by: Yoichi Yuasa <yuasa@hh.iij4u.or.jp>

diff -urN -X dontdiff a-orig/include/asm-mips/pgtable-64.h a/include/asm-mips/pgtable-64.h
--- a-orig/include/asm-mips/pgtable-64.h	Mon Nov 15 10:26:43 2004
+++ a/include/asm-mips/pgtable-64.h	Sat Nov 20 00:56:00 2004
@@ -66,7 +66,7 @@
  */
 #ifdef CONFIG_PAGE_SIZE_4KB
 #define PGD_ORDER		1
-#define PMD_ORDER		1
+#define PMD_ORDER		0
 #define PTE_ORDER		0
 #endif
 #ifdef CONFIG_PAGE_SIZE_8KB
