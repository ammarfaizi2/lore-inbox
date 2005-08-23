Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932463AbVHWVw7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932463AbVHWVw7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Aug 2005 17:52:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932407AbVHWVnU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Aug 2005 17:43:20 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:2230 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S932424AbVHWVnS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Aug 2005 17:43:18 -0400
To: torvalds@osdl.org
Subject: [PATCH] (19/43) Kconfig fix (VGA console on arm/versatile)
Cc: linux-kernel@vger.kernel.org, rmk@arm.linux.org.uk
Message-Id: <E1E7gb7-0007BV-Lw@parcelfarce.linux.theplanet.co.uk>
From: Al Viro <viro@www.linux.org.uk>
Date: Tue, 23 Aug 2005 22:46:21 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

VGA console doesn't exist (or build) on arm/versatile; dependency fixed.

Signed-off-by: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
----
diff -urN RC13-rc6-git13-amba/drivers/video/console/Kconfig RC13-rc6-git13-vga/drivers/video/console/Kconfig
--- RC13-rc6-git13-amba/drivers/video/console/Kconfig	2005-08-10 10:37:52.000000000 -0400
+++ RC13-rc6-git13-vga/drivers/video/console/Kconfig	2005-08-21 13:17:03.000000000 -0400
@@ -6,7 +6,7 @@
 
 config VGA_CONSOLE
 	bool "VGA text console" if EMBEDDED || !X86
-	depends on !ARCH_ACORN && !ARCH_EBSA110 && !4xx && !8xx && !SPARC32 && !SPARC64 && !M68K && !PARISC
+	depends on !ARCH_ACORN && !ARCH_EBSA110 && !4xx && !8xx && !SPARC32 && !SPARC64 && !M68K && !PARISC && !ARCH_VERSATILE
 	default y
 	help
 	  Saying Y here will allow you to use Linux in text mode through a
