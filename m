Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261791AbUB0K4f (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Feb 2004 05:56:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261795AbUB0K4e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Feb 2004 05:56:34 -0500
Received: from s4.uklinux.net ([80.84.72.14]:6358 "EHLO mail2.uklinux.net")
	by vger.kernel.org with ESMTP id S261791AbUB0Kxo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Feb 2004 05:53:44 -0500
Date: Fri, 27 Feb 2004 10:53:16 +0000
To: linux-kernel@vger.kernel.org
Subject: ALSA and CD Audio problems on Acer Aspire 1350
Message-ID: <20040227105316.GA4346@titan.home.hindley.uklinux.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
From: Mark Hindley <mark@hindley.uklinux.net>
X-MailScanner-Titan: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I am encountering 2 problems with ALSA on my new Acer Aspire 1353XV.

Using 2.6.3, modular kernel.

Firstly, I get the following error when playing using aplay:

Feb 27 10:19:54 mercury kernel: ALSA sound/pci/via82xx.c:724: invalid via82xx_cur_ptr, using last valid pointer

The sound produced is a bit 'choppy'.

Secondly, I can get no CD Audio. Mixer settings are fine. cdplayer shows the
disc is playing, lights flash etc, but no output or ^ soundcard irqs. All mixer settings
are up and unmuted.

I have tried the various module params with no effect.

Any suggestions? Thanks.

Mark

lspci -v gives

00:00.0 Host bridge: VIA Technologies, Inc.: Unknown device 3205
	Subsystem: VIA Technologies, Inc.: Unknown device 7205
	Flags: bus master, 66Mhz, medium devsel, latency 8
	Memory at e0000000 (32-bit, prefetchable) [size=256M]
	Capabilities: [80] AGP version 3.5
	Capabilities: [c0] Power Management version 2

00:01.0 PCI bridge: VIA Technologies, Inc.: Unknown device b168 (prog-if 00 [Normal decode])
	Flags: bus master, 66Mhz, medium devsel, latency 0
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
	Memory behind bridge: d1000000-d1ffffff
	Prefetchable memory behind bridge: f0000000-f3ffffff
	Capabilities: [80] Power Management version 2

00:07.0 CardBus bridge: Texas Instruments PCI1410 PC card Cardbus Controller (rev 02)
	Subsystem: Acer Incorporated [ALI]: Unknown device 0033
	Flags: bus master, medium devsel, latency 0, IRQ 5
	Memory at 10000000 (32-bit, non-prefetchable) [size=4K]
	Bus: primary=00, secondary=02, subordinate=05, sec-latency=176
	I/O window 0: 00000000-00000003
	I/O window 1: 00000000-00000003
	16-bit legacy interface ports at 0001

00:08.0 FireWire (IEEE 1394): Texas Instruments: Unknown device 8026 (prog-if 10 [OHCI])
	Subsystem: Acer Incorporated [ALI]: Unknown device 0033
	Flags: medium devsel, IRQ 5
	Memory at d0004000 (32-bit, non-prefetchable) [size=2K]
	Memory at d0000000 (32-bit, non-prefetchable) [size=16K]
	Capabilities: [44] Power Management version 2

00:10.0 USB Controller: VIA Technologies, Inc. UHCI USB (rev 80) (prog-if 00 [UHCI])
	Subsystem: Acer Incorporated [ALI]: Unknown device 0033
	Flags: bus master, medium devsel, latency 64, IRQ 4
	I/O ports at 1c00 [size=32]
	Capabilities: [80] Power Management version 2

00:10.1 USB Controller: VIA Technologies, Inc. UHCI USB (rev 80) (prog-if 00 [UHCI])
	Subsystem: Acer Incorporated [ALI]: Unknown device 0033
	Flags: bus master, medium devsel, latency 64, IRQ 5
	I/O ports at 1c20 [size=32]
	Capabilities: [80] Power Management version 2

00:10.2 USB Controller: VIA Technologies, Inc. UHCI USB (rev 80) (prog-if 00 [UHCI])
	Subsystem: Acer Incorporated [ALI]: Unknown device 0033
	Flags: bus master, medium devsel, latency 64, IRQ 9
	I/O ports at 1c40 [size=32]
	Capabilities: [80] Power Management version 2

00:10.3 USB Controller: VIA Technologies, Inc.: Unknown device 3104 (rev 82) (prog-if 20)
	Subsystem: Acer Incorporated [ALI]: Unknown device 0033
	Flags: bus master, medium devsel, latency 64, IRQ 11
	Memory at d0004800 (32-bit, non-prefetchable) [size=256]
	Capabilities: [80] Power Management version 2

00:11.0 ISA bridge: VIA Technologies, Inc.: Unknown device 3177
	Subsystem: Acer Incorporated [ALI]: Unknown device 0033
	Flags: bus master, stepping, medium devsel, latency 0
	Capabilities: [c0] Power Management version 2

00:11.1 IDE interface: VIA Technologies, Inc. Bus Master IDE (rev 06) (prog-if 8a [Master SecP PriP])
	Subsystem: Acer Incorporated [ALI]: Unknown device 0033
	Flags: bus master, medium devsel, latency 64, IRQ 4
	I/O ports at 1c60 [size=16]
	Capabilities: [c0] Power Management version 2

00:11.5 Multimedia audio controller: VIA Technologies, Inc. AC97 Audio Controller (rev 50)
	Subsystem: Acer Incorporated [ALI]: Unknown device 0033
	Flags: medium devsel, IRQ 9
	I/O ports at 1000 [size=256]
	Capabilities: [c0] Power Management version 2

00:11.6 Communication controller: VIA Technologies, Inc. AC97 Modem Controller (rev 80)
	Subsystem: Acer Incorporated [ALI]: Unknown device 0033
	Flags: medium devsel, IRQ 9
	I/O ports at 1400 [size=256]
	Capabilities: [d0] Power Management version 2

00:12.0 Ethernet controller: VIA Technologies, Inc. Ethernet Controller (rev 74)
	Subsystem: Acer Incorporated [ALI]: Unknown device 0033
	Flags: bus master, medium devsel, latency 64, IRQ 4
	I/O ports at 1800 [size=256]
	Memory at d0004c00 (32-bit, non-prefetchable) [size=256]
	Capabilities: [40] Power Management version 2

01:00.0 VGA compatible controller: VIA Technologies, Inc.: Unknown device 7205 (rev 01) (prog-if 00 [VGA])
	Subsystem: Acer Incorporated [ALI]: Unknown device 0033
	Flags: bus master, 66Mhz, medium devsel, latency 64, IRQ 4
	Memory at f0000000 (32-bit, prefetchable) [size=64M]
	Memory at d1000000 (32-bit, non-prefetchable) [size=16M]
	Expansion ROM at <unassigned> [disabled] [size=64K]
	Capabilities: [60] Power Management version 2
	Capabilities: [70] AGP version 2.0

pruned .config file is:

#
# Automatically generated make config: don't edit
#
CONFIG_X86=y
CONFIG_MMU=y
CONFIG_UID16=y
CONFIG_GENERIC_ISA_DMA=y

#
# Code maturity level options
#
CONFIG_EXPERIMENTAL=y
CONFIG_CLEAN_COMPILE=y
CONFIG_STANDALONE=y
CONFIG_BROKEN_ON_SMP=y

#
# General setup
#
CONFIG_SWAP=y
CONFIG_SYSVIPC=y
CONFIG_BSD_PROCESS_ACCT=y
CONFIG_SYSCTL=y
CONFIG_LOG_BUF_SHIFT=17
# CONFIG_IKCONFIG is not set
# CONFIG_EMBEDDED is not set
CONFIG_KALLSYMS=y
CONFIG_FUTEX=y
CONFIG_EPOLL=y
CONFIG_IOSCHED_NOOP=y
CONFIG_IOSCHED_AS=y
CONFIG_IOSCHED_DEADLINE=y
# CONFIG_CC_OPTIMIZE_FOR_SIZE is not set

#
# Loadable module support
#
CONFIG_MODULES=y
CONFIG_MODULE_UNLOAD=y
# CONFIG_MODULE_FORCE_UNLOAD is not set
CONFIG_OBSOLETE_MODPARM=y
CONFIG_MODVERSIONS=y
CONFIG_KMOD=y

#
# Processor type and features
#
CONFIG_X86_PC=y
# CONFIG_X86_VOYAGER is not set
# CONFIG_X86_NUMAQ is not set
# CONFIG_X86_SUMMIT is not set
# CONFIG_X86_BIGSMP is not set
# CONFIG_X86_VISWS is not set
# CONFIG_X86_GENERICARCH is not set
# CONFIG_X86_ES7000 is not set
# CONFIG_M386 is not set
# CONFIG_M486 is not set
# CONFIG_M586 is not set
# CONFIG_M586TSC is not set
# CONFIG_M586MMX is not set
# CONFIG_M686 is not set
# CONFIG_MPENTIUMII is not set
# CONFIG_MPENTIUMIII is not set
# CONFIG_MPENTIUM4 is not set
# CONFIG_MK6 is not set
CONFIG_MK7=y
# CONFIG_MK8 is not set
# CONFIG_MELAN is not set
# CONFIG_MCRUSOE is not set
# CONFIG_MWINCHIPC6 is not set
# CONFIG_MWINCHIP2 is not set
# CONFIG_MWINCHIP3D is not set
# CONFIG_MCYRIXIII is not set
# CONFIG_MVIAC3_2 is not set
# CONFIG_X86_GENERIC is not set
CONFIG_X86_CMPXCHG=y
CONFIG_X86_XADD=y
CONFIG_X86_L1_CACHE_SHIFT=6
CONFIG_RWSEM_XCHGADD_ALGORITHM=y
CONFIG_X86_WP_WORKS_OK=y
CONFIG_X86_INVLPG=y
CONFIG_X86_BSWAP=y
CONFIG_X86_POPAD_OK=y
CONFIG_X86_GOOD_APIC=y
CONFIG_X86_INTEL_USERCOPY=y
CONFIG_X86_USE_PPRO_CHECKSUM=y
CONFIG_X86_USE_3DNOW=y
# CONFIG_HPET_TIMER is not set
# CONFIG_HPET_EMULATE_RTC is not set
# CONFIG_SMP is not set
CONFIG_PREEMPT=y
CONFIG_X86_UP_APIC=y
CONFIG_X86_UP_IOAPIC=y
CONFIG_X86_LOCAL_APIC=y
CONFIG_X86_IO_APIC=y
CONFIG_X86_TSC=y
# CONFIG_X86_MCE is not set
# CONFIG_TOSHIBA is not set
# CONFIG_I8K is not set
# CONFIG_MICROCODE is not set
# CONFIG_X86_MSR is not set
CONFIG_X86_CPUID=m
# CONFIG_EDD is not set
CONFIG_NOHIGHMEM=y
# CONFIG_HIGHMEM4G is not set
# CONFIG_HIGHMEM64G is not set
# CONFIG_MATH_EMULATION is not set
CONFIG_MTRR=y
# CONFIG_EFI is not set
CONFIG_HAVE_DEC_LOCK=y

#
# Power management options (ACPI, APM)
#
CONFIG_PM=y
# CONFIG_SOFTWARE_SUSPEND is not set
# CONFIG_PM_DISK is not set

#
# ACPI (Advanced Configuration and Power Interface) Support
#
CONFIG_ACPI=y
CONFIG_ACPI_BOOT=y
CONFIG_ACPI_INTERPRETER=y
CONFIG_ACPI_SLEEP=y
CONFIG_ACPI_SLEEP_PROC_FS=y
CONFIG_ACPI_AC=m
CONFIG_ACPI_BATTERY=m
CONFIG_ACPI_BUTTON=m
CONFIG_ACPI_FAN=m
CONFIG_ACPI_PROCESSOR=m
CONFIG_ACPI_THERMAL=m
# CONFIG_ACPI_ASUS is not set
# CONFIG_ACPI_TOSHIBA is not set
# CONFIG_ACPI_DEBUG is not set
CONFIG_ACPI_BUS=y
CONFIG_ACPI_EC=y
CONFIG_ACPI_POWER=y
CONFIG_ACPI_PCI=y
CONFIG_ACPI_SYSTEM=y
# CONFIG_ACPI_RELAXED_AML is not set

#
# APM (Advanced Power Management) BIOS Support
#
CONFIG_APM=m
# CONFIG_APM_IGNORE_USER_SUSPEND is not set
# CONFIG_APM_DO_ENABLE is not set
# CONFIG_APM_CPU_IDLE is not set
# CONFIG_APM_DISPLAY_BLANK is not set
# CONFIG_APM_RTC_IS_GMT is not set
CONFIG_APM_ALLOW_INTS=y
# CONFIG_APM_REAL_MODE_POWER_OFF is not set

#
# CPU Frequency scaling
#
# CONFIG_CPU_FREQ is not set

#
# Bus options (PCI, PCMCIA, EISA, MCA, ISA)
#
CONFIG_PCI=y
# CONFIG_PCI_GOBIOS is not set
# CONFIG_PCI_GODIRECT is not set
CONFIG_PCI_GOANY=y
CONFIG_PCI_BIOS=y
CONFIG_PCI_DIRECT=y
# CONFIG_PCI_USE_VECTOR is not set
# CONFIG_PCI_LEGACY_PROC is not set
CONFIG_PCI_NAMES=y
CONFIG_ISA=y
# CONFIG_EISA is not set
# CONFIG_MCA is not set
# CONFIG_SCx200 is not set
CONFIG_HOTPLUG=y

#
# PCMCIA/CardBus support
#
CONFIG_PCMCIA=y
CONFIG_YENTA=m
CONFIG_CARDBUS=y
# CONFIG_I82092 is not set
CONFIG_I82365=m
# CONFIG_TCIC is not set
CONFIG_PCMCIA_PROBE=y

#
# PCI Hotplug Support
#
# CONFIG_HOTPLUG_PCI is not set

#
# Executable file formats
#
CONFIG_BINFMT_ELF=y
# CONFIG_BINFMT_AOUT is not set
CONFIG_BINFMT_MISC=y

#
# Device Drivers
#

#
# Plug and Play support
#
# CONFIG_PNP is not set

#
# ATA/ATAPI/MFM/RLL support
#
CONFIG_IDE=y
CONFIG_BLK_DEV_IDE=y

#
# Please see Documentation/ide.txt for help/info on IDE drives
#
# CONFIG_BLK_DEV_HD_IDE is not set
CONFIG_BLK_DEV_IDEDISK=y
# CONFIG_IDEDISK_MULTI_MODE is not set
# CONFIG_IDEDISK_STROKE is not set
# CONFIG_BLK_DEV_IDECS is not set
CONFIG_BLK_DEV_IDECD=m
# CONFIG_BLK_DEV_IDETAPE is not set
# CONFIG_BLK_DEV_IDEFLOPPY is not set
# CONFIG_IDE_TASK_IOCTL is not set
# CONFIG_IDE_TASKFILE_IO is not set

#
# IDE chipset support/bugfixes
#
CONFIG_IDE_GENERIC=y
# CONFIG_BLK_DEV_CMD640 is not set
CONFIG_BLK_DEV_IDEPCI=y
CONFIG_IDEPCI_SHARE_IRQ=y
# CONFIG_BLK_DEV_OFFBOARD is not set
# CONFIG_BLK_DEV_GENERIC is not set
# CONFIG_BLK_DEV_OPTI621 is not set
# CONFIG_BLK_DEV_RZ1000 is not set
CONFIG_BLK_DEV_IDEDMA_PCI=y
# CONFIG_BLK_DEV_IDEDMA_FORCED is not set
CONFIG_IDEDMA_PCI_AUTO=y
# CONFIG_IDEDMA_ONLYDISK is not set
CONFIG_BLK_DEV_ADMA=y
# CONFIG_BLK_DEV_AEC62XX is not set
# CONFIG_BLK_DEV_ALI15X3 is not set
# CONFIG_BLK_DEV_AMD74XX is not set
# CONFIG_BLK_DEV_CMD64X is not set
# CONFIG_BLK_DEV_TRIFLEX is not set
# CONFIG_BLK_DEV_CY82C693 is not set
# CONFIG_BLK_DEV_CS5520 is not set
# CONFIG_BLK_DEV_CS5530 is not set
# CONFIG_BLK_DEV_HPT34X is not set
# CONFIG_BLK_DEV_HPT366 is not set
# CONFIG_BLK_DEV_SC1200 is not set
CONFIG_BLK_DEV_PIIX=y
# CONFIG_BLK_DEV_NS87415 is not set
# CONFIG_BLK_DEV_PDC202XX_OLD is not set
# CONFIG_BLK_DEV_PDC202XX_NEW is not set
# CONFIG_BLK_DEV_SVWKS is not set
# CONFIG_BLK_DEV_SIIMAGE is not set
# CONFIG_BLK_DEV_SIS5513 is not set
# CONFIG_BLK_DEV_SLC90E66 is not set
# CONFIG_BLK_DEV_TRM290 is not set
CONFIG_BLK_DEV_VIA82CXXX=y
# CONFIG_IDE_CHIPSETS is not set
CONFIG_BLK_DEV_IDEDMA=y
# CONFIG_IDEDMA_IVB is not set
CONFIG_IDEDMA_AUTO=y
# CONFIG_DMA_NONPCI is not set
# CONFIG_BLK_DEV_HD is not set

#
# SCSI device support
#
# CONFIG_SCSI is not set

#
# Old CD-ROM drivers (not SCSI, not IDE)
#
# CONFIG_CD_NO_IDESCSI is not set

#
# Sound
#
CONFIG_SOUND=m

#
# Advanced Linux Sound Architecture
#
CONFIG_SND=m
CONFIG_SND_SEQUENCER=m
# CONFIG_SND_SEQ_DUMMY is not set
CONFIG_SND_OSSEMUL=y
CONFIG_SND_MIXER_OSS=m
CONFIG_SND_PCM_OSS=m
CONFIG_SND_SEQUENCER_OSS=y
# CONFIG_SND_RTCTIMER is not set
CONFIG_SND_VERBOSE_PRINTK=y
CONFIG_SND_DEBUG=y
# CONFIG_SND_DEBUG_MEMORY is not set
CONFIG_SND_DEBUG_DETECT=y

#
# Generic devices
#
# CONFIG_SND_DUMMY is not set
# CONFIG_SND_VIRMIDI is not set
# CONFIG_SND_MTPAV is not set
# CONFIG_SND_SERIAL_U16550 is not set
# CONFIG_SND_MPU401 is not set

#
# PCI devices
#
# CONFIG_SND_ALI5451 is not set
# CONFIG_SND_AZT3328 is not set
# CONFIG_SND_BT87X is not set
# CONFIG_SND_CS46XX is not set
# CONFIG_SND_CS4281 is not set
# CONFIG_SND_EMU10K1 is not set
# CONFIG_SND_KORG1212 is not set
# CONFIG_SND_NM256 is not set
# CONFIG_SND_RME32 is not set
# CONFIG_SND_RME96 is not set
# CONFIG_SND_RME9652 is not set
# CONFIG_SND_HDSP is not set
# CONFIG_SND_TRIDENT is not set
# CONFIG_SND_YMFPCI is not set
# CONFIG_SND_ALS4000 is not set
# CONFIG_SND_CMIPCI is not set
# CONFIG_SND_ENS1370 is not set
# CONFIG_SND_ENS1371 is not set
# CONFIG_SND_ES1938 is not set
# CONFIG_SND_ES1968 is not set
# CONFIG_SND_MAESTRO3 is not set
# CONFIG_SND_FM801 is not set
# CONFIG_SND_ICE1712 is not set
# CONFIG_SND_ICE1724 is not set
# CONFIG_SND_INTEL8X0 is not set
# CONFIG_SND_SONICVIBES is not set
CONFIG_SND_VIA82XX=m
# CONFIG_SND_VX222 is not set


Let me know if you want/need other info.

Thanks.

Mark
