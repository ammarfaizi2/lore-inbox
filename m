Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262895AbVCJXSj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262895AbVCJXSj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Mar 2005 18:18:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262362AbVCJXSU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Mar 2005 18:18:20 -0500
Received: from mail.kroah.org ([69.55.234.183]:14554 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262903AbVCJXKI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Mar 2005 18:10:08 -0500
Date: Thu, 10 Mar 2005 15:08:24 -0800
From: Greg KH <greg@kroah.com>
To: benh@kernel.crashing.org, paulus@samba.org, gjaeger@sysgo.com,
       mporter@kernel.crashing.org
Cc: linux-kernel@vger.kernel.org, stable@kernel.org
Subject: [04/11] ppc32: Compilation fixes for Ebony, Luan and Ocotea
Message-ID: <20050310230824.GE22112@kroah.com>
References: <20050310230519.GA22112@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050310230519.GA22112@kroah.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


-stable review patch.  If anyone has any objections, please let us know.

------------------


From: Matt Porter <mporter@kernel.crashing.org>

this patch fixes the problem, that the current kernel (linux-2.6.11-rc5)
could not be compiled, when "support for early boot texts over serial port"
(CONFIG_SERIAL_TEXT_DEBUG=y) is active.

Signed-off-by: Gerhard Jaeger <gjaeger@sysgo.com>
Signed-off-by: Matt Porter <mporter@kernel.crashing.org>
Signed-off-by: Andrew Morton <akpm@osdl.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
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

