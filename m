Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263726AbUBOAvY (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Feb 2004 19:51:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263742AbUBOAvY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Feb 2004 19:51:24 -0500
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:29869 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S263726AbUBOAvB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Feb 2004 19:51:01 -0500
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] move CONFIG_HOTPLUG to kernel/Kconfig.hotplug
Date: Sun, 15 Feb 2004 01:57:05 +0100
User-Agent: KMail/1.5.3
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200402150157.05808.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I've also noticed that some archs (cris, h8300, m68k and sparc) don't
have HOTPLUG in their Kconfig files, shame on you - no udev for you 8).

BTW maybe HOTPLUG should be moved from "Bus options" to "General setup"?

 linux-2.6.3-rc2-bk4-root/arch/alpha/Kconfig     |   18 +-----------------
 linux-2.6.3-rc2-bk4-root/arch/arm/Kconfig       |   18 +-----------------
 linux-2.6.3-rc2-bk4-root/arch/arm26/Kconfig     |   18 +-----------------
 linux-2.6.3-rc2-bk4-root/arch/i386/Kconfig      |   18 +-----------------
 linux-2.6.3-rc2-bk4-root/arch/ia64/Kconfig      |   18 +-----------------
 linux-2.6.3-rc2-bk4-root/arch/m68knommu/Kconfig |   18 +-----------------
 linux-2.6.3-rc2-bk4-root/arch/mips/Kconfig      |   18 +-----------------
 linux-2.6.3-rc2-bk4-root/arch/ppc/Kconfig       |   18 +-----------------
 linux-2.6.3-rc2-bk4-root/arch/ppc64/Kconfig     |   18 +-----------------
 linux-2.6.3-rc2-bk4-root/arch/sh/Kconfig        |   18 +-----------------
 linux-2.6.3-rc2-bk4-root/arch/sparc64/Kconfig   |   18 +-----------------
 linux-2.6.3-rc2-bk4-root/arch/v850/Kconfig      |   18 +-----------------
 linux-2.6.3-rc2-bk4-root/arch/x86_64/Kconfig    |   18 +-----------------
 linux-2.6.3-rc2-bk4-root/drivers/parisc/Kconfig |   18 +-----------------
 linux-2.6.3-rc2-bk4-root/drivers/s390/Kconfig   |   18 ------------------
 linux-2.6.3-rc2-bk4-root/kernel/Kconfig.hotplug |   17 +++++++++++++++++
 16 files changed, 31 insertions(+), 256 deletions(-)

diff -puN arch/alpha/Kconfig~Kconfig_hotplug arch/alpha/Kconfig
--- linux-2.6.3-rc2-bk4/arch/alpha/Kconfig~Kconfig_hotplug	2004-02-15 01:17:55.118977544 +0100
+++ linux-2.6.3-rc2-bk4-root/arch/alpha/Kconfig	2004-02-15 01:18:51.502405960 +0100
@@ -569,23 +569,7 @@ config VERBOSE_MCHECK_ON
 source "drivers/pci/Kconfig"
 source "drivers/eisa/Kconfig"
 
