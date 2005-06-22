Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262763AbVFVGSx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262763AbVFVGSx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Jun 2005 02:18:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262760AbVFVGRv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Jun 2005 02:17:51 -0400
Received: from mail.kroah.org ([69.55.234.183]:43420 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262811AbVFVFWK convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Jun 2005 01:22:10 -0400
Cc: R.Marek@sh.cvut.cz
Subject: [PATCH] I2C: KConfig update - some EXPERIMENTAL removal
In-Reply-To: <1119417466764@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Tue, 21 Jun 2005 22:17:46 -0700
Message-Id: <1119417466194@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org, sensors@Stimpy.netroedge.com
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] I2C: KConfig update - some EXPERIMENTAL removal

Following patch removes EXPERIMENTAL flag from some of I2C bus and chip
drivers. It is removed when the driver is in kernel at least from
2.6.3 and I generally think there is no problem with it.

Also this patch adds SiS 745 to help option of sis96x and it
also fixes nForce2 driver entry to reflect current state.

Signed-off-by: Rudolf Marek <r.marek@sh.cvut.cz>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit 5d740fe9fefda41292b5cabe70f4f8eff9f8aad0
tree 974485c72963e94570b339276ebf5defc8197442
parent 828621dda6381093ceafbe9381b6118cae3f9b13
author R.Marek@sh.cvut.cz <R.Marek@sh.cvut.cz> Sat, 28 May 2005 11:26:24 +0000
committer Greg Kroah-Hartman <gregkh@suse.de> Tue, 21 Jun 2005 21:52:02 -0700

 drivers/i2c/busses/Kconfig |   34 +++++++++++++++++-----------------
 drivers/i2c/chips/Kconfig  |   12 ++++++------
 2 files changed, 23 insertions(+), 23 deletions(-)

diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
--- a/drivers/i2c/busses/Kconfig
+++ b/drivers/i2c/busses/Kconfig
@@ -7,7 +7,7 @@ menu "I2C Hardware Bus support"
 
 config I2C_ALI1535
 	tristate "ALI 1535"
-	depends on I2C && PCI && EXPERIMENTAL
+	depends on I2C && PCI
 	help
 	  If you say yes to this option, support will be included for the SMB
 	  Host controller on Acer Labs Inc. (ALI) M1535 South Bridges.  The SMB
@@ -31,7 +31,7 @@ config I2C_ALI1563
 
 config I2C_ALI15X3
 	tristate "ALI 15x3"
-	depends on I2C && PCI && EXPERIMENTAL
+	depends on I2C && PCI
 	help
 	  If you say yes to this option, support will be included for the
 	  Acer Labs Inc. (ALI) M1514 and M1543 motherboard I2C interfaces.
@@ -41,7 +41,7 @@ config I2C_ALI15X3
 
 config I2C_AMD756
 	tristate "AMD 756/766/768/8111 and nVidia nForce"
-	depends on I2C && PCI && EXPERIMENTAL
+	depends on I2C && PCI
 	help
 	  If you say yes to this option, support will be included for the AMD
 	  756/766/768 mainboard I2C interfaces.  The driver also includes
@@ -66,7 +66,7 @@ config I2C_AMD756_S4882
 
 config I2C_AMD8111
 	tristate "AMD 8111"
-	depends on I2C && PCI && EXPERIMENTAL
+	depends on I2C && PCI
 	help
 	  If you say yes to this option, support will be included for the
 	  second (SMBus 2.0) AMD 8111 mainboard I2C interface.
@@ -109,7 +109,7 @@ config I2C_HYDRA
 
 config I2C_I801
 	tristate "Intel 82801 (ICH)"
-	depends on I2C && PCI && EXPERIMENTAL
+	depends on I2C && PCI
 	help
 	  If you say yes to this option, support will be included for the Intel
 	  801 family of mainboard I2C interfaces.  Specifically, the following
@@ -130,7 +130,7 @@ config I2C_I801
 
 config I2C_I810
 	tristate "Intel 810/815"
-	depends on I2C && PCI && EXPERIMENTAL
+	depends on I2C && PCI
 	select I2C_ALGOBIT
 	help
 	  If you say yes to this option, support will be included for the Intel
@@ -183,7 +183,7 @@ config I2C_IOP3XX
 
 config I2C_ISA
 	tristate "ISA Bus support"
-	depends on I2C && EXPERIMENTAL
+	depends on I2C
 	help
 	  If you say yes to this option, support will be included for i2c
 	  interfaces that are on the ISA bus.
@@ -248,12 +248,11 @@ config I2C_MPC
 	  will be called i2c-mpc.
 
 config I2C_NFORCE2
-	tristate "Nvidia Nforce2"
-	depends on I2C && PCI && EXPERIMENTAL
+	tristate "Nvidia nForce2, nForce3 and nForce4"
+	depends on I2C && PCI
 	help
 	  If you say yes to this option, support will be included for the Nvidia
