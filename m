Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262521AbVD3F5x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262521AbVD3F5x (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Apr 2005 01:57:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262522AbVD3F5x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Apr 2005 01:57:53 -0400
Received: from mx1.redhat.com ([66.187.233.31]:31634 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262521AbVD3F5p (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Apr 2005 01:57:45 -0400
Date: Sat, 30 Apr 2005 01:57:45 -0400
From: Dave Jones <davej@redhat.com>
To: linux-kernel@vger.kernel.org
Subject: tighten i2c dependancies
Message-ID: <20050430055745.GB832@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A lot of these drivers show up on pretty much every arch
regardless of whether they make sense. This adds a bunch
of additional dependancies tying down platform specific drivers
that are unlikely to be used on other archs.

Signed-off-by: Dave Jones <davej@redhat.com>

--- linux-2.6.11/drivers/i2c/busses/Kconfig~	2005-04-16 01:05:36.000000000 -0400
+++ linux-2.6.11/drivers/i2c/busses/Kconfig	2005-04-16 01:06:09.000000000 -0400
@@ -376,7 +376,7 @@ config SCx200_I2C_SDA
 
 config SCx200_ACB
 	tristate "NatSemi SCx200 ACCESS.bus"
-	depends on I2C && PCI
+	depends on SCx200_I2C && PCI
 	help
 	  Enable the use of the ACCESS.bus controllers of a SCx200 processor.
 
--- linux-2.6.11/drivers/i2c/busses/Kconfig~	2005-04-16 01:07:57.000000000 -0400
+++ linux-2.6.11/drivers/i2c/busses/Kconfig	2005-04-16 01:11:10.000000000 -0400
@@ -7,7 +7,7 @@ menu "I2C Hardware Bus support"
 
 config I2C_ALI1535
 	tristate "ALI 1535"
-	depends on I2C && PCI && EXPERIMENTAL
+	depends on X86 && I2C && PCI && EXPERIMENTAL
 	help
 	  If you say yes to this option, support will be included for the SMB
 	  Host controller on Acer Labs Inc. (ALI) M1535 South Bridges.  The SMB
@@ -19,7 +19,7 @@ config I2C_ALI1535
 
 config I2C_ALI1563
 	tristate "ALI 1563"
-	depends on I2C && PCI && EXPERIMENTAL
+	depends on X86 && I2C && PCI && EXPERIMENTAL
 	help
 	  If you say yes to this option, support will be included for the SMB
 	  Host controller on Acer Labs Inc. (ALI) M1563 South Bridges.  The SMB
@@ -31,7 +31,7 @@ config I2C_ALI1563
 
 config I2C_ALI15X3
 	tristate "ALI 15x3"
-	depends on I2C && PCI && EXPERIMENTAL
+	depends on X86 && I2C && PCI && EXPERIMENTAL
 	help
 	  If you say yes to this option, support will be included for the
 	  Acer Labs Inc. (ALI) M1514 and M1543 motherboard I2C interfaces.
@@ -41,7 +41,7 @@ config I2C_ALI15X3
 
 config I2C_AMD756
 	tristate "AMD 756/766/768/8111 and nVidia nForce"
-	depends on I2C && PCI && EXPERIMENTAL
+	depends on X86 && I2C && PCI && EXPERIMENTAL
 	help
 	  If you say yes to this option, support will be included for the AMD
 	  756/766/768 mainboard I2C interfaces.  The driver also includes
@@ -53,7 +53,7 @@ config I2C_AMD756
 
 config I2C_AMD756_S4882
 	tristate "SMBus multiplexing on the Tyan S4882"
-	depends on I2C_AMD756 && EXPERIMENTAL
+	depends on X86 && I2C_AMD756 && EXPERIMENTAL
 	help
 	  Enabling this option will add specific SMBus support for the Tyan
 	  S4882 motherboard.  On this 4-CPU board, the SMBus is multiplexed
@@ -66,7 +66,7 @@ config I2C_AMD756_S4882
 
 config I2C_AMD8111
 	tristate "AMD 8111"
-	depends on I2C && PCI && EXPERIMENTAL
+	depends on X86 && I2C && PCI && EXPERIMENTAL
 	help
 	  If you say yes to this option, support will be included for the
 	  second (SMBus 2.0) AMD 8111 mainboard I2C interface.
@@ -109,7 +109,7 @@ config I2C_HYDRA
 
 config I2C_I801
 	tristate "Intel 82801 (ICH)"
-	depends on I2C && PCI && EXPERIMENTAL
+	depends on X86 && I2C && PCI && EXPERIMENTAL
 	help
 	  If you say yes to this option, support will be included for the Intel
 	  801 family of mainboard I2C interfaces.  Specifically, the following
@@ -129,7 +129,7 @@ config I2C_I801
 
 config I2C_I810
 	tristate "Intel 810/815"
-	depends on I2C && PCI && EXPERIMENTAL
+	depends on X86 && I2C && PCI && EXPERIMENTAL
 	select I2C_ALGOBIT
 	help
 	  If you say yes to this option, support will be included for the Intel
@@ -145,7 +145,7 @@ config I2C_I810
 
 config I2C_PIIX4
 	tristate "Intel PIIX4"
-	depends on I2C && PCI
+	depends on X86 && I2C && PCI
 	help
 	  If you say yes to this option, support will be included for the Intel
 	  PIIX4 family of mainboard I2C interfaces.  Specifically, the following
@@ -437,7 +437,7 @@ config I2C_STUB
 
 config I2C_VIA
 	tristate "VIA 82C586B"
-	depends on I2C && PCI && EXPERIMENTAL
+	depends on (X86 || PPC) && I2C && PCI && EXPERIMENTAL
 	select I2C_ALGOBIT
 	help
 	  If you say yes to this option, support will be included for the VIA
@@ -448,7 +448,7 @@ config I2C_VIA
 
 config I2C_VIAPRO
 	tristate "VIA 82C596/82C686/823x"
-	depends on I2C && PCI && EXPERIMENTAL
+	depends on (X86 || PPC) && I2C && PCI && EXPERIMENTAL
 	help
 	  If you say yes to this option, support will be included for the VIA
 	  82C596/82C686/823x I2C interfaces.  Specifically, the following 
--- linux-2.6.11/drivers/i2c/busses/Kconfig~	2005-04-16 01:16:48.000000000 -0400
+++ linux-2.6.11/drivers/i2c/busses/Kconfig	2005-04-16 01:17:11.000000000 -0400
@@ -387,7 +387,7 @@ config SCx200_ACB
 
 config I2C_SIS5595
 	tristate "SiS 5595"
-	depends on I2C && PCI && EXPERIMENTAL
+	depends on X86 && I2C && PCI && EXPERIMENTAL
 	help
 	  If you say yes to this option, support will be included for the 
 	  SiS5595 SMBus (a subset of I2C) interface.
@@ -397,7 +397,7 @@ config I2C_SIS5595
 
 config I2C_SIS630
 	tristate "SiS 630/730"
-	depends on I2C && PCI && EXPERIMENTAL
+	depends on X86 && I2C && PCI && EXPERIMENTAL
 	help
 	  If you say yes to this option, support will be included for the 
 	  SiS630 and SiS730 SMBus (a subset of I2C) interface.
@@ -407,7 +407,7 @@ config I2C_SIS630
 
 config I2C_SIS96X
 	tristate "SiS 96x"
-	depends on I2C && PCI && EXPERIMENTAL
+	depends on X86 && I2C && PCI && EXPERIMENTAL
 	help
 	  If you say yes to this option, support will be included for the SiS
 	  96x SMBus (a subset of I2C) interfaces.  Specifically, the following