-config HOTPLUG
-	bool "Support for hot-pluggable devices"
-	---help---
-	  Say Y here if you want to plug devices into your computer while
-	  the system is running, and be able to use them quickly.  In many
-	  cases, the devices can likewise be unplugged at any time too.
-
-	  One well known example of this is PCMCIA- or PC-cards, credit-card
-	  size devices such as network cards, modems or hard drives which are
-	  plugged into slots found on all modern laptop computers.  Another
-	  example, used on modern desktops as well as laptops, is USB.
-
-	  Enable HOTPLUG and KMOD, and build a modular kernel.  Get agent
-	  software (at <http://linux-hotplug.sourceforge.net/>) and install it.
-	  Then your kernel will automatically call out to a user mode "policy
-	  agent" (/sbin/hotplug) to load modules and set up software needed
-	  to use devices as you hotplug them.
+source "kernel/Kconfig.hotplug"
 
 source "drivers/pcmcia/Kconfig"
 
diff -puN arch/arm26/Kconfig~Kconfig_hotplug arch/arm26/Kconfig
--- linux-2.6.3-rc2-bk4/arch/arm26/Kconfig~Kconfig_hotplug	2004-02-15 01:16:53.573333904 +0100
+++ linux-2.6.3-rc2-bk4-root/arch/arm26/Kconfig	2004-02-15 01:17:19.321419600 +0100
@@ -118,23 +118,7 @@ config XIP_KERNEL
 	  Select this option to create a kernel that can be programed into
 	  the OS ROMs.
 
-config HOTPLUG
-	bool "Support for hot-pluggable devices"
-	---help---
-	  Say Y here if you want to plug devices into your computer while
-	  the system is running, and be able to use them quickly.  In many
-	  cases, the devices can likewise be unplugged at any time too.
-
-	  One well known example of this is PCMCIA- or PC-cards, credit-card
-	  size devices such as network cards, modems or hard drives which are
-	  plugged into slots found on all modern laptop computers.  Another
-	  example, used on modern desktops as well as laptops, is USB.
-
-	  Enable HOTPLUG and KMOD, and build a modular kernel.  Get agent
-	  software (at <http://linux-hotplug.sourceforge.net/>) and install it.
-	  Then your kernel will automatically call out to a user mode "policy
-	  agent" (/sbin/hotplug) to load modules and set up software needed
-	  to use devices as you hotplug them.
+source "kernel/Kconfig.hotplug"
 
 comment "At least one math emulation must be selected"
 
diff -puN arch/arm/Kconfig~Kconfig_hotplug arch/arm/Kconfig
--- linux-2.6.3-rc2-bk4/arch/arm/Kconfig~Kconfig_hotplug	2004-02-15 01:19:03.363602784 +0100
+++ linux-2.6.3-rc2-bk4-root/arch/arm/Kconfig	2004-02-15 01:19:25.845185064 +0100
@@ -365,23 +365,7 @@ endif
 
 source "drivers/pci/Kconfig"
 
-config HOTPLUG
-	bool "Support for hot-pluggable devices"
-	---help---
-	  Say Y here if you want to plug devices into your computer while
-	  the system is running, and be able to use them quickly.  In many
-	  cases, the devices can likewise be unplugged at any time too.
-
-	  One well known example of this is PCMCIA- or PC-cards, credit-card
-	  size devices such as network cards, modems or hard drives which are
-	  plugged into slots found on all modern laptop computers.  Another
-	  example, used on modern desktops as well as laptops, is USB.
-
-	  Enable HOTPLUG and KMOD, and build a modular kernel.  Get agent
-	  software (at <http://linux-hotplug.sourceforge.net/>) and install it.
-	  Then your kernel will automatically call out to a user mode "policy
-	  agent" (/sbin/hotplug) to load modules and set up software needed
-	  to use devices as you hotplug them.
+source "kernel/Kconfig.hotplug"
 
 source "drivers/pcmcia/Kconfig"
 
diff -puN arch/i386/Kconfig~Kconfig_hotplug arch/i386/Kconfig
--- linux-2.6.3-rc2-bk4/arch/i386/Kconfig~Kconfig_hotplug	2004-02-15 01:07:00.758455464 +0100
+++ linux-2.6.3-rc2-bk4-root/arch/i386/Kconfig	2004-02-15 01:13:19.196924072 +0100
@@ -1131,23 +1131,7 @@ config SCx200
 	  This support is also available as a module.  If compiled as a
 	  module, it will be called scx200.
 
-config HOTPLUG
-	bool "Support for hot-pluggable devices"
-	---help---
-	  Say Y here if you want to plug devices into your computer while
-	  the system is running, and be able to use them quickly.  In many
-	  cases, the devices can likewise be unplugged at any time too.
-
-	  One well known example of this is PCMCIA- or PC-cards, credit-card
-	  size devices such as network cards, modems or hard drives which are
-	  plugged into slots found on all modern laptop computers.  Another
-	  example, used on modern desktops as well as laptops, is USB.
-
-	  Enable HOTPLUG and KMOD, and build a modular kernel.  Get agent
-	  software (at <http://linux-hotplug.sourceforge.net/>) and install it.
-	  Then your kernel will automatically call out to a user mode "policy
-	  agent" (/sbin/hotplug) to load modules and set up software needed
-	  to use devices as you hotplug them.
+source "kernel/Kconfig.hotplug"
 
 source "drivers/pcmcia/Kconfig"
 
diff -puN arch/ia64/Kconfig~Kconfig_hotplug arch/ia64/Kconfig
--- linux-2.6.3-rc2-bk4/arch/ia64/Kconfig~Kconfig_hotplug	2004-02-15 01:19:55.684648776 +0100
+++ linux-2.6.3-rc2-bk4-root/arch/ia64/Kconfig	2004-02-15 01:20:36.384461464 +0100
@@ -439,23 +439,7 @@ config PCI_DOMAINS
 
 source "drivers/pci/Kconfig"
 
-config HOTPLUG
-	bool "Support for hot-pluggable devices"
-	help
-	  Say Y here if you want to plug devices into your computer while
-	  the system is running, and be able to use them quickly.  In many
-	  cases, the devices can likewise be unplugged at any time too.
-
-	  One well known example of this is PCMCIA- or PC-cards, credit-card
-	  size devices such as network cards, modems or hard drives which are
-	  plugged into slots found on all modern laptop computers.  Another
-	  example, used on modern desktops as well as laptops, is USB.
-
-	  Enable HOTPLUG and KMOD, and build a modular kernel.  Get agent
-	  software (at <http://linux-hotplug.sourceforge.net/>) and install it.
-	  Then your kernel will automatically call out to a user mode "policy
-	  agent" (/sbin/hotplug) to load modules and set up software needed
-	  to use devices as you hotplug them.
+source "kernel/Kconfig.hotplug"
 
 source "drivers/pci/hotplug/Kconfig"
 
diff -puN arch/m68knommu/Kconfig~Kconfig_hotplug arch/m68knommu/Kconfig
--- linux-2.6.3-rc2-bk4/arch/m68knommu/Kconfig~Kconfig_hotplug	2004-02-15 01:11:48.543705456 +0100
+++ linux-2.6.3-rc2-bk4-root/arch/m68knommu/Kconfig	2004-02-15 01:13:08.500550168 +0100
@@ -464,23 +464,7 @@ config COMEMPCI
 
 source "drivers/pci/Kconfig"
 
-config HOTPLUG
-	bool "Support for hot-pluggable device"
-	  ---help---
-	  Say Y here if you want to plug devices into your computer while
-	  the system is running, and be able to use them quickly.  In many
-	  cases, the devices can likewise be unplugged at any time too.
-
-	  One well known example of this is PCMCIA- or PC-cards, credit-card
-	  size devices such as network cards, modems or hard drives which are
-	  plugged into slots found on all modern laptop computers.  Another
-	  example, used on modern desktops as well as laptops, is USB.
-
-	  Enable HOTPLUG and KMOD, and build a modular kernel.  Get agent
-	  software (at <http://linux-hotplug.sourceforge.net/>) and install it.
-	  Then your kernel will automatically call out to a user mode "policy
-	  agent" (/sbin/hotplug) to load modules and set up software needed
-	  to use devices as you hotplug them.
+source "kernel/Kconfig.hotplug"
 
 source "drivers/pcmcia/Kconfig"
 
diff -puN arch/mips/Kconfig~Kconfig_hotplug arch/mips/Kconfig
--- linux-2.6.3-rc2-bk4/arch/mips/Kconfig~Kconfig_hotplug	2004-02-15 01:21:28.093600480 +0100
+++ linux-2.6.3-rc2-bk4-root/arch/mips/Kconfig	2004-02-15 01:22:15.614376224 +0100
@@ -1104,23 +1104,7 @@ config MCA
 config SBUS
 	bool
 
-config HOTPLUG
-	bool "Support for hot-pluggable devices"
-	---help---
-	  Say Y here if you want to plug devices into your computer while
-	  the system is running, and be able to use them quickly.  In many
-	  cases, the devices can likewise be unplugged at any time too.
-
-	  One well known example of this is PCMCIA- or PC-cards, credit-card
-	  size devices such as network cards, modems or hard drives which are
-	  plugged into slots found on all modern laptop computers.  Another
-	  example, used on modern desktops as well as laptops, is USB.
-
-	  Enable HOTPLUG and KMOD, and build a modular kernel.  Get agent
-	  software (at <http://linux-hotplug.sourceforge.net/>) and install it.
-	  Then your kernel will automatically call out to a user mode "policy
-	  agent" (/sbin/hotplug) to load modules and set up software needed
-	  to use devices as you hotplug them.
+source "kernel/Kconfig.hotplug"
 
 source "drivers/pcmcia/Kconfig"
 
diff -puN arch/ppc64/Kconfig~Kconfig_hotplug arch/ppc64/Kconfig
--- linux-2.6.3-rc2-bk4/arch/ppc64/Kconfig~Kconfig_hotplug	2004-02-15 01:16:06.581477752 +0100
+++ linux-2.6.3-rc2-bk4-root/arch/ppc64/Kconfig	2004-02-15 01:16:35.988007280 +0100
@@ -227,23 +227,7 @@ source "fs/Kconfig.binfmt"
 
 source "drivers/pci/Kconfig"
 
-config HOTPLUG
-	bool "Support for hot-pluggable devices"
-	---help---
-	  Say Y here if you want to plug devices into your computer while
-	  the system is running, and be able to use them quickly.  In many
-	  cases, the devices can likewise be unplugged at any time too.
-
-	  One well known example of this is PCMCIA- or PC-cards, credit-card
-	  size devices such as network cards, modems or hard drives which are
-	  plugged into slots found on all modern laptop computers.  Another
-	  example, used on modern desktops as well as laptops, is USB.
-
-	  Enable HOTPLUG and KMOD, and build a modular kernel.  Get agent
-	  software (at <http://linux-hotplug.sourceforge.net/>) and install it.
-	  Then your kernel will automatically call out to a user mode "policy
-	  agent" (/sbin/hotplug) to load modules and set up software needed
-	  to use devices as you hotplug them.
+source "kernel/Kconfig.hotplug"
 
 source "drivers/pcmcia/Kconfig"
 
diff -puN arch/ppc/Kconfig~Kconfig_hotplug arch/ppc/Kconfig
--- linux-2.6.3-rc2-bk4/arch/ppc/Kconfig~Kconfig_hotplug	2004-02-15 01:22:44.675958192 +0100
+++ linux-2.6.3-rc2-bk4-root/arch/ppc/Kconfig	2004-02-15 01:23:28.560286760 +0100
@@ -978,23 +978,7 @@ config PCI_PERMEDIA
 
 source "drivers/pci/Kconfig"
 
-config HOTPLUG
-	bool "Support for hot-pluggable devices"
-	---help---
-	  Say Y here if you want to plug devices into your computer while
-	  the system is running, and be able to use them quickly.  In many
-	  cases, the devices can likewise be unplugged at any time too.
-
-	  One well known example of this is PCMCIA- or PC-cards, credit-card
-	  size devices such as network cards, modems or hard drives which are
-	  plugged into slots found on all modern laptop computers.  Another
-	  example, used on modern desktops as well as laptops, is USB.
-
-	  Enable HOTPLUG and KMOD, and build a modular kernel.  Get agent
-	  software (at <http://linux-hotplug.sourceforge.net/>) and install it.
-	  Then your kernel will automatically call out to a user mode "policy
-	  agent" (/sbin/hotplug) to load modules and set up software needed
-	  to use devices as you hotplug them.
+source "kernel/Kconfig.hotplug"
 
 source "drivers/pcmcia/Kconfig"
 
diff -puN arch/sh/Kconfig~Kconfig_hotplug arch/sh/Kconfig
--- linux-2.6.3-rc2-bk4/arch/sh/Kconfig~Kconfig_hotplug	2004-02-15 01:23:48.093317288 +0100
+++ linux-2.6.3-rc2-bk4-root/arch/sh/Kconfig	2004-02-15 01:24:24.397798168 +0100
@@ -609,23 +609,7 @@ source "arch/sh/drivers/pci/Kconfig"
 
 source "drivers/pci/Kconfig"
 
-config HOTPLUG
-	bool "Support for hot-pluggable devices"
-	---help---
-	  Say Y here if you want to plug devices into your computer while
-	  the system is running, and be able to use them quickly.  In many
-	  cases, the devices can likewise be unplugged at any time too.
-
-	  One well known example of this is PCMCIA- or PC-cards, credit-card
-	  size devices such as network cards, modems or hard drives which are
-	  plugged into slots found on all modern laptop computers.  Another
-	  example, used on modern desktops as well as laptops, is USB.
-
-	  Enable HOTPLUG and KMOD, and build a modular kernel.  Get agent
-	  software (at <http://linux-hotplug.sourceforge.net/>) and install it.
-	  Then your kernel will automatically call out to a user mode "policy
-	  agent" (/sbin/hotplug) to load modules and set up software needed
-	  to use devices as you hotplug them.
+source "kernel/Kconfig.hotplug"
 
 source "drivers/pcmcia/Kconfig"
 
diff -puN arch/sparc64/Kconfig~Kconfig_hotplug arch/sparc64/Kconfig
--- linux-2.6.3-rc2-bk4/arch/sparc64/Kconfig~Kconfig_hotplug	2004-02-15 01:15:16.056158768 +0100
+++ linux-2.6.3-rc2-bk4-root/arch/sparc64/Kconfig	2004-02-15 01:15:54.780271808 +0100
@@ -186,23 +186,7 @@ config SPARC64
 	  SPARC64 ports; its web page is available at
 	  <http://www.ultralinux.org/>.
 
-config HOTPLUG
-	bool "Support for hot-pluggable devices"
-	---help---
-	  Say Y here if you want to plug devices into your computer while
-	  the system is running, and be able to use them quickly.  In many
-	  cases, the devices can likewise be unplugged at any time too.
-
-	  One well known example of this is PCMCIA- or PC-cards, credit-card
-	  size devices such as network cards, modems or hard drives which are
-	  plugged into slots found on all modern laptop computers.  Another
-	  example, used on modern desktops as well as laptops, is USB.
-
-	  Enable HOTPLUG and KMOD, and build a modular kernel.  Get agent
-	  software (at <http://linux-hotplug.sourceforge.net/>) and install it.
-	  Then your kernel will automatically call out to a user mode "policy
-	  agent" (/sbin/hotplug) to load modules and set up software needed
-	  to use devices as you hotplug them.
+source "kernel/Kconfig.hotplug"
 
 # Global things across all Sun machines.
 config RWSEM_GENERIC_SPINLOCK
diff -puN arch/v850/Kconfig~Kconfig_hotplug arch/v850/Kconfig
--- linux-2.6.3-rc2-bk4/arch/v850/Kconfig~Kconfig_hotplug	2004-02-15 01:24:48.776092104 +0100
+++ linux-2.6.3-rc2-bk4-root/arch/v850/Kconfig	2004-02-15 01:25:22.365985664 +0100
@@ -236,23 +236,7 @@ menu "Bus options (PCI, PCMCIA, EISA, MC
 
 source "drivers/pci/Kconfig"
 
-config HOTPLUG
-	bool "Support for hot-pluggable device"
-	  ---help---
-	  Say Y here if you want to plug devices into your computer while
-	  the system is running, and be able to use them quickly.  In many
-	  cases, the devices can likewise be unplugged at any time too.
-
-	  One well known example of this is PCMCIA- or PC-cards, credit-card
-	  size devices such as network cards, modems or hard drives which are
-	  plugged into slots found on all modern laptop computers.  Another
-	  example, used on modern desktops as well as laptops, is USB.
-
-	  Enable HOTPLUG and KMOD, and build a modular kernel.  Get agent
-	  software (at <http://linux-hotplug.sourceforge.net/>) and install it.
-	  Then your kernel will automatically call out to a user mode "policy
-	  agent" (/sbin/hotplug) to load modules and set up software needed
-	  to use devices as you hotplug them.
+source "kernel/Kconfig.hotplug"
 
 source "drivers/pcmcia/Kconfig"
 
diff -puN arch/x86_64/Kconfig~Kconfig_hotplug arch/x86_64/Kconfig
--- linux-2.6.3-rc2-bk4/arch/x86_64/Kconfig~Kconfig_hotplug	2004-02-15 01:13:37.002217256 +0100
+++ linux-2.6.3-rc2-bk4-root/arch/x86_64/Kconfig	2004-02-15 01:14:37.996944648 +0100
@@ -315,23 +315,7 @@ config PCI_USE_VECTOR
 
 source "drivers/pci/Kconfig"
 
-config HOTPLUG
-	bool "Support for hot-pluggable devices"
-	---help---
-	  Say Y here if you want to plug devices into your computer while
-	  the system is running, and be able to use them quickly.  In many
-	  cases, the devices can likewise be unplugged at any time too.
-
-	  One well-known example of this is PCMCIA- or PC-cards, credit-card
-	  size devices such as network cards, modems, or hard drives which are
-	  plugged into slots found on all modern laptop computers.  Another
-	  example, used on modern desktops as well as laptops, is USB.
-
-	  Enable HOTPLUG and KMOD, and build a modular kernel.  Get agent
-	  software (at <http://linux-hotplug.sourceforge.net/>) and install it.
-	  Then your kernel will automatically call out to a user mode "policy
-	  agent" (/sbin/hotplug) to load modules and set up software needed
-	  to use devices as you hotplug them.
+source "kernel/Kconfig.hotplug"
 
 source "drivers/pcmcia/Kconfig"
 
diff -puN drivers/parisc/Kconfig~Kconfig_hotplug drivers/parisc/Kconfig
--- linux-2.6.3-rc2-bk4/drivers/parisc/Kconfig~Kconfig_hotplug	2004-02-15 01:51:06.950173176 +0100
+++ linux-2.6.3-rc2-bk4-root/drivers/parisc/Kconfig	2004-02-15 01:51:40.267108232 +0100
@@ -143,24 +143,8 @@ config PDC_CHASSIS
 	  This has nothing to do with Chassis LCD and LED support.
 	  
 	  If unsure, say Y.
- 
-config HOTPLUG
-	bool "Support for hot-pluggable devices"
-	---help---
-	  Say Y here if you want to plug devices into your computer while
-	  the system is running, and be able to use them quickly.  In many
-	  cases, the devices can likewise be unplugged at any time too.
 
-	  One well known example of this is PCMCIA- or PC-cards, credit-card
-	  size devices such as network cards, modems or hard drives which are
-	  plugged into slots found on all modern laptop computers.  Another
-	  example, used on modern desktops as well as laptops, is USB.
-
-	  Enable HOTPLUG and KMOD, and build a modular kernel.  Get agent
-	  software (at <http://linux-hotplug.sourceforge.net/>) and install it.
-	  Then your kernel will automatically call out to a user mode "policy
-	  agent" (/sbin/hotplug) to load modules and set up software needed
-	  to use devices as you hotplug them.
+source "kernel/Kconfig.hotplug"
 
 source "drivers/pcmcia/Kconfig"
 
diff -puN drivers/s390/Kconfig~Kconfig_hotplug drivers/s390/Kconfig
--- linux-2.6.3-rc2-bk4/drivers/s390/Kconfig~Kconfig_hotplug	2004-02-15 01:42:36.325799880 +0100
+++ linux-2.6.3-rc2-bk4-root/drivers/s390/Kconfig	2004-02-15 01:50:29.467871352 +0100
@@ -165,24 +165,6 @@ config S390_TAPE_34XX
 
 endmenu
 
-
 config HOTPLUG
 	bool
 	default y
-	---help---
-	  Say Y here if you want to plug devices into your computer while
-	  the system is running, and be able to use them quickly.  In many
-	  cases, the devices can likewise be unplugged at any time too.
-
-	  One well known example of this is PCMCIA- or PC-cards, credit-card
-	  size devices such as network cards, modems or hard drives which are
-	  plugged into slots found on all modern laptop computers.  Another
-	  example, used on modern desktops as well as laptops, is USB.
-
-	  Enable HOTPLUG and KMOD, and build a modular kernel.  Get agent
-	  software (at <http://linux-hotplug.sourceforge.net/>) and install it.
-	  Then your kernel will automatically call out to a user mode "policy
-	  agent" (/sbin/hotplug) to load modules and set up software needed
-	  to use devices as you hotplug them.
-
-
diff -puN /dev/null kernel/Kconfig.hotplug
--- /dev/null	2004-01-17 00:25:55.000000000 +0100
+++ linux-2.6.3-rc2-bk4-root/kernel/Kconfig.hotplug	2004-02-15 01:49:57.404745688 +0100
@@ -0,0 +1,17 @@
+config HOTPLUG
+	bool "Support for hot-pluggable devices"
+	help
+	  Say Y here if you want to plug devices into your computer while
+	  the system is running, and be able to use them quickly.  In many
+	  cases, the devices can likewise be unplugged at any time too.
+
+	  One well known example of this is PCMCIA- or PC-cards, credit-card
+	  size devices such as network cards, modems or hard drives which are
+	  plugged into slots found on all modern laptop computers.  Another
+	  example, used on modern desktops as well as laptops, is USB.
+
+	  Enable HOTPLUG and KMOD, and build a modular kernel.  Get agent
+	  software (at <http://linux-hotplug.sourceforge.net/>) and install it.
+	  Then your kernel will automatically call out to a user mode "policy
+	  agent" (/sbin/hotplug) to load modules and set up software needed
+	  to use devices as you hotplug them.

_

