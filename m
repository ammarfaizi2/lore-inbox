Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263715AbTEJJlN (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 May 2003 05:41:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263717AbTEJJlN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 May 2003 05:41:13 -0400
Received: from palrel13.hp.com ([156.153.255.238]:50114 "EHLO palrel13.hp.com")
	by vger.kernel.org with ESMTP id S263715AbTEJJlL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 May 2003 05:41:11 -0400
Date: Sat, 10 May 2003 02:53:49 -0700
From: David Mosberger <davidm@napali.hpl.hp.com>
Message-Id: <200305100953.h4A9rnV8012151@napali.hpl.hp.com>
To: davej@suse.de
Cc: linux-kernel@vger.kernel.org
Subject: TRIVIAL: turn of AGP drivers which are not supported on ia64
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Reply-To: davidm@hpl.hp.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dave,

Subject says it all.  Please apply.

Thanks,

	--daivd

diff -Nru a/drivers/char/agp/Kconfig b/drivers/char/agp/Kconfig
--- a/drivers/char/agp/Kconfig	Sat May 10 01:47:43 2003
+++ b/drivers/char/agp/Kconfig	Sat May 10 01:47:43 2003
@@ -31,7 +31,7 @@
 
 config AGP_INTEL
 	tristate "Intel 440LX/BX/GX, I8xx and E7x05 support"
-	depends on AGP && !X86_64
+	depends on AGP && !X86_64 && !IA64
 	help
 	  This option gives you AGP support for the GLX component of the
 	  XFree86 4.x on Intel 440LX/BX/GX, 815, 820, 830, 840, 845, 850, 860
@@ -44,7 +44,7 @@
 
 #config AGP_I810
 #	tristate "Intel I810/I815/I830M (on-board) support"
-#	depends on AGP && !X86_64
+#	depends on AGP && !X86_64 && !IA64
 #	help
 #	  This option gives you AGP support for the Xserver on the Intel 810
 #	  815 and 830m chipset boards for their on-board integrated graphics. This
@@ -52,7 +52,7 @@
 
 config AGP_VIA
 	tristate "VIA chipset support"
-	depends on AGP && !X86_64
+	depends on AGP && !X86_64 && !IA64
 	help
 	  This option gives you AGP support for the GLX component of the
 	  XFree86 4.x on VIA MPV3/Apollo Pro chipsets.
@@ -62,7 +62,7 @@
 
 config AGP_AMD
 	tristate "AMD Irongate, 761, and 762 support"
-	depends on AGP && !X86_64
+	depends on AGP && !X86_64 && !IA64
 	help
 	  This option gives you AGP support for the GLX component of the
 	  XFree86 4.x on AMD Irongate, 761, and 762 chipsets.
@@ -72,7 +72,7 @@
 
 config AGP_SIS
 	tristate "Generic SiS support"
-	depends on AGP && !X86_64
+	depends on AGP && !X86_64 && !IA64
 	help
 	  This option gives you AGP support for the GLX component of the "soon
 	  to be released" XFree86 4.x on Silicon Integrated Systems [SiS]
@@ -85,7 +85,7 @@
 
 config AGP_ALI
 	tristate "ALI chipset support"
-	depends on AGP && !X86_64
+	depends on AGP && !X86_64 && !IA64
 	---help---
 	  This option gives you AGP support for the GLX component of the
 	  XFree86 4.x on the following ALi chipsets.  The supported chipsets
@@ -103,14 +103,14 @@
 
 config AGP_SWORKS
 	tristate "Serverworks LE/HE support"
-	depends on AGP && !X86_64
+	depends on AGP && !X86_64 && !IA64
 	help
 	  Say Y here to support the Serverworks AGP card.  See 
 	  <http://www.serverworks.com/> for product descriptions and images.
 
 config AGP_AMD_8151
 	tristate "AMD 8151 support"
-	depends on AGP
+	depends on AGP && !IA64
 	default GART_IOMMU
 	help
 	  Say Y here to support the AMD 8151 AGP bridge and the builtin
