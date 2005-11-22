Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965122AbVKVTI0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965122AbVKVTI0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Nov 2005 14:08:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965123AbVKVTIZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Nov 2005 14:08:25 -0500
Received: from tayrelbas01.tay.hp.com ([161.114.80.244]:56494 "EHLO
	tayrelbas01.tay.hp.com") by vger.kernel.org with ESMTP
	id S965122AbVKVTIY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Nov 2005 14:08:24 -0500
Date: Tue, 22 Nov 2005 11:08:21 -0800
To: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: BUG 2.6.14.2 : ACPI boot lockup
Message-ID: <20051122190821.GA29294@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
User-Agent: Mutt/1.5.9i
From: Jean Tourrilhes <jt@hpl.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Hi,

	The pristine 2.6.14.2 kernel lockup at boot on my
laptop. Kernel 2.6.11 did boot properly, as far as I could see. Did
not try versions in between.
	Short log, short config, lspci and full log down there. More
info on request.
	If any of you guys would have a clue, I would be grateful...

	Jean

---------------------------------------
PCI: Cannot allocate resource region 7 of bridge 0000:00:1c.1
PCI: Cannot allocate resource region 8 of bridge 0000:00:1c.1
PCI: Cannot allocate resource region 9 of bridge 0000:00:1c.1
BUG: soft lockup detected on CPU#0!

Pid: 1, comm:              swapper
EIP: 0060:[<c01b892a>] CPU: 0
EIP is at strstr+0x2a/0x50
 EFLAGS: 00000287    Not tainted  (2.6.14.2)
EAX: c02bc758 EBX: f7ccc800 ECX: 00000006 EDX: 00000007
ESI: c02bc759 EDI: f7ccc83d EBP: f7ccc820 DS: 007b ES: 007b
CR0: 8005003b CR2: fffa7000 CR3: 00352000 CR4: 000006d0
 [<c01e0be9>] acpi_match_ids+0x27/0x85
 [<c01e1017>] acpi_driver_attach+0x31/0x65
 [<c033da5b>] acpi_motherboard_init+0xa/0x2f
 [<c032a8bc>] do_initcalls+0x2c/0xc0
 [<c0100290>] init+0x0/0x160
 [<c0100290>] init+0x0/0x160
 [<c01002ba>] init+0x2a/0x160
 [<c0101374>] kernel_thread_helper+0x0/0xc
 [<c0101379>] kernel_thread_helper+0x5/0xc
---------------------------------------
CONFIG_X86=y
CONFIG_SEMAPHORE_SLEEPERS=y
CONFIG_MMU=y
CONFIG_UID16=y
CONFIG_GENERIC_ISA_DMA=y
CONFIG_GENERIC_IOMAP=y
CONFIG_ARCH_MAY_HAVE_PC_FDC=y
CONFIG_EXPERIMENTAL=y
# CONFIG_CLEAN_COMPILE is not set
CONFIG_BROKEN=y
CONFIG_BROKEN_ON_SMP=y
CONFIG_INIT_ENV_ARG_LIMIT=32
CONFIG_LOCALVERSION=""
CONFIG_LOCALVERSION_AUTO=y
CONFIG_SWAP=y
CONFIG_SYSVIPC=y
CONFIG_POSIX_MQUEUE=y
CONFIG_BSD_PROCESS_ACCT=y
CONFIG_BSD_PROCESS_ACCT_V3=y
CONFIG_SYSCTL=y
# CONFIG_AUDIT is not set
CONFIG_HOTPLUG=y
CONFIG_KOBJECT_UEVENT=y
# CONFIG_IKCONFIG is not set
CONFIG_INITRAMFS_SOURCE=""
# CONFIG_EMBEDDED is not set
CONFIG_KALLSYMS=y
# CONFIG_KALLSYMS_ALL is not set
# CONFIG_KALLSYMS_EXTRA_PASS is not set
CONFIG_PRINTK=y
CONFIG_BUG=y
CONFIG_BASE_FULL=y
CONFIG_FUTEX=y
CONFIG_EPOLL=y
CONFIG_SHMEM=y
CONFIG_CC_ALIGN_FUNCTIONS=0
CONFIG_CC_ALIGN_LABELS=0
CONFIG_CC_ALIGN_LOOPS=0
CONFIG_CC_ALIGN_JUMPS=0
# CONFIG_TINY_SHMEM is not set
CONFIG_BASE_SMALL=0
CONFIG_X86_PC=y
CONFIG_MPENTIUMM=y
CONFIG_X86_CMPXCHG=y
CONFIG_X86_XADD=y
CONFIG_X86_L1_CACHE_SHIFT=6
CONFIG_RWSEM_XCHGADD_ALGORITHM=y
CONFIG_GENERIC_CALIBRATE_DELAY=y
CONFIG_X86_WP_WORKS_OK=y
CONFIG_X86_INVLPG=y
CONFIG_X86_BSWAP=y
CONFIG_X86_POPAD_OK=y
CONFIG_X86_GOOD_APIC=y
CONFIG_X86_INTEL_USERCOPY=y
CONFIG_X86_USE_PPRO_CHECKSUM=y
CONFIG_HPET_TIMER=y
# CONFIG_SMP is not set
CONFIG_PREEMPT_NONE=y
# CONFIG_PREEMPT_VOLUNTARY is not set
# CONFIG_PREEMPT is not set
CONFIG_X86_UP_APIC=y
CONFIG_X86_UP_IOAPIC=y
CONFIG_X86_LOCAL_APIC=y
CONFIG_X86_IO_APIC=y
CONFIG_X86_TSC=y
CONFIG_X86_MCE=y
CONFIG_X86_MCE_NONFATAL=y
# CONFIG_X86_MCE_P4THERMAL is not set
# CONFIG_TOSHIBA is not set
# CONFIG_I8K is not set
# CONFIG_X86_REBOOTFIXUPS is not set
# CONFIG_MICROCODE is not set
CONFIG_X86_MSR=m
CONFIG_X86_CPUID=m
CONFIG_ACPI=y
CONFIG_ACPI_SLEEP=y
CONFIG_ACPI_SLEEP_PROC_FS=y
CONFIG_ACPI_SLEEP_PROC_SLEEP=y
CONFIG_ACPI_AC=m
CONFIG_ACPI_BATTERY=m
CONFIG_ACPI_BUTTON=m
CONFIG_ACPI_VIDEO=m
# CONFIG_ACPI_HOTKEY is not set
CONFIG_ACPI_FAN=m
CONFIG_ACPI_PROCESSOR=m
CONFIG_ACPI_THERMAL=m
CONFIG_ACPI_ASUS=m
CONFIG_ACPI_IBM=m
# CONFIG_ACPI_TOSHIBA is not set
# CONFIG_ACPI_CUSTOM_DSDT is not set
CONFIG_ACPI_BLACKLIST_YEAR=0
# CONFIG_ACPI_DEBUG is not set
CONFIG_ACPI_EC=y
CONFIG_ACPI_POWER=y
CONFIG_ACPI_SYSTEM=y
CONFIG_X86_PM_TIMER=y
# CONFIG_ACPI_CONTAINER is not set
---------------------------------------
0000:00:00.0 Host bridge: Intel Corp. Mobile Memory Controller Hub (rev 03)
0000:00:01.0 PCI bridge: Intel Corp. Mobile Memory Controller Hub PCI Express Port (rev 03)
0000:00:1c.0 PCI bridge: Intel Corp. 82801FB/FBM/FR/FW/FRW (ICH6 Family) PCI Express Port 1 (rev 03)
0000:00:1c.1 PCI bridge: Intel Corp. 82801FB/FBM/FR/FW/FRW (ICH6 Family) PCI Express Port 2 (rev 03)
0000:00:1d.0 USB Controller: Intel Corp. 82801FB/FBM/FR/FW/FRW (ICH6 Family) USB UHCI #1 (rev 03)
0000:00:1d.1 USB Controller: Intel Corp. 82801FB/FBM/FR/FW/FRW (ICH6 Family) USB UHCI #2 (rev 03)
0000:00:1d.2 USB Controller: Intel Corp. 82801FB/FBM/FR/FW/FRW (ICH6 Family) USB UHCI #3 (rev 03)
0000:00:1d.7 USB Controller: Intel Corp. 82801FB/FBM/FR/FW/FRW (ICH6 Family) USB2 EHCI Controller (rev 03)
0000:00:1e.0 PCI bridge: Intel Corp. 82801 PCI Bridge (rev d3)
0000:00:1e.2 Multimedia audio controller: Intel Corp. 82801FB/FBM/FR/FW/FRW (ICH6 Family) AC'97 Audio Controller (rev 03)
0000:00:1e.3 Modem: Intel Corp. 82801FB/FBM/FR/FW/FRW (ICH6 Family) AC'97 Modem Controller (rev 03)
0000:00:1f.0 ISA bridge: Intel Corp. 82801FBM (ICH6M) LPC Interface Bridge (rev 03)
0000:00:1f.1 IDE interface: Intel Corp. 82801FB/FBM/FR/FW/FRW (ICH6 Family) IDE Controller (rev 03)
0000:01:00.0 VGA compatible controller: ATI Technologies Inc: Unknown device 5653
0000:02:04.0 Network controller: Intel Corp. PRO/Wireless 2200BG (rev 05)
0000:02:06.0 CardBus bridge: Texas Instruments: Unknown device 8031
0000:02:06.2 FireWire (IEEE 1394): Texas Instruments: Unknown device 8032
0000:02:06.3 Unknown mass storage controller: Texas Instruments: Unknown device 8033
0000:02:06.4 0805: Texas Instruments: Unknown device 8034
0000:02:06.5 Communication controller: Texas Instruments: Unknown device 8035
0000:10:00.0 Ethernet controller: Broadcom Corporation: Unknown device 167d (rev 11)
---------------------------------------
Linux version 2.6.14.2 (root@treize) (gcc version 3.3.5 (Debian 1:3.3.5-13)) #1 Mon Nov 21 17:04:59 PST 2005
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000e0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000003ffd0000 (usable)
 BIOS-e820: 000000003ffd0000 - 000000003ffefc00 (reserved)
 BIOS-e820: 000000003ffefc00 - 000000003fffb000 (ACPI NVS)
 BIOS-e820: 000000003fffb000 - 0000000040000000 (reserved)
 BIOS-e820: 00000000e0000000 - 00000000f0000000 (reserved)
 BIOS-e820: 00000000fec00000 - 00000000fec02000 (reserved)
 BIOS-e820: 00000000fed20000 - 00000000fed9b000 (reserved)
 BIOS-e820: 00000000feda0000 - 00000000fedc0000 (reserved)
 BIOS-e820: 00000000ffb00000 - 00000000ffc00000 (reserved)
 BIOS-e820: 00000000fff00000 - 0000000100000000 (reserved)
Warning only 896MB will be used.
Use a HIGHMEM enabled kernel.
896MB LOWMEM available.
DMI 2.3 present.
ACPI: PM-Timer IO Port: 0x1008
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
Processor #0 6:13 APIC version 20
ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x1])
ACPI: IOAPIC (id[0x01] address[0xfec00000] gsi_base[0])
IOAPIC[0]: apic_id 1, version 32, address 0xfec00000, GSI 0-23
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
Enabling APIC mode:  Flat.  Using 1 I/O APICs
Using ACPI (MADT) for SMP configuration information
Allocating PCI resources starting at 50000000 (gap: 40000000:a0000000)
Built 1 zonelists
Kernel command line: root=/dev/hda2 ro console=ttyS0,115200n8
Initializing CPU#0
PID hash table entries: 4096 (order: 12, 65536 bytes)
Detected 1862.402 MHz processor.
Using pmtmr for high-res timesource
Console: colour VGA+ 80x25
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Memory: 906476k/917504k available (1666k kernel code, 10576k reserved, 536k data, 160k init, 0k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay using timer specific routine.. 3729.51 BogoMIPS (lpj=7459027)
Mount-cache hash table entries: 512
CPU: L1 I cache: 32K, L1 D cache: 32K
CPU: L2 cache: 2048K
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
mtrr: v2.0 (20020519)
CPU: Intel(R) Pentium(R) M processor 1.86GHz stepping 08
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
ENABLING IO-APIC IRQs
..TIMER: vector=0x31 pin1=2 pin2=-1
softlockup thread 0 started up.
NET: Registered protocol family 16
ACPI: bus type pci registered
PCI: PCI BIOS revision 2.10 entry at 0xf0322, last bus=32
PCI: Using MMCONFIG
ACPI: Subsystem revision 20050902
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Root Bridge [C003] (0000:00)
PCI: Probing PCI hardware (bus 00)
ACPI: Assume root bridge [\_SB_.C003] bus is 0
PCI: Ignoring BAR0-3 of IDE controller 0000:00:1f.1
PCI: Transparent bridge - 0000:00:1e.0
ACPI: Power Resource [C1C8] (on)
ACPI: Embedded Controller [C005] (gpe 16)
ACPI: Power Resource [C1A2] (on)
ACPI: Power Resource [C1AA] (on)
ACPI: Power Resource [C1B1] (on)
ACPI: Power Resource [C1C1] (on)
ACPI: PCI Interrupt Link [C0D9] (IRQs *10 11)
ACPI: PCI Interrupt Link [C0DA] (IRQs 10 *11)
ACPI: PCI Interrupt Link [C0DB] (IRQs 10 *11)
ACPI: PCI Interrupt Link [C0DC] (IRQs *10 11)
ACPI: PCI Interrupt Link [C0EF] (IRQs *10 11)
ACPI: PCI Interrupt Link [C0F0] (IRQs 10 *11)
ACPI: PCI Interrupt Link [C0F1] (IRQs *10 11)
ACPI: Power Resource [C25A] (off)
ACPI: Power Resource [C25B] (off)
ACPI: Power Resource [C25C] (off)
ACPI: Power Resource [C25D] (off)
Linux Plug and Play Support v0.97 (c) Adam Belay
pnp: PnP ACPI init
pnp: PnP ACPI: found 16 devices
PnPBIOS: Disabled by ACPI PNP
PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
PCI: Cannot allocate resource region 7 of bridge 0000:00:1c.1
PCI: Cannot allocate resource region 8 of bridge 0000:00:1c.1
PCI: Cannot allocate resource region 9 of bridge 0000:00:1c.1
BUG: soft lockup detected on CPU#0!

Pid: 1, comm:              swapper
EIP: 0060:[<c01b892a>] CPU: 0
EIP is at strstr+0x2a/0x50
 EFLAGS: 00000287    Not tainted  (2.6.14.2)
EAX: c02bc758 EBX: f7ccc800 ECX: 00000006 EDX: 00000007
ESI: c02bc759 EDI: f7ccc83d EBP: f7ccc820 DS: 007b ES: 007b
CR0: 8005003b CR2: fffa7000 CR3: 00352000 CR4: 000006d0
 [<c01e0be9>] acpi_match_ids+0x27/0x85
 [<c01e1017>] acpi_driver_attach+0x31/0x65
 [<c033da5b>] acpi_motherboard_init+0xa/0x2f
 [<c032a8bc>] do_initcalls+0x2c/0xc0
 [<c0100290>] init+0x0/0x160
 [<c0100290>] init+0x0/0x160
 [<c01002ba>] init+0x2a/0x160
 [<c0101374>] kernel_thread_helper+0x0/0xc
 [<c0101379>] kernel_thread_helper+0x5/0xc

