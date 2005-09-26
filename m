Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932385AbVIZFTb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932385AbVIZFTb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Sep 2005 01:19:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932389AbVIZFTb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Sep 2005 01:19:31 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:47572 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S932388AbVIZFT3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Sep 2005 01:19:29 -0400
To: torvalds@osdl.org
Subject: [PATCH] m32r: missing  __iomem in ioremap() declaration
Cc: linux-kernel@vger.kernel.org, takata@linux-m32r.org
Message-Id: <E1EJlOi-0005A2-JD@ZenIV.linux.org.uk>
From: Al Viro <viro@ftp.linux.org.uk>
Date: Mon, 26 Sep 2005 06:19:28 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
----
diff -urN RC14-rc2-git5-armv-iomem/include/asm-m32r/io.h RC14-rc2-git5-m32r-iomem/include/asm-m32r/io.h
--- RC14-rc2-git5-armv-iomem/include/asm-m32r/io.h	2005-06-17 15:48:29.000000000 -0400
+++ RC14-rc2-git5-m32r-iomem/include/asm-m32r/io.h	2005-09-25 23:46:33.000000000 -0400
@@ -60,7 +60,7 @@
  *	address.
  */
 
-static inline void * ioremap(unsigned long offset, unsigned long size)
+static inline void __iomem *ioremap(unsigned long offset, unsigned long size)
 {
 	return __ioremap(offset, size, 0);
 }
