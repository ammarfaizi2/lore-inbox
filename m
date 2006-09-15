Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932108AbWIOTdZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932108AbWIOTdZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Sep 2006 15:33:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751500AbWIOTdZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Sep 2006 15:33:25 -0400
Received: from mail.windriver.com ([147.11.1.11]:25520 "EHLO mail.wrs.com")
	by vger.kernel.org with ESMTP id S1751497AbWIOTdY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Sep 2006 15:33:24 -0400
Date: Fri, 15 Sep 2006 15:33:23 -0400
To: linux-kernel@vger.kernel.org
Subject: [PATCH] sbc8560 fixes
Message-ID: <20060915193323.GA25614@lucciola.windriver.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="wRRV7LY7NUeQGEoC"
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
From: Amy Fong <amy.fong@windriver.com>
X-OriginalArrivalTime: 15 Sep 2006 19:33:24.0397 (UTC) FILETIME=[CF5D6DD0:01C6D8FD]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--wRRV7LY7NUeQGEoC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

[PATCH] sbc8560 fixes

This patch makes changes required to fix compile errors in the sbc8560 target.

Kernel version:  linux-2.6.18-rc6


--wRRV7LY7NUeQGEoC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="sbc8560.diff"

Index: linux-2.6.18-rc6/arch/ppc/platforms/85xx/sbc8560.h
===================================================================
--- linux-2.6.18-rc6.orig/arch/ppc/platforms/85xx/sbc8560.h
+++ linux-2.6.18-rc6/arch/ppc/platforms/85xx/sbc8560.h
@@ -14,6 +14,7 @@
 #define __MACH_SBC8560_H__
  
 #include <platforms/85xx/sbc85xx.h>
+#include <asm/irq.h>
 
 #define CPM_MAP_ADDR    (CCSRBAR + MPC85xx_CPM_OFFSET)
  
Index: linux-2.6.18-rc6/arch/ppc/platforms/85xx/sbc85xx.h
===================================================================
--- linux-2.6.18-rc6.orig/arch/ppc/platforms/85xx/sbc85xx.h
+++ linux-2.6.18-rc6/arch/ppc/platforms/85xx/sbc85xx.h
@@ -49,4 +49,22 @@
 
 #define MPC85XX_PCI1_IO_SIZE	0x01000000
 
+/* FCC1 Clock Source Configuration.  These can be
+ * redefined in the board specific file.
+ *    Can only choose from CLK9-12 */
+#define F1_RXCLK       12
+#define F1_TXCLK       11
+
+/* FCC2 Clock Source Configuration.  These can be
+ * redefined in the board specific file.
+ *    Can only choose from CLK13-16 */
+#define F2_RXCLK       13
+#define F2_TXCLK       14
+
+/* FCC3 Clock Source Configuration.  These can be
+ * redefined in the board specific file.
+ *    Can only choose from CLK13-16 */
+#define F3_RXCLK       15
+#define F3_TXCLK       16
+
 #endif /* __PLATFORMS_85XX_SBC85XX_H__ */

--wRRV7LY7NUeQGEoC--
