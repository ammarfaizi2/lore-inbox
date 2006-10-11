Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030799AbWJKFOh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030799AbWJKFOh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Oct 2006 01:14:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932420AbWJKFOh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Oct 2006 01:14:37 -0400
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:12141 "EHLO
	pd5mo3so.prod.shaw.ca") by vger.kernel.org with ESMTP
	id S932425AbWJKFOf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Oct 2006 01:14:35 -0400
Date: Tue, 10 Oct 2006 23:13:12 -0600
From: Robert Hancock <hancockr@shaw.ca>
Subject: do_IRQ:No irq handler for vector (was 2.6.19-rc1-mm1)
In-reply-to: <fa.YBZBpW3yb4mb+4lGvOyPjn9n3BE@ifi.uio.no>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Message-id: <452C7D68.8010200@shaw.ca>
MIME-version: 1.0
Content-type: multipart/mixed; boundary="Boundary_(ID_z7LowFyEnnRY+akGVOBtIg)"
References: <fa.YBZBpW3yb4mb+4lGvOyPjn9n3BE@ifi.uio.no>
User-Agent: Thunderbird 1.5.0.7 (Windows/20060909)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

--Boundary_(ID_z7LowFyEnnRY+akGVOBtIg)
Content-type: text/plain; charset=ISO-8859-1; format=flowed
Content-transfer-encoding: 7BIT

Andrew Morton wrote:
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.19-rc1/2.6.19-rc1-mm1/

Seeing some strange behavior on my box with 2.6.19-rc1-mm1 on Fedora 
Core 5. (This also has my sata_nv ADMA patch applied, but I doubt it is 
related.) About 30 seconds or so after I finish logging into X, I get this:

do_IRQ: 0.105 No irq handler for vector

and then shortly thereafter, my USB keyboard/mouse start acting 
strangely - keypresses get missed or doubled somehow, and mouse clicks 
don't register. Also, on my first bootup attempt, it hardlocked the box 
at this point.

2.6.19-rc1 and 2.6.18-mm3 (both also with the sata_nv ADMA patch) don't 
seem to have this problem.

Full dmesg is attached.

-- 
Robert Hancock      Saskatoon, SK, Canada
To email, remove "nospam" from hancockr@nospamshaw.ca
Home Page: http://www.roberthancock.com/


--Boundary_(ID_z7LowFyEnnRY+akGVOBtIg)
Content-type: text/plain; name=2.6.19-rc1-mm1-dmesg.txt
Content-transfer-encoding: 8BIT
Content-disposition: inline; filename=2.6.19-rc1-mm1-dmesg.txt

