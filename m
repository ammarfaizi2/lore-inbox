Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932413AbVHWVnU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932413AbVHWVnU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Aug 2005 17:43:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932426AbVHWVnT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Aug 2005 17:43:19 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:1206 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S932413AbVHWVnN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Aug 2005 17:43:13 -0400
To: torvalds@osdl.org
Subject: [PATCH] (18/43) Kconfig fix (amba on arm/versatile)
Cc: linux-kernel@vger.kernel.org, rmk@arm.linux.org.uk
Message-Id: <E1E7gb2-0007BJ-Kf@parcelfarce.linux.theplanet.co.uk>
From: Al Viro <viro@www.linux.org.uk>
Date: Tue, 23 Aug 2005 22:46:16 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

AMBA_PL010 is broken on arm/versatile; marked as such

Signed-off-by: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
----
diff -urN RC13-rc6-git13-acornscsi/drivers/serial/Kconfig RC13-rc6-git13-amba/drivers/serial/Kconfig
--- RC13-rc6-git13-acornscsi/drivers/serial/Kconfig	2005-08-21 13:16:58.000000000 -0400
+++ RC13-rc6-git13-amba/drivers/serial/Kconfig	2005-08-21 13:17:02.000000000 -0400
@@ -211,7 +211,7 @@
 
 config SERIAL_AMBA_PL010
 	tristate "ARM AMBA PL010 serial port support"
-	depends on ARM_AMBA
+	depends on ARM_AMBA && (BROKEN || !ARCH_VERSATILE)
 	select SERIAL_CORE
 	help
 	  This selects the ARM(R) AMBA(R) PrimeCell PL010 UART.  If you have