-	  Nforce2 family of mainboard I2C interfaces.
-	  This driver also supports the nForce3 Pro 150 MCP.
+	  nForce2, nForce3 and nForce4 families of mainboard I2C interfaces.
 
 	  This driver can also be built as a module.  If so, the module
 	  will be called i2c-nforce2.
@@ -305,7 +304,7 @@ config I2C_PARPORT_LIGHT
 
 config I2C_PROSAVAGE
 	tristate "S3/VIA (Pro)Savage"
-	depends on I2C && PCI && EXPERIMENTAL
+	depends on I2C && PCI
 	select I2C_ALGOBIT
 	help
 	  If you say yes to this option, support will be included for the
@@ -388,7 +387,7 @@ config SCx200_ACB
 
 config I2C_SIS5595
 	tristate "SiS 5595"
-	depends on I2C && PCI && EXPERIMENTAL
+	depends on I2C && PCI
 	help
 	  If you say yes to this option, support will be included for the 
 	  SiS5595 SMBus (a subset of I2C) interface.
@@ -398,7 +397,7 @@ config I2C_SIS5595
 
 config I2C_SIS630
 	tristate "SiS 630/730"
-	depends on I2C && PCI && EXPERIMENTAL
+	depends on I2C && PCI
 	help
 	  If you say yes to this option, support will be included for the 
 	  SiS630 and SiS730 SMBus (a subset of I2C) interface.
@@ -408,7 +407,7 @@ config I2C_SIS630
 
 config I2C_SIS96X
 	tristate "SiS 96x"
-	depends on I2C && PCI && EXPERIMENTAL
+	depends on I2C && PCI
 	help
 	  If you say yes to this option, support will be included for the SiS
 	  96x SMBus (a subset of I2C) interfaces.  Specifically, the following
@@ -419,6 +418,7 @@ config I2C_SIS96X
 	    648/961
 	    650/961
 	    735
+	    745
 
 	  This driver can also be built as a module.  If so, the module
 	  will be called i2c-sis96x.
@@ -449,7 +449,7 @@ config I2C_VIA
 
 config I2C_VIAPRO
 	tristate "VIA 82C596/82C686/823x"
-	depends on I2C && PCI && EXPERIMENTAL
+	depends on I2C && PCI
 	help
 	  If you say yes to this option, support will be included for the VIA
 	  82C596/82C686/823x I2C interfaces.  Specifically, the following 
@@ -467,7 +467,7 @@ config I2C_VIAPRO
 
 config I2C_VOODOO3
 	tristate "Voodoo 3"
-	depends on I2C && PCI && EXPERIMENTAL
+	depends on I2C && PCI
 	select I2C_ALGOBIT
 	help
 	  If you say yes to this option, support will be included for the
diff --git a/drivers/i2c/chips/Kconfig b/drivers/i2c/chips/Kconfig
--- a/drivers/i2c/chips/Kconfig
+++ b/drivers/i2c/chips/Kconfig
@@ -11,7 +11,7 @@ config I2C_SENSOR
 
 config SENSORS_ADM1021
 	tristate "Analog Devices ADM1021 and compatibles"
-	depends on I2C && EXPERIMENTAL
+	depends on I2C
 	select I2C_SENSOR
 	help
 	  If you say yes here you get support for Analog Devices ADM1021 
@@ -125,7 +125,7 @@ config SENSORS_FSCPOS
 
 config SENSORS_GL518SM
 	tristate "Genesys Logic GL518SM"
-	depends on I2C && EXPERIMENTAL
+	depends on I2C
 	select I2C_SENSOR
 	help
 	  If you say yes here you get support for Genesys Logic GL518SM
@@ -147,7 +147,7 @@ config SENSORS_GL520SM
 
 config SENSORS_IT87
 	tristate "ITE IT87xx and compatibles"
-	depends on I2C && EXPERIMENTAL
+	depends on I2C
 	select I2C_SENSOR
 	help
 	  If you say yes here you get support for ITE IT87xx sensor chips
@@ -171,7 +171,7 @@ config SENSORS_LM63
 
 config SENSORS_LM75
 	tristate "National Semiconductor LM75 and compatibles"
-	depends on I2C && EXPERIMENTAL
+	depends on I2C
 	select I2C_SENSOR
 	help
 	  If you say yes here you get support for National Semiconductor LM75
@@ -341,7 +341,7 @@ config SENSORS_SMSC47M1
 
 config SENSORS_VIA686A
 	tristate "VIA686A"
-	depends on I2C && PCI && EXPERIMENTAL
+	depends on I2C && PCI
 	select I2C_SENSOR
 	select I2C_ISA
 	help
@@ -353,7 +353,7 @@ config SENSORS_VIA686A
 
 config SENSORS_W83781D
 	tristate "Winbond W83781D, W83782D, W83783S, W83627HF, Asus AS99127F"
-	depends on I2C && EXPERIMENTAL
+	depends on I2C
 	select I2C_SENSOR
 	help
 	  If you say yes here you get support for the Winbond W8378x series