Oct 10 22:52:27 newcastle kernel: klogd 1.4.1, log source = /proc/kmsg started.
Oct 10 22:52:27 newcastle kernel: Linux version 2.6.19-rc1-mm1-adma (rob@newcastle.ss.shawcable.net) (gcc version 4.1.1 20060525 (Red Hat 4.1.1-1)) #1 SMP Tue Oct 10 21:38:56 CST 2006
Oct 10 22:52:27 newcastle kernel: Command line: ro root=/dev/VolGroup00/LogVol00
Oct 10 22:52:27 newcastle kernel: BIOS-provided physical RAM map:
Oct 10 22:52:27 newcastle kernel:  BIOS-e820: 0000000000000000 - 000000000009f400 (usable)
Oct 10 22:52:27 newcastle kernel:  BIOS-e820: 000000000009f400 - 00000000000a0000 (reserved)
Oct 10 22:52:27 newcastle kernel:  BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
Oct 10 22:52:27 newcastle kernel:  BIOS-e820: 0000000000100000 - 000000007fff0000 (usable)
Oct 10 22:52:27 newcastle kernel:  BIOS-e820: 000000007fff0000 - 000000007fff3000 (ACPI NVS)
Oct 10 22:52:27 newcastle kernel:  BIOS-e820: 000000007fff3000 - 0000000080000000 (ACPI data)
Oct 10 22:52:27 newcastle kernel:  BIOS-e820: 00000000e0000000 - 00000000f0000000 (reserved)
Oct 10 22:52:27 newcastle kernel:  BIOS-e820: 00000000fec00000 - 0000000100000000 (reserved)
Oct 10 22:52:27 newcastle kernel: end_pfn_map = 1048576
Oct 10 22:52:27 newcastle kernel: DMI 2.3 present.
Oct 10 22:52:27 newcastle kernel: SRAT: PXM 0 -> APIC 0 -> Node 0
Oct 10 22:52:27 newcastle kernel: SRAT: PXM 0 -> APIC 1 -> Node 0
Oct 10 22:52:27 newcastle kernel: SRAT: Node 0 PXM 0 0-a0000
Oct 10 22:52:27 newcastle kernel: SRAT: Node 0 PXM 0 0-80000000
Oct 10 22:52:27 newcastle kernel: Bootmem setup node 0 0000000000000000-000000007fff0000
Oct 10 22:52:27 newcastle kernel: Zone PFN ranges:
Oct 10 22:52:27 newcastle kernel:   DMA             0 ->     4096
Oct 10 22:52:27 newcastle kernel:   DMA32        4096 ->  1048576
Oct 10 22:52:27 newcastle kernel:   Normal    1048576 ->  1048576
Oct 10 22:52:27 newcastle kernel: early_node_map[2] active PFN ranges
Oct 10 22:52:27 newcastle kernel:     0:        0 ->      159
Oct 10 22:52:27 newcastle kernel:     0:      256 ->   524272
Oct 10 22:52:27 newcastle kernel: Nvidia board detected. Ignoring ACPI timer override.
Oct 10 22:52:27 newcastle kernel: ACPI: PM-Timer IO Port: 0x4008
Oct 10 22:52:27 newcastle kernel: ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
Oct 10 22:52:27 newcastle kernel: Processor #0 (Bootup-CPU)
Oct 10 22:52:27 newcastle kernel: ACPI: LAPIC (acpi_id[0x01] lapic_id[0x01] enabled)
Oct 10 22:52:27 newcastle kernel: Processor #1
Oct 10 22:52:27 newcastle kernel: ACPI: LAPIC_NMI (acpi_id[0x00] high edge lint[0x1])
Oct 10 22:52:27 newcastle kernel: ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x1])
Oct 10 22:52:27 newcastle kernel: ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])
Oct 10 22:52:27 newcastle kernel: IOAPIC[0]: apic_id 2, address 0xfec00000, GSI 0-23
Oct 10 22:52:27 newcastle kernel: ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
Oct 10 22:52:27 newcastle kernel: ACPI: BIOS IRQ0 pin2 override ignored.
Oct 10 22:52:28 newcastle kernel: ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
Oct 10 22:52:28 newcastle kernel: ACPI: INT_SRC_OVR (bus 0 bus_irq 14 global_irq 14 high edge)
Oct 10 22:52:28 newcastle kernel: ACPI: INT_SRC_OVR (bus 0 bus_irq 15 global_irq 15 high edge)
Oct 10 22:52:28 newcastle kernel: Setting APIC routing to physical flat
Oct 10 22:52:28 newcastle kernel: Using ACPI (MADT) for SMP configuration information
Oct 10 22:52:28 newcastle kernel: Nosave address range: 000000000009f000 - 00000000000a0000
Oct 10 22:52:28 newcastle kernel: Nosave address range: 00000000000a0000 - 00000000000f0000
Oct 10 22:52:28 newcastle kernel: Nosave address range: 00000000000f0000 - 0000000000100000
Oct 10 22:52:28 newcastle kernel: Allocating PCI resources starting at 88000000 (gap: 80000000:60000000)
Oct 10 22:52:28 newcastle kernel: SMP: Allowing 2 CPUs, 0 hotplug CPUs
Oct 10 22:52:28 newcastle kernel: PERCPU: Allocating 67456 bytes of per cpu data
Oct 10 22:52:28 newcastle kernel: Built 1 zonelists.  Total pages: 514148
Oct 10 22:52:28 newcastle kernel: Kernel command line: ro root=/dev/VolGroup00/LogVol00
Oct 10 22:52:28 newcastle kernel: Initializing CPU#0
Oct 10 22:52:28 newcastle kernel: PID hash table entries: 4096 (order: 12, 32768 bytes)
Oct 10 22:52:28 newcastle kernel: Console: colour VGA+ 80x25
Oct 10 22:52:28 newcastle kernel: Dentry cache hash table entries: 262144 (order: 9, 2097152 bytes)
Oct 10 22:52:28 newcastle kernel: Inode-cache hash table entries: 131072 (order: 8, 1048576 bytes)
Oct 10 22:52:28 newcastle kernel: Checking aperture...
Oct 10 22:52:28 newcastle kernel: CPU 0: aperture @ e30000000 size 32 MB
Oct 10 22:52:28 newcastle kernel: Aperture too small (32 MB)
Oct 10 22:52:28 newcastle kernel: No AGP bridge found
Oct 10 22:52:28 newcastle kernel: Memory: 2051260k/2097088k available (2263k kernel code, 45440k reserved, 1639k data, 336k init)
Oct 10 22:52:28 newcastle kernel: Calibrating delay using timer specific routine.. 4425.52 BogoMIPS (lpj=8851044)
Oct 10 22:52:28 newcastle kernel: Security Framework v1.0.0 initialized
Oct 10 22:52:28 newcastle kernel: SELinux:  Initializing.
Oct 10 22:52:28 newcastle kernel: SELinux:  Starting in permissive mode
Oct 10 22:52:28 newcastle kernel: selinux_register_security:  Registering secondary module capability
Oct 10 22:52:28 newcastle kernel: Capability LSM initialized as secondary
Oct 10 22:52:28 newcastle kernel: Mount-cache hash table entries: 256
Oct 10 22:52:28 newcastle kernel: CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
Oct 10 22:52:28 newcastle kernel: CPU: L2 Cache: 512K (64 bytes/line)
Oct 10 22:52:28 newcastle kernel: CPU 0/0 -> Node 0
Oct 10 22:52:28 newcastle kernel: CPU: Physical Processor ID: 0
Oct 10 22:52:28 newcastle kernel: CPU: Processor Core ID: 0
Oct 10 22:52:28 newcastle kernel: SMP alternatives: switching to UP code
Oct 10 22:52:28 newcastle kernel: ACPI: Core revision 20060707
Oct 10 22:52:28 newcastle kernel: Using local APIC timer interrupts.
Oct 10 22:52:28 newcastle kernel: result 12564563
Oct 10 22:52:28 newcastle kernel: Detected 12.564 MHz APIC timer.
Oct 10 22:52:28 newcastle kernel: SMP alternatives: switching to SMP code
Oct 10 22:52:28 newcastle kernel: Booting processor 1/2 APIC 0x1
Oct 10 22:52:28 newcastle kernel: Initializing CPU#1
Oct 10 22:52:28 newcastle kernel: Calibrating delay using timer specific routine.. 4422.96 BogoMIPS (lpj=8845938)
Oct 10 22:52:28 newcastle kernel: CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
Oct 10 22:52:28 newcastle kernel: CPU: L2 Cache: 512K (64 bytes/line)
Oct 10 22:52:28 newcastle kernel: CPU 1/1 -> Node 0
Oct 10 22:52:28 newcastle kernel: CPU: Physical Processor ID: 0
Oct 10 22:52:28 newcastle kernel: CPU: Processor Core ID: 1
Oct 10 22:52:28 newcastle kernel: AMD Athlon(tm) 64 X2 Dual Core Processor 4200+ stepping 01
Oct 10 22:52:28 newcastle kernel: CPU 1: Syncing TSC to CPU 0.
Oct 10 22:52:28 newcastle kernel: CPU 1: synchronized TSC with CPU 0 (last diff -78 cycles, maxerr 548 cycles)
Oct 10 22:52:28 newcastle kernel: Brought up 2 CPUs
Oct 10 22:52:28 newcastle kernel: testing NMI watchdog ... OK.
Oct 10 22:52:28 newcastle kernel: Disabling vsyscall due to use of PM timer
Oct 10 22:52:28 newcastle kernel: time.c: Using 3.579545 MHz WALL PM GTOD PM timer.
Oct 10 22:52:28 newcastle kernel: time.c: Detected 2211.359 MHz processor.
Oct 10 22:52:28 newcastle kernel: migration_cost=210
Oct 10 22:52:28 newcastle kernel: checking if image is initramfs... it is
Oct 10 22:52:28 newcastle kernel: Freeing initrd memory: 1906k freed
Oct 10 22:52:28 newcastle kernel: NET: Registered protocol family 16
Oct 10 22:52:28 newcastle kernel: ACPI: bus type pci registered
Oct 10 22:52:28 newcastle kernel: PCI: Using MMCONFIG at e0000000
Oct 10 22:52:28 newcastle kernel: PCI: No mmconfig possible on device 00:18
Oct 10 22:52:28 newcastle kernel: ACPI: Interpreter enabled
Oct 10 22:52:28 newcastle kernel: ACPI: Using IOAPIC for interrupt routing
Oct 10 22:52:29 newcastle kernel: ACPI: PCI Root Bridge [PCI0] (0000:00)
Oct 10 22:52:29 newcastle kernel: PCI: Transparent bridge - 0000:00:09.0
Oct 10 22:52:29 newcastle kernel: ACPI: PCI Interrupt Link [LNK1] (IRQs *3 4 5 7 9 10 11 12 14 15)
Oct 10 22:52:29 newcastle kernel: ACPI: PCI Interrupt Link [LNK2] (IRQs 3 4 5 *7 9 10 11 12 14 15)
Oct 10 22:52:29 newcastle kernel: ACPI: PCI Interrupt Link [LNK3] (IRQs 3 4 5 7 9 10 11 *12 14 15)
Oct 10 22:52:29 newcastle kernel: ACPI: PCI Interrupt Link [LNK4] (IRQs 3 4 *5 7 9 10 11 12 14 15)
Oct 10 22:52:29 newcastle kernel: ACPI: PCI Interrupt Link [LNK5] (IRQs 3 4 5 7 9 10 11 12 14 15) *0, disabled.
Oct 10 22:52:29 newcastle kernel: ACPI: PCI Interrupt Link [LUBA] (IRQs 3 4 5 7 9 10 *11 12 14 15)
Oct 10 22:52:29 newcastle kernel: ACPI: PCI Interrupt Link [LUBB] (IRQs 3 4 5 7 9 10 11 12 14 15) *0, disabled.
Oct 10 22:52:29 newcastle kernel: ACPI: PCI Interrupt Link [LMAC] (IRQs *3 4 5 7 9 10 11 12 14 15)
Oct 10 22:52:29 newcastle kernel: ACPI: PCI Interrupt Link [LACI] (IRQs 3 4 5 7 9 10 11 12 14 15) *0, disabled.
Oct 10 22:52:29 newcastle kernel: ACPI: PCI Interrupt Link [LMCI] (IRQs 3 4 5 7 9 10 11 12 14 15) *0, disabled.
Oct 10 22:52:29 newcastle kernel: ACPI: PCI Interrupt Link [LSMB] (IRQs 3 4 5 7 9 10 11 *12 14 15)
Oct 10 22:52:29 newcastle kernel: ACPI: PCI Interrupt Link [LUB2] (IRQs 3 4 5 7 9 *10 11 12 14 15)
Oct 10 22:52:29 newcastle kernel: ACPI: PCI Interrupt Link [LIDE] (IRQs 3 4 5 7 9 10 11 12 14 15) *0, disabled.
Oct 10 22:52:29 newcastle kernel: ACPI: PCI Interrupt Link [LSID] (IRQs 3 4 5 7 9 10 *11 12 14 15)
Oct 10 22:52:29 newcastle kernel: ACPI: PCI Interrupt Link [LFID] (IRQs 3 4 *5 7 9 10 11 12 14 15)
Oct 10 22:52:29 newcastle kernel: ACPI: PCI Interrupt Link [LPCA] (IRQs 3 4 5 7 9 10 11 12 14 15) *0, disabled.
Oct 10 22:52:29 newcastle kernel: ACPI: PCI Interrupt Link [APC1] (IRQs 16) *0, disabled.
Oct 10 22:52:29 newcastle kernel: ACPI: PCI Interrupt Link [APC2] (IRQs 17) *0, disabled.
Oct 10 22:52:29 newcastle kernel: ACPI: PCI Interrupt Link [APC3] (IRQs 18) *0, disabled.
Oct 10 22:52:29 newcastle kernel: ACPI: PCI Interrupt Link [APC4] (IRQs 19) *0, disabled.
Oct 10 22:52:29 newcastle kernel: ACPI: PCI Interrupt Link [APC5] (IRQs *16), disabled.
Oct 10 22:52:29 newcastle kernel: ACPI: PCI Interrupt Link [APCF] (IRQs 20 21 22 23) *0, disabled.
Oct 10 22:52:29 newcastle kernel: ACPI: PCI Interrupt Link [APCG] (IRQs 20 21 22 23) *0, disabled.
Oct 10 22:52:29 newcastle kernel: ACPI: PCI Interrupt Link [APCH] (IRQs 20 21 22 23) *0, disabled.
Oct 10 22:52:29 newcastle kernel: ACPI: PCI Interrupt Link [APCJ] (IRQs 20 21 22 23) *0, disabled.
Oct 10 22:52:29 newcastle kernel: ACPI: PCI Interrupt Link [APCK] (IRQs 20 21 22 23) *0, disabled.
Oct 10 22:52:29 newcastle kernel: ACPI: PCI Interrupt Link [APCS] (IRQs 20 21 22 23) *0, disabled.
Oct 10 22:52:29 newcastle kernel: ACPI: PCI Interrupt Link [APCL] (IRQs 20 21 22 23) *0, disabled.
Oct 10 22:52:29 newcastle kernel: ACPI: PCI Interrupt Link [APCZ] (IRQs 20 21 22 23) *0, disabled.
Oct 10 22:52:29 newcastle kernel: ACPI: PCI Interrupt Link [APSI] (IRQs 20 21 22 23) *0, disabled.
Oct 10 22:52:29 newcastle kernel: ACPI: PCI Interrupt Link [APSJ] (IRQs 20 21 22 23) *0, disabled.
Oct 10 22:52:29 newcastle kernel: ACPI: PCI Interrupt Link [APCP] (IRQs 20 21 22 23) *0, disabled.
Oct 10 22:52:29 newcastle kernel: Linux Plug and Play Support v0.97 (c) Adam Belay
Oct 10 22:52:29 newcastle kernel: pnp: PnP ACPI init
Oct 10 22:52:29 newcastle kernel: pnp: PnP ACPI: found 10 devices
Oct 10 22:52:29 newcastle kernel: usbcore: registered new interface driver usbfs
Oct 10 22:52:29 newcastle kernel: usbcore: registered new interface driver hub
Oct 10 22:52:29 newcastle kernel: usbcore: registered new device driver usb
Oct 10 22:52:29 newcastle kernel: PCI: Using ACPI for IRQ routing
Oct 10 22:52:29 newcastle kernel: PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
Oct 10 22:52:29 newcastle kernel: PCI-DMA: Disabling IOMMU.
Oct 10 22:52:29 newcastle kernel: pnp: 00:01: ioport range 0x4000-0x407f could not be reserved
Oct 10 22:52:29 newcastle kernel: pnp: 00:01: ioport range 0x4080-0x40ff has been reserved
Oct 10 22:52:29 newcastle kernel: pnp: 00:01: ioport range 0x4400-0x447f has been reserved
Oct 10 22:52:29 newcastle kernel: pnp: 00:01: ioport range 0x4480-0x44ff could not be reserved
Oct 10 22:52:29 newcastle kernel: pnp: 00:01: ioport range 0x4800-0x487f has been reserved
Oct 10 22:52:29 newcastle kernel: pnp: 00:01: ioport range 0x4880-0x48ff has been reserved
Oct 10 22:52:29 newcastle kernel: PCI: Bridge: 0000:00:09.0
Oct 10 22:52:29 newcastle kernel:   IO window: a000-afff
Oct 10 22:52:29 newcastle kernel:   MEM window: d0000000-d1ffffff
Oct 10 22:52:29 newcastle kernel:   PREFETCH window: disabled.
Oct 10 22:52:29 newcastle kernel: PCI: Bridge: 0000:00:0b.0
Oct 10 22:52:29 newcastle kernel:   IO window: disabled.
Oct 10 22:52:29 newcastle kernel:   MEM window: disabled.
Oct 10 22:52:29 newcastle kernel:   PREFETCH window: disabled.
Oct 10 22:52:29 newcastle kernel: PCI: Bridge: 0000:00:0c.0
Oct 10 22:52:29 newcastle kernel:   IO window: disabled.
Oct 10 22:52:29 newcastle kernel:   MEM window: disabled.
Oct 10 22:52:29 newcastle kernel:   PREFETCH window: disabled.
Oct 10 22:52:29 newcastle kernel: PCI: Bridge: 0000:00:0d.0
Oct 10 22:52:29 newcastle kernel:   IO window: disabled.
Oct 10 22:52:29 newcastle kernel:   MEM window: c0000000-c7ffffff
Oct 10 22:52:29 newcastle kernel:   PREFETCH window: b8000000-bfffffff
Oct 10 22:52:29 newcastle kernel: PCI: Bridge: 0000:00:0e.0
Oct 10 22:52:29 newcastle kernel:   IO window: disabled.
Oct 10 22:52:29 newcastle kernel:   MEM window: c8000000-cfffffff
Oct 10 22:52:29 newcastle kernel:   PREFETCH window: b0000000-b7ffffff
Oct 10 22:52:29 newcastle kernel: NET: Registered protocol family 2
Oct 10 22:52:29 newcastle kernel: IP route cache hash table entries: 65536 (order: 7, 524288 bytes)
Oct 10 22:52:29 newcastle kernel: TCP established hash table entries: 131072 (order: 10, 4194304 bytes)
Oct 10 22:52:29 newcastle kernel: TCP bind hash table entries: 65536 (order: 9, 2097152 bytes)
Oct 10 22:52:29 newcastle kernel: TCP: Hash tables configured (established 131072 bind 65536)
Oct 10 22:52:29 newcastle kernel: TCP reno registered
Oct 10 22:52:29 newcastle kernel: audit: initializing netlink socket (disabled)
Oct 10 22:52:29 newcastle kernel: audit(1160520729.592:1): initialized
Oct 10 22:52:29 newcastle kernel: KEVENT subsystem has been successfully registered.
Oct 10 22:52:29 newcastle kernel: KEVENT: Added callbacks for type 2.
Oct 10 22:52:29 newcastle kernel: KEVENT: Added callbacks for type 3.
Oct 10 22:52:29 newcastle kernel: Kevent poll()/select() subsystem has been initialized.
Oct 10 22:52:29 newcastle kernel: KEVENT: Added callbacks for type 0.
Oct 10 22:52:29 newcastle kernel: Total HugeTLB memory allocated, 0
Oct 10 22:52:29 newcastle kernel: VFS: Disk quotas dquot_6.5.1
Oct 10 22:52:29 newcastle kernel: Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
Oct 10 22:52:29 newcastle kernel: SELinux:  Registering netfilter hooks
Oct 10 22:52:29 newcastle kernel: io scheduler noop registered
Oct 10 22:52:29 newcastle kernel: io scheduler anticipatory registered
Oct 10 22:52:29 newcastle kernel: io scheduler deadline registered
Oct 10 22:52:29 newcastle kernel: io scheduler cfq registered (default)
Oct 10 22:52:29 newcastle kernel: PCI: Linking AER extended capability on 0000:00:0b.0
Oct 10 22:52:29 newcastle kernel: PCI: Found HT MSI mapping on 0000:00:0b.0 with capability disabled
Oct 10 22:52:30 newcastle kernel: PCI: Found HT MSI mapping on 0000:00:00.0 with capability enabled
Oct 10 22:52:30 newcastle kernel: PCI: Linking AER extended capability on 0000:00:0c.0
Oct 10 22:52:30 newcastle kernel: PCI: Found HT MSI mapping on 0000:00:0c.0 with capability disabled
Oct 10 22:52:30 newcastle kernel: PCI: Found HT MSI mapping on 0000:00:00.0 with capability enabled
Oct 10 22:52:30 newcastle kernel: PCI: Linking AER extended capability on 0000:00:0d.0
Oct 10 22:52:30 newcastle kernel: PCI: Found HT MSI mapping on 0000:00:0d.0 with capability disabled
Oct 10 22:52:30 newcastle kernel: PCI: Found HT MSI mapping on 0000:00:00.0 with capability enabled
Oct 10 22:52:30 newcastle kernel: PCI: Linking AER extended capability on 0000:00:0e.0
Oct 10 22:52:30 newcastle kernel: PCI: Found HT MSI mapping on 0000:00:0e.0 with capability disabled
Oct 10 22:52:30 newcastle kernel: PCI: Found HT MSI mapping on 0000:00:00.0 with capability enabled
Oct 10 22:52:30 newcastle kernel: pcie_portdrv_probe->Dev[005d:10de] has invalid IRQ. Check vendor BIOS
Oct 10 22:52:30 newcastle kernel: assign_interrupt_mode Found MSI capability
Oct 10 22:52:30 newcastle kernel: pcie_portdrv_probe->Dev[005d:10de] has invalid IRQ. Check vendor BIOS
Oct 10 22:52:30 newcastle kernel: assign_interrupt_mode Found MSI capability
Oct 10 22:52:30 newcastle kernel: pcie_portdrv_probe->Dev[005d:10de] has invalid IRQ. Check vendor BIOS
Oct 10 22:52:30 newcastle kernel: assign_interrupt_mode Found MSI capability
Oct 10 22:52:30 newcastle kernel: pcie_portdrv_probe->Dev[005d:10de] has invalid IRQ. Check vendor BIOS
Oct 10 22:52:30 newcastle kernel: assign_interrupt_mode Found MSI capability
Oct 10 22:52:30 newcastle kernel: pci_hotplug: PCI Hot Plug PCI Core version: 0.5
Oct 10 22:52:30 newcastle kernel: ACPI: Fan [FAN] (on)
Oct 10 22:52:30 newcastle kernel: ACPI: Thermal Zone [THRM] (40 C)
Oct 10 22:52:30 newcastle kernel: Real Time Clock Driver v1.12ac
Oct 10 22:52:30 newcastle kernel: Non-volatile memory driver v1.2
Oct 10 22:52:30 newcastle kernel: Linux agpgart interface v0.101 (c) Dave Jones
Oct 10 22:52:30 newcastle kernel: Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing enabled
Oct 10 22:52:30 newcastle kernel: RAMDISK driver initialized: 16 RAM disks of 16384K size 1024 blocksize
Oct 10 22:52:30 newcastle kernel: usbcore: registered new interface driver libusual
Oct 10 22:52:30 newcastle kernel: usbcore: registered new interface driver hiddev
Oct 10 22:52:30 newcastle kernel: usbcore: registered new interface driver usbhid
Oct 10 22:52:30 newcastle kernel: drivers/usb/input/hid-core.c: v2.6:USB HID core driver
Oct 10 22:52:30 newcastle kernel: PNP: No PS/2 controller found. Probing ports directly.
Oct 10 22:52:30 newcastle kernel: serio: i8042 KBD port at 0x60,0x64 irq 1
Oct 10 22:52:30 newcastle kernel: mice: PS/2 mouse device common for all mice
Oct 10 22:52:30 newcastle kernel: TCP cubic registered
Oct 10 22:52:30 newcastle kernel: Initializing XFRM netlink socket
Oct 10 22:52:30 newcastle kernel: NET: Registered protocol family 1
Oct 10 22:52:30 newcastle kernel: NET: Registered protocol family 17
Oct 10 22:52:30 newcastle kernel: powernow-k8: Found 2 AMD Athlon(tm) 64 X2 Dual Core Processor 4200+ processors (version 2.00.00)
Oct 10 22:52:30 newcastle kernel: powernow-k8:    0 : fid 0xe (2200 MHz), vid 0x8
Oct 10 22:52:30 newcastle kernel: powernow-k8:    1 : fid 0xc (2000 MHz), vid 0xa
Oct 10 22:52:30 newcastle kernel: powernow-k8:    2 : fid 0xa (1800 MHz), vid 0xc
Oct 10 22:52:30 newcastle kernel: powernow-k8:    3 : fid 0x2 (1000 MHz), vid 0x12
Oct 10 22:52:30 newcastle kernel: ACPI: (supports S0 S1 S3 S4 S5)
Oct 10 22:52:30 newcastle kernel: Freeing unused kernel memory: 336k freed
Oct 10 22:52:30 newcastle kernel: Write protecting the kernel read-only data: 448k
Oct 10 22:52:30 newcastle kernel: SCSI subsystem initialized
Oct 10 22:52:30 newcastle kernel: sata_nv 0000:00:07.0: Using ADMA mode
Oct 10 22:52:30 newcastle kernel: ACPI: PCI Interrupt Link [APSI] enabled at IRQ 23
Oct 10 22:52:30 newcastle kernel: ACPI: PCI Interrupt 0000:00:07.0[A] -> Link [APSI] -> GSI 23 (level, low) -> IRQ 23
Oct 10 22:52:30 newcastle kernel: ata1: SATA max UDMA/133 cmd 0xFFFFC20000004480 ctl 0xFFFFC200000044A0 bmdma 0xD800 irq 23
Oct 10 22:52:30 newcastle kernel: ata2: SATA max UDMA/133 cmd 0xFFFFC20000004580 ctl 0xFFFFC200000045A0 bmdma 0xD808 irq 23
Oct 10 22:52:30 newcastle kernel: scsi0 : sata_nv
Oct 10 22:52:30 newcastle kernel: ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
Oct 10 22:52:30 newcastle kernel: ata1.00: ATA-6, max UDMA/133, 312581808 sectors: LBA48 NCQ (depth 31/32)
Oct 10 22:52:30 newcastle kernel: ata1.00: ata1: dev 0 multi count 1
Oct 10 22:52:30 newcastle kernel: ata1.00: configured for UDMA/133
Oct 10 22:52:30 newcastle kernel: scsi1 : sata_nv
Oct 10 22:52:30 newcastle kernel: ata2: SATA link down (SStatus 0 SControl 300)
Oct 10 22:52:30 newcastle kernel: scsi 0:0:0:0: Direct-Access     ATA      ST3160827AS      3.42 PQ: 0 ANSI: 5
Oct 10 22:52:31 newcastle kernel: SCSI device sda: 312581808 512-byte hdwr sectors (160042 MB)
Oct 10 22:52:31 newcastle kernel: sda: Write Protect is off
Oct 10 22:52:31 newcastle kernel: SCSI device sda: drive cache: write back
Oct 10 22:52:31 newcastle kernel: SCSI device sda: 312581808 512-byte hdwr sectors (160042 MB)
Oct 10 22:52:31 newcastle kernel: sda: Write Protect is off
Oct 10 22:52:31 newcastle kernel: SCSI device sda: drive cache: write back
Oct 10 22:52:31 newcastle kernel:  sda: sda1
Oct 10 22:52:32 newcastle kernel: sd 0:0:0:0: Attached scsi disk sda
Oct 10 22:52:32 newcastle kernel: sata_nv 0000:00:08.0: Using ADMA mode
Oct 10 22:52:32 newcastle kernel: ACPI: PCI Interrupt Link [APSJ] enabled at IRQ 22
Oct 10 22:52:32 newcastle kernel: ACPI: PCI Interrupt 0000:00:08.0[A] -> Link [APSJ] -> GSI 22 (level, low) -> IRQ 22
Oct 10 22:52:32 newcastle kernel: ata3: SATA max UDMA/133 cmd 0xFFFFC20000006480 ctl 0xFFFFC200000064A0 bmdma 0xC400 irq 22
Oct 10 22:52:32 newcastle kernel: ata4: SATA max UDMA/133 cmd 0xFFFFC20000006580 ctl 0xFFFFC200000065A0 bmdma 0xC408 irq 22
Oct 10 22:52:32 newcastle kernel: scsi2 : sata_nv
Oct 10 22:52:32 newcastle kernel: ata3: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
Oct 10 22:52:32 newcastle kernel: ata3.00: ATA-7, max UDMA/133, 625142448 sectors: LBA48 NCQ (depth 31/32)
Oct 10 22:52:32 newcastle kernel: ata3.00: ata3: dev 0 multi count 1
Oct 10 22:52:32 newcastle kernel: ata3.00: configured for UDMA/133
Oct 10 22:52:33 newcastle kernel: scsi3 : sata_nv
Oct 10 22:52:33 newcastle kernel: ata4: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
Oct 10 22:52:33 newcastle kernel: ata4.00: ATA-6, max UDMA/133, 312581808 sectors: LBA48 NCQ (depth 31/32)
Oct 10 22:52:34 newcastle kernel: ata4.00: ata4: dev 0 multi count 1
Oct 10 22:52:34 newcastle kernel: ata4.00: configured for UDMA/133
Oct 10 22:52:34 newcastle kernel: scsi 2:0:0:0: Direct-Access     ATA      ST3320620AS      3.AA PQ: 0 ANSI: 5
Oct 10 22:52:34 newcastle kernel: SCSI device sdb: 625142448 512-byte hdwr sectors (320073 MB)
Oct 10 22:52:34 newcastle kernel: sdb: Write Protect is off
Oct 10 22:52:34 newcastle kernel: SCSI device sdb: drive cache: write back
Oct 10 22:52:35 newcastle kernel: SCSI device sdb: 625142448 512-byte hdwr sectors (320073 MB)
Oct 10 22:52:35 newcastle kernel: sdb: Write Protect is off
Oct 10 22:52:35 newcastle kernel: SCSI device sdb: drive cache: write back
Oct 10 22:52:35 newcastle kernel:  sdb: sdb1
Oct 10 22:52:35 newcastle kernel: sd 2:0:0:0: Attached scsi disk sdb
Oct 10 22:52:35 newcastle kernel: scsi 3:0:0:0: Direct-Access     ATA      ST3160827AS      3.42 PQ: 0 ANSI: 5
Oct 10 22:52:35 newcastle kernel: SCSI device sdc: 312581808 512-byte hdwr sectors (160042 MB)
Oct 10 22:52:35 newcastle kernel: sdc: Write Protect is off
Oct 10 22:52:35 newcastle kernel: SCSI device sdc: drive cache: write back
Oct 10 22:52:35 newcastle kernel: SCSI device sdc: 312581808 512-byte hdwr sectors (160042 MB)
Oct 10 22:52:35 newcastle kernel: sdc: Write Protect is off
Oct 10 22:52:35 newcastle kernel: SCSI device sdc: drive cache: write back
Oct 10 22:52:35 newcastle kernel:  sdc: sdc1 sdc2 sdc3 sdc4 < sdc5 >
Oct 10 22:52:35 newcastle kernel: sd 3:0:0:0: Attached scsi disk sdc
Oct 10 22:52:35 newcastle kernel: device-mapper: ioctl: 4.10.0-ioctl (2006-09-14) initialised: dm-devel@redhat.com
Oct 10 22:52:35 newcastle kernel: kjournald starting.  Commit interval 5 seconds
Oct 10 22:52:35 newcastle kernel: EXT3-fs: mounted filesystem with ordered data mode.
Oct 10 22:52:35 newcastle kernel: audit(1160520732.784:2): enforcing=1 old_enforcing=0 auid=4294967295
Oct 10 22:52:35 newcastle kernel: security:  3 users, 6 roles, 1481 types, 152 bools, 1 sens, 256 cats
Oct 10 22:52:35 newcastle kernel: security:  58 classes, 43474 rules
Oct 10 22:52:35 newcastle kernel: SELinux:  Completing initialization.
Oct 10 22:52:35 newcastle kernel: SELinux:  Setting up existing superblocks.
Oct 10 22:52:35 newcastle kernel: SELinux: initialized (dev dm-0, type ext3), uses xattr
Oct 10 22:52:35 newcastle kernel: SELinux: initialized (dev tmpfs, type tmpfs), uses transition SIDs
Oct 10 22:52:35 newcastle kernel: SELinux: initialized (dev debugfs, type debugfs), uses genfs_contexts
Oct 10 22:52:35 newcastle kernel: SELinux: initialized (dev selinuxfs, type selinuxfs), uses genfs_contexts
Oct 10 22:52:35 newcastle kernel: SELinux: initialized (dev mqueue, type mqueue), uses transition SIDs
Oct 10 22:52:35 newcastle kernel: SELinux: initialized (dev hugetlbfs, type hugetlbfs), uses genfs_contexts
Oct 10 22:52:35 newcastle kernel: SELinux: initialized (dev devpts, type devpts), uses transition SIDs
Oct 10 22:52:36 newcastle kernel: SELinux: initialized (dev eventpollfs, type eventpollfs), uses task SIDs
Oct 10 22:52:36 newcastle kernel: SELinux: initialized (dev inotifyfs, type inotifyfs), uses genfs_contexts
Oct 10 22:52:36 newcastle kernel: SELinux: initialized (dev tmpfs, type tmpfs), uses transition SIDs
Oct 10 22:52:36 newcastle kernel: SELinux: initialized (dev futexfs, type futexfs), uses genfs_contexts
Oct 10 22:52:36 newcastle kernel: SELinux: initialized (dev pipefs, type pipefs), uses task SIDs
Oct 10 22:52:36 newcastle kernel: SELinux: initialized (dev sockfs, type sockfs), uses task SIDs
Oct 10 22:52:36 newcastle kernel: SELinux: initialized (dev cpuset, type cpuset), not configured for labeling
Oct 10 22:52:36 newcastle kernel: SELinux: initialized (dev proc, type proc), uses genfs_contexts
Oct 10 22:52:36 newcastle kernel: SELinux: initialized (dev bdev, type bdev), uses genfs_contexts
Oct 10 22:52:36 newcastle kernel: SELinux: initialized (dev rootfs, type rootfs), uses genfs_contexts
Oct 10 22:52:36 newcastle kernel: SELinux: initialized (dev sysfs, type sysfs), uses genfs_contexts
Oct 10 22:52:36 newcastle kernel: audit(1160520733.000:3): policy loaded auid=4294967295
Oct 10 22:52:36 newcastle kernel: SELinux: initialized (dev usbfs, type usbfs), uses genfs_contexts
Oct 10 22:52:36 newcastle kernel: warning: process `date' used the removed sysctl system call
Oct 10 22:52:36 newcastle kernel: warning: process `touch' used the removed sysctl system call
Oct 10 22:52:36 newcastle kernel: i2c_adapter i2c-0: nForce2 SMBus adapter at 0x4c00
Oct 10 22:52:36 newcastle kernel: i2c_adapter i2c-1: nForce2 SMBus adapter at 0x4c40
Oct 10 22:52:36 newcastle kernel: EDAC MC: Ver: 2.0.1 Oct 10 2006
Oct 10 22:52:36 newcastle kernel: forcedeth.c: Reverse Engineered nForce ethernet driver. Version 0.57.
Oct 10 22:52:36 newcastle kernel: ACPI: PCI Interrupt Link [APCH] enabled at IRQ 21
Oct 10 22:52:36 newcastle kernel: ACPI: PCI Interrupt 0000:00:0a.0[A] -> Link [APCH] -> GSI 21 (level, low) -> IRQ 21
Oct 10 22:52:36 newcastle kernel: forcedeth: using HIGHDMA
Oct 10 22:52:36 newcastle kernel: input: PC Speaker as /class/input/input0
Oct 10 22:52:37 newcastle kernel: Linux video capture interface: v2.00
Oct 10 22:52:37 newcastle kernel: eth0: forcedeth.c: subsystem: 01043:8141 bound to 0000:00:0a.0
Oct 10 22:52:37 newcastle kernel: ata5: PATA max UDMA/133 cmd 0x1F0 ctl 0x3F6 bmdma 0xF000 irq 14
Oct 10 22:52:37 newcastle kernel: ata6: PATA max UDMA/133 cmd 0x170 ctl 0x376 bmdma 0xF008 irq 15
Oct 10 22:52:37 newcastle kernel: scsi4 : pata_amd
Oct 10 22:52:37 newcastle kernel: cx2388x v4l2 driver version 0.0.6 loaded
Oct 10 22:52:37 newcastle kernel: ata5.00: ATAPI, max UDMA/66
Oct 10 22:52:37 newcastle kernel: sd 0:0:0:0: Attached scsi generic sg0 type 0
Oct 10 22:52:37 newcastle kernel: sd 2:0:0:0: Attached scsi generic sg1 type 0
Oct 10 22:52:37 newcastle kernel: sd 3:0:0:0: Attached scsi generic sg2 type 0
Oct 10 22:52:37 newcastle kernel: ata5.00: configured for UDMA/66
Oct 10 22:52:37 newcastle kernel: scsi5 : pata_amd
Oct 10 22:52:37 newcastle kernel: ata6.00: ATAPI, max UDMA/33
Oct 10 22:52:37 newcastle kernel: Floppy drive(s): fd0 is 1.44M
Oct 10 22:52:37 newcastle kernel: FDC 0 is a post-1991 82077
Oct 10 22:52:37 newcastle kernel: ata6.00: configured for UDMA/33
Oct 10 22:52:37 newcastle kernel: scsi 4:0:0:0: CD-ROM            LITE-ON  DVDRW SHM-165H6S HS0E PQ: 0 ANSI: 5
Oct 10 22:52:37 newcastle kernel: scsi 4:0:0:0: Attached scsi generic sg3 type 5
Oct 10 22:52:37 newcastle kernel: scsi 5:0:0:0: CD-ROM            LITE-ON  CD-RW SOHR-5238S 4S09 PQ: 0 ANSI: 5
Oct 10 22:52:37 newcastle kernel: scsi 5:0:0:0: Attached scsi generic sg4 type 5
Oct 10 22:52:37 newcastle kernel: EDAC MC0: Giving out device to k8_edac Athlon64/Opteron: DEV 0000:00:18.2
Oct 10 22:52:37 newcastle kernel: ACPI: PCI Interrupt Link [APC3] enabled at IRQ 18
Oct 10 22:52:37 newcastle kernel: ACPI: PCI Interrupt 0000:05:08.0[A] -> Link [APC3] -> GSI 18 (level, low) -> IRQ 18
Oct 10 22:52:38 newcastle kernel: CORE cx88[0]: subsystem: 0000:0000, board: MSI TV-@nywhere [card=13,insmod option]
Oct 10 22:52:38 newcastle kernel: TV tuner 33 at 0x1fe, Radio tuner -1 at 0x1fe
Oct 10 22:52:38 newcastle kernel: ACPI: PCI Interrupt Link [APCL] enabled at IRQ 20
Oct 10 22:52:38 newcastle kernel: ACPI: PCI Interrupt 0000:00:02.1[B] -> Link [APCL] -> GSI 20 (level, low) -> IRQ 20
Oct 10 22:52:38 newcastle kernel: ehci_hcd 0000:00:02.1: EHCI Host Controller
Oct 10 22:52:38 newcastle kernel: ehci_hcd 0000:00:02.1: new USB bus registered, assigned bus number 1
Oct 10 22:52:38 newcastle kernel: ehci_hcd 0000:00:02.1: debug port 1
Oct 10 22:52:38 newcastle kernel: ehci_hcd 0000:00:02.1: irq 20, io mem 0xfeb00000
Oct 10 22:52:38 newcastle kernel: ehci_hcd 0000:00:02.1: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
Oct 10 22:52:38 newcastle kernel: usb usb1: new device found, idVendor=0000, idProduct=0000
Oct 10 22:52:38 newcastle kernel: usb usb1: new device strings: Mfr=3, Product=2, SerialNumber=1
Oct 10 22:52:38 newcastle kernel: usb usb1: Product: EHCI Host Controller
Oct 10 22:52:38 newcastle kernel: usb usb1: Manufacturer: Linux 2.6.19-rc1-mm1-adma ehci_hcd
Oct 10 22:52:38 newcastle kernel: usb usb1: SerialNumber: 0000:00:02.1
Oct 10 22:52:38 newcastle kernel: usb usb1: configuration #1 chosen from 1 choice
Oct 10 22:52:38 newcastle kernel: hub 1-0:1.0: USB hub found
Oct 10 22:52:38 newcastle kernel: hub 1-0:1.0: 10 ports detected
Oct 10 22:52:39 newcastle kernel: tveeprom 2-0050: Huh, no eeprom present (err=-121)?
Oct 10 22:52:39 newcastle kernel: cx88[0]/0: found at 0000:05:08.0, rev: 3, irq: 18, latency: 32, mmio: 0xd0000000
Oct 10 22:52:39 newcastle kernel: tuner 2-0060: Chip ID is not zero. It is not a TEA5767
Oct 10 22:52:39 newcastle kernel: tuner 2-0060: chip found @ 0xc0 (cx88[0])
Oct 10 22:52:39 newcastle kernel: tuner 2-0060: microtune: companycode=4d54 part=04 rev=04
Oct 10 22:52:39 newcastle kernel: tuner 2-0060: microtune MT2032 found, OK
Oct 10 22:52:39 newcastle kernel: tuner 2-0060: microtune: companycode=4d54 part=04 rev=04
Oct 10 22:52:39 newcastle kernel: tuner 2-0060: microtune MT2032 found, OK
Oct 10 22:52:39 newcastle kernel: cx88[0]/0: registered device video0 [v4l2]
Oct 10 22:52:39 newcastle kernel: cx88[0]/0: registered device vbi0
Oct 10 22:52:39 newcastle kernel: ACPI: PCI Interrupt Link [APCF] enabled at IRQ 23
Oct 10 22:52:39 newcastle kernel: ACPI: PCI Interrupt 0000:00:02.0[A] -> Link [APCF] -> GSI 23 (level, low) -> IRQ 23
Oct 10 22:52:39 newcastle kernel: ohci_hcd 0000:00:02.0: OHCI Host Controller
Oct 10 22:52:39 newcastle kernel: ohci_hcd 0000:00:02.0: new USB bus registered, assigned bus number 2
Oct 10 22:52:39 newcastle kernel: ohci_hcd 0000:00:02.0: irq 23, io mem 0xd2003000
Oct 10 22:52:39 newcastle kernel: usb usb2: new device found, idVendor=0000, idProduct=0000
Oct 10 22:52:39 newcastle kernel: usb usb2: new device strings: Mfr=3, Product=2, SerialNumber=1
Oct 10 22:52:39 newcastle kernel: usb usb2: Product: OHCI Host Controller
Oct 10 22:52:39 newcastle kernel: usb usb2: Manufacturer: Linux 2.6.19-rc1-mm1-adma ohci_hcd
Oct 10 22:52:39 newcastle kernel: usb usb2: SerialNumber: 0000:00:02.0
Oct 10 22:52:39 newcastle kernel: usb usb2: configuration #1 chosen from 1 choice
Oct 10 22:52:39 newcastle kernel: hub 2-0:1.0: USB hub found
Oct 10 22:52:39 newcastle kernel: hub 2-0:1.0: 10 ports detected
Oct 10 22:52:39 newcastle kernel: ACPI: PCI Interrupt Link [APC1] enabled at IRQ 16
Oct 10 22:52:39 newcastle kernel: ACPI: PCI Interrupt 0000:05:0b.0[A] -> Link [APC1] -> GSI 16 (level, low) -> IRQ 16
Oct 10 22:52:39 newcastle kernel: ohci1394: fw-host0: OHCI-1394 1.1 (PCI): IRQ=[16]  MMIO=[d1004000-d10047ff]  Max Packet=[2048]  IR/IT contexts=[4/8]
Oct 10 22:52:39 newcastle kernel: sr0: scsi3-mmc drive: 48x/48x writer dvd-ram cd/rw xa/form2 cdda tray
Oct 10 22:52:39 newcastle kernel: Uniform CD-ROM driver Revision: 3.20
Oct 10 22:52:39 newcastle kernel: sr1: scsi3-mmc drive: 40x/52x writer cd/rw xa/form2 cdda tray
Oct 10 22:52:39 newcastle kernel: usb 1-3: new high speed USB device using ehci_hcd and address 4
Oct 10 22:52:39 newcastle kernel: ACPI: PCI Interrupt Link [APC2] enabled at IRQ 17
Oct 10 22:52:39 newcastle kernel: ACPI: PCI Interrupt 0000:05:07.0[A] -> Link [APC2] -> GSI 17 (level, low) -> IRQ 17
Oct 10 22:52:39 newcastle kernel: ice1724: No matching model found for ID 0x581404a6
Oct 10 22:52:39 newcastle kernel: ice1724: Invalid EEPROM version 1
Oct 10 22:52:39 newcastle kernel: usb 1-3: new device found, idVendor=0409, idProduct=0059
Oct 10 22:52:39 newcastle kernel: usb 1-3: new device strings: Mfr=0, Product=0, SerialNumber=0
Oct 10 22:52:39 newcastle kernel: usb 1-3: configuration #1 chosen from 1 choice
Oct 10 22:52:39 newcastle kernel: hub 1-3:1.0: USB hub found
Oct 10 22:52:39 newcastle kernel: hub 1-3:1.0: 4 ports detected
Oct 10 22:52:39 newcastle kernel: warning: process `salsa' used the removed sysctl system call
Oct 10 22:52:39 newcastle kernel: lp: driver loaded but no devices found
Oct 10 22:52:39 newcastle kernel: usb 1-9: new high speed USB device using ehci_hcd and address 6
Oct 10 22:52:39 newcastle kernel: usb 1-9: new device found, idVendor=07cc, idProduct=0301
Oct 10 22:52:39 newcastle kernel: usb 1-9: new device strings: Mfr=1, Product=2, SerialNumber=3
Oct 10 22:52:39 newcastle kernel: usb 1-9: Product: Winter Ver1.3   
Oct 10 22:52:39 newcastle kernel: usb 1-9: Manufacturer:         Ltd
Oct 10 22:52:39 newcastle kernel: usb 1-9: SerialNumber: 972394281841
Oct 10 22:52:39 newcastle kernel: usb 1-9: configuration #1 chosen from 1 choice
Oct 10 22:52:39 newcastle kernel: Initializing USB Mass Storage driver...
Oct 10 22:52:39 newcastle kernel: usb 2-1: new low speed USB device using ohci_hcd and address 2
Oct 10 22:52:39 newcastle kernel: bay: Unknown symbol is_dock_device
Oct 10 22:52:39 newcastle kernel: bay: Unknown symbol register_hotplug_dock_device
Oct 10 22:52:39 newcastle kernel: bay: Unknown symbol unregister_hotplug_dock_device
Oct 10 22:52:39 newcastle kernel: ACPI: Power Button (FF) [PWRF]
Oct 10 22:52:39 newcastle kernel: ACPI: Power Button (CM) [PWRB]
Oct 10 22:52:39 newcastle kernel: ibm_acpi: ec object not found
Oct 10 22:52:39 newcastle kernel: usb 2-1: new device found, idVendor=045e, idProduct=008c
Oct 10 22:52:39 newcastle kernel: usb 2-1: new device strings: Mfr=1, Product=2, SerialNumber=0
Oct 10 22:52:39 newcastle kernel: usb 2-1: Product: Microsoft Wireless Optical Mouse® 1.0A
Oct 10 22:52:39 newcastle kernel: usb 2-1: Manufacturer: Microsoft
Oct 10 22:52:39 newcastle kernel: usb 2-1: configuration #1 chosen from 1 choice
Oct 10 22:52:39 newcastle kernel: input: Microsoft Microsoft Wireless Optical Mouse® 1.0A as /class/input/input1
Oct 10 22:52:39 newcastle kernel: input: USB HID v1.11 Mouse [Microsoft Microsoft Wireless Optical Mouse® 1.0A] on usb-0000:00:02.0-1
Oct 10 22:52:39 newcastle kernel: md: Autodetecting RAID arrays.
Oct 10 22:52:39 newcastle kernel: md: autorun ...
Oct 10 22:52:39 newcastle kernel: md: ... autorun DONE.
Oct 10 22:52:39 newcastle kernel: usb 2-2: new full speed USB device using ohci_hcd and address 3
Oct 10 22:52:39 newcastle kernel: usb 2-2: new device found, idVendor=0451, idProduct=1446
Oct 10 22:52:39 newcastle kernel: usb 2-2: new device strings: Mfr=0, Product=0, SerialNumber=0
Oct 10 22:52:39 newcastle kernel: usb 2-2: configuration #1 chosen from 1 choice
Oct 10 22:52:39 newcastle kernel: hub 2-2:1.0: USB hub found
Oct 10 22:52:39 newcastle kernel: hub 2-2:1.0: 4 ports detected
Oct 10 22:52:39 newcastle kernel: usb 2-4: new low speed USB device using ohci_hcd and address 4
Oct 10 22:52:39 newcastle kernel: usb 2-4: new device found, idVendor=051d, idProduct=0002
Oct 10 22:52:39 newcastle kernel: usb 2-4: new device strings: Mfr=3, Product=1, SerialNumber=2
Oct 10 22:52:39 newcastle kernel: usb 2-4: Product: Back-UPS BR  800 FW:9.o2 .D USB FW:o2 
Oct 10 22:52:39 newcastle kernel: usb 2-4: Manufacturer: American Power Conversion
Oct 10 22:52:39 newcastle kernel: usb 2-4: SerialNumber: QB0419230426  
Oct 10 22:52:39 newcastle kernel: usb 2-4: configuration #1 chosen from 1 choice
Oct 10 22:52:39 newcastle kernel: EXT3 FS on dm-0, internal journal
Oct 10 22:52:39 newcastle kernel: kjournald starting.  Commit interval 5 seconds
Oct 10 22:52:39 newcastle kernel: EXT3 FS on sdc3, internal journal
Oct 10 22:52:39 newcastle kernel: EXT3-fs: mounted filesystem with ordered data mode.
Oct 10 22:52:39 newcastle kernel: SELinux: initialized (dev sdc3, type ext3), uses xattr
Oct 10 22:52:39 newcastle kernel: SELinux: initialized (dev tmpfs, type tmpfs), uses transition SIDs
Oct 10 22:52:39 newcastle kernel: hiddev96: USB HID v1.10 Device [American Power Conversion Back-UPS BR  800 FW:9.o2 .D USB FW:o2 ] on usb-0000:00:02.0-4
Oct 10 22:52:39 newcastle kernel: NTFS driver 2.1.27 [Flags: R/W MODULE].
Oct 10 22:52:39 newcastle kernel: NTFS volume version 3.1.
Oct 10 22:52:39 newcastle kernel: usb 1-3.1: new full speed USB device using ehci_hcd and address 7
Oct 10 22:52:39 newcastle kernel: SELinux: initialized (dev sdb1, type ntfs), uses genfs_contexts
Oct 10 22:52:39 newcastle kernel: NTFS volume version 3.1.
Oct 10 22:52:39 newcastle kernel: SELinux: initialized (dev sdc1, type ntfs), uses genfs_contexts
Oct 10 22:52:39 newcastle kernel: usb 1-3.1: new device found, idVendor=046d, idProduct=092c
Oct 10 22:52:39 newcastle kernel: usb 1-3.1: new device strings: Mfr=1, Product=2, SerialNumber=0
Oct 10 22:52:39 newcastle kernel: usb 1-3.1: Product: Camera
Oct 10 22:52:39 newcastle kernel: usb 1-3.1: Manufacturer:         
Oct 10 22:52:39 newcastle kernel: usb 1-3.1: configuration #1 chosen from 1 choice
Oct 10 22:52:39 newcastle kernel: scsi6 : SCSI emulation for USB Mass Storage devices
Oct 10 22:52:39 newcastle kernel: SELinux: initialized (dev sdc2, type vfat), uses genfs_contexts
Oct 10 22:52:39 newcastle kernel: usb 2-2.1: new low speed USB device using ohci_hcd and address 5
Oct 10 22:52:40 newcastle kernel: usb 2-2.1: new device found, idVendor=045e, idProduct=002b
Oct 10 22:52:40 newcastle kernel: usb 2-2.1: new device strings: Mfr=0, Product=1, SerialNumber=0
Oct 10 22:52:40 newcastle kernel: usb 2-2.1: Product: Microsoft Internet Keyboard Pro
Oct 10 22:52:40 newcastle kernel: usb 2-2.1: configuration #1 chosen from 1 choice
Oct 10 22:52:40 newcastle kernel: input: Microsoft Internet Keyboard Pro as /class/input/input2
Oct 10 22:52:40 newcastle kernel: input: USB HID v1.10 Keyboard [Microsoft Internet Keyboard Pro] on usb-0000:00:02.0-2.1
Oct 10 22:52:40 newcastle kernel: input: Microsoft Internet Keyboard Pro as /class/input/input3
Oct 10 22:52:40 newcastle kernel: input: USB HID v1.10 Device [Microsoft Internet Keyboard Pro] on usb-0000:00:02.0-2.1
Oct 10 22:52:40 newcastle kernel: usbcore: registered new interface driver usb-storage
Oct 10 22:52:40 newcastle kernel: USB Mass Storage support registered.
Oct 10 22:52:40 newcastle kernel: Adding 2031608k swap on /dev/VolGroup00/LogVol01.  Priority:-1 extents:1 across:2031608k
Oct 10 22:52:40 newcastle kernel: SELinux: initialized (dev binfmt_misc, type binfmt_misc), uses genfs_contexts
Oct 10 22:52:40 newcastle kernel: scsi 6:0:0:0: Direct-Access     USB2.0   CardReader CF RW 0.0> PQ: 0 ANSI: 0
Oct 10 22:52:40 newcastle kernel: sd 6:0:0:0: Attached scsi removable disk sdd
Oct 10 22:52:40 newcastle kernel: sd 6:0:0:0: Attached scsi generic sg5 type 0
Oct 10 22:52:40 newcastle kernel: scsi 6:0:0:1: Direct-Access     USB2.0   CardReader Combo 0.0> PQ: 0 ANSI: 0
Oct 10 22:52:40 newcastle kernel: sd 6:0:0:1: Attached scsi removable disk sde
Oct 10 22:52:40 newcastle kernel: sd 6:0:0:1: Attached scsi generic sg6 type 0
Oct 10 22:52:40 newcastle kernel: it87: Found IT8712F chip at 0x290, revision 7
Oct 10 22:52:40 newcastle kernel: it87: in3 is VCC (+5V)
Oct 10 22:52:40 newcastle kernel: it87: in7 is VCCH (+5V Stand-By)
Oct 10 22:52:40 newcastle kernel: it87-isa 9191-0290: Detected broken BIOS defaults, disabling PWM interface
Oct 10 22:52:40 newcastle kernel: SELinux: initialized (dev autofs, type autofs), uses genfs_contexts
Oct 10 22:52:40 newcastle kernel: NET: Registered protocol family 10
Oct 10 22:52:40 newcastle kernel: lo: Disabled Privacy Extensions
Oct 10 22:52:40 newcastle kernel: IPv6 over IPv4 tunneling driver
Oct 10 22:53:34 newcastle kernel: do_IRQ: 0.105 No irq handler for vector

--Boundary_(ID_z7LowFyEnnRY+akGVOBtIg)--
