Return-Path: <linux-kernel-owner+willy=40w.ods.org-S934395AbWKZQFY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934395AbWKZQFY (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Nov 2006 11:05:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934398AbWKZQFY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Nov 2006 11:05:24 -0500
Received: from nic.NetDirect.CA ([216.16.235.2]:48364 "EHLO
	rubicon.netdirect.ca") by vger.kernel.org with ESMTP
	id S934395AbWKZQFX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Nov 2006 11:05:23 -0500
X-Originating-Ip: 72.57.81.197
Date: Sun, 26 Nov 2006 11:01:56 -0500 (EST)
From: "Robert P. J. Day" <rpjday@mindspring.com>
X-X-Sender: rpjday@localhost.localdomain
To: Linux kernel mailing list <linux-kernel@vger.kernel.org>
cc: trivial@kernel.org
Subject: [PATCH] kconfig: Standardize "depends" -> "depends on" in Kconfig
 files
Message-ID: <Pine.LNX.4.64.0611261101460.26743@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Net-Direct-Inc-MailScanner-Information: Please contact the ISP for more information
X-Net-Direct-Inc-MailScanner: Found to be clean
X-Net-Direct-Inc-MailScanner-SpamCheck: not spam, SpamAssassin (not cached,
	score=-1.722, required 5, autolearn=not spam, ALL_TRUSTED -1.80,
	BAYES_50 0.00, TW_DB 0.08, UPPERCASE_25_50 0.00)
X-Net-Direct-Inc-MailScanner-From: rpjday@mindspring.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


  Standardize the miniscule percentage of occurrences of "depends" in
Kconfig files to "depends on", and update kconfig-language.txt to
reflect that.

Signed-off-by: Robert P. J. Day <rpjday@mindspring.com>

---

  This patch doesn't address the redundancy of "requires", nor does it
simplify the kconf parser.  I'll leave that job to someone else.

 Documentation/kbuild/kconfig-language.txt  |    8 ++++----
 arch/arm/mach-pxa/Kconfig                  |   16 ++++++++--------
 arch/arm/plat-omap/Kconfig                 |    2 +-
 arch/powerpc/platforms/4xx/Kconfig         |    2 +-
 arch/powerpc/platforms/embedded6xx/Kconfig |    2 +-
 arch/ppc/Kconfig                           |    4 ++--
 arch/ppc/platforms/4xx/Kconfig             |    2 +-
 arch/v850/Kconfig                          |   28 ++++++++++++++--------------
 drivers/char/Kconfig                       |    2 +-
 drivers/ide/Kconfig                        |    2 +-
 drivers/leds/Kconfig                       |   22 +++++++++++-----------
 drivers/serial/Kconfig                     |    4 ++--
 fs/Kconfig                                 |    2 +-
 sound/aoa/fabrics/Kconfig                  |    2 +-
 14 files changed, 49 insertions(+), 49 deletions(-)


diff --git a/Documentation/kbuild/kconfig-language.txt b/Documentation/kbuild/kconfig-language.txt
index 125093c..536d5bf 100644
--- a/Documentation/kbuild/kconfig-language.txt
+++ b/Documentation/kbuild/kconfig-language.txt
@@ -29,7 +29,7 @@ them. A single configuration option is d

 config MODVERSIONS
 	bool "Set version information on all module symbols"
-	depends MODULES
+	depends on MODULES
 	help
 	  Usually, modules have to be recompiled whenever you switch to a new
 	  kernel.  ...
@@ -163,7 +163,7 @@ The position of a menu entry in the tree
 it can be specified explicitly:

 menu "Network device support"
-	depends NET
+	depends on NET

 config NETDEVICES
 	...
@@ -188,10 +188,10 @@ config MODULES

 config MODVERSIONS
 	bool "Set version information on all module symbols"
-	depends MODULES
+	depends on MODULES

 comment "module support disabled"
-	depends !MODULES
+	depends on !MODULES

 MODVERSIONS directly depends on MODULES, this means it's only visible if
 MODULES is different from 'n'. The comment on the other hand is always
diff --git a/arch/arm/mach-pxa/Kconfig b/arch/arm/mach-pxa/Kconfig
index 03d07ca..bc1038c 100644
--- a/arch/arm/mach-pxa/Kconfig
+++ b/arch/arm/mach-pxa/Kconfig
@@ -78,28 +78,28 @@ endmenu

 config MACH_POODLE
 	bool "Enable Sharp SL-5600 (Poodle) Support"
-	depends PXA_SHARPSL_25x
+	depends on PXA_SHARPSL_25x
 	select SHARP_LOCOMO
 	select PXA_SSP

 config MACH_CORGI
 	bool "Enable Sharp SL-C700 (Corgi) Support"
-	depends PXA_SHARPSL_25x
+	depends on PXA_SHARPSL_25x
 	select PXA_SHARP_C7xx

 config MACH_SHEPHERD
 	bool "Enable Sharp SL-C750 (Shepherd) Support"
-	depends PXA_SHARPSL_25x
+	depends on PXA_SHARPSL_25x
 	select PXA_SHARP_C7xx

 config MACH_HUSKY
 	bool "Enable Sharp SL-C760 (Husky) Support"
-	depends PXA_SHARPSL_25x
+	depends on PXA_SHARPSL_25x
 	select PXA_SHARP_C7xx

 config MACH_AKITA
 	bool "Enable Sharp SL-1000 (Akita) Support"
-	depends PXA_SHARPSL_27x
+	depends on PXA_SHARPSL_27x
 	select PXA_SHARP_Cxx00
 	select MACH_SPITZ
 	select I2C
@@ -107,17 +107,17 @@ config MACH_AKITA

 config MACH_SPITZ
 	bool "Enable Sharp Zaurus SL-3000 (Spitz) Support"
-	depends PXA_SHARPSL_27x
+	depends on PXA_SHARPSL_27x
 	select PXA_SHARP_Cxx00

 config MACH_BORZOI
 	bool "Enable Sharp Zaurus SL-3100 (Borzoi) Support"
-	depends PXA_SHARPSL_27x
+	depends on PXA_SHARPSL_27x
 	select PXA_SHARP_Cxx00

 config MACH_TOSA
 	bool "Enable Sharp SL-6000x (Tosa) Support"
-	depends PXA_SHARPSL_25x
+	depends on PXA_SHARPSL_25x

 config PXA25x
 	bool
diff --git a/arch/arm/plat-omap/Kconfig b/arch/arm/plat-omap/Kconfig
index ec752e1..f2dc363 100644
--- a/arch/arm/plat-omap/Kconfig
+++ b/arch/arm/plat-omap/Kconfig
@@ -113,7 +113,7 @@ endchoice

 config OMAP_SERIAL_WAKE
 	bool "Enable wake-up events for serial ports"
-	depends OMAP_MUX
+	depends on OMAP_MUX
 	default y
 	help
 	  Select this option if you want to have your system wake up
diff --git a/arch/powerpc/platforms/4xx/Kconfig b/arch/powerpc/platforms/4xx/Kconfig
index ed39d6a..2f2a13e 100644
--- a/arch/powerpc/platforms/4xx/Kconfig
+++ b/arch/powerpc/platforms/4xx/Kconfig
@@ -179,7 +179,7 @@ config BIOS_FIXUP
 # OAK doesn't exist but wanted to keep this around for any future 403GCX boards
 config 403GCX
 	bool
-	depends OAK
+	depends on OAK
 	default y

 config 405EP
diff --git a/arch/powerpc/platforms/embedded6xx/Kconfig b/arch/powerpc/platforms/embedded6xx/Kconfig
index 234a861..9a42928 100644
--- a/arch/powerpc/platforms/embedded6xx/Kconfig
+++ b/arch/powerpc/platforms/embedded6xx/Kconfig
@@ -35,7 +35,7 @@ config HDPU
 	  Select HDPU if configuring a Sky Computers Compute Blade.

 config HDPU_FEATURES
-	depends HDPU
+	depends on HDPU
 	tristate "HDPU-Features"
 	help
 	  Select to enable HDPU enhanced features.
diff --git a/arch/ppc/Kconfig b/arch/ppc/Kconfig
index 077711e..8e10bce 100644
--- a/arch/ppc/Kconfig
+++ b/arch/ppc/Kconfig
@@ -600,7 +600,7 @@ config HDPU
 	  Select HDPU if configuring a Sky Computers Compute Blade.

 config HDPU_FEATURES
-	depends HDPU
+	depends on HDPU
 	tristate "HDPU-Features"
 	help
 	  Select to enable HDPU enhanced features.
@@ -711,7 +711,7 @@ config LITE5200

 config LITE5200B
 	bool "Freescale LITE5200B"
-	depends LITE5200
+	depends on LITE5200
 	help
 	  Support for the LITE5200B dev board for the MPC5200 from Freescale.
 	  This is the new board with 2 PCI slots.
diff --git a/arch/ppc/platforms/4xx/Kconfig b/arch/ppc/platforms/4xx/Kconfig
index 293bd48..6980de4 100644
--- a/arch/ppc/platforms/4xx/Kconfig
+++ b/arch/ppc/platforms/4xx/Kconfig
@@ -189,7 +189,7 @@ config BIOS_FIXUP
 # OAK doesn't exist but wanted to keep this around for any future 403GCX boards
 config 403GCX
 	bool
-	depends OAK
+	depends on OAK
 	default y

 config 405EP
diff --git a/arch/v850/Kconfig b/arch/v850/Kconfig
index 37ec644..54b7904 100644
--- a/arch/v850/Kconfig
+++ b/arch/v850/Kconfig
@@ -97,17 +97,17 @@ menu "Processor type and features"
    # currently support
    config V850E_MA1
    	  bool
-	  depends RTE_CB_MA1
+	  depends on RTE_CB_MA1
 	  default y
    # Similarly for the RTE-V850E/NB85E-CB - V850E/TEG
    config V850E_TEG
    	  bool
-	  depends RTE_CB_NB85E
+	  depends on RTE_CB_NB85E
 	  default y
    # ... and the RTE-V850E/ME2-CB - V850E/ME2
    config V850E_ME2
    	  bool
-	  depends RTE_CB_ME2
+	  depends on RTE_CB_ME2
 	  default y


@@ -115,7 +115,7 @@ menu "Processor type and features"

    config V850E2_SIM85E2
    	  bool
-	  depends V850E2_SIM85E2C || V850E2_SIM85E2S
+	  depends on V850E2_SIM85E2C || V850E2_SIM85E2S
 	  default y


@@ -124,7 +124,7 @@ menu "Processor type and features"
    # V850E2 processors
    config V850E2
    	  bool
-	  depends V850E2_SIM85E2 || V850E2_FPGA85E2C || V850E2_ANNA
+	  depends on V850E2_SIM85E2 || V850E2_FPGA85E2C || V850E2_ANNA
 	  default y


@@ -133,7 +133,7 @@ menu "Processor type and features"
    # Boards in the RTE-x-CB series
    config RTE_CB
    	  bool
-	  depends RTE_CB_MA1 || RTE_CB_NB85E || RTE_CB_ME2
+	  depends on RTE_CB_MA1 || RTE_CB_NB85E || RTE_CB_ME2
 	  default y

    config RTE_CB_MULTI
@@ -141,28 +141,28 @@ menu "Processor type and features"
 	  # RTE_CB_NB85E can either have multi ROM support or not, but
 	  # other platforms (currently only RTE_CB_MA1) require it.
 	  prompt "Multi monitor ROM support" if RTE_CB_NB85E
-	  depends RTE_CB_MA1 || RTE_CB_NB85E
+	  depends on RTE_CB_MA1 || RTE_CB_NB85E
 	  default y

    config RTE_CB_MULTI_DBTRAP
    	  bool "Pass illegal insn trap / dbtrap to kernel"
-	  depends RTE_CB_MULTI
+	  depends on RTE_CB_MULTI
 	  default n

    config RTE_CB_MA1_KSRAM
    	  bool "Kernel in SRAM (limits size of kernel)"
-	  depends RTE_CB_MA1 && RTE_CB_MULTI
+	  depends on RTE_CB_MA1 && RTE_CB_MULTI
 	  default n

    config RTE_MB_A_PCI
    	  bool "Mother-A PCI support"
-	  depends RTE_CB
+	  depends on RTE_CB
 	  default y

    # The GBUS is used to talk to the RTE-MOTHER-A board
    config RTE_GBUS_INT
    	  bool
-	  depends RTE_MB_A_PCI
+	  depends on RTE_MB_A_PCI
 	  default y

    # The only PCI bus we support is on the RTE-MOTHER-A board
@@ -201,7 +201,7 @@ menu "Processor type and features"

    config ROM_KERNEL
    	  bool "Kernel in ROM"
-	  depends V850E2_ANNA || V850E_AS85EP1 || RTE_CB_ME2
+	  depends on V850E2_ANNA || V850E_AS85EP1 || RTE_CB_ME2

    # Some platforms pre-zero memory, in which case the kernel doesn't need to
    config ZERO_BSS
@@ -217,10 +217,10 @@ menu "Processor type and features"

    config V850E_HIGHRES_TIMER
    	  bool "High resolution timer support"
-	  depends V850E_TIMER_D
+	  depends on V850E_TIMER_D
    config TIME_BOOTUP
    	  bool "Time bootup"
-	  depends V850E_HIGHRES_TIMER
+	  depends on V850E_HIGHRES_TIMER

    config RESET_GUARD
    	  bool "Reset Guard"
diff --git a/drivers/char/Kconfig b/drivers/char/Kconfig
index 2af12fc..3e8d920 100644
--- a/drivers/char/Kconfig
+++ b/drivers/char/Kconfig
@@ -852,7 +852,7 @@ config SONYPI

 config TANBAC_TB0219
 	tristate "TANBAC TB0219 base board support"
-	depends TANBAC_TB022X
+	depends on TANBAC_TB022X
 	select GPIO_VR41XX

 menu "Ftape, the floppy tape device driver"
diff --git a/drivers/ide/Kconfig b/drivers/ide/Kconfig
index 0c68d0f..4464902 100644
--- a/drivers/ide/Kconfig
+++ b/drivers/ide/Kconfig
@@ -796,7 +796,7 @@ endchoice
 config BLK_DEV_IDE_AU1XXX_SEQTS_PER_RQ
        int "Maximum transfer size (KB) per request (up to 128)"
        default "128"
-       depends BLK_DEV_IDE_AU1XXX
+       depends on BLK_DEV_IDE_AU1XXX

 config IDE_ARM
 	def_bool ARM && (ARCH_A5K || ARCH_CLPS7500 || ARCH_RPC || ARCH_SHARK)
diff --git a/drivers/leds/Kconfig b/drivers/leds/Kconfig
index 9c39b98..852dd88 100644
--- a/drivers/leds/Kconfig
+++ b/drivers/leds/Kconfig
@@ -12,7 +12,7 @@ config NEW_LEDS

 config LEDS_CLASS
 	tristate "LED Class Support"
-	depends NEW_LEDS
+	depends on NEW_LEDS
 	help
 	  This option enables the led sysfs class in /sys/class/leds.  You'll
 	  need this to do anything useful with LEDs.  If unsure, say N.
@@ -21,28 +21,28 @@ comment "LED drivers"

 config LEDS_CORGI
 	tristate "LED Support for the Sharp SL-C7x0 series"
-	depends LEDS_CLASS && PXA_SHARP_C7xx
+	depends on LEDS_CLASS && PXA_SHARP_C7xx
 	help
 	  This option enables support for the LEDs on Sharp Zaurus
 	  SL-C7x0 series (C700, C750, C760, C860).

 config LEDS_LOCOMO
 	tristate "LED Support for Locomo device"
-	depends LEDS_CLASS && SHARP_LOCOMO
+	depends on LEDS_CLASS && SHARP_LOCOMO
 	help
 	  This option enables support for the LEDs on Sharp Locomo.
 	  Zaurus models SL-5500 and SL-5600.

 config LEDS_SPITZ
 	tristate "LED Support for the Sharp SL-Cxx00 series"
-	depends LEDS_CLASS && PXA_SHARP_Cxx00
+	depends on LEDS_CLASS && PXA_SHARP_Cxx00
 	help
 	  This option enables support for the LEDs on Sharp Zaurus
 	  SL-Cxx00 series (C1000, C3000, C3100).

 config LEDS_IXP4XX
 	tristate "LED Support for GPIO connected LEDs on IXP4XX processors"
-	depends LEDS_CLASS && ARCH_IXP4XX
+	depends on LEDS_CLASS && ARCH_IXP4XX
 	help
 	  This option enables support for the LEDs connected to GPIO
 	  outputs of the Intel IXP4XX processors.  To be useful the
@@ -51,7 +51,7 @@ config LEDS_IXP4XX

 config LEDS_TOSA
 	tristate "LED Support for the Sharp SL-6000 series"
-	depends LEDS_CLASS && PXA_SHARPSL
+	depends on LEDS_CLASS && PXA_SHARPSL
 	help
 	  This option enables support for the LEDs on Sharp Zaurus
 	  SL-6000 series.
@@ -65,7 +65,7 @@ config LEDS_S3C24XX

 config LEDS_AMS_DELTA
 	tristate "LED Support for the Amstrad Delta (E3)"
-	depends LEDS_CLASS && MACH_AMS_DELTA
+	depends on LEDS_CLASS && MACH_AMS_DELTA
 	help
 	  This option enables support for the LEDs on Amstrad Delta (E3).

@@ -80,7 +80,7 @@ comment "LED Triggers"

 config LEDS_TRIGGERS
 	bool "LED Trigger support"
-	depends NEW_LEDS
+	depends on NEW_LEDS
 	help
 	  This option enables trigger support for the leds class.
 	  These triggers allow kernel events to drive the LEDs and can
@@ -88,21 +88,21 @@ config LEDS_TRIGGERS

 config LEDS_TRIGGER_TIMER
 	tristate "LED Timer Trigger"
-	depends LEDS_TRIGGERS
+	depends on LEDS_TRIGGERS
 	help
 	  This allows LEDs to be controlled by a programmable timer
 	  via sysfs. If unsure, say Y.

 config LEDS_TRIGGER_IDE_DISK
 	bool "LED IDE Disk Trigger"
-	depends LEDS_TRIGGERS && BLK_DEV_IDEDISK
+	depends on LEDS_TRIGGERS && BLK_DEV_IDEDISK
 	help
 	  This allows LEDs to be controlled by IDE disk activity.
 	  If unsure, say Y.

 config LEDS_TRIGGER_HEARTBEAT
 	tristate "LED Heartbeat Trigger"
-	depends LEDS_TRIGGERS
+	depends on LEDS_TRIGGERS
 	help
 	  This allows LEDs to be controlled by a CPU load average.
 	  The flash frequency is a hyperbolic function of the 1-minute
diff --git a/drivers/serial/Kconfig b/drivers/serial/Kconfig
index 0b71e7d..f652f82 100644
--- a/drivers/serial/Kconfig
+++ b/drivers/serial/Kconfig
@@ -634,7 +634,7 @@ config V850E_UART

 config V850E_UARTB
         bool
-	depends V850E_UART && V850E_ME2
+	depends on V850E_UART && V850E_ME2
 	default y

 config V850E_UART_CONSOLE
@@ -880,7 +880,7 @@ config SERIAL_M32R_PLDSIO

 config SERIAL_TXX9
 	bool "TMPTX39XX/49XX SIO support"
-	depends HAS_TXX9_SERIAL
+	depends on HAS_TXX9_SERIAL
 	select SERIAL_CORE
 	default y

diff --git a/fs/Kconfig b/fs/Kconfig
index 7b1511d..7f4c418 100644
--- a/fs/Kconfig
+++ b/fs/Kconfig
@@ -1008,7 +1008,7 @@ config TMPFS_POSIX_ACL

 config HUGETLBFS
 	bool "HugeTLB file system support"
-	depends X86 || IA64 || PPC64 || SPARC64 || SUPERH || BROKEN
+	depends on X86 || IA64 || PPC64 || SPARC64 || SUPERH || BROKEN
 	help
 	  hugetlbfs is a filesystem backing for HugeTLB pages, based on
 	  ramfs. For architectures that support it, say Y here and read
diff --git a/sound/aoa/fabrics/Kconfig b/sound/aoa/fabrics/Kconfig
index c3bc770..50d7021 100644
--- a/sound/aoa/fabrics/Kconfig
+++ b/sound/aoa/fabrics/Kconfig
@@ -1,6 +1,6 @@
 config SND_AOA_FABRIC_LAYOUT
 	tristate "layout-id fabric"
-	depends SND_AOA
+	depends on SND_AOA
 	select SND_AOA_SOUNDBUS
 	select SND_AOA_SOUNDBUS_I2S
 	---help---
