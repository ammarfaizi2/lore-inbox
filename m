Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752125AbWCCBtM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752125AbWCCBtM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Mar 2006 20:49:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752136AbWCCBs4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Mar 2006 20:48:56 -0500
Received: from smtp-1.llnl.gov ([128.115.3.81]:18129 "EHLO smtp-1.llnl.gov")
	by vger.kernel.org with ESMTP id S1752139AbWCCBsc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Mar 2006 20:48:32 -0500
From: Dave Peterson <dsp@llnl.gov>
To: alan@lxorguk.ukuu.org.uk, akpm@osdl.org
Subject: [PATCH 15/15] EDAC: Kconfig dependency changes
Date: Thu, 2 Mar 2006 17:48:17 -0800
User-Agent: KMail/1.5.3
Cc: linux-kernel@vger.kernel.org, bluesmoke-devel@lists.sourceforge.net
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603021748.17935.dsp@llnl.gov>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

- Add x86 dependency in drivers/edac/Kconfig for all current
  platform-specific modules.

- Remove x86 dependency in drivers/edac/Kconfig for core EDAC module.
  Although there are not yet any platform-specific modules for non-x86
  hardware, the core EDAC module should be platform-independent.

Signed-Off-By: David S. Peterson <dsp@llnl.gov> <dave_peterson@pobox.com>
---

Index: linux-2.6.16-rc5-edac/drivers/edac/Kconfig
===================================================================
--- linux-2.6.16-rc5-edac.orig/drivers/edac/Kconfig	2006-02-27 15:13:54.000000000 -0800
+++ linux-2.6.16-rc5-edac/drivers/edac/Kconfig	2006-02-27 17:37:32.000000000 -0800
@@ -10,7 +10,6 @@ menu 'EDAC - error detection and reporti
 
 config EDAC
 	tristate "EDAC core system error reporting"
-	depends on X86
 	help
 	  EDAC is designed to report errors in the core system.
 	  These are low-level errors that are reported in the CPU or
@@ -52,35 +51,35 @@ config EDAC_AMD76X
 
 config EDAC_E7XXX
 	tristate "Intel e7xxx (e7205, e7500, e7501, e7505)"
-	depends on EDAC_MM_EDAC && PCI
+	depends on EDAC_MM_EDAC && PCI && X86_32
 	help
 	  Support for error detection and correction on the Intel
 	  E7205, E7500, E7501 and E7505 server chipsets.
 
 config EDAC_E752X
 	tristate "Intel e752x (e7520, e7525, e7320)"
-	depends on EDAC_MM_EDAC && PCI
+	depends on EDAC_MM_EDAC && PCI && X86
 	help
 	  Support for error detection and correction on the Intel
 	  E7520, E7525, E7320 server chipsets.
 
 config EDAC_I82875P
 	tristate "Intel 82875p (D82875P, E7210)"
-	depends on EDAC_MM_EDAC && PCI
+	depends on EDAC_MM_EDAC && PCI && X86_32
 	help
 	  Support for error detection and correction on the Intel
 	  DP82785P and E7210 server chipsets.
 
 config EDAC_I82860
 	tristate "Intel 82860"
-	depends on EDAC_MM_EDAC && PCI
+	depends on EDAC_MM_EDAC && PCI && X86_32
 	help
 	  Support for error detection and correction on the Intel
 	  82860 chipset.
 
 config EDAC_R82600
 	tristate "Radisys 82600 embedded chipset"
-	depends on EDAC_MM_EDAC
+	depends on EDAC_MM_EDAC && PCI && X86_32
 	help
 	  Support for error detection and correction on the Radisys
 	  82600 embedded chipset.
