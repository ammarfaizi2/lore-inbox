Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264257AbUBQBYh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Feb 2004 20:24:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264477AbUBQBYh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Feb 2004 20:24:37 -0500
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:45769 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S264257AbUBQBYW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Feb 2004 20:24:22 -0500
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Greg KH <greg@kroah.com>
Subject: Re: [PATCH] move CONFIG_HOTPLUG to kernel/Kconfig.hotplug
Date: Tue, 17 Feb 2004 02:30:38 +0100
User-Agent: KMail/1.5.3
Cc: linux-kernel@vger.kernel.org
References: <200402150157.05808.bzolnier@elka.pw.edu.pl> <20040216233911.GB23911@kroah.com>
In-Reply-To: <20040216233911.GB23911@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200402170230.38839.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 17 of February 2004 00:39, Greg KH wrote:
> On Sun, Feb 15, 2004 at 01:57:05AM +0100, Bartlomiej Zolnierkiewicz wrote:
> > I've also noticed that some archs (cris, h8300, m68k and sparc) don't
> > have HOTPLUG in their Kconfig files, shame on you - no udev for you 8).
> >
> > BTW maybe HOTPLUG should be moved from "Bus options" to "General setup"?
>
> I agree, it should go there, as it affects so much more these days than
> "bus options".
>
> Care to make that change instead?

Done.  I put HOTPLUG between SYSCTL and IKCONFIG.

--bart


[PATCH] move CONFIG_HOTPLUG to init/Kconfig

As a bonus: cris, h8300, m68k and sparc can use CONFIG_HOTPLUG now.

 linux-2.6.3-rc3-root/arch/alpha/Kconfig     |   18 ------------------
 linux-2.6.3-rc3-root/arch/arm/Kconfig       |   18 ------------------
 linux-2.6.3-rc3-root/arch/arm26/Kconfig     |   18 ------------------
 linux-2.6.3-rc3-root/arch/i386/Kconfig      |   18 ------------------
 linux-2.6.3-rc3-root/arch/ia64/Kconfig      |   18 ------------------
 linux-2.6.3-rc3-root/arch/m68knommu/Kconfig |   18 ------------------
 linux-2.6.3-rc3-root/arch/mips/Kconfig      |   18 ------------------
 linux-2.6.3-rc3-root/arch/ppc/Kconfig       |   18 ------------------
 linux-2.6.3-rc3-root/arch/ppc64/Kconfig     |   18 ------------------
 linux-2.6.3-rc3-root/arch/sh/Kconfig        |   18 ------------------
 linux-2.6.3-rc3-root/arch/sparc64/Kconfig   |   18 ------------------
 linux-2.6.3-rc3-root/arch/v850/Kconfig      |   18 ------------------
 linux-2.6.3-rc3-root/arch/x86_64/Kconfig    |   18 ------------------
 linux-2.6.3-rc3-root/drivers/parisc/Kconfig |   18 ------------------
 linux-2.6.3-rc3-root/drivers/s390/Kconfig   |   22 ----------------------
 linux-2.6.3-rc3-root/init/Kconfig           |   19 +++++++++++++++++++
 16 files changed, 19 insertions(+), 274 deletions(-)

