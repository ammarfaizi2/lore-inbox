Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266732AbUF3QDq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266732AbUF3QDq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jun 2004 12:03:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266691AbUF3QDq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jun 2004 12:03:46 -0400
Received: from web51806.mail.yahoo.com ([206.190.38.237]:14678 "HELO
	web51806.mail.yahoo.com") by vger.kernel.org with SMTP
	id S266732AbUF3QB0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jun 2004 12:01:26 -0400
Message-ID: <20040630160124.46609.qmail@web51806.mail.yahoo.com>
Date: Wed, 30 Jun 2004 09:01:24 -0700 (PDT)
From: Phy Prabab <phyprabab@yahoo.com>
Subject: Re: [2.6.7-mm4] Network regression?
To: Stefano Rivoir <s.rivoir@gts.it>, linux-kernel@vger.kernel.org
In-Reply-To: <40E2E16D.9030301@gts.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pulled from another thread, have you tried this:

sysctl -w net.ipv4.tcp_default_win_scale=0


Phy
--- Stefano Rivoir <s.rivoir@gts.it> wrote:
> 
> Hi all,
> 
> as probably discussed in another thread (or maybe
> related to it?), 
> 2.6.7-mm4 shows here a massive drop in network
> performances, while 
> vanilla 2.6.7 runs just fine.
> 
> I'm behind a ~150 KBytes/sec ADSL, and with 2.6.7 I
> can download at full 
> speed, while with -mm4 I can't go over 18/19 Kb/sec.
> 
> Note that I'm just apt-getting from
> http://http.us.debian.org, but even 
> downloading from kernel.org does the same.
> 
> Am I missing something I should be aware of?
> 
> Here attached, .config and lspci -v.
> 
> Bye
> 
> -- 
> Stefano RIVOIR
> 
> > #
> # Automatically generated make config: don't edit
> #
> CONFIG_X86=y
> CONFIG_MMU=y
> CONFIG_UID16=y
> CONFIG_GENERIC_ISA_DMA=y
> 
> #
> # Code maturity level options
> #
> CONFIG_EXPERIMENTAL=y
> # CONFIG_CLEAN_COMPILE is not set
> # CONFIG_STANDALONE is not set
> CONFIG_BROKEN=y
> CONFIG_BROKEN_ON_SMP=y
> 
> #
> # General setup
> #
> CONFIG_SWAP=y
> CONFIG_SYSVIPC=y
> CONFIG_POSIX_MQUEUE=y
> CONFIG_BSD_PROCESS_ACCT=y
> CONFIG_SYSCTL=y
> # CONFIG_AUDIT is not set
> CONFIG_LOG_BUF_SHIFT=15
> CONFIG_HOTPLUG=y
> # CONFIG_IKCONFIG is not set
> # CONFIG_EMBEDDED is not set
> CONFIG_KALLSYMS=y
> # CONFIG_KALLSYMS_ALL is not set
> CONFIG_FUTEX=y
> CONFIG_EPOLL=y
> CONFIG_IOSCHED_NOOP=y
> CONFIG_IOSCHED_AS=y
> CONFIG_IOSCHED_DEADLINE=y
> CONFIG_IOSCHED_CFQ=y
> # CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
> 
> #
> # Loadable module support
> #
> CONFIG_MODULES=y
> CONFIG_MODULE_UNLOAD=y
> # CONFIG_MODULE_FORCE_UNLOAD is not set
> CONFIG_OBSOLETE_MODPARM=y
> # CONFIG_MODVERSIONS is not set
> CONFIG_KMOD=y
> 
> #
> # Processor type and features
> #
> CONFIG_X86_PC=y
> # CONFIG_X86_ELAN is not set
> # CONFIG_X86_VOYAGER is not set
> # CONFIG_X86_NUMAQ is not set
> # CONFIG_X86_SUMMIT is not set
> # CONFIG_X86_BIGSMP is not set
> # CONFIG_X86_VISWS is not set
> # CONFIG_X86_GENERICARCH is not set
> # CONFIG_X86_ES7000 is not set
> # CONFIG_M386 is not set
> # CONFIG_M486 is not set
> # CONFIG_M586 is not set
> # CONFIG_M586TSC is not set
> # CONFIG_M586MMX is not set
> # CONFIG_M686 is not set
> # CONFIG_MPENTIUMII is not set
> # CONFIG_MPENTIUMIII is not set
> # CONFIG_MPENTIUMM is not set
> CONFIG_MPENTIUM4=y
> # CONFIG_MK6 is not set
> # CONFIG_MK7 is not set
> # CONFIG_MK8 is not set
> # CONFIG_MCRUSOE is not set
> # CONFIG_MWINCHIPC6 is not set
> # CONFIG_MWINCHIP2 is not set
> # CONFIG_MWINCHIP3D is not set
> # CONFIG_MCYRIXIII is not set
> # CONFIG_MVIAC3_2 is not set
> # CONFIG_X86_GENERIC is not set
> CONFIG_X86_CMPXCHG=y
> CONFIG_X86_XADD=y
> CONFIG_X86_L1_CACHE_SHIFT=7
> CONFIG_RWSEM_XCHGADD_ALGORITHM=y
> CONFIG_X86_WP_WORKS_OK=y
> CONFIG_X86_INVLPG=y
> CONFIG_X86_BSWAP=y
> CONFIG_X86_POPAD_OK=y
> CONFIG_X86_GOOD_APIC=y
> CONFIG_X86_INTEL_USERCOPY=y
> CONFIG_X86_USE_PPRO_CHECKSUM=y
> # CONFIG_HPET_TIMER is not set
> # CONFIG_HPET_EMULATE_RTC is not set
> # CONFIG_SMP is not set
> CONFIG_PREEMPT=y
> # CONFIG_X86_UP_APIC is not set
> CONFIG_X86_TSC=y
> # CONFIG_X86_MCE is not set
> # CONFIG_TOSHIBA is not set
> # CONFIG_I8K is not set
> # CONFIG_MICROCODE is not set
> # CONFIG_X86_MSR is not set
> # CONFIG_X86_CPUID is not set
> 
> #
> # Firmware Drivers
> #
> # CONFIG_EDD is not set
> CONFIG_NOHIGHMEM=y
> # CONFIG_HIGHMEM4G is not set
> # CONFIG_HIGHMEM64G is not set
> # CONFIG_MATH_EMULATION is not set
> CONFIG_MTRR=y
> # CONFIG_EFI is not set
> CONFIG_HAVE_DEC_LOCK=y
> CONFIG_REGPARM=y
> 
> #
> # Power management options (ACPI, APM)
> #
> # CONFIG_PM is not set
> 
> #
> # ACPI (Advanced Configuration and Power Interface)
> Support
> #
> CONFIG_ACPI=y
> CONFIG_ACPI_BOOT=y
> CONFIG_ACPI_INTERPRETER=y
> CONFIG_ACPI_AC=m
> CONFIG_ACPI_BATTERY=m
> CONFIG_ACPI_BUTTON=m
> CONFIG_ACPI_FAN=m
> CONFIG_ACPI_PROCESSOR=m
> CONFIG_ACPI_THERMAL=m
> CONFIG_ACPI_ASUS=m
> CONFIG_ACPI_TOSHIBA=m
> # CONFIG_ACPI_DEBUG is not set
> CONFIG_ACPI_BUS=y
> CONFIG_ACPI_EC=y
> CONFIG_ACPI_POWER=y
> CONFIG_ACPI_PCI=y
> CONFIG_ACPI_SYSTEM=y
> # CONFIG_X86_PM_TIMER is not set
> 
> #
> # CPU Frequency scaling
> #
> # CONFIG_CPU_FREQ is not set
> 
> #
> # Bus options (PCI, PCMCIA, EISA, MCA, ISA)
> #
> CONFIG_PCI=y
> # CONFIG_PCI_GOBIOS is not set
> # CONFIG_PCI_GOMMCONFIG is not set
> # CONFIG_PCI_GODIRECT is not set
> CONFIG_PCI_GOANY=y
> CONFIG_PCI_BIOS=y
> CONFIG_PCI_DIRECT=y
> CONFIG_PCI_MMCONFIG=y
> # CONFIG_PCI_LEGACY_PROC is not set
> CONFIG_PCI_NAMES=y
> # CONFIG_ISA is not set
> # CONFIG_MCA is not set
> # CONFIG_SCx200 is not set
> 
> #
> # PCMCIA/CardBus support
> #
> CONFIG_PCMCIA=m
> # CONFIG_PCMCIA_DEBUG is not set
> CONFIG_YENTA=m
> CONFIG_CARDBUS=y
> CONFIG_I82092=m
> CONFIG_TCIC=m
> 
> #
> # PCI Hotplug Support
> #
> # CONFIG_HOTPLUG_PCI is not set
> 
> #
> # Executable file formats
> #
> CONFIG_BINFMT_ELF=y
> CONFIG_BINFMT_AOUT=m
> CONFIG_BINFMT_MISC=m
> 
> #
> # Device Drivers
> #
> 
> #
> # Generic Driver Options
> #
> # CONFIG_FW_LOADER is not set
> # CONFIG_DEBUG_DRIVER is not set
> 
> 
=== message truncated ===> 0000:00:00.0 Host bridge:
Silicon Integrated Systems
> [SiS] SiS 645xx (rev 03)
> 	Subsystem: Asustek Computer, Inc.: Unknown device
> 1738
> 	Flags: bus master, medium devsel, latency 32
> 	Memory at e8000000 (32-bit, non-prefetchable)
> 	Capabilities: [c0] AGP version 2.0
> 
> 0000:00:01.0 PCI bridge: Silicon Integrated Systems
> [SiS] Virtual PCI-to-PCI bridge (AGP) (prog-if 00
> [Normal decode])
> 	Flags: bus master, fast devsel, latency 0
> 	Bus: primary=00, secondary=01, subordinate=01,
> sec-latency=0
> 	I/O behind bridge: 0000d000-0000dfff
> 	Memory behind bridge: e7800000-e7ffffff
> 	Prefetchable memory behind bridge:
> eff00000-febfffff
> 	Expansion ROM at 0000d000 [disabled] [size=4K]
> 
> 0000:00:02.0 ISA bridge: Silicon Integrated Systems
> [SiS] SiS963 [MuTIOL Media IO] (rev 14)
> 	Flags: bus master, medium devsel, latency 0
> 
> 0000:00:02.1 SMBus: Silicon Integrated Systems
> [SiS]: Unknown device 0016
> 	Flags: medium devsel, IRQ 11
> 	I/O ports at e800 [size=32]
> 
> 0000:00:02.3 FireWire (IEEE 1394): Silicon
> Integrated Systems [SiS] FireWire Controller
> (prog-if 10 [OHCI])
> 	Subsystem: Asustek Computer, Inc.: Unknown device
> 1737
> 	Flags: bus master, medium devsel, latency 32, IRQ
> 11
> 	Memory at e7000000 (32-bit, non-prefetchable)
> 	Capabilities: [64] Power Management version 2
> 
> 0000:00:02.5 IDE interface: Silicon Integrated
> Systems [SiS] 5513 [IDE] (prog-if 80 [Master])
> 	Subsystem: Asustek Computer, Inc.: Unknown device
> 1738
> 	Flags: bus master, medium devsel, latency 32
> 	I/O ports at b800 [size=16]
> 	Capabilities: [58] Power Management version 2
> 
> 0000:00:02.6 Modem: Silicon Integrated Systems [SiS]
> AC'97 Modem Controller (rev a0) (prog-if 00
> [Generic])
> 	Subsystem: Asustek Computer, Inc.: Unknown device
> 1736
> 	Flags: medium devsel, IRQ 11
> 	I/O ports at b400
> 	I/O ports at b000 [size=128]
> 	Capabilities: [48] Power Management version 2
> 
> 0000:00:02.7 Multimedia audio controller: Silicon
> Integrated Systems [SiS] Sound Controller (rev a0)
> 	Subsystem: Asustek Computer, Inc.: Unknown device
> 1733
> 	Flags: bus master, medium devsel, latency 32, IRQ
> 11
> 	I/O ports at a800
> 	I/O ports at a400 [size=128]
> 	Capabilities: [48] Power Management version 2
> 
> 0000:00:03.0 USB Controller: Silicon Integrated
> Systems [SiS] USB 1.0 Controller (rev 0f) (prog-if
> 10 [OHCI])
> 	Subsystem: Asustek Computer, Inc.: Unknown device
> 1739
> 	Flags: bus master, medium devsel, latency 32, IRQ 5
> 	Memory at e6800000 (32-bit, non-prefetchable)
> 	Capabilities: [dc] Power Management version 2
> 
> 0000:00:03.1 USB Controller: Silicon Integrated
> Systems [SiS] USB 1.0 Controller (rev 0f) (prog-if
> 10 [OHCI])
> 	Subsystem: Asustek Computer, Inc.: Unknown device
> 1739
> 	Flags: bus master, medium devsel, latency 32, IRQ 5
> 	Memory at e6000000 (32-bit, non-prefetchable)
> 	Capabilities: [dc] Power Management version 2
> 
> 0000:00:03.2 USB Controller: Silicon Integrated
> Systems [SiS] USB 1.0 Controller (rev 0f) (prog-if
> 10 [OHCI])
> 	Subsystem: Asustek Computer, Inc.: Unknown device
> 1739
> 	Flags: bus master, medium devsel, latency 32, IRQ 5
> 	Memory at e5800000 (32-bit, non-prefetchable)
> 	Capabilities: [dc] Power Management version 2
> 
> 0000:00:03.3 USB Controller: Silicon Integrated
> Systems [SiS] USB 2.0 Controller (prog-if 20 [EHCI])
> 	Subsystem: Asustek Computer, Inc.: Unknown device
> 173a
> 	Flags: bus master, medium devsel, latency 32, IRQ 5
> 	Memory at e5000000 (32-bit, non-prefetchable)
> 	Capabilities: [50] Power Management version 2
> 
> 0000:00:0a.0 CardBus bridge: ENE Technology Inc
> CB720 Cardbus Controller (rev 01)
> 	Subsystem: Asustek Computer, Inc.: Unknown device
> 1734
> 	Flags: bus master, medium devsel, latency 168, IRQ
> 11
> 	Memory at 20000000 (32-bit, non-prefetchable)
> 	Bus: primary=00, secondary=02, subordinate=05,
> sec-latency=176
> 	Memory window 0: 20400000-207ff000 (prefetchable)
> 	Memory window 1: 20800000-20bff000
> 	I/O window 0: 00004000-000040ff
> 	I/O window 1: 00004400-000044ff
> 	16-bit legacy interface ports at 0001
> 
> 0000:00:0a.1 CardBus bridge: ENE Technology Inc
> CB720 Cardbus Controller (rev 01)
> 	Subsystem: Asustek Computer, Inc.: Unknown device
> 1734
> 	Flags: bus master, medium devsel, latency 168, IRQ
> 11
> 	Memory at 20001000 (32-bit, non-prefetchable)
> 	Bus: primary=00, secondary=06, subordinate=09,
> sec-latency=176
> 	Memory window 0: 20c00000-20fff000 (prefetchable)
> 	Memory window 1: 21000000-213ff000
> 	I/O window 0: 00004800-000048ff
> 	I/O window 1: 00004c00-00004cff
> 	16-bit legacy interface ports at 0001
> 
> 0000:00:0a.2 FLASH memory: ENE Technology Inc CB710
> Memory Card Reader Controller
> 	Subsystem: Asustek Computer, Inc.: Unknown device
> 173b
> 	Flags: medium devsel, IRQ 11
> 	I/O ports at 9800
> 	Capabilities: [a0] Power Management version 2
> 
> 0000:00:0d.0 Ethernet controller: 3Com Corporation
> 3c940 10/100/1000Base-T [Marvell] (rev 12)
> 	Subsystem: Asustek Computer, Inc.: Unknown device
> 173c
> 	Flags: bus master, 66MHz, medium devsel, latency
> 32, IRQ 11
> 	Memory at e4000000 (32-bit, non-prefetchable)
> 	I/O ports at 9400 [size=256]
> 	Capabilities: [48] Power Management version 2
> 	Capabilities: [50] Vital Product Data
> 
> 0000:01:00.0 VGA compatible controller: ATI
> Technologies Inc Radeon R250 Lf [Radeon Mobility
> 9000 M9] (rev 01) (prog-if 00 [VGA])
> 	Subsystem: Asustek Computer, Inc.: Unknown device
> 1732
> 	Flags: bus master, stepping, 66MHz, medium devsel,
> latency 64, IRQ 11
> 	Memory at f0000000 (32-bit, prefetchable)
> [size=effe0000]
> 	I/O ports at d800 [size=256]
> 	Memory at e7800000 (32-bit, non-prefetchable)
> [size=64K]
> 	Expansion ROM at 00020000 [disabled]
> 	Capabilities: [58] AGP version 2.0
> 	Capabilities: [50] Power Management version 2
> 
> 


__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
