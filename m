Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263292AbTKWFuM (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Nov 2003 00:50:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263293AbTKWFuL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Nov 2003 00:50:11 -0500
Received: from [64.65.189.210] ([64.65.189.210]:50374 "EHLO
	mail.pacrimopen.com") by vger.kernel.org with ESMTP id S263292AbTKWFtq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Nov 2003 00:49:46 -0500
Subject: Re: irq 9: nobody cared! on 2.6.0-test9
From: Joshua Schmidlkofer <kernel@pacrimopen.com>
To: Darren Dupre <darren@dmdtech.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <001a01c3b17a$b509f140$1e01a8c0@dmdtech2>
References: <001a01c3b17a$b509f140$1e01a8c0@dmdtech2>
Content-Type: text/plain
Message-Id: <1069566568.8861.53.camel@menion.home>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Sat, 22 Nov 2003 21:49:29 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

LOn Sat, 2003-11-22 at 20:31, Darren Dupre wrote:
> I compiled and installed 2.6.0-test9 today on my AMD 1.1Ghz system (VIA
> KT133A Chipset, Gigabyte 7ZXE motherboard).
> 
> Its just a light server. I am not doing anything in particular that I know
> of to trigger this, but it does happen a while after every boot. I even
> flashed to the latest BIOS for this board and it still happens. The system
> is still perfectly usable afterwards.
> 
> Let me know if you need any more information.
> 
> Nov 22 22:14:06 dmdtech kernel: irq 9: nobody cared!
> Nov 22 22:14:06 dmdtech kernel: Call Trace:
> Nov 22 22:14:06 dmdtech kernel:  [<c010b70b>] __report_bad_irq+0x2b/0x90
> Nov 22 22:14:06 dmdtech kernel:  [<c01ac9dd>] acpi_irq+0xf/0x1a
> Nov 22 22:14:06 dmdtech kernel:  [<c010b804>] note_interrupt+0x64/0xa0
> Nov 22 22:14:06 dmdtech kernel:  [<c010bac9>] do_IRQ+0x139/0x150
> Nov 22 22:14:06 dmdtech kernel:  [<c0109de8>] common_interrupt+0x18/0x20
> Nov 22 22:14:06 dmdtech kernel:  [<c0120984>] do_softirq+0x44/0xa0
> Nov 22 22:14:06 dmdtech kernel:  [<c010baa3>] do_IRQ+0x113/0x150
> Nov 22 22:14:06 dmdtech kernel:  [<c0109de8>] common_interrupt+0x18/0x20
> Nov 22 22:14:06 dmdtech kernel:  [<c01668b4>] d_alloc+0xc4/0x200
> Nov 22 22:14:06 dmdtech kernel:  [<c0166d83>] d_lookup+0x23/0x50
> Nov 22 22:14:06 dmdtech kernel:  [<c015cb62>] real_lookup+0xa2/0xf0
> Nov 22 22:14:06 dmdtech kernel:  [<c015cdf6>] do_lookup+0x86/0xa0
> Nov 22 22:14:06 dmdtech kernel:  [<c015cf34>] link_path_walk+0x124/0x920
> Nov 22 22:14:06 dmdtech kernel:  [<c0161d41>] do_select+0x181/0x280
> Nov 22 22:14:06 dmdtech kernel:  [<c01408c1>] unmap_page_range+0x41/0x70
> Nov 22 22:14:06 dmdtech kernel:  [<c015e027>] open_namei+0x87/0x3f0
> Nov 22 22:14:06 dmdtech kernel:  [<c0161a30>] __pollwait+0x0/0xb0
> Nov 22 22:14:06 dmdtech kernel:  [<c014e851>] filp_open+0x41/0x70
> Nov 22 22:14:06 dmdtech kernel:  [<c014ed13>] sys_open+0x53/0x90
> Nov 22 22:14:06 dmdtech kernel:  [<c010947b>] syscall_call+0x7/0xb
> Nov 22 22:14:06 dmdtech kernel:
> Nov 22 22:14:06 dmdtech kernel: handlers:
> Nov 22 22:14:06 dmdtech kernel: [<c01ac9ce>] (acpi_irq+0x0/0x1a)
> Nov 22 22:14:06 dmdtech kernel: Disabling IRQ #9
> 
> /proc/interrupts:
> 
>            CPU0
>   0:    7765751    IO-APIC-edge  timer
>   1:     287249    IO-APIC-edge  i8042
>   2:          0          XT-PIC  cascade
>   8:          2    IO-APIC-edge  rtc
>   9:     100000   IO-APIC-level  acpi (Curious note: Every time its done
> this, the count stops at 100000)
>  14:      23788    IO-APIC-edge  ide0
>  17:     107243   IO-APIC-level  eth0
>  18:     142287   IO-APIC-level  eth1
> NMI:          0
> LOC:    7765938
> ERR:          0
> MIS:          0
> 
> dmesg:
> Linux version 2.6.0-test9 (root@dmdtech.org) (gcc version 3.2.2 20030222
> (Red Hat Linux 3.2.2-5)) #4 Sat Nov 22 08:26:58 CST 2003
> BIOS-provided physical RAM map:
>  BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
>  BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
>  BIOS-e820: 00000000000ec000 - 0000000000100000 (reserved)
>  BIOS-e820: 0000000000100000 - 000000001fff0000 (usable)
>  BIOS-e820: 000000001fff0000 - 000000001fff8000 (ACPI data)
>  BIOS-e820: 000000001fff8000 - 0000000020000000 (ACPI NVS)
>  BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
>  BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
>  BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
> 511MB LOWMEM available.
> found SMP MP-table at 000fb210
> hm, page 000fb000 reserved twice.
> hm, page 000fc000 reserved twice.
> hm, page 000f5000 reserved twice.
> hm, page 000f6000 reserved twice.
> On node 0 totalpages: 131056
>   DMA zone: 4096 pages, LIFO batch:1
>   Normal zone: 126960 pages, LIFO batch:16
>   HighMem zone: 0 pages, LIFO batch:1
> DMI 2.3 present.
> ACPI: RSDP (v000 AMI                                       ) @ 0x000fa970
> ACPI: RSDT (v001 AMIINT VIA_K7   0x00000010 MSFT 0x00000097) @ 0x1fff0000
> ACPI: FADT (v001 AMIINT VIA_K7   0x00000011 MSFT 0x00000097) @ 0x1fff0030
> ACPI: MADT (v001 AMIINT          0x00000009 MSFT 0x00000097) @ 0x1fff00b0
> ACPI: DSDT (v001    VIA   VT8371 0x00001000 MSFT 0x0100000b) @ 0x00000000
> ACPI: Local APIC address 0xfee00000
> ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
> Processor #0 6:4 APIC version 16
> ACPI: IOAPIC (id[0x02] address[0xfec00000] global_irq_base[0x0])
> IOAPIC[0]: Assigned apic_id 2
> IOAPIC[0]: apic_id 2, version 17, address 0xfec00000, IRQ 0-23
> ACPI: INT_SRC_OVR (bus[0] irq[0x0] global_irq[0x2] polarity[0x0]
> trigger[0x0])
> ACPI: INT_SRC_OVR (bus[0] irq[0x9] global_irq[0x9] polarity[0x3]
> trigger[0x3])
> Enabling APIC mode:  Flat.  Using 1 I/O APICs
> Using ACPI (MADT) for SMP configuration information
> Building zonelist for node : 0
> Kernel command line: ro root=/dev/hda2
> Initializing CPU#0
> PID hash table entries: 2048 (order 11: 16384 bytes)
> Detected 1100.526 MHz processor.
> Console: colour VGA+ 80x25
> Memory: 515908k/524224k available (1452k kernel code, 7568k reserved, 632k
> data, 132k init, 0k highmem)
> Calibrating delay loop... 2162.68 BogoMIPS
> Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
> Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
> Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
> CPU:     After generic identify, caps: 0183fbff c1c7fbff 00000000 00000000
> CPU:     After vendor identify, caps: 0183fbff c1c7fbff 00000000 00000000
> CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
> CPU: L2 Cache: 256K (64 bytes/line)
> CPU:     After all inits, caps: 0183fbff c1c7fbff 00000000 00000020
> Intel machine check architecture supported.
> Intel machine check reporting enabled on CPU#0.
> CPU: AMD Athlon(tm) Processor stepping 02
> Enabling fast FPU save and restore... done.
> Checking 'hlt' instruction... OK.
> POSIX conformance testing by UNIFIX
> enabled ExtINT on CPU#0
> ESR value before enabling vector: 00000080
> ESR value after enabling vector: 00000000
> ENABLING IO-APIC IRQs
> init IO_APIC IRQs
>  IO-APIC (apicid-pin) 2-0, 2-16, 2-17, 2-18, 2-19, 2-20, 2-21, 2-22, 2-23
> not connected.
> ..TIMER: vector=0x31 pin1=2 pin2=-1
> number of MP IRQ sources: 15.
> number of IO-APIC #2 registers: 24.
> testing the IO APIC.......................
> IO APIC #2......
> .... register #00: 02000000
> .......    : physical APIC id: 02
> .......    : Delivery Type: 0
> .......    : LTS          : 0
> .... register #01: 00178011
> .......     : max redirection entries: 0017
> .......     : PRQ implemented: 1
> .......     : IO APIC version: 0011
> .... register #02: 00000000
> .......     : arbitration: 00
> .... IRQ redirection table:
>  NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:
>  00 000 00  1    0    0   0   0    0    0    00
>  01 001 01  0    0    0   0   0    1    1    39
>  02 001 01  0    0    0   0   0    1    1    31
>  03 001 01  0    0    0   0   0    1    1    41
>  04 001 01  0    0    0   0   0    1    1    49
>  05 001 01  0    0    0   0   0    1    1    51
>  06 001 01  0    0    0   0   0    1    1    59
>  07 001 01  0    0    0   0   0    1    1    61
>  08 001 01  0    0    0   0   0    1    1    69
>  09 001 01  1    1    0   1   0    1    1    71
>  0a 001 01  0    0    0   0   0    1    1    79
>  0b 001 01  0    0    0   0   0    1    1    81
>  0c 001 01  0    0    0   0   0    1    1    89
>  0d 001 01  0    0    0   0   0    1    1    91
>  0e 001 01  0    0    0   0   0    1    1    99
>  0f 001 01  0    0    0   0   0    1    1    A1
>  10 000 00  1    0    0   0   0    0    0    00
>  11 000 00  1    0    0   0   0    0    0    00
>  12 000 00  1    0    0   0   0    0    0    00
>  13 000 00  1    0    0   0   0    0    0    00
>  14 000 00  1    0    0   0   0    0    0    00
>  15 000 00  1    0    0   0   0    0    0    00
>  16 000 00  1    0    0   0   0    0    0    00
>  17 000 00  1    0    0   0   0    0    0    00
> IRQ to pin mappings:
> IRQ0 -> 0:2
> IRQ1 -> 0:1
> IRQ3 -> 0:3
> IRQ4 -> 0:4
> IRQ5 -> 0:5
> IRQ6 -> 0:6
> IRQ7 -> 0:7
> IRQ8 -> 0:8
> IRQ9 -> 0:9
> IRQ10 -> 0:10
> IRQ11 -> 0:11
> IRQ12 -> 0:12
> IRQ13 -> 0:13
> IRQ14 -> 0:14
> IRQ15 -> 0:15
> .................................... done.
> Using local APIC timer interrupts.
> calibrating APIC timer ...
> ..... CPU clock speed is 1099.0857 MHz.
> ..... host bus clock speed is 199.0974 MHz.
> NET: Registered protocol family 16
> PCI: PCI BIOS revision 2.10 entry at 0xfdb31, last bus=1
> PCI: Using configuration type 1
> mtrr: v2.0 (20020519)
> ACPI: Subsystem revision 20031002
> IOAPIC[0]: Set PCI routing entry (2-9 -> 0x71 -> IRQ 9 Mode:1 Active:1)
> ACPI: Interpreter enabled
> ACPI: Using IOAPIC for interrupt routing
> ACPI: PCI Root Bridge [PCI0] (00:00)
> PCI: Probing PCI hardware (bus 00)
> ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
> ACPI: Power Resource [URP1] (off)
> ACPI: Power Resource [URP2] (off)
> ACPI: Power Resource [FDDP] (off)
> ACPI: Power Resource [LPTP] (off)
> ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 *10 11 12 14 15)
> ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 10 11 12 14 15)
> ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 10 11 *12 14 15)
> ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 10 *11 12 14 15)
> Linux Plug and Play Support v0.97 (c) Adam Belay
> SCSI subsystem initialized
> IOAPIC[0]: Set PCI routing entry (2-12 -> 0xa9 -> IRQ 28 Mode:1 Active:1)
> 00:00:07[C] -> 2-12 -> IRQ 28
> IOAPIC[0]: Set PCI routing entry (2-11 -> 0xb1 -> IRQ 27 Mode:1 Active:1)
> 00:00:07[D] -> 2-11 -> IRQ 27
> IOAPIC[0]: Set PCI routing entry (2-17 -> 0xb9 -> IRQ 17 Mode:1 Active:1)
> 00:00:09[A] -> 2-17 -> IRQ 17
> IOAPIC[0]: Set PCI routing entry (2-18 -> 0xc1 -> IRQ 18 Mode:1 Active:1)
> 00:00:09[B] -> 2-18 -> IRQ 18
> IOAPIC[0]: Set PCI routing entry (2-19 -> 0xc9 -> IRQ 19 Mode:1 Active:1)
> 00:00:09[C] -> 2-19 -> IRQ 19
> IOAPIC[0]: Set PCI routing entry (2-16 -> 0xd1 -> IRQ 16 Mode:1 Active:1)
> 00:00:09[D] -> 2-16 -> IRQ 16
> Pin 2-18 already programmed
> Pin 2-19 already programmed
> Pin 2-16 already programmed
> Pin 2-17 already programmed
> Pin 2-19 already programmed
> Pin 2-16 already programmed
> Pin 2-17 already programmed
> Pin 2-18 already programmed
> Pin 2-16 already programmed
> Pin 2-17 already programmed
> Pin 2-18 already programmed
> Pin 2-19 already programmed
> Pin 2-17 already programmed
> Pin 2-18 already programmed
> Pin 2-19 already programmed
> Pin 2-16 already programmed
> Pin 2-16 already programmed
> Pin 2-17 already programmed
> PCI: Using ACPI for IRQ routing
> PCI: if you experience problems, try using option 'pci=noacpi' or even
> 'acpi=off'
> Machine check exception polling timer started.
> Initializing Cryptographic API
> Applying VIA southbridge workaround.
> PCI: Enabling Via external APIC routing
> ACPI: Power Button (FF) [PWRF]
> ACPI: Sleep Button (CM) [SLPB]
> ACPI: Processor [CPU1] (supports C1, 16 throttling states)
> isapnp: Scanning for PnP cards...
> isapnp: No Plug & Play device found
> pty: 256 Unix98 ptys configured
> Serial: 8250/16550 driver $Revision: 1.90 $ 8 ports, IRQ sharing disabled
> ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
> ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
> Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
> ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
> VP_IDE: IDE controller at PCI slot 0000:00:07.1
> VP_IDE: chipset revision 6
> VP_IDE: not 100% native mode: will probe irqs later
> ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
> VP_IDE: VIA vt82c686b (rev 40) IDE UDMA100 controller on pci0000:00:07.1
>     ide0: BM-DMA at 0xffa0-0xffa7, BIOS settings: hda:DMA, hdb:pio
> hda: IBM-DJNA-370910, ATA DISK drive
> Using anticipatory io scheduler
> ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
> hda: max request size: 128KiB
> hda: 17803440 sectors (9115 MB) w/1966KiB Cache, CHS=17662/16/63
>  hda: hda1 hda2
> mice: PS/2 mouse device common for all mice
> serio: i8042 AUX port at 0x60,0x64 irq 12
> input: AT Translated Set 2 keyboard on isa0060/serio0
> serio: i8042 KBD port at 0x60,0x64 irq 1
> NET: Registered protocol family 2
> IP: routing cache hash table of 4096 buckets, 32Kbytes
> TCP: Hash tables configured (established 32768 bind 65536)
> EXT3-fs: INFO: recovery required on readonly filesystem.
> EXT3-fs: write access will be enabled during recovery.
> kjournald starting.  Commit interval 5 seconds
> EXT3-fs: recovery complete.
> EXT3-fs: mounted filesystem with ordered data mode.
> VFS: Mounted root (ext3 filesystem) readonly.
> Freeing unused kernel memory: 132k freed
> NET: Registered protocol family 1
> Real Time Clock Driver v1.12
> EXT3 FS on hda2, internal journal
> Adding 393552k swap on /dev/hda1.  Priority:-1 extents:1
> ip_tables: (C) 2000-2002 Netfilter core team
> NET: Registered protocol family 17
> 3c59x: Donald Becker and others. www.scyld.com/network/vortex.html
> 0000:00:0d.0: 3Com PCI 3c905B Cyclone 100baseTx at 0xc000. Vers LK1.1.19
> eepro100.c:v1.09j-t 9/29/99 Donald Becker
> http://www.scyld.com/network/eepro100.html
> eepro100.c: $Revision: 1.36 $ 2000/11/17 Modified by Andrey V. Savochkin
> <saw@saw.sw.com.sg> and others
> eth1: OEM i82557/i82558 10/100 Ethernet, 00:50:8B:63:09:39, IRQ 18.
>   Receiver lock-up bug exists -- enabling work-around.
>   Board assembly 702536-009, Physical connectors present: RJ45
>   Primary interface chip i82555 PHY #1.
>   General self-test: passed.
>   Serial sub-system self-test: passed.
>   Internal registers self-test: passed.
>   ROM checksum self-test: passed (0x24c9f043).
>   Receiver lock-up workaround activated.
> Bridge firewalling registered
> eth0: Setting promiscuous mode.
> device eth0 entered promiscuous mode
> device eth1 entered promiscuous mode
> bridge0: port 2(eth1) entering learning state
> bridge0: port 1(eth0) entering learning state
> ip_conntrack version 2.1 (4095 buckets, 32760 max) - 300 bytes per conntrack
> bridge0: topology change detected, propgating
> bridge0: port 2(eth1) entering forwarding state
> bridge0: topology change detected, propgating
> bridge0: port 1(eth0) entering forwarding state
> 
Darren,

http://bugme.osdl.org/show_bug.cgi?id=1352

Does this bug match your system at all?

thanks,
  Joshua




