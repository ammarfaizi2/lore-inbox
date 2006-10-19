Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161451AbWJSPTh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161451AbWJSPTh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Oct 2006 11:19:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161452AbWJSPTh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Oct 2006 11:19:37 -0400
Received: from mail.dsa-ac.de ([62.112.80.99]:56849 "EHLO mail.dsa-ac.de")
	by vger.kernel.org with ESMTP id S1161451AbWJSPTg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Oct 2006 11:19:36 -0400
Date: Thu, 19 Oct 2006 17:19:00 +0200 (CEST)
From: Guennadi Liakhovetski <gl@dsa-ac.de>
To: mingo@elte.hu
Cc: linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH 2/3] Remove CONFIG_IS_TICK_BASED
In-Reply-To: <Pine.LNX.4.63.0610191640550.1920@pcgl.dsa-ac.de>
Message-ID: <Pine.LNX.4.63.0610191714590.1920@pcgl.dsa-ac.de>
References: <Pine.LNX.4.63.0610191640550.1920@pcgl.dsa-ac.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the CONFIG_IS_TICK_BASED macro - never set now.

Thanks
Guennadi
---------------------------------
Guennadi Liakhovetski, Ph.D.
DSA Daten- und Systemtechnik GmbH
Pascalstr. 28
D-52076 Aachen
Germany

Signed-off-by: G. Liakhovetski <gl@dsa-ac.de>

diff --exclude=CVS -ur linux-2.6.18-rt6/arch/arm/Kconfig linux-2.6.18-rt6-rmdead/arch/arm/Kconfig
--- linux-2.6.18-rt6/arch/arm/Kconfig	2006-10-19 15:45:37.639189355 +0200
+++ linux-2.6.18-rt6-rmdead/arch/arm/Kconfig	2006-10-19 15:47:19.259176672 +0200
@@ -360,15 +360,6 @@

  source "arch/arm/mach-netx/Kconfig"

-config IS_TICK_BASED
-	bool
-	depends on GENERIC_TIME
-	default y
-	help
-	  This is used on platforms that have not added a clocksource to
-	  support GENERIC_TIME.  Platforms which have a clocksource
-	  should set this to 'n' in their mach-*/Kconfig.
-
  # Definitions to make life easier
  config ARCH_ACORN
  	bool
diff --exclude=CVS -ur linux-2.6.18-rt6/arch/arm/mach-ixp4xx/Kconfig linux-2.6.18-rt6-rmdead/arch/arm/mach-ixp4xx/Kconfig
--- linux-2.6.18-rt6/arch/arm/mach-ixp4xx/Kconfig	2006-10-19 12:29:12.434092798 +0200
+++ linux-2.6.18-rt6-rmdead/arch/arm/mach-ixp4xx/Kconfig	2006-10-19 15:41:15.375060531 +0200
@@ -1,9 +1,5 @@
  if ARCH_IXP4XX

-config IS_TICK_BASED
-	bool
-	default n
-
  config ARCH_SUPPORTS_BIG_ENDIAN
  	bool
  	default y
diff --exclude=CVS -ur linux-2.6.18-rt6/arch/arm/mach-versatile/Kconfig linux-2.6.18-rt6-rmdead/arch/arm/mach-versatile/Kconfig
--- linux-2.6.18-rt6/arch/arm/mach-versatile/Kconfig	2006-10-19 12:29:12.437092147 +0200
+++ linux-2.6.18-rt6-rmdead/arch/arm/mach-versatile/Kconfig	2006-10-19 15:41:29.527991395 +0200
@@ -1,10 +1,6 @@
  menu "Versatile platform type"
  	depends on ARCH_VERSATILE

-config IS_TICK_BASED
-	bool
-	default n
-
  config ARCH_VERSATILE_PB
  	bool "Support Versatile/PB platform"
  	default y
