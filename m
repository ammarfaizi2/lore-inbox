Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932232AbVI2RAX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932232AbVI2RAX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Sep 2005 13:00:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932267AbVI2RAX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Sep 2005 13:00:23 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:1800 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S932262AbVI2RAW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Sep 2005 13:00:22 -0400
Date: Thu, 29 Sep 2005 18:00:12 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Al Viro <viro@ftp.linux.org.uk>
Cc: Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm/rpc iomem annotations
Message-ID: <20050929170012.GE7684@flint.arm.linux.org.uk>
Mail-Followup-To: Al Viro <viro@ftp.linux.org.uk>,
	Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org
References: <20050928231001.GF7992@ftp.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050928231001.GF7992@ftp.linux.org.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
Acked-by: Russell King <rmk+kernel@arm.linux.org.uk>

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

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