diff -puN arch/alpha/Kconfig~Kconfig_hotplug arch/alpha/Kconfig
--- linux-2.6.3-rc3/arch/alpha/Kconfig~Kconfig_hotplug	2004-02-17 01:26:23.418064416 +0100
+++ linux-2.6.3-rc3-root/arch/alpha/Kconfig	2004-02-17 01:36:06.399437776 +0100
@@ -569,24 +569,6 @@ config VERBOSE_MCHECK_ON
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
diff -puN arch/arm26/Kconfig~Kconfig_hotplug arch/arm26/Kconfig
--- linux-2.6.3-rc3/arch/arm26/Kconfig~Kconfig_hotplug	2004-02-17 01:26:23.421063960 +0100
+++ linux-2.6.3-rc3-root/arch/arm26/Kconfig	2004-02-17 01:37:50.036682520 +0100
@@ -118,24 +118,6 @@ config XIP_KERNEL
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
diff -puN arch/arm/Kconfig~Kconfig_hotplug arch/arm/Kconfig
--- linux-2.6.3-rc3/arch/arm/Kconfig~Kconfig_hotplug	2004-02-17 01:26:23.425063352 +0100
+++ linux-2.6.3-rc3-root/arch/arm/Kconfig	2004-02-17 01:36:52.536423888 +0100
@@ -365,24 +365,6 @@ endif
 
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
diff -puN arch/i386/Kconfig~Kconfig_hotplug arch/i386/Kconfig
--- linux-2.6.3-rc3/arch/i386/Kconfig~Kconfig_hotplug	2004-02-17 01:26:23.428062896 +0100
+++ linux-2.6.3-rc3-root/arch/i386/Kconfig	2004-02-17 01:38:55.603714816 +0100
@@ -1131,24 +1131,6 @@ config SCx200
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
diff -puN arch/ia64/Kconfig~Kconfig_hotplug arch/ia64/Kconfig
--- linux-2.6.3-rc3/arch/ia64/Kconfig~Kconfig_hotplug	2004-02-17 01:26:23.434061984 +0100
+++ linux-2.6.3-rc3-root/arch/ia64/Kconfig	2004-02-17 01:39:16.470542576 +0100
@@ -439,24 +439,6 @@ config PCI_DOMAINS
 
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
diff -puN arch/m68knommu/Kconfig~Kconfig_hotplug arch/m68knommu/Kconfig
--- linux-2.6.3-rc3/arch/m68knommu/Kconfig~Kconfig_hotplug	2004-02-17 01:26:23.439061224 +0100
+++ linux-2.6.3-rc3-root/arch/m68knommu/Kconfig	2004-02-17 01:39:53.760873584 +0100
@@ -464,24 +464,6 @@ config COMEMPCI
 
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
diff -puN arch/mips/Kconfig~Kconfig_hotplug arch/mips/Kconfig
--- linux-2.6.3-rc3/arch/mips/Kconfig~Kconfig_hotplug	2004-02-17 01:26:23.442060768 +0100
+++ linux-2.6.3-rc3-root/arch/mips/Kconfig	2004-02-17 01:40:19.633940280 +0100
@@ -1104,24 +1104,6 @@ config MCA
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
diff -puN arch/ppc64/Kconfig~Kconfig_hotplug arch/ppc64/Kconfig
--- linux-2.6.3-rc3/arch/ppc64/Kconfig~Kconfig_hotplug	2004-02-17 01:26:23.445060312 +0100
+++ linux-2.6.3-rc3-root/arch/ppc64/Kconfig	2004-02-17 01:41:28.544464288 +0100
@@ -227,24 +227,6 @@ source "fs/Kconfig.binfmt"
 
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
diff -puN arch/ppc/Kconfig~Kconfig_hotplug arch/ppc/Kconfig
--- linux-2.6.3-rc3/arch/ppc/Kconfig~Kconfig_hotplug	2004-02-17 01:26:23.456058640 +0100
+++ linux-2.6.3-rc3-root/arch/ppc/Kconfig	2004-02-17 01:40:47.148757392 +0100
@@ -978,24 +978,6 @@ config PCI_PERMEDIA
 
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
diff -puN arch/sh/Kconfig~Kconfig_hotplug arch/sh/Kconfig
--- linux-2.6.3-rc3/arch/sh/Kconfig~Kconfig_hotplug	2004-02-17 01:26:23.470056512 +0100
+++ linux-2.6.3-rc3-root/arch/sh/Kconfig	2004-02-17 01:43:39.834505168 +0100
@@ -609,24 +609,6 @@ source "arch/sh/drivers/pci/Kconfig"
 
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
diff -puN arch/sparc64/Kconfig~Kconfig_hotplug arch/sparc64/Kconfig
--- linux-2.6.3-rc3/arch/sparc64/Kconfig~Kconfig_hotplug	2004-02-17 01:26:23.474055904 +0100
+++ linux-2.6.3-rc3-root/arch/sparc64/Kconfig	2004-02-17 01:42:10.323112968 +0100
@@ -186,24 +186,6 @@ config SPARC64
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
diff -puN arch/v850/Kconfig~Kconfig_hotplug arch/v850/Kconfig
--- linux-2.6.3-rc3/arch/v850/Kconfig~Kconfig_hotplug	2004-02-17 01:26:23.478055296 +0100
+++ linux-2.6.3-rc3-root/arch/v850/Kconfig	2004-02-17 01:42:32.369761368 +0100
@@ -236,24 +236,6 @@ menu "Bus options (PCI, PCMCIA, EISA, MC
 
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
diff -puN arch/x86_64/Kconfig~Kconfig_hotplug arch/x86_64/Kconfig
--- linux-2.6.3-rc3/arch/x86_64/Kconfig~Kconfig_hotplug	2004-02-17 01:26:23.482054688 +0100
+++ linux-2.6.3-rc3-root/arch/x86_64/Kconfig	2004-02-17 01:42:43.089131776 +0100
@@ -315,24 +315,6 @@ config PCI_USE_VECTOR
 
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
diff -puN drivers/parisc/Kconfig~Kconfig_hotplug drivers/parisc/Kconfig
--- linux-2.6.3-rc3/drivers/parisc/Kconfig~Kconfig_hotplug	2004-02-17 01:26:23.490053472 +0100
+++ linux-2.6.3-rc3-root/drivers/parisc/Kconfig	2004-02-17 01:44:01.895151440 +0100
@@ -143,24 +143,6 @@ config PDC_CHASSIS
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
 
diff -puN drivers/s390/Kconfig~Kconfig_hotplug drivers/s390/Kconfig
--- linux-2.6.3-rc3/drivers/s390/Kconfig~Kconfig_hotplug	2004-02-17 01:26:23.500051952 +0100
+++ linux-2.6.3-rc3-root/drivers/s390/Kconfig	2004-02-17 01:44:31.554642512 +0100
@@ -164,25 +164,3 @@ config S390_TAPE_34XX
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
diff -puN init/Kconfig~Kconfig_hotplug init/Kconfig
--- linux-2.6.3-rc3/init/Kconfig~Kconfig_hotplug	2004-02-17 01:33:50.854043808 +0100
+++ linux-2.6.3-rc3-root/init/Kconfig	2004-02-17 01:58:55.547295664 +0100
@@ -137,6 +137,25 @@ config LOG_BUF_SHIFT
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

_

