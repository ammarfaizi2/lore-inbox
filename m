Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263087AbTIVX4j (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Sep 2003 19:56:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263085AbTIVXzR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Sep 2003 19:55:17 -0400
Received: from mail.kroah.org ([65.200.24.183]:21409 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262798AbTIVXbQ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Sep 2003 19:31:16 -0400
Content-Type: text/plain; charset=US-ASCII
Message-Id: <10642734201540@kroah.com>
Subject: Re: [PATCH] i2c driver fixes for 2.6.0-test5
In-Reply-To: <10642734202631@kroah.com>
From: Greg KH <greg@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Mon, 22 Sep 2003 16:30:20 -0700
Content-Transfer-Encoding: 7BIT
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1315.1.5, 2003/09/15 16:38:32-07:00, greg@kroah.com

[PATCH] I2C: clean up the i2c bus Kconfig menu and help texts.


 drivers/i2c/busses/Kconfig |  165 ++++++++++-----------------------------------
 1 files changed, 39 insertions(+), 126 deletions(-)


diff -Nru a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
--- a/drivers/i2c/busses/Kconfig	Mon Sep 22 16:15:25 2003
+++ b/drivers/i2c/busses/Kconfig	Mon Sep 22 16:15:25 2003
@@ -5,7 +5,7 @@
 menu "I2C Hardware Sensors Mainboard support"
 
 config I2C_ALI1535
-	tristate "  ALI 1535"
+	tristate "ALI 1535"
 	depends on I2C && PCI && EXPERIMENTAL
 	help
 	  If you say yes to this option, support will be included for the SMB
@@ -13,63 +13,41 @@
 	  controller is part of the 7101 device, which is an ACPI-compliant
 	  Power Management Unit (PMU).
 
-	  This can also be built as a module.  If so, the module will be
-	  called i2c-ali1535.
-
-	  You will also need the latest user-space utilties: you can find them
-	  in the lm_sensors package, which you can download at
-	  http://www.lm-sensors.nu
+	  This driver can also be built as a module.  If so, the module
+	  will be called i2c-ali1535.
 
 config I2C_ALI15X3
-	tristate "  ALI 15x3"
+	tristate "ALI 15x3"
 	depends on I2C && PCI && EXPERIMENTAL
 	help
 	  If you say yes to this option, support will be included for the
 	  Acer Labs Inc. (ALI) M1514 and M1543 motherboard I2C interfaces.
 
-	  This can also be built as a module.  If so, the module will be
-	  called i2c-ali15x3.
-
-	  You will also need the latest user-space utilties: you can find them
-	  in the lm_sensors package, which you can download at
-	  http://www.lm-sensors.nu
+	  This driver can also be built as a module.  If so, the module
+	  will be called i2c-ali15x3.
 
 config I2C_AMD756
-	tristate "  AMD 756/766"
+	tristate "AMD 756/766"
 	depends on I2C && EXPERIMENTAL
 	help
 	  If you say yes to this option, support will be included for the AMD
 	  756/766/768 mainboard I2C interfaces.
 
-	  This can also be built as a module which can be inserted and removed 
-	  while the kernel is running.  If you want to compile it as a module,
-	  say M here and read <file:Documentation/modules.txt>.
-
-	  The module will be called i2c-amd756.
-
-	  You will also need the latest user-space utilties: you can find them
-	  in the lm_sensors package, which you can download at 
-	  http://www.lm-sensors.nu
+	  This driver can also be built as a module.  If so, the module
+	  will be called i2c-amd756.
 
 config I2C_AMD8111
-	tristate "  AMD 8111"
+	tristate "AMD 8111"
 	depends on I2C && EXPERIMENTAL
 	help
 	  If you say yes to this option, support will be included for the AMD
 	  8111 mainboard I2C interfaces.
 
-	  This can also be built as a module which can be inserted and removed 
-	  while the kernel is running.  If you want to compile it as a module,
-	  say M here and read <file:Documentation/modules.txt>.
-
-	  The module will be called i2c-amd8111.
-
-	  You will also need the latest user-space utilties: you can find them
-	  in the lm_sensors package, which you can download at 
-	  http://www.lm-sensors.nu
+	  This driver can also be built as a module.  If so, the module
+	  will be called i2c-amd8111.
 
 config I2C_I801
-	tristate "  Intel 801"
+	tristate "Intel 801"
 	depends on I2C && PCI && EXPERIMENTAL
 	help
 	  If you say yes to this option, support will be included for the Intel
@@ -81,53 +59,31 @@
 	    82801CA/CAM
 	    82801DB
 
-	  This can also be built as a module which can be inserted and removed 
-	  while the kernel is running.  If you want to compile it as a module,
-	  say M here and read <file:Documentation/modules.txt>.
-
-	  The module will be called i2c-i801.
-
-	  You will also need the latest user-space utilties: you can find them
-	  in the lm_sensors package, which you can download at 
-	  http://www.lm-sensors.nu
+	  This driver can also be built as a module.  If so, the module
+	  will be called i2c-i801.
 
 config I2C_ISA
-	tristate "  ISA Bus support"
+	tristate "ISA Bus support"
 	depends on I2C && ISA && EXPERIMENTAL
 	help
 	  If you say yes to this option, support will be included for i2c
 	  interfaces that are on the ISA bus.
 
-	  This can also be built as a module which can be inserted and removed 
-	  while the kernel is running.  If you want to compile it as a module,
-	  say M here and read <file:Documentation/modules.txt>.
-
-	  The module will be called i2c-isa.
-
-	  You will also need the latest user-space utilties: you can find them
-	  in the lm_sensors package, which you can download at 
-	  http://www.lm-sensors.nu
+	  This driver can also be built as a module.  If so, the module
+	  will be called i2c-isa.
 
 config I2C_NFORCE2
-	tristate "  Nvidia Nforce2"
+	tristate "Nvidia Nforce2"
 	depends on I2C && PCI && EXPERIMENTAL
 	help
 	  If you say yes to this option, support will be included for the Nvidia
 	  Nforce2 family of mainboard I2C interfaces.
 
-	  This can also be built as a module which can be inserted and removed
-	  while the kernel is running.  If you want to compile it as a module,
-	  say M here and read <file:Documentation/modules.txt>.
-
-	  The module will be called i2c-nforce2.
-
-	  You will also need the latest user-space utilties: you can find them
-	  in the lm_sensors package, which you can download at
-	  http://www.lm-sensors.nu
-
+	  This driver can also be built as a module.  If so, the module
+	  will be called i2c-nforce2.
 
 config I2C_PIIX4
-	tristate "  Intel PIIX4"
+	tristate "Intel PIIX4"
 	depends on I2C && PCI && EXPERIMENTAL
 	help
 	  If you say yes to this option, support will be included for the Intel
@@ -139,52 +95,31 @@
 	    Serverworks CSB5
 	    SMSC Victory66
 
-	  This can also be built as a module which can be inserted and removed 
-	  while the kernel is running.  If you want to compile it as a module,
-	  say M here and read <file:Documentation/modules.txt>.
-
-	  The module will be called i2c-piix4.
-
-	  You will also need the latest user-space utilties: you can find them
-	  in the lm_sensors package, which you can download at 
-	  http://www.lm-sensors.nu
+	  This driver can also be built as a module.  If so, the module
+	  will be called i2c-piix4.
 
 config I2C_SIS5595
-	tristate "  Sis5595"
+	tristate "SiS 5595"
 	depends on I2C && PCI && EXPERIMENTAL
 	help
 	  If you say yes to this option, support will be included for the 
 	  SiS5595 SMBus (a subset of I2C) interface.
 
-	  This can also be built as a module which can be inserted and removed 
-	  while the kernel is running.  If you want to compile it as a module,
-	  say M here and read <file:Documentation/modules.txt>.
-
-	  The module will be called i2c-sis5595.
-
-	  You will also need the latest user-space utilties: you can find them
-	  in the lm_sensors package, which you can download at 
-	  http://www.lm-sensors.nu
+	  This driver can also be built as a module.  If so, the module
+	  will be called i2c-sis5595.
 
 config I2C_SIS630
-	tristate "  Sis630"
+	tristate "SiS 630"
 	depends on I2C && PCI && EXPERIMENTAL
 	help
 	  If you say yes to this option, support will be included for the 
 	  SiS630 SMBus (a subset of I2C) interface.
 
-	  This can also be built as a module which can be inserted and removed 
-	  while the kernel is running.  If you want to compile it as a module,
-	  say M here and read <file:Documentation/modules.txt>.
-
-	  The module will be called i2c-sis630.
-
-	  You will also need the latest user-space utilties: you can find them
-	  in the lm_sensors package, which you can download at 
-	  http://www.lm-sensors.nu
+	  This driver can also be built as a module.  If so, the module
+	  will be called i2c-sis630.
 
 config I2C_SIS96X
-	tristate "  SiS 96x"
+	tristate "SiS 96x"
 	depends on I2C && PCI && EXPERIMENTAL
 	help
 	  If you say yes to this option, support will be included for the SiS
@@ -197,36 +132,22 @@
 	    650/961
 	    735
 
-	  This can also be built as a module which can be inserted and removed 
-	  while the kernel is running.  If you want to compile it as a module,
-	  say M here and read <file:Documentation/modules.txt>.
-
-	  The module will be called i2c-sis96x.
-
-	  You will also need the latest user-space utilties: you can find them
-	  in the lm_sensors package, which you can download at 
-	  http://www.lm-sensors.nu
+	  This driver can also be built as a module.  If so, the module
+	  will be called i2c-sis96x.
 
 config I2C_VIA
-	tristate "  VIA 82C58B"
+	tristate "VIA 82C58B"
 	depends on I2C && PCI && EXPERIMENTAL
 	help
 
 	  If you say yes to this option, support will be included for the VIA
           82C586B I2C interface
 
-	  This can also be built as a module which can be inserted and removed
-	  while the kernel is running.  If you want to compile it as a module,
-	  say M here and read <file:Documentation/modules.txt>.
-
-	  The module will be called i2c-via.
-
-	  You will also need the latest user-space utilties: you can find them
-	  in the lm_sensors package, which you can download at
-	  http://www.lm-sensors.nu
+	  This driver can also be built as a module.  If so, the module
+	  will be called i2c-via.
 
 config I2C_VIAPRO
-	tristate "  VIA 82C596/82C686/823x"
+	tristate "VIA 82C596/82C686/823x"
 	depends on I2C && PCI && EXPERIMENTAL
 	help
 
@@ -240,15 +161,7 @@
 	  8233A
 	  8235
 
-	  This can also be built as a module which can be inserted and removed
-	  while the kernel is running.  If you want to compile it as a module,
-	  say M here and read <file:Documentation/modules.txt>.
-
-	  The module will be called i2c-viapro.
-
-	  You will also need the latest user-space utilties: you can find them
-	  in the lm_sensors package, which you can download at
-	  http://www.lm-sensors.nu
+	  This driver can also be built as a module.  If so, the module
+	  will be called i2c-viapro.
 
 endmenu
-

