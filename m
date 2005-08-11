Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751086AbVHKP0M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751086AbVHKP0M (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Aug 2005 11:26:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751088AbVHKP0M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Aug 2005 11:26:12 -0400
Received: from cernmx05.cern.ch ([137.138.166.161]:51268 "EHLO
	cernmxlb.cern.ch") by vger.kernel.org with ESMTP id S1751086AbVHKP0K
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Aug 2005 11:26:10 -0400
DomainKey-Signature: a=rsa-sha1; c=nofws; s=beta; d=cern.ch; q=dns; 
	h=received:message-id:date:from:to:subject:mime-version:content-type;
	b=nZg6aKZx5ewilefxmCToWjCMo2oaIOMVb2JX61TV+/58o4lt6AtiLwiR/uqcp6pZBf8+I2cP/D8VH/lRlvziFvN7JkDXd0HV2llipb2HJRmGzn6ZjQmFB2Ou5pHz+h/L;
From: Jean-Damien Durand <Jean-Damien.Durand@cern.ch>
Organization: CERN
To: linux-kernel@vger.kernel.org
Subject: problem with 2.6.13-rc*: network card not seen at insert, seen at 2nd insert but then network instability
Date: Thu, 11 Aug 2005 17:25:24 +0200
User-Agent: KMail/1.8.1
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_l32+Cf1tMTifFlt"
Message-Id: <200508111725.25538.Jean-Damien.Durand@cern.ch>
X-OriginalArrivalTime: 11 Aug 2005 15:25:45.0243 (UTC) FILETIME=[F16276B0:01C59E88]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_l32+Cf1tMTifFlt
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

[Trying to follow reporting-bugs.html recommendations!]

2/Full description:

With 2.6.13-rc6-git2, but I just checked identical behaviour with 2.6.13-rc1, inserting
the pcmcia network card has no effect to my laptop. Reinserting makes its visible, but then,
after connection to AP is done, it stays ok for few seconds, and the search for AP starts again,
etc, i.e. network is not usable.
2.6.12.4 behaves totally ok!

I reported that at http://bugzilla.kernel.org/show_bug.cgi?id=5017 (where there is more info, and some
output of a previous kernel compiled with debug info) and hope to get wider audience here, just in case
other users might hit a similar problem. My kernel knowledge if not far from zero unfortunately; hope
this report is enough for you experts and that I have not done any error building the stuff...!

3/ Keywords: network, pcmcia, irq (?)

4/ Kernel version: 
% cat /proc/version
Linux version 2.6.13-rc6-git2 (root@jddportable) (gcc version 3.3.6 (Debian 1:3.3.6-7)) #1 SMP Thu Aug 11 13:46:10 CEST 2005

5/ [no oops]
6/ [no script]
7/ Environment:
7.1/ Software: c.f. attachment
Note: ath_* modules come from madwifi. They unfortunately taint the kernel, and got loaded only after the second insert of my network card.
7.2/ Processor information: c.f. attachment
7.3/ Module information: c.f. attachment
7.4/ Loaded driver and hardware information: c.f. attachments
7.5/ PCI information: c.f. attachment
7.6/ SCSI information: c.f. attachment
7.7/ syslog messages:

Aug 11 16:23:56 jddportable syslogd 1.4.1#17: restart.
Aug 11 16:23:56 jddportable kernel: klogd 1.4.1#17, log source = /proc/kmsg started.
Aug 11 16:23:56 jddportable kernel: Inspecting /boot/System.map-2.6.13-rc6-git2
Aug 11 16:23:56 jddportable kernel: Loaded 37508 symbols from /boot/System.map-2.6.13-rc6-git2.
Aug 11 16:23:56 jddportable kernel: Symbols match kernel version 2.6.13.
Aug 11 16:23:56 jddportable kernel: No module symbols loaded - kernel modules not enabled. 
Aug 11 16:23:56 jddportable kernel: Linux version 2.6.13-rc6-git2 (root@jddportable) (gcc version 3.3.6 (Debian 1:3.3.6-7)) #1 SMP Thu Aug 11 13:46:10 CEST 2005
Aug 11 16:23:56 jddportable kernel: BIOS-provided physical RAM map:
Aug 11 16:23:56 jddportable kernel:  BIOS-e820: 0000000000000000 - 000000000009f800 (usable)
Aug 11 16:23:56 jddportable kernel:  BIOS-e820: 000000000009f800 - 00000000000a0000 (reserved)
Aug 11 16:23:56 jddportable kernel:  BIOS-e820: 00000000000d8000 - 00000000000e0000 (reserved)
Aug 11 16:23:56 jddportable kernel:  BIOS-e820: 00000000000e4000 - 0000000000100000 (reserved)
Aug 11 16:23:56 jddportable kernel:  BIOS-e820: 0000000000100000 - 000000002bf70000 (usable)
Aug 11 16:23:56 jddportable kernel:  BIOS-e820: 000000002bf70000 - 000000002bf7c000 (ACPI data)
Aug 11 16:23:56 jddportable kernel:  BIOS-e820: 000000002bf7c000 - 000000002bf80000 (ACPI NVS)
Aug 11 16:23:56 jddportable kernel:  BIOS-e820: 000000002bf80000 - 000000002c000000 (reserved)
Aug 11 16:23:56 jddportable kernel:  BIOS-e820: 000000003bf80000 - 000000003c000000 (reserved)
Aug 11 16:23:56 jddportable kernel:  BIOS-e820: 00000000fff80000 - 0000000100000000 (reserved)
Aug 11 16:23:56 jddportable kernel: 0MB HIGHMEM available.
Aug 11 16:23:56 jddportable kernel: 703MB LOWMEM available.
Aug 11 16:23:56 jddportable kernel: On node 0 totalpages: 180080
Aug 11 16:23:56 jddportable kernel:   DMA zone: 4096 pages, LIFO batch:1
Aug 11 16:23:56 jddportable kernel:   Normal zone: 175984 pages, LIFO batch:31
Aug 11 16:23:56 jddportable kernel:   HighMem zone: 0 pages, LIFO batch:1
Aug 11 16:23:56 jddportable kernel: DMI 2.3 present.
Aug 11 16:23:56 jddportable kernel: ACPI: RSDP (v000 PTLTD                                 ) @ 0x000f6ab0
Aug 11 16:23:56 jddportable kernel: ACPI: RSDT (v001 PTLTD    RSDT   0x06040000  LTP 0x00000000) @ 0x2bf75284
Aug 11 16:23:56 jddportable kernel: ACPI: FADT (v001 ATI    Salmon   0x06040000 ATI  0x000f4240) @ 0x2bf7bf64
Aug 11 16:23:56 jddportable kernel: ACPI: BOOT (v001 PTLTD  $SBFTBL$ 0x06040000  LTP 0x00000001) @ 0x2bf7bfd8
Aug 11 16:23:56 jddportable kernel: ACPI: DSDT (v001    ATI MS2_1535 0x06040000 MSFT 0x0100000e) @ 0x00000000
Aug 11 16:23:56 jddportable kernel: ACPI: PM-Timer IO Port: 0x8008
Aug 11 16:23:56 jddportable kernel: Allocating PCI resources starting at 3c000000 (gap: 3c000000:c3f80000)
Aug 11 16:23:56 jddportable kernel: Built 1 zonelists
Aug 11 16:23:56 jddportable kernel: Kernel command line: root=/dev/hda3 video=radeonfb ro
Aug 11 16:23:56 jddportable kernel: Local APIC disabled by BIOS -- you can enable it with "lapic"
Aug 11 16:23:56 jddportable kernel: mapped APIC to ffffd000 (01684000)
Aug 11 16:23:56 jddportable kernel: Initializing CPU#0
Aug 11 16:23:56 jddportable kernel: PID hash table entries: 4096 (order: 12, 65536 bytes)
Aug 11 16:23:56 jddportable kernel: Detected 2658.961 MHz processor.
Aug 11 16:23:56 jddportable kernel: Using pmtmr for high-res timesource
Aug 11 16:23:56 jddportable kernel: Console: colour VGA+ 80x25
Aug 11 16:23:56 jddportable kernel: Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Aug 11 16:23:56 jddportable kernel: Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Aug 11 16:23:56 jddportable kernel: Memory: 702968k/720320k available (3475k kernel code, 16728k reserved, 1506k data, 328k init, 0k highmem)
Aug 11 16:23:56 jddportable kernel: Checking if this processor honours the WP bit even in supervisor mode... Ok.
Aug 11 16:23:56 jddportable kernel: Calibrating delay using timer specific routine.. 5325.34 BogoMIPS (lpj=10650685)
Aug 11 16:23:56 jddportable kernel: Security Framework v1.0.0 initialized
Aug 11 16:23:56 jddportable kernel: SELinux:  Initializing.
Aug 11 16:23:56 jddportable kernel: SELinux:  Starting in permissive mode
Aug 11 16:23:56 jddportable kernel: Mount-cache hash table entries: 512
Aug 11 16:23:56 jddportable kernel: CPU: After generic identify, caps: bfebf9ff 00000000 00000000 00000000 00004400 00000000 00000000
Aug 11 16:23:56 jddportable kernel: CPU: After vendor identify, caps: bfebf9ff 00000000 00000000 00000000 00004400 00000000 00000000
Aug 11 16:23:56 jddportable kernel: CPU: Trace cache: 12K uops, L1 D cache: 8K
Aug 11 16:23:56 jddportable kernel: CPU: L2 cache: 512K
Aug 11 16:23:56 jddportable kernel: CPU: Hyper-Threading is disabled
Aug 11 16:23:56 jddportable kernel: CPU: After all inits, caps: bfebf9ff 00000000 00000000 00000080 00004400 00000000 00000000
Aug 11 16:23:56 jddportable kernel: Intel machine check architecture supported.
Aug 11 16:23:56 jddportable kernel: Intel machine check reporting enabled on CPU#0.
Aug 11 16:23:56 jddportable kernel: CPU0: Intel P4/Xeon Extended MCE MSRs (12) available
Aug 11 16:23:56 jddportable kernel: CPU0: Thermal monitoring enabled
Aug 11 16:23:56 jddportable kernel: mtrr: v2.0 (20020519)
Aug 11 16:23:56 jddportable kernel: Enabling fast FPU save and restore... done.
Aug 11 16:23:56 jddportable kernel: Enabling unmasked SIMD FPU exception support... done.
Aug 11 16:23:56 jddportable kernel: Checking 'hlt' instruction... OK.
Aug 11 16:23:56 jddportable kernel: ACPI: setting ELCR to 0200 (from 0420)
Aug 11 16:23:56 jddportable kernel: CPU0: Intel Mobile Intel(R) Pentium(R) 4     CPU 2.66GHz stepping 09
Aug 11 16:23:56 jddportable kernel: SMP motherboard not detected.
Aug 11 16:23:56 jddportable kernel: Local APIC not detected. Using dummy APIC emulation.
Aug 11 16:23:56 jddportable kernel: Brought up 1 CPUs
Aug 11 16:23:56 jddportable kernel: checking if image is initramfs...it isn't (no cpio magic); looks like an initrd
Aug 11 16:23:56 jddportable kernel: Freeing initrd memory: 3592k freed
Aug 11 16:23:56 jddportable kernel: NET: Registered protocol family 16
Aug 11 16:23:56 jddportable kernel: EISA bus registered
Aug 11 16:23:56 jddportable kernel: ACPI: bus type pci registered
Aug 11 16:23:56 jddportable kernel: PCI: PCI BIOS revision 2.10 entry at 0xfd89b, last bus=2
Aug 11 16:23:56 jddportable kernel: PCI: Using configuration type 1
Aug 11 16:23:56 jddportable kernel: ACPI: Subsystem revision 20050408
Aug 11 16:23:56 jddportable kernel: ACPI: Interpreter enabled
Aug 11 16:23:56 jddportable kernel: ACPI: Using PIC for interrupt routing
Aug 11 16:23:56 jddportable kernel: ACPI: PCI Root Bridge [PCI0] (0000:00)
Aug 11 16:23:56 jddportable kernel: PCI: Probing PCI hardware (bus 00)
Aug 11 16:23:56 jddportable kernel: ACPI: Assume root bridge [\_SB_.PCI0] segment is 0
Aug 11 16:23:56 jddportable kernel: Boot video device is 0000:01:05.0
Aug 11 16:23:56 jddportable kernel: ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
Aug 11 16:23:56 jddportable kernel: ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.AGPB._PRT]
Aug 11 16:23:56 jddportable kernel: ACPI: PCI Interrupt Link [LNK0] (IRQs 7 10) *0, disabled.
Aug 11 16:23:56 jddportable kernel: ACPI: PCI Interrupt Link [LNK1] (IRQs 7 *10)
Aug 11 16:23:56 jddportable kernel: ACPI: PCI Interrupt Link [LNK2] (IRQs 7 *10)
Aug 11 16:23:56 jddportable kernel: ACPI: PCI Interrupt Link [LNK3] (IRQs 7 *10)
Aug 11 16:23:56 jddportable kernel: ACPI: PCI Interrupt Link [LNK4] (IRQs 7 10) *0, disabled.
Aug 11 16:23:56 jddportable kernel: ACPI: PCI Interrupt Link [LNK5] (IRQs 7 *11)
Aug 11 16:23:56 jddportable kernel: ACPI: PCI Interrupt Link [LNK6] (IRQs 7 10) *0, disabled.
Aug 11 16:23:56 jddportable kernel: ACPI: PCI Interrupt Link [LNK7] (IRQs *5)
Aug 11 16:23:56 jddportable kernel: ACPI: PCI Interrupt Link [LNK8] (IRQs 7 10) *0, disabled.
Aug 11 16:23:56 jddportable kernel: ACPI: Embedded Controller [EC0] (gpe 24)
Aug 11 16:23:56 jddportable kernel: Linux Plug and Play Support v0.97 (c) Adam Belay
Aug 11 16:23:56 jddportable kernel: pnp: PnP ACPI init
Aug 11 16:23:56 jddportable kernel: pnp: PnP ACPI: found 13 devices
Aug 11 16:23:56 jddportable kernel: PnPBIOS: Disabled by ACPI PNP
Aug 11 16:23:56 jddportable kernel: SCSI subsystem initialized
Aug 11 16:23:56 jddportable kernel: PCI: Using ACPI for IRQ routing
Aug 11 16:23:56 jddportable kernel: PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
Aug 11 16:23:56 jddportable kernel: PCI: Bridge: 0000:00:01.0
Aug 11 16:23:56 jddportable kernel:   IO window: 9000-9fff
Aug 11 16:23:56 jddportable kernel:   MEM window: d0300000-d03fffff
Aug 11 16:23:56 jddportable kernel:   PREFETCH window: d8000000-dfffffff
Aug 11 16:23:56 jddportable kernel: PCI: Bus 2, cardbus bridge: 0000:00:0a.0
Aug 11 16:23:56 jddportable kernel:   IO window: 00004000-00004fff
Aug 11 16:23:56 jddportable kernel:   IO window: 00005000-00005fff
Aug 11 16:23:56 jddportable kernel:   PREFETCH window: 3c000000-3dffffff
Aug 11 16:23:56 jddportable kernel:   MEM window: 3e000000-3fffffff
Aug 11 16:23:56 jddportable kernel: PCI: Enabling device 0000:00:0a.0 (0005 -> 0007)
Aug 11 16:23:56 jddportable kernel: ACPI: PCI Interrupt Link [LNK5] enabled at IRQ 11
Aug 11 16:23:56 jddportable kernel: PCI: setting IRQ 11 as level-triggered
Aug 11 16:23:56 jddportable kernel: ACPI: PCI Interrupt 0000:00:0a.0[A] -> Link [LNK5] -> GSI 11 (level, low) -> IRQ 11
Aug 11 16:23:56 jddportable kernel: pnp: 00:06: ioport range 0x40b-0x40b has been reserved
Aug 11 16:23:56 jddportable kernel: pnp: 00:06: ioport range 0x480-0x48f has been reserved
Aug 11 16:23:56 jddportable kernel: pnp: 00:06: ioport range 0x4d0-0x4d1 has been reserved
Aug 11 16:23:56 jddportable kernel: pnp: 00:06: ioport range 0x4d6-0x4d6 has been reserved
Aug 11 16:23:56 jddportable kernel: pnp: 00:06: ioport range 0x8000-0x807f could not be reserved
Aug 11 16:23:56 jddportable kernel: Simple Boot Flag at 0x37 set to 0x1
Aug 11 16:23:56 jddportable kernel: audit: initializing netlink socket (disabled)
Aug 11 16:23:56 jddportable kernel: audit(1123777407.608:1): initialized
Aug 11 16:23:56 jddportable kernel: Total HugeTLB memory allocated, 0
Aug 11 16:23:56 jddportable kernel: VFS: Disk quotas dquot_6.5.1
Aug 11 16:23:56 jddportable kernel: Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
Aug 11 16:23:56 jddportable kernel: JFS: nTxBlock = 5521, nTxLock = 44175
Aug 11 16:23:56 jddportable kernel: SGI XFS with ACLs, security attributes, realtime, large block numbers, no debug enabled
Aug 11 16:23:56 jddportable kernel: SGI XFS Quota Management subsystem
Aug 11 16:23:56 jddportable kernel: SELinux:  Registering netfilter hooks
Aug 11 16:23:56 jddportable kernel: Initializing Cryptographic API
Aug 11 16:23:56 jddportable kernel: Activating ISA DMA hang workarounds.
Aug 11 16:23:56 jddportable kernel: pci_hotplug: PCI Hot Plug PCI Core version: 0.5
Aug 11 16:23:56 jddportable kernel: fakephp: Fake PCI Hot Plug Controller Driver
Aug 11 16:23:56 jddportable kernel: cpqphp: Compaq Hot Plug PCI Controller Driver version: 0.9.8
Aug 11 16:23:56 jddportable kernel: ibmphpd: IBM Hot Plug PCI Controller Driver version: 0.6
Aug 11 16:23:56 jddportable kernel: acpiphp: ACPI Hot Plug PCI Controller Driver version: 0.5
Aug 11 16:23:56 jddportable kernel: acpiphp_ibm: ibm_find_acpi_device:  Failed to get device information<3>acpiphp_ibm: ibm_acpiphp_init: acpi_walk_namespace failed
Aug 11 16:23:56 jddportable kernel: cpcihp_zt5550: ZT5550 CompactPCI Hot Plug Driver version: 0.2
Aug 11 16:23:56 jddportable kernel: cpcihp_generic: Generic port I/O CompactPCI Hot Plug Driver version: 0.1
Aug 11 16:23:56 jddportable kernel: cpcihp_generic: not configured, disabling.
Aug 11 16:23:56 jddportable kernel: shpchp: shpc_init : shpc_cap_offset == 0
Aug 11 16:23:56 jddportable kernel: shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
Aug 11 16:23:56 jddportable kernel: isapnp: Scanning for PnP cards...
Aug 11 16:23:56 jddportable kernel: isapnp: No Plug & Play device found
Aug 11 16:23:56 jddportable kernel: PNP: PS/2 Controller [PNP0303:KBC0,PNP0f13:MSE0] at 0x60,0x64 irq 1,12
Aug 11 16:23:56 jddportable kernel: serio: i8042 AUX port at 0x60,0x64 irq 12
Aug 11 16:23:56 jddportable kernel: serio: i8042 KBD port at 0x60,0x64 irq 1
Aug 11 16:23:56 jddportable kernel: io scheduler noop registered
Aug 11 16:23:56 jddportable kernel: io scheduler anticipatory registered
Aug 11 16:23:56 jddportable kernel: io scheduler deadline registered
Aug 11 16:23:56 jddportable kernel: io scheduler cfq registered
Aug 11 16:23:56 jddportable kernel: Floppy drive(s): fd0 is 1.44M
Aug 11 16:23:56 jddportable kernel: FDC 0 is a post-1991 82077
Aug 11 16:23:56 jddportable kernel: RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
Aug 11 16:23:56 jddportable kernel: Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
Aug 11 16:23:56 jddportable kernel: ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
Aug 11 16:23:56 jddportable kernel: ALI15X3: IDE controller at PCI slot 0000:00:10.0
Aug 11 16:23:56 jddportable kernel: ACPI: PCI Interrupt 0000:00:10.0[A]: no GSI
Aug 11 16:23:56 jddportable kernel: ALI15X3: chipset revision 196
Aug 11 16:23:56 jddportable kernel: ALI15X3: not 100%% native mode: will probe irqs later
Aug 11 16:23:56 jddportable kernel:     ide0: BM-DMA at 0x2040-0x2047, BIOS settings: hda:DMA, hdb:pio
Aug 11 16:23:56 jddportable kernel:     ide1: BM-DMA at 0x2048-0x204f, BIOS settings: hdc:pio, hdd:pio
Aug 11 16:23:56 jddportable kernel: Probing IDE interface ide0...
Aug 11 16:23:56 jddportable kernel: hda: ST94011A, ATA DISK drive
Aug 11 16:23:56 jddportable kernel: ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Aug 11 16:23:56 jddportable kernel: Probing IDE interface ide1...
Aug 11 16:23:56 jddportable kernel: hdc: HL-DT-ST DVD+RW GCA-4040N, ATAPI CD/DVD-ROM drive
Aug 11 16:23:56 jddportable kernel: ide1 at 0x170-0x177,0x376 on irq 15
Aug 11 16:23:56 jddportable kernel: hda: max request size: 128KiB
Aug 11 16:23:56 jddportable kernel: hda: 78140160 sectors (40007 MB) w/2048KiB Cache, CHS=16383/255/63
Aug 11 16:23:56 jddportable kernel: hda: cache flushes supported
Aug 11 16:23:56 jddportable kernel:  hda: hda1 hda3 hda4 < hda5 >
Aug 11 16:23:56 jddportable kernel: libata version 1.11 loaded.
Aug 11 16:23:56 jddportable kernel: mice: PS/2 mouse device common for all mice
Aug 11 16:23:56 jddportable kernel: EISA: Probing bus 0 at eisa.0
Aug 11 16:23:56 jddportable kernel: Cannot allocate resource for EISA slot 1
Aug 11 16:23:56 jddportable kernel: Cannot allocate resource for EISA slot 2
Aug 11 16:23:56 jddportable kernel: Cannot allocate resource for EISA slot 4
Aug 11 16:23:56 jddportable kernel: Cannot allocate resource for EISA slot 5
Aug 11 16:23:56 jddportable kernel: Cannot allocate resource for EISA slot 8
Aug 11 16:23:56 jddportable kernel: EISA: Detected 0 cards.
Aug 11 16:23:56 jddportable kernel: NET: Registered protocol family 2
Aug 11 16:23:56 jddportable kernel: input: AT Translated Set 2 keyboard on isa0060/serio0
Aug 11 16:23:56 jddportable kernel: IP route cache hash table entries: 32768 (order: 5, 131072 bytes)
Aug 11 16:23:56 jddportable kernel: TCP established hash table entries: 131072 (order: 9, 2097152 bytes)
Aug 11 16:23:56 jddportable kernel: TCP bind hash table entries: 65536 (order: 7, 786432 bytes)
Aug 11 16:23:56 jddportable kernel: TCP: Hash tables configured (established 131072 bind 65536)
Aug 11 16:23:56 jddportable kernel: TCP reno registered
Aug 11 16:23:56 jddportable kernel: TCP bic registered
Aug 11 16:23:56 jddportable kernel: NET: Registered protocol family 1
Aug 11 16:23:56 jddportable kernel: NET: Registered protocol family 15
Aug 11 16:23:56 jddportable kernel: Using IPI No-Shortcut mode
Aug 11 16:23:56 jddportable kernel: ACPI wakeup devices: 
Aug 11 16:23:56 jddportable kernel: PCI0 MDEM  LAN  LID 
Aug 11 16:23:56 jddportable kernel: ACPI: (supports S0 S3 S4 S5)
Aug 11 16:23:56 jddportable kernel: RAMDISK: Compressed image found at block 0
Aug 11 16:23:56 jddportable kernel: RAMDISK: incomplete write (-28 != 32768) 4194304
Aug 11 16:23:56 jddportable kernel: EXT3-fs: mounted filesystem with ordered data mode.
Aug 11 16:23:56 jddportable kernel: VFS: Mounted root (ext3 filesystem) readonly.
Aug 11 16:23:56 jddportable kernel: Freeing unused kernel memory: 328k freed
Aug 11 16:23:56 jddportable kernel: kjournald starting.  Commit interval 5 seconds
Aug 11 16:23:56 jddportable kernel: Synaptics Touchpad, model: 1, fw: 5.9, id: 0x236eb3, caps: 0x904713/0x10008
Aug 11 16:23:56 jddportable kernel: input: SynPS/2 Synaptics TouchPad on isa0060/serio1
Aug 11 16:23:56 jddportable kernel: ts: Compaq touchscreen protocol output
Aug 11 16:23:56 jddportable kernel: Adding 385520k swap on /dev/hda5.  Priority:-1 extents:1
Aug 11 16:23:56 jddportable kernel: EXT3 FS on hda3, internal journal
Aug 11 16:23:56 jddportable kernel: Generic RTC Driver v1.07
Aug 11 16:23:56 jddportable kernel: Linux agpgart interface v0.101 (c) Dave Jones
Aug 11 16:23:56 jddportable kernel: agpgart: Detected Ati IGP345M chipset
Aug 11 16:23:56 jddportable kernel: agpgart: AGP aperture is 64M @ 0xd4000000
Aug 11 16:23:56 jddportable kernel: ACPI: PCI Interrupt Link [LNK0] enabled at IRQ 10
Aug 11 16:23:56 jddportable kernel: PCI: setting IRQ 10 as level-triggered
Aug 11 16:23:56 jddportable kernel: ACPI: PCI Interrupt 0000:01:05.0[A] -> Link [LNK0] -> GSI 10 (level, low) -> IRQ 10
Aug 11 16:23:56 jddportable kernel: radeonfb: Retreived PLL infos from BIOS
Aug 11 16:23:56 jddportable kernel: radeonfb: Reference=14.32 MHz (RefDiv=31) Memory=183.00 Mhz, System=133.00 MHz
Aug 11 16:23:56 jddportable kernel: radeonfb: PLL min 12000 max 35000
Aug 11 16:23:56 jddportable kernel: Non-DDC laptop panel detected
Aug 11 16:23:56 jddportable kernel: radeonfb: Monitor 1 type LCD found
Aug 11 16:23:56 jddportable kernel: radeonfb: Monitor 2 type no found
Aug 11 16:23:56 jddportable kernel: radeonfb: panel ID string: QDI141X1LH03            
Aug 11 16:23:56 jddportable kernel: radeonfb: detected LVDS panel size from BIOS: 1024x768
Aug 11 16:23:56 jddportable kernel: radeondb: BIOS provided dividers will be used
Aug 11 16:23:56 jddportable kernel: radeonfb: Dynamic Clock Power Management enabled
Aug 11 16:23:56 jddportable kernel: Console: switching to colour frame buffer device 128x48
Aug 11 16:23:56 jddportable kernel: radeonfb (0000:01:05.0): ATI Radeon C7 
Aug 11 16:23:56 jddportable kernel: ide-scsi is deprecated for cd burning! Use ide-cd and give dev=/dev/hdX as device
Aug 11 16:23:56 jddportable kernel: scsi0 : SCSI host adapter emulation for IDE ATAPI devices
Aug 11 16:23:56 jddportable kernel:   Vendor: HL-DT-ST  Model: DVD+RW GCA-4040N  Rev: 1.15
Aug 11 16:23:56 jddportable kernel:   Type:   CD-ROM                             ANSI SCSI revision: 02
Aug 11 16:23:56 jddportable kernel: sr0: scsi3-mmc drive: 24x/24x writer cd/rw xa/form2 cdda tray
Aug 11 16:23:56 jddportable kernel: Uniform CD-ROM driver Revision: 3.20
Aug 11 16:23:56 jddportable kernel: Attached scsi CD-ROM sr0 at scsi0, channel 0, id 0, lun 0
Aug 11 16:23:56 jddportable kernel: ACPI: AC Adapter [ACAD] (on-line)
Aug 11 16:23:56 jddportable kernel: ACPI: Battery Slot [BAT1] (battery present)
Aug 11 16:23:56 jddportable kernel: ACPI: Power Button (FF) [PWRF]
Aug 11 16:23:56 jddportable kernel: ACPI: Power Button (CM) [PWRB]
Aug 11 16:23:56 jddportable kernel: ACPI: Lid Switch [LID]
Aug 11 16:23:56 jddportable kernel: ACPI: CPU0 (power states: C1[C1] C2[C2])
Aug 11 16:23:56 jddportable kernel: ACPI: Thermal Zone [THRM] (49 C)
Aug 11 16:23:56 jddportable kernel: acpi-cpufreq: CPU0 - ACPI performance management activated.
Aug 11 16:23:56 jddportable kernel: Attached scsi generic sg0 at scsi0, channel 0, id 0, lun 0,  type 5
Aug 11 16:23:56 jddportable kernel: device-mapper: 4.4.0-ioctl (2005-01-12) initialised: dm-devel@redhat.com
Aug 11 16:23:56 jddportable kernel: Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing enabled
Aug 11 16:23:56 jddportable kernel: ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
Aug 11 16:23:56 jddportable kernel: ttyS0: LSR safety check engaged!
Aug 11 16:23:56 jddportable kernel: ttyS0: LSR safety check engaged!
Aug 11 16:23:56 jddportable kernel: NET: Registered protocol family 17
Aug 11 16:23:56 jddportable kernel: hdc: DMA disabled
Aug 11 16:23:57 jddportable kernel: ACPI: PCI Interrupt 0000:00:0a.0[A] -> Link [LNK5] -> GSI 11 (level, low) -> IRQ 11
Aug 11 16:23:57 jddportable kernel: Yenta: CardBus bridge found at 0000:00:0a.0 [103c:0850]
Aug 11 16:23:57 jddportable kernel: Yenta O2: res at 0x94/0xD4: 00/ea
Aug 11 16:23:57 jddportable kernel: Yenta O2: enabling read prefetch/write burst
Aug 11 16:23:57 jddportable kernel: Yenta: ISA IRQ mask 0x04b8, PCI irq 11
Aug 11 16:23:57 jddportable kernel: Socket status: 30000007
Aug 11 16:23:57 jddportable kernel: spurious 8259A interrupt: IRQ7.
Aug 11 16:23:57 jddportable cardmgr[2008]: watching 1 socket
Aug 11 16:23:57 jddportable kernel: cs: IO port probe 0xc00-0xcff: clean.
Aug 11 16:23:57 jddportable kernel: cs: IO port probe 0x820-0x8ff: clean.
Aug 11 16:23:57 jddportable kernel: cs: IO port probe 0x800-0x80f: clean.
Aug 11 16:23:57 jddportable kernel: cs: IO port probe 0x100-0x4ff: excluding 0x378-0x37f
Aug 11 16:23:57 jddportable kernel: cs: IO port probe 0xa00-0xaff: clean.
Aug 11 16:23:57 jddportable cardmgr[2009]: starting, version is 3.2.5
Aug 11 16:24:00 jddportable /usr/sbin/gpm[2095]: Detected EXPS/2 protocol mouse.
Aug 11 16:24:01 jddportable kernel: parport: PnPBIOS parport detected.
Aug 11 16:24:01 jddportable kernel: parport0: PC-style at 0x378 (0x778), irq 7, dma 0 [PCSPP,TRISTATE,COMPAT,ECP,DMA]
Aug 11 16:24:01 jddportable kernel: lp0: using parport0 (interrupt-driven).
Aug 11 16:24:01 jddportable kernel: lp0: console ready
Aug 11 16:24:01 jddportable kernel: usbcore: registered new driver usbfs
Aug 11 16:24:01 jddportable kernel: usbcore: registered new driver hub
Aug 11 16:24:02 jddportable pci.agent[2110]:      ati-agp: already loaded
Aug 11 16:24:06 jddportable kernel: PCI: Enabling device 0000:00:06.0 (0005 -> 0007)
Aug 11 16:24:06 jddportable kernel: ACPI: PCI Interrupt Link [LNK7] enabled at IRQ 5
Aug 11 16:24:06 jddportable kernel: PCI: setting IRQ 5 as level-triggered
Aug 11 16:24:06 jddportable kernel: ACPI: PCI Interrupt 0000:00:06.0[A] -> Link [LNK7] -> GSI 5 (level, low) -> IRQ 5
Aug 11 16:24:07 jddportable kernel: AC'97 1 does not respond - RESET
Aug 11 16:24:07 jddportable kernel: AC'97 1 access is not valid [0xffffffff], removing mixer.
Aug 11 16:24:07 jddportable kernel: ali mixer 1 creating error.
Aug 11 16:24:08 jddportable pci.agent[2230]:      snd-ali5451: loaded successfully
Aug 11 16:24:11 jddportable kernel: PCI: Enabling device 0000:00:08.0 (0000 -> 0003)
Aug 11 16:24:11 jddportable kernel: ACPI: PCI Interrupt Link [LNK6] enabled at IRQ 10
Aug 11 16:24:11 jddportable kernel: ACPI: PCI Interrupt 0000:00:08.0[A] -> Link [LNK6] -> GSI 10 (level, low) -> IRQ 10
Aug 11 16:24:12 jddportable kernel: ttyS2 at I/O 0x1428 (irq = 10) is a 8250
Aug 11 16:24:12 jddportable kernel: ttyS3 at I/O 0x1440 (irq = 10) is a 8250
Aug 11 16:24:12 jddportable kernel: Couldn't register serial port 0000:00:08.0: -28
Aug 11 16:24:12 jddportable pci.agent[2416]:      8250_pci: loaded successfully
Aug 11 16:24:13 jddportable pci.agent[2553]:      yenta_socket: already loaded
Aug 11 16:24:15 jddportable kernel: USB Universal Host Controller Interface driver v2.3
Aug 11 16:24:15 jddportable kernel: ACPI: PCI Interrupt Link [LNK2] enabled at IRQ 10
Aug 11 16:24:15 jddportable kernel: ACPI: PCI Interrupt 0000:00:0b.0[A] -> Link [LNK2] -> GSI 10 (level, low) -> IRQ 10
Aug 11 16:24:15 jddportable kernel: uhci_hcd 0000:00:0b.0: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller
Aug 11 16:24:15 jddportable kernel: uhci_hcd 0000:00:0b.0: new USB bus registered, assigned bus number 1
Aug 11 16:24:15 jddportable kernel: uhci_hcd 0000:00:0b.0: irq 10, io base 0x00002000
Aug 11 16:24:15 jddportable kernel: hub 1-0:1.0: USB hub found
Aug 11 16:24:15 jddportable kernel: hub 1-0:1.0: 2 ports detected
Aug 11 16:24:15 jddportable kernel: ACPI: PCI Interrupt Link [LNK3] enabled at IRQ 10
Aug 11 16:24:15 jddportable kernel: ACPI: PCI Interrupt 0000:00:0b.1[B] -> Link [LNK3] -> GSI 10 (level, low) -> IRQ 10
Aug 11 16:24:15 jddportable kernel: uhci_hcd 0000:00:0b.1: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (#2)
Aug 11 16:24:16 jddportable kernel: uhci_hcd 0000:00:0b.1: new USB bus registered, assigned bus number 2
Aug 11 16:24:16 jddportable kernel: uhci_hcd 0000:00:0b.1: irq 10, io base 0x00002020
Aug 11 16:24:16 jddportable kernel: hub 2-0:1.0: USB hub found
Aug 11 16:24:16 jddportable kernel: hub 2-0:1.0: 2 ports detected
Aug 11 16:24:16 jddportable pci.agent[2583]:      uhci-hcd: loaded successfully
Aug 11 16:24:19 jddportable usb.agent[2691]:      usbcore: already loaded
Aug 11 16:24:19 jddportable usb.agent[2719]:      usbcore: already loaded
Aug 11 16:24:22 jddportable pci.agent[2745]:      uhci-hcd: already loaded
Aug 11 16:24:24 jddportable kernel: PCI: Enabling device 0000:00:0b.2 (0010 -> 0012)
Aug 11 16:24:24 jddportable kernel: ACPI: PCI Interrupt 0000:00:0b.2[C] -> Link [LNK5] -> GSI 11 (level, low) -> IRQ 11
Aug 11 16:24:24 jddportable kernel: PCI: Via IRQ fixup for 0000:00:0b.2, from 255 to 11
Aug 11 16:24:24 jddportable kernel: ehci_hcd 0000:00:0b.2: VIA Technologies, Inc. USB 2.0
Aug 11 16:24:24 jddportable kernel: ehci_hcd 0000:00:0b.2: new USB bus registered, assigned bus number 3
Aug 11 16:24:24 jddportable kernel: ehci_hcd 0000:00:0b.2: irq 11, io mem 0xd0003000
Aug 11 16:24:24 jddportable kernel: ehci_hcd 0000:00:0b.2: USB 2.0 initialized, EHCI 0.95, driver 10 Dec 2004
Aug 11 16:24:24 jddportable kernel: hub 3-0:1.0: USB hub found
Aug 11 16:24:24 jddportable kernel: hub 3-0:1.0: 4 ports detected
Aug 11 16:24:24 jddportable pci.agent[2808]:      ehci-hcd: loaded successfully
Aug 11 16:24:25 jddportable usb.agent[2887]:      usbcore: already loaded
Aug 11 16:24:28 jddportable kernel: ieee1394: Initialized config rom entry `ip1394'
Aug 11 16:24:28 jddportable kernel: ohci1394: $Rev: 1299 $ Ben Collins <bcollins@debian.org>
Aug 11 16:24:28 jddportable kernel: PCI: Enabling device 0000:00:0c.0 (0010 -> 0012)
Aug 11 16:24:28 jddportable kernel: ACPI: PCI Interrupt 0000:00:0c.0[A] -> Link [LNK2] -> GSI 10 (level, low) -> IRQ 10
Aug 11 16:24:28 jddportable kernel: ohci1394: fw-host0: OHCI-1394 1.1 (PCI): IRQ=[10]  MMIO=[d0003800-d0003fff]  Max Packet=[2048]
Aug 11 16:24:28 jddportable pci.agent[2914]:      ohci1394: loaded successfully
Aug 11 16:24:29 jddportable kernel: ieee1394: Host added: ID:BUS[0-00:1023]  GUID[000d9d71a08b35db]
Aug 11 16:24:30 jddportable kernel: eth1394: $Rev: 1264 $ Ben Collins <bcollins@debian.org>
Aug 11 16:24:30 jddportable kernel: eth1394: eth0: IEEE-1394 IPv4 over 1394 Ethernet (fw-host0)
Aug 11 16:24:30 jddportable ieee1394.agent[3022]:      eth1394: loaded successfully
Aug 11 16:24:32 jddportable pci.agent[3084]:      i2c-ali1535: loaded successfully
Aug 11 16:24:33 jddportable pci.agent[3084]:      i2c-ali15x3: loaded successfully
Aug 11 16:24:34 jddportable kernel: natsemi dp8381x driver, version 1.07+LK1.0.17, Sep 27, 2002
Aug 11 16:24:34 jddportable kernel:   originally by Donald Becker <becker@scyld.com>
Aug 11 16:24:34 jddportable kernel:   http://www.scyld.com/network/natsemi.html
Aug 11 16:24:34 jddportable kernel:   2.4.x kernel port by Jeff Garzik, Tjeerd Mulder
Aug 11 16:24:34 jddportable kernel: ACPI: PCI Interrupt Link [LNK1] enabled at IRQ 10
Aug 11 16:24:34 jddportable kernel: ACPI: PCI Interrupt 0000:00:12.0[A] -> Link [LNK1] -> GSI 10 (level, low) -> IRQ 10
Aug 11 16:24:35 jddportable kernel: natsemi eth1: NatSemi DP8381[56] at 0xd0008000 (0000:00:12.0), 00:0d:9d:8a:02:8c, IRQ 10, port TP.
Aug 11 16:24:35 jddportable pci.agent[3169]:      natsemi: loaded successfully
Aug 11 16:24:35 jddportable pci.rc[2099]:      ignoring pci display device 01:05.0
Aug 11 16:24:36 jddportable modprobe: FATAL: Error inserting rtc (/lib/modules/2.6.13-rc6-git2/kernel/drivers/char/rtc.ko): No such device 
Aug 11 16:24:36 jddportable isapnp.rc[3259]:      rtc: can't be loaded
Aug 11 16:24:37 jddportable kernel: input: PC Speaker
Aug 11 16:24:37 jddportable input.agent[3308]:      evdev: already loaded
Aug 11 16:24:37 jddportable isapnp.rc[3259]:      pcspkr: loaded sucessfully
Aug 11 16:24:37 jddportable input.agent[3313]:      evdev: already loaded
Aug 11 16:24:37 jddportable isapnp.rc[3259]:      parport_pc: loaded sucessfully
Aug 11 16:24:38 jddportable kernel: NET: Registered protocol family 23
Aug 11 16:24:38 jddportable isapnp.rc[3259]:      irtty-sir: loaded sucessfully
Aug 11 16:24:38 jddportable ide.rc[3424]:      ide-cd: loaded sucessfully
Aug 11 16:24:38 jddportable input.agent[3450]:      evdev: already loaded
Aug 11 16:24:38 jddportable input.agent[3464]:      evdev: already loaded
Aug 11 16:24:38 jddportable input.agent[3464]:      joydev: already loaded
Aug 11 16:24:38 jddportable input.agent[3464]:      tsdev: already loaded
Aug 11 16:24:39 jddportable input.agent[3500]:      evdev: already loaded
Aug 11 16:24:39 jddportable scsi.agent[3519]:      sr_mod: can't be loaded (for cdrom)
Aug 11 16:24:39 jddportable scsi.agent[3519]:      sg: loaded sucessfully (for cdrom)
Aug 11 16:24:39 jddportable ifplugd(eth1)[3544]: ifplugd 0.26 initializing.
Aug 11 16:24:39 jddportable kernel: eth1: DSPCFG accepted after 0 usec.
Aug 11 16:24:39 jddportable ifplugd(eth1)[3544]: Using interface eth1/00:0D:9D:8A:02:8C with driver <natsemi> (version: 1.07+LK1.0.17)
Aug 11 16:24:39 jddportable ifplugd(eth1)[3544]: Using detection mode: SIOCETHTOOL
Aug 11 16:24:39 jddportable ifplugd(eth1)[3544]: Initialization complete, link beat not detected.
Aug 11 16:24:40 jddportable syslogd 1.4.1#17: restart.
Aug 11 16:24:41 jddportable kernel: NET: Registered protocol family 10
Aug 11 16:24:41 jddportable kernel: Disabled Privacy Extensions on device c053e7e0(lo)
Aug 11 16:24:41 jddportable kernel: IPv6 over IPv4 tunneling driver
Aug 11 16:24:41 jddportable xfs[3651]: ignoring font path element /usr/lib/X11/fonts/cyrillic/ (unreadable) 
Aug 11 16:24:42 jddportable hcid[3655]: Bluetooth HCI daemon
Aug 11 16:24:42 jddportable kernel: Bluetooth: Core ver 2.7
Aug 11 16:24:42 jddportable kernel: NET: Registered protocol family 31
Aug 11 16:24:42 jddportable kernel: Bluetooth: HCI device and connection manager initialized
Aug 11 16:24:42 jddportable kernel: Bluetooth: HCI socket layer initialized
Aug 11 16:24:42 jddportable kernel: Bluetooth: L2CAP ver 2.7
Aug 11 16:24:42 jddportable kernel: Bluetooth: L2CAP socket layer initialized
Aug 11 16:24:42 jddportable sdpd[3665]: Bluetooth SDP daemon 
Aug 11 16:24:42 jddportable kernel: Bluetooth: RFCOMM ver 1.5
Aug 11 16:24:42 jddportable kernel: Bluetooth: RFCOMM socket layer initialized
Aug 11 16:24:42 jddportable kernel: Bluetooth: RFCOMM TTY layer initialized
Aug 11 16:24:42 jddportable dund[3686]: Bluetooth DUN daemon version 2.15
Aug 11 16:24:42 jddportable xfs[3651]: ignoring font path element /usr/lib/X11/fonts/CID (unreadable) 
Aug 11 16:24:42 jddportable xfs[3651]: ignoring font path element /usr/lib/X11/fonts/Speedo/ (unreadable) 
Aug 11 16:24:43 jddportable /usr/sbin/cron[3691]: (CRON) INFO (pidfile fd = 3)
Aug 11 16:24:43 jddportable /usr/sbin/cron[3692]: (CRON) STARTUP (fork ok)
Aug 11 16:24:43 jddportable /usr/sbin/cron[3692]: (CRON) INFO (Running @reboot jobs)
Aug 11 16:24:44 jddportable modprobe: FATAL: Error inserting apm (/lib/modules/2.6.13-rc6-git2/kernel/arch/i386/kernel/apm.ko): No such device 
Aug 11 16:24:44 jddportable kernel: apm: BIOS not found.
Aug 11 16:24:47 jddportable kernel: [drm] Initialized drm 1.0.0 20040925
Aug 11 16:24:47 jddportable kernel: ACPI: PCI Interrupt 0000:01:05.0[A] -> Link [LNK0] -> GSI 10 (level, low) -> IRQ 10
Aug 11 16:24:47 jddportable kernel: [drm] Initialized radeon 1.16.0 20050311 on minor 0: ATI Technologies Inc Radeon IGP 330M/340M/350M
Aug 11 16:24:47 jddportable kernel: agpgart: Found an AGP 2.0 compliant device at 0000:00:00.0.
Aug 11 16:24:47 jddportable kernel: agpgart: Putting AGP V2 device at 0000:00:00.0 into 4x mode
Aug 11 16:24:47 jddportable kernel: agpgart: Putting AGP V2 device at 0000:01:05.0 into 4x mode
Aug 11 16:24:51 jddportable kernel: eth1: no IPv6 routers present
Aug 11 16:24:56 jddportable kdm_greet[3827]: Can't open default user face
Aug 11 16:25:01 jddportable /USR/SBIN/CRON[3832]: (root) CMD (if [ -x /usr/bin/gsmsmsrequeue ]; then /usr/bin/gsmsmsrequeue; fi)
Aug 11 16:25:19 jddportable kernel: sr0: Hmm, seems the drive doesn't support multisession CD's
Aug 11 16:27:12 jddportable kernel: ath_hal: module license 'Proprietary' taints kernel.
Aug 11 16:27:12 jddportable kernel: ath_hal: 0.9.14.9 (AR5210, AR5211, AR5212, RF5111, RF5112, RF2413)
Aug 11 16:27:12 jddportable kernel: wlan: 0.8.6.0 (EXPERIMENTAL)
Aug 11 16:27:12 jddportable kernel: ath_rate_onoe: 1.0
Aug 11 16:27:12 jddportable waproamd.hotplug[4137]: Invoking waproamd for ath0
Aug 11 16:27:12 jddportable kernel: ath_pci: 0.9.6.0 (EXPERIMENTAL)
Aug 11 16:27:12 jddportable kernel: PCI: Enabling device 0000:02:00.0 (0000 -> 0002)
Aug 11 16:27:12 jddportable kernel: ACPI: PCI Interrupt 0000:02:00.0[A] -> Link [LNK5] -> GSI 11 (level, low) -> IRQ 11
Aug 11 16:27:12 jddportable kernel: Build date: Aug 11 2005
Aug 11 16:27:12 jddportable kernel: Debugging version (IEEE80211)
Aug 11 16:27:12 jddportable kernel: ath0: 11a rates: 6Mbps 9Mbps 12Mbps 18Mbps 24Mbps 36Mbps 48Mbps 54Mbps
Aug 11 16:27:12 jddportable kernel: ath0: 11b rates: 1Mbps 2Mbps 5.5Mbps 11Mbps
Aug 11 16:27:12 jddportable kernel: ath0: 11g rates: 1Mbps 2Mbps 5.5Mbps 11Mbps 6Mbps 9Mbps 12Mbps 18Mbps 24Mbps 36Mbps 48Mbps 54Mbps
Aug 11 16:27:12 jddportable kernel: ath0: turboA rates: 6Mbps 9Mbps 12Mbps 18Mbps 24Mbps 36Mbps 48Mbps 54Mbps
Aug 11 16:27:12 jddportable kernel: ath0: H/W encryption support: WEP AES AES_CCM TKIP
Aug 11 16:27:12 jddportable kernel: ath0: mac 5.6 phy 4.1 5ghz radio 1.7 2ghz radio 2.3
Aug 11 16:27:12 jddportable kernel: ath0: Use hw queue 1 for WME_AC_BE traffic
Aug 11 16:27:12 jddportable kernel: ath0: Use hw queue 0 for WME_AC_BK traffic
Aug 11 16:27:12 jddportable kernel: ath0: Use hw queue 2 for WME_AC_VI traffic
Aug 11 16:27:12 jddportable kernel: ath0: Use hw queue 3 for WME_AC_VO traffic
Aug 11 16:27:12 jddportable kernel: ath0: Use hw queue 8 for CAB traffic
Aug 11 16:27:12 jddportable kernel: ath0: Use hw queue 9 for beacons
Aug 11 16:27:12 jddportable kernel: Debugging version (ATH)
Aug 11 16:27:12 jddportable kernel: ath0: Atheros 5212: mem=0x3e000000, irq=11
Aug 11 16:27:12 jddportable pci.agent[4077]:      ath_pci: loaded successfully
Aug 11 16:27:12 jddportable waproamd(ath0)[4151]: waproamd 0.6 initializing, using NETLINK device monitoring.
Aug 11 16:27:12 jddportable waproamd(ath0)[4151]: Warning: Could not get interface address.
Aug 11 16:27:12 jddportable waproamd(ath0)[4151]: Interface set to status UP.
Aug 11 16:27:12 jddportable waproamd(ath0)[4151]: Enabling user space roaming failed, doing without.
Aug 11 16:27:12 jddportable waproamd(ath0)[4151]: Currently not associated, interface enabled.
Aug 11 16:27:12 jddportable waproamd(ath0)[4151]: Initialization complete.
Aug 11 16:27:12 jddportable waproamd(ath0)[4151]: Scanning...
Aug 11 16:27:22 jddportable waproamd(ath0)[4151]: Scan results:
Aug 11 16:27:22 jddportable waproamd(ath0)[4151]: 1. Found AP 00:20:a6:50:67:41, ESSID 'CERN', script: yes
Aug 11 16:27:22 jddportable waproamd(ath0)[4151]: Scan completed with 1 suitable networks. (total: 1)
Aug 11 16:27:22 jddportable waproamd(ath0)[4151]: Selected new AP 00:20:a6:50:67:41 with ESSID 'CERN'
Aug 11 16:27:22 jddportable waproamd(ath0)[4151]: Running script '/etc/waproamd/scripts/essid:CERN start'
Aug 11 16:27:22 jddportable waproamd(ath0)[4151]: client: Setting policy 'open'
Aug 11 16:27:22 jddportable pumpd[1754]: PUMP: sending discover 
Aug 11 16:27:23 jddportable pumpd[1754]: got dhcp offer 
Aug 11 16:27:23 jddportable pumpd[1754]: PUMP: sending second discover
Aug 11 16:27:23 jddportable pumpd[1754]: PUMP: got an offer
Aug 11 16:27:23 jddportable pumpd[1754]: PUMP: got lease
Aug 11 16:27:23 jddportable pumpd[1754]: intf: device: ath0
Aug 11 16:27:23 jddportable pumpd[1754]: intf: set: 416
Aug 11 16:27:23 jddportable pumpd[1754]: intf: bootServer: 137.138.17.6
Aug 11 16:27:23 jddportable pumpd[1754]: intf: reqLease: 43200
Aug 11 16:27:23 jddportable pumpd[1754]: intf: ip: 128.141.128.114
Aug 11 16:27:23 jddportable pumpd[1754]: intf: next server: 137.138.17.6
Aug 11 16:27:23 jddportable pumpd[1754]: intf: netmask: 255.255.0.0
Aug 11 16:27:23 jddportable pumpd[1754]: intf: gateways[0]: 128.141.1.1
Aug 11 16:27:23 jddportable pumpd[1754]: intf: numGateways: 1
Aug 11 16:27:23 jddportable pumpd[1754]: intf: dnsServers[0]: 137.138.16.5
Aug 11 16:27:23 jddportable pumpd[1754]: intf: dnsServers[1]: 137.138.17.5
Aug 11 16:27:23 jddportable pumpd[1754]: intf: numDns: 2
Aug 11 16:27:23 jddportable pumpd[1754]: intf: domain: cern.ch
Aug 11 16:27:23 jddportable pumpd[1754]: intf: broadcast: 128.141.255.255
Aug 11 16:27:23 jddportable pumpd[1754]: intf: hostname: jddportable
Aug 11 16:27:23 jddportable pumpd[1754]: intf: network: 128.141.0.0
Aug 11 16:27:23 jddportable pumpd[1754]: configured interface ath0
Aug 11 16:27:23 jddportable waproamd(ath0)[4151]: Script successfully executed.
Aug 11 16:27:33 jddportable kernel: ath0: no IPv6 routers present
Aug 11 16:27:53 jddportable waproamd(ath0)[4151]: Scanning...
Aug 11 16:28:03 jddportable waproamd(ath0)[4151]: Scan results:
Aug 11 16:28:03 jddportable waproamd(ath0)[4151]: 1. Found AP 00:20:a6:50:67:41, ESSID 'CERN', script: yes
Aug 11 16:28:03 jddportable waproamd(ath0)[4151]: Scan completed with 1 suitable networks. (total: 1)
Aug 11 16:28:33 jddportable waproamd(ath0)[4151]: Scanning...
Aug 11 16:28:42 jddportable waproamd(ath0)[4151]: Scan results:
Aug 11 16:28:42 jddportable waproamd(ath0)[4151]: 1. Found AP 00:20:a6:50:67:41, ESSID 'CERN', script: yes
Aug 11 16:28:42 jddportable waproamd(ath0)[4151]: Scan completed with 1 suitable networks. (total: 1)
Aug 11 16:29:12 jddportable waproamd(ath0)[4151]: Scanning...
Aug 11 16:29:22 jddportable waproamd(ath0)[4151]: Scan results:
Aug 11 16:29:22 jddportable waproamd(ath0)[4151]: 1. Found AP 00:20:a6:50:67:41, ESSID 'CERN', script: yes
Aug 11 16:29:22 jddportable waproamd(ath0)[4151]: Scan completed with 1 suitable networks. (total: 1)
Aug 11 16:29:52 jddportable waproamd(ath0)[4151]: Scanning...
Aug 11 16:30:01 jddportable waproamd(ath0)[4151]: Scan results:
Aug 11 16:30:01 jddportable waproamd(ath0)[4151]: 1. Found AP 00:20:a6:50:67:41, ESSID 'CERN', script: yes
Aug 11 16:30:01 jddportable waproamd(ath0)[4151]: Scan completed with 1 suitable networks. (total: 1)
Aug 11 16:30:01 jddportable /USR/SBIN/CRON[4257]: (root) CMD ([ -d /etc/shaper ] && /etc/init.d/shaper timecheck)
Aug 11 16:30:01 jddportable /USR/SBIN/CRON[4258]: (root) CMD (if [ -x /usr/bin/gsmsmsrequeue ]; then /usr/bin/gsmsmsrequeue; fi)
Aug 11 16:30:31 jddportable waproamd(ath0)[4151]: Scanning...
Aug 11 16:30:40 jddportable waproamd(ath0)[4151]: Scan results:
Aug 11 16:30:40 jddportable waproamd(ath0)[4151]: 1. Found AP 00:20:a6:50:67:41, ESSID 'CERN', script: yes
Aug 11 16:30:40 jddportable waproamd(ath0)[4151]: Scan completed with 1 suitable networks. (total: 1)
Aug 11 16:31:10 jddportable waproamd(ath0)[4151]: Scanning...
Aug 11 16:31:19 jddportable waproamd(ath0)[4151]: Scan results:
Aug 11 16:31:19 jddportable waproamd(ath0)[4151]: 1. Found AP 00:20:a6:50:67:41, ESSID 'CERN', script: yes
Aug 11 16:31:19 jddportable waproamd(ath0)[4151]: 2. Found AP 00:02:2d:41:0d:d8, ESSID 'CERN', script: yes
Aug 11 16:31:19 jddportable waproamd(ath0)[4151]: 3. Found AP 00:20:a6:50:66:7f, ESSID 'CERN', script: yes
Aug 11 16:31:19 jddportable waproamd(ath0)[4151]: Scan completed with 3 suitable networks. (total: 3)
Aug 11 16:31:49 jddportable waproamd(ath0)[4151]: Scanning...
Aug 11 16:31:58 jddportable waproamd(ath0)[4151]: Scan results:
Aug 11 16:31:58 jddportable waproamd(ath0)[4151]: 1. Found AP 00:20:a6:50:67:41, ESSID 'CERN', script: yes
Aug 11 16:31:58 jddportable waproamd(ath0)[4151]: 2. Found AP 00:20:a6:50:66:7f, ESSID 'CERN', script: yes
Aug 11 16:31:58 jddportable waproamd(ath0)[4151]: 3. Found AP 00:02:2d:41:0d:d8, ESSID 'CERN', script: yes
Aug 11 16:31:58 jddportable waproamd(ath0)[4151]: Scan completed with 3 suitable networks. (total: 3)
Aug 11 16:32:28 jddportable waproamd(ath0)[4151]: Scanning...
Aug 11 16:32:37 jddportable waproamd(ath0)[4151]: Scan results:
Aug 11 16:32:37 jddportable waproamd(ath0)[4151]: 1. Found AP 00:20:a6:50:67:41, ESSID 'CERN', script: yes
Aug 11 16:32:37 jddportable waproamd(ath0)[4151]: 2. Found AP 00:20:a6:50:66:7f, ESSID 'CERN', script: yes
Aug 11 16:32:37 jddportable waproamd(ath0)[4151]: 3. Found AP 00:02:2d:41:0d:d8, ESSID 'CERN', script: yes
Aug 11 16:32:37 jddportable waproamd(ath0)[4151]: Scan completed with 3 suitable networks. (total: 3)
Aug 11 16:33:07 jddportable waproamd(ath0)[4151]: Scanning...
Aug 11 16:33:16 jddportable waproamd(ath0)[4151]: Scan results:
...
Cheers, JD.

--Boundary-00=_l32+Cf1tMTifFlt
Content-Type: text/plain;
  charset="us-ascii";
  name="scsi"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="scsi"

Attached devices:
Host: scsi0 Channel: 00 Id: 00 Lun: 00
  Vendor: HL-DT-ST Model: DVD+RW GCA-4040N Rev: 1.15
  Type:   CD-ROM                           ANSI SCSI revision: 02

--Boundary-00=_l32+Cf1tMTifFlt
Content-Type: text/plain;
  charset="us-ascii";
  name="lspci"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="lspci"

0000:00:00.0 Host bridge: ATI Technologies Inc: Unknown device cbb2 (rev 02)
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
	Latency: 64
	Region 0: Memory at d4000000 (32-bit, prefetchable) [size=64M]
	Region 1: Memory at d0009000 (32-bit, prefetchable) [size=4K]
	Capabilities: [a0] AGP version 2.0
		Status: RQ=16 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64- HTrans- 64bit- FW+ AGP3- Rate=x1,x2,x4
		Command: RQ=1 ArqSz=0 Cal=0 SBA+ AGP+ GART64- 64bit- FW- Rate=x4

0000:00:01.0 PCI bridge: ATI Technologies Inc PCI Bridge [IGP 340M] (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66MHz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 99
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=68
	I/O behind bridge: 00009000-00009fff
	Memory behind bridge: d0300000-d03fffff
	Prefetchable memory behind bridge: d8000000-dfffffff
	BridgeCtl: Parity- SERR- NoISA+ VGA+ MAbort- >Reset- FastB2B-

0000:00:06.0 Multimedia audio controller: ALi Corporation M5451 PCI AC-Link Controller Audio Device (rev 02)
	Subsystem: Hewlett-Packard Company: Unknown device 0850
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR+ <PERR+
	Latency: 64 (500ns min, 6000ns max)
	Interrupt: pin A routed to IRQ 5
	Region 0: I/O ports at 1000 [size=256]
	Region 1: Memory at d0000000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: [dc] Power Management version 2
		Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:07.0 ISA bridge: ALi Corporation M1533 PCI to ISA Bridge [Aladdin IV]
	Subsystem: ALi Corporation ALI M1533 Aladdin IV ISA Bridge
	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Capabilities: [a0] Power Management version 1
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:08.0 Modem: ALi Corporation M5457 AC'97 Modem Controller (prog-if 00 [Generic])
	Subsystem: Hewlett-Packard Company: Unknown device 0850
	Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin A routed to IRQ 10
	Region 0: Memory at d0001000 (32-bit, non-prefetchable) [size=4K]
	Region 1: I/O ports at 1400 [size=256]
	Capabilities: [40] Power Management version 2
		Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:0a.0 CardBus bridge: O2 Micro, Inc. OZ6912 Cardbus Controller
	Subsystem: Hewlett-Packard Company: Unknown device 0850
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=slow >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 168
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at d0002000 (32-bit, non-prefetchable) [size=4K]
	Bus: primary=00, secondary=02, subordinate=05, sec-latency=176
	Memory window 0: 3c000000-3dfff000 (prefetchable)
	Memory window 1: 3e000000-3ffff000
	I/O window 0: 00004000-00004fff
	I/O window 1: 00005000-00005fff
	BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset- 16bInt- PostWrite+
	16-bit legacy interface ports at 0001

0000:00:0b.0 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (rev 50) (prog-if 00 [UHCI])
	Subsystem: Hewlett-Packard Company: Unknown device 0850
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64, Cache Line Size: 0x08 (32 bytes)
	Interrupt: pin A routed to IRQ 10
	Region 4: I/O ports at 2000 [size=32]
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:0b.1 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (rev 50) (prog-if 00 [UHCI])
	Subsystem: Hewlett-Packard Company: Unknown device 0850
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64, Cache Line Size: 0x08 (32 bytes)
	Interrupt: pin B routed to IRQ 10
	Region 4: I/O ports at 2020 [size=32]
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:0b.2 USB Controller: VIA Technologies, Inc. USB 2.0 (rev 51) (prog-if 20 [EHCI])
	Subsystem: Hewlett-Packard Company: Unknown device 0850
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64, Cache Line Size: 0x20 (128 bytes)
	Interrupt: pin C routed to IRQ 11
	Region 0: Memory at d0003000 (32-bit, non-prefetchable) [size=256]
	Capabilities: [80] Power Management version 2
		Flags: PMEClk+ DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:0c.0 FireWire (IEEE 1394): Texas Instruments TSB43AB21 IEEE-1394a-2000 Controller (PHY/Link) (prog-if 10 [OHCI])
	Subsystem: Hewlett-Packard Company: Unknown device 0850
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (500ns min, 1000ns max), Cache Line Size: 0x08 (32 bytes)
	Interrupt: pin A routed to IRQ 10
	Region 0: Memory at d0003800 (32-bit, non-prefetchable) [size=2K]
	Region 1: Memory at d0004000 (32-bit, non-prefetchable) [size=16K]
	Capabilities: [44] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME+

0000:00:10.0 IDE interface: ALi Corporation M5229 IDE (rev c4) (prog-if fa)
	Subsystem: Hewlett-Packard Company: Unknown device 0850
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (500ns min, 1000ns max)
	Interrupt: pin A routed to IRQ 0
	Region 4: I/O ports at 2040 [size=16]
	Capabilities: [60] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:11.0 Bridge: ALi Corporation M7101 Power Management Controller [PMU]
	Subsystem: Hewlett-Packard Company: Unknown device 0850
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-

0000:00:12.0 Ethernet controller: National Semiconductor Corporation DP83815 (MacPhyter) Ethernet Controller
	Subsystem: Hewlett-Packard Company: Unknown device 0850
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 90 (2750ns min, 13000ns max)
	Interrupt: pin A routed to IRQ 10
	Region 0: I/O ports at 2400 [size=256]
	Region 1: Memory at d0008000 (32-bit, non-prefetchable) [size=4K]
	Expansion ROM at 40000000 [disabled] [size=64K]
	Capabilities: [40] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=320mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME+

0000:01:05.0 VGA compatible controller: ATI Technologies Inc Radeon IGP 340M (prog-if 00 [VGA])
	Subsystem: Hewlett-Packard Company: Unknown device 0850
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ SERR- FastB2B+
	Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 66 (2000ns min), Cache Line Size: 0x08 (32 bytes)
	Interrupt: pin A routed to IRQ 10
	Region 0: Memory at d8000000 (32-bit, prefetchable) [size=128M]
	Region 1: I/O ports at 9000 [size=256]
	Region 2: Memory at d0300000 (32-bit, non-prefetchable) [size=64K]
	Expansion ROM at d0320000 [disabled] [size=128K]
	Capabilities: [58] AGP version 2.0
		Status: RQ=48 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64- HTrans- 64bit- FW- AGP3- Rate=x1,x2,x4
		Command: RQ=16 ArqSz=0 Cal=0 SBA+ AGP+ GART64- 64bit- FW- Rate=x4
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-


--Boundary-00=_l32+Cf1tMTifFlt
Content-Type: text/plain;
  charset="us-ascii";
  name="iomem"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="iomem"

00000000-0009f7ff : System RAM
0009f800-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000cefff : Video ROM
000cf000-000cf7ff : Adapter ROM
000d8000-000dffff : reserved
000f0000-000fffff : System ROM
00100000-2bf6ffff : System RAM
  00100000-00464f09 : Kernel code
  00464f0a-005dda07 : Kernel data
2bf70000-2bf7bfff : ACPI Tables
2bf7c000-2bf7ffff : ACPI Non-volatile Storage
2bf80000-2bffffff : reserved
3bf80000-3bffffff : reserved
3c000000-3dffffff : PCI CardBus #02
3e000000-3fffffff : PCI CardBus #02
40000000-4000ffff : 0000:00:12.0
d0000000-d0000fff : 0000:00:06.0
  d0000000-d0000fff : ALI 5451
d0001000-d0001fff : 0000:00:08.0
d0002000-d0002fff : 0000:00:0a.0
  d0002000-d0002fff : yenta_socket
d0003000-d00030ff : 0000:00:0b.2
  d0003000-d00030ff : ehci_hcd
d0003800-d0003fff : 0000:00:0c.0
  d0003800-d0003fff : ohci1394
d0004000-d0007fff : 0000:00:0c.0
d0008000-d0008fff : 0000:00:12.0
  d0008000-d0008fff : natsemi
d0009000-d0009fff : 0000:00:00.0
d0300000-d03fffff : PCI Bus #01
  d0300000-d030ffff : 0000:01:05.0
    d0300000-d030ffff : radeonfb
  d0320000-d033ffff : 0000:01:05.0
d4000000-d7ffffff : 0000:00:00.0
d8000000-dfffffff : PCI Bus #01
  d8000000-dfffffff : 0000:01:05.0
    d8000000-dfffffff : radeonfb
fff80000-ffffffff : reserved

--Boundary-00=_l32+Cf1tMTifFlt
Content-Type: text/plain;
  charset="us-ascii";
  name="ioports"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="ioports"

0000-001f : dma1
0020-0021 : pic1
0040-0043 : timer0
0050-0053 : timer1
0060-006f : keyboard
0080-008f : dma page reg
00a0-00a1 : pic2
00c0-00df : dma2
00e1-00e1 : #ENUM hotswap signal register
00f0-00ff : fpu
0170-0177 : ide1
01f0-01f7 : ide0
02f8-02ff : serial
0376-0376 : ide1
0378-037a : parport0
03c0-03df : vga+
03f6-03f6 : ide0
03f8-03ff : serial
040b-040b : pnp 00:06
0480-048f : pnp 00:06
04d0-04d1 : pnp 00:06
04d6-04d6 : pnp 00:06
0778-077a : parport0
0cf8-0cff : PCI conf1
1000-10ff : 0000:00:06.0
  1000-10ff : ALI 5451
1400-14ff : 0000:00:08.0
  1428-142f : serial
  1440-1447 : serial
2000-201f : 0000:00:0b.0
  2000-201f : uhci_hcd
2020-203f : 0000:00:0b.1
  2020-203f : uhci_hcd
2040-204f : 0000:00:10.0
  2040-2047 : ide0
  2048-204f : ide1
2400-24ff : 0000:00:12.0
  2400-24ff : natsemi
4000-4fff : PCI CardBus #02
5000-5fff : PCI CardBus #02
8000-803f : 0000:00:11.0
  8000-8003 : PM1a_EVT_BLK
  8004-8005 : motherboard
    8004-8005 : PM1a_CNT_BLK
  8008-800b : PM_TMR
  8010-8015 : ACPI CPU throttle
  8018-8027 : GPE0_BLK
  8030-8030 : PM2_CNT_BLK
8040-805f : 0000:00:11.0
  8040-805f : ali1535-smb
80f0-80f3 : motherboard
9000-9fff : PCI Bus #01
  9000-90ff : 0000:01:05.0
    9000-90ff : radeonfb
fe00-fefe : motherboard
ff00-ff01 : motherboard

--Boundary-00=_l32+Cf1tMTifFlt
Content-Type: text/plain;
  charset="us-ascii";
  name="modules"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="modules"

ath_pci 87324 0 - Live 0xee0a8000
ath_rate_onoe 13576 1 ath_pci, Live 0xedf20000
wlan 149660 2 ath_pci,ath_rate_onoe, Live 0xedfda000
ath_hal 153296 1 ath_pci, Live 0xee081000
radeon 83328 1 - Live 0xedf38000
drm 73236 2 radeon, Live 0xedf4f000
rfcomm 50328 3 - Live 0xedeca000
l2cap 36352 5 rfcomm, Live 0xedee5000
bluetooth 61316 4 rfcomm,l2cap, Live 0xedf28000
ipv6 286592 12 - Live 0xedf68000
ide_cd 48004 0 - Live 0xeded8000
irtty_sir 11008 0 - Live 0xedeb3000
sir_dev 23116 1 irtty_sir, Live 0xedec3000
irda 146232 1 sir_dev, Live 0xedef0000
crc_ccitt 6272 1 irda, Live 0xede4a000
pcspkr 7904 0 - Live 0xede47000
natsemi 33632 0 - Live 0xedeb9000
i2c_ali15x3 12036 0 - Live 0xede43000
i2c_ali1535 11524 0 - Live 0xede3f000
eth1394 25352 0 - Live 0xede37000
ohci1394 41268 0 - Live 0xeddf8000
ieee1394 321624 2 eth1394,ohci1394, Live 0xede4d000
ehci_hcd 39304 0 - Live 0xedd98000
uhci_hcd 39440 0 - Live 0xedd4c000
8250_pci 23424 0 - Live 0xedca7000
snd_ali5451 31172 1 - Live 0xedd2d000
snd_ac97_codec 90876 1 snd_ali5451, Live 0xeddd3000
snd_pcm_oss 57760 0 - Live 0xeddc3000
snd_mixer_oss 24064 1 snd_pcm_oss, Live 0xedd26000
snd_pcm 98948 3 snd_ali5451,snd_ac97_codec,snd_pcm_oss, Live 0xedda9000
snd_timer 30596 1 snd_pcm, Live 0xedd43000
snd 62948 8 snd_ali5451,snd_ac97_codec,snd_pcm_oss,snd_mixer_oss,snd_pcm,snd_timer, Live 0xedd57000
soundcore 14688 1 snd, Live 0xedcf7000
snd_page_alloc 15112 1 snd_pcm, Live 0xecc5b000
usbcore 132604 3 ehci_hcd,uhci_hcd, Live 0xedd6a000
parport_pc 45892 1 - Live 0xedd36000
lp 17160 0 - Live 0xedcf1000
parport 42824 2 parport_pc,lp, Live 0xedd1a000
pcmcia 45096 2 - Live 0xedd0d000
yenta_socket 30092 2 - Live 0xedcde000
rsrc_nonstatic 18304 1 yenta_socket, Live 0xedcca000
pcmcia_core 48664 3 pcmcia,yenta_socket,rsrc_nonstatic, Live 0xedd00000
af_packet 31624 0 - Live 0xedce8000
deflate 8192 0 - Live 0xecc0b000
zlib_deflate 26904 1 deflate, Live 0xedcc2000
twofish 43136 0 - Live 0xedcd2000
serpent 22528 0 - Live 0xedcbb000
aes_i586 43136 0 - Live 0xedcaf000
blowfish 12544 0 - Live 0xecc60000
des 20864 0 - Live 0xedc8b000
sha256 16000 0 - Live 0xecc78000
sha1 6656 0 - Live 0xecc58000
crypto_null 6400 0 - Live 0xecc4f000
8250 32900 1 8250_pci, Live 0xedc81000
serial_core 27648 1 8250, Live 0xecc70000
dm_mod 66076 0 - Live 0xedc95000
sg 39072 0 - Live 0xecc65000
cpufreq_stats 10272 0 - Live 0xecc54000
cpufreq_powersave 5888 1 - Live 0xecc4c000
cpufreq_performance 6272 0 - Live 0xecc3e000
cpufreq_ondemand 11528 0 - Live 0xecc48000
cpufreq_conservative 12684 0 - Live 0xecc43000
acpi_cpufreq 10880 0 - Live 0xecc2b000
freq_table 8960 2 cpufreq_stats,acpi_cpufreq, Live 0xecc2f000
thermal 17928 0 - Live 0xecbfc000
processor 30312 2 acpi_cpufreq,thermal, Live 0xecc35000
fan 8708 0 - Live 0xecc27000
container 8704 0 - Live 0xecc07000
button 10768 0 - Live 0xecbda000
battery 14212 0 - Live 0xecc02000
ac 8964 0 - Live 0xecbde000
ide_scsi 23300 0 - Live 0xecbf5000
radeonfb 97344 1 - Live 0xecc0e000
i2c_algo_bit 14088 1 radeonfb, Live 0xecbeb000
i2c_core 26624 4 i2c_ali15x3,i2c_ali1535,radeonfb,i2c_algo_bit, Live 0xecbe3000
ati_agp 13068 1 - Live 0xecba2000
agpgart 41168 2 drm,ati_agp, Live 0xecbaa000
genrtc 14472 0 - Live 0xecb59000
tsdev 11840 0 - Live 0xecb68000
joydev 14016 0 - Live 0xecb63000
evdev 13568 0 - Live 0xecb5e000

--Boundary-00=_l32+Cf1tMTifFlt
Content-Type: text/plain;
  charset="us-ascii";
  name="cpuinfo"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="cpuinfo"

processor	: 0
vendor_id	: GenuineIntel
cpu family	: 15
model		: 2
model name	: Mobile Intel(R) Pentium(R) 4     CPU 2.66GHz
stepping	: 9
cpu MHz		: 2658.961
cache size	: 512 KB
fdiv_bug	: no
hlt_bug		: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 2
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe cid xtpr
bogomips	: 3195.20


--Boundary-00=_l32+Cf1tMTifFlt
Content-Type: text/plain;
  charset="us-ascii";
  name="ver_linux"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="ver_linux"

If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.
 
Linux jddportable 2.6.13-rc6-git2 #1 SMP Thu Aug 11 13:46:10 CEST 2005 i686 GNU/Linux
 
Gnu C                  3.3.6
Gnu make               3.80
binutils               2.16.1
util-linux             2.12p
mount                  2.12p
module-init-tools      3.2-pre1
e2fsprogs              1.38
jfsutils               1.1.8
reiserfsprogs          3.6.19
reiser4progs           line
xfsprogs               2.6.28
pcmcia-cs              3.2.5
PPP                    2.4.3
isdn4k-utils           3.6
Linux C Library        2.3.2
Dynamic linker (ldd)   2.3.2
Procps                 3.2.5
Net-tools              1.60
Console-tools          0.2.3
Sh-utils               5.2.1
Modules Loaded         ath_pci ath_rate_onoe wlan ath_hal radeon drm rfcomm l2cap bluetooth ipv6 ide_cd irtty_sir sir_dev irda crc_ccitt pcspkr natsemi i2c_ali15x3 i2c_ali1535 eth1394 ohci1394 ieee1394 ehci_hcd uhci_hcd 8250_pci snd_ali5451 snd_ac97_codec snd_pcm_oss snd_mixer_oss snd_pcm snd_timer snd soundcore snd_page_alloc usbcore parport_pc lp parport pcmcia yenta_socket rsrc_nonstatic pcmcia_core af_packet deflate zlib_deflate twofish serpent aes_i586 blowfish des sha256 sha1 crypto_null 8250 serial_core dm_mod sg cpufreq_stats cpufreq_powersave cpufreq_performance cpufreq_ondemand cpufreq_conservative acpi_cpufreq freq_table thermal processor fan container button battery ac ide_scsi radeonfb i2c_algo_bit i2c_core ati_agp agpgart genrtc tsdev joydev evdev

--Boundary-00=_l32+Cf1tMTifFlt--
