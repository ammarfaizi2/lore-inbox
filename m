Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932430AbVHWVnr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932430AbVHWVnr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Aug 2005 17:43:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932423AbVHWVnZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Aug 2005 17:43:25 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:64181 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S932422AbVHWVnD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Aug 2005 17:43:03 -0400
To: torvalds@osdl.org
Subject: [PATCH] (16/43) Kconfig fix (M32R_PLDSIO dependecies)
Cc: linux-kernel@vger.kernel.org, takata@linux-m32r.org
Message-Id: <E1E7gas-0007Ax-I9@parcelfarce.linux.theplanet.co.uk>
From: Al Viro <viro@www.linux.org.uk>
Date: Tue, 23 Aug 2005 22:46:06 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

M32R_PLDSIO depends on subarchitecture providing PLD_ESIO0CR and
friends.

Signed-off-by: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
----
diff -urN RC13-rc6-git13-m32r-parport_pc/drivers/serial/Kconfig RC13-rc6-git13-m32r-pldsio/drivers/serial/Kconfig
--- RC13-rc6-git13-m32r-parport_pc/drivers/serial/Kconfig	2005-08-10 10:37:51.000000000 -0400
+++ RC13-rc6-git13-m32r-pldsio/drivers/serial/Kconfig	2005-08-21 13:16:58.000000000 -0400
@@ -819,7 +819,7 @@
 
 config SERIAL_M32R_PLDSIO
 	bool "M32R SIO I/F on a PLD"
-	depends on SERIAL_M32R_SIO=y
+	depends on SERIAL_M32R_SIO=y && (PLAT_OPSPUT || PALT_USRV || PLAT_M32700UT)
 	default n
 	help
 	  Say Y here if you want to use the M32R serial controller
