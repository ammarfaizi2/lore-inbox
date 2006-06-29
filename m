Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932757AbWF2VhF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932757AbWF2VhF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jun 2006 17:37:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932773AbWF2Vg7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jun 2006 17:36:59 -0400
Received: from saraswathi.solana.com ([198.99.130.12]:26080 "EHLO
	saraswathi.solana.com") by vger.kernel.org with ESMTP
	id S932758AbWF2Vgj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jun 2006 17:36:39 -0400
Message-Id: <200606292136.k5TLaefd010832@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.0.4
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net
Subject: [PATCH 9/9] UML - add __raw_writeq definition
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 29 Jun 2006 17:36:40 -0400
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The x86_64 build requires a definition for __raw_writeq.

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.16/include/asm-um/io.h
===================================================================
--- linux-2.6.16.orig/include/asm-um/io.h	2006-03-23 16:40:24.000000000 -0500
+++ linux-2.6.16/include/asm-um/io.h	2006-06-21 17:39:40.000000000 -0400
@@ -45,8 +45,13 @@ static inline void writel(unsigned int b
 {
 	*(volatile unsigned int __force *) addr = b;
 }
+static inline void writeq(unsigned int b, volatile void __iomem *addr)
+{
+	*(volatile unsigned long long __force *) addr = b;
+}
 #define __raw_writeb writeb
 #define __raw_writew writew
 #define __raw_writel writel
+#define __raw_writeq writeq
 
 #endif

