Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263243AbVCDXnh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263243AbVCDXnh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Mar 2005 18:43:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263191AbVCDXVY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Mar 2005 18:21:24 -0500
Received: from fire.osdl.org ([65.172.181.4]:56986 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S263236AbVCDVRX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Mar 2005 16:17:23 -0500
Message-Id: <200503042117.j24LHHhN017970@shell0.pdx.osdl.net>
Subject: [patch 3/5] ppc32: Compilation fixes for Ebony, Luan and Ocotea
To: greg@kroah.com
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, mporter@kernel.crashing.org,
       gjaeger@sysgo.com
From: akpm@osdl.org
Date: Fri, 04 Mar 2005 13:16:56 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Matt Porter <mporter@kernel.crashing.org>

this patch fixes the problem, that the current kernel (linux-2.6.11-rc5)
could not be compiled, when "support for early boot texts over serial port"
(CONFIG_SERIAL_TEXT_DEBUG=y) is active.

Signed-off-by: Gerhard Jaeger <gjaeger@sysgo.com>
Signed-off-by: Matt Porter <mporter@kernel.crashing.org>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 25-akpm/arch/ppc/platforms/4xx/ebony.h  |    4 ++--
 25-akpm/arch/ppc/platforms/4xx/luan.h   |    6 +++---
 25-akpm/arch/ppc/platforms/4xx/ocotea.h |    4 ++--
 3 files changed, 7 insertions(+), 7 deletions(-)

diff -puN arch/ppc/platforms/4xx/ebony.h~ppc32-compilation-fixes-for-ebony-luan-and-ocotea arch/ppc/platforms/4xx/ebony.h
--- 25/arch/ppc/platforms/4xx/ebony.h~ppc32-compilation-fixes-for-ebony-luan-and-ocotea	2005-03-04 13:16:17.000000000 -0800
+++ 25-akpm/arch/ppc/platforms/4xx/ebony.h	2005-03-04 13:16:17.000000000 -0800
@@ -61,8 +61,8 @@
  */
 
 /* OpenBIOS defined UART mappings, used before early_serial_setup */
-#define UART0_IO_BASE	(u8 *) 0xE0000200
-#define UART1_IO_BASE	(u8 *) 0xE0000300
+#define UART0_IO_BASE	0xE0000200
+#define UART1_IO_BASE	0xE0000300
 
 /* external Epson SG-615P */
 #define BASE_BAUD	691200
diff -puN arch/ppc/platforms/4xx/luan.h~ppc32-compilation-fixes-for-ebony-luan-and-ocotea arch/ppc/platforms/4xx/luan.h
--- 25/arch/ppc/platforms/4xx/luan.h~ppc32-compilation-fixes-for-ebony-luan-and-ocotea	2005-03-04 13:16:17.000000000 -0800
+++ 25-akpm/arch/ppc/platforms/4xx/luan.h	2005-03-04 13:16:17.000000000 -0800
@@ -47,9 +47,9 @@
 #define RS_TABLE_SIZE	3
 
 /* PIBS defined UART mappings, used before early_serial_setup */
-#define UART0_IO_BASE	(u8 *) 0xa0000200
-#define UART1_IO_BASE	(u8 *) 0xa0000300
-#define UART2_IO_BASE	(u8 *) 0xa0000600
+#define UART0_IO_BASE	0xa0000200
+#define UART1_IO_BASE	0xa0000300
+#define UART2_IO_BASE	0xa0000600
 
 #define BASE_BAUD	11059200
 #define STD_UART_OP(num)					\
diff -puN arch/ppc/platforms/4xx/ocotea.h~ppc32-compilation-fixes-for-ebony-luan-and-ocotea arch/ppc/platforms/4xx/ocotea.h
--- 25/arch/ppc/platforms/4xx/ocotea.h~ppc32-compilation-fixes-for-ebony-luan-and-ocotea	2005-03-04 13:16:17.000000000 -0800
+++ 25-akpm/arch/ppc/platforms/4xx/ocotea.h	2005-03-04 13:16:17.000000000 -0800
@@ -56,8 +56,8 @@
 #define RS_TABLE_SIZE	2
 
 /* OpenBIOS defined UART mappings, used before early_serial_setup */
-#define UART0_IO_BASE	(u8 *) 0xE0000200
-#define UART1_IO_BASE	(u8 *) 0xE0000300
+#define UART0_IO_BASE	0xE0000200
+#define UART1_IO_BASE	0xE0000300
 
 #define BASE_BAUD	11059200/16
 #define STD_UART_OP(num)					\
_
