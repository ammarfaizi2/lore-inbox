Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261262AbUBTTk5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Feb 2004 14:40:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261363AbUBTTk4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Feb 2004 14:40:56 -0500
Received: from mail.kroah.org ([65.200.24.183]:62693 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261262AbUBTTGV convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Feb 2004 14:06:21 -0500
Subject: Re: [PATCH] PCI update for 2.6.3
In-Reply-To: <10773039802393@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Fri, 20 Feb 2004 11:06:21 -0800
Message-Id: <10773039813376@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org, pcihpd-discuss@lists.sourceforge.net
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1557.58.9, 2004/02/18 15:25:48-08:00, B.Zolnierkiewicz@elka.pw.edu.pl

[PATCH] move CONFIG_HOTPLUG to init/Kconfig

As a bonus: cris, h8300, m68k and sparc can use CONFIG_HOTPLUG now.


 arch/alpha/Kconfig     |   18 ------------------
 arch/arm/Kconfig       |   18 ------------------
 arch/arm26/Kconfig     |   18 ------------------
 arch/i386/Kconfig      |   18 ------------------
 arch/ia64/Kconfig      |   18 ------------------
 arch/m68knommu/Kconfig |   18 ------------------
 arch/mips/Kconfig      |   18 ------------------
 arch/ppc/Kconfig       |   18 ------------------
 arch/ppc64/Kconfig     |   18 ------------------
 arch/sh/Kconfig        |   18 ------------------
 arch/sparc64/Kconfig   |   18 ------------------
 arch/v850/Kconfig      |   18 ------------------
 arch/x86_64/Kconfig    |   18 ------------------
 drivers/parisc/Kconfig |   18 ------------------
 drivers/s390/Kconfig   |   22 ----------------------
 init/Kconfig           |   19 +++++++++++++++++++
 16 files changed, 19 insertions(+), 274 deletions(-)


diff -Nru a/arch/alpha/Kconfig b/arch/alpha/Kconfig
--- a/arch/alpha/Kconfig	Fri Feb 20 10:44:37 2004
+++ b/arch/alpha/Kconfig	Fri Feb 20 10:44:37 2004
@@ -569,24 +569,6 @@
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
-
 source "drivers/pcmcia/Kconfig"
 
 config SRM_ENV
diff -Nru a/arch/arm/Kconfig b/arch/arm/Kconfig
--- a/arch/arm/Kconfig	Fri Feb 20 10:44:37 2004
+++ b/arch/arm/Kconfig	Fri Feb 20 10:44:37 2004
@@ -365,24 +365,6 @@
 
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
-
 source "drivers/pcmcia/Kconfig"
 
 comment "At least one math emulation must be selected"
diff -Nru a/arch/arm26/Kconfig b/arch/arm26/Kconfig
--- a/arch/arm26/Kconfig	Fri Feb 20 10:44:37 2004
+++ b/arch/arm26/Kconfig	Fri Feb 20 10:44:37 2004
@@ -118,24 +118,6 @@
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
-
 comment "At least one math emulation must be selected"
 
 config FPE_NWFPE
diff -Nru a/arch/i386/Kconfig b/arch/i386/Kconfig
--- a/arch/i386/Kconfig	Fri Feb 20 10:44:37 2004
+++ b/arch/i386/Kconfig	Fri Feb 20 10:44:37 2004
@@ -1131,24 +1131,6 @@
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
-
 source "drivers/pcmcia/Kconfig"
 
 source "drivers/pci/hotplug/Kconfig"
diff -Nru a/arch/ia64/Kconfig b/arch/ia64/Kconfig
--- a/arch/ia64/Kconfig	Fri Feb 20 10:44:37 2004
+++ b/arch/ia64/Kconfig	Fri Feb 20 10:44:37 2004
@@ -439,24 +439,6 @@
 
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
-
 source "drivers/pci/hotplug/Kconfig"
 
 source "drivers/pcmcia/Kconfig"
diff -Nru a/arch/m68knommu/Kconfig b/arch/m68knommu/Kconfig
--- a/arch/m68knommu/Kconfig	Fri Feb 20 10:44:37 2004
+++ b/arch/m68knommu/Kconfig	Fri Feb 20 10:44:37 2004
@@ -464,24 +464,6 @@
 
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
-
 source "drivers/pcmcia/Kconfig"
 
 source "drivers/pci/hotplug/Kconfig"
diff -Nru a/arch/mips/Kconfig b/arch/mips/Kconfig
--- a/arch/mips/Kconfig	Fri Feb 20 10:44:37 2004
+++ b/arch/mips/Kconfig	Fri Feb 20 10:44:37 2004
@@ -1104,24 +1104,6 @@
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
-
 source "drivers/pcmcia/Kconfig"
 
 source "drivers/pci/hotplug/Kconfig"
diff -Nru a/arch/ppc/Kconfig b/arch/ppc/Kconfig
--- a/arch/ppc/Kconfig	Fri Feb 20 10:44:37 2004
+++ b/arch/ppc/Kconfig	Fri Feb 20 10:44:37 2004
@@ -978,24 +978,6 @@
 
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
-
 source "drivers/pcmcia/Kconfig"
 
 endmenu
diff -Nru a/arch/ppc64/Kconfig b/arch/ppc64/Kconfig
--- a/arch/ppc64/Kconfig	Fri Feb 20 10:44:37 2004
+++ b/arch/ppc64/Kconfig	Fri Feb 20 10:44:37 2004
@@ -227,24 +227,6 @@
 
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
-
 source "drivers/pcmcia/Kconfig"
 
 source "drivers/pci/hotplug/Kconfig"
diff -Nru a/arch/sh/Kconfig b/arch/sh/Kconfig
--- a/arch/sh/Kconfig	Fri Feb 20 10:44:37 2004
+++ b/arch/sh/Kconfig	Fri Feb 20 10:44:37 2004
@@ -609,24 +609,6 @@
 
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
-
 source "drivers/pcmcia/Kconfig"
 
 source "drivers/pci/hotplug/Kconfig"
diff -Nru a/arch/sparc64/Kconfig b/arch/sparc64/Kconfig
--- a/arch/sparc64/Kconfig	Fri Feb 20 10:44:37 2004
+++ b/arch/sparc64/Kconfig	Fri Feb 20 10:44:37 2004
@@ -186,24 +186,6 @@
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
-
 # Global things across all Sun machines.
 config RWSEM_GENERIC_SPINLOCK
 	bool
diff -Nru a/arch/v850/Kconfig b/arch/v850/Kconfig
--- a/arch/v850/Kconfig	Fri Feb 20 10:44:37 2004
+++ b/arch/v850/Kconfig	Fri Feb 20 10:44:37 2004
@@ -236,24 +236,6 @@
 
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
-
 source "drivers/pcmcia/Kconfig"
 
 source "drivers/pci/hotplug/Kconfig"
diff -Nru a/arch/x86_64/Kconfig b/arch/x86_64/Kconfig
--- a/arch/x86_64/Kconfig	Fri Feb 20 10:44:37 2004
+++ b/arch/x86_64/Kconfig	Fri Feb 20 10:44:37 2004
@@ -315,24 +315,6 @@
 
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
-
 source "drivers/pcmcia/Kconfig"
 
 source "drivers/pci/hotplug/Kconfig"
diff -Nru a/drivers/parisc/Kconfig b/drivers/parisc/Kconfig
--- a/drivers/parisc/Kconfig	Fri Feb 20 10:44:37 2004
+++ b/drivers/parisc/Kconfig	Fri Feb 20 10:44:37 2004
@@ -143,24 +143,6 @@
 	  This has nothing to do with Chassis LCD and LED support.
 	  
 	  If unsure, say Y.
- 
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
 
 source "drivers/pcmcia/Kconfig"
 
diff -Nru a/drivers/s390/Kconfig b/drivers/s390/Kconfig
--- a/drivers/s390/Kconfig	Fri Feb 20 10:44:37 2004
+++ b/drivers/s390/Kconfig	Fri Feb 20 10:44:37 2004
@@ -164,25 +164,3 @@
 	  It is safe to say "Y" here.
 
 endmenu
-
-
-config HOTPLUG
-	bool
-	default y
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
diff -Nru a/init/Kconfig b/init/Kconfig
--- a/init/Kconfig	Fri Feb 20 10:44:37 2004
+++ b/init/Kconfig	Fri Feb 20 10:44:37 2004
@@ -137,6 +137,25 @@
 		     13 =>  8 KB
 		     12 =>  4 KB
 
+config HOTPLUG
+	bool "Support for hot-pluggable devices" if !ARCH_S390
+	default ARCH_S390
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
+
 config IKCONFIG
 	bool "Kernel .config support"
 	---help---

