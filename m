Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751204AbWEQWHF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751204AbWEQWHF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 May 2006 18:07:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751206AbWEQWHF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 May 2006 18:07:05 -0400
Received: from h-66-166-126-70.lsanca54.covad.net ([66.166.126.70]:13729 "EHLO
	myri.com") by vger.kernel.org with ESMTP id S1751204AbWEQWHD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 May 2006 18:07:03 -0400
Date: Wed, 17 May 2006 18:07:01 -0400
From: Brice Goglin <brice@myri.com>
To: netdev@vger.kernel.org
Cc: gallatin@myri.com, linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] myri10ge - Kconfig and Makefile
Message-ID: <20060517220700.GE13411@myri.com>
References: <20060517220218.GA13411@myri.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060517220218.GA13411@myri.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH 4/4] myri10ge - Kconfig and Makefile

Add Kconfig and Makefile support for the myri10ge driver.

Signed-off-by: Brice Goglin <brice@myri.com>
Signed-off-by: Andrew J. Gallatin <gallatin@myri.com>

 Kconfig           |   16 ++++++++++++++++
 Makefile          |    1 +
 myri10ge/Makefile |    5 +++++
 3 files changed, 22 insertions(+)

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
