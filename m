Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932467AbWCHVsq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932467AbWCHVsq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Mar 2006 16:48:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932263AbWCHVsq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Mar 2006 16:48:46 -0500
Received: from e5.ny.us.ibm.com ([32.97.182.145]:41386 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932467AbWCHVsp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Mar 2006 16:48:45 -0500
Date: Wed, 8 Mar 2006 15:48:30 -0600
From: Jon Mason <jdmason@us.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: mulix@mulix.org, Andi Kleen <ak@muc.de>
Subject: [PATCH] x86-64: Make GART_IOMMU kconfig help text more specific (trivial)
Message-ID: <20060308214829.GJ28921@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oops, forgot to CC lkml.

----- Forwarded message from Jon Mason <jdmason@us.ibm.com> -----

User-Agent: Mutt/1.5.11
From: Jon Mason <jdmason@us.ibm.com>
To: Andi Kleen <ak@muc.de>
Date: Wed, 8 Mar 2006 15:45:49 -0600
Subject: [PATCH] x86-64: Make GART_IOMMU kconfig help text more specific (trivial)

Have the GART_IOMMU help text specify that this is the hardware IOMMU in
amd64 processors.  This will be significant if/when other IOMMUs are
added to the x86-64 architecture. :-)

Also, note that the previous help text stated that IOMMU was needed for
>3GB memory instead of >4GB.  This is fixed in the newer version.

Thanks,
Jon

Signed-off-by: Jon Mason <jdmason@us.ibm.com>

diff -r 149aa2a22913 arch/x86_64/Kconfig
--- a/arch/x86_64/Kconfig	Tue Feb 28 22:02:10 2006
+++ b/arch/x86_64/Kconfig	Wed Mar  8 15:24:44 2006
@@ -364,13 +364,14 @@
 	select SWIOTLB
 	depends on PCI
 	help
-	  Support the IOMMU. Needed to run systems with more than 3GB of memory
-	  properly with 32-bit PCI devices that do not support DAC (Double Address
-	  Cycle). The IOMMU can be turned off at runtime with the iommu=off parameter.
-	  Normally the kernel will take the right choice by itself.
-	  This option includes a driver for the AMD Opteron/Athlon64 northbridge IOMMU
-	  and a software emulation used on other systems.
-	  If unsure, say Y.
+	  Support for hardware IOMMU in AMD's Opteron/Athlon64 Processors.
+	  Needed to run systems with more than 4GB of memory properly with
+	  32-bit PCI devices that do not support DAC (Double Address Cycle).
+	  The IOMMU can be turned off at runtime with the iommu=off parameter.
+  	  Normally the kernel will take the right choice by itself.
+  	  This option includes a driver for the AMD Opteron/Athlon64 IOMMU
+  	  northbridge and a software emulation used on some other systems.
+  	  If unsure, say Y.
 
 # need this always enabled with GART_IOMMU for the VIA workaround
 config SWIOTLB

----- End forwarded message -----
