Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263785AbTCUSq2>; Fri, 21 Mar 2003 13:46:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263780AbTCUSpG>; Fri, 21 Mar 2003 13:45:06 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:18820
	"EHLO hraefn.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S263779AbTCUSo3>; Fri, 21 Mar 2003 13:44:29 -0500
Date: Fri, 21 Mar 2003 19:59:44 GMT
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Message-Id: <200303211959.h2LJxiJp026163@hraefn.swansea.linux.org.uk>
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: PATCH: update i2o build rules for change
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[Please also rm i2o_pci.c]
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.65/drivers/message/i2o/Kconfig linux-2.5.65-ac2/drivers/message/i2o/Kconfig
--- linux-2.5.65/drivers/message/i2o/Kconfig	2003-02-15 03:39:30.000000000 +0000
+++ linux-2.5.65-ac2/drivers/message/i2o/Kconfig	2003-03-20 18:44:46.000000000 +0000
@@ -3,6 +3,7 @@
 
 config I2O
 	tristate "I2O support"
+	depends on PCI
 	---help---
 	  The Intelligent Input/Output (I2O) architecture allows hardware
 	  drivers to be split into two parts: an operating system specific
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.65/drivers/message/i2o/Makefile linux-2.5.65-ac2/drivers/message/i2o/Makefile
--- linux-2.5.65/drivers/message/i2o/Makefile	2003-02-15 03:39:30.000000000 +0000
+++ linux-2.5.65-ac2/drivers/message/i2o/Makefile	2003-03-13 20:40:07.000000000 +0000
@@ -5,7 +5,6 @@
 # In the future, some of these should be built conditionally.
 #
 
-obj-$(CONFIG_I2O_PCI)	+= i2o_pci.o
 obj-$(CONFIG_I2O)	+= i2o_core.o i2o_config.o
 obj-$(CONFIG_I2O_BLOCK)	+= i2o_block.o
 obj-$(CONFIG_I2O_SCSI)	+= i2o_scsi.o
