Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263200AbTDCACO>; Wed, 2 Apr 2003 19:02:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263224AbTDCACN>; Wed, 2 Apr 2003 19:02:13 -0500
Received: from e32.co.us.ibm.com ([32.97.110.130]:50364 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S263200AbTDCACK> convert rfc822-to-8bit; Wed, 2 Apr 2003 19:02:10 -0500
Content-Type: text/plain; charset=US-ASCII
Message-Id: <10493289593135@kroah.com>
Subject: Re: [PATCH] More i2c driver changes for 2.5.66
In-Reply-To: <10493289592304@kroah.com>
From: Greg KH <greg@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Wed, 2 Apr 2003 16:15:59 -0800
Content-Transfer-Encoding: 7BIT
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1009, 2003/04/02 15:36:11-08:00, greg@kroah.com

i2c: fix up broken drivers/i2c/busses build due to I2C_PROC now being gone.


 drivers/i2c/busses/Kconfig |   13 ++++++-------
 1 files changed, 6 insertions(+), 7 deletions(-)


diff -Nru a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
--- a/drivers/i2c/busses/Kconfig	Wed Apr  2 16:00:11 2003
+++ b/drivers/i2c/busses/Kconfig	Wed Apr  2 16:00:11 2003
@@ -1,13 +1,12 @@
 #
 # Sensor device configuration
-# All depend on EXPERIMENTAL, I2C and I2C_PROC.
 #
 
 menu "I2C Hardware Sensors Mainboard support"
 
 config I2C_ALI15X3
 	tristate "  ALI 15x3"
-	depends on I2C && I2C_PROC && PCI && EXPERIMENTAL
+	depends on I2C && PCI && EXPERIMENTAL
 	help
 	  If you say yes to this option, support will be included for the
 	  Acer Labs Inc. (ALI) M1514 and M1543 motherboard I2C interfaces.
@@ -21,7 +20,7 @@
 
 config I2C_AMD756
 	tristate "  AMD 756/766"
-	depends on I2C && I2C_PROC
+	depends on I2C && EXPERIMENTAL
 	help
 	  If you say yes to this option, support will be included for the AMD
 	  756/766/768 mainboard I2C interfaces.
@@ -38,7 +37,7 @@
 
 config I2C_AMD8111
 	tristate "  AMD 8111"
-	depends on I2C && I2C_PROC
+	depends on I2C && EXPERIMENTAL
 	help
 	  If you say yes to this option, support will be included for the AMD
 	  8111 mainboard I2C interfaces.
@@ -55,7 +54,7 @@
 
 config I2C_I801
 	tristate "  Intel 801"
-	depends on I2C && I2C_PROC && PCI && EXPERIMENTAL
+	depends on I2C && PCI && EXPERIMENTAL
 	help
 	  If you say yes to this option, support will be included for the Intel
 	  801 family of mainboard I2C interfaces.  Specifically, the following
@@ -78,7 +77,7 @@
 
 config I2C_ISA
 	tristate "  ISA Bus support"
-	depends on I2C && I2C_PROC && ISA && EXPERIMENTAL
+	depends on I2C && ISA && EXPERIMENTAL
 	help
 	  If you say yes to this option, support will be included for i2c
 	  interfaces that are on the ISA bus.
@@ -96,7 +95,7 @@
 
 config I2C_PIIX4
 	tristate "  Intel PIIX4"
-	depends on I2C && I2C_PROC && PCI && EXPERIMENTAL
+	depends on I2C && PCI && EXPERIMENTAL
 	help
 	  If you say yes to this option, support will be included for the Intel
 	  PIIX4 family of mainboard I2C interfaces.  Specifically, the following

