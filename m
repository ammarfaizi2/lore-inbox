Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268255AbUHYTHI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268255AbUHYTHI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Aug 2004 15:07:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268308AbUHYTHH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Aug 2004 15:07:07 -0400
Received: from mamona.cetuc.puc-rio.br ([139.82.74.4]:46479 "EHLO
	mamona.cetuc.puc-rio.br") by vger.kernel.org with ESMTP
	id S268255AbUHYTGD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Aug 2004 15:06:03 -0400
Subject: SMP kernel 2.6 does not work with my network cards. UP kernel
	works nice.
From: Marcelo Roberto Jimenez <mroberto@cetuc.puc-rio.br>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Organization: CETUC/PUC-Rio
Message-Id: <1093460668.2461.46.camel@genipapo>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Wed, 25 Aug 2004 16:04:28 -0300
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I am currently not able to use the 2.6 SMP kernel, because the network
card drivers seem not to be working. UP kernel works fine. I have tried
the latest www.kernel.org kernel, and is has the same problem as the
latest Fedora Core 2.

I have tried with both the VIA-Rhine-III and the RTL-8139 nics, both
fail the same way.

Here is my data:

[root@genipapo cvswork]# uname -sr
Linux 2.6.8-1.521
[root@genipapo cvswork]# lspci
00:00.0 Host bridge: VIA Technologies, Inc. VT82C693A/694x [Apollo PRO133x] (rev c4)
00:01.0 PCI bridge: VIA Technologies, Inc. VT82C598/694x [Apollo MVP3/Pro133x AGP]
00:07.0 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super South] (rev 40)
00:07.1 IDE interface: VIA Technologies, Inc. VT82C586A/B/VT82C686/A/B/VT823x/A/C PIPC Bus Master IDE (rev 06)
00:07.2 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (rev 16)
00:07.3 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (rev 16)
00:07.4 Bridge: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI] (rev 40)
00:09.0 Ethernet controller: VIA Technologies, Inc. VT6105 [Rhine-III] (rev 86)
00:0a.0 Multimedia audio controller: Ensoniq 5880 AudioPCI (rev 02)
00:0c.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139/8139C/8139C+ (rev 10)
01:00.0 VGA compatible controller: nVidia Corporation NV5M64 [RIVA TNT2 Model 64/Model 64 Pro] (rev 15)

