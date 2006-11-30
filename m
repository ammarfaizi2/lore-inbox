Return-Path: <linux-kernel-owner+willy=40w.ods.org-S967877AbWK3UqG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967877AbWK3UqG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Nov 2006 15:46:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967893AbWK3UqG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Nov 2006 15:46:06 -0500
Received: from outmx005.isp.belgacom.be ([195.238.4.102]:6281 "EHLO
	outmx005.isp.belgacom.be") by vger.kernel.org with ESMTP
	id S967877AbWK3UqB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Nov 2006 15:46:01 -0500
Date: Thu, 30 Nov 2006 21:45:41 +0100
From: Wim Van Sebroeck <wim@iguana.be>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Sven Anders <anders@anduras.de>, Marcus Junker <junker@anduras.de>,
       Robert Seretny <lkpatches@paypc.com>,
       Thomas Koeller <thomas.koeller@baslerweb.com>,
       Sam Ravnborg <sam@ravnborg.org>, Randy Dunlap <rdunlap@xenotime.net>
Subject: [WATCHDOG] git v2.6.19 patches
Message-ID: <20061130204541.GA3406@infomag.infomag.iguana.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull from 'master' branch of
	git://git.kernel.org/pub/scm/linux/kernel/git/wim/linux-2.6-watchdog.git
or if master.kernel.org hasn't synced up yet:
	master.kernel.org:/pub/scm/linux/kernel/git/wim/linux-2.6-watchdog.git

This will update the following files:

 drivers/char/watchdog/Kconfig               |   32 +
 drivers/char/watchdog/Makefile              |    4 
 drivers/char/watchdog/iTCO_vendor_support.c |  307 +++++++++++++
 drivers/char/watchdog/iTCO_wdt.c            |   29 +
 drivers/char/watchdog/pc87413_wdt.c         |  635 ++++++++++++++++++++++++++++
 drivers/char/watchdog/rm9k_wdt.c            |  420 ++++++++++++++++++
 6 files changed, 1423 insertions(+), 4 deletions(-)

with these Changes:

Merge: 0215ffb... d5d06ff...
Author: Wim Van Sebroeck <wim@iguana.be>
Date:   Thu Nov 30 20:22:09 2006 +0100

    Merge ../linux-2.6-watchdog-mm

Author: Wim Van Sebroeck <wim@iguana.be>
Date:   Fri Nov 17 23:50:06 2006 +0100

    [WATCHDOG] MIPS RM9000 on-chip watchdog device - patch 4
    
    a number of small patches:
    - include notifier.h include file
    - re-arrange prototype functions
    - remove =0 initializations
    - change printk logging levels to what's used in other drivers
    - /dev/watchdog is a VFS so use nonseekable_open
    - Style: Instead of "if (constant op function_or_variable)"
      we prefer "if (function_or_variable op constant)"
    - arg is a __user pointer
    - use MAX_TIMEOUT_SECONDS instead of 32 in WDIOC_SETTIMEOUT
    
    Signed-off-by: Randy Dunlap <rdunlap@xenotime.net>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

Author: Wim Van Sebroeck <wim@iguana.be>
Date:   Fri Nov 17 23:36:08 2006 +0100

    [WATCHDOG] MIPS RM9000 on-chip watchdog device - patch 3
    
    Move start and stop code into seperate functions
    
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

Author: Wim Van Sebroeck <wim@iguana.be>
Date:   Fri Nov 17 23:15:48 2006 +0100

    [WATCHDOG] MIPS RM9000 on-chip watchdog device - patch 2
    
    Reorganize source code so that it is structured as follows:
    - Function prototypes
    - Local variables
    - Module arguments
    - Interrupt handler
    - Watchdog functions
    - /dev/watchdog operations
    - Shutdown notifier
    - Kernel interfaces
    - Init & exit procedures
    - Device driver init & exit
    
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

Author: Wim Van Sebroeck <wim@iguana.be>
Date:   Fri Nov 17 21:51:35 2006 +0100

    [WATCHDOG] MIPS RM9000 on-chip watchdog device - patch 1
    
    Locate parameter descriptions close to parameter definition -
    not in bottom of file.
    
    Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

Author: Thomas Koeller <thomas.koeller@baslerweb.com>
Date:   Mon Aug 14 21:55:29 2006 +0200

    [WATCHDOG] MIPS RM9000 on-chip watchdog device
    
    This is a driver for the on-chip watchdog device found on some
    MIPS RM9000 processors.
    
    Signed-off-by: Thomas Koeller <thomas.koeller@baslerweb.com>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

Author: Wim Van Sebroeck <wim@iguana.be>
Date:   Sun Nov 12 18:05:09 2006 +0100

    [WATCHDOG] Add iTCO vendor specific support
    
    Add vendor specific support to the intel TCO timer based watchdog
    devices. At this moment we only have additional support for some
    SuperMicro Inc. motherboards.
    
    Signed-off-by: Robert Seretny <lkpatches@paypc.com>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

Author: Andrew Morton <akpm@osdl.org>
Date:   Fri Oct 27 17:20:42 2006 -0700

    [WATCHDOG] config.h removal
    
    config.h got removed
    
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>
    Signed-off-by: Andrew Morton <akpm@osdl.org>

Author: Wim Van Sebroeck <wim@iguana.be>
Date:   Mon Oct 23 18:21:52 2006 +0200

    [WATCHDOG] NS pc87413-wdt Watchdog driver - fixes
    
    Some small fixes:
    * the status should return 0 and not 1 (1 means:
    * wdt_io is not a module-param, io is.
    
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

Author: Sven Anders & Marcus Junker <anders@anduras.de, junker@anduras.de>
Date:   Mon Oct 16 18:18:09 2006 +0200

    [WATCHDOG] NS pc87413-wdt Watchdog driver v1.1
    
    Change the driver for proper spin_locking,
    remove the TEMP_MINOR stuff,
    make sure the device works as a Virtual File System
    that is non_seekable,
    ...
    
    Signed-off-by: Sven Anders <anders@anduras.de>
    Signed-off-by: Marcus Junker <junker@anduras.de>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

Author: Sven Anders & Marcus Junker <anders@anduras.de, junker@anduras.de>
Date:   Thu Aug 24 17:11:50 2006 +0200

    [WATCHDOG] NS pc87413-wdt Watchdog driver
    
    New watchdog driver for the NS pc87413-wdt Watchdog Timer.
    
    Signed-off-by: Sven Anders <anders@anduras.de>
    Signed-off-by: Marcus Junker <junker@anduras.de>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

The Changes can also be looked at on:
	http://www.kernel.org/git/?p=linux/kernel/git/wim/linux-2.6-watchdog.git;a=summary

For completeness, I added the overal diff below.

Greetings,
Wim.

================================================================================
diff --git a/drivers/char/watchdog/Kconfig b/drivers/char/watchdog/Kconfig
index 0187b11..ea09d0c 100644
--- a/drivers/char/watchdog/Kconfig
+++ b/drivers/char/watchdog/Kconfig
@@ -340,6 +340,14 @@ config ITCO_WDT
 	  To compile this driver as a module, choose M here: the
 	  module will be called iTCO_wdt.
 
+config ITCO_VENDOR_SUPPORT
+	bool "Intel TCO Timer/Watchdog Specific Vendor Support"
+	depends on ITCO_WDT
+	---help---
+	  Add vendor specific support to the intel TCO timer based watchdog
+	  devices. At this moment we only have additional support for some
+	  SuperMicro Inc. motherboards.
+
 config SC1200_WDT
 	tristate "National Semiconductor PC87307/PC97307 (ala SC1200) Watchdog"
 	depends on WATCHDOG && X86
@@ -363,6 +371,20 @@ config SCx200_WDT
 
 	  If compiled as a module, it will be called scx200_wdt.
 
+config PC87413_WDT
+	tristate "NS PC87413 watchdog"
+	depends on WATCHDOG && X86
+	---help---
+	  This is the driver for the hardware watchdog on the PC87413 chipset
+	  This watchdog simply watches your kernel to make sure it doesn't
+	  freeze, and if it does, it reboots your computer after a certain
+	  amount of time.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called pc87413_wdt.
+
+	  Most people will say N.
+ 
 config 60XX_WDT
 	tristate "SBC-60XX Watchdog Timer"
 	depends on WATCHDOG && X86
@@ -553,6 +575,16 @@ config INDYDOG
 	  timer expired and no process has written to /dev/watchdog during
 	  that time.
 
+config WDT_RM9K_GPI
+	tristate "RM9000/GPI hardware watchdog"
+	depends on WATCHDOG && CPU_RM9000
+	help
+	  Watchdog implementation using the GPI hardware found on
+	  PMC-Sierra RM9xxx CPUs.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called rm9k_wdt.
+
 # S390 Architecture
 
 config ZVM_WATCHDOG
diff --git a/drivers/char/watchdog/Makefile b/drivers/char/watchdog/Makefile
index 3644049..2cd8ff8 100644
--- a/drivers/char/watchdog/Makefile
+++ b/drivers/char/watchdog/Makefile
@@ -47,9 +47,10 @@ obj-$(CONFIG_IBMASR) += ibmasr.o
 obj-$(CONFIG_WAFER_WDT) += wafer5823wdt.o
 obj-$(CONFIG_I6300ESB_WDT) += i6300esb.o
 obj-$(CONFIG_I8XX_TCO) += i8xx_tco.o
-obj-$(CONFIG_ITCO_WDT) += iTCO_wdt.o
+obj-$(CONFIG_ITCO_WDT) += iTCO_wdt.o iTCO_vendor_support.o
 obj-$(CONFIG_SC1200_WDT) += sc1200wdt.o
 obj-$(CONFIG_SCx200_WDT) += scx200_wdt.o
+obj-$(CONFIG_PC87413_WDT) += pc87413_wdt.o
 obj-$(CONFIG_60XX_WDT) += sbc60xxwdt.o
 obj-$(CONFIG_SBC8360_WDT) += sbc8360.o
 obj-$(CONFIG_CPU5_WDT) += cpu5wdt.o
@@ -72,6 +73,7 @@ obj-$(CONFIG_WATCHDOG_RTAS) += wdrtas.o
 
 # MIPS Architecture
 obj-$(CONFIG_INDYDOG) += indydog.o
+obj-$(CONFIG_WDT_RM9K_GPI) += rm9k_wdt.o
 
 # S390 Architecture
 
diff --git a/drivers/char/watchdog/iTCO_vendor_support.c b/drivers/char/watchdog/iTCO_vendor_support.c
new file mode 100644
index 0000000..4150839
--- /dev/null
+++ b/drivers/char/watchdog/iTCO_vendor_support.c
@@ -0,0 +1,307 @@
+/*
+ *	intel TCO vendor specific watchdog driver support
+ *
+ *	(c) Copyright 2006 Wim Van Sebroeck <wim@iguana.be>.
+ *
+ *	This program is free software; you can redistribute it and/or
+ *	modify it under the terms of the GNU General Public License
+ *	as published by the Free Software Foundation; either version
+ *	2 of the License, or (at your option) any later version.
+ *
+ *	Neither Wim Van Sebroeck nor Iguana vzw. admit liability nor
+ *	provide warranty for any of this software. This material is
+ *	provided "AS-IS" and at no charge.
+ */
+
+/*
+ *	Includes, defines, variables, module parameters, ...
+ */
+
+/* Module and version information */
+#define DRV_NAME        "iTCO_vendor_support"
+#define DRV_VERSION     "1.01"
+#define DRV_RELDATE     "11-Nov-2006"
+#define PFX		DRV_NAME ": "
+
+/* Includes */
+#include <linux/module.h>		/* For module specific items */
+#include <linux/moduleparam.h>		/* For new moduleparam's */
+#include <linux/types.h>		/* For standard types (like size_t) */
+#include <linux/errno.h>		/* For the -ENODEV/... values */
+#include <linux/kernel.h>		/* For printk/panic/... */
+#include <linux/init.h>			/* For __init/__exit/... */
+#include <linux/ioport.h>		/* For io-port access */
+
+#include <asm/io.h>			/* For inb/outb/... */
+
+/* iTCO defines */
+#define	SMI_EN		acpibase + 0x30	/* SMI Control and Enable Register */
+#define	TCOBASE		acpibase + 0x60	/* TCO base address		*/
+#define	TCO1_STS	TCOBASE + 0x04	/* TCO1 Status Register		*/
+
+/* List of vendor support modes */
+#define SUPERMICRO_OLD_BOARD	1	/* SuperMicro Pentium 3 Era 370SSE+-OEM1/P3TSSE */
+#define SUPERMICRO_NEW_BOARD	2	/* SuperMicro Pentium 4 / Xeon 4 / EMT64T Era Systems */
+
+static int vendorsupport = 0;
+module_param(vendorsupport, int, 0);
+MODULE_PARM_DESC(vendorsupport, "iTCO vendor specific support mode, default=0 (none), 1=SuperMicro Pent3, 2=SuperMicro Pent4+");
+
+/*
+ *	Vendor Specific Support
+ */
+
+/*
+ *	Vendor Support: 1
+ *	Board: Super Micro Computer Inc. 370SSE+-OEM1/P3TSSE
+ *	iTCO chipset: ICH2
+ *
+ *	Code contributed by: R. Seretny <lkpatches@paypc.com>
+ *	Documentation obtained by R. Seretny from SuperMicro Technical Support
+ *
+ *	To enable Watchdog function:
+ *	    BIOS setup -> Power -> TCO Logic SMI Enable -> Within5Minutes
+ *	    This setting enables SMI to clear the watchdog expired flag.
+ *	    If BIOS or CPU fail which may cause SMI hang, then system will
+ *	    reboot. When application starts to use watchdog function,
+ *	    application has to take over the control from SMI.
+ *
+ *	    For P3TSSE, J36 jumper needs to be removed to enable the Watchdog
+ *	    function.
+ *
+ *	    Note: The system will reboot when Expire Flag is set TWICE.
+ *	    So, if the watchdog timer is 20 seconds, then the maximum hang
+ *	    time is about 40 seconds, and the minimum hang time is about
+ *	    20.6 seconds.
+ */
+
+static void supermicro_old_pre_start(unsigned long acpibase)
+{
+	unsigned long val32;
+
+	val32 = inl(SMI_EN);
+	val32 &= 0xffffdfff;	/* Turn off SMI clearing watchdog */
+	outl(val32, SMI_EN);	/* Needed to activate watchdog */
+}
+
+static void supermicro_old_pre_stop(unsigned long acpibase)
+{
+	unsigned long val32;
+
+	val32 = inl(SMI_EN);
+	val32 &= 0x00002000;	/* Turn on SMI clearing watchdog */
+	outl(val32, SMI_EN);	/* Needed to deactivate watchdog */
+}
+
+static void supermicro_old_pre_keepalive(unsigned long acpibase)
+{
+	/* Reload TCO Timer (done in iTCO_wdt_keepalive) + */
+	/* Clear "Expire Flag" (Bit 3 of TC01_STS register) */
+	outb(0x08, TCO1_STS);
+}
+
+/*
+ *	Vendor Support: 2
+ *	Board: Super Micro Computer Inc. P4SBx, P4DPx
+ *	iTCO chipset: ICH4
+ *
+ *	Code contributed by: R. Seretny <lkpatches@paypc.com>
+ *	Documentation obtained by R. Seretny from SuperMicro Technical Support
+ *
+ *	To enable Watchdog function:
+ *	 1. BIOS
+ *	  For P4SBx:
+ *	  BIOS setup -> Advanced -> Integrated Peripherals -> Watch Dog Feature
+ *	  For P4DPx:
+ *	  BIOS setup -> Advanced -> I/O Device Configuration -> Watch Dog
+ *	 This setting enables or disables Watchdog function. When enabled, the
+ *	 default watchdog timer is set to be 5 minutes (about 4’35”). It is
+ *	 enough to load and run the OS. The application (service or driver) has
+ *	 to take over the control once OS is running up and before watchdog
+ *	 expires.
+ *
+ *	 2. JUMPER
+ *	  For P4SBx: JP39
+ *	  For P4DPx: JP37
+ *	  This jumper is used for safety.  Closed is enabled. This jumper
+ *	  prevents user enables watchdog in BIOS by accident.
+ *
+ *	 To enable Watch Dog function, both BIOS and JUMPER must be enabled.
+ *
+ *	The documentation lists motherboards P4SBx and P4DPx series as of
+ *	20-March-2002. However, this code works flawlessly with much newer
+ *	motherboards, such as my X6DHR-8G2 (SuperServer 6014H-82).
+ *
+ *	The original iTCO driver as written does not actually reset the
+ *	watchdog timer on these machines, as a result they reboot after five
+ *	minutes.
+ *
+ *	NOTE: You may leave the Watchdog function disabled in the SuperMicro
+ *	BIOS to avoid a "boot-race"... This driver will enable watchdog
+ *	functionality even if it's disabled in the BIOS once the /dev/watchdog
+ *	file is opened.
+ */
+
+/* I/O Port's */
+#define SM_REGINDEX	0x2e		/* SuperMicro ICH4+ Register Index */
+#define SM_DATAIO	0x2f		/* SuperMicro ICH4+ Register Data I/O */
+
+/* Control Register's */
+#define SM_CTLPAGESW	0x07		/* SuperMicro ICH4+ Control Page Switch */
+#define SM_CTLPAGE		0x08	/* SuperMicro ICH4+ Control Page Num */
+
+#define SM_WATCHENABLE	0x30		/* Watchdog enable: Bit 0: 0=off, 1=on */
+
+#define SM_WATCHPAGE	0x87		/* Watchdog unlock control page */
+
+#define SM_ENDWATCH	0xAA		/* Watchdog lock control page */
+
+#define SM_COUNTMODE	0xf5		/* Watchdog count mode select */
+					/* (Bit 3: 0 = seconds, 1 = minutes */
+
+#define SM_WATCHTIMER	0xf6		/* 8-bits, Watchdog timer counter (RW) */
+
+#define SM_RESETCONTROL	0xf7		/* Watchdog reset control */
+					/* Bit 6: timer is reset by kbd interrupt */
+					/* Bit 7: timer is reset by mouse interrupt */
+
+static void supermicro_new_unlock_watchdog(void)
+{
+	outb(SM_WATCHPAGE, SM_REGINDEX);	/* Write 0x87 to port 0x2e twice */
+	outb(SM_WATCHPAGE, SM_REGINDEX);
+
+	outb(SM_CTLPAGESW, SM_REGINDEX);	/* Switch to watchdog control page */
+	outb(SM_CTLPAGE, SM_DATAIO);
+}
+
+static void supermicro_new_lock_watchdog(void)
+{
+	outb(SM_ENDWATCH, SM_REGINDEX);
+}
+
+static void supermicro_new_pre_start(unsigned int heartbeat)
+{
+	unsigned int val;
+
+	supermicro_new_unlock_watchdog();
+
+	/* Watchdog timer setting needs to be in seconds*/
+	outb(SM_COUNTMODE, SM_REGINDEX);
+	val = inb(SM_DATAIO);
+	val &= 0xF7;
+	outb(val, SM_DATAIO);
+
+	/* Write heartbeat interval to WDOG */
+	outb (SM_WATCHTIMER, SM_REGINDEX);
+	outb((heartbeat & 255), SM_DATAIO);
+
+	/* Make sure keyboard/mouse interrupts don't interfere */
+	outb(SM_RESETCONTROL, SM_REGINDEX);
+	val = inb(SM_DATAIO);
+	val &= 0x3f;
+	outb(val, SM_DATAIO);
+
+	/* enable watchdog by setting bit 0 of Watchdog Enable to 1 */
+	outb(SM_WATCHENABLE, SM_REGINDEX);
+	val = inb(SM_DATAIO);
+	val |= 0x01;
+	outb(val, SM_DATAIO);
+
+	supermicro_new_lock_watchdog();
+}
+
+static void supermicro_new_pre_stop(void)
+{
+	unsigned int val;
+
+	supermicro_new_unlock_watchdog();
+
+	/* disable watchdog by setting bit 0 of Watchdog Enable to 0 */
+	outb(SM_WATCHENABLE, SM_REGINDEX);
+	val = inb(SM_DATAIO);
+	val &= 0xFE;
+	outb(val, SM_DATAIO);
+
+	supermicro_new_lock_watchdog();
+}
+
+static void supermicro_new_pre_set_heartbeat(unsigned int heartbeat)
+{
+	supermicro_new_unlock_watchdog();
+
+	/* reset watchdog timeout to heartveat value */
+	outb(SM_WATCHTIMER, SM_REGINDEX);
+	outb((heartbeat & 255), SM_DATAIO);
+
+	supermicro_new_lock_watchdog();
+}
+
+/*
+ *	Generic Support Functions
+ */
+
+void iTCO_vendor_pre_start(unsigned long acpibase,
+			   unsigned int heartbeat)
+{
+	if (vendorsupport == SUPERMICRO_OLD_BOARD)
+		supermicro_old_pre_start(acpibase);
+	else if (vendorsupport == SUPERMICRO_NEW_BOARD)
+		supermicro_new_pre_start(heartbeat);
+}
+EXPORT_SYMBOL(iTCO_vendor_pre_start);
+
+void iTCO_vendor_pre_stop(unsigned long acpibase)
+{
+	if (vendorsupport == SUPERMICRO_OLD_BOARD)
+		supermicro_old_pre_stop(acpibase);
+	else if (vendorsupport == SUPERMICRO_NEW_BOARD)
+		supermicro_new_pre_stop();
+}
+EXPORT_SYMBOL(iTCO_vendor_pre_stop);
+
+void iTCO_vendor_pre_keepalive(unsigned long acpibase, unsigned int heartbeat)
+{
+	if (vendorsupport == SUPERMICRO_OLD_BOARD)
+		supermicro_old_pre_keepalive(acpibase);
+	else if (vendorsupport == SUPERMICRO_NEW_BOARD)
+		supermicro_new_pre_set_heartbeat(heartbeat);
+}
+EXPORT_SYMBOL(iTCO_vendor_pre_keepalive);
+
+void iTCO_vendor_pre_set_heartbeat(unsigned int heartbeat)
+{
+	if (vendorsupport == SUPERMICRO_NEW_BOARD)
+		supermicro_new_pre_set_heartbeat(heartbeat);
+}
+EXPORT_SYMBOL(iTCO_vendor_pre_set_heartbeat);
+
+int iTCO_vendor_check_noreboot_on(void)
+{
+	switch(vendorsupport) {
+	case SUPERMICRO_OLD_BOARD:
+		return 0;
+	default:
+		return 1;
+	}
+}
+EXPORT_SYMBOL(iTCO_vendor_check_noreboot_on);
+
+static int __init iTCO_vendor_init_module(void)
+{
+	printk (KERN_INFO PFX "vendor-support=%d\n", vendorsupport);
+	return 0;
+}
+
+static void __exit iTCO_vendor_exit_module(void)
+{
+	printk (KERN_INFO PFX "Module Unloaded\n");
+}
+
+module_init(iTCO_vendor_init_module);
+module_exit(iTCO_vendor_exit_module);
+
+MODULE_AUTHOR("Wim Van Sebroeck <wim@iguana.be>, R. Seretny <lkpatches@paypc.com>");
+MODULE_DESCRIPTION("Intel TCO Vendor Specific WatchDog Timer Driver Support");
+MODULE_VERSION(DRV_VERSION);
+MODULE_LICENSE("GPL");
+
diff --git a/drivers/char/watchdog/iTCO_wdt.c b/drivers/char/watchdog/iTCO_wdt.c
index b6f29cb..7eac922 100644
--- a/drivers/char/watchdog/iTCO_wdt.c
+++ b/drivers/char/watchdog/iTCO_wdt.c
@@ -48,8 +48,8 @@
 
 /* Module and version information */
 #define DRV_NAME        "iTCO_wdt"
-#define DRV_VERSION     "1.00"
-#define DRV_RELDATE     "08-Oct-2006"
+#define DRV_VERSION     "1.01"
+#define DRV_RELDATE     "11-Nov-2006"
 #define PFX		DRV_NAME ": "
 
 /* Includes */
@@ -189,6 +189,21 @@ static int nowayout = WATCHDOG_NOWAYOUT;
 module_param(nowayout, int, 0);
 MODULE_PARM_DESC(nowayout, "Watchdog cannot be stopped once started (default=CONFIG_WATCHDOG_NOWAYOUT)");
 
+/* iTCO Vendor Specific Support hooks */
+#ifdef CONFIG_ITCO_VENDOR_SUPPORT
+extern void iTCO_vendor_pre_start(unsigned long, unsigned int);
+extern void iTCO_vendor_pre_stop(unsigned long);
+extern void iTCO_vendor_pre_keepalive(unsigned long, unsigned int);
+extern void iTCO_vendor_pre_set_heartbeat(unsigned int);
+extern int iTCO_vendor_check_noreboot_on(void);
+#else
+#define iTCO_vendor_pre_start(acpibase, heartbeat)	{}
+#define iTCO_vendor_pre_stop(acpibase)			{}
+#define iTCO_vendor_pre_keepalive(acpibase,heartbeat)	{}
+#define iTCO_vendor_pre_set_heartbeat(heartbeat)	{}
+#define iTCO_vendor_check_noreboot_on()			1	/* 1=check noreboot; 0=don't check */
+#endif
+
 /*
  * Some TCO specific functions
  */
@@ -249,6 +264,8 @@ static int iTCO_wdt_start(void)
 
 	spin_lock(&iTCO_wdt_private.io_lock);
 
+	iTCO_vendor_pre_start(iTCO_wdt_private.ACPIBASE, heartbeat);
+
 	/* disable chipset's NO_REBOOT bit */
 	if (iTCO_wdt_unset_NO_REBOOT_bit()) {
 		printk(KERN_ERR PFX "failed to reset NO_REBOOT flag, reboot disabled by hardware\n");
@@ -273,6 +290,8 @@ static int iTCO_wdt_stop(void)
 
 	spin_lock(&iTCO_wdt_private.io_lock);
 
+	iTCO_vendor_pre_stop(iTCO_wdt_private.ACPIBASE);
+
 	/* Bit 11: TCO Timer Halt -> 1 = The TCO timer is disabled */
 	val = inw(TCO1_CNT);
 	val |= 0x0800;
@@ -293,6 +312,8 @@ static int iTCO_wdt_keepalive(void)
 {
 	spin_lock(&iTCO_wdt_private.io_lock);
 
+	iTCO_vendor_pre_keepalive(iTCO_wdt_private.ACPIBASE, heartbeat);
+
 	/* Reload the timer by writing to the TCO Timer Counter register */
 	if (iTCO_wdt_private.iTCO_version == 2) {
 		outw(0x01, TCO_RLD);
@@ -319,6 +340,8 @@ static int iTCO_wdt_set_heartbeat(int t)
 	    ((iTCO_wdt_private.iTCO_version == 1) && (tmrval > 0x03f)))
 		return -EINVAL;
 
+	iTCO_vendor_pre_set_heartbeat(tmrval);
+
 	/* Write new heartbeat to watchdog */
 	if (iTCO_wdt_private.iTCO_version == 2) {
 		spin_lock(&iTCO_wdt_private.io_lock);
@@ -569,7 +592,7 @@ static int iTCO_wdt_init(struct pci_dev 
 	}
 
 	/* Check chipset's NO_REBOOT bit */
-	if (iTCO_wdt_unset_NO_REBOOT_bit()) {
+	if (iTCO_wdt_unset_NO_REBOOT_bit() && iTCO_vendor_check_noreboot_on()) {
 		printk(KERN_ERR PFX "failed to reset NO_REBOOT flag, reboot disabled by hardware\n");
 		ret = -ENODEV;	/* Cannot reset NO_REBOOT bit */
 		goto out;
diff --git a/drivers/char/watchdog/pc87413_wdt.c b/drivers/char/watchdog/pc87413_wdt.c
new file mode 100644
index 0000000..1d447e3
--- /dev/null
+++ b/drivers/char/watchdog/pc87413_wdt.c
@@ -0,0 +1,635 @@
+/*
+ *      NS pc87413-wdt Watchdog Timer driver for Linux 2.6.x.x
+ *
+ *      This code is based on wdt.c with original copyright.
+ *
+ *      (C) Copyright 2006 Sven Anders, <anders@anduras.de>
+ *                     and Marcus Junker, <junker@anduras.de>
+ *
+ *      This program is free software; you can redistribute it and/or
+ *      modify it under the terms of the GNU General Public License
+ *      as published by the Free Software Foundation; either version
+ *      2 of the License, or (at your option) any later version.
+ *
+ *      Neither Sven Anders, Marcus Junker nor ANDURAS AG
+ *      admit liability nor provide warranty for any of this software.
+ *      This material is provided "AS-IS" and at no charge.
+ *
+ *      Release 1.1
+ */
+
+#include <linux/module.h>
+#include <linux/types.h>
+#include <linux/miscdevice.h>
+#include <linux/watchdog.h>
+#include <linux/ioport.h>
+#include <linux/delay.h>
+#include <linux/notifier.h>
+#include <linux/fs.h>
+#include <linux/reboot.h>
+#include <linux/init.h>
+#include <linux/spinlock.h>
+#include <linux/moduleparam.h>
+#include <linux/version.h>
+
+#include <asm/io.h>
+#include <asm/uaccess.h>
+#include <asm/system.h>
+
+/* #define DEBUG 1 */
+
+#define DEFAULT_TIMEOUT     1            /* 1 minute */
+#define MAX_TIMEOUT         255
+
+#define VERSION             "1.1"
+#define MODNAME             "pc87413 WDT"
+#define PFX                 MODNAME ": "
+#define DPFX                MODNAME " - DEBUG: "
+
+#define WDT_INDEX_IO_PORT   (io+0)       /* I/O port base (index register) */
+#define WDT_DATA_IO_PORT    (WDT_INDEX_IO_PORT+1)
+#define SWC_LDN             0x04
+#define SIOCFG2             0x22         /* Serial IO register */
+#define WDCTL               0x10         /* Watchdog-Timer-Controll-Register */
+#define WDTO                0x11         /* Watchdog timeout register */
+#define WDCFG               0x12         /* Watchdog config register */
+
+static int io = 0x2E;		         /* Address used on Portwell Boards */
+
+static int timeout = DEFAULT_TIMEOUT;    /* timeout value */
+static unsigned long timer_enabled = 0;  /* is the timer enabled? */
+
+static char expect_close;                /* is the close expected? */
+
+static spinlock_t io_lock;               /* to guard the watchdog from io races */
+
+static int nowayout = WATCHDOG_NOWAYOUT;
+
+/* -- Low level function ----------------------------------------*/
+
+/* Select pins for Watchdog output */
+
+static inline void pc87413_select_wdt_out (void)
+{
+	unsigned int cr_data = 0;
+
+	/* Step 1: Select multiple pin,pin55,as WDT output */
+
+	outb_p(SIOCFG2, WDT_INDEX_IO_PORT);
+
+	cr_data = inb (WDT_DATA_IO_PORT);
+
+	cr_data |= 0x80; /* Set Bit7 to 1*/
+	outb_p(SIOCFG2, WDT_INDEX_IO_PORT);
+
+	outb_p(cr_data, WDT_DATA_IO_PORT);
+
+#ifdef DEBUG
+	printk(KERN_INFO DPFX "Select multiple pin,pin55,as WDT output:"
+	                      " Bit7 to 1: %d\n", cr_data);
+#endif
+}
+
+/* Enable SWC functions */
+
+static inline void pc87413_enable_swc(void)
+{
+	unsigned int cr_data=0;
+
+	/* Step 2: Enable SWC functions */
+
+	outb_p(0x07, WDT_INDEX_IO_PORT);        /* Point SWC_LDN (LDN=4) */
+	outb_p(SWC_LDN, WDT_DATA_IO_PORT);
+
+	outb_p(0x30, WDT_INDEX_IO_PORT);        /* Read Index 0x30 First */
+	cr_data = inb(WDT_DATA_IO_PORT);
+	cr_data |= 0x01;                        /* Set Bit0 to 1 */
+	outb_p(0x30, WDT_INDEX_IO_PORT);
+	outb_p(cr_data, WDT_DATA_IO_PORT);      /* Index0x30_bit0P1 */
+
+#ifdef DEBUG
+	printk(KERN_INFO DPFX "pc87413 - Enable SWC functions\n");
+#endif
+}
+
+/* Read SWC I/O base address */
+
+static inline unsigned int pc87413_get_swc_base(void)
+{
+	unsigned int  swc_base_addr = 0;
+	unsigned char addr_l, addr_h = 0;
+
+	/* Step 3: Read SWC I/O Base Address */
+
+	outb_p(0x60, WDT_INDEX_IO_PORT);        /* Read Index 0x60 */
+	addr_h = inb(WDT_DATA_IO_PORT);
+
+	outb_p(0x61, WDT_INDEX_IO_PORT);        /* Read Index 0x61 */
+
+	addr_l = inb(WDT_DATA_IO_PORT);
+
+	swc_base_addr = (addr_h << 8) + addr_l;
+
+#ifdef DEBUG
+	printk(KERN_INFO DPFX "Read SWC I/O Base Address: low %d, high %d,"
+	                      " res %d\n", addr_l, addr_h, swc_base_addr);
+#endif
+
+	return swc_base_addr;
+}
+
+/* Select Bank 3 of SWC */
+
+static inline void pc87413_swc_bank3(unsigned int swc_base_addr)
+{
+	/* Step 4: Select Bank3 of SWC */
+
+	outb_p(inb(swc_base_addr + 0x0f) | 0x03, swc_base_addr + 0x0f);
+
+#ifdef DEBUG
+	printk(KERN_INFO DPFX "Select Bank3 of SWC\n");
+#endif
+}
+
+/* Set watchdog timeout to x minutes */
+
+static inline void pc87413_programm_wdto(unsigned int swc_base_addr,
+					 char pc87413_time)
+{
+	/* Step 5: Programm WDTO, Twd. */
+
+	outb_p(pc87413_time, swc_base_addr + WDTO);
+
+#ifdef DEBUG
+	printk(KERN_INFO DPFX "Set WDTO to %d minutes\n", pc87413_time);
+#endif
+}
+
+/* Enable WDEN */
+
+static inline void pc87413_enable_wden(unsigned int swc_base_addr)
+{
+	/* Step 6: Enable WDEN */
+
+	outb_p(inb (swc_base_addr + WDCTL) | 0x01, swc_base_addr + WDCTL);
+
+#ifdef DEBUG
+	printk(KERN_INFO DPFX "Enable WDEN\n");
+#endif
+}
+
+/* Enable SW_WD_TREN */
+static inline void pc87413_enable_sw_wd_tren(unsigned int swc_base_addr)
+{
+	/* Enable SW_WD_TREN */
+
+	outb_p(inb (swc_base_addr + WDCFG) | 0x80, swc_base_addr + WDCFG);
+
+#ifdef DEBUG
+	printk(KERN_INFO DPFX "Enable SW_WD_TREN\n");
+#endif
+}
+
+/* Disable SW_WD_TREN */
+
+static inline void pc87413_disable_sw_wd_tren(unsigned int swc_base_addr)
+{
+	/* Disable SW_WD_TREN */
+
+	outb_p(inb (swc_base_addr + WDCFG) & 0x7f, swc_base_addr + WDCFG);
+
+#ifdef DEBUG
+	printk(KERN_INFO DPFX "pc87413 - Disable SW_WD_TREN\n");
+#endif
+}
+
+/* Enable SW_WD_TRG */
+
+static inline void pc87413_enable_sw_wd_trg(unsigned int swc_base_addr)
+{
+	/* Enable SW_WD_TRG */
+
+	outb_p(inb (swc_base_addr + WDCTL) | 0x80, swc_base_addr + WDCTL);
+
+#ifdef DEBUG
+	printk(KERN_INFO DPFX "pc87413 - Enable SW_WD_TRG\n");
+#endif
+}
+
+/* Disable SW_WD_TRG */
+
+static inline void pc87413_disable_sw_wd_trg(unsigned int swc_base_addr)
+{
+	/* Disable SW_WD_TRG */
+
+	outb_p(inb (swc_base_addr + WDCTL) & 0x7f, swc_base_addr + WDCTL);
+
+#ifdef DEBUG
+	printk(KERN_INFO DPFX "Disable SW_WD_TRG\n");
+#endif
+}
+
+/* -- Higher level functions ------------------------------------*/
+
+/* Enable the watchdog */
+
+static void pc87413_enable(void)
+{
+	unsigned int swc_base_addr;
+
+	spin_lock(&io_lock);
+
+	pc87413_select_wdt_out();
+	pc87413_enable_swc();
+	swc_base_addr = pc87413_get_swc_base();
+	pc87413_swc_bank3(swc_base_addr);
+	pc87413_programm_wdto(swc_base_addr, timeout);
+	pc87413_enable_wden(swc_base_addr);
+	pc87413_enable_sw_wd_tren(swc_base_addr);
+	pc87413_enable_sw_wd_trg(swc_base_addr);
+
+	spin_unlock(&io_lock);
+}
+
+/* Disable the watchdog */
+
+static void pc87413_disable(void)
+{
+	unsigned int swc_base_addr;
+
+	spin_lock(&io_lock);
+
+	pc87413_select_wdt_out();
+	pc87413_enable_swc();
+	swc_base_addr = pc87413_get_swc_base();
+	pc87413_swc_bank3(swc_base_addr);
+	pc87413_disable_sw_wd_tren(swc_base_addr);
+	pc87413_disable_sw_wd_trg(swc_base_addr);
+	pc87413_programm_wdto(swc_base_addr, 0);
+
+	spin_unlock(&io_lock);
+}
+
+/* Refresh the watchdog */
+
+static void pc87413_refresh(void)
+{
+	unsigned int swc_base_addr;
+
+	spin_lock(&io_lock);
+
+	pc87413_select_wdt_out();
+	pc87413_enable_swc();
+	swc_base_addr = pc87413_get_swc_base();
+	pc87413_swc_bank3(swc_base_addr);
+	pc87413_disable_sw_wd_tren(swc_base_addr);
+	pc87413_disable_sw_wd_trg(swc_base_addr);
+	pc87413_programm_wdto(swc_base_addr, timeout);
+	pc87413_enable_wden(swc_base_addr);
+	pc87413_enable_sw_wd_tren(swc_base_addr);
+	pc87413_enable_sw_wd_trg(swc_base_addr);
+
+	spin_unlock(&io_lock);
+}
+
+/* -- File operations -------------------------------------------*/
+
+/**
+ *	pc87413_open:
+ *	@inode: inode of device
+ *	@file: file handle to device
+ *
+ */
+
+static int pc87413_open(struct inode *inode, struct file *file)
+{
+	/* /dev/watchdog can only be opened once */
+
+	if (test_and_set_bit(0, &timer_enabled))
+		return -EBUSY;
+
+	if (nowayout)
+		__module_get(THIS_MODULE);
+
+	/* Reload and activate timer */
+	pc87413_refresh();
+
+	printk(KERN_INFO MODNAME "Watchdog enabled. Timeout set to"
+	                         " %d minute(s).\n", timeout);
+
+	return nonseekable_open(inode, file);
+}
+
+/**
+ *	pc87413_release:
+ *	@inode: inode to board
+ *	@file: file handle to board
+ *
+ *	The watchdog has a configurable API. There is a religious dispute
+ *	between people who want their watchdog to be able to shut down and
+ *	those who want to be sure if the watchdog manager dies the machine
+ *	reboots. In the former case we disable the counters, in the latter
+ *	case you have to open it again very soon.
+ */
+
+static int pc87413_release(struct inode *inode, struct file *file)
+{
+	/* Shut off the timer. */
+
+	if (expect_close == 42) {
+		pc87413_disable();
+		printk(KERN_INFO MODNAME "Watchdog disabled,"
+		                         " sleeping again...\n");
+	} else {
+		printk(KERN_CRIT MODNAME "Unexpected close, not stopping"
+		                         " watchdog!\n");
+		pc87413_refresh();
+	}
+
+	clear_bit(0, &timer_enabled);
+	expect_close = 0;
+
+	return 0;
+}
+
+/**
+ *	pc87413_status:
+ *
+ *      return, if the watchdog is enabled (timeout is set...)
+ */
+
+
+static int pc87413_status(void)
+{
+	  return 0; /* currently not supported */
+}
+
+/**
+ *	pc87413_write:
+ *	@file: file handle to the watchdog
+ *	@data: data buffer to write
+ *	@len: length in bytes
+ *	@ppos: pointer to the position to write. No seeks allowed
+ *
+ *	A write to a watchdog device is defined as a keepalive signal. Any
+ *	write of data will do, as we we don't define content meaning.
+ */
+
+static ssize_t pc87413_write(struct file *file, const char __user *data,
+			     size_t len, loff_t *ppos)
+{
+	/* See if we got the magic character 'V' and reload the timer */
+	if (len) {
+		if (!nowayout) {
+			size_t i;
+
+			/* reset expect flag */
+			expect_close = 0;
+
+			/* scan to see whether or not we got the magic character */
+			for (i = 0; i != len; i++) {
+				char c;
+				if (get_user(c, data+i))
+					return -EFAULT;
+				if (c == 'V')
+					expect_close = 42;
+			}
+		}
+
+		/* someone wrote to us, we should reload the timer */
+		pc87413_refresh();
+	}
+	return len;
+}
+
+/**
+ *	pc87413_ioctl:
+ *	@inode: inode of the device
+ *	@file: file handle to the device
+ *	@cmd: watchdog command
+ *	@arg: argument pointer
+ *
+ *	The watchdog API defines a common set of functions for all watchdogs
+ *	according to their available features. We only actually usefully support
+ *	querying capabilities and current status.
+ */
+
+static int pc87413_ioctl(struct inode *inode, struct file *file,
+			 unsigned int cmd, unsigned long arg)
+{
+	int new_timeout;
+
+	union {
+		struct watchdog_info __user *ident;
+		int __user *i;
+	} uarg;
+
+	static struct watchdog_info ident = {
+		.options          = WDIOF_KEEPALIVEPING |
+		                    WDIOF_SETTIMEOUT |
+		                    WDIOF_MAGICCLOSE,
+		.firmware_version = 1,
+		.identity         = "PC87413(HF/F) watchdog"
+	};
+
+	uarg.i = (int __user *)arg;
+
+	switch(cmd) {
+		default:
+			return -ENOTTY;
+
+		case WDIOC_GETSUPPORT:
+			return copy_to_user(uarg.ident, &ident,
+				sizeof(ident)) ? -EFAULT : 0;
+
+		case WDIOC_GETSTATUS:
+			return put_user(pc87413_status(), uarg.i);
+
+		case WDIOC_GETBOOTSTATUS:
+			return put_user(0, uarg.i);
+
+		case WDIOC_KEEPALIVE:
+			pc87413_refresh();
+#ifdef DEBUG
+	                printk(KERN_INFO DPFX "keepalive\n");
+#endif
+			return 0;
+
+		case WDIOC_SETTIMEOUT:
+			if (get_user(new_timeout, uarg.i))
+				return -EFAULT;
+
+			// the API states this is given in secs
+			new_timeout /= 60;
+
+			if (new_timeout < 0 || new_timeout > MAX_TIMEOUT)
+				return -EINVAL;
+
+			timeout = new_timeout;
+			pc87413_refresh();
+
+			// fall through and return the new timeout...
+
+		case WDIOC_GETTIMEOUT:
+
+		        new_timeout = timeout * 60;
+
+			return put_user(new_timeout, uarg.i);
+
+		case WDIOC_SETOPTIONS:
+		{
+			int options, retval = -EINVAL;
+
+			if (get_user(options, uarg.i))
+				return -EFAULT;
+
+			if (options & WDIOS_DISABLECARD) {
+			        pc87413_disable();
+				retval = 0;
+			}
+
+			if (options & WDIOS_ENABLECARD) {
+				pc87413_enable();
+				retval = 0;
+			}
+
+			return retval;
+		}
+	}
+}
+
+/* -- Notifier funtions -----------------------------------------*/
+
+/**
+ *	notify_sys:
+ *	@this: our notifier block
+ *	@code: the event being reported
+ *	@unused: unused
+ *
+ *	Our notifier is called on system shutdowns. We want to turn the card
+ *	off at reboot otherwise the machine will reboot again during memory
+ *	test or worse yet during the following fsck. This would suck, in fact
+ *	trust me - if it happens it does suck.
+ */
+
+static int pc87413_notify_sys(struct notifier_block *this,
+			      unsigned long code,
+			      void *unused)
+{
+	if (code == SYS_DOWN || code == SYS_HALT)
+	{
+		/* Turn the card off */
+		pc87413_disable();
+	}
+	return NOTIFY_DONE;
+}
+
+/* -- Module's structures ---------------------------------------*/
+
+static struct file_operations pc87413_fops = {
+	.owner		= THIS_MODULE,
+	.llseek		= no_llseek,
+	.write		= pc87413_write,
+	.ioctl		= pc87413_ioctl,
+	.open		= pc87413_open,
+	.release	= pc87413_release,
+};
+
+static struct notifier_block pc87413_notifier =
+{
+	.notifier_call  = pc87413_notify_sys,
+};
+
+static struct miscdevice pc87413_miscdev=
+{
+	.minor          = WATCHDOG_MINOR,
+	.name           = "watchdog",
+	.fops           = &pc87413_fops
+};
+
+/* -- Module init functions -------------------------------------*/
+
+/**
+ * 	pc87413_init: module's "constructor"
+ *
+ *	Set up the WDT watchdog board. All we have to do is grab the
+ *	resources we require and bitch if anyone beat us to them.
+ *	The open() function will actually kick the board off.
+ */
+
+static int __init pc87413_init(void)
+{
+	int ret;
+
+	spin_lock_init(&io_lock);
+
+	printk(KERN_INFO PFX "Version " VERSION " at io 0x%X\n", WDT_INDEX_IO_PORT);
+
+	/* request_region(io, 2, "pc87413"); */
+
+	ret = register_reboot_notifier(&pc87413_notifier);
+	if (ret != 0) {
+		printk(KERN_ERR PFX "cannot register reboot notifier (err=%d)\n",
+			ret);
+	}
+
+	ret = misc_register(&pc87413_miscdev);
+
+	if (ret != 0) {
+		printk(KERN_ERR PFX "cannot register miscdev on minor=%d (err=%d)\n",
+			WATCHDOG_MINOR, ret);
+		unregister_reboot_notifier(&pc87413_notifier);
+		return ret;
+	}
+
+	printk(KERN_INFO PFX "initialized. timeout=%d min \n", timeout);
+
+	pc87413_enable();
+
+	return 0;
+}
+
+/**
+ *	pc87413_exit: module's "destructor"
+ *
+ *	Unload the watchdog. You cannot do this with any file handles open.
+ *	If your watchdog is set to continue ticking on close and you unload
+ *	it, well it keeps ticking. We won't get the interrupt but the board
+ *	will not touch PC memory so all is fine. You just have to load a new
+ *	module in 60 seconds or reboot.
+ */
+
+static void __exit pc87413_exit(void)
+{
+	/* Stop the timer before we leave */
+	if (!nowayout)
+	{
+		pc87413_disable();
+		printk(KERN_INFO MODNAME "Watchdog disabled.\n");
+	}
+
+	misc_deregister(&pc87413_miscdev);
+	unregister_reboot_notifier(&pc87413_notifier);
+	/* release_region(io,2); */
+
+	printk(MODNAME " watchdog component driver removed.\n");
+}
+
+module_init(pc87413_init);
+module_exit(pc87413_exit);
+
+MODULE_AUTHOR("Sven Anders <anders@anduras.de>, Marcus Junker <junker@anduras.de>,");
+MODULE_DESCRIPTION("PC87413 WDT driver");
+MODULE_LICENSE("GPL");
+
+MODULE_ALIAS_MISCDEV(WATCHDOG_MINOR);
+
+module_param(io, int, 0);
+MODULE_PARM_DESC(io, MODNAME " I/O port (default: " __MODULE_STRING(io) ").");
+
+module_param(timeout, int, 0);
+MODULE_PARM_DESC(timeout, "Watchdog timeout in minutes (default=" __MODULE_STRING(timeout) ").");
+
+module_param(nowayout, int, 0);
+MODULE_PARM_DESC(nowayout, "Watchdog cannot be stopped once started (default=CONFIG_WATCHDOG_NOWAYOUT)");
+
diff --git a/drivers/char/watchdog/rm9k_wdt.c b/drivers/char/watchdog/rm9k_wdt.c
new file mode 100644
index 0000000..ec39093
--- /dev/null
+++ b/drivers/char/watchdog/rm9k_wdt.c
@@ -0,0 +1,420 @@
+/*
+ *  Watchdog implementation for GPI h/w found on PMC-Sierra RM9xxx
+ *  chips.
+ *
+ *  Copyright (C) 2004 by Basler Vision Technologies AG
+ *  Author: Thomas Koeller <thomas.koeller@baslerweb.com>
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2 of the License, or
+ *  (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, write to the Free Software
+ *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ */
+
+#include <linux/platform_device.h>
+#include <linux/module.h>
+#include <linux/moduleparam.h>
+#include <linux/interrupt.h>
+#include <linux/fs.h>
+#include <linux/reboot.h>
+#include <linux/notifier.h>
+#include <linux/miscdevice.h>
+#include <linux/watchdog.h>
+#include <asm/io.h>
+#include <asm/atomic.h>
+#include <asm/processor.h>
+#include <asm/uaccess.h>
+#include <asm/system.h>
+#include <asm/rm9k-ocd.h>
+
+#include <rm9k_wdt.h>
+
+
+#define CLOCK                  125000000
+#define MAX_TIMEOUT_SECONDS    32
+#define CPCCR                  0x0080
+#define CPGIG1SR               0x0044
+#define CPGIG1ER               0x0054
+
+
+/* Function prototypes */
+static irqreturn_t wdt_gpi_irqhdl(int, void *, struct pt_regs *);
+static void wdt_gpi_start(void);
+static void wdt_gpi_stop(void);
+static void wdt_gpi_set_timeout(unsigned int);
+static int wdt_gpi_open(struct inode *, struct file *);
+static int wdt_gpi_release(struct inode *, struct file *);
+static ssize_t wdt_gpi_write(struct file *, const char __user *, size_t, loff_t *);
+static long wdt_gpi_ioctl(struct file *, unsigned int, unsigned long);
+static int wdt_gpi_notify(struct notifier_block *, unsigned long, void *);
+static const struct resource *wdt_gpi_get_resource(struct platform_device *, const char *, unsigned int);
+static int __init wdt_gpi_probe(struct device *);
+static int __exit wdt_gpi_remove(struct device *);
+
+
+static const char wdt_gpi_name[] = "wdt_gpi";
+static atomic_t opencnt;
+static int expect_close;
+static int locked;
+
+
+/* These are set from device resources */
+static void __iomem * wd_regs;
+static unsigned int wd_irq, wd_ctr;
+
+
+/* Module arguments */
+static int timeout = MAX_TIMEOUT_SECONDS;
+module_param(timeout, int, 0444);
+MODULE_PARM_DESC(timeout, "Watchdog timeout in seconds");
+
+static unsigned long resetaddr = 0xbffdc200;
+module_param(resetaddr, ulong, 0444);
+MODULE_PARM_DESC(resetaddr, "Address to write to to force a reset");
+
+static unsigned long flagaddr = 0xbffdc104;
+module_param(flagaddr, ulong, 0444);
+MODULE_PARM_DESC(flagaddr, "Address to write to boot flags to");
+
+static int powercycle;
+module_param(powercycle, bool, 0444);
+MODULE_PARM_DESC(powercycle, "Cycle power if watchdog expires");
+
+static int nowayout = WATCHDOG_NOWAYOUT;
+module_param(nowayout, bool, 0444);
+MODULE_PARM_DESC(nowayout, "Watchdog cannot be disabled once started");
+
+
+/* Interrupt handler */
+static irqreturn_t wdt_gpi_irqhdl(int irq, void *ctxt, struct pt_regs *regs)
+{
+	if (!unlikely(__raw_readl(wd_regs + 0x0008) & 0x1))
+		return IRQ_NONE;
+	__raw_writel(0x1, wd_regs + 0x0008);
+
+
+	printk(KERN_CRIT "%s: watchdog expired - resetting system\n",
+		wdt_gpi_name);
+
+	*(volatile char *) flagaddr |= 0x01;
+	*(volatile char *) resetaddr = powercycle ? 0x01 : 0x2;
+	iob();
+	while (1)
+		cpu_relax();
+}
+
+
+/* Watchdog functions */
+static void wdt_gpi_start(void)
+{
+	u32 reg;
+
+	lock_titan_regs();
+	reg = titan_readl(CPGIG1ER);
+	titan_writel(reg | (0x100 << wd_ctr), CPGIG1ER);
+	iob();
+	unlock_titan_regs();
+}
+
+static void wdt_gpi_stop(void)
+{
+	u32 reg;
+
+	lock_titan_regs();
+	reg = titan_readl(CPCCR) & ~(0xf << (wd_ctr * 4));
+	titan_writel(reg, CPCCR);
+	reg = titan_readl(CPGIG1ER);
+	titan_writel(reg & ~(0x100 << wd_ctr), CPGIG1ER);
+	iob();
+	unlock_titan_regs();
+}
+
+static void wdt_gpi_set_timeout(unsigned int to)
+{
+	u32 reg;
+	const u32 wdval = (to * CLOCK) & ~0x0000000f;
+
+	lock_titan_regs();
+	reg = titan_readl(CPCCR) & ~(0xf << (wd_ctr * 4));
+	titan_writel(reg, CPCCR);
+	wmb();
+	__raw_writel(wdval, wd_regs + 0x0000);
+	wmb();
+	titan_writel(reg | (0x2 << (wd_ctr * 4)), CPCCR);
+	wmb();
+	titan_writel(reg | (0x5 << (wd_ctr * 4)), CPCCR);
+	iob();
+	unlock_titan_regs();
+}
+
+
+/* /dev/watchdog operations */
+static int wdt_gpi_open(struct inode *inode, struct file *file)
+{
+	int res;
+
+	if (unlikely(atomic_dec_if_positive(&opencnt) < 0))
+		return -EBUSY;
+
+	expect_close = 0;
+	if (locked) {
+		module_put(THIS_MODULE);
+		free_irq(wd_irq, &miscdev);
+		locked = 0;
+	}
+
+	res = request_irq(wd_irq, wdt_gpi_irqhdl, SA_SHIRQ | SA_INTERRUPT,
+			  wdt_gpi_name, &miscdev);
+	if (unlikely(res))
+		return res;
+
+	wdt_gpi_set_timeout(timeout);
+	wdt_gpi_start();
+
+	printk(KERN_INFO "%s: watchdog started, timeout = %u seconds\n",
+		wdt_gpi_name, timeout);
+	return nonseekable_open(inode, file);
+}
+
+static int wdt_gpi_release(struct inode *inode, struct file *file)
+{
+	if (nowayout) {
+		printk(KERN_INFO "%s: no way out - watchdog left running\n",
+			wdt_gpi_name);
+		__module_get(THIS_MODULE);
+		locked = 1;
+	} else {
+		if (expect_close) {
+			wdt_gpi_stop();
+			free_irq(wd_irq, &miscdev);
+			printk(KERN_INFO "%s: watchdog stopped\n", wdt_gpi_name);
+		} else {
+			printk(KERN_CRIT "%s: unexpected close() -"
+				" watchdog left running\n",
+				wdt_gpi_name);
+			wdt_gpi_set_timeout(timeout);
+			__module_get(THIS_MODULE);
+			locked = 1;
+		}
+	}
+
+	atomic_inc(&opencnt);
+	return 0;
+}
+
+static ssize_t
+wdt_gpi_write(struct file *f, const char __user *d, size_t s, loff_t *o)
+{
+	char val;
+
+	wdt_gpi_set_timeout(timeout);
+	expect_close = (s > 0) && !get_user(val, d) && (val == 'V');
+	return s ? 1 : 0;
+}
+
+static long
+wdt_gpi_ioctl(struct file *f, unsigned int cmd, unsigned long arg)
+{
+	long res = -ENOTTY;
+	const long size = _IOC_SIZE(cmd);
+	int stat;
+	void __user *argp = (void __user *)arg;
+	static struct watchdog_info wdinfo = {
+		.identity               = "RM9xxx/GPI watchdog",
+		.firmware_version       = 0,
+		.options                = WDIOF_SETTIMEOUT | WDIOF_KEEPALIVEPING
+	};
+
+	if (unlikely(_IOC_TYPE(cmd) != WATCHDOG_IOCTL_BASE))
+		return -ENOTTY;
+
+	if ((_IOC_DIR(cmd) & _IOC_READ)
+	    && !access_ok(VERIFY_WRITE, arg, size))
+		return -EFAULT;
+
+	if ((_IOC_DIR(cmd) & _IOC_WRITE)
+	    && !access_ok(VERIFY_READ, arg, size))
+		return -EFAULT;
+
+	expect_close = 0;
+
+	switch (cmd) {
+	case WDIOC_GETSUPPORT:
+		wdinfo.options = nowayout ?
+			WDIOF_SETTIMEOUT | WDIOF_KEEPALIVEPING :
+			WDIOF_SETTIMEOUT | WDIOF_KEEPALIVEPING | WDIOF_MAGICCLOSE;
+		res = __copy_to_user(argp, &wdinfo, size) ?  -EFAULT : size;
+		break;
+
+	case WDIOC_GETSTATUS:
+		break;
+
+	case WDIOC_GETBOOTSTATUS:
+		stat = (*(volatile char *) flagaddr & 0x01)
+			? WDIOF_CARDRESET : 0;
+		res = __copy_to_user(argp, &stat, size) ?
+			-EFAULT : size;
+		break;
+
+	case WDIOC_SETOPTIONS:
+		break;
+
+	case WDIOC_KEEPALIVE:
+		wdt_gpi_set_timeout(timeout);
+		res = size;
+		break;
+
+	case WDIOC_SETTIMEOUT:
+		{
+			int val;
+			if (unlikely(__copy_from_user(&val, argp, size))) {
+				res = -EFAULT;
+				break;
+			}
+
+			if (val > MAX_TIMEOUT_SECONDS)
+				val = MAX_TIMEOUT_SECONDS;
+			timeout = val;
+			wdt_gpi_set_timeout(val);
+			res = size;
+			printk(KERN_INFO "%s: timeout set to %u seconds\n",
+				wdt_gpi_name, timeout);
+		}
+		break;
+
+	case WDIOC_GETTIMEOUT:
+		res = __copy_to_user(argp, &timeout, size) ?
+			-EFAULT : size;
+		break;
+	}
+
+	return res;
+}
+
+
+/* Shutdown notifier */
+static int
+wdt_gpi_notify(struct notifier_block *this, unsigned long code, void *unused)
+{
+	if (code == SYS_DOWN || code == SYS_HALT)
+		wdt_gpi_stop();
+
+	return NOTIFY_DONE;
+}
+
+
+/* Kernel interfaces */
+static struct file_operations fops = {
+	.owner		= THIS_MODULE,
+	.open		= wdt_gpi_open,
+	.release	= wdt_gpi_release,
+	.write		= wdt_gpi_write,
+	.unlocked_ioctl	= wdt_gpi_ioctl,
+};
+
+static struct miscdevice miscdev = {
+	.minor		= WATCHDOG_MINOR,
+	.name		= wdt_gpi_name,
+	.fops		= &fops,
+};
+
+static struct notifier_block wdt_gpi_shutdown = {
+	.notifier_call	= wdt_gpi_notify,
+};
+
+
+/* Init & exit procedures */
+static const struct resource *
+wdt_gpi_get_resource(struct platform_device *pdv, const char *name,
+		      unsigned int type)
+{
+	char buf[80];
+	if (snprintf(buf, sizeof buf, "%s_0", name) >= sizeof buf)
+		return NULL;
+	return platform_get_resource_byname(pdv, type, buf);
+}
+
+/* No hotplugging on the platform bus - use __init */
+static int __init wdt_gpi_probe(struct device *dev)
+{
+	int res;
+	struct platform_device * const pdv = to_platform_device(dev);
+	const struct resource
+		* const rr = wdt_gpi_get_resource(pdv, WDT_RESOURCE_REGS,
+						  IORESOURCE_MEM),
+		* const ri = wdt_gpi_get_resource(pdv, WDT_RESOURCE_IRQ,
+						  IORESOURCE_IRQ),
+		* const rc = wdt_gpi_get_resource(pdv, WDT_RESOURCE_COUNTER,
+						  0);
+
+	if (unlikely(!rr || !ri || !rc))
+		return -ENXIO;
+
+	wd_regs = ioremap_nocache(rr->start, rr->end + 1 - rr->start);
+	if (unlikely(!wd_regs))
+		return -ENOMEM;
+	wd_irq = ri->start;
+	wd_ctr = rc->start;
+	res = misc_register(&miscdev);
+	if (res)
+		iounmap(wd_regs);
+	else
+		register_reboot_notifier(&wdt_gpi_shutdown);
+	return res;
+}
+
+static int __exit wdt_gpi_remove(struct device *dev)
+{
+	int res;
+
+	unregister_reboot_notifier(&wdt_gpi_shutdown);
+	res = misc_deregister(&miscdev);
+	iounmap(wd_regs);
+	wd_regs = NULL;
+	return res;
+}
+
+
+/* Device driver init & exit */
+static struct device_driver wdt_gpi_driver = {
+	.name		= (char *) wdt_gpi_name,
+	.bus		= &platform_bus_type,
+	.owner		= THIS_MODULE,
+	.probe		= wdt_gpi_probe,
+	.remove		= __exit_p(wdt_gpi_remove),
+	.shutdown	= NULL,
+	.suspend	= NULL,
+	.resume		= NULL,
+};
+
+static int __init wdt_gpi_init_module(void)
+{
+	atomic_set(&opencnt, 1);
+	if (timeout > MAX_TIMEOUT_SECONDS)
+		timeout = MAX_TIMEOUT_SECONDS;
+	return driver_register(&wdt_gpi_driver);
+}
+
+static void __exit wdt_gpi_cleanup_module(void)
+{
+	driver_unregister(&wdt_gpi_driver);
+}
+
+module_init(wdt_gpi_init_module);
+module_exit(wdt_gpi_cleanup_module);
+
+MODULE_AUTHOR("Thomas Koeller <thomas.koeller@baslerweb.com>");
+MODULE_DESCRIPTION("Basler eXcite watchdog driver for gpi devices");
+MODULE_VERSION("0.1");
+MODULE_LICENSE("GPL");
+MODULE_ALIAS_MISCDEV(WATCHDOG_MINOR);
+
