Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751216AbVI1XKH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751216AbVI1XKH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Sep 2005 19:10:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751217AbVI1XKG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Sep 2005 19:10:06 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:19366 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1751216AbVI1XKF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Sep 2005 19:10:05 -0400
Date: Thu, 29 Sep 2005 00:10:01 +0100
From: Al Viro <viro@ftp.linux.org.uk>
To: Linus Torvalds <torvalds@osdl.org>
Cc: rmk@arm.linux.org.uk, linux-kernel@vger.kernel.org
Subject: [PATCH] arm/rpc iomem annotations
Message-ID: <20050928231001.GF7992@ftp.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
----
diff -urN RC14-rc2-git6-ia64-user/include/asm-arm/arch-rpc/hardware.h RC14-rc2-git6-rpc-iomem/include/asm-arm/arch-rpc/hardware.h
--- RC14-rc2-git6-ia64-user/include/asm-arm/arch-rpc/hardware.h	2005-06-17 15:48:29.000000000 -0400
+++ RC14-rc2-git6-rpc-iomem/include/asm-arm/arch-rpc/hardware.h	2005-09-28 13:02:05.000000000 -0400
@@ -15,7 +15,7 @@
 #include <asm/arch/memory.h>
 
 #ifndef __ASSEMBLY__
-#define IOMEM(x) ((void __iomem *)(x))
+#define IOMEM(x) ((void __iomem *)(unsigned long)(x))
 #else
 #define IOMEM(x) x
 #endif /* __ASSEMBLY__ */
@@ -52,7 +52,7 @@
 /*
  * IO Addresses
  */
-#define VIDC_BASE		(void __iomem *)0xe0400000
+#define VIDC_BASE		IOMEM(0xe0400000)
 #define EXPMASK_BASE		0xe0360000
 #define IOMD_BASE		IOMEM(0xe0200000)
 #define IOC_BASE		IOMEM(0xe0200000)
