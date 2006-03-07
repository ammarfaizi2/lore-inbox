Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751436AbWCGSUw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751436AbWCGSUw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Mar 2006 13:20:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751468AbWCGSUw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Mar 2006 13:20:52 -0500
Received: from c-68-35-68-128.hsd1.nm.comcast.net ([68.35.68.128]:51144 "EHLO
	deneb.dwf.com") by vger.kernel.org with ESMTP id S1751436AbWCGSUv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Mar 2006 13:20:51 -0500
Message-Id: <200603071820.k27IKSsm003595@deneb.dwf.com>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.1
To: "Randy.Dunlap" <rdunlap@xenotime.net>
cc: Reg Clemens <reg@dwf.com>, rlrevell@joe-job.com, torvalds@osdl.org,
       linux-kernel@vger.kernel.org, reg@deneb.dwf.com, reg@deneb.dwf.com
Subject: Re: vmlinuz-2.6.16-rc5-git8 still nogo with Intel D945 Motherboard 
In-reply-to: <20060307081806.0af1d2c4.rdunlap@xenotime.net> 
References: <200603070340.k273ev0A003594@deneb.dwf.com> 
 <1141703317.25487.142.camel@mindpipe> <200603070823.k278NE9o006674@deneb.dwf.com> <20060307081806.0af1d2c4.rdunlap@xenotime.net>
Comments: In-reply-to "Randy.Dunlap" <rdunlap@xenotime.net>
   message dated "Tue, 07 Mar 2006 08:18:06 -0800."
Mime-Version: 1.0
Content-Type: multipart/mixed ;
	boundary="==_Exmh_1141755325_31870"
Date: Tue, 07 Mar 2006 11:20:28 -0700
From: Reg Clemens <reg@dwf.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multipart MIME message.

--==_Exmh_1141755325_31870
Content-Type: text/plain; charset=us-ascii


> I meant, narrow it down by identifying the change that broke it.
> "Somewhere between 2.6.11 and 2.6.15" is not helpful.

Yes, I can do that, but not till this evening.

> The HD (high-definition) audio driver works for me.
> Are you using a vendor/distro kernel or roll-your-own?

Im building my own kernels.

> Maybe try the latest e1000 driver from
>  http://sourceforge.net/projects/e1000/

Ill give that a shot, but again probably not till this evening.

> Can you post the complete boot log instead of one line of it?

Sure.
In fact, Ill give you two, first the bad boot from 2.6.16, then a
good boot from 1.6.11 just in case you need something to compare
against.

Here they are, In the bad boot, the lines of interest are between
lines 115 and 120, and start with PCI: Cannot and PCI: Failed .



--==_Exmh_1141755325_31870
Content-Type: text/plain ; name="boot-bad-2.6.16"; charset=us-ascii
Content-Description: boot-bad-2.6.16
Content-Disposition: attachment; filename="boot-bad-2.6.16"

Mar  7 10:58:40 deneb syslogd 1.4.1: restart.
Mar  7 10:58:40 deneb kernel: klogd 1.4.1, log source = /proc/kmsg started.
Mar  7 10:58:40 deneb kernel: Linux version 2.6.16-rc5-git8 (root@deneb.dwf.com) (gcc version 4.0.2 20051125 (Red Hat 4.0.2-8)) #1 SMP Mon Mar 6 19:15:22 MST 2006
Mar  7 10:58:40 deneb kernel: BIOS-provided physical RAM map:
Mar  7 10:58:40 deneb kernel:  BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
Mar  7 10:58:40 deneb kernel:  BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
Mar  7 10:58:40 deneb kernel:  BIOS-e820: 00000000000e0000 - 0000000000100000 (reserved)
Mar  7 10:58:40 deneb kernel:  BIOS-e820: 0000000000100000 - 000000003fe82000 (usable)
Mar  7 10:58:40 deneb kernel:  BIOS-e820: 000000003fe82000 - 000000003fee9000 (ACPI NVS)
Mar  7 10:58:40 deneb kernel:  BIOS-e820: 000000003fee9000 - 000000003feed000 (usable)
Mar  7 10:58:40 deneb kernel:  BIOS-e820: 000000003feed000 - 000000003feff000 (ACPI data)
Mar  7 10:58:40 deneb kernel:  BIOS-e820: 000000003feff000 - 000000003ff00000 (usable)
Mar  7 10:58:40 deneb kernel: 127MB HIGHMEM available.
Mar  7 10:58:40 deneb kernel: 896MB LOWMEM available.
Mar  7 10:58:40 deneb kernel: found SMP MP-table at 000fe680
Mar  7 10:58:40 deneb kernel: NX (Execute Disable) protection: active
Mar  7 10:58:40 deneb kernel: DMI 2.3 present.
Mar  7 10:58:40 deneb kernel: Using APIC driver default
Mar  7 10:58:40 deneb rpc.statd[2274]: Version 1.0.7 Starting
Mar  7 10:58:40 deneb kernel: ACPI: PM-Timer IO Port: 0x408
Mar  7 10:58:40 deneb kernel: ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
Mar  7 10:58:40 deneb kernel: Processor #0 15:4 APIC version 20
Mar  7 10:58:40 deneb kernel: ACPI: LAPIC (acpi_id[0x02] lapic_id[0x01] enabled)
Mar  7 10:58:40 deneb kernel: Processor #1 15:4 APIC version 20
Mar  7 10:58:40 deneb kernel: ACPI: LAPIC (acpi_id[0x03] lapic_id[0x82] disabled)
Mar  7 10:58:40 deneb kernel: ACPI: LAPIC (acpi_id[0x04] lapic_id[0x83] disabled)
Mar  7 10:58:40 deneb kernel: ACPI: LAPIC_NMI (acpi_id[0x01] dfl dfl lint[0x1])
Mar  7 10:58:40 deneb kernel: ACPI: LAPIC_NMI (acpi_id[0x02] dfl dfl lint[0x1])
Mar  7 10:58:40 deneb kernel: ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])
Mar  7 10:58:40 deneb kernel: IOAPIC[0]: apic_id 2, version 32, address 0xfec00000, GSI 0-23
Mar  7 10:58:40 deneb kernel: ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
Mar  7 10:58:40 deneb kernel: ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
Mar  7 10:58:40 deneb kernel: Enabling APIC mode:  Flat.  Using 1 I/O APICs
Mar  7 10:58:40 deneb kernel: Using ACPI (MADT) for SMP configuration information
Mar  7 10:58:40 deneb kernel: Allocating PCI resources starting at 40000000 (gap: 3ff00000:c0100000)
Mar  7 10:58:40 deneb kernel: Built 1 zonelists
Mar  7 10:58:40 deneb kernel: Kernel command line: ro root=/dev/sda6 rhgb quiet
Mar  7 10:58:40 deneb auditd[2288]: Init complete, auditd 1.0.14 listening for events
Mar  7 10:58:40 deneb kernel: Enabling fast FPU save and restore... done.
Mar  7 10:58:40 deneb kernel: Enabling unmasked SIMD FPU exception support... done.
Mar  7 10:58:40 deneb kernel: Initializing CPU#0
Mar  7 10:58:40 deneb kernel: CPU 0 irqstacks, hard=c0451000 soft=c0471000
Mar  7 10:58:40 deneb kernel: PID hash table entries: 4096 (order: 12, 65536 bytes)
Mar  7 10:58:40 deneb kernel: Detected 3200.730 MHz processor.
Mar  7 10:58:40 deneb kernel: Using pmtmr for high-res timesource
Mar  7 10:58:40 deneb kernel: Console: colour VGA+ 80x25
Mar  7 10:58:40 deneb kernel: Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Mar  7 10:58:40 deneb kernel: Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Mar  7 10:58:40 deneb kernel: Memory: 1028940k/1047552k available (2331k kernel code, 17384k reserved, 798k data, 240k init, 129564k highmem)
Mar  7 10:58:40 deneb kernel: Checking if this processor honours the WP bit even in supervisor mode... Ok.
Mar  7 10:58:40 deneb kernel: Calibrating delay using timer specific routine.. 6413.82 BogoMIPS (lpj=12827658)
Mar  7 10:58:40 deneb kernel: Security Framework v1.0.0 initialized
Mar  7 10:58:40 deneb kernel: SELinux:  Initializing.
Mar  7 10:58:40 deneb kernel: SELinux:  Starting in permissive mode
Mar  7 10:58:40 deneb kernel: selinux_register_security:  Registering secondary module capability
Mar  7 10:58:40 deneb kernel: Capability LSM initialized as secondary
Mar  7 10:58:40 deneb kernel: Mount-cache hash table entries: 512
Mar  7 10:58:40 deneb kernel: monitor/mwait feature present.
Mar  7 10:58:40 deneb kernel: using mwait in idle threads.
Mar  7 10:58:41 deneb kernel: CPU: Trace cache: 12K uops, L1 D cache: 16K
Mar  7 10:58:41 deneb kernel: CPU: L2 cache: 2048K
Mar  7 10:58:41 deneb kernel: CPU: Physical Processor ID: 0
Mar  7 10:58:41 deneb kernel: Intel machine check architecture supported.
Mar  7 10:58:41 deneb kernel: Intel machine check reporting enabled on CPU#0.
Mar  7 10:58:41 deneb kernel: CPU0: Intel P4/Xeon Extended MCE MSRs (24) available
Mar  7 10:58:41 deneb kernel: CPU0: Thermal monitoring enabled
Mar  7 10:58:41 deneb kernel: Checking 'hlt' instruction... OK.
Mar  7 10:58:41 deneb kernel: CPU0: Intel(R) Pentium(R) 4 CPU 3.20GHz stepping 03
Mar  7 10:58:41 deneb kernel: Booting processor 1/1 eip 2000
Mar  7 10:58:41 deneb kernel: CPU 1 irqstacks, hard=c0452000 soft=c0472000
Mar  7 10:58:41 deneb kernel: Initializing CPU#1
Mar  7 10:58:41 deneb kernel: Calibrating delay using timer specific routine.. 6400.59 BogoMIPS (lpj=12801181)
Mar  7 10:58:41 deneb kernel: monitor/mwait feature present.
Mar  7 10:58:41 deneb kernel: CPU: Trace cache: 12K uops, L1 D cache: 16K
Mar  7 10:58:41 deneb kernel: CPU: L2 cache: 2048K
Mar  7 10:58:41 deneb kernel: CPU: Physical Processor ID: 0
Mar  7 10:58:41 deneb kernel: Intel machine check architecture supported.
Mar  7 10:58:41 deneb kernel: Intel machine check reporting enabled on CPU#1.
Mar  7 10:58:41 deneb kernel: CPU1: Intel P4/Xeon Extended MCE MSRs (24) available
Mar  7 10:58:41 deneb kernel: CPU1: Thermal monitoring enabled
Mar  7 10:58:41 deneb kernel: CPU1: Intel(R) Pentium(R) 4 CPU 3.20GHz stepping 03
Mar  7 10:58:41 deneb kernel: Total of 2 processors activated (12814.41 BogoMIPS).
Mar  7 10:58:41 deneb kernel: ENABLING IO-APIC IRQs
Mar  7 10:58:41 deneb kernel: ..TIMER: vector=0x31 apic1=0 pin1=2 apic2=-1 pin2=-1
Mar  7 10:58:41 deneb kernel: checking TSC synchronization across 2 CPUs: passed.
Mar  7 10:58:41 deneb kernel: Brought up 2 CPUs
Mar  7 10:58:41 deneb kernel: migration_cost=0
Mar  7 10:58:41 deneb kernel: checking if image is initramfs... it is
Mar  7 10:58:41 deneb kernel: Freeing initrd memory: 1228k freed
Mar  7 10:58:41 deneb kernel: NET: Registered protocol family 16
Mar  7 10:58:41 deneb kernel: ACPI: bus type pci registered
Mar  7 10:58:41 deneb kernel: PCI: Using MMCONFIG
Mar  7 10:58:41 deneb kernel: ACPI: Subsystem revision 20060127
Mar  7 10:58:41 deneb kernel: ACPI: Interpreter enabled
Mar  7 10:58:41 deneb kernel: ACPI: Using IOAPIC for interrupt routing
Mar  7 10:58:41 deneb kernel: ACPI: PCI Root Bridge [PCI0] (0000:00)
Mar  7 10:58:41 deneb kernel: ACPI: Assume root bridge [\_SB_.PCI0] bus is 0
Mar  7 10:58:41 deneb kernel: PCI: Ignoring BAR0-3 of IDE controller 0000:00:1f.1
Mar  7 10:58:41 deneb kernel: PCI: Transparent bridge - 0000:00:1e.0
Mar  7 10:58:41 deneb kernel: ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 7 9 10 *11 12)
Mar  7 10:58:41 deneb kernel: ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 7 9 10 11 12) *0, disabled.
Mar  7 10:58:41 deneb kernel: ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 7 9 10 *11 12)
Mar  7 10:58:41 deneb kernel: ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 7 9 10 *11 12)
Mar  7 10:58:41 deneb kernel: ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 7 9 10 11 12) *0, disabled.
Mar  7 10:58:41 deneb kernel: ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 7 9 10 11 12) *0, disabled.
Mar  7 10:58:41 deneb kernel: ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 7 *9 10 11 12)
Mar  7 10:58:41 deneb kernel: ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 7 9 *10 11 12)
Mar  7 10:58:41 deneb kernel: Linux Plug and Play Support v0.97 (c) Adam Belay
Mar  7 10:58:41 deneb kernel: pnp: PnP ACPI init
Mar  7 10:58:41 deneb kernel: pnp: PnP ACPI: found 13 devices
Mar  7 10:58:41 deneb kernel: usbcore: registered new driver usbfs
Mar  7 10:58:41 deneb kernel: usbcore: registered new driver hub
Mar  7 10:58:41 deneb kernel: PCI: Using ACPI for IRQ routing
Mar  7 10:58:41 deneb kernel: PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
Mar  7 10:58:41 deneb kernel: PCI: Cannot allocate resource region 1 of device 0000:05:01.0
Mar  7 10:58:41 deneb kernel: PCI: Cannot allocate resource region 2 of device 0000:05:01.0
Mar  7 10:58:41 deneb kernel: pnp: 00:06: ioport range 0x500-0x53f has been reserved
Mar  7 10:58:41 deneb kernel: pnp: 00:06: ioport range 0x400-0x47f could not be reserved
Mar  7 10:58:41 deneb kernel: pnp: 00:06: ioport range 0x680-0x6ff has been reserved
Mar  7 10:58:41 deneb kernel: PCI: Failed to allocate mem resource #6:20000@48000000 for 0000:01:00.0
Mar  7 10:58:41 deneb kernel: PCI: Bridge: 0000:00:01.0
Mar  7 10:58:41 deneb kernel:   IO window: disabled.
Mar  7 10:58:41 deneb kernel:   MEM window: 48000000-4cffffff
Mar  7 10:58:41 deneb kernel:   PREFETCH window: 40000000-47ffffff
Mar  7 10:58:41 deneb kernel: PCI: Bridge: 0000:00:1c.0
Mar  7 10:58:41 deneb kernel:   IO window: disabled.
Mar  7 10:58:41 deneb kernel:   MEM window: 4d200000-4d2fffff
Mar  7 10:58:41 deneb hcid[2336]: Bluetooth HCI daemon
Mar  7 10:58:41 deneb kernel:   PREFETCH window: disabled.
Mar  7 10:58:41 deneb kernel: PCI: Bridge: 0000:00:1c.2
Mar  7 10:58:41 deneb hcid[2336]: Unable to get on D-BUS
Mar  7 10:58:41 deneb kernel:   IO window: disabled.
Mar  7 10:58:41 deneb sdpd[2338]: Bluetooth SDP daemon 
Mar  7 10:58:41 deneb kernel:   MEM window: 4d300000-4d3fffff
Mar  7 10:58:41 deneb kernel:   PREFETCH window: disabled.
Mar  7 10:58:41 deneb kernel: PCI: Bridge: 0000:00:1c.3
Mar  7 10:58:41 deneb kernel:   IO window: disabled.
Mar  7 10:58:41 deneb kernel:   MEM window: 4d400000-4d4fffff
Mar  7 10:58:41 deneb kernel:   PREFETCH window: disabled.
Mar  7 10:58:41 deneb kernel: PCI: Bridge: 0000:00:1e.0
Mar  7 10:58:41 deneb kernel:   IO window: 1000-1fff
Mar  7 10:58:41 deneb kernel:   MEM window: 4d000000-4d0fffff
Mar  7 10:58:41 deneb kernel:   PREFETCH window: 4d500000-4d5fffff
Mar  7 10:58:41 deneb kernel: ACPI: PCI Interrupt 0000:00:01.0[A] -> GSI 16 (level, low) -> IRQ 169
Mar  7 10:58:41 deneb kernel: ACPI: PCI Interrupt 0000:00:1c.0[A] -> GSI 17 (level, low) -> IRQ 177
Mar  7 10:58:41 deneb kernel: ACPI: PCI Interrupt 0000:00:1c.2[C] -> GSI 18 (level, low) -> IRQ 185
Mar  7 10:58:41 deneb kernel: ACPI: PCI Interrupt 0000:00:1c.3[D] -> GSI 19 (level, low) -> IRQ 193
Mar  7 10:58:41 deneb kernel: apm: BIOS version 1.2 Flags 0x03 (Driver version 1.16ac)
Mar  7 10:58:41 deneb kernel: apm: disabled - APM is not SMP safe.
Mar  7 10:58:41 deneb kernel: audit: initializing netlink socket (disabled)
Mar  7 10:58:41 deneb kernel: audit(1141754299.996:1): initialized
Mar  7 10:58:41 deneb kernel: highmem bounce pool size: 64 pages
Mar  7 10:58:41 deneb kernel: Total HugeTLB memory allocated, 0
Mar  7 10:58:41 deneb kernel: VFS: Disk quotas dquot_6.5.1
Mar  7 10:58:41 deneb kernel: Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
Mar  7 10:58:41 deneb kernel: SELinux:  Registering netfilter hooks
Mar  7 10:58:41 deneb kernel: Initializing Cryptographic API
Mar  7 10:58:41 deneb kernel: io scheduler noop registered
Mar  7 10:58:41 deneb kernel: io scheduler anticipatory registered (default)
Mar  7 10:58:41 deneb kernel: io scheduler deadline registered
Mar  7 10:58:41 deneb kernel: io scheduler cfq registered
Mar  7 10:58:41 deneb kernel: ACPI: PCI Interrupt 0000:00:01.0[A] -> GSI 16 (level, low) -> IRQ 169
Mar  7 10:58:41 deneb kernel: assign_interrupt_mode Found MSI capability
Mar  7 10:58:41 deneb kernel: ACPI: PCI Interrupt 0000:00:1c.0[A] -> GSI 17 (level, low) -> IRQ 177
Mar  7 10:58:41 deneb kernel: assign_interrupt_mode Found MSI capability
Mar  7 10:58:41 deneb kernel: ACPI: PCI Interrupt 0000:00:1c.2[C] -> GSI 18 (level, low) -> IRQ 185
Mar  7 10:58:42 deneb kernel: assign_interrupt_mode Found MSI capability
Mar  7 10:58:42 deneb kernel: ACPI: PCI Interrupt 0000:00:1c.3[D] -> GSI 19 (level, low) -> IRQ 193
Mar  7 10:58:42 deneb kernel: assign_interrupt_mode Found MSI capability
Mar  7 10:58:42 deneb kernel: pci_hotplug: PCI Hot Plug PCI Core version: 0.5
Mar  7 10:58:42 deneb kernel: isapnp: Scanning for PnP cards...
Mar  7 10:58:42 deneb kernel: isapnp: No Plug & Play device found
Mar  7 10:58:42 deneb kernel: Real Time Clock Driver v1.12ac
Mar  7 10:58:42 deneb kernel: Linux agpgart interface v0.101 (c) Dave Jones
Mar  7 10:58:42 deneb kernel: agpgart: Detected an Intel 945G Chipset.
Mar  7 10:58:42 deneb kernel: agpgart: AGP aperture is 256M @ 0x0
Mar  7 10:58:42 deneb kernel: PNP: PS/2 Controller [PNP0303:PS2K,PNP0f03:PS2M] at 0x60,0x64 irq 1,12
Mar  7 10:58:42 deneb kernel: serio: i8042 AUX port at 0x60,0x64 irq 12
Mar  7 10:58:42 deneb kernel: serio: i8042 KBD port at 0x60,0x64 irq 1
Mar  7 10:58:42 deneb kernel: RAMDISK driver initialized: 16 RAM disks of 16384K size 1024 blocksize
Mar  7 10:58:42 deneb kernel: Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
Mar  7 10:58:42 deneb kernel: ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
Mar  7 10:58:42 deneb kernel: ICH7: IDE controller at PCI slot 0000:00:1f.1
Mar  7 10:58:42 deneb kernel: ACPI: PCI Interrupt 0000:00:1f.1[A] -> GSI 18 (level, low) -> IRQ 185
Mar  7 10:58:42 deneb kernel: ICH7: chipset revision 1
Mar  7 10:58:42 deneb kernel: ICH7: not 100% native mode: will probe irqs later
Mar  7 10:58:42 deneb kernel:     ide0: BM-DMA at 0x20b0-0x20b7, BIOS settings: hda:DMA, hdb:DMA
Mar  7 10:58:42 deneb kernel: hda: ST3160023A, ATA DISK drive
Mar  7 10:58:42 deneb kernel: hdb: PLEXTOR DVDR PX-740A, ATAPI CD/DVD-ROM drive
Mar  7 10:58:42 deneb kernel: ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Mar  7 10:58:42 deneb kernel: hda: max request size: 512KiB
Mar  7 10:58:42 deneb kernel: hda: 312581808 sectors (160041 MB) w/8192KiB Cache, CHS=19457/255/63, UDMA(100)
Mar  7 10:58:42 deneb kernel: hda: cache flushes supported
Mar  7 10:58:42 deneb kernel:  hda: hda1 hda2 hda3
Mar  7 10:58:42 deneb kernel: hdb: ATAPI 48X DVD-ROM DVD-R CD-R/RW drive, 2048kB Cache, UDMA(33)
Mar  7 10:58:42 deneb kernel: Uniform CD-ROM driver Revision: 3.20
Mar  7 10:58:42 deneb kernel: ide-floppy driver 0.99.newide
Mar  7 10:58:42 deneb kernel: usbcore: registered new driver hiddev
Mar  7 10:58:42 deneb kernel: usbcore: registered new driver usbhid
Mar  7 10:58:42 deneb kernel: drivers/usb/input/hid-core.c: v2.6:USB HID core driver
Mar  7 10:58:42 deneb kernel: mice: PS/2 mouse device common for all mice
Mar  7 10:58:42 deneb kernel: md: md driver 0.90.3 MAX_MD_DEVS=256, MD_SB_DISKS=27
Mar  7 10:58:42 deneb kernel: md: bitmap version 4.39
Mar  7 10:58:42 deneb kernel: NET: Registered protocol family 2
Mar  7 10:58:42 deneb kernel: input: AT Translated Set 2 keyboard as /class/input/input0
Mar  7 10:58:42 deneb kernel: IP route cache hash table entries: 32768 (order: 5, 131072 bytes)
Mar  7 10:58:42 deneb kernel: TCP established hash table entries: 131072 (order: 9, 2621440 bytes)
Mar  7 10:58:42 deneb kernel: TCP bind hash table entries: 65536 (order: 8, 1310720 bytes)
Mar  7 10:58:42 deneb kernel: TCP: Hash tables configured (established 131072 bind 65536)
Mar  7 10:58:42 deneb kernel: TCP reno registered
Mar  7 10:58:42 deneb kernel: TCP bic registered
Mar  7 10:58:42 deneb kernel: Initializing IPsec netlink socket
Mar  7 10:58:42 deneb kernel: NET: Registered protocol family 1
Mar  7 10:58:42 deneb kernel: NET: Registered protocol family 17
Mar  7 10:58:42 deneb kernel: Using IPI Shortcut mode
Mar  7 10:58:42 deneb kernel: Freeing unused kernel memory: 240k freed
Mar  7 10:58:42 deneb kernel: SCSI subsystem initialized
Mar  7 10:58:42 deneb kernel: ACPI: PCI Interrupt 0000:05:01.0[A] -> GSI 22 (level, low) -> IRQ 50
Mar  7 10:58:42 deneb kernel: sym0: <875> rev 0x4 at pci 0000:05:01.0 irq 50
Mar  7 10:58:42 deneb kernel: sym0: Symbios NVRAM, ID 7, Fast-20, SE, parity checking
Mar  7 10:58:42 deneb kernel: sym0: open drain IRQ line driver, using on-chip SRAM
Mar  7 10:58:42 deneb kernel: sym0: using LOAD/STORE-based firmware.
Mar  7 10:58:42 deneb kernel: sym0: SCSI BUS has been reset.
Mar  7 10:58:42 deneb kernel: scsi0 : sym-2.2.2
Mar  7 10:58:42 deneb kernel: input: PS/2 Generic Mouse as /class/input/input1
Mar  7 10:58:42 deneb kernel: ACPI: PCI Interrupt 0000:00:1f.2[B] -> GSI 19 (level, low) -> IRQ 193
Mar  7 10:58:42 deneb kernel: ata1: SATA max UDMA/133 cmd 0x20C8 ctl 0x20E6 bmdma 0x20A0 irq 193
Mar  7 10:58:42 deneb kernel: ata2: SATA max UDMA/133 cmd 0x20C0 ctl 0x20E2 bmdma 0x20A8 irq 193
Mar  7 10:58:42 deneb kernel: ata1: dev 0 ATA-7, max UDMA/133, 586072368 sectors: LBA48
Mar  7 10:58:42 deneb kernel: ata1: dev 0 configured for UDMA/133
Mar  7 10:58:42 deneb rarpd[2570]: rarpd: no suitable device found
Mar  7 10:58:42 deneb kernel: scsi1 : ata_piix
Mar  7 10:58:42 deneb kernel: ATA: abnormal status 0x7F on port 0x20C7
Mar  7 10:58:42 deneb kernel: ata2: disabling port
Mar  7 10:58:42 deneb kernel: scsi2 : ata_piix
Mar  7 10:58:42 deneb kernel:   Vendor: ATA       Model: ST3300831AS       Rev: 3.03
Mar  7 10:58:42 deneb kernel:   Type:   Direct-Access                      ANSI SCSI revision: 05
Mar  7 10:58:42 deneb kernel: SCSI device sda: 586072368 512-byte hdwr sectors (300069 MB)
Mar  7 10:58:42 deneb kernel: sda: Write Protect is off
Mar  7 10:58:43 deneb kernel: SCSI device sda: drive cache: write back
Mar  7 10:58:43 deneb kernel: SCSI device sda: 586072368 512-byte hdwr sectors (300069 MB)
Mar  7 10:58:43 deneb kernel: sda: Write Protect is off
Mar  7 10:58:43 deneb kernel: SCSI device sda: drive cache: write back
Mar  7 10:58:43 deneb kernel:  sda: sda1 sda2 sda3 sda4 < sda5 sda6 sda7 sda8 sda9 sda10 sda11 sda12 sda13 sda14 >
Mar  7 10:58:43 deneb kernel: sd 1:0:0:0: Attached scsi disk sda
Mar  7 10:58:43 deneb kernel: kjournald starting.  Commit interval 5 seconds
Mar  7 10:58:43 deneb kernel: EXT3-fs: mounted filesystem with ordered data mode.
Mar  7 10:58:43 deneb kernel: SELinux:  Disabled at runtime.
Mar  7 10:58:43 deneb kernel: SELinux:  Unregistering netfilter hooks
Mar  7 10:58:43 deneb kernel: Floppy drive(s): fd0 is 1.44M
Mar  7 10:58:43 deneb kernel: FDC 0 is a post-1991 82077
Mar  7 10:58:43 deneb kernel: ACPI: PCI Interrupt 0000:05:02.0[A] -> GSI 18 (level, low) -> IRQ 185
Mar  7 10:58:43 deneb kernel: Model 1006 Rev 00000000 Serial 10061102
Mar  7 10:58:43 deneb kernel: ACPI: PCI Interrupt 0000:00:1b.0[A] -> GSI 22 (level, low) -> IRQ 50
Mar  7 10:58:43 deneb kernel: hw_random hardware driver 1.0.0 loaded
Mar  7 10:58:43 deneb kernel: shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
Mar  7 10:58:43 deneb kernel: ACPI: PCI Interrupt 0000:00:1d.7[A] -> GSI 23 (level, low) -> IRQ 58
Mar  7 10:58:43 deneb kernel: ehci_hcd 0000:00:1d.7: EHCI Host Controller
Mar  7 10:58:43 deneb kernel: ehci_hcd 0000:00:1d.7: debug port 1
Mar  7 10:58:43 deneb kernel: ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus number 1
Mar  7 10:58:43 deneb kernel: ehci_hcd 0000:00:1d.7: irq 58, io mem 0x4d104000
Mar  7 10:58:43 deneb kernel: ehci_hcd 0000:00:1d.7: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
Mar  7 10:58:43 deneb kernel: usb usb1: configuration #1 chosen from 1 choice
Mar  7 10:58:43 deneb kernel: hub 1-0:1.0: USB hub found
Mar  7 10:58:43 deneb kernel: hub 1-0:1.0: 8 ports detected
Mar  7 10:58:43 deneb kernel: USB Universal Host Controller Interface driver v2.3
Mar  7 10:58:43 deneb kernel: ACPI: PCI Interrupt 0000:00:1d.0[A] -> GSI 23 (level, low) -> IRQ 58
Mar  7 10:58:43 deneb kernel: uhci_hcd 0000:00:1d.0: UHCI Host Controller
Mar  7 10:58:43 deneb kernel: uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 2
Mar  7 10:58:43 deneb kernel: uhci_hcd 0000:00:1d.0: irq 58, io base 0x00002080
Mar  7 10:58:43 deneb kernel: usb usb2: configuration #1 chosen from 1 choice
Mar  7 10:58:43 deneb kernel: hub 2-0:1.0: USB hub found
Mar  7 10:58:43 deneb kernel: hub 2-0:1.0: 2 ports detected
Mar  7 10:58:43 deneb kernel: ACPI: PCI Interrupt 0000:00:1d.1[B] -> GSI 19 (level, low) -> IRQ 193
Mar  7 10:58:43 deneb kernel: uhci_hcd 0000:00:1d.1: UHCI Host Controller
Mar  7 10:58:43 deneb kernel: uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 3
Mar  7 10:58:43 deneb kernel: uhci_hcd 0000:00:1d.1: irq 193, io base 0x00002060
Mar  7 10:58:43 deneb kernel: usb usb3: configuration #1 chosen from 1 choice
Mar  7 10:58:43 deneb kernel: hub 3-0:1.0: USB hub found
Mar  7 10:58:43 deneb kernel: hub 3-0:1.0: 2 ports detected
Mar  7 10:58:43 deneb kernel: ACPI: PCI Interrupt 0000:00:1d.2[C] -> GSI 18 (level, low) -> IRQ 185
Mar  7 10:58:43 deneb kernel: uhci_hcd 0000:00:1d.2: UHCI Host Controller
Mar  7 10:58:43 deneb kernel: uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus number 4
Mar  7 10:58:43 deneb kernel: uhci_hcd 0000:00:1d.2: irq 185, io base 0x00002040
Mar  7 10:58:43 deneb kernel: usb usb4: configuration #1 chosen from 1 choice
Mar  7 10:58:43 deneb kernel: hub 4-0:1.0: USB hub found
Mar  7 10:58:43 deneb kernel: hub 4-0:1.0: 2 ports detected
Mar  7 10:58:44 deneb kernel: ACPI: PCI Interrupt 0000:00:1d.3[D] -> GSI 16 (level, low) -> IRQ 169
Mar  7 10:58:44 deneb kernel: uhci_hcd 0000:00:1d.3: UHCI Host Controller
Mar  7 10:58:44 deneb kernel: uhci_hcd 0000:00:1d.3: new USB bus registered, assigned bus number 5
Mar  7 10:58:44 deneb kernel: uhci_hcd 0000:00:1d.3: irq 169, io base 0x00002020
Mar  7 10:58:44 deneb kernel: usb usb5: configuration #1 chosen from 1 choice
Mar  7 10:58:44 deneb kernel: hub 5-0:1.0: USB hub found
Mar  7 10:58:44 deneb kernel: hub 5-0:1.0: 2 ports detected
Mar  7 10:58:44 deneb kernel: usb 2-2: new low speed USB device using uhci_hcd and address 2
Mar  7 10:58:44 deneb kernel: usb 2-2: configuration #1 chosen from 1 choice
Mar  7 10:58:44 deneb kernel: hiddev96: USB HID v1.10 Device [American Power Conversion Back-UPS RS 1000 FW:7.g4 .D USB FW:g4 ] on usb-0000:00:1d.0-2
Mar  7 10:58:44 deneb kernel: ACPI: Power Button (FF) [PWRF]
Mar  7 10:58:44 deneb kernel: ACPI: Sleep Button (CM) [SLPB]
Mar  7 10:58:44 deneb kernel: ibm_acpi: ec object not found
Mar  7 10:58:44 deneb kernel: md: Autodetecting RAID arrays.
Mar  7 10:58:44 deneb kernel: md: autorun ...
Mar  7 10:58:44 deneb kernel: md: ... autorun DONE.
Mar  7 10:58:44 deneb kernel: device-mapper: 4.5.0-ioctl (2005-10-04) initialised: dm-devel@redhat.com
Mar  7 10:58:44 deneb kernel: EXT3 FS on sda6, internal journal
Mar  7 10:58:44 deneb kernel: kjournald starting.  Commit interval 5 seconds
Mar  7 10:58:44 deneb kernel: EXT3 FS on sda10, internal journal
Mar  7 10:58:44 deneb kernel: EXT3-fs: mounted filesystem with ordered data mode.
Mar  7 10:58:44 deneb kernel: kjournald starting.  Commit interval 5 seconds
Mar  7 10:58:44 deneb kernel: EXT3 FS on sda13, internal journal
Mar  7 10:58:44 deneb kernel: EXT3-fs: mounted filesystem with ordered data mode.
Mar  7 10:58:44 deneb kernel: kjournald starting.  Commit interval 5 seconds
Mar  7 10:58:44 deneb kernel: EXT3 FS on sda14, internal journal
Mar  7 10:58:44 deneb kernel: EXT3-fs: mounted filesystem with ordered data mode.
Mar  7 10:58:44 deneb kernel: kjournald starting.  Commit interval 5 seconds
Mar  7 10:58:44 deneb kernel: EXT3 FS on sda11, internal journal
Mar  7 10:58:44 deneb kernel: EXT3-fs: mounted filesystem with ordered data mode.
Mar  7 10:58:44 deneb kernel: kjournald starting.  Commit interval 5 seconds
Mar  7 10:58:44 deneb kernel: EXT3 FS on sda12, internal journal
Mar  7 10:58:44 deneb kernel: EXT3-fs: mounted filesystem with ordered data mode.
Mar  7 10:58:44 deneb kernel: kjournald starting.  Commit interval 5 seconds
Mar  7 10:58:44 deneb kernel: EXT3 FS on sda2, internal journal
Mar  7 10:58:44 deneb kernel: EXT3-fs: mounted filesystem with ordered data mode.
Mar  7 10:58:44 deneb kernel: kjournald starting.  Commit interval 5 seconds
Mar  7 10:58:44 deneb kernel: EXT3 FS on sda3, internal journal
Mar  7 10:58:44 deneb sshd[2654]: Server listening on :: port 22.
Mar  7 10:58:44 deneb kernel: EXT3-fs: mounted filesystem with ordered data mode.
Mar  7 10:58:44 deneb sshd[2654]: error: Bind to port 22 on 0.0.0.0 failed: Address already in use.
Mar  7 10:58:44 deneb kernel: kjournald starting.  Commit interval 5 seconds
Mar  7 10:58:44 deneb kernel: EXT3 FS on sda7, internal journal
Mar  7 10:58:44 deneb kernel: EXT3-fs: mounted filesystem with ordered data mode.
Mar  7 10:58:44 deneb kernel: kjournald starting.  Commit interval 5 seconds
Mar  7 10:58:44 deneb kernel: EXT3 FS on sda8, internal journal
Mar  7 10:58:44 deneb kernel: EXT3-fs: mounted filesystem with ordered data mode.
Mar  7 10:58:45 deneb ntpd[2669]: ntpd 4.2.0a@1.1190-r Thu Apr 14 07:47:25 EDT 2005 (1)
Mar  7 10:58:45 deneb kernel: kjournald starting.  Commit interval 5 seconds
Mar  7 10:58:45 deneb ntpd[2669]: precision = 3.000 usec
Mar  7 10:58:45 deneb kernel: EXT3 FS on sda9, internal journal
Mar  7 10:58:45 deneb ntpd[2669]: Listening on interface wildcard, 0.0.0.0#123
Mar  7 10:58:45 deneb kernel: EXT3-fs: mounted filesystem with ordered data mode.
Mar  7 10:58:45 deneb ntpd[2669]: Listening on interface wildcard, ::#123
Mar  7 10:58:45 deneb kernel: Adding 2449872k swap on /dev/sda5.  Priority:-1 extents:1 across:2449872k
Mar  7 10:58:45 deneb ntpd[2669]: Listening on interface lo, 127.0.0.1#123
Mar  7 10:58:45 deneb kernel: Bluetooth: Core ver 2.8
Mar  7 10:58:45 deneb ntpd[2669]: kernel time sync status 0040
Mar  7 10:58:45 deneb kernel: NET: Registered protocol family 31
Mar  7 10:58:45 deneb kernel: Bluetooth: HCI device and connection manager initialized
Mar  7 10:58:45 deneb kernel: Bluetooth: HCI socket layer initialized
Mar  7 10:58:45 deneb kernel: Bluetooth: L2CAP ver 2.8
Mar  7 10:58:45 deneb kernel: Bluetooth: L2CAP socket layer initialized
Mar  7 10:58:45 deneb kernel: Bluetooth: RFCOMM socket layer initialized
Mar  7 10:58:45 deneb kernel: Bluetooth: RFCOMM TTY layer initialized
Mar  7 10:58:45 deneb kernel: Bluetooth: RFCOMM ver 1.7
Mar  7 10:58:45 deneb kernel: parport: PnPBIOS parport detected.
Mar  7 10:58:45 deneb kernel: parport0: PC-style at 0x378 (0x778), irq 7 [PCSPP,TRISTATE]
Mar  7 10:58:45 deneb kernel: lp0: using parport0 (interrupt-driven).
Mar  7 10:58:45 deneb kernel: lp0: console ready
Mar  7 10:58:45 deneb kernel: NET: Registered protocol family 10
Mar  7 10:58:45 deneb kernel: lo: Disabled Privacy Extensions
Mar  7 10:58:45 deneb kernel: IPv6 over IPv4 tunneling driver
Mar  7 11:00:07 deneb ntpd[2677]: ntpd 4.2.0a@1.1190-r Thu Apr 14 07:47:25 EDT 2005 (1)
Mar  7 11:00:07 deneb ntpd[2677]: precision = 4.000 usec
Mar  7 11:00:07 deneb ntpd[2677]: Listening on interface wildcard, 0.0.0.0#123
Mar  7 11:00:07 deneb ntpd[2677]: Listening on interface wildcard, ::#123
Mar  7 11:00:07 deneb ntpd[2677]: Listening on interface lo, 127.0.0.1#123
Mar  7 11:00:07 deneb ntpd[2677]: kernel time sync status 0040
Mar  7 11:00:07 deneb ntpd[2677]: frequency initialized -19.100 PPM from /etc/ntp/ntp.drift
Mar  7 11:00:07 deneb apcupsd[2696]: apcupsd 3.10.17 (18 March 2005) redhat startup succeeded
Mar  7 11:00:07 deneb apcupsd[2696]: NIS server startup succeeded
Mar  7 11:00:09 deneb gpm[2748]: *** info [startup.c(95)]: 
Mar  7 11:00:09 deneb gpm[2748]: Started gpm successfully. Entered daemon mode.
Mar  7 11:00:09 deneb gpm[2748]: *** info [mice.c(1766)]: 
Mar  7 11:00:09 deneb gpm[2748]: imps2: Auto-detected intellimouse PS/2
Mar  7 11:00:13 deneb nmbd[2813]: [2006/03/07 11:00:13, 0] nmbd/nmbd_subnetdb.c:create_subnets(217) 
Mar  7 11:00:13 deneb nmbd[2813]:   create_subnets: No local interfaces ! 
Mar  7 11:00:13 deneb nmbd[2813]: [2006/03/07 11:00:13, 0] nmbd/nmbd_subnetdb.c:create_subnets(218) 
Mar  7 11:00:13 deneb nmbd[2813]:   create_subnets: Waiting for an interface to appear ... 
Mar  7 11:00:14 deneb fstab-sync[2860]: removed all generated mount points
Mar  7 11:00:15 deneb fstab-sync[2869]: added mount point /media/floppy1 for /dev/fd0
Mar  7 11:00:15 deneb fstab-sync[2887]: added mount point /media/cdrecorder for /dev/hdb
Mar  7 11:00:23 deneb login(pam_unix)[2906]: session opened for user reg by (uid=0)
Mar  7 11:00:23 deneb  -- reg[2906]: LOGIN ON tty1 BY reg
Mar  7 11:00:33 deneb login(pam_unix)[2906]: session closed for user reg
Mar  7 11:00:33 deneb ainit: Operation not permitted
Mar  7 11:00:33 deneb ainit: Operation not permitted
Mar  7 11:00:40 deneb login(pam_unix)[3204]: session opened for user reg by (uid=0)
Mar  7 11:00:40 deneb  -- reg[3204]: LOGIN ON tty1 BY reg
Mar  7 11:00:51 deneb shutdown: shutting down for system reboot
Mar  7 11:00:51 deneb init: Switching to runlevel: 6
Mar  7 11:00:51 deneb login(pam_unix)[3204]: session closed for user reg
Mar  7 11:00:51 deneb ainit: Operation not permitted
Mar  7 11:00:51 deneb ainit: Operation not permitted
Mar  7 11:00:52 deneb xfs[2802]: terminating 
Mar  7 11:00:54 deneb sshd[2654]: Received signal 15; terminating.
Mar  7 11:00:59 deneb rpc.statd[2274]: Caught signal 15, un-registering and exiting.
Mar  7 11:00:59 deneb auditd[2288]: The audit daemon is exiting.
Mar  7 11:00:59 deneb kernel: audit(1141754459.973:21): audit_pid=0 old=2288 by auid=4294967295
Mar  7 11:01:00 deneb kernel: Kernel logging (proc) stopped.
Mar  7 11:01:00 deneb kernel: Kernel log daemon terminating.
Mar  7 11:01:01 deneb exiting on signal 15

