Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261385AbUKXBSZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261385AbUKXBSZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Nov 2004 20:18:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261406AbUKXBSZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Nov 2004 20:18:25 -0500
Received: from mo01.iij4u.or.jp ([210.130.0.20]:16322 "EHLO mo01.iij4u.or.jp")
	by vger.kernel.org with ESMTP id S261385AbUKXBSW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Nov 2004 20:18:22 -0500
Date: Wed, 24 Nov 2004 10:18:09 +0900
From: Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
To: Andrew Morton <akpm@osdl.org>
Cc: yuasa@hh.iij4u.or.jp, linux-kernel <linux-kernel@vger.kernel.org>,
       Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH 2.6.10-rc2-mm3] mips: fixed memory mapped I/O of IDE on MIPS
Message-Id: <20041124101809.77a1d877.yuasa@hh.iij4u.or.jp>
X-Mailer: Sylpheed version 0.9.99 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes memory mapped I/O of IDE on MIPS.

The MMIO of IDE on MIPS, the read*()/write*() are correct methods for it.
 
Signed-off-by: Yoichi Yuasa <yuasa@hh.iij4u.or.jp>

diff -urN -X dontdiff a-orig/include/asm-mips/ide.h a/include/asm-mips/ide.h
--- a-orig/include/asm-mips/ide.h	Mon Oct 11 11:58:23 2004
+++ a/include/asm-mips/ide.h	Thu Oct 14 12:19:27 2004
@@ -14,11 +14,7 @@
 #ifdef __KERNEL__
 
 #include <ide.h>
-
-#define __ide_mm_insw   ide_insw
-#define __ide_mm_insl   ide_insl
-#define __ide_mm_outsw  ide_outsw
-#define __ide_mm_outsl  ide_outsl
+#include <asm-generic/ide_iops.h>
 
 #endif /* __KERNEL__ */
 

