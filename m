Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751344AbWBJK4c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751344AbWBJK4c (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Feb 2006 05:56:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751347AbWBJK4c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Feb 2006 05:56:32 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:61194 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751344AbWBJK4b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Feb 2006 05:56:31 -0500
Date: Fri, 10 Feb 2006 11:56:30 +0100
From: Adrian Bunk <bunk@stusta.de>
To: davej@codemonkey.org.uk
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] drivers/char/agp/Kconfig: help text updates
Message-ID: <20060210105630.GA19918@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch contains help text updates including the following:
- XFree86 * -> X
- there is no need for repeating part of the help text of the AGP
  option and having "If unsure, say Y/N." in the chip specific
  options.


Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 drivers/char/agp/Kconfig |   55 ++++++++++++---------------------------
 1 file changed, 17 insertions(+), 38 deletions(-)

--- linux-2.6.16-rc2-mm1-full/drivers/char/agp/Kconfig.old	2006-02-10 11:47:37.000000000 +0100
+++ linux-2.6.16-rc2-mm1-full/drivers/char/agp/Kconfig	2006-02-10 11:51:27.000000000 +0100
@@ -15,22 +15,23 @@
 	  due to kernel allocation issues), you could use PCI accesses
 	  and have up to a couple gigs of texture space.
 
-	  Note that this is the only means to have XFree4/GLX use
+	  Note that this is the only means to have X/GLX use
 	  write-combining with MTRR support on the AGP bus. Without it, OpenGL
 	  direct rendering will be a lot slower but still faster than PIO.
 
-	  You should say Y here if you use XFree86 3.3.6 or 4.x and want to
-	  use GLX or DRI.  If unsure, say N.
-
 	  To compile this driver as a module, choose M here: the
 	  module will be called agpgart.
 
+	  You should say Y here if you want to use GLX or DRI.
+
+	  If unsure, say N.
+
 config AGP_ALI
 	tristate "ALI chipset support"
 	depends on AGP && X86_32
 	---help---
 	  This option gives you AGP support for the GLX component of
-	  XFree86 4.x on the following ALi chipsets.  The supported chipsets
+	  X on the following ALi chipsets.  The supported chipsets
 	  include M1541, M1621, M1631, M1632, M1641,M1647,and M1651.
 	  For the ALi-chipset question, ALi suggests you refer to
 	  <http://www.ali.com.tw/eng/support/index.shtml>.
@@ -40,28 +41,19 @@
 	  timing issues, this chipset cannot do AGP 2x with the G200.
 	  This is a hardware limitation. AGP 1x seems to be fine, though.
 
-	  You should say Y here if you use XFree86 3.3.6 or 4.x and want to
-	  use GLX or DRI.  If unsure, say N.
-
 config AGP_ATI
 	tristate "ATI chipset support"
 	depends on AGP && X86_32
 	---help---
-      This option gives you AGP support for the GLX component of
-      XFree86 4.x on the ATI RadeonIGP family of chipsets.
-
-      You should say Y here if you use XFree86 3.3.6 or 4.x and want to
-      use GLX or DRI.  If unsure, say N.
+	  This option gives you AGP support for the GLX component of
+	  X on the ATI RadeonIGP family of chipsets.
 
 config AGP_AMD
 	tristate "AMD Irongate, 761, and 762 chipset support"
 	depends on AGP && X86_32
 	help
 	  This option gives you AGP support for the GLX component of
-	  XFree86 4.x on AMD Irongate, 761, and 762 chipsets.
-
-	  You should say Y here if you use XFree86 3.3.6 or 4.x and want to
-	  use GLX or DRI.  If unsure, say N.
+	  X on AMD Irongate, 761, and 762 chipsets.
 
 config AGP_AMD64
 	tristate "AMD Opteron/Athlon64 on-CPU GART support" if !GART_IOMMU
@@ -69,45 +61,38 @@
 	default y if GART_IOMMU
 	help
 	  This option gives you AGP support for the GLX component of
-	  XFree86 4.x using the on-CPU northbridge of the AMD Athlon64/Opteron CPUs.
+	  X using the on-CPU northbridge of the AMD Athlon64/Opteron CPUs.
 	  You still need an external AGP bridge like the AMD 8151, VIA
           K8T400M, SiS755. It may also support other AGP bridges when loaded
 	  with agp_try_unsupported=1.
-	  You should say Y here if you use XFree86 3.3.6 or 4.x and want to
-	  use GLX or DRI.  If unsure, say Y
 
 config AGP_INTEL
 	tristate "Intel 440LX/BX/GX, I8xx and E7x05 chipset support"
 	depends on AGP && X86
 	help
-	  This option gives you AGP support for the GLX component of XFree86 4.x
+	  This option gives you AGP support for the GLX component of X
 	  on Intel 440LX/BX/GX, 815, 820, 830, 840, 845, 850, 860, 875,
-	  E7205 and E7505 chipsets and full support for the 810, 815, 830M, 845G,
-	  852GM, 855GM, 865G and I915 integrated graphics chipsets.
+	  E7205 and E7505 chipsets and full support for the 810, 815, 830M,
+	  845G, 852GM, 855GM, 865G and I915 integrated graphics chipsets.
+
 
-	  You should say Y here if you use XFree86 3.3.6 or 4.x and want to
-	  use GLX or DRI, or if you have any Intel integrated graphics
-	  chipsets.  If unsure, say Y.
 
 config AGP_NVIDIA
 	tristate "NVIDIA nForce/nForce2 chipset support"
 	depends on AGP && X86_32
 	help
 	  This option gives you AGP support for the GLX component of
-	  XFree86 4.x on the following NVIDIA chipsets.  The supported chipsets
-	  include nForce and nForce2
+	  X on NVIDIA chipsets including nForce and nForce2
 
 config AGP_SIS
 	tristate "SiS chipset support"
 	depends on AGP && X86_32
 	help
 	  This option gives you AGP support for the GLX component of
-	  XFree86 4.x on Silicon Integrated Systems [SiS] chipsets.
+	  X on Silicon Integrated Systems [SiS] chipsets.
 
 	  Note that 5591/5592 AGP chipsets are NOT supported.
 
-	  You should say Y here if you use XFree86 3.3.6 or 4.x and want to
-	  use GLX or DRI.  If unsure, say N.
 
 config AGP_SWORKS
 	tristate "Serverworks LE/HE chipset support"
@@ -121,10 +106,7 @@
 	depends on AGP && X86_32
 	help
 	  This option gives you AGP support for the GLX component of
-	  XFree86 4.x on VIA MVP3/Apollo Pro chipsets.
-
-	  You should say Y here if you use XFree86 3.3.6 or 4.x and want to
-	  use GLX or DRI.  If unsure, say N.
+	  X on VIA MVP3/Apollo Pro chipsets.
 
 config AGP_I460
 	tristate "Intel 460GX chipset support"
@@ -159,9 +141,6 @@
 	  This option gives you AGP support for the Transmeta Efficeon
 	  series processors with integrated northbridges.
 
-	  You should say Y here if you use XFree86 3.3.6 or 4.x and want to
-	  use GLX or DRI.  If unsure, say Y.
-
 config AGP_SGI_TIOCA
         tristate "SGI TIO chipset AGP support"
         depends on AGP && (IA64_SGI_SN2 || IA64_GENERIC)