--------------------------------------------------------------------------------
SMP Kernel:
--------------------------------------------------------------------------------
Aug 20 13:45:33 genipapo kernel: klogd 1.4.1, log source = /proc/kmsg started.
Aug 20 13:45:33 genipapo kernel: Linux version 2.6.8-1.521smp (bhcompile@tweety.build.redhat.com) (gcc version 3.3.3 20040412 (Red Hat Linux 3.3.3-7)) #1 SMP Mon Aug 16 09:25:06 EDT 2004
Aug 20 13:45:33 genipapo kernel: BIOS-provided physical RAM map:
Aug 20 13:45:33 genipapo kernel:  BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
Aug 20 13:45:33 genipapo kernel:  BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
Aug 20 13:45:33 genipapo kernel:  BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
Aug 20 13:45:33 genipapo kernel:  BIOS-e820: 0000000000100000 - 000000003fff0000 (usable)
Aug 20 13:45:33 genipapo kernel:  BIOS-e820: 000000003fff0000 - 000000003fff3000 (ACPI NVS)
Aug 20 13:45:33 genipapo kernel:  BIOS-e820: 000000003fff3000 - 0000000040000000 (ACPI data)
Aug 20 13:45:33 genipapo kernel:  BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
Aug 20 13:45:33 genipapo kernel:  BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
Aug 20 13:45:33 genipapo kernel:  BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
Aug 20 13:45:33 genipapo kernel: 0MB HIGHMEM available.
Aug 20 13:45:33 genipapo kernel: 1023MB LOWMEM available.
Aug 20 13:45:33 genipapo syslog: klogd startup succeeded
Aug 20 13:45:33 genipapo kernel: ACPI: S3 and PAE do not like each other for now, S3 disabled.
Aug 20 13:45:33 genipapo kernel: found SMP MP-table at 000f5610
Aug 20 13:45:33 genipapo kernel: DMI 2.3 present.
Aug 20 13:45:33 genipapo kernel: Using APIC driver default
Aug 20 13:45:33 genipapo kernel: ACPI: RSDP (v000 VIA694                                    ) @ 0x000f6f60
Aug 20 13:45:33 genipapo kernel: ACPI: RSDT (v001 VIA694 AWRDACPI 0x42302e31 AWRD 0x00000000) @ 0x3fff3000
Aug 20 13:45:33 genipapo kernel: ACPI: FADT (v001 VIA694 AWRDACPI 0x42302e31 AWRD 0x00000000) @ 0x3fff3040
Aug 20 13:45:33 genipapo kernel: ACPI: MADT (v001 VIA694          0x00000000  0x00000000) @ 0x3fff56c0
Aug 20 13:45:33 genipapo kernel: ACPI: DSDT (v001 VIA694 AWRDACPI 0x00001000 MSFT 0x0100000c) @ 0x00000000
Aug 20 13:45:33 genipapo kernel: ACPI: PM-Timer IO Port: 0x4008
Aug 20 13:45:33 genipapo kernel: ES7000: did not find Unisys ACPI OEM table!
Aug 20 13:45:33 genipapo kernel: ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
Aug 20 13:45:33 genipapo kernel: Processor #0 6:8 APIC version 17
Aug 20 13:45:33 genipapo kernel: ACPI: LAPIC (acpi_id[0x01] lapic_id[0x01] enabled)
Aug 20 13:45:33 genipapo kernel: Processor #1 6:8 APIC version 17
Aug 20 13:45:33 genipapo kernel: ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])
Aug 20 13:45:33 genipapo irqbalance: irqbalance startup succeeded
Aug 20 13:45:33 genipapo kernel: IOAPIC[0]: Assigned apic_id 2
Aug 20 13:45:33 genipapo kernel: IOAPIC[0]: apic_id 2, version 17, address 0xfec00000, GSI 0-23
Aug 20 13:45:33 genipapo kernel: ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
Aug 20 13:45:33 genipapo kernel: ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 dfl dfl)
Aug 20 13:45:33 genipapo kernel: Enabling APIC mode:  Flat.  Using 1 I/O APICs
Aug 20 13:45:33 genipapo kernel: Using ACPI (MADT) for SMP configuration information
Aug 20 13:45:33 genipapo kernel: Built 1 zonelists
Aug 20 13:45:33 genipapo kernel: Kernel command line: ro root=LABEL=/ vga=ext 
Aug 20 13:45:33 genipapo kernel: mapped 4G/4G trampoline to fffeb000.
Aug 20 13:45:33 genipapo kernel: Initializing CPU#0
Aug 20 13:45:33 genipapo kernel: CPU 0 irqstacks, hard=023eb000 soft=023cb000
Aug 20 13:45:33 genipapo kernel: PID hash table entries: 4096 (order 12: 32768 bytes)
Aug 20 13:45:33 genipapo kernel: Detected 1134.660 MHz processor.
Aug 20 13:45:33 genipapo kernel: Using tsc for high-res timesource
Aug 20 13:45:33 genipapo kernel: Console: colour VGA+ 80x50
Aug 20 13:45:33 genipapo kernel: Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Aug 20 13:45:33 genipapo kernel: Inode-cache hash table entries: 131072 (order: 7, 524288 bytes)
Aug 20 13:45:33 genipapo kernel: Memory: 1033604k/1048512k available (1896k kernel code, 14112k reserved, 736k data, 176k init, 0k highmem)
Aug 20 13:45:33 genipapo kernel: Calibrating delay loop... 2228.22 BogoMIPS
Aug 20 13:45:33 genipapo kernel: Security Scaffold v1.0.0 initialized
Aug 20 13:45:33 genipapo kernel: SELinux:  Initializing.
Aug 20 13:45:33 genipapo kernel: SELinux:  Starting in permissive mode
Aug 20 13:45:33 genipapo kernel: There is already a security framework initialized, register_security failed.
Aug 20 13:45:33 genipapo kernel: selinux_register_security:  Registering secondary module capability
Aug 20 13:45:33 genipapo kernel: Capability LSM initialized as secondary
Aug 20 13:45:33 genipapo kernel: Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
Aug 20 13:45:33 genipapo kernel: CPU: L1 I cache: 16K, L1 D cache: 16K
Aug 20 13:45:33 genipapo kernel: CPU: L2 cache: 256K
Aug 20 13:45:33 genipapo kernel: CPU serial number disabled.
Aug 20 13:45:33 genipapo kernel: Intel machine check architecture supported.
Aug 20 13:45:33 genipapo kernel: Intel machine check reporting enabled on CPU#0.
Aug 20 13:45:33 genipapo kernel: Enabling fast FPU save and restore... done.
Aug 20 13:45:33 genipapo kernel: Enabling unmasked SIMD FPU exception support... done.
Aug 20 13:45:33 genipapo kernel: Checking 'hlt' instruction... OK.
Aug 20 13:45:33 genipapo kernel: CPU0: Intel Pentium III (Coppermine) stepping 0a
Aug 20 13:45:33 genipapo kernel: per-CPU timeslice cutoff: 731.81 usecs.
Aug 20 13:45:33 genipapo kernel: task migration cache decay timeout: 1 msecs.
Aug 20 13:45:33 genipapo kernel: enabled ExtINT on CPU#0
Aug 20 13:45:33 genipapo kernel: ESR value before enabling vector: 00000000
Aug 20 13:45:33 genipapo kernel: ESR value after enabling vector: 00000000
Aug 20 13:45:33 genipapo kernel: Booting processor 1/1 eip 2000
Aug 20 13:45:33 genipapo kernel: CPU 1 irqstacks, hard=023ec000 soft=023cc000
Aug 20 13:45:33 genipapo kernel: Initializing CPU#1
Aug 20 13:45:33 genipapo kernel: masked ExtINT on CPU#1
Aug 20 13:45:33 genipapo kernel: ESR value before enabling vector: 00000000
Aug 20 13:45:33 genipapo kernel: ESR value after enabling vector: 00000000
Aug 20 13:45:33 genipapo kernel: Calibrating delay loop... 2260.99 BogoMIPS
Aug 20 13:45:33 genipapo kernel: CPU: L1 I cache: 16K, L1 D cache: 16K
Aug 20 13:45:33 genipapo kernel: CPU: L2 cache: 256K
Aug 20 13:45:33 genipapo kernel: CPU serial number disabled.
Aug 20 13:45:33 genipapo kernel: Intel machine check architecture supported.
Aug 20 13:45:33 genipapo kernel: Intel machine check reporting enabled on CPU#1.
Aug 20 13:45:34 genipapo kernel: CPU1: Intel Pentium III (Coppermine) stepping 0a
Aug 20 13:45:34 genipapo kernel: Total of 2 processors activated (4489.21 BogoMIPS).
Aug 20 13:45:34 genipapo kernel: ENABLING IO-APIC IRQs
Aug 20 13:45:34 genipapo kernel: ..TIMER: vector=0x31 pin1=2 pin2=-1
Aug 20 13:45:34 genipapo kernel: Using local APIC timer interrupts.
Aug 20 13:45:34 genipapo kernel: calibrating APIC timer ...
Aug 20 13:45:34 genipapo kernel: ..... CPU clock speed is 1134.0300 MHz.
Aug 20 13:45:34 genipapo kernel: ..... host bus clock speed is 103.0118 MHz.
Aug 20 13:45:34 genipapo kernel: checking TSC synchronization across 2 CPUs: passed.
Aug 20 13:45:34 genipapo kernel: Brought up 2 CPUs
Aug 20 13:45:34 genipapo kernel: zapping low mappings.
Aug 20 13:45:34 genipapo kernel: checking if image is initramfs...it isn't (no cpio magic); looks like an initrd
Aug 20 13:45:34 genipapo kernel: Freeing initrd memory: 189k freed
Aug 20 13:45:34 genipapo kernel: NET: Registered protocol family 16
Aug 20 13:45:34 genipapo kernel: PCI: PCI BIOS revision 2.10 entry at 0xfb370, last bus=1
Aug 20 13:45:34 genipapo kernel: PCI: Using configuration type 1
Aug 20 13:45:34 genipapo kernel: mtrr: v2.0 (20020519)
Aug 20 13:45:34 genipapo kernel: mtrr: your CPUs had inconsistent fixed MTRR settings
Aug 20 13:45:34 genipapo kernel: mtrr: your CPUs had inconsistent variable MTRR settings
Aug 20 13:45:34 genipapo kernel: mtrr: probably your BIOS does not setup all CPUs.
Aug 20 13:45:34 genipapo kernel: mtrr: corrected configuration.
Aug 20 13:45:34 genipapo kernel: ACPI: Subsystem revision 20040326
Aug 20 13:45:34 genipapo kernel: ACPI: Interpreter enabled
Aug 20 13:45:34 genipapo kernel: ACPI: Using IOAPIC for interrupt routing
Aug 20 13:45:34 genipapo kernel: ACPI: PCI Root Bridge [PCI0] (00:00)
Aug 20 13:45:34 genipapo kernel: PCI: Probing PCI hardware (bus 00)
Aug 20 13:45:34 genipapo kernel: ACPI: PCI Interrupt Link [LNKA] (IRQs 1 3 4 5 6 7 *10 11 12 14 15)
Aug 20 13:45:34 genipapo kernel: ACPI: PCI Interrupt Link [LNKB] (IRQs 1 3 4 *5 6 7 10 11 12 14 15)
Aug 20 13:45:34 genipapo kernel: ACPI: PCI Interrupt Link [LNKC] (IRQs 1 3 4 5 6 7 10 11 12 14 15) *0, disabled.
Aug 20 13:45:34 genipapo kernel: ACPI: PCI Interrupt Link [LNKD] (IRQs 1 3 4 5 6 7 10 *11 12 14 15)
Aug 20 13:45:34 genipapo kernel: Linux Plug and Play Support v0.97 (c) Adam Belay
Aug 20 13:45:34 genipapo kernel: usbcore: registered new driver usbfs
Aug 20 13:45:34 genipapo kernel: usbcore: registered new driver hub
Aug 20 13:45:34 genipapo kernel: PCI: Using ACPI for IRQ routing
Aug 20 13:45:35 genipapo kernel: ACPI: PCI interrupt 0000:00:07.2[D]: no GSI - using IRQ 11
Aug 20 13:45:35 genipapo kernel: ACPI: PCI interrupt 0000:00:07.3[D]: no GSI - using IRQ 11
Aug 20 13:45:35 genipapo kernel: ACPI: PCI interrupt 0000:00:09.0[A]: no GSI - using IRQ 10
Aug 20 13:45:35 genipapo kernel: ACPI: PCI interrupt 0000:00:0a.0[A]: no GSI - using IRQ 5
Aug 20 13:45:35 genipapo kernel: ACPI: PCI interrupt 0000:00:0c.0[A]: no GSI - using IRQ 11
Aug 20 13:45:35 genipapo kernel: ACPI: PCI interrupt 0000:01:00.0[A]: no GSI - using IRQ 10
Aug 20 13:45:35 genipapo kernel: testing the IO APIC.......................
Aug 20 13:45:32 genipapo network: Bringing up interface eth0:  succeeded 
Aug 20 13:45:32 genipapo ifup-cipcb: cipcb started for cipcb0 
Aug 20 13:45:32 genipapo ciped-cb[1122]: CIPE daemon vers 1.4.5 (c) Olaf Titz 1996-2000 
Aug 20 13:45:32 genipapo network: Bringing up interface cipcb0:  succeeded 
Aug 20 13:45:38 genipapo kernel: Using vector-based indexing
Aug 20 13:45:38 genipapo kernel: .................................... done.
Aug 20 13:45:38 genipapo kernel: vesafb: probe of vesafb0 failed with error -6
Aug 20 13:45:38 genipapo kernel: apm: BIOS version 1.2 Flags 0x07 (Driver version 1.16ac)
Aug 20 13:45:38 genipapo kernel: apm: disabled - APM is not SMP safe.
Aug 20 13:45:38 genipapo kernel: audit: initializing netlink socket (disabled)
Aug 20 13:45:38 genipapo kernel: audit(1093020291.274:0): initialized
Aug 20 13:45:38 genipapo kernel: Total HugeTLB memory allocated, 0
Aug 20 13:45:38 genipapo kernel: VFS: Disk quotas dquot_6.5.1
Aug 20 13:45:38 genipapo kernel: Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
Aug 20 13:45:38 genipapo kernel: SELinux:  Registering netfilter hooks
Aug 20 13:45:38 genipapo kernel: Initializing Cryptographic API
Aug 20 13:45:38 genipapo kernel: ksign: Installing public key data
Aug 20 13:45:38 genipapo kernel: Loading keyring
Aug 20 13:45:38 genipapo kernel: - Added public key 9488DB81FF525AA3
Aug 20 13:45:38 genipapo kernel: - User ID: Red Hat, Inc. (Kernel Module GPG key)
Aug 20 13:45:39 genipapo kernel: ksign: invalid packet (ctb=00)
Aug 20 13:45:39 genipapo kernel: Unable to load default keyring: error=74
Aug 20 13:45:39 genipapo kernel: PCI: Enabling Via external APIC routing
Aug 20 13:45:39 genipapo kernel: pci_hotplug: PCI Hot Plug PCI Core version: 0.5
Aug 20 13:45:39 genipapo kernel: ACPI: Processor [CPU] (supports C1)
Aug 20 13:45:39 genipapo kernel: ACPI: Processor [CPU1] (supports C1)
Aug 20 13:45:39 genipapo kernel: isapnp: Scanning for PnP cards...
Aug 20 13:45:39 genipapo kernel: isapnp: No Plug & Play device found
Aug 20 13:45:39 genipapo kernel: Real Time Clock Driver v1.12
Aug 20 13:45:39 genipapo kernel: Linux agpgart interface v0.100 (c) Dave Jones
Aug 20 13:45:40 genipapo kernel: agpgart: Detected VIA Apollo Pro 133 chipset
Aug 20 13:45:40 genipapo kernel: agpgart: Maximum main memory to use for agp memory: 941M
Aug 20 13:45:40 genipapo kernel: agpgart: AGP aperture is 64M @ 0xd0000000
Aug 20 13:45:40 genipapo kernel: Serial: 8250/16550 driver $Revision: 1.90 $ 8 ports, IRQ sharing enabled
Aug 20 13:45:40 genipapo kernel: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
Aug 20 13:45:40 genipapo kernel: ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
Aug 20 13:45:40 genipapo kernel: RAMDISK driver initialized: 16 RAM disks of 16384K size 1024 blocksize
Aug 20 13:45:40 genipapo kernel: Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
Aug 20 13:45:40 genipapo kernel: ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
Aug 20 13:45:41 genipapo kernel: VP_IDE: IDE controller at PCI slot 0000:00:07.1
Aug 20 13:45:41 genipapo kernel: VP_IDE: chipset revision 6
Aug 20 13:45:41 genipapo kernel: VP_IDE: not 100%% native mode: will probe irqs later
Aug 20 13:45:41 genipapo kernel: VP_IDE: VIA vt82c686b (rev 40) IDE UDMA100 controller on pci0000:00:07.1
Aug 20 13:45:41 genipapo kernel:     ide0: BM-DMA at 0xd000-0xd007, BIOS settings: hda:DMA, hdb:DMA
Aug 20 13:45:41 genipapo kernel:     ide1: BM-DMA at 0xd008-0xd00f, BIOS settings: hdc:DMA, hdd:pio
Aug 20 13:45:41 genipapo kernel: hda: Maxtor 4D040H2, ATA DISK drive
Aug 20 13:45:41 genipapo kernel: hdb: ST310232A, ATA DISK drive
Aug 20 13:45:41 genipapo kernel: Using cfq io scheduler
Aug 20 13:45:41 genipapo kernel: ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Aug 20 13:45:41 genipapo kernel: hdc: HL-DT-ST GCE-8520B, ATAPI CD/DVD-ROM drive
Aug 20 13:45:41 genipapo kernel: hdd: IOMEGA ZIP 100 ATAPI, ATAPI FLOPPY drive
Aug 20 13:45:41 genipapo kernel: ide1 at 0x170-0x177,0x376 on irq 15
Aug 20 13:45:41 genipapo kernel: hda: max request size: 128KiB
Aug 20 13:45:41 genipapo kernel: hda: 80043264 sectors (40982 MB) w/2048KiB Cache, CHS=65535/16/63, UDMA(100)
Aug 20 13:45:41 genipapo kernel:  hda: hda1 hda2 hda3
Aug 20 13:45:41 genipapo kernel: hdb: max request size: 128KiB
Aug 20 13:45:41 genipapo kernel: hdb: 20005650 sectors (10242 MB) w/512KiB Cache, CHS=19846/16/63, UDMA(66)
Aug 20 13:45:41 genipapo kernel:  hdb: hdb1
Aug 20 13:45:41 genipapo kernel: hdc: ATAPI 40X CD-ROM CD-R/RW drive, 2048kB Cache, UDMA(33)
Aug 20 13:45:41 genipapo kernel: Uniform CD-ROM driver Revision: 3.20
Aug 20 13:45:41 genipapo kernel: ide-floppy driver 0.99.newide
Aug 20 13:45:42 genipapo kernel: hdd: No disk in drive
Aug 20 13:45:42 genipapo kernel: hdd: 98304kB, 32/64/96 CHS, 4096 kBps, 512 sector size, 2941 rpm
Aug 20 13:45:42 genipapo kernel: usbcore: registered new driver hiddev
Aug 20 13:45:42 genipapo kernel: usbcore: registered new driver usbhid
Aug 20 13:45:42 genipapo kernel: drivers/usb/input/hid-core.c: v2.0:USB HID core driver
Aug 20 13:45:42 genipapo kernel: mice: PS/2 mouse device common for all mice
Aug 20 13:45:42 genipapo kernel: serio: i8042 AUX port at 0x60,0x64 irq 12
Aug 20 13:45:42 genipapo kernel: input: ImPS/2 Generic Wheel Mouse on isa0060/serio1
Aug 20 13:45:42 genipapo kernel: serio: i8042 KBD port at 0x60,0x64 irq 1
Aug 20 13:45:42 genipapo kernel: input: AT Translated Set 2 keyboard on isa0060/serio0
Aug 20 13:45:42 genipapo kernel: md: md driver 0.90.0 MAX_MD_DEVS=256, MD_SB_DISKS=27
Aug 20 13:45:42 genipapo kernel: NET: Registered protocol family 2
Aug 20 13:45:42 genipapo kernel: IP: routing cache hash table of 4096 buckets, 64Kbytes
Aug 20 13:45:42 genipapo kernel: TCP: Hash tables configured (established 131072 bind 43690)
Aug 20 13:45:42 genipapo kernel: Initializing IPsec netlink socket
Aug 20 13:45:42 genipapo kernel: NET: Registered protocol family 1
Aug 20 13:45:42 genipapo kernel: NET: Registered protocol family 17
Aug 20 13:45:42 genipapo kernel: ACPI: (supports S0 S1 S4 S5)
Aug 20 13:45:42 genipapo kernel: md: Autodetecting RAID arrays.
Aug 20 13:45:42 genipapo kernel: md: autorun ...
Aug 20 13:45:42 genipapo kernel: md: ... autorun DONE.
Aug 20 13:45:42 genipapo kernel: RAMDISK: Compressed image found at block 0
Aug 20 13:45:42 genipapo kernel: VFS: Mounted root (ext2 filesystem).
Aug 20 13:45:42 genipapo kernel: kjournald starting.  Commit interval 5 seconds
Aug 20 13:45:42 genipapo kernel: EXT3-fs: mounted filesystem with ordered data mode.
Aug 20 13:45:42 genipapo kernel: Freeing unused kernel memory: 176k freed
Aug 20 13:45:42 genipapo kernel: ACPI: Power Button (FF) [PWRF]
Aug 20 13:45:42 genipapo kernel: USB Universal Host Controller Interface driver v2.2
Aug 20 13:45:42 genipapo kernel: ACPI: PCI interrupt 0000:00:07.2[D]: no GSI - using IRQ 11
Aug 20 13:45:42 genipapo kernel: uhci_hcd 0000:00:07.2: UHCI Host Controller
Aug 20 13:45:42 genipapo kernel: uhci_hcd 0000:00:07.2: irq 11, io base 0000d400
Aug 20 13:45:42 genipapo kernel: uhci_hcd 0000:00:07.2: new USB bus registered, assigned bus number 1
Aug 20 13:45:42 genipapo kernel: hub 1-0:1.0: USB hub found
Aug 20 13:45:42 genipapo kernel: hub 1-0:1.0: 2 ports detected
Aug 20 13:45:43 genipapo kernel: ACPI: PCI interrupt 0000:00:07.3[D]: no GSI - using IRQ 11
Aug 20 13:45:43 genipapo kernel: uhci_hcd 0000:00:07.3: UHCI Host Controller
Aug 20 13:45:43 genipapo kernel: uhci_hcd 0000:00:07.3: irq 11, io base 0000d800
Aug 20 13:45:43 genipapo kernel: uhci_hcd 0000:00:07.3: new USB bus registered, assigned bus number 2
Aug 20 13:45:43 genipapo kernel: hub 2-0:1.0: USB hub found
Aug 20 13:45:43 genipapo kernel: hub 2-0:1.0: 2 ports detected
Aug 20 13:45:43 genipapo kernel: EXT3 FS on hda2, internal journal
Aug 20 13:45:43 genipapo kernel: device-mapper: 4.1.0-ioctl (2003-12-10) initialised: dm@uk.sistina.com
Aug 20 13:45:43 genipapo kernel: cdrom: open failed.
Aug 20 13:45:43 genipapo kernel: ide-floppy: hdd: I/O error, pc =  0, key =  2, asc = 3a, ascq =  0
Aug 20 13:45:43 genipapo kernel: ide-floppy: hdd: I/O error, pc = 1b, key =  2, asc = 3a, ascq =  0
Aug 20 13:45:43 genipapo kernel: hdd: No disk in drive
Aug 20 13:45:43 genipapo kernel: Adding 2097136k swap on /dev/hda3.  Priority:-1 extents:1
Aug 20 13:45:43 genipapo kernel: kjournald starting.  Commit interval 5 seconds
Aug 20 13:45:43 genipapo kernel: EXT3-fs warning: mounting fs with errors, running e2fsck is recommended
Aug 20 13:45:43 genipapo kernel: EXT3 FS on hda1, internal journal
Aug 20 13:45:43 genipapo kernel: EXT3-fs: mounted filesystem with ordered data mode.
Aug 20 13:45:43 genipapo kernel: kjournald starting.  Commit interval 5 seconds
Aug 20 13:45:43 genipapo kernel: EXT3-fs warning: mounting fs with errors, running e2fsck is recommended
Aug 20 13:45:43 genipapo kernel: EXT3 FS on hdb1, internal journal
Aug 20 13:45:43 genipapo kernel: EXT3-fs: mounted filesystem with ordered data mode.
Aug 20 13:45:43 genipapo kernel: IA-32 Microcode Update Driver: v1.14 <tigran@veritas.com>
Aug 20 13:45:43 genipapo kernel: microcode: CPU1 updated from revision 0x0 to 0x1, date = 11022000 
Aug 20 13:45:43 genipapo kernel: microcode: CPU0 updated from revision 0x0 to 0x1, date = 11022000 
Aug 20 13:45:43 genipapo kernel: parport0: PC-style at 0x378 (0x778) [PCSPP,TRISTATE]
Aug 20 13:45:43 genipapo kernel: parport_pc: Via 686A parallel port: io=0x378
Aug 20 13:45:43 genipapo kernel: SCSI subsystem initialized
Aug 20 13:45:43 genipapo kernel: inserting floppy driver for 2.6.8-1.521smp
Aug 20 13:45:43 genipapo kernel: Floppy drive(s): fd0 is 1.44M
Aug 20 13:45:43 genipapo kernel: FDC 0 is a post-1991 82077
Aug 20 13:45:43 genipapo kernel: 8139too Fast Ethernet driver 0.9.27
Aug 20 13:45:43 genipapo kernel: ACPI: PCI interrupt 0000:00:0c.0[A]: no GSI - using IRQ 11
Aug 20 13:45:43 genipapo kernel: eth0: RealTek RTL8139 at 0xe400, 00:00:1c:d9:a7:51, IRQ 11
Aug 20 13:45:43 genipapo kernel: via-rhine.c:v1.10-LK1.1.20-2.6 May-23-2004 Written by Donald Becker
Aug 20 13:45:43 genipapo kernel: ACPI: PCI interrupt 0000:00:09.0[A]: no GSI - using IRQ 10
Aug 20 13:45:44 genipapo kernel: eth1: VIA Rhine III at 0xd8000000, 00:e0:7d:f7:d1:b1, IRQ 10.
Aug 20 13:45:44 genipapo kernel: eth1: MII PHY found at address 1, status 0x7849 advertising 05e1 Link 0000.
Aug 20 13:45:44 genipapo kernel: ip_tables: (C) 2000-2002 Netfilter core team
Aug 20 13:45:44 genipapo kernel: 8139too Fast Ethernet driver 0.9.27
Aug 20 13:45:44 genipapo kernel: ACPI: PCI interrupt 0000:00:0c.0[A]: no GSI - using IRQ 11
Aug 20 13:45:44 genipapo kernel: eth0: RealTek RTL8139 at 0xe400, 00:00:1c:d9:a7:51, IRQ 11
Aug 20 13:45:44 genipapo kernel: ip_tables: (C) 2000-2002 Netfilter core team
Aug 20 13:45:44 genipapo kernel: eth0: link up, 100Mbps, full-duplex, lpa 0x45E1
Aug 20 13:45:44 genipapo kernel: NETDEV WATCHDOG: eth0: transmit timed out
Aug 20 13:45:44 genipapo kernel: eth0: link up, 100Mbps, full-duplex, lpa 0x45E1
Aug 20 13:45:51 genipapo rpcidmapd: rpc.idmapd startup succeeded
Aug 20 13:45:51 genipapo random: Initializing random number generator:  succeeded
Aug 20 13:45:52 genipapo rc: Starting pcmcia:  succeeded
Aug 20 13:45:52 genipapo netfs: Mounting other filesystems:  succeeded
Aug 20 13:45:53 genipapo kernel: NET: Registered protocol family 10
Aug 20 13:45:53 genipapo kernel: Disabled Privacy Extensions on device 02343560(lo)
Aug 20 13:45:53 genipapo kernel: IPv6 over IPv4 tunneling driver
Aug 20 13:45:53 genipapo sshd:  succeeded
Aug 20 13:45:53 genipapo xinetd: xinetd startup succeeded
Aug 20 13:45:53 genipapo xinetd[1291]: Server /usr/lib/ppr/lib/lprsrv is not executable [file=/etc/xinetd.d/ppr] [line=12]
Aug 20 13:45:53 genipapo xinetd[1291]: Error parsing attribute server - DISABLING SERVICE [file=/etc/xinetd.d/ppr] [line=12]
Aug 20 13:45:53 genipapo xinetd[1291]: bad service attribute: disabled [file=/etc/xinetd.d/ppr] [line=15]
Aug 20 13:45:53 genipapo xinetd[1291]: Unknown user: pprwww [file=/etc/xinetd.d/ppr] [line=24]
Aug 20 13:45:53 genipapo xinetd[1291]: Error parsing attribute user - DISABLING SERVICE [file=/etc/xinetd.d/ppr] [line=24]
Aug 20 13:45:53 genipapo xinetd[1291]: Server /usr/lib/ppr/lib/ppr-httpd is not executable [file=/etc/xinetd.d/ppr] [line=25]
Aug 20 13:45:53 genipapo xinetd[1291]: Error parsing attribute server - DISABLING SERVICE [file=/etc/xinetd.d/ppr] [line=25]
Aug 20 13:45:53 genipapo xinetd[1291]: bad service attribute: disabled [file=/etc/xinetd.d/ppr] [line=27]
Aug 20 13:45:54 genipapo xinetd[1291]: xinetd Version 2.3.13 started with libwrap loadavg options compiled in.
Aug 20 13:45:54 genipapo xinetd[1291]: Started working: 1 available service
Aug 20 13:46:06 genipapo kernel: NETDEV WATCHDOG: eth0: transmit timed out
Aug 20 13:46:06 genipapo kernel: eth0: link up, 100Mbps, full-duplex, lpa 0x45E1
Aug 20 13:46:18 genipapo kernel: NETDEV WATCHDOG: eth0: transmit timed out
Aug 20 13:46:18 genipapo kernel: eth0: link up, 100Mbps, full-duplex, lpa 0x45E1
Aug 20 13:46:30 genipapo kernel: NETDEV WATCHDOG: eth0: transmit timed out
Aug 20 13:46:30 genipapo kernel: eth0: link up, 100Mbps, full-duplex, lpa 0x45E1
Aug 20 13:46:33 genipapo ntpdate[1300]: can't find host clock.redhat.com 
Aug 20 13:46:33 genipapo ntpdate[1300]: no servers can be used, exiting
Aug 20 13:46:33 genipapo ntpd:  failed
Aug 20 13:46:33 genipapo ntpd[1304]: ntpd 4.2.0@1.1161-r Thu Mar 11 11:46:39 EST 2004 (1)
Aug 20 13:46:33 genipapo ntpd: ntpd startup succeeded
Aug 20 13:46:33 genipapo ntpd[1304]: precision = 4.000 usec
Aug 20 13:46:33 genipapo ntpd[1304]: kernel time sync status 0040
Aug 20 13:46:34 genipapo ntpd[1304]: frequency initialized 137.554 PPM from /var/lib/ntp/drift
Aug 20 13:46:34 genipapo ntpd[1304]: configure: keyword "authenticate" unknown, line ignored
Aug 20 13:46:42 genipapo kernel: NETDEV WATCHDOG: eth0: transmit timed out
Aug 20 13:46:42 genipapo kernel: eth0: link up, 100Mbps, full-duplex, lpa 0x45E1
Aug 20 13:46:54 genipapo kernel: NETDEV WATCHDOG: eth0: transmit timed out
Aug 20 13:46:54 genipapo kernel: eth0: link up, 100Mbps, full-duplex, lpa 0x45E1
Aug 20 13:47:06 genipapo kernel: NETDEV WATCHDOG: eth0: transmit timed out
Aug 20 13:47:06 genipapo kernel: eth0: link up, 100Mbps, full-duplex, lpa 0x45E1
Aug 20 13:47:18 genipapo kernel: NETDEV WATCHDOG: eth0: transmit timed out
Aug 20 13:47:18 genipapo kernel: eth0: link up, 100Mbps, full-duplex, lpa 0x45E1
Aug 20 13:47:30 genipapo kernel: NETDEV WATCHDOG: eth0: transmit timed out
Aug 20 13:47:30 genipapo kernel: eth0: link up, 100Mbps, full-duplex, lpa 0x45E1
Aug 20 13:47:42 genipapo kernel: NETDEV WATCHDOG: eth0: transmit timed out
Aug 20 13:47:42 genipapo kernel: eth0: link up, 100Mbps, full-duplex, lpa 0x45E1
Aug 20 13:47:54 genipapo kernel: NETDEV WATCHDOG: eth0: transmit timed out
Aug 20 13:47:54 genipapo kernel: eth0: link up, 100Mbps, full-duplex, lpa 0x45E1
Aug 20 13:48:06 genipapo kernel: NETDEV WATCHDOG: eth0: transmit timed out
Aug 20 13:48:06 genipapo kernel: eth0: link up, 100Mbps, full-duplex, lpa 0x45E1
Aug 20 13:48:18 genipapo kernel: NETDEV WATCHDOG: eth0: transmit timed out
Aug 20 13:48:18 genipapo kernel: eth0: link up, 100Mbps, full-duplex, lpa 0x45E1
Aug 20 13:48:30 genipapo kernel: NETDEV WATCHDOG: eth0: transmit timed out
Aug 20 13:48:30 genipapo kernel: eth0: link up, 100Mbps, full-duplex, lpa 0x45E1
Aug 20 13:48:42 genipapo kernel: NETDEV WATCHDOG: eth0: transmit timed out
Aug 20 13:48:42 genipapo kernel: eth0: link up, 100Mbps, full-duplex, lpa 0x45E1
Aug 20 13:48:54 genipapo kernel: NETDEV WATCHDOG: eth0: transmit timed out
Aug 20 13:48:54 genipapo kernel: eth0: link up, 100Mbps, full-duplex, lpa 0x45E1
Aug 20 13:49:06 genipapo kernel: NETDEV WATCHDOG: eth0: transmit timed out
Aug 20 13:49:06 genipapo kernel: eth0: link up, 100Mbps, full-duplex, lpa 0x45E1
Aug 20 13:49:18 genipapo kernel: NETDEV WATCHDOG: eth0: transmit timed out
Aug 20 13:49:18 genipapo kernel: eth0: link up, 100Mbps, full-duplex, lpa 0x45E1
Aug 20 13:49:30 genipapo kernel: NETDEV WATCHDOG: eth0: transmit timed out
Aug 20 13:49:30 genipapo kernel: eth0: link up, 100Mbps, full-duplex, lpa 0x45E1
Aug 20 13:49:42 genipapo kernel: NETDEV WATCHDOG: eth0: transmit timed out
Aug 20 13:49:42 genipapo kernel: eth0: link up, 100Mbps, full-duplex, lpa 0x45E1
Aug 20 13:49:54 genipapo kernel: NETDEV WATCHDOG: eth0: transmit timed out
Aug 20 13:49:54 genipapo kernel: eth0: link up, 100Mbps, full-duplex, lpa 0x45E1
Aug 20 13:50:06 genipapo kernel: NETDEV WATCHDOG: eth0: transmit timed out
Aug 20 13:50:06 genipapo kernel: eth0: link up, 100Mbps, full-duplex, lpa 0x45E1
Aug 20 13:50:18 genipapo kernel: NETDEV WATCHDOG: eth0: transmit timed out
Aug 20 13:50:18 genipapo kernel: eth0: link up, 100Mbps, full-duplex, lpa 0x45E1
Aug 20 13:50:30 genipapo kernel: NETDEV WATCHDOG: eth0: transmit timed out
Aug 20 13:50:30 genipapo kernel: eth0: link up, 100Mbps, full-duplex, lpa 0x45E1
Aug 20 13:50:42 genipapo kernel: NETDEV WATCHDOG: eth0: transmit timed out
Aug 20 13:50:42 genipapo kernel: eth0: link up, 100Mbps, full-duplex, lpa 0x45E1
Aug 20 13:50:54 genipapo kernel: NETDEV WATCHDOG: eth0: transmit timed out
Aug 20 13:50:54 genipapo kernel: eth0: link up, 100Mbps, full-duplex, lpa 0x45E1
Aug 20 13:51:06 genipapo kernel: NETDEV WATCHDOG: eth0: transmit timed out
Aug 20 13:51:06 genipapo kernel: eth0: link up, 100Mbps, full-duplex, lpa 0x45E1
Aug 20 13:51:18 genipapo kernel: NETDEV WATCHDOG: eth0: transmit timed out
Aug 20 13:51:18 genipapo kernel: eth0: link up, 100Mbps, full-duplex, lpa 0x45E1
Aug 20 13:51:30 genipapo kernel: NETDEV WATCHDOG: eth0: transmit timed out
Aug 20 13:51:30 genipapo kernel: eth0: link up, 100Mbps, full-duplex, lpa 0x45E1
Aug 20 13:51:42 genipapo kernel: NETDEV WATCHDOG: eth0: transmit timed out
Aug 20 13:51:42 genipapo kernel: eth0: link up, 100Mbps, full-duplex, lpa 0x45E1
Aug 20 13:51:54 genipapo kernel: NETDEV WATCHDOG: eth0: transmit timed out
Aug 20 13:51:54 genipapo kernel: eth0: link up, 100Mbps, full-duplex, lpa 0x45E1
Aug 20 13:51:54 genipapo sendmail: sendmail startup succeeded
Aug 20 13:52:06 genipapo kernel: NETDEV WATCHDOG: eth0: transmit timed out
Aug 20 13:52:06 genipapo kernel: eth0: link up, 100Mbps, full-duplex, lpa 0x45E1
Aug 20 13:52:18 genipapo kernel: NETDEV WATCHDOG: eth0: transmit timed out
Aug 20 13:52:18 genipapo kernel: eth0: link up, 100Mbps, full-duplex, lpa 0x45E1
Aug 20 13:52:30 genipapo kernel: NETDEV WATCHDOG: eth0: transmit timed out
Aug 20 13:52:30 genipapo kernel: eth0: link up, 100Mbps, full-duplex, lpa 0x45E1
Aug 20 13:52:42 genipapo kernel: NETDEV WATCHDOG: eth0: transmit timed out
Aug 20 13:52:42 genipapo kernel: eth0: link up, 100Mbps, full-duplex, lpa 0x45E1
Aug 20 13:52:54 genipapo kernel: NETDEV WATCHDOG: eth0: transmit timed out
Aug 20 13:52:54 genipapo kernel: eth0: link up, 100Mbps, full-duplex, lpa 0x45E1
Aug 20 13:53:06 genipapo kernel: NETDEV WATCHDOG: eth0: transmit timed out
Aug 20 13:53:06 genipapo kernel: eth0: link up, 100Mbps, full-duplex, lpa 0x45E1
Aug 20 13:53:18 genipapo kernel: NETDEV WATCHDOG: eth0: transmit timed out
Aug 20 13:53:18 genipapo kernel: eth0: link up, 100Mbps, full-duplex, lpa 0x45E1
Aug 20 13:53:30 genipapo kernel: NETDEV WATCHDOG: eth0: transmit timed out
Aug 20 13:53:30 genipapo kernel: eth0: link up, 100Mbps, full-duplex, lpa 0x45E1
Aug 20 13:53:42 genipapo kernel: NETDEV WATCHDOG: eth0: transmit timed out
Aug 20 13:53:42 genipapo kernel: eth0: link up, 100Mbps, full-duplex, lpa 0x45E1
Aug 20 13:53:54 genipapo kernel: NETDEV WATCHDOG: eth0: transmit timed out
Aug 20 13:53:54 genipapo kernel: eth0: link up, 100Mbps, full-duplex, lpa 0x45E1
Aug 20 13:54:06 genipapo kernel: NETDEV WATCHDOG: eth0: transmit timed out
Aug 20 13:54:06 genipapo kernel: eth0: link up, 100Mbps, full-duplex, lpa 0x45E1
Aug 20 13:54:09 genipapo shutdown: shutting down for system reboot
Aug 20 13:54:09 genipapo init: Switching to runlevel: 6
Aug 20 13:54:10 genipapo sshd: sshd -TERM succeeded
Aug 20 13:54:10 genipapo sendmail: sendmail shutdown succeeded
Aug 20 13:54:10 genipapo sendmail: sm-client shutdown failed
Aug 20 13:54:10 genipapo xinetd[1291]: Exiting...
Aug 20 13:54:11 genipapo xinetd: xinetd shutdown succeeded
Aug 20 13:54:11 genipapo ntpd[1304]: ntpd exiting on signal 15
Aug 20 13:54:11 genipapo ntpd: ntpd shutdown succeeded
Aug 20 13:54:11 genipapo dd: 1+0 records in
Aug 20 13:54:11 genipapo dd: 1+0 records out
Aug 20 13:54:11 genipapo random: Saving random seed:  succeeded
Aug 20 13:54:11 genipapo kernel: Kernel logging (proc) stopped.
Aug 20 13:54:11 genipapo kernel: Kernel log daemon terminating.
Aug 20 13:54:12 genipapo syslog: klogd shutdown succeeded
Aug 20 13:54:12 genipapo exiting on signal 15
--------------------------------------------------------------------------------
Non-SMP Kernel:
--------------------------------------------------------------------------------
Aug 20 14:16:57 genipapo syslogd 1.4.1: restart.
Aug 20 14:16:57 genipapo syslog: syslogd startup succeeded
Aug 20 14:16:57 genipapo syslog: klogd startup succeeded
Aug 20 14:16:57 genipapo kernel: klogd 1.4.1, log source = /proc/kmsg started.
Aug 20 14:16:57 genipapo kernel: Linux version 2.6.8-1.521 (bhcompile@tweety.build.redhat.com) (gcc version 3.3.3 20040412 (Red Hat Linux 3.3.3-7)) #1 Mon Aug 16 09:01:18 EDT 2004
Aug 20 14:16:57 genipapo kernel: BIOS-provided physical RAM map:
Aug 20 14:16:57 genipapo kernel:  BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
Aug 20 14:16:57 genipapo kernel:  BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
Aug 20 14:16:57 genipapo kernel:  BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
Aug 20 14:16:57 genipapo kernel:  BIOS-e820: 0000000000100000 - 000000003fff0000 (usable)
Aug 20 14:16:57 genipapo kernel:  BIOS-e820: 000000003fff0000 - 000000003fff3000 (ACPI NVS)
Aug 20 14:16:57 genipapo kernel:  BIOS-e820: 000000003fff3000 - 0000000040000000 (ACPI data)
Aug 20 14:16:57 genipapo kernel:  BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
Aug 20 14:16:57 genipapo kernel:  BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
Aug 20 14:16:57 genipapo kernel:  BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
Aug 20 14:16:57 genipapo kernel: 0MB HIGHMEM available.
Aug 20 14:16:57 genipapo irqbalance: irqbalance startup succeeded
Aug 20 14:16:57 genipapo kernel: 1023MB LOWMEM available.
Aug 20 14:16:57 genipapo kernel: zapping low mappings.
Aug 20 14:16:57 genipapo kernel: DMI 2.3 present.
Aug 20 14:16:57 genipapo kernel: ACPI: RSDP (v000 VIA694                                    ) @ 0x000f6f60
Aug 20 14:16:57 genipapo kernel: ACPI: RSDT (v001 VIA694 AWRDACPI 0x42302e31 AWRD 0x00000000) @ 0x3fff3000
Aug 20 14:16:57 genipapo kernel: ACPI: FADT (v001 VIA694 AWRDACPI 0x42302e31 AWRD 0x00000000) @ 0x3fff3040
Aug 20 14:16:57 genipapo kernel: ACPI: MADT (v001 VIA694          0x00000000  0x00000000) @ 0x3fff56c0
Aug 20 14:16:57 genipapo kernel: ACPI: DSDT (v001 VIA694 AWRDACPI 0x00001000 MSFT 0x0100000c) @ 0x00000000
Aug 20 14:16:57 genipapo kernel: ACPI: PM-Timer IO Port: 0x4008
Aug 20 14:16:57 genipapo kernel: Built 1 zonelists
Aug 20 14:16:57 genipapo kernel: Kernel command line: ro root=LABEL=/ vga=ext 
Aug 20 14:16:57 genipapo kernel: mapped 4G/4G trampoline to ffff3000.
Aug 20 14:16:57 genipapo kernel: Initializing CPU#0
Aug 20 14:16:57 genipapo kernel: CPU 0 irqstacks, hard=023c7000 soft=023c6000
Aug 20 14:16:57 genipapo kernel: PID hash table entries: 4096 (order 12: 32768 bytes)
Aug 20 14:16:57 genipapo kernel: Detected 1134.636 MHz processor.
Aug 20 14:16:57 genipapo kernel: Using tsc for high-res timesource
Aug 20 14:16:57 genipapo kernel: Console: colour VGA+ 80x50
Aug 20 14:16:57 genipapo kernel: Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Aug 20 14:16:57 genipapo kernel: Inode-cache hash table entries: 131072 (order: 7, 524288 bytes)
Aug 20 14:16:57 genipapo kernel: Memory: 1034960k/1048512k available (2012k kernel code, 12772k reserved, 651k data, 140k init, 0k highmem)
Aug 20 14:16:57 genipapo kernel: Calibrating delay loop... 2228.22 BogoMIPS
Aug 20 14:16:57 genipapo kernel: Security Scaffold v1.0.0 initialized
Aug 20 14:16:57 genipapo kernel: SELinux:  Initializing.
Aug 20 14:16:57 genipapo kernel: SELinux:  Starting in permissive mode
Aug 20 14:16:57 genipapo kernel: There is already a security framework initialized, register_security failed.
Aug 20 14:16:58 genipapo kernel: selinux_register_security:  Registering secondary module capability
Aug 20 14:16:58 genipapo kernel: Capability LSM initialized as secondary
Aug 20 14:16:58 genipapo kernel: Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
Aug 20 14:16:58 genipapo kernel: CPU: L1 I cache: 16K, L1 D cache: 16K
Aug 20 14:16:58 genipapo kernel: CPU: L2 cache: 256K
Aug 20 14:16:58 genipapo kernel: CPU serial number disabled.
Aug 20 14:16:58 genipapo kernel: Intel machine check architecture supported.
Aug 20 14:16:58 genipapo kernel: Intel machine check reporting enabled on CPU#0.
Aug 20 14:16:58 genipapo kernel: CPU: Intel Pentium III (Coppermine) stepping 0a
Aug 20 14:16:58 genipapo kernel: Enabling fast FPU save and restore... done.
Aug 20 14:16:58 genipapo kernel: Enabling unmasked SIMD FPU exception support... done.
Aug 20 14:16:58 genipapo kernel: Checking 'hlt' instruction... OK.
Aug 20 14:16:58 genipapo kernel: checking if image is initramfs...it isn't (no cpio magic); looks like an initrd
Aug 20 14:16:58 genipapo kernel: Freeing initrd memory: 191k freed
Aug 20 14:16:58 genipapo kernel: NET: Registered protocol family 16
Aug 20 14:16:58 genipapo kernel: PCI: PCI BIOS revision 2.10 entry at 0xfb370, last bus=1
Aug 20 14:16:58 genipapo kernel: PCI: Using configuration type 1
Aug 20 14:16:58 genipapo kernel: mtrr: v2.0 (20020519)
Aug 20 14:16:58 genipapo kernel: ACPI: Subsystem revision 20040326
Aug 20 14:16:58 genipapo kernel: ACPI: IRQ9 SCI: Level Trigger.
Aug 20 14:16:58 genipapo kernel: ACPI: Interpreter enabled
Aug 20 14:16:58 genipapo kernel: ACPI: Using PIC for interrupt routing
Aug 20 14:16:58 genipapo kernel: ACPI: PCI Root Bridge [PCI0] (00:00)
Aug 20 14:16:58 genipapo kernel: PCI: Probing PCI hardware (bus 00)
Aug 20 14:16:58 genipapo kernel: ACPI: PCI Interrupt Link [LNKA] (IRQs 1 3 4 5 6 7 *10 11 12 14 15)
Aug 20 14:16:58 genipapo kernel: ACPI: PCI Interrupt Link [LNKB] (IRQs 1 3 4 *5 6 7 10 11 12 14 15)
Aug 20 14:16:58 genipapo kernel: ACPI: PCI Interrupt Link [LNKC] (IRQs 1 3 4 5 6 7 10 11 12 14 15) *0, disabled.
Aug 20 14:16:58 genipapo kernel: ACPI: PCI Interrupt Link [LNKD] (IRQs 1 3 4 5 6 7 10 *11 12 14 15)
Aug 20 14:16:58 genipapo kernel: Linux Plug and Play Support v0.97 (c) Adam Belay
Aug 20 14:16:58 genipapo kernel: usbcore: registered new driver usbfs
Aug 20 14:16:58 genipapo kernel: usbcore: registered new driver hub
Aug 20 14:16:58 genipapo kernel: PCI: Using ACPI for IRQ routing
Aug 20 14:16:58 genipapo kernel: ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 11
Aug 20 14:16:58 genipapo kernel: ACPI: PCI interrupt 0000:00:07.2[D] -> GSI 11 (level, low) -> IRQ 11
Aug 20 14:16:58 genipapo kernel: ACPI: PCI interrupt 0000:00:07.3[D] -> GSI 11 (level, low) -> IRQ 11
Aug 20 14:16:58 genipapo kernel: ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 10
Aug 20 14:16:58 genipapo kernel: ACPI: PCI interrupt 0000:00:09.0[A] -> GSI 10 (level, low) -> IRQ 10
Aug 20 14:16:58 genipapo kernel: ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 5
Aug 20 14:16:58 genipapo kernel: ACPI: PCI interrupt 0000:00:0a.0[A] -> GSI 5 (level, low) -> IRQ 5
Aug 20 14:16:58 genipapo kernel: ACPI: PCI interrupt 0000:00:0c.0[A] -> GSI 11 (level, low) -> IRQ 11
Aug 20 14:16:58 genipapo kernel: ACPI: PCI interrupt 0000:01:00.0[A] -> GSI 10 (level, low) -> IRQ 10
Aug 20 14:16:58 genipapo kernel: vesafb: probe of vesafb0 failed with error -6
Aug 20 14:16:58 genipapo kernel: apm: BIOS version 1.2 Flags 0x07 (Driver version 1.16ac)
Aug 20 14:16:58 genipapo kernel: apm: overridden by ACPI.
Aug 20 14:16:58 genipapo kernel: audit: initializing netlink socket (disabled)
Aug 20 14:16:58 genipapo kernel: audit(1093022169.4294967294:0): initialized
Aug 20 14:16:58 genipapo kernel: Total HugeTLB memory allocated, 0
Aug 20 14:16:58 genipapo kernel: VFS: Disk quotas dquot_6.5.1
Aug 20 14:16:58 genipapo kernel: Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
Aug 20 14:16:58 genipapo kernel: SELinux:  Registering netfilter hooks
Aug 20 14:16:58 genipapo kernel: Initializing Cryptographic API
Aug 20 14:16:58 genipapo kernel: ksign: Installing public key data
Aug 20 14:16:58 genipapo kernel: Loading keyring
Aug 20 14:16:58 genipapo kernel: - Added public key 9488DB81FF525AA3
Aug 20 14:16:58 genipapo kernel: - User ID: Red Hat, Inc. (Kernel Module GPG key)
Aug 20 14:16:58 genipapo kernel: ksign: invalid packet (ctb=00)
Aug 20 14:16:58 genipapo kernel: Unable to load default keyring: error=74
Aug 20 14:16:58 genipapo kernel: pci_hotplug: PCI Hot Plug PCI Core version: 0.5
Aug 20 14:16:58 genipapo kernel: ACPI: Processor [CPU] (supports C1)
Aug 20 14:16:58 genipapo kernel: isapnp: Scanning for PnP cards...
Aug 20 14:16:58 genipapo kernel: isapnp: No Plug & Play device found
Aug 20 14:16:58 genipapo kernel: Real Time Clock Driver v1.12
Aug 20 14:16:58 genipapo kernel: Linux agpgart interface v0.100 (c) Dave Jones
Aug 20 14:16:58 genipapo kernel: agpgart: Detected VIA Apollo Pro 133 chipset
Aug 20 14:16:58 genipapo kernel: agpgart: Maximum main memory to use for agp memory: 941M
Aug 20 14:16:58 genipapo kernel: agpgart: AGP aperture is 64M @ 0xd0000000
Aug 20 14:16:58 genipapo kernel: Serial: 8250/16550 driver $Revision: 1.90 $ 8 ports, IRQ sharing enabled
Aug 20 14:16:58 genipapo kernel: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
Aug 20 14:16:59 genipapo kernel: ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
Aug 20 14:16:59 genipapo kernel: RAMDISK driver initialized: 16 RAM disks of 16384K size 1024 blocksize
Aug 20 14:16:59 genipapo kernel: Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
Aug 20 14:16:59 genipapo kernel: ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
Aug 20 14:16:59 genipapo kernel: VP_IDE: IDE controller at PCI slot 0000:00:07.1
Aug 20 14:16:59 genipapo kernel: VP_IDE: chipset revision 6
Aug 20 14:16:59 genipapo kernel: VP_IDE: not 100%% native mode: will probe irqs later
Aug 20 14:16:54 genipapo network: Setting network parameters:  succeeded 
Aug 20 14:16:59 genipapo kernel: VP_IDE: VIA vt82c686b (rev 40) IDE UDMA100 controller on pci0000:00:07.1
Aug 20 14:16:54 genipapo network: Bringing up loopback interface:  succeeded 
Aug 20 14:17:00 genipapo kernel:     ide0: BM-DMA at 0xd000-0xd007, BIOS settings: hda:DMA, hdb:DMA
Aug 20 14:17:00 genipapo kernel:     ide1: BM-DMA at 0xd008-0xd00f, BIOS settings: hdc:DMA, hdd:pio
Aug 20 14:17:00 genipapo kernel: hda: Maxtor 4D040H2, ATA DISK drive
Aug 20 14:17:00 genipapo kernel: hdb: ST310232A, ATA DISK drive
Aug 20 14:17:00 genipapo kernel: Using cfq io scheduler
Aug 20 14:17:00 genipapo kernel: ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Aug 20 14:17:00 genipapo kernel: hdc: HL-DT-ST GCE-8520B, ATAPI CD/DVD-ROM drive
Aug 20 14:17:00 genipapo kernel: hdd: IOMEGA ZIP 100 ATAPI, ATAPI FLOPPY drive
Aug 20 14:17:00 genipapo kernel: ide1 at 0x170-0x177,0x376 on irq 15
Aug 20 14:17:00 genipapo kernel: hda: max request size: 128KiB
Aug 20 14:17:00 genipapo kernel: hda: 80043264 sectors (40982 MB) w/2048KiB Cache, CHS=65535/16/63, UDMA(100)
Aug 20 14:17:00 genipapo kernel:  hda: hda1 hda2 hda3
Aug 20 14:17:00 genipapo kernel: hdb: max request size: 128KiB
Aug 20 14:17:00 genipapo kernel: hdb: 20005650 sectors (10242 MB) w/512KiB Cache, CHS=19846/16/63, UDMA(66)
Aug 20 14:17:00 genipapo kernel:  hdb: hdb1
Aug 20 14:17:00 genipapo kernel: hdc: ATAPI 40X CD-ROM CD-R/RW drive, 2048kB Cache, UDMA(33)
Aug 20 14:17:00 genipapo kernel: Uniform CD-ROM driver Revision: 3.20
Aug 20 14:17:00 genipapo kernel: ide-floppy driver 0.99.newide
Aug 20 14:17:01 genipapo kernel: hdd: No disk in drive
Aug 20 14:17:01 genipapo kernel: hdd: 98304kB, 32/64/96 CHS, 4096 kBps, 512 sector size, 2941 rpm
Aug 20 14:17:01 genipapo kernel: usbcore: registered new driver hiddev
Aug 20 14:17:01 genipapo kernel: usbcore: registered new driver usbhid
Aug 20 14:17:01 genipapo kernel: drivers/usb/input/hid-core.c: v2.0:USB HID core driver
Aug 20 14:17:01 genipapo kernel: mice: PS/2 mouse device common for all mice
Aug 20 14:17:01 genipapo kernel: serio: i8042 AUX port at 0x60,0x64 irq 12
Aug 20 14:17:01 genipapo kernel: input: ImPS/2 Generic Wheel Mouse on isa0060/serio1
Aug 20 14:17:01 genipapo kernel: serio: i8042 KBD port at 0x60,0x64 irq 1
Aug 20 14:17:01 genipapo kernel: input: AT Translated Set 2 keyboard on isa0060/serio0
Aug 20 14:17:01 genipapo kernel: md: md driver 0.90.0 MAX_MD_DEVS=256, MD_SB_DISKS=27
Aug 20 14:17:01 genipapo kernel: NET: Registered protocol family 2
Aug 20 14:17:01 genipapo kernel: IP: routing cache hash table of 2048 buckets, 64Kbytes
Aug 20 14:17:01 genipapo kernel: TCP: Hash tables configured (established 262144 bind 37449)
Aug 20 14:17:01 genipapo kernel: Initializing IPsec netlink socket
Aug 20 14:17:01 genipapo kernel: NET: Registered protocol family 1
Aug 20 14:17:01 genipapo kernel: NET: Registered protocol family 17
Aug 20 14:17:01 genipapo kernel: ACPI: (supports S0 S1 S4 S5)
Aug 20 14:17:01 genipapo kernel: md: Autodetecting RAID arrays.
Aug 20 14:17:01 genipapo kernel: md: autorun ...
Aug 20 14:17:01 genipapo kernel: md: ... autorun DONE.
Aug 20 14:17:01 genipapo kernel: RAMDISK: Compressed image found at block 0
Aug 20 14:17:01 genipapo kernel: VFS: Mounted root (ext2 filesystem).
Aug 20 14:17:01 genipapo kernel: kjournald starting.  Commit interval 5 seconds
Aug 20 14:17:01 genipapo kernel: EXT3-fs: mounted filesystem with ordered data mode.
Aug 20 14:17:01 genipapo kernel: Freeing unused kernel memory: 140k freed
Aug 20 14:17:01 genipapo kernel: ACPI: Power Button (FF) [PWRF]
Aug 20 14:17:01 genipapo kernel: USB Universal Host Controller Interface driver v2.2
Aug 20 14:17:01 genipapo kernel: ACPI: PCI interrupt 0000:00:07.2[D] -> GSI 11 (level, low) -> IRQ 11
Aug 20 14:17:01 genipapo kernel: uhci_hcd 0000:00:07.2: UHCI Host Controller
Aug 20 14:17:01 genipapo kernel: uhci_hcd 0000:00:07.2: irq 11, io base 0000d400
Aug 20 14:17:01 genipapo kernel: uhci_hcd 0000:00:07.2: new USB bus registered, assigned bus number 1
Aug 20 14:17:01 genipapo kernel: hub 1-0:1.0: USB hub found
Aug 20 14:17:01 genipapo kernel: hub 1-0:1.0: 2 ports detected
Aug 20 14:17:01 genipapo kernel: ACPI: PCI interrupt 0000:00:07.3[D] -> GSI 11 (level, low) -> IRQ 11
Aug 20 14:17:01 genipapo kernel: uhci_hcd 0000:00:07.3: UHCI Host Controller
Aug 20 14:17:01 genipapo kernel: uhci_hcd 0000:00:07.3: irq 11, io base 0000d800
Aug 20 14:17:01 genipapo kernel: uhci_hcd 0000:00:07.3: new USB bus registered, assigned bus number 2
Aug 20 14:17:01 genipapo kernel: hub 2-0:1.0: USB hub found
Aug 20 14:17:01 genipapo kernel: hub 2-0:1.0: 2 ports detected
Aug 20 14:17:01 genipapo kernel: EXT3 FS on hda2, internal journal
Aug 20 14:17:01 genipapo kernel: device-mapper: 4.1.0-ioctl (2003-12-10) initialised: dm@uk.sistina.com
Aug 20 14:17:02 genipapo kernel: cdrom: open failed.
Aug 20 14:17:02 genipapo kernel: ide-floppy: hdd: I/O error, pc =  0, key =  2, asc = 3a, ascq =  0
Aug 20 14:17:02 genipapo kernel: ide-floppy: hdd: I/O error, pc = 1b, key =  2, asc = 3a, ascq =  0
Aug 20 14:17:02 genipapo kernel: hdd: No disk in drive
Aug 20 14:17:02 genipapo kernel: Adding 2097136k swap on /dev/hda3.  Priority:-1 extents:1
Aug 20 14:17:02 genipapo kernel: kjournald starting.  Commit interval 5 seconds
Aug 20 14:17:02 genipapo kernel: EXT3-fs warning: mounting fs with errors, running e2fsck is recommended
Aug 20 14:17:02 genipapo kernel: EXT3 FS on hda1, internal journal
Aug 20 14:17:02 genipapo kernel: EXT3-fs: mounted filesystem with ordered data mode.
Aug 20 14:17:02 genipapo kernel: kjournald starting.  Commit interval 5 seconds
Aug 20 14:17:02 genipapo kernel: EXT3-fs warning: mounting fs with errors, running e2fsck is recommended
Aug 20 14:17:02 genipapo kernel: EXT3 FS on hdb1, internal journal
Aug 20 14:17:02 genipapo kernel: EXT3-fs: mounted filesystem with ordered data mode.
Aug 20 14:17:02 genipapo kernel: IA-32 Microcode Update Driver: v1.14 <tigran@veritas.com>
Aug 20 14:17:02 genipapo kernel: microcode: CPU0 updated from revision 0x0 to 0x1, date = 11022000 
Aug 20 14:17:02 genipapo kernel: parport0: PC-style at 0x378 (0x778) [PCSPP,TRISTATE]
Aug 20 14:17:02 genipapo kernel: parport_pc: Via 686A parallel port: io=0x378
Aug 20 14:17:02 genipapo kernel: SCSI subsystem initialized
Aug 20 14:17:02 genipapo kernel: inserting floppy driver for 2.6.8-1.521
Aug 20 14:17:02 genipapo kernel: Floppy drive(s): fd0 is 1.44M
Aug 20 14:17:02 genipapo kernel: FDC 0 is a post-1991 82077
Aug 20 14:17:02 genipapo kernel: 8139too Fast Ethernet driver 0.9.27
Aug 20 14:17:02 genipapo kernel: ACPI: PCI interrupt 0000:00:0c.0[A] -> GSI 11 (level, low) -> IRQ 11
Aug 20 14:17:02 genipapo kernel: eth0: RealTek RTL8139 at 0xe400, 00:00:1c:d9:a7:51, IRQ 11
Aug 20 14:17:02 genipapo kernel: via-rhine.c:v1.10-LK1.1.20-2.6 May-23-2004 Written by Donald Becker
Aug 20 14:17:02 genipapo kernel: ACPI: PCI interrupt 0000:00:09.0[A] -> GSI 10 (level, low) -> IRQ 10
Aug 20 14:17:02 genipapo kernel: eth1: VIA Rhine III at 0xd8000000, 00:e0:7d:f7:d1:b1, IRQ 10.
Aug 20 14:17:02 genipapo kernel: eth1: MII PHY found at address 1, status 0x7849 advertising 05e1 Link 0000.
Aug 20 14:17:02 genipapo kernel: ip_tables: (C) 2000-2002 Netfilter core team
Aug 20 14:17:02 genipapo kernel: 8139too Fast Ethernet driver 0.9.27
Aug 20 14:17:02 genipapo kernel: ACPI: PCI interrupt 0000:00:0c.0[A] -> GSI 11 (level, low) -> IRQ 11
Aug 20 14:17:02 genipapo kernel: eth0: RealTek RTL8139 at 0xe400, 00:00:1c:d9:a7:51, IRQ 11
Aug 20 14:17:02 genipapo kernel: ip_tables: (C) 2000-2002 Netfilter core team
Aug 20 14:17:02 genipapo kernel: eth0: link up, 100Mbps, full-duplex, lpa 0x45E1
Aug 20 14:17:16 genipapo rpcidmapd: rpc.idmapd startup succeeded
Aug 20 14:17:16 genipapo random: Initializing random number generator:  succeeded
Aug 20 14:17:17 genipapo rc: Starting pcmcia:  succeeded
Aug 20 14:17:17 genipapo netfs: Mounting other filesystems:  succeeded
Aug 20 14:17:17 genipapo kernel: NET: Registered protocol family 10
Aug 20 14:17:17 genipapo kernel: Disabled Privacy Extensions on device 0235c2a0(lo)
Aug 20 14:17:17 genipapo kernel: IPv6 over IPv4 tunneling driver
Aug 20 14:17:18 genipapo sshd:  succeeded
Aug 20 14:17:18 genipapo xinetd: xinetd startup succeeded
Aug 20 14:17:18 genipapo xinetd[1220]: Server /usr/lib/ppr/lib/lprsrv is not executable [file=/etc/xinetd.d/ppr] [line=12]
Aug 20 14:17:18 genipapo xinetd[1220]: Error parsing attribute server - DISABLING SERVICE [file=/etc/xinetd.d/ppr] [line=12]
Aug 20 14:17:18 genipapo xinetd[1220]: bad service attribute: disabled [file=/etc/xinetd.d/ppr] [line=15]
Aug 20 14:17:18 genipapo xinetd[1220]: Unknown user: pprwww [file=/etc/xinetd.d/ppr] [line=24]
Aug 20 14:17:18 genipapo xinetd[1220]: Error parsing attribute user - DISABLING SERVICE [file=/etc/xinetd.d/ppr] [line=24]
Aug 20 14:17:18 genipapo xinetd[1220]: Server /usr/lib/ppr/lib/ppr-httpd is not executable [file=/etc/xinetd.d/ppr] [line=25]
Aug 20 14:17:18 genipapo xinetd[1220]: Error parsing attribute server - DISABLING SERVICE [file=/etc/xinetd.d/ppr] [line=25]
Aug 20 14:17:18 genipapo xinetd[1220]: bad service attribute: disabled [file=/etc/xinetd.d/ppr] [line=27]
Aug 20 14:17:18 genipapo xinetd[1220]: xinetd Version 2.3.13 started with libwrap loadavg options compiled in.
Aug 20 14:17:18 genipapo xinetd[1220]: Started working: 1 available service
Aug 20 14:17:19 genipapo ntpdate[1229]: step time server 209.132.176.4 offset -1.649732 sec
Aug 20 14:17:19 genipapo ntpd:  succeeded
Aug 20 14:17:19 genipapo ntpd[1233]: ntpd 4.2.0@1.1161-r Thu Mar 11 11:46:39 EST 2004 (1)
Aug 20 14:17:19 genipapo ntpd: ntpd startup succeeded
Aug 20 14:17:19 genipapo ntpd[1233]: precision = 1.000 usec
Aug 20 14:17:19 genipapo ntpd[1233]: kernel time sync status 0040
Aug 20 14:17:19 genipapo ntpd[1233]: frequency initialized 137.554 PPM from /var/lib/ntp/drift
Aug 20 14:17:19 genipapo ntpd[1233]: configure: keyword "authenticate" unknown, line ignored
Aug 20 14:17:20 genipapo sendmail: sendmail startup succeeded
Aug 20 14:17:20 genipapo sendmail: sm-client startup succeeded
Aug 20 14:17:20 genipapo gpm[1270]: *** info [startup.c(95)]: 
Aug 20 14:17:20 genipapo gpm[1270]: Started gpm successfully. Entered daemon mode.
Aug 20 14:17:20 genipapo gpm[1270]: *** info [mice.c(1766)]: 
Aug 20 14:17:20 genipapo gpm[1270]: imps2: Auto-detected intellimouse PS/2
Aug 20 14:17:20 genipapo gpm: gpm startup succeeded
Aug 20 14:17:21 genipapo crond: crond startup succeeded
Aug 20 14:17:24 genipapo kernel: parport0: PC-style at 0x378 (0x778) [PCSPP,TRISTATE]
Aug 20 14:17:24 genipapo kernel: parport_pc: Via 686A parallel port: io=0x378
Aug 20 14:17:24 genipapo kernel: lp0: using parport0 (polling).
Aug 20 14:17:24 genipapo kernel: lp0: console ready
Aug 20 14:17:29 genipapo cups: cupsd startup succeeded
Aug 20 14:17:31 genipapo xfs: xfs startup succeeded
Aug 20 14:17:32 genipapo xfs: ignoring font path element /usr/X11R6/lib/X11/fonts/cyrillic (unreadable) 
Aug 20 14:17:32 genipapo xfs: ignoring font path element /usr/X11R6/lib/X11/fonts/CID (unreadable) 
Aug 20 14:17:32 genipapo xfs: ignoring font path element /usr/X11R6/lib/X11/fonts/local (unreadable) 
Aug 20 14:17:32 genipapo xfs: ignoring font path element /usr/X11R6/lib/X11/fonts/latin2/Type1 (unreadable) 
Aug 20 14:17:32 genipapo xfs: ignoring font path element /usr/share/AbiSuite/fonts (unreadable) 
Aug 20 14:17:32 genipapo smb: smbd startup succeeded
Aug 20 14:17:33 genipapo nmbd[1538]: [2004/08/20 14:17:33, 0] lib/util_sock.c:open_socket_in(691) 
Aug 20 14:17:33 genipapo nmbd[1538]:   bind failed on port 137 socket_addr = 192.168.1.1. 
Aug 20 14:17:33 genipapo nmbd[1538]:   Error = Cannot assign requested address 
Aug 20 14:17:33 genipapo nmbd[1538]: [2004/08/20 14:17:33, 0] nmbd/nmbd_subnetdb.c:make_subnet(126) 
Aug 20 14:17:33 genipapo nmbd[1538]: nmbd_subnetdb:make_subnet() 
Aug 20 14:17:33 genipapo nmbd[1538]:   Failed to open nmb socket on interface 192.168.1.1 
Aug 20 14:17:33 genipapo nmbd[1538]: for port 137.  
Aug 20 14:17:33 genipapo nmbd[1538]: Error was Cannot assign requested address 
Aug 20 14:17:33 genipapo nmbd[1538]: [2004/08/20 14:17:33, 0] nmbd/nmbd.c:main(733) 
Aug 20 14:17:33 genipapo nmbd[1538]:   ERROR: Failed when creating subnet lists. Exiting. 
Aug 20 14:17:33 genipapo smb: nmbd startup succeeded
Aug 20 14:17:33 genipapo anacron: anacron startup succeeded
Aug 20 14:17:33 genipapo atd: atd startup succeeded
Aug 20 14:17:33 genipapo readahead: Starting background readahead: 
Aug 20 14:17:33 genipapo rc: Starting readahead:  succeeded
Aug 20 14:17:34 genipapo messagebus: messagebus startup succeeded
Aug 20 14:17:35 genipapo kernel: warning: process `update' used the obsolete bdflush system call
Aug 20 14:17:35 genipapo kernel: Fix your initscripts?
Aug 20 14:17:40 genipapo kernel: warning: process `update' used the obsolete bdflush system call
Aug 20 14:17:40 genipapo kernel: Fix your initscripts?
Aug 20 14:17:54 genipapo kernel: nvidia: module license 'NVIDIA' taints kernel.
Aug 20 14:17:54 genipapo kernel: ACPI: PCI interrupt 0000:01:00.0[A] -> GSI 10 (level, low) -> IRQ 10
Aug 20 14:17:54 genipapo kernel: NVRM: loading NVIDIA Linux x86 NVIDIA Kernel Module  1.0-6111  Tue Jul 27 07:55:38 PDT 2004
Aug 20 14:17:54 genipapo kernel: agpgart: Found an AGP 2.0 compliant device at 0000:00:00.0.
Aug 20 14:17:54 genipapo kernel: agpgart: Putting AGP V2 device at 0000:00:00.0 into 4x mode
Aug 20 14:17:54 genipapo kernel: agpgart: Putting AGP V2 device at 0000:01:00.0 into 4x mode
Aug 20 14:17:55 genipapo kernel: agpgart: Found an AGP 2.0 compliant device at 0000:00:00.0.
Aug 20 14:17:55 genipapo kernel: agpgart: Putting AGP V2 device at 0000:00:00.0 into 2x mode
Aug 20 14:17:55 genipapo kernel: agpgart: Putting AGP V2 device at 0000:01:00.0 into 2x mode
Aug 20 14:18:21 genipapo kde(pam_unix)[1747]: session opened for user mroberto by (uid=0)
Aug 20 14:18:36 genipapo kernel: ACPI: PCI interrupt 0000:00:0a.0[A] -> GSI 5 (level, low) -> IRQ 5


