Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263661AbUDNFHe (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Apr 2004 01:07:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263796AbUDNFHe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Apr 2004 01:07:34 -0400
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36]:20960 "EHLO
	fgwmail6.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S263661AbUDNFHb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Apr 2004 01:07:31 -0400
Date: Wed, 14 Apr 2004 14:00:06 +0900 (JST)
From: MAEDA Naoaki <maeda.naoaki@jp.fujitsu.com>
Subject: [PATCH 2.6.5-mm5] msi.c compile failure on ia64 fix
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Message-id: <20040414.140006.08347127.maeda@jp.fujitsu.com>
MIME-version: 1.0
X-Mailer: Mew version 2.2 on Emacs 20.3 / Mule 4.0 (HANANOEN)
Content-type: Text/Plain; charset=us-ascii
Content-transfer-encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew,

Compilation of 2.6.5-mm5 on ia64 appears to fail in drivers/pci/msi.c
due to lack of definition of NR_VECTORS. Following patch fix the problem.

Regards,
Naoaki Maeda

diff -Naur linux-2.6.5-mm5/include/asm-ia64/msi.h linux-2.6.5-mm5-ia64msifix/include/asm-ia64/msi.h
--- linux-2.6.5-mm5/include/asm-ia64/msi.h	2004-04-14 13:10:42.000000000 +0900
+++ linux-2.6.5-mm5-ia64msifix/include/asm-ia64/msi.h	2004-04-14 13:12:51.000000000 +0900
@@ -6,6 +6,7 @@
 #ifndef ASM_MSI_H
 #define ASM_MSI_H
 
+#define NR_VECTORS		NR_IRQ_VECTORS
 #define FIRST_DEVICE_VECTOR 	IA64_FIRST_DEVICE_VECTOR
 #define LAST_DEVICE_VECTOR	IA64_LAST_DEVICE_VECTOR
 static inline void set_intr_gate (int nr, void *func) {}
