Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261854AbTA1XXc>; Tue, 28 Jan 2003 18:23:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261855AbTA1XXc>; Tue, 28 Jan 2003 18:23:32 -0500
Received: from mailrelay1.lanl.gov ([128.165.4.101]:17644 "EHLO
	mailrelay1.lanl.gov") by vger.kernel.org with ESMTP
	id <S261854AbTA1XXb>; Tue, 28 Jan 2003 18:23:31 -0500
Subject: [PATCH] 2.5.59 add two help texts to drivers/i2c/Kconfig
From: Steven Cole <elenstev@mesatop.com>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Cc: trivial@rustcorp.com.au
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.2-5mdk 
Date: 28 Jan 2003 16:30:32 -0700
Message-Id: <1043796632.2570.176.camel@spc9.esa.lanl.gov>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here are some help texts from 2.4.21-pre3 Configure.help which are
needed in 2.5.59 drivers/i2c/Kconfig.

Steven

--- linux-2.5.59/drivers/i2c/Kconfig.orig	Tue Jan 28 16:03:42 2003
+++ linux-2.5.59/drivers/i2c/Kconfig	Tue Jan 28 16:18:39 2003
@@ -145,10 +145,26 @@
 config ITE_I2C_ALGO
 	tristate "ITE I2C Algorithm"
 	depends on MIPS_ITE8172 && I2C
+	help
+	  This supports the use of the ITE8172 I2C interface found on some MIPS
+	  systems. Say Y if you have one of these. You should also say Y for
+	  the ITE I2C peripheral driver support below.
+
+	  This support is also available as a module. If you want to compile
+	  it as a module, say M here and read Documentation/modules.txt.
+	  The module will be called i2c-algo-ite.o.
 
 config ITE_I2C_ADAP
 	tristate "ITE I2C Adapter"
 	depends on ITE_I2C_ALGO
+	help
+	  This supports the ITE8172 I2C peripheral found on some MIPS
+	  systems. Say Y if you have one of these. You should also say Y for
+	  the ITE I2C driver algorithm support above.
+
+	  This support is also available as a module. If you want to compile
+	  it as a module, say M here and read Documentation/modules.txt.
+	  The module will be called i2c-adap-ite.o.
 
 config I2C_ALGO8XX
 	tristate "MPC8xx CPM I2C interface"


