Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932085AbWEWHNE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932085AbWEWHNE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 May 2006 03:13:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932087AbWEWHND
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 May 2006 03:13:03 -0400
Received: from h-66-166-126-70.lsanca54.covad.net ([66.166.126.70]:43479 "EHLO
	myri.com") by vger.kernel.org with ESMTP id S932085AbWEWHNA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 May 2006 03:13:00 -0400
Date: Tue, 23 May 2006 03:12:59 -0400
From: Brice Goglin <brice@myri.com>
To: netdev@vger.kernel.org
Cc: gallatin@myri.com, linux-kernel@vger.kernel.org
Subject: [PATCH 5/5] myri10ge - Kconfig and Makefile
Message-ID: <20060523071258.GG30499@myri.com>
References: <20060523070919.GB30499@myri.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060523070919.GB30499@myri.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH 5/5] myri10ge - Kconfig and Makefile

Add Kconfig and Makefile support for the myri10ge driver.

Signed-off-by: Brice Goglin <brice@myri.com>
Signed-off-by: Andrew J. Gallatin <gallatin@myri.com>

 drivers/net/Kconfig           |   17 +++++++++++++++++
 drivers/net/Makefile          |    1 +
 drivers/net/myri10ge/Makefile |    5 +++++
 3 files changed, 23 insertions(+)

--- linux-mm/drivers/net/Kconfig.old	2006-04-10 03:44:01.000000000 -0700
+++ linux-mm/drivers/net/Kconfig	2006-04-18 03:49:11.000000000 -0700
@@ -2327,6 +2327,23 @@ config S2IO_NAPI
 
 	  If in doubt, say N.
 
+config MYRI10GE
+	tristate "Myricom Myri-10G Ethernet support"
+	depends on PCI
+	select FW_LOADER
+	select CRC32
+	---help---
+	  This driver supports Myricom Myri-10G Dual Protocol interface in
+	  Ethernet mode. If the eeprom on your board is not recent enough,
+	  you will need a newer firmware image.
+	  You may get this image or more information, at:
+
+	  <http://www.myri.com/Myri-10G/>
+
+	  To compile this driver as a module, choose M here and read
+	  <file:Documentation/networking/net-modules.txt>.  The module
+	  will be called myri10ge.
+
 endmenu
 
 source "drivers/net/tokenring/Kconfig"
--- linux-mm/drivers/net/Makefile.old	2006-04-08 04:49:53.000000000 -0700
+++ linux-mm/drivers/net/Makefile	2006-04-21 08:10:27.000000000 -0700
@@ -192,6 +192,7 @@ obj-$(CONFIG_R8169) += r8169.o
 obj-$(CONFIG_AMD8111_ETH) += amd8111e.o
 obj-$(CONFIG_IBMVETH) += ibmveth.o
 obj-$(CONFIG_S2IO) += s2io.o
+obj-$(CONFIG_MYRI10GE) += myri10ge/
 obj-$(CONFIG_SMC91X) += smc91x.o
 obj-$(CONFIG_SMC911X) += smc911x.o
 obj-$(CONFIG_DM9000) += dm9000.o
--- /dev/null	2006-04-21 00:45:09.064430000 -0700
+++ linux-mm/drivers/net/myri10ge/Makefile	2006-04-21 08:14:21.000000000 -0700
@@ -0,0 +1,5 @@
+#
+# Makefile for the Myricom Myri-10G ethernet driver
+#
+
+obj-$(CONFIG_MYRI10GE) += myri10ge.o
