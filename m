Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261592AbVGDKsC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261592AbVGDKsC (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Jul 2005 06:48:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261394AbVGDKsC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Jul 2005 06:48:02 -0400
Received: from mail-in-01.arcor-online.net ([151.189.21.41]:35971 "EHLO
	mail-in-01.arcor-online.net") by vger.kernel.org with ESMTP
	id S261592AbVGDKon (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Jul 2005 06:44:43 -0400
Date: Mon, 4 Jul 2005 12:43:56 +0200 (CEST)
From: Bodo Eggert <7eggert@gmx.de>
To: Bodo Eggert <7eggert@gmx.de>
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Kconfig changes 4: s/menu/menuconfig/ CPU scaling menu
In-Reply-To: <Pine.LNX.4.58.0507041231200.6165@be1.lrz>
Message-ID: <Pine.LNX.4.58.0507041243070.8687@be1.lrz>
References: <Pine.LNX.4.58.0506301152460.11960@be1.lrz>
 <Pine.LNX.4.58.0507041134410.3798@be1.lrz> <Pine.LNX.4.58.0507041210190.6165@be1.lrz>
 <Pine.LNX.4.58.0507041231200.6165@be1.lrz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Part 4: The CPU scaling menu.

In many config submenus, the first menu option will enable the rest 
of the menu options. For these menus, It's appropriate to use the more 
convenient "menuconfig" keyword.

This patch is designed for 2.6.13-rc1


--- rc1-a/./arch/sh/Kconfig	2005-06-30 11:22:17.000000000 +0200
+++ rc1-b/./arch/sh/Kconfig	2005-07-04 12:39:29.000000000 +0200
@@ -657,8 +657,6 @@ config SH_PCLK_FREQ
 	  with an auto-probed frequency which should be considered the proper
 	  value for your hardware.
 
-menu "CPU Frequency scaling"
-
 source "drivers/cpufreq/Kconfig"
 
 config SH_CPU_FREQ
@@ -673,8 +671,6 @@ config SH_CPU_FREQ
 
 	  If unsure, say N.
 
-endmenu
-
 source "arch/sh/drivers/dma/Kconfig"
 
 source "arch/sh/cchips/Kconfig"
--- rc1-a/./arch/arm/Kconfig	2005-06-30 11:22:15.000000000 +0200
+++ rc1-b/./arch/arm/Kconfig	2005-07-04 12:39:29.000000000 +0200
@@ -516,8 +516,6 @@ endmenu
 
 if (ARCH_SA1100 || ARCH_INTEGRATOR)
 
-menu "CPU Frequency scaling"
-
 source "drivers/cpufreq/Kconfig"
 
 config CPU_FREQ_SA1100
@@ -541,8 +539,6 @@ config CPU_FREQ_INTEGRATOR
 
 	  If in doubt, say Y.
 
-endmenu
-
 endif
 
 menu "Floating point emulation"
--- rc1-a/./arch/i386/kernel/cpu/cpufreq/Kconfig	2005-06-30 11:21:18.000000000 +0200
+++ rc1-b/./arch/i386/kernel/cpu/cpufreq/Kconfig	2005-07-04 12:39:29.000000000 +0200
@@ -2,8 +2,6 @@
 # CPU Frequency scaling
 #
 
-menu "CPU Frequency scaling"
-
 source "drivers/cpufreq/Kconfig"
 
 if CPU_FREQ
@@ -239,5 +237,3 @@ config X86_SPEEDSTEP_RELAXED_CAP_CHECK
 	  parameter "relaxed_check=1" is passed to the module.
 
 endif	# CPU_FREQ
-
-endmenu
--- rc1-a/./arch/x86_64/kernel/cpufreq/Kconfig	2005-06-30 11:21:31.000000000 +0200
+++ rc1-b/./arch/x86_64/kernel/cpufreq/Kconfig	2005-07-04 12:39:29.000000000 +0200
@@ -2,8 +2,6 @@
 # CPU Frequency scaling
 #
 
-menu "CPU Frequency scaling"
-
 source "drivers/cpufreq/Kconfig"
 
 if CPU_FREQ
@@ -92,5 +90,3 @@ config X86_SPEEDSTEP_LIB
 
 endif
 
-endmenu
-

-- 
Top 100 things you don't want the sysadmin to say:
97. Go get your backup tape. (You _do_ have a backup tape?)