--==_Exmh_1141755325_31870
Content-Type: text/plain ; name="boot-ok-2.6.11"; charset=us-ascii
Content-Description: boot-ok-2.6.11
Content-Disposition: attachment; filename="boot-ok-2.6.11"

Mar  7 11:02:20 deneb syslogd 1.4.1: restart.
Mar  7 11:02:20 deneb kernel: klogd 1.4.1, log source = /proc/kmsg started.
Mar  7 11:02:20 deneb kernel: Linux version 2.6.11-1.1369_FC4smp (bhcompile@decompose.build.redhat.com) (gcc version 4.0.0 20050525 (Red Hat 4.0.0-9)) #1 SMP Thu Jun 2 23:08:39 EDT 2005
Mar  7 11:02:20 deneb kernel: BIOS-provided physical RAM map:
Mar  7 11:02:20 deneb kernel:  BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
Mar  7 11:02:20 deneb kernel:  BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
Mar  7 11:02:20 deneb kernel:  BIOS-e820: 00000000000e0000 - 0000000000100000 (reserved)
Mar  7 11:02:20 deneb kernel:  BIOS-e820: 0000000000100000 - 000000003fe82000 (usable)
Mar  7 11:02:20 deneb kernel:  BIOS-e820: 000000003fe82000 - 000000003fee9000 (ACPI NVS)
Mar  7 11:02:20 deneb kernel:  BIOS-e820: 000000003fee9000 - 000000003feed000 (usable)
Mar  7 11:02:20 deneb kernel:  BIOS-e820: 000000003feed000 - 000000003feff000 (ACPI data)
Mar  7 11:02:20 deneb kernel:  BIOS-e820: 000000003feff000 - 000000003ff00000 (usable)
Mar  7 11:02:20 deneb kernel: 127MB HIGHMEM available.
Mar  7 11:02:20 deneb kernel: 896MB LOWMEM available.
Mar  7 11:02:20 deneb kernel: found SMP MP-table at 000fe680
Mar  7 11:02:20 deneb kernel: NX (Execute Disable) protection: active
Mar  7 11:02:20 deneb kernel: DMI 2.3 present.
Mar  7 11:02:20 deneb kernel: Using APIC driver default
Mar  7 11:02:20 deneb kernel: ACPI: PM-Timer IO Port: 0x408
Mar  7 11:02:20 deneb kernel: ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
Mar  7 11:02:20 deneb kernel: Processor #0 15:4 APIC version 20
Mar  7 11:02:20 deneb kernel: ACPI: LAPIC (acpi_id[0x02] lapic_id[0x01] enabled)
Mar  7 11:02:20 deneb kernel: Processor #1 15:4 APIC version 20
Mar  7 11:02:20 deneb kernel: ACPI: LAPIC (acpi_id[0x03] lapic_id[0x82] disabled)
Mar  7 11:02:20 deneb kernel: ACPI: LAPIC (acpi_id[0x04] lapic_id[0x83] disabled)
Mar  7 11:02:20 deneb kernel: ACPI: LAPIC_NMI (acpi_id[0x01] dfl dfl lint[0x1])
Mar  7 11:02:20 deneb kernel: ACPI: LAPIC_NMI (acpi_id[0x02] dfl dfl lint[0x1])
Mar  7 11:02:20 deneb kernel: ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])
Mar  7 11:02:20 deneb kernel: IOAPIC[0]: apic_id 2, version 32, address 0xfec00000, GSI 0-23
Mar  7 11:02:20 deneb kernel: ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
Mar  7 11:02:20 deneb kernel: ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
Mar  7 11:02:20 deneb kernel: Enabling APIC mode:  Flat.  Using 1 I/O APICs
Mar  7 11:02:20 deneb kernel: Using ACPI (MADT) for SMP configuration information
Mar  7 11:02:20 deneb kernel: Allocating PCI resources starting at 3ff00000 (gap: 3ff00000:c0100000)
Mar  7 11:02:20 deneb kernel: Built 1 zonelists
Mar  7 11:02:20 deneb kernel: Kernel command line: ro root=/dev/sda6 rhgb quiet
Mar  7 11:02:20 deneb kernel: Initializing CPU#0
Mar  7 11:02:21 deneb kernel: CPU 0 irqstacks, hard=c042a000 soft=c040a000
Mar  7 11:02:21 deneb kernel: PID hash table entries: 4096 (order: 12, 65536 bytes)
Mar  7 11:02:21 deneb kernel: Detected 3200.355 MHz processor.
Mar  7 11:02:21 deneb kernel: Using pmtmr for high-res timesource
Mar  7 11:02:21 deneb kernel: Console: colour VGA+ 80x25
Mar  7 11:02:21 deneb kernel: Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Mar  7 11:02:21 deneb kernel: Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Mar  7 11:02:21 deneb kernel: Memory: 1031068k/1047552k available (2084k kernel code, 15068k reserved, 769k data, 232k init, 129564k highmem)
Mar  7 11:02:21 deneb kernel: Checking if this processor honours the WP bit even in supervisor mode... Ok.
Mar  7 11:02:21 deneb kernel: Security Framework v1.0.0 initialized
Mar  7 11:02:21 deneb kernel: SELinux:  Initializing.
Mar  7 11:02:21 deneb kernel: SELinux:  Starting in permissive mode
Mar  7 11:02:21 deneb kernel: selinux_register_security:  Registering secondary module capability
Mar  7 11:02:21 deneb kernel: Capability LSM initialized as secondary
Mar  7 11:02:21 deneb kernel: Mount-cache hash table entries: 512
Mar  7 11:02:21 deneb kernel: monitor/mwait feature present.
Mar  7 11:02:21 deneb rpc.statd[2247]: Version 1.0.7 Starting
Mar  7 11:02:21 deneb kernel: using mwait in idle threads.
Mar  7 11:02:21 deneb kernel: CPU: Trace cache: 12K uops, L1 D cache: 16K
Mar  7 11:02:21 deneb kernel: CPU: L2 cache: 2048K
Mar  7 11:02:21 deneb kernel: CPU: Physical Processor ID: 0
Mar  7 11:02:21 deneb kernel: Intel machine check architecture supported.
Mar  7 11:02:21 deneb kernel: Intel machine check reporting enabled on CPU#0.
Mar  7 11:02:21 deneb kernel: CPU0: Intel P4/Xeon Extended MCE MSRs (24) available
Mar  7 11:02:21 deneb kernel: CPU0: Thermal monitoring enabled
Mar  7 11:02:21 deneb kernel: Enabling fast FPU save and restore... done.
Mar  7 11:02:21 deneb kernel: Enabling unmasked SIMD FPU exception support... done.
Mar  7 11:02:21 deneb kernel: Checking 'hlt' instruction... OK.
Mar  7 11:02:21 deneb kernel: CPU0: Intel(R) Pentium(R) 4 CPU 3.20GHz stepping 03
Mar  7 11:02:21 deneb kernel: Booting processor 1/1 eip 3000
Mar  7 11:02:21 deneb kernel: CPU 1 irqstacks, hard=c042b000 soft=c040b000
Mar  7 11:02:21 deneb kernel: Initializing CPU#1
Mar  7 11:02:21 deneb kernel: monitor/mwait feature present.
Mar  7 11:02:21 deneb kernel: CPU: Trace cache: 12K uops, L1 D cache: 16K
Mar  7 11:02:21 deneb kernel: CPU: L2 cache: 2048K
Mar  7 11:02:21 deneb kernel: CPU: Physical Processor ID: 0
Mar  7 11:02:21 deneb kernel: Intel machine check architecture supported.
Mar  7 11:02:21 deneb kernel: Intel machine check reporting enabled on CPU#1.
Mar  7 11:02:21 deneb kernel: CPU1: Intel P4/Xeon Extended MCE MSRs (24) available
Mar  7 11:02:21 deneb kernel: CPU1: Thermal monitoring enabled
Mar  7 11:02:21 deneb kernel: CPU1: Intel(R) Pentium(R) 4 CPU 3.20GHz stepping 03
Mar  7 11:02:21 deneb kernel: Total of 2 processors activated (12713.98 BogoMIPS).
Mar  7 11:02:21 deneb kernel: ENABLING IO-APIC IRQs
Mar  7 11:02:21 deneb kernel: ..TIMER: vector=0x31 pin1=2 pin2=-1
Mar  7 11:02:21 deneb kernel: checking TSC synchronization across 2 CPUs: passed.
Mar  7 11:02:21 deneb kernel: softlockup thread 0 started up.
Mar  7 11:02:21 deneb auditd[2261]: Init complete, auditd 1.0.14 listening for events
Mar  7 11:02:21 deneb kernel: Brought up 2 CPUs
Mar  7 11:02:21 deneb kernel: softlockup thread 1 started up.
Mar  7 11:02:21 deneb kernel: checking if image is initramfs... it is
Mar  7 11:02:21 deneb kernel: Freeing initrd memory: 1253k freed
Mar  7 11:02:21 deneb kernel: NET: Registered protocol family 16
Mar  7 11:02:21 deneb kernel: PCI: Using MMCONFIG
Mar  7 11:02:21 deneb kernel: mtrr: v2.0 (20020519)
Mar  7 11:02:21 deneb kernel: ACPI: Subsystem revision 20050309
Mar  7 11:02:21 deneb kernel: ACPI: Interpreter enabled
Mar  7 11:02:21 deneb kernel: ACPI: Using IOAPIC for interrupt routing
Mar  7 11:02:21 deneb kernel: ACPI: PCI Root Bridge [PCI0] (0000:00)
Mar  7 11:02:21 deneb kernel: PCI: Probing PCI hardware (bus 00)
Mar  7 11:02:21 deneb kernel: PCI: Ignoring BAR0-3 of IDE controller 0000:00:1f.1
Mar  7 11:02:21 deneb kernel: PCI: Transparent bridge - 0000:00:1e.0
Mar  7 11:02:21 deneb kernel: ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 7 9 10 *11 12)
Mar  7 11:02:21 deneb kernel: ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 7 9 10 11 12) *0, disabled.
Mar  7 11:02:21 deneb kernel: ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 7 9 10 *11 12)
Mar  7 11:02:21 deneb kernel: ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 7 9 10 *11 12)
Mar  7 11:02:21 deneb kernel: ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 7 9 10 11 12) *0, disabled.
Mar  7 11:02:21 deneb kernel: ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 7 9 10 11 12) *0, disabled.
Mar  7 11:02:21 deneb kernel: ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 7 *9 10 11 12)
Mar  7 11:02:21 deneb kernel: ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 7 9 *10 11 12)
Mar  7 11:02:21 deneb kernel: Linux Plug and Play Support v0.97 (c) Adam Belay
Mar  7 11:02:21 deneb kernel: pnp: PnP ACPI init
Mar  7 11:02:21 deneb kernel: pnp: PnP ACPI: found 12 devices
Mar  7 11:02:21 deneb kernel: usbcore: registered new driver usbfs
Mar  7 11:02:21 deneb kernel: usbcore: registered new driver hub
Mar  7 11:02:21 deneb kernel: PCI: Using ACPI for IRQ routing
Mar  7 11:02:21 deneb kernel: PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
Mar  7 11:02:21 deneb kernel: PCI: Cannot allocate resource region 1 of device 0000:05:01.0
Mar  7 11:02:21 deneb kernel: PCI: Cannot allocate resource region 2 of device 0000:05:01.0
Mar  7 11:02:21 deneb kernel: pnp: 00:05: ioport range 0x500-0x53f has been reserved
Mar  7 11:02:21 deneb kernel: pnp: 00:05: ioport range 0x400-0x47f could not be reserved
Mar  7 11:02:21 deneb kernel: pnp: 00:05: ioport range 0x680-0x6ff has been reserved
Mar  7 11:02:21 deneb kernel: apm: BIOS version 1.2 Flags 0x03 (Driver version 1.16ac)
Mar  7 11:02:21 deneb kernel: apm: disabled - APM is not SMP safe.
Mar  7 11:02:21 deneb kernel: audit: initializing netlink socket (disabled)
Mar  7 11:02:21 deneb kernel: audit(1141754527.597:1): initialized
Mar  7 11:02:21 deneb kernel: highmem bounce pool size: 64 pages
Mar  7 11:02:21 deneb kernel: Total HugeTLB memory allocated, 0
Mar  7 11:02:21 deneb kernel: VFS: Disk quotas dquot_6.5.1
Mar  7 11:02:21 deneb kernel: Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
Mar  7 11:02:21 deneb kernel: SELinux:  Registering netfilter hooks
Mar  7 11:02:21 deneb kernel: Initializing Cryptographic API
Mar  7 11:02:21 deneb kernel: ksign: Installing public key data
Mar  7 11:02:21 deneb kernel: Loading keyring
Mar  7 11:02:21 deneb kernel: - Added public key 42BD35A990375F72
Mar  7 11:02:21 deneb kernel: - User ID: Red Hat, Inc. (Kernel Module GPG key)
Mar  7 11:02:21 deneb kernel: pci_hotplug: PCI Hot Plug PCI Core version: 0.5
Mar  7 11:02:21 deneb kernel: ACPI: PCI Interrupt 0000:00:01.0[A] -> GSI 16 (level, low) -> IRQ 169
Mar  7 11:02:21 deneb kernel: assign_interrupt_mode Found MSI capability
Mar  7 11:02:21 deneb kernel: ACPI: PCI Interrupt 0000:00:1c.0[A] -> GSI 17 (level, low) -> IRQ 193
Mar  7 11:02:21 deneb kernel: assign_interrupt_mode Found MSI capability
Mar  7 11:02:21 deneb kernel: ACPI: PCI Interrupt 0000:00:1c.2[C] -> GSI 18 (level, low) -> IRQ 209
Mar  7 11:02:21 deneb kernel: assign_interrupt_mode Found MSI capability
Mar  7 11:02:21 deneb kernel: ACPI: PCI Interrupt 0000:00:1c.3[D] -> GSI 19 (level, low) -> IRQ 225
Mar  7 11:02:21 deneb kernel: assign_interrupt_mode Found MSI capability
Mar  7 11:02:21 deneb kernel: isapnp: Scanning for PnP cards...
Mar  7 11:02:21 deneb kernel: isapnp: No Plug & Play device found
Mar  7 11:02:21 deneb kernel: Real Time Clock Driver v1.12
Mar  7 11:02:21 deneb kernel: Linux agpgart interface v0.101 (c) Dave Jones
Mar  7 11:02:21 deneb kernel: PNP: PS/2 Controller [PNP0303:PS2K,PNP0f03:PS2M] at 0x60,0x64 irq 1,12
Mar  7 11:02:21 deneb kernel: serio: i8042 AUX port at 0x60,0x64 irq 12
Mar  7 11:02:21 deneb kernel: serio: i8042 KBD port at 0x60,0x64 irq 1
Mar  7 11:02:21 deneb kernel: Serial: 8250/16550 driver $Revision: 1.90 $ 76 ports, IRQ sharing enabled
Mar  7 11:02:21 deneb kernel: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
Mar  7 11:02:21 deneb kernel: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
Mar  7 11:02:21 deneb kernel: io scheduler noop registered
Mar  7 11:02:21 deneb kernel: io scheduler anticipatory registered
Mar  7 11:02:21 deneb kernel: io scheduler deadline registered
Mar  7 11:02:21 deneb kernel: io scheduler cfq registered
Mar  7 11:02:21 deneb kernel: RAMDISK driver initialized: 16 RAM disks of 16384K size 1024 blocksize
Mar  7 11:02:21 deneb kernel: Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
Mar  7 11:02:21 deneb kernel: ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
Mar  7 11:02:21 deneb kernel: ICH7: IDE controller at PCI slot 0000:00:1f.1
Mar  7 11:02:21 deneb kernel: ACPI: PCI Interrupt 0000:00:1f.1[A] -> GSI 18 (level, low) -> IRQ 209
Mar  7 11:02:21 deneb kernel: ICH7: chipset revision 1
Mar  7 11:02:21 deneb kernel: ICH7: not 100% native mode: will probe irqs later
Mar  7 11:02:21 deneb kernel:     ide0: BM-DMA at 0x20b0-0x20b7, BIOS settings: hda:DMA, hdb:DMA
Mar  7 11:02:21 deneb kernel: hda: ST3160023A, ATA DISK drive
Mar  7 11:02:21 deneb kernel: hdb: PLEXTOR DVDR PX-740A, ATAPI CD/DVD-ROM drive
Mar  7 11:02:21 deneb kernel: ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Mar  7 11:02:21 deneb kernel: hda: max request size: 1024KiB
Mar  7 11:02:21 deneb kernel: hda: 312581808 sectors (160041 MB) w/8192KiB Cache, CHS=19457/255/63, UDMA(100)
Mar  7 11:02:21 deneb kernel: hda: cache flushes supported
Mar  7 11:02:21 deneb kernel:  hda: hda1 hda2 hda3
Mar  7 11:02:21 deneb kernel: hdb: ATAPI 48X DVD-ROM DVD-R CD-R/RW drive, 2048kB Cache, UDMA(33)
Mar  7 11:02:21 deneb kernel: Uniform CD-ROM driver Revision: 3.20
Mar  7 11:02:21 deneb kernel: ide-floppy driver 0.99.newide
Mar  7 11:02:21 deneb kernel: usbcore: registered new driver hiddev
Mar  7 11:02:21 deneb kernel: usbcore: registered new driver usbhid
Mar  7 11:02:21 deneb kernel: drivers/usb/input/hid-core.c: v2.01:USB HID core driver
Mar  7 11:02:21 deneb kernel: mice: PS/2 mouse device common for all mice
Mar  7 11:02:21 deneb kernel: md: md driver 0.90.1 MAX_MD_DEVS=256, MD_SB_DISKS=27
Mar  7 11:02:21 deneb kernel: NET: Registered protocol family 2
Mar  7 11:02:21 deneb kernel: IP: routing cache hash table of 4096 buckets, 64Kbytes
Mar  7 11:02:21 deneb kernel: TCP established hash table entries: 131072 (order: 9, 2097152 bytes)
Mar  7 11:02:21 deneb kernel: TCP bind hash table entries: 65536 (order: 7, 786432 bytes)
Mar  7 11:02:21 deneb kernel: TCP: Hash tables configured (established 131072 bind 65536)
Mar  7 11:02:21 deneb kernel: Initializing IPsec netlink socket
Mar  7 11:02:21 deneb kernel: NET: Registered protocol family 1
Mar  7 11:02:21 deneb kernel: NET: Registered protocol family 17
Mar  7 11:02:21 deneb kernel: ACPI wakeup devices: 
Mar  7 11:02:21 deneb kernel: SLPB  P32 UAR1 PEX0 PEX1 PEX2 PEX3 PEX4 PEX5 UHC1 UHC2 UHC3 UHC4 EHCI AC9M AZAL 
Mar  7 11:02:21 deneb kernel: ACPI: (supports S0 S1 S3 S4 S5)
Mar  7 11:02:21 deneb kernel: Freeing unused kernel memory: 232k freed
Mar  7 11:02:21 deneb kernel: input: AT Translated Set 2 keyboard on isa0060/serio0
Mar  7 11:02:21 deneb kernel: SCSI subsystem initialized
Mar  7 11:02:21 deneb kernel: ACPI: PCI Interrupt 0000:00:1f.2[B] -> GSI 19 (level, low) -> IRQ 225
Mar  7 11:02:21 deneb kernel: ata1: SATA max UDMA/133 cmd 0x20C8 ctl 0x20E6 bmdma 0x20A0 irq 225
Mar  7 11:02:21 deneb kernel: ata2: SATA max UDMA/133 cmd 0x20C0 ctl 0x20E2 bmdma 0x20A8 irq 225
Mar  7 11:02:21 deneb kernel: ata1: dev 0 ATA, max UDMA/133, 586072368 sectors: lba48
Mar  7 11:02:21 deneb kernel: ata1: dev 0 configured for UDMA/133
Mar  7 11:02:21 deneb kernel: scsi0 : ata_piix
Mar  7 11:02:21 deneb kernel: ATA: abnormal status 0x7F on port 0x20C7
Mar  7 11:02:21 deneb kernel: ata2: disabling port
Mar  7 11:02:21 deneb kernel: scsi1 : ata_piix
Mar  7 11:02:21 deneb kernel:   Vendor: ATA       Model: ST3300831AS       Rev: 3.03
Mar  7 11:02:21 deneb kernel:   Type:   Direct-Access                      ANSI SCSI revision: 05
Mar  7 11:02:21 deneb kernel: SCSI device sda: 586072368 512-byte hdwr sectors (300069 MB)
Mar  7 11:02:21 deneb kernel: SCSI device sda: drive cache: write back
Mar  7 11:02:21 deneb kernel: SCSI device sda: 586072368 512-byte hdwr sectors (300069 MB)
Mar  7 11:02:21 deneb kernel: SCSI device sda: drive cache: write back
Mar  7 11:02:21 deneb kernel:  sda: sda1 sda2 sda3 sda4 <<6>input: PS/2 Generic Mouse on isa0060/serio1
Mar  7 11:02:21 deneb kernel:  sda5 sda6 sda7 sda8 sda9 sda10 sda11 sda12 sda13 sda14 >
Mar  7 11:02:21 deneb kernel: Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
Mar  7 11:02:22 deneb kernel: kjournald starting.  Commit interval 5 seconds
Mar  7 11:02:22 deneb kernel: EXT3-fs: mounted filesystem with ordered data mode.
Mar  7 11:02:22 deneb kernel: SELinux:  Disabled at runtime.
Mar  7 11:02:22 deneb kernel: SELinux:  Unregistering netfilter hooks
Mar  7 11:02:22 deneb kernel: ACPI: PCI Interrupt 0000:05:01.0[A] -> GSI 22 (level, low) -> IRQ 50
Mar  7 11:02:22 deneb kernel: sym0: <875> rev 0x4 at pci 0000:05:01.0 irq 50
Mar  7 11:02:22 deneb kernel: sym0: No NVRAM, ID 7, Fast-20, HVD, parity checking
Mar  7 11:02:22 deneb kernel: CACHE TEST FAILED: reg dstat-sstat2 readback ffffffff.
Mar  7 11:02:22 deneb kernel: sym0: CACHE INCORRECTLY CONFIGURED.
Mar  7 11:02:22 deneb kernel: sym0: giving up ...
Mar  7 11:02:22 deneb kernel: Floppy drive(s): fd0 is 1.44M
Mar  7 11:02:22 deneb kernel: FDC 0 is a post-1991 82077
Mar  7 11:02:22 deneb kernel: ACPI: PCI Interrupt 0000:05:03.0[A] -> GSI 19 (level, low) -> IRQ 225
Mar  7 11:02:22 deneb kernel: ACPI: PCI Interrupt 0000:05:03.0[A] -> GSI 19 (level, low) -> IRQ 225
Mar  7 11:02:22 deneb kernel: eth0: DGE-530T Gigabit Ethernet Adapter
Mar  7 11:02:22 deneb kernel:       PrefPort:A  RlmtMode:Check Link State
Mar  7 11:02:22 deneb kernel: ACPI: PCI Interrupt 0000:05:02.0[A] -> GSI 18 (level, low) -> IRQ 209
Mar  7 11:02:22 deneb kernel: Model 1006 Rev 00000000 Serial 10061102
Mar  7 11:02:22 deneb kernel: ACPI: PCI Interrupt 0000:00:1b.0[A] -> GSI 22 (level, low) -> IRQ 50
Mar  7 11:02:22 deneb kernel: hw_random hardware driver 1.0.0 loaded
Mar  7 11:02:22 deneb kernel: shpchp: acpi_shpchprm:\_SB_.PCI0 evaluate _BBN fail=0x5
Mar  7 11:02:22 deneb kernel: shpchp: acpi_shpchprm:get_device PCI ROOT HID fail=0x5
Mar  7 11:02:22 deneb kernel: shpchp: acpi_shpchprm:\_SB_.PCI0 evaluate _BBN fail=0x5
Mar  7 11:02:22 deneb kernel: shpchp: acpi_shpchprm:get_device PCI ROOT HID fail=0x5
Mar  7 11:02:22 deneb kernel: shpchp: acpi_shpchprm:\_SB_.PCI0 evaluate _BBN fail=0x5
Mar  7 11:02:22 deneb kernel: shpchp: acpi_shpchprm:get_device PCI ROOT HID fail=0x5
Mar  7 11:02:22 deneb kernel: shpchp: acpi_shpchprm:\_SB_.PCI0 evaluate _BBN fail=0x5
Mar  7 11:02:22 deneb kernel: shpchp: acpi_shpchprm:get_device PCI ROOT HID fail=0x5
Mar  7 11:02:22 deneb kernel: ACPI: PCI Interrupt 0000:00:1d.7[A] -> GSI 23 (level, low) -> IRQ 58
Mar  7 11:02:22 deneb kernel: ehci_hcd 0000:00:1d.7: EHCI Host Controller
Mar  7 11:02:22 deneb kernel: ehci_hcd 0000:00:1d.7: debug port 1
Mar  7 11:02:22 deneb kernel: ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus number 1
Mar  7 11:02:22 deneb kernel: ehci_hcd 0000:00:1d.7: irq 58, io mem 0x4d104000
Mar  7 11:02:22 deneb kernel: ehci_hcd 0000:00:1d.7: USB 2.0 initialized, EHCI 1.00, driver 10 Dec 2004
Mar  7 11:02:22 deneb kernel: hub 1-0:1.0: USB hub found
Mar  7 11:02:22 deneb kernel: hub 1-0:1.0: 8 ports detected
Mar  7 11:02:22 deneb kernel: USB Universal Host Controller Interface driver v2.2
Mar  7 11:02:22 deneb kernel: ACPI: PCI Interrupt 0000:00:1d.0[A] -> GSI 23 (level, low) -> IRQ 58
Mar  7 11:02:22 deneb kernel: uhci_hcd 0000:00:1d.0: UHCI Host Controller
Mar  7 11:02:22 deneb kernel: uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 2
Mar  7 11:02:22 deneb kernel: uhci_hcd 0000:00:1d.0: irq 58, io base 0x00002080
Mar  7 11:02:22 deneb hcid[2307]: Bluetooth HCI daemon
Mar  7 11:02:22 deneb kernel: hub 2-0:1.0: USB hub found
Mar  7 11:02:22 deneb kernel: hub 2-0:1.0: 2 ports detected
Mar  7 11:02:22 deneb kernel: ACPI: PCI Interrupt 0000:00:1d.1[B] -> GSI 19 (level, low) -> IRQ 225
Mar  7 11:02:22 deneb hcid[2307]: Unable to get on D-BUS
Mar  7 11:02:22 deneb kernel: uhci_hcd 0000:00:1d.1: UHCI Host Controller
Mar  7 11:02:22 deneb kernel: uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 3
Mar  7 11:02:22 deneb sdpd[2311]: Bluetooth SDP daemon 
Mar  7 11:02:22 deneb kernel: uhci_hcd 0000:00:1d.1: irq 225, io base 0x00002060
Mar  7 11:02:22 deneb kernel: hub 3-0:1.0: USB hub found
Mar  7 11:02:22 deneb kernel: hub 3-0:1.0: 2 ports detected
Mar  7 11:02:22 deneb kernel: ACPI: PCI Interrupt 0000:00:1d.2[C] -> GSI 18 (level, low) -> IRQ 209
Mar  7 11:02:22 deneb kernel: uhci_hcd 0000:00:1d.2: UHCI Host Controller
Mar  7 11:02:22 deneb kernel: uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus number 4
Mar  7 11:02:22 deneb kernel: uhci_hcd 0000:00:1d.2: irq 209, io base 0x00002040
Mar  7 11:02:22 deneb kernel: hub 4-0:1.0: USB hub found
Mar  7 11:02:22 deneb kernel: hub 4-0:1.0: 2 ports detected
Mar  7 11:02:22 deneb kernel: ACPI: PCI Interrupt 0000:00:1d.3[D] -> GSI 16 (level, low) -> IRQ 169
Mar  7 11:02:22 deneb kernel: uhci_hcd 0000:00:1d.3: UHCI Host Controller
Mar  7 11:02:22 deneb kernel: usb 2-2: new low speed USB device using uhci_hcd and address 2
Mar  7 11:02:22 deneb kernel: uhci_hcd 0000:00:1d.3: new USB bus registered, assigned bus number 5
Mar  7 11:02:22 deneb kernel: uhci_hcd 0000:00:1d.3: irq 169, io base 0x00002020
Mar  7 11:02:22 deneb kernel: hub 5-0:1.0: USB hub found
Mar  7 11:02:22 deneb kernel: hub 5-0:1.0: 2 ports detected
Mar  7 11:02:22 deneb kernel: hiddev96: USB HID v1.10 Device [American Power Conversion Back-UPS RS 1000 FW:7.g4 .D USB FW:g4] on usb-0000:00:1d.0-2
Mar  7 11:02:22 deneb kernel: audit(1141754534.999:2): user pid=1820 uid=0 auid=4294967295 msg='hwclock: op=changing system time id=0 res=success'
Mar  7 11:02:22 deneb kernel: ACPI: Power Button (FF) [PWRF]
Mar  7 11:02:22 deneb kernel: ACPI: Sleep Button (CM) [SLPB]
Mar  7 11:02:22 deneb kernel: ibm_acpi: ec object not found
Mar  7 11:02:22 deneb kernel: md: Autodetecting RAID arrays.
Mar  7 11:02:22 deneb kernel: md: autorun ...
Mar  7 11:02:22 deneb kernel: md: ... autorun DONE.
Mar  7 11:02:22 deneb kernel: device-mapper: 4.4.0-ioctl (2005-01-12) initialised: dm-devel@redhat.com
Mar  7 11:02:22 deneb kernel: EXT3 FS on sda6, internal journal
Mar  7 11:02:22 deneb kernel: kjournald starting.  Commit interval 5 seconds
Mar  7 11:02:22 deneb kernel: EXT3 FS on sda10, internal journal
Mar  7 11:02:22 deneb kernel: EXT3-fs: mounted filesystem with ordered data mode.
Mar  7 11:02:22 deneb kernel: kjournald starting.  Commit interval 5 seconds
Mar  7 11:02:22 deneb kernel: EXT3 FS on sda13, internal journal
Mar  7 11:02:22 deneb kernel: EXT3-fs: mounted filesystem with ordered data mode.
Mar  7 11:02:22 deneb kernel: kjournald starting.  Commit interval 5 seconds
Mar  7 11:02:22 deneb kernel: EXT3 FS on sda14, internal journal
Mar  7 11:02:22 deneb kernel: EXT3-fs: mounted filesystem with ordered data mode.
Mar  7 11:02:22 deneb kernel: kjournald starting.  Commit interval 5 seconds
Mar  7 11:02:22 deneb kernel: EXT3 FS on sda11, internal journal
Mar  7 11:02:22 deneb kernel: EXT3-fs: mounted filesystem with ordered data mode.
Mar  7 11:02:22 deneb kernel: kjournald starting.  Commit interval 5 seconds
Mar  7 11:02:22 deneb kernel: EXT3 FS on sda12, internal journal
Mar  7 11:02:22 deneb kernel: EXT3-fs: mounted filesystem with ordered data mode.
Mar  7 11:02:22 deneb kernel: kjournald starting.  Commit interval 5 seconds
Mar  7 11:02:22 deneb kernel: EXT3 FS on sda2, internal journal
Mar  7 11:02:22 deneb kernel: EXT3-fs: mounted filesystem with ordered data mode.
Mar  7 11:02:22 deneb kernel: kjournald starting.  Commit interval 5 seconds
Mar  7 11:02:22 deneb kernel: EXT3 FS on sda3, internal journal
Mar  7 11:02:22 deneb kernel: EXT3-fs: mounted filesystem with ordered data mode.
Mar  7 11:02:22 deneb kernel: kjournald starting.  Commit interval 5 seconds
Mar  7 11:02:22 deneb kernel: EXT3 FS on sda7, internal journal
Mar  7 11:02:22 deneb kernel: EXT3-fs: mounted filesystem with ordered data mode.
Mar  7 11:02:22 deneb kernel: kjournald starting.  Commit interval 5 seconds
Mar  7 11:02:22 deneb kernel: EXT3 FS on sda8, internal journal
Mar  7 11:02:22 deneb kernel: EXT3-fs: mounted filesystem with ordered data mode.
Mar  7 11:02:22 deneb kernel: kjournald starting.  Commit interval 5 seconds
Mar  7 11:02:22 deneb kernel: EXT3 FS on sda9, internal journal
Mar  7 11:02:22 deneb kernel: EXT3-fs: mounted filesystem with ordered data mode.
Mar  7 11:02:22 deneb kernel: Adding 2449872k swap on /dev/sda5.  Priority:-1 extents:1
Mar  7 11:02:22 deneb kernel: eth0: network connection up using port A
Mar  7 11:02:22 deneb kernel:     speed:           100
Mar  7 11:02:22 deneb kernel:     autonegotiation: yes
Mar  7 11:02:22 deneb kernel:     duplex mode:     full
Mar  7 11:02:22 deneb kernel:     flowctrl:        symmetric
Mar  7 11:02:22 deneb kernel:     irq moderation:  disabled
Mar  7 11:02:22 deneb kernel:     scatter-gather:  enabled
Mar  7 11:02:22 deneb kernel: Bluetooth: Core ver 2.7
Mar  7 11:02:22 deneb kernel: NET: Registered protocol family 31
Mar  7 11:02:22 deneb kernel: Bluetooth: HCI device and connection manager initialized
Mar  7 11:02:22 deneb kernel: Bluetooth: HCI socket layer initialized
Mar  7 11:02:22 deneb kernel: Bluetooth: L2CAP ver 2.7
Mar  7 11:02:22 deneb kernel: Bluetooth: L2CAP socket layer initialized
Mar  7 11:02:22 deneb kernel: Bluetooth: RFCOMM ver 1.5
Mar  7 11:02:22 deneb kernel: Bluetooth: RFCOMM socket layer initialized
Mar  7 11:02:22 deneb kernel: Bluetooth: RFCOMM TTY layer initialized
Mar  7 11:02:23 deneb kernel: rarpd uses obsolete (PF_INET,SOCK_PACKET)
Mar  7 11:02:24 deneb kernel: parport: PnPBIOS parport detected.
Mar  7 11:02:24 deneb kernel: parport0: PC-style at 0x378 (0x778), irq 7 [PCSPP,TRISTATE]
Mar  7 11:02:24 deneb kernel: lp0: using parport0 (interrupt-driven).
Mar  7 11:02:24 deneb kernel: lp0: console ready
Mar  7 11:02:25 deneb kernel: NET: Registered protocol family 10
Mar  7 11:02:25 deneb kernel: Disabled Privacy Extensions on device c037d640(lo)
Mar  7 11:02:25 deneb kernel: IPv6 over IPv4 tunneling driver
Mar  7 11:02:25 deneb sshd[2636]: Server listening on :: port 22.
Mar  7 11:02:25 deneb sshd[2636]: error: Bind to port 22 on 0.0.0.0 failed: Address already in use.
Mar  7 11:02:25 deneb ntpd[2646]: ntpd 4.2.0a@1.1190-r Thu Apr 14 07:47:25 EDT 2005 (1)
Mar  7 11:02:25 deneb ntpd[2646]: precision = 4.000 usec
Mar  7 11:02:25 deneb ntpd[2646]: Listening on interface wildcard, 0.0.0.0#123
Mar  7 11:02:25 deneb ntpd[2646]: Listening on interface wildcard, ::#123
Mar  7 11:02:25 deneb ntpd[2646]: Listening on interface lo, 127.0.0.1#123
Mar  7 11:02:25 deneb ntpd[2646]: Listening on interface eth0, 204.134.2.17#123
Mar  7 11:02:25 deneb ntpd[2646]: kernel time sync status 0040
Mar  7 11:02:35 deneb ntpd[2648]: ntpd 4.2.0a@1.1190-r Thu Apr 14 07:47:25 EDT 2005 (1)
Mar  7 11:02:35 deneb ntpd[2648]: precision = 4.000 usec
Mar  7 11:02:35 deneb ntpd[2648]: Listening on interface wildcard, 0.0.0.0#123
Mar  7 11:02:35 deneb ntpd[2648]: Listening on interface wildcard, ::#123
Mar  7 11:02:35 deneb ntpd[2648]: Listening on interface lo, 127.0.0.1#123
Mar  7 11:02:35 deneb ntpd[2648]: Listening on interface eth0, 204.134.2.17#123
Mar  7 11:02:35 deneb ntpd[2648]: kernel time sync status 0040
Mar  7 11:02:35 deneb ntpd[2648]: frequency initialized -19.100 PPM from /etc/ntp/ntp.drift
Mar  7 11:02:35 deneb apcupsd[2666]: apcupsd 3.10.17 (18 March 2005) redhat startup succeeded
Mar  7 11:02:35 deneb apcupsd[2666]: NIS server startup succeeded
Mar  7 11:02:38 deneb gpm[2718]: *** info [startup.c(95)]: 
Mar  7 11:02:38 deneb gpm[2718]: Started gpm successfully. Entered daemon mode.
Mar  7 11:02:38 deneb gpm[2718]: *** info [mice.c(1766)]: 
Mar  7 11:02:38 deneb gpm[2718]: imps2: Auto-detected intellimouse PS/2
Mar  7 11:02:43 deneb fstab-sync[2830]: removed all generated mount points
Mar  7 11:02:43 deneb fstab-sync[2841]: added mount point /media/floppy1 for /dev/fd0
Mar  7 11:02:44 deneb fstab-sync[2859]: added mount point /media/cdrecorder for /dev/hdb
Mar  7 11:02:51 deneb login(pam_unix)[2878]: session opened for user reg by (uid=0)
Mar  7 11:02:51 deneb  -- reg[2878]: LOGIN ON tty1 BY reg
Mar  7 11:02:59 deneb kernel: nvidia: module license 'NVIDIA' taints kernel.
Mar  7 11:02:59 deneb kernel: ACPI: PCI Interrupt 0000:01:00.0[A] -> GSI 16 (level, low) -> IRQ 169
Mar  7 11:02:59 deneb kernel: NVRM: loading NVIDIA Linux x86 NVIDIA Kernel Module  1.0-7676  Fri Jul 29 12:58:54 PDT 2005
Mar  7 11:03:14 deneb su(pam_unix)[3281]: session opened for user root by (uid=1015)

--==_Exmh_1141755325_31870
Content-Type: text/plain; charset=us-ascii

                                        Reg.Clemens
                                        reg@dwf.com

--==_Exmh_1141755325_31870--


