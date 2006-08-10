Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932130AbWHJTfR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932130AbWHJTfR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 15:35:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932135AbWHJTfQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 15:35:16 -0400
Received: from mx1.suse.de ([195.135.220.2]:144 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932130AbWHJTfP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 15:35:15 -0400
From: Andi Kleen <ak@suse.de>
References: <20060810 935.775038000@suse.de>
In-Reply-To: <20060810 935.775038000@suse.de>
Subject: [PATCH for review] [1/145] x86_64: Update defconfig
Message-Id: <20060810193512.E2B2B13B90@wotan.suse.de>
Date: Thu, 10 Aug 2006 21:35:12 +0200 (CEST)
To: undisclosed-recipients:;
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

r

Enable cpufrequency debugging
Disable soft watchdog

Signed-off-by: Andi Kleen <ak@suse.de>

---
 arch/x86_64/defconfig |   56 ++++++++------------------------------------------
 1 files changed, 10 insertions(+), 46 deletions(-)

Index: linux/arch/x86_64/defconfig
===================================================================
--- linux.orig/arch/x86_64/defconfig
+++ linux/arch/x86_64/defconfig
@@ -1,7 +1,7 @@
 #
 # Automatically generated make config: don't edit
-# Linux kernel version: 2.6.18-rc2
-# Tue Jul 18 17:13:20 2006
+# Linux kernel version: 2.6.18-rc3-git6
+# Sat Aug  5 02:32:50 2006
 #
 CONFIG_X86_64=y
 CONFIG_64BIT=y
@@ -201,7 +201,7 @@ CONFIG_ACPI_THERMAL=y
 CONFIG_ACPI_NUMA=y
 # CONFIG_ACPI_ASUS is not set
 # CONFIG_ACPI_IBM is not set
-CONFIG_ACPI_TOSHIBA=y
+# CONFIG_ACPI_TOSHIBA is not set
 CONFIG_ACPI_BLACKLIST_YEAR=0
 # CONFIG_ACPI_DEBUG is not set
 CONFIG_ACPI_EC=y
@@ -216,7 +216,7 @@ CONFIG_ACPI_CONTAINER=y
 #
 CONFIG_CPU_FREQ=y
 CONFIG_CPU_FREQ_TABLE=y
-# CONFIG_CPU_FREQ_DEBUG is not set
+CONFIG_CPU_FREQ_DEBUG=y
 CONFIG_CPU_FREQ_STAT=y
 # CONFIG_CPU_FREQ_STAT_DETAILS is not set
 CONFIG_CPU_FREQ_DEFAULT_GOV_PERFORMANCE=y
@@ -512,7 +512,7 @@ CONFIG_SCSI_CONSTANTS=y
 CONFIG_SCSI_SPI_ATTRS=y
 CONFIG_SCSI_FC_ATTRS=y
 # CONFIG_SCSI_ISCSI_ATTRS is not set
-# CONFIG_SCSI_SAS_ATTRS is not set
+CONFIG_SCSI_SAS_ATTRS=y
 
 #
 # SCSI low-level drivers
@@ -538,7 +538,7 @@ CONFIG_MEGARAID_MAILBOX=y
 CONFIG_MEGARAID_SAS=y
 CONFIG_SCSI_SATA=y
 CONFIG_SCSI_SATA_AHCI=y
-# CONFIG_SCSI_SATA_SVW is not set
+CONFIG_SCSI_SATA_SVW=y
 CONFIG_SCSI_ATA_PIIX=y
 # CONFIG_SCSI_SATA_MV is not set
 CONFIG_SCSI_SATA_NV=y
@@ -589,7 +589,7 @@ CONFIG_BLK_DEV_DM=y
 CONFIG_FUSION=y
 CONFIG_FUSION_SPI=y
 # CONFIG_FUSION_FC is not set
-# CONFIG_FUSION_SAS is not set
+CONFIG_FUSION_SAS=y
 CONFIG_FUSION_MAX_SGE=128
 # CONFIG_FUSION_CTL is not set
 
@@ -675,7 +675,7 @@ CONFIG_NET_PCI=y
 # CONFIG_PCNET32 is not set
 # CONFIG_AMD8111_ETH is not set
 # CONFIG_ADAPTEC_STARFIRE is not set
-# CONFIG_B44 is not set
+CONFIG_B44=y
 CONFIG_FORCEDETH=y
 # CONFIG_DGRS is not set
 # CONFIG_EEPRO100 is not set
@@ -842,44 +842,7 @@ CONFIG_LEGACY_PTY_COUNT=256
 #
 # Watchdog Cards
 #
-CONFIG_WATCHDOG=y
-# CONFIG_WATCHDOG_NOWAYOUT is not set
-
-#
-# Watchdog Device Drivers
-#
-CONFIG_SOFT_WATCHDOG=y
-# CONFIG_ACQUIRE_WDT is not set
-# CONFIG_ADVANTECH_WDT is not set
-# CONFIG_ALIM1535_WDT is not set
-# CONFIG_ALIM7101_WDT is not set
-# CONFIG_SC520_WDT is not set
-# CONFIG_EUROTECH_WDT is not set
-# CONFIG_IB700_WDT is not set
-# CONFIG_IBMASR is not set
-# CONFIG_WAFER_WDT is not set
-# CONFIG_I6300ESB_WDT is not set
-# CONFIG_I8XX_TCO is not set
-# CONFIG_SC1200_WDT is not set
-# CONFIG_60XX_WDT is not set
-# CONFIG_SBC8360_WDT is not set
-# CONFIG_CPU5_WDT is not set
-# CONFIG_W83627HF_WDT is not set
-# CONFIG_W83877F_WDT is not set
-# CONFIG_W83977F_WDT is not set
-# CONFIG_MACHZ_WDT is not set
-# CONFIG_SBC_EPX_C3_WATCHDOG is not set
-
-#
-# PCI-based Watchdog Cards
-#
-# CONFIG_PCIPCWATCHDOG is not set
-# CONFIG_WDTPCI is not set
-
-#
-# USB-based Watchdog Cards
-#
-# CONFIG_USBPCWATCHDOG is not set
+# CONFIG_WATCHDOG is not set
 CONFIG_HW_RANDOM=y
 CONFIG_HW_RANDOM_INTEL=y
 CONFIG_HW_RANDOM_AMD=y
@@ -1056,6 +1019,7 @@ CONFIG_VGACON_SOFT_SCROLLBACK=y
 CONFIG_VGACON_SOFT_SCROLLBACK_SIZE=256
 CONFIG_VIDEO_SELECT=y
 CONFIG_DUMMY_CONSOLE=y
+# CONFIG_BACKLIGHT_LCD_SUPPORT is not set
 
 #
 # Sound
