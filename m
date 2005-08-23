Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932482AbVHWVyI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932482AbVHWVyI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Aug 2005 17:54:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932419AbVHWVnB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Aug 2005 17:43:01 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:61877 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S932402AbVHWVm6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Aug 2005 17:42:58 -0400
To: torvalds@osdl.org
Subject: [PATCH] (15/43) Kconfig fix (parport_pc on m32r)
Cc: linux-kernel@vger.kernel.org, takata@linux-m32r.org
Message-Id: <E1E7gan-0007Ak-Gu@parcelfarce.linux.theplanet.co.uk>
From: Al Viro <viro@www.linux.org.uk>
Date: Tue, 23 Aug 2005 22:46:01 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

parport_pc shouldn't be picked on m32r (no asm/parport.h, for starters)

Signed-off-by: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
----
diff -urN RC13-rc6-git13-m32r-airo/drivers/parport/Kconfig RC13-rc6-git13-m32r-parport_pc/drivers/parport/Kconfig
--- RC13-rc6-git13-m32r-airo/drivers/parport/Kconfig	2005-06-17 15:48:29.000000000 -0400
+++ RC13-rc6-git13-m32r-parport_pc/drivers/parport/Kconfig	2005-08-21 13:16:58.000000000 -0400
@@ -34,7 +34,7 @@
 
 config PARPORT_PC
 	tristate "PC-style hardware"
-	depends on PARPORT && (!SPARC64 || PCI) && !SPARC32
+	depends on PARPORT && (!SPARC64 || PCI) && !SPARC32 && !M32R
 	---help---
 	  You should say Y here if you have a PC-style parallel port. All
 	  IBM PC compatible computers and some Alphas have PC-style
