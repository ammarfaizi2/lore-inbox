Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261554AbVGDKnS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261554AbVGDKnS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Jul 2005 06:43:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261592AbVGDKnS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Jul 2005 06:43:18 -0400
Received: from mail-in-04.arcor-online.net ([151.189.21.44]:60121 "EHLO
	mail-in-04.arcor-online.net") by vger.kernel.org with ESMTP
	id S261554AbVGDKkr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Jul 2005 06:40:47 -0400
Date: Mon, 4 Jul 2005 12:40:37 +0200 (CEST)
From: Bodo Eggert <7eggert@gmx.de>
To: Bodo Eggert <7eggert@gmx.de>
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Kconfig changes 4: s/menu/menuconfig/ CPU scaling menu
In-Reply-To: <Pine.LNX.4.58.0507041210190.6165@be1.lrz>
Message-ID: <Pine.LNX.4.58.0507041231200.6165@be1.lrz>
References: <Pine.LNX.4.58.0506301152460.11960@be1.lrz>
 <Pine.LNX.4.58.0507041134410.3798@be1.lrz> <Pine.LNX.4.58.0507041210190.6165@be1.lrz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 4 Jul 2005, Bodo Eggert wrote:

Part 4: The CPU scaling menu.

In many config submenus, the first menu option will enable the rest 
of the menu options. For these menus, It's appropriate to use the more 
convenient "menuconfig" keyword.

This patch is designed for 2.6.12 , the patch for .13-rc1 will be sent in 
a reply



--- a/./arch/sh/Kconfig	2005-06-19 14:16:18.000000000 +0200
+++ b/./arch/sh/Kconfig	2005-07-04 12:36:57.000000000 +0200
@@ -655,8 +655,6 @@ config SH_PCLK_FREQ
 	  with an auto-probed frequency which should be considered the proper
 	  value for your hardware.
 
-menu "CPU Frequency scaling"
-
 source "drivers/cpufreq/Kconfig"
 
 config SH_CPU_FREQ
@@ -671,8 +669,6 @@ config SH_CPU_FREQ
 
 	  If unsure, say N.
 
-endmenu
-
 source "arch/sh/drivers/dma/Kconfig"
 
 source "arch/sh/cchips/Kconfig"
--- a/./arch/arm/Kconfig	2005-06-19 14:15:59.000000000 +0200
+++ b/./arch/arm/Kconfig	2005-07-04 12:37:23.000000000 +0200
@@ -491,8 +491,6 @@ endmenu
 
 if (ARCH_SA1100 || ARCH_INTEGRATOR)
 
-menu "CPU Frequency scaling"
-
 source "drivers/cpufreq/Kconfig"
 
 config CPU_FREQ_SA1100
@@ -516,8 +514,6 @@ config CPU_FREQ_INTEGRATOR
 
 	  If in doubt, say Y.
 
-endmenu
-
 endif
 
 menu "Floating point emulation"
--- a/./arch/i386/kernel/cpu/cpufreq/Kconfig	2005-06-19 14:16:03.000000000 +0200
+++ b/./arch/i386/kernel/cpu/cpufreq/Kconfig	2005-07-04 12:27:46.000000000 +0200
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
--- a/./arch/x86_64/kernel/cpufreq/Kconfig	2005-06-19 14:16:25.000000000 +0200
+++ b/./arch/x86_64/kernel/cpufreq/Kconfig	2005-07-04 12:28:05.000000000 +0200
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
To steal information from a person is called plagiarism. To steal
information from the enemy is called gathering intelligence.
