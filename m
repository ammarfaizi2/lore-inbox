Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264380AbUD2Mun@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264380AbUD2Mun (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Apr 2004 08:50:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264367AbUD2Mun
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Apr 2004 08:50:43 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:39428 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S264380AbUD2Mt2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Apr 2004 08:49:28 -0400
Date: Thu, 29 Apr 2004 13:49:25 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] 2/4 MMC layer: configuration + makefiles
Message-ID: <20040429134925.D16407@flint.arm.linux.org.uk>
Mail-Followup-To: Linux Kernel List <linux-kernel@vger.kernel.org>
References: <20040429134824.C16407@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20040429134824.C16407@flint.arm.linux.org.uk>; from rmk+lkml@arm.linux.org.uk on Thu, Apr 29, 2004 at 01:48:24PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add changes to Kconfig / Makefiles to support MMC subsystem.

--- orig/arch/arm/Kconfig	Wed Apr 28 11:52:31 2004
+++ linux/arch/arm/Kconfig	Thu Apr 29 13:32:30 2004
@@ -631,6 +631,8 @@ source "drivers/misc/Kconfig"
 
 source "drivers/usb/Kconfig"
 
+source "drivers/mmc/Kconfig"
+
 
 menu "Kernel hacking"
 
--- orig/drivers/Kconfig	Thu Mar  4 13:25:22 2004
+++ linux/drivers/Kconfig	Thu Apr 29 13:29:42 2004
@@ -52,4 +52,6 @@ source "sound/Kconfig"
 
 source "drivers/usb/Kconfig"
 
+source "drivers/mmc/Kconfig"
+
 endmenu
--- orig/drivers/Makefile	Sat Mar 20 09:22:27 2004
+++ linux/drivers/Makefile	Thu Apr 29 13:36:36 2004
@@ -49,4 +49,5 @@ obj-$(CONFIG_ISDN)		+= isdn/
 obj-$(CONFIG_MCA)		+= mca/
 obj-$(CONFIG_EISA)		+= eisa/
 obj-$(CONFIG_CPU_FREQ)		+= cpufreq/
+obj-$(CONFIG_MMC)		+= mmc/
 obj-y				+= firmware/

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
