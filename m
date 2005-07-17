Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261276AbVGQLfQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261276AbVGQLfQ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Jul 2005 07:35:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261270AbVGQLfP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Jul 2005 07:35:15 -0400
Received: from mail-in-07.arcor-online.net ([151.189.21.47]:57518 "EHLO
	mail-in-07.arcor-online.net") by vger.kernel.org with ESMTP
	id S261263AbVGQLdQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Jul 2005 07:33:16 -0400
Date: Sun, 17 Jul 2005 13:33:35 +0200 (CEST)
From: Bodo Eggert <7eggert@gmx.de>
To: Bodo Eggert <7eggert@gmx.de>
cc: akpm@osdl.org, torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] [4/5+1] menu -> menuconfig part 1
In-Reply-To: <Pine.LNX.4.58.0507171311400.5931@be1.lrz>
Message-ID: <Pine.LNX.4.58.0507171332090.6041@be1.lrz>
References: <Pine.LNX.4.58.0507171311400.5931@be1.lrz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-be10.7eggert.dyndns.org-MailScanner-Information: See www.mailscanner.info for information
X-be10.7eggert.dyndns.org-MailScanner: Found to be clean
X-be10.7eggert.dyndns.org-MailScanner-From: 7eggert@web.de
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 17 Jul 2005, Bodo Eggert wrote:

> These patches change some menus into menuconfig options.
> 
> Reworked to apply to linux-2.6.13-rc3-git3

CPU frequency scaling menu

 arch/arm/Kconfig                     |    4 ----
 arch/i386/kernel/cpu/cpufreq/Kconfig |    4 ----
 arch/sh/Kconfig                      |    4 ----
 arch/x86_64/kernel/cpufreq/Kconfig   |    4 ----
 drivers/cpufreq/Kconfig              |    2 +-
 5 files changed, 1 insertion(+), 17 deletions(-)

Signed-Off-By: Bodo Eggert <7eggert@gmx.de>

diff -rNup a/arch/arm/Kconfig b/arch/arm/Kconfig
--- a/arch/arm/Kconfig	2005-07-17 08:09:33.000000000 +0200
+++ b/arch/arm/Kconfig	2005-07-17 11:25:40.000000000 +0200
@@ -518,8 +518,6 @@ endmenu
 
 if (ARCH_SA1100 || ARCH_INTEGRATOR || ARCH_OMAP1)
 
-menu "CPU Frequency scaling"
-
 source "drivers/cpufreq/Kconfig"
 
 config CPU_FREQ_SA1100
@@ -543,8 +541,6 @@ config CPU_FREQ_INTEGRATOR
 
 	  If in doubt, say Y.
 
-endmenu
-
 endif
 
 menu "Floating point emulation"
diff -rNup a/arch/i386/kernel/cpu/cpufreq/Kconfig b/arch/i386/kernel/cpu/cpufreq/Kconfig
--- a/arch/i386/kernel/cpu/cpufreq/Kconfig	2005-07-17 08:08:24.000000000 +0200
+++ b/arch/i386/kernel/cpu/cpufreq/Kconfig	2005-07-17 11:25:40.000000000 +0200
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
diff -rNup a/arch/sh/Kconfig b/arch/sh/Kconfig
--- a/arch/sh/Kconfig	2005-07-17 08:09:35.000000000 +0200
+++ b/arch/sh/Kconfig	2005-07-17 11:25:40.000000000 +0200
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
diff -rNup a/arch/x86_64/kernel/cpufreq/Kconfig b/arch/x86_64/kernel/cpufreq/Kconfig
--- a/arch/x86_64/kernel/cpufreq/Kconfig	2005-07-17 08:08:37.000000000 +0200
+++ b/arch/x86_64/kernel/cpufreq/Kconfig	2005-07-17 11:25:40.000000000 +0200
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
diff -rNup a/drivers/cpufreq/Kconfig b/drivers/cpufreq/Kconfig
--- a/drivers/cpufreq/Kconfig	2005-07-17 08:08:43.000000000 +0200
+++ b/drivers/cpufreq/Kconfig	2005-07-17 11:31:18.000000000 +0200
@@ -1,4 +1,4 @@
-config CPU_FREQ
+menuconfig CPU_FREQ
 	bool "CPU Frequency scaling"
 	help
 	  CPU Frequency scaling allows you to change the clock speed of 

-- 
The most dangerous thing in the world is a second lieutenant with a map and
a compass.
