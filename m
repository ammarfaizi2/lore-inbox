Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261440AbTHSUsf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Aug 2003 16:48:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261431AbTHSUsN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Aug 2003 16:48:13 -0400
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:27918
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id S261245AbTHSUhR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Aug 2003 16:37:17 -0400
Date: Tue, 19 Aug 2003 13:37:12 -0700
From: Mike Fedyk <mfedyk@matchmail.com>
To: linux-kernel@vger.kernel.org
Subject: md: bug in file raid5.c, line 1909 in 2.4.22-pre7
Message-ID: <20030819203712.GB4083@matchmail.com>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="4SFOXa2GPu3tIq4H"
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--4SFOXa2GPu3tIq4H
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

I have another report against rc1 also, but this is with a different line
number and under different circumstances, but with the same hardware.

Details in dmesg file.

--4SFOXa2GPu3tIq4H
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="raid-2.4.22-pre7-bug-dmesg"

Aug 15 15:25:27 srv-lr2600 kernel: Linux version 2.4.22-pre7 (root@mis-mike-wstn) (gcc version 2.95.4 20011002 (Debian prerelease)) #1 SMP Mon Jul 21 12:59:55 PDT 2003
Aug 15 15:25:27 srv-lr2600 kernel: BIOS-provided physical RAM map:
Aug 15 15:25:27 srv-lr2600 kernel:  BIOS-e820: 0000000000000000 - 000000000009f800 (usable)
Aug 15 15:25:27 srv-lr2600 kernel:  BIOS-e820: 000000000009f800 - 00000000000a0000 (reserved)
Aug 15 15:25:27 srv-lr2600 kernel:  BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
Aug 15 15:25:27 srv-lr2600 kernel:  BIOS-e820: 0000000000100000 - 000000005fffc000 (usable)
Aug 15 15:25:27 srv-lr2600 kernel:  BIOS-e820: 000000005fffc000 - 000000005ffff000 (ACPI data)
Aug 15 15:25:27 srv-lr2600 kernel:  BIOS-e820: 000000005ffff000 - 0000000060000000 (ACPI NVS)
Aug 15 15:25:27 srv-lr2600 kernel:  BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
Aug 15 15:25:27 srv-lr2600 kernel:  BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
Aug 15 15:25:27 srv-lr2600 kernel:  BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
Aug 15 15:25:27 srv-lr2600 kernel: 639MB HIGHMEM available.
Aug 15 15:25:27 srv-lr2600 kernel: 896MB LOWMEM available.
Aug 15 15:25:27 srv-lr2600 kernel: ACPI: have wakeup address 0xc0002000
Aug 15 15:25:27 srv-lr2600 kernel: On node 0 totalpages: 393212
Aug 15 15:25:27 srv-lr2600 kernel: zone(0): 4096 pages.
Aug 15 15:25:27 srv-lr2600 kernel: zone(1): 225280 pages.
Aug 15 15:25:27 srv-lr2600 kernel: zone(2): 163836 pages.
Aug 15 15:25:27 srv-lr2600 kernel: ACPI: RSDP (v000 ASUS                       ) @ 0x000f5dc0
Aug 15 15:25:27 srv-lr2600 kernel: ACPI: RSDT (v001 ASUS   A7V8X-X  16944.11825) @ 0x5fffc000
Aug 15 15:25:27 srv-lr2600 kernel: ACPI: FADT (v001 ASUS   A7V8X-X  16944.11825) @ 0x5fffc0b2
Aug 15 15:25:27 srv-lr2600 kernel: ACPI: BOOT (v001 ASUS   A7V8X-X  16944.11825) @ 0x5fffc030
Aug 15 15:25:27 srv-lr2600 kernel: ACPI: MADT (v001 ASUS   A7V8X-X  16944.11825) @ 0x5fffc058
Aug 15 15:25:27 srv-lr2600 kernel: ACPI: DSDT (v001   ASUS A7V8X-X  00000.04096) @ 0x00000000
Aug 15 15:25:27 srv-lr2600 kernel: ACPI: BIOS passes blacklist
Aug 15 15:25:27 srv-lr2600 kernel: ACPI: Local APIC address 0xfee00000
Aug 15 15:25:27 srv-lr2600 kernel: ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
Aug 15 15:25:27 srv-lr2600 kernel: Processor #0 Pentium(tm) Pro APIC version 16
Aug 15 15:25:27 srv-lr2600 kernel: ACPI: LAPIC_NMI (acpi_id[0x00] polarity[0x1] trigger[0x1] lint[0x1])
Aug 15 15:25:27 srv-lr2600 kernel: ACPI: IOAPIC (id[0x02] address[0xfec00000] global_irq_base[0x0])
Aug 15 15:25:27 srv-lr2600 kernel: IOAPIC[0]: Assigned apic_id 2
Aug 15 15:25:27 srv-lr2600 kernel: IOAPIC[0]: apic_id 2, version 3, address 0xfec00000, IRQ 0-23
Aug 15 15:25:27 srv-lr2600 kernel: ACPI: INT_SRC_OVR (bus[0] irq[0x0] global_irq[0x2] polarity[0x0] trigger[0x1])
Aug 15 15:25:27 srv-lr2600 kernel: ACPI: INT_SRC_OVR (bus[0] irq[0x9] global_irq[0x9] polarity[0x3] trigger[0x3])
Aug 15 15:25:27 srv-lr2600 kernel: Using ACPI (MADT) for SMP configuration information
Aug 15 15:25:27 srv-lr2600 kernel: Kernel command line: auto BOOT_IMAGE=Linux ro root=900 console=ttyS0,9600 console=tty0 ide=reverse
Aug 15 15:25:27 srv-lr2600 kernel: ide_setup: ide=reverse : Enabled support for IDE inverse scan order.
Aug 15 15:25:27 srv-lr2600 kernel: Initializing CPU#0
Aug 15 15:25:27 srv-lr2600 kernel: Detected 2083.159 MHz processor.
Aug 15 15:25:27 srv-lr2600 kernel: Console: colour VGA+ 80x50
Aug 15 15:25:27 srv-lr2600 kernel: Calibrating delay loop... 4154.98 BogoMIPS
Aug 15 15:25:27 srv-lr2600 kernel: Memory: 1550912k/1572848k available (1718k kernel code, 21548k reserved, 689k data, 128k init, 655344k highmem)
Aug 15 15:25:27 srv-lr2600 kernel: Dentry cache hash table entries: 262144 (order: 9, 2097152 bytes)
Aug 15 15:25:27 srv-lr2600 kernel: Inode cache hash table entries: 131072 (order: 8, 1048576 bytes)
Aug 15 15:25:27 srv-lr2600 kernel: Mount cache hash table entries: 512 (order: 0, 4096 bytes)
Aug 15 15:25:27 srv-lr2600 kernel: Buffer cache hash table entries: 131072 (order: 7, 524288 bytes)
Aug 15 15:25:27 srv-lr2600 kernel: Page-cache hash table entries: 524288 (order: 9, 2097152 bytes)
Aug 15 15:25:27 srv-lr2600 kernel: CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
Aug 15 15:25:27 srv-lr2600 kernel: CPU: L2 Cache: 256K (64 bytes/line)
Aug 15 15:25:27 srv-lr2600 kernel: Intel machine check architecture supported.
Aug 15 15:25:27 srv-lr2600 kernel: Intel machine check reporting enabled on CPU#0.
Aug 15 15:25:27 srv-lr2600 kernel: CPU:     After generic, caps: 0383fbff c1c3fbff 00000000 00000000
Aug 15 15:25:27 srv-lr2600 kernel: CPU:             Common caps: 0383fbff c1c3fbff 00000000 00000000
Aug 15 15:25:27 srv-lr2600 kernel: Enabling fast FPU save and restore... done.
Aug 15 15:25:27 srv-lr2600 kernel: Enabling unmasked SIMD FPU exception support... done.
Aug 15 15:25:27 srv-lr2600 kernel: Checking 'hlt' instruction... OK.
Aug 15 15:25:27 srv-lr2600 kernel: POSIX conformance testing by UNIFIX
Aug 15 15:25:27 srv-lr2600 kernel: mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
Aug 15 15:25:27 srv-lr2600 kernel: mtrr: detected mtrr type: Intel
Aug 15 15:25:27 srv-lr2600 kernel: CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
Aug 15 15:25:27 srv-lr2600 kernel: CPU: L2 Cache: 256K (64 bytes/line)
Aug 15 15:25:27 srv-lr2600 kernel: Intel machine check reporting enabled on CPU#0.
Aug 15 15:25:27 srv-lr2600 kernel: CPU:     After generic, caps: 0383fbff c1c3fbff 00000000 00000000
Aug 15 15:25:27 srv-lr2600 kernel: CPU:             Common caps: 0383fbff c1c3fbff 00000000 00000000
Aug 15 15:25:27 srv-lr2600 kernel: CPU0: AMD Athlon(TM) XP 2600+ stepping 01
Aug 15 15:25:27 srv-lr2600 kernel: per-CPU timeslice cutoff: 731.36 usecs.
Aug 15 15:25:27 srv-lr2600 kernel: enabled ExtINT on CPU#0
Aug 15 15:25:27 srv-lr2600 kernel: ESR value before enabling vector: 00000000
Aug 15 15:25:27 srv-lr2600 kernel: ESR value after enabling vector: 00000000
Aug 15 15:25:27 srv-lr2600 kernel: Error: only one processor found.
Aug 15 15:25:27 srv-lr2600 kernel: ENABLING IO-APIC IRQs
Aug 15 15:25:27 srv-lr2600 kernel: init IO_APIC IRQs
Aug 15 15:25:27 srv-lr2600 kernel:  IO-APIC (apicid-pin) 2-0, 2-16, 2-17, 2-18, 2-19, 2-20, 2-21, 2-22, 2-23 not connected.
Aug 15 15:25:27 srv-lr2600 kernel: ..TIMER: vector=0x31 pin1=2 pin2=0
Aug 15 15:25:27 srv-lr2600 kernel: number of MP IRQ sources: 16.
Aug 15 15:25:27 srv-lr2600 kernel: number of IO-APIC #2 registers: 24.
Aug 15 15:25:27 srv-lr2600 kernel: testing the IO APIC.......................
Aug 15 15:25:27 srv-lr2600 kernel: 
Aug 15 15:25:27 srv-lr2600 kernel: IO APIC #2......
Aug 15 15:25:27 srv-lr2600 kernel: .... register #00: 02000000
Aug 15 15:25:27 srv-lr2600 kernel: .......    : physical APIC id: 02
Aug 15 15:25:27 srv-lr2600 kernel: .......    : Delivery Type: 0
Aug 15 15:25:27 srv-lr2600 kernel: .......    : LTS          : 0
Aug 15 15:25:27 srv-lr2600 kernel: .... register #01: 00178003
Aug 15 15:25:27 srv-lr2600 kernel: .......     : max redirection entries: 0017
Aug 15 15:25:27 srv-lr2600 kernel: .......     : PRQ implemented: 1
Aug 15 15:25:27 srv-lr2600 kernel: .......     : IO APIC version: 0003
Aug 15 15:25:27 srv-lr2600 kernel: .... IRQ redirection table:
Aug 15 15:25:27 srv-lr2600 kernel:  NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:   
Aug 15 15:25:27 srv-lr2600 kernel:  00 000 00  1    0    0   0   0    0    0    00
Aug 15 15:25:27 srv-lr2600 kernel:  01 001 01  0    0    0   0   0    1    1    39
Aug 15 15:25:27 srv-lr2600 kernel:  02 001 01  0    0    0   0   0    1    1    31
Aug 15 15:25:27 srv-lr2600 kernel:  03 001 01  0    0    0   0   0    1    1    41
Aug 15 15:25:27 srv-lr2600 kernel:  04 001 01  0    0    0   0   0    1    1    49
Aug 15 15:25:27 srv-lr2600 kernel:  05 001 01  0    0    0   0   0    1    1    51
Aug 15 15:25:27 srv-lr2600 kernel:  06 001 01  0    0    0   0   0    1    1    59
Aug 15 15:25:27 srv-lr2600 kernel:  07 001 01  0    0    0   0   0    1    1    61
Aug 15 15:25:27 srv-lr2600 kernel:  08 001 01  0    0    0   0   0    1    1    69
Aug 15 15:25:27 srv-lr2600 kernel:  09 001 01  1    1    0   1   0    1    1    71
Aug 15 15:25:27 srv-lr2600 kernel:  0a 001 01  0    0    0   0   0    1    1    79
Aug 15 15:25:27 srv-lr2600 kernel:  0b 001 01  0    0    0   0   0    1    1    81
Aug 15 15:25:27 srv-lr2600 kernel:  0c 001 01  0    0    0   0   0    1    1    89
Aug 15 15:25:27 srv-lr2600 kernel:  0d 001 01  0    0    0   0   0    1    1    91
Aug 15 15:25:27 srv-lr2600 kernel:  0e 001 01  0    0    0   0   0    1    1    99
Aug 15 15:25:27 srv-lr2600 kernel:  0f 001 01  0    0    0   0   0    1    1    A1
Aug 15 15:25:27 srv-lr2600 kernel:  10 000 00  1    0    0   0   0    0    0    00
Aug 15 15:25:27 srv-lr2600 kernel:  11 000 00  1    0    0   0   0    0    0    00
Aug 15 15:25:27 srv-lr2600 kernel:  12 000 00  1    0    0   0   0    0    0    00
Aug 15 15:25:27 srv-lr2600 kernel:  13 000 00  1    0    0   0   0    0    0    00
Aug 15 15:25:27 srv-lr2600 kernel:  14 000 00  1    0    0   0   0    0    0    00
Aug 15 15:25:27 srv-lr2600 kernel:  15 000 00  1    0    0   0   0    0    0    00
Aug 15 15:25:27 srv-lr2600 kernel:  16 000 00  1    0    0   0   0    0    0    00
Aug 15 15:25:27 srv-lr2600 kernel:  17 000 00  1    0    0   0   0    0    0    00
Aug 15 15:25:27 srv-lr2600 kernel: IRQ to pin mappings:
Aug 15 15:25:27 srv-lr2600 kernel: IRQ0 -> 0:2
Aug 15 15:25:27 srv-lr2600 kernel: IRQ1 -> 0:1
Aug 15 15:25:27 srv-lr2600 kernel: IRQ3 -> 0:3
Aug 15 15:25:27 srv-lr2600 kernel: IRQ4 -> 0:4
Aug 15 15:25:27 srv-lr2600 kernel: IRQ5 -> 0:5
Aug 15 15:25:27 srv-lr2600 kernel: IRQ6 -> 0:6
Aug 15 15:25:27 srv-lr2600 kernel: IRQ7 -> 0:7
Aug 15 15:25:27 srv-lr2600 kernel: IRQ8 -> 0:8
Aug 15 15:25:27 srv-lr2600 kernel: IRQ9 -> 0:9
Aug 15 15:25:27 srv-lr2600 kernel: IRQ10 -> 0:10
Aug 15 15:25:27 srv-lr2600 kernel: IRQ11 -> 0:11
Aug 15 15:25:27 srv-lr2600 kernel: IRQ12 -> 0:12
Aug 15 15:25:27 srv-lr2600 kernel: IRQ13 -> 0:13
Aug 15 15:25:27 srv-lr2600 kernel: IRQ14 -> 0:14
Aug 15 15:25:27 srv-lr2600 kernel: IRQ15 -> 0:15
Aug 15 15:25:27 srv-lr2600 kernel: .................................... done.
Aug 15 15:25:27 srv-lr2600 kernel: Using local APIC timer interrupts.
Aug 15 15:25:27 srv-lr2600 kernel: calibrating APIC timer ...
Aug 15 15:25:27 srv-lr2600 kernel: ..... CPU clock speed is 2083.1399 MHz.
Aug 15 15:25:27 srv-lr2600 kernel: ..... host bus clock speed is 333.3024 MHz.
Aug 15 15:25:27 srv-lr2600 kernel: cpu: 0, clocks: 3333024, slice: 1666512
Aug 15 15:25:27 srv-lr2600 kernel: CPU0<T0:3333024,T1:1666512,D:0,S:1666512,C:3333024>
Aug 15 15:25:27 srv-lr2600 kernel: Waiting on wait_init_idle (map = 0x0)
Aug 15 15:25:27 srv-lr2600 kernel: All processors have done init_idle
Aug 15 15:25:27 srv-lr2600 kernel: ACPI: Subsystem revision 20030619
Aug 15 15:25:27 srv-lr2600 kernel: PCI: PCI BIOS revision 2.10 entry at 0xf15e0, last bus=1
Aug 15 15:25:27 srv-lr2600 kernel: PCI: Using configuration type 1
Aug 15 15:25:27 srv-lr2600 kernel:  tbxface-0117 [03] acpi_load_tables      : ACPI Tables successfully acquired
Aug 15 15:25:27 srv-lr2600 kernel: Parsing all Control Methods:.........................................................................................................................
Aug 15 15:25:27 srv-lr2600 kernel: Table [DSDT](id F004) - 343 Objects with 47 Devices 121 Methods 16 Regions
Aug 15 15:25:27 srv-lr2600 kernel: ACPI Namespace successfully loaded at root c03b393c
Aug 15 15:25:27 srv-lr2600 kernel: evxfevnt-0093 [04] acpi_enable           : Transition to ACPI mode successful
Aug 15 15:25:27 srv-lr2600 kernel: evgpeblk-0748 [06] ev_create_gpe_block   : GPE 00 to 15 [_GPE] 2 regs at 000000000000E420 on int 9
Aug 15 15:25:27 srv-lr2600 kernel: Completing Region/Field/Buffer/Package initialization:...................................................
Aug 15 15:25:27 srv-lr2600 kernel: Initialized 16/16 Regions 2/2 Fields 22/22 Buffers 11/11 Packages (351 nodes)
Aug 15 15:25:27 srv-lr2600 kernel: Executing all Device _STA and_INI methods:................................................
Aug 15 15:25:27 srv-lr2600 kernel: 48 Devices found containing: 48 _STA, 1 _INI methods
Aug 15 15:25:27 srv-lr2600 kernel: ACPI: Interpreter enabled
Aug 15 15:25:27 srv-lr2600 kernel: ACPI: Using IOAPIC for interrupt routing
Aug 15 15:25:27 srv-lr2600 kernel: ACPI: System [ACPI] (supports S0 S1 S4 S5)
Aug 15 15:25:27 srv-lr2600 kernel: ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 10 *11 12 14 15)
Aug 15 15:25:27 srv-lr2600 kernel: ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 *10 11 12 14 15)
Aug 15 15:25:27 srv-lr2600 kernel: ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 10 11 12 14 15, disabled)
Aug 15 15:25:27 srv-lr2600 kernel: ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 10 11 12 14 15, disabled)
Aug 15 15:25:27 srv-lr2600 kernel: ACPI: PCI Interrupt Link [LNKE] (IRQs *3 4 5 6 7 10 11 12 14)
Aug 15 15:25:27 srv-lr2600 kernel: ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 7 10 11 12 14 15, disabled)
Aug 15 15:25:27 srv-lr2600 kernel: ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 *5 6 7 10 11 12 14 15)
Aug 15 15:25:27 srv-lr2600 kernel: ACPI: PCI Root Bridge [PCI0] (00:00)
Aug 15 15:25:27 srv-lr2600 kernel: PCI: Probing PCI hardware (bus 00)
Aug 15 15:25:27 srv-lr2600 kernel: ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
Aug 15 15:25:27 srv-lr2600 kernel: ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCI1._PRT]
Aug 15 15:25:27 srv-lr2600 kernel: PCI: Probing PCI hardware
Aug 15 15:25:27 srv-lr2600 kernel: ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 11
Aug 15 15:25:27 srv-lr2600 kernel: ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 10
Aug 15 15:25:27 srv-lr2600 kernel: pci_link-0345 [16] acpi_pci_link_set     : Link disabled
Aug 15 15:25:27 srv-lr2600 kernel: ACPI: PCI Interrupt Link [LNKF] enabled at IRQ 0
Aug 15 15:25:27 srv-lr2600 kernel: IOAPIC[0]: Set PCI routing entry (2-17 -> 0xa9 -> IRQ 17)
Aug 15 15:25:27 srv-lr2600 kernel: 00:00:07[A] -> 2-17 -> IRQ 17
Aug 15 15:25:27 srv-lr2600 kernel: Pin 2-17 already programmed
Aug 15 15:25:27 srv-lr2600 kernel: IOAPIC[0]: Set PCI routing entry (2-18 -> 0xb1 -> IRQ 18)
Aug 15 15:25:27 srv-lr2600 kernel: 00:00:09[A] -> 2-18 -> IRQ 18
Aug 15 15:25:27 srv-lr2600 kernel: IOAPIC[0]: Set PCI routing entry (2-19 -> 0xb9 -> IRQ 19)
Aug 15 15:25:27 srv-lr2600 kernel: 00:00:0c[A] -> 2-19 -> IRQ 19
Aug 15 15:25:27 srv-lr2600 kernel: IOAPIC[0]: Set PCI routing entry (2-16 -> 0xc1 -> IRQ 16)
Aug 15 15:25:27 srv-lr2600 kernel: 00:00:0c[B] -> 2-16 -> IRQ 16
Aug 15 15:25:27 srv-lr2600 kernel: Pin 2-17 already programmed
Aug 15 15:25:27 srv-lr2600 kernel: Pin 2-18 already programmed
Aug 15 15:25:27 srv-lr2600 kernel: Pin 2-16 already programmed
Aug 15 15:25:27 srv-lr2600 kernel: Pin 2-17 already programmed
Aug 15 15:25:27 srv-lr2600 kernel: Pin 2-18 already programmed
Aug 15 15:25:27 srv-lr2600 kernel: Pin 2-19 already programmed
Aug 15 15:25:27 srv-lr2600 kernel: Pin 2-17 already programmed
Aug 15 15:25:27 srv-lr2600 kernel: Pin 2-18 already programmed
Aug 15 15:25:27 srv-lr2600 kernel: Pin 2-19 already programmed
Aug 15 15:25:27 srv-lr2600 kernel: Pin 2-16 already programmed
Aug 15 15:25:27 srv-lr2600 kernel: Pin 2-18 already programmed
Aug 15 15:25:27 srv-lr2600 kernel: Pin 2-19 already programmed
Aug 15 15:25:27 srv-lr2600 kernel: Pin 2-16 already programmed
Aug 15 15:25:27 srv-lr2600 kernel: Pin 2-17 already programmed
Aug 15 15:25:27 srv-lr2600 kernel: Pin 2-19 already programmed
Aug 15 15:25:27 srv-lr2600 kernel: Pin 2-16 already programmed
Aug 15 15:25:27 srv-lr2600 kernel: Pin 2-17 already programmed
Aug 15 15:25:27 srv-lr2600 kernel: Pin 2-18 already programmed
Aug 15 15:25:27 srv-lr2600 kernel: Pin 2-16 already programmed
Aug 15 15:25:27 srv-lr2600 kernel: Pin 2-17 already programmed
Aug 15 15:25:27 srv-lr2600 kernel: Pin 2-18 already programmed
Aug 15 15:25:27 srv-lr2600 kernel: Pin 2-19 already programmed
Aug 15 15:25:27 srv-lr2600 kernel: IOAPIC[0]: Set PCI routing entry (2-21 -> 0xc9 -> IRQ 21)
Aug 15 15:25:27 srv-lr2600 kernel: 00:00:10[A] -> 2-21 -> IRQ 21
Aug 15 15:25:27 srv-lr2600 kernel: Pin 2-21 already programmed
Aug 15 15:25:27 srv-lr2600 last message repeated 2 times
Aug 15 15:25:27 srv-lr2600 kernel: IOAPIC[0]: Set PCI routing entry (2-22 -> 0xd1 -> IRQ 22)
Aug 15 15:25:27 srv-lr2600 kernel: 00:00:11[C] -> 2-22 -> IRQ 22
Aug 15 15:25:27 srv-lr2600 kernel: IOAPIC[0]: Set PCI routing entry (2-23 -> 0xd9 -> IRQ 23)
Aug 15 15:25:27 srv-lr2600 kernel: 00:00:12[A] -> 2-23 -> IRQ 23
Aug 15 15:25:27 srv-lr2600 kernel: Pin 2-16 already programmed
Aug 15 15:25:27 srv-lr2600 kernel: Pin 2-17 already programmed
Aug 15 15:25:27 srv-lr2600 kernel:  pci_irq-0297 [16] acpi_pci_irq_derive   : Unable to derive IRQ for device 00:11.1
Aug 15 15:25:27 srv-lr2600 kernel: PCI: No IRQ known for interrupt pin A of device 00:11.1 - using IRQ 255
Aug 15 15:25:27 srv-lr2600 kernel: PCI: Using ACPI for IRQ routing
Aug 15 15:25:27 srv-lr2600 kernel: PCI: if you experience problems, try using option 'pci=noacpi' or even 'acpi=off'
Aug 15 15:25:27 srv-lr2600 kernel: PCI: Via IRQ fixup for 00:10.0, from 3 to 5
Aug 15 15:25:27 srv-lr2600 kernel: PCI: Via IRQ fixup for 00:10.1, from 3 to 5
Aug 15 15:25:27 srv-lr2600 kernel: PCI: Via IRQ fixup for 00:10.2, from 3 to 5
Aug 15 15:25:27 srv-lr2600 kernel: isapnp: Scanning for PnP cards...
Aug 15 15:25:27 srv-lr2600 kernel: isapnp: No Plug & Play device found
Aug 15 15:25:27 srv-lr2600 kernel: Linux NET4.0 for Linux 2.4
Aug 15 15:25:27 srv-lr2600 kernel: Based upon Swansea University Computer Society NET3.039
Aug 15 15:25:27 srv-lr2600 kernel: Initializing RT netlink socket
Aug 15 15:25:27 srv-lr2600 kernel: apm: BIOS version 1.2 Flags 0x03 (Driver version 1.16)
Aug 15 15:25:27 srv-lr2600 kernel: apm: overridden by ACPI.
Aug 15 15:25:27 srv-lr2600 kernel: Starting kswapd
Aug 15 15:25:27 srv-lr2600 kernel: allocated 32 pages and 32 bhs reserved for the highmem bounces
Aug 15 15:25:27 srv-lr2600 kernel: VFS: Disk quotas vdquot_6.5.1
Aug 15 15:25:27 srv-lr2600 kernel: Journalled Block Device driver loaded
Aug 15 15:25:27 srv-lr2600 kernel: ACPI: Power Button (FF) [PWRF]
Aug 15 15:25:27 srv-lr2600 kernel: ACPI: Processor [CPU0] (supports C1)
Aug 15 15:25:27 srv-lr2600 kernel: pty: 256 Unix98 ptys configured
Aug 15 15:25:27 srv-lr2600 kernel: Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ DETECT_IRQ SERIAL_PCI ISAPNP enabled
Aug 15 15:25:27 srv-lr2600 kernel: ttyS00 at 0x03f8 (irq = 4) is a 16550A
Aug 15 15:25:27 srv-lr2600 kernel: Uniform Multi-Platform E-IDE driver Revision: 7.00beta4-2.4
Aug 15 15:25:27 srv-lr2600 kernel: ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
Aug 15 15:25:27 srv-lr2600 kernel: VP_IDE: IDE controller at PCI slot 00:11.1
Aug 15 15:25:27 srv-lr2600 kernel:  pci_irq-0297 [15] acpi_pci_irq_derive   : Unable to derive IRQ for device 00:11.1
Aug 15 15:25:27 srv-lr2600 kernel: PCI: No IRQ known for interrupt pin A of device 00:11.1 - using IRQ 255
Aug 15 15:25:27 srv-lr2600 kernel: VP_IDE: chipset revision 6
Aug 15 15:25:27 srv-lr2600 kernel: VP_IDE: not 100%% native mode: will probe irqs later
Aug 15 15:25:27 srv-lr2600 kernel: VP_IDE: VIA vt8235 (rev 00) IDE UDMA133 controller on pci00:11.1
Aug 15 15:25:27 srv-lr2600 kernel:     ide0: BM-DMA at 0xa000-0xa007, BIOS settings: hda:DMA, hdb:pio
Aug 15 15:25:27 srv-lr2600 kernel:     ide1: BM-DMA at 0xa008-0xa00f, BIOS settings: hdc:DMA, hdd:pio
Aug 15 15:25:27 srv-lr2600 kernel: SiI680: IDE controller at PCI slot 00:0e.0
Aug 15 15:25:27 srv-lr2600 kernel: SiI680: chipset revision 2
Aug 15 15:25:27 srv-lr2600 kernel: SiI680: not 100%% native mode: will probe irqs later
Aug 15 15:25:27 srv-lr2600 kernel: SiI680: BASE CLOCK == 133 
Aug 15 15:25:27 srv-lr2600 kernel:     ide2: MMIO-DMA , BIOS settings: hde:pio, hdf:pio
Aug 15 15:25:27 srv-lr2600 kernel:     ide3: MMIO-DMA , BIOS settings: hdg:pio, hdh:pio
Aug 15 15:25:27 srv-lr2600 kernel: hda: Maxtor 6Y160P0, ATA DISK drive
Aug 15 15:25:27 srv-lr2600 kernel: blk: queue c03cbf40, I/O limit 4095Mb (mask 0xffffffff)
Aug 15 15:25:27 srv-lr2600 kernel: hdc: YAMAHA CRW2100E, ATAPI CD/DVD-ROM drive
Aug 15 15:25:27 srv-lr2600 kernel: hde: Maxtor 6Y160P0, ATA DISK drive
Aug 15 15:25:27 srv-lr2600 kernel: blk: queue c03cc818, I/O limit 4095Mb (mask 0xffffffff)
Aug 15 15:25:27 srv-lr2600 kernel: hdg: Maxtor 6Y160P0, ATA DISK drive
Aug 15 15:25:27 srv-lr2600 kernel: blk: queue c03ccc84, I/O limit 4095Mb (mask 0xffffffff)
Aug 15 15:25:27 srv-lr2600 kernel: ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Aug 15 15:25:27 srv-lr2600 kernel: ide1 at 0x170-0x177,0x376 on irq 15
Aug 15 15:25:27 srv-lr2600 kernel: ide2 at 0xf880a080-0xf880a087,0xf880a08a on irq 17
Aug 15 15:25:27 srv-lr2600 kernel: ide3 at 0xf880a0c0-0xf880a0c7,0xf880a0ca on irq 17
Aug 15 15:25:27 srv-lr2600 kernel: hda: attached ide-disk driver.
Aug 15 15:25:27 srv-lr2600 kernel: hda: host protected area => 1
Aug 15 15:25:27 srv-lr2600 kernel: hda: 320173056 sectors (163929 MB) w/7936KiB Cache, CHS=19929/255/63, UDMA(133)
Aug 15 15:25:27 srv-lr2600 kernel: hde: attached ide-disk driver.
Aug 15 15:25:27 srv-lr2600 kernel: hde: host protected area => 1
Aug 15 15:25:27 srv-lr2600 kernel: hde: 320173056 sectors (163929 MB) w/7936KiB Cache, CHS=19929/255/63, UDMA(133)
Aug 15 15:25:27 srv-lr2600 kernel: hdg: attached ide-disk driver.
Aug 15 15:25:27 srv-lr2600 kernel: hdg: host protected area => 1
Aug 15 15:25:27 srv-lr2600 kernel: hdg: 320173056 sectors (163929 MB) w/7936KiB Cache, CHS=19929/255/63, UDMA(133)
Aug 15 15:25:27 srv-lr2600 kernel: Partition check:
Aug 15 15:25:27 srv-lr2600 kernel:  hda: hda1 hda2 hda3
Aug 15 15:25:27 srv-lr2600 kernel:  hde: hde1 hde2 hde3
Aug 15 15:25:27 srv-lr2600 kernel:  hdg: hdg1 hdg3
Aug 15 15:25:27 srv-lr2600 kernel: SCSI subsystem driver Revision: 1.00
Aug 15 15:25:27 srv-lr2600 kernel: kmod: failed to exec /sbin/modprobe -s -k scsi_hostadapter, errno = 2
Aug 15 15:25:27 srv-lr2600 kernel: md: linear personality registered as nr 1
Aug 15 15:25:27 srv-lr2600 kernel: md: raid0 personality registered as nr 2
Aug 15 15:25:27 srv-lr2600 kernel: md: raid1 personality registered as nr 3
Aug 15 15:25:27 srv-lr2600 kernel: md: raid5 personality registered as nr 4
Aug 15 15:25:27 srv-lr2600 kernel: raid5: measuring checksumming speed
Aug 15 15:25:27 srv-lr2600 kernel:    8regs     :  3182.000 MB/sec
Aug 15 15:25:27 srv-lr2600 kernel:    32regs    :  2588.400 MB/sec
Aug 15 15:25:27 srv-lr2600 kernel:    pIII_sse  :  2560.400 MB/sec
Aug 15 15:25:27 srv-lr2600 kernel:    pII_mmx   :  4865.200 MB/sec
Aug 15 15:25:27 srv-lr2600 kernel:    p5_mmx    :  6240.000 MB/sec
Aug 15 15:25:27 srv-lr2600 kernel: raid5: using function: pIII_sse (2560.400 MB/sec)
Aug 15 15:25:27 srv-lr2600 kernel: md: md driver 0.90.0 MAX_MD_DEVS=256, MD_SB_DISKS=27
Aug 15 15:25:27 srv-lr2600 kernel: md: Autodetecting RAID arrays.
Aug 15 15:25:27 srv-lr2600 kernel:  [events: 0001b742]
Aug 15 15:25:27 srv-lr2600 kernel:  [events: 0001b7fe]
Aug 15 15:25:27 srv-lr2600 kernel:  [events: 0001b7fe]
Aug 15 15:25:27 srv-lr2600 kernel: md: autorun ...
Aug 15 15:25:27 srv-lr2600 kernel: md: considering hdg3 ...
Aug 15 15:25:27 srv-lr2600 kernel: md:  adding hdg3 ...
Aug 15 15:25:27 srv-lr2600 kernel: md:  adding hde3 ...
Aug 15 15:25:27 srv-lr2600 kernel: md:  adding hda3 ...
Aug 15 15:25:27 srv-lr2600 kernel: md: created md0
Aug 15 15:25:27 srv-lr2600 kernel: md: bind<hda3,1>
Aug 15 15:25:27 srv-lr2600 kernel: md: bind<hde3,2>
Aug 15 15:25:27 srv-lr2600 kernel: md: bind<hdg3,3>
Aug 15 15:25:27 srv-lr2600 kernel: md: running: <hdg3><hde3><hda3>
Aug 15 15:25:27 srv-lr2600 kernel: md: hdg3's event counter: 0001b7fe
Aug 15 15:25:27 srv-lr2600 kernel: md: hde3's event counter: 0001b7fe
Aug 15 15:25:27 srv-lr2600 kernel: md: hda3's event counter: 0001b742
Aug 15 15:25:27 srv-lr2600 kernel: md: superblock update time inconsistency -- using the most recent one
Aug 15 15:25:27 srv-lr2600 kernel: md: freshest: hdg3
Aug 15 15:25:27 srv-lr2600 kernel: md: kicking non-fresh hda3 from array!

I rebooted after a failed disk was removed from the array.

Aug 15 15:25:27 srv-lr2600 kernel: md: unbind<hda3,2>
Aug 15 15:25:27 srv-lr2600 kernel: md: export_rdev(hda3)
Aug 15 15:25:27 srv-lr2600 kernel: md0: removing former faulty hda3!
Aug 15 15:25:27 srv-lr2600 kernel: md0: max total readahead window set to 512k
Aug 15 15:25:27 srv-lr2600 kernel: md0: 2 data-disks, max readahead per data-disk: 256k
Aug 15 15:25:27 srv-lr2600 kernel: raid5: device hdg3 operational as raid disk 1
Aug 15 15:25:27 srv-lr2600 kernel: raid5: device hde3 operational as raid disk 0
Aug 15 15:25:27 srv-lr2600 kernel: raid5: md0, not all disks are operational -- trying to recover array
Aug 15 15:25:27 srv-lr2600 kernel: raid5: allocated 3288kB for md0
Aug 15 15:25:27 srv-lr2600 kernel: raid5: raid level 5 set md0 active with 2 out of 3 devices, algorithm 0
Aug 15 15:25:27 srv-lr2600 kernel: RAID5 conf printout:
Aug 15 15:25:27 srv-lr2600 kernel:  --- rd:3 wd:2 fd:1
Aug 15 15:25:27 srv-lr2600 kernel:  disk 0, s:0, o:1, n:0 rd:0 us:1 dev:hde3
Aug 15 15:25:27 srv-lr2600 kernel:  disk 1, s:0, o:1, n:1 rd:1 us:1 dev:hdg3
Aug 15 15:25:27 srv-lr2600 kernel:  disk 2, s:0, o:0, n:0 rd:0 us:0 dev:[dev 00:00]
Aug 15 15:25:27 srv-lr2600 kernel: RAID5 conf printout:
Aug 15 15:25:27 srv-lr2600 kernel:  --- rd:3 wd:2 fd:1
Aug 15 15:25:27 srv-lr2600 kernel:  disk 0, s:0, o:1, n:0 rd:0 us:1 dev:hde3
Aug 15 15:25:27 srv-lr2600 kernel:  disk 1, s:0, o:1, n:1 rd:1 us:1 dev:hdg3
Aug 15 15:25:27 srv-lr2600 kernel:  disk 2, s:0, o:0, n:0 rd:0 us:0 dev:[dev 00:00]
Aug 15 15:25:27 srv-lr2600 kernel: md: updating md0 RAID superblock on device
Aug 15 15:25:27 srv-lr2600 kernel: md: hdg3 [events: 0001b7ff]<6>(write) hdg3's sb offset: 159694016
Aug 15 15:25:27 srv-lr2600 kernel: md: recovery thread got woken up ...
Aug 15 15:25:27 srv-lr2600 kernel: md0: no spare disk to reconstruct array! -- continuing in degraded mode
Aug 15 15:25:27 srv-lr2600 kernel: md: recovery thread finished ...
Aug 15 15:25:27 srv-lr2600 kernel: md: hde3 [events: 0001b7ff]<6>(write) hde3's sb offset: 159694016
Aug 15 15:25:27 srv-lr2600 kernel: md: ... autorun DONE.
Aug 15 15:25:27 srv-lr2600 kernel: LVM version 1.0.5+(22/07/2002)
Aug 15 15:25:27 srv-lr2600 kernel: Initializing Cryptographic API
Aug 15 15:25:27 srv-lr2600 kernel: NET4: Linux TCP/IP 1.0 for NET4.0
Aug 15 15:25:27 srv-lr2600 kernel: IP Protocols: ICMP, UDP, TCP, IGMP
Aug 15 15:25:27 srv-lr2600 kernel: IP: routing cache hash table of 16384 buckets, 128Kbytes
Aug 15 15:25:27 srv-lr2600 kernel: TCP: Hash tables configured (established 262144 bind 65536)
Aug 15 15:25:27 srv-lr2600 kernel: raid5: switching cache buffer size, 4096 --> 1024
Aug 15 15:25:27 srv-lr2600 kernel: raid5: switching cache buffer size, 1024 --> 4096
Aug 15 15:25:27 srv-lr2600 kernel: reiserfs: found format "3.6" with non-standard journal
Aug 15 15:25:27 srv-lr2600 kernel: reiserfs: checking transaction log (device md(9,0)) ...
Aug 15 15:25:27 srv-lr2600 kernel: for (md(9,0))
Aug 15 15:25:27 srv-lr2600 kernel: md(9,0):Using r5 hash to sort names
Aug 15 15:25:27 srv-lr2600 kernel: VFS: Mounted root (reiserfs filesystem) readonly.
Aug 15 15:25:27 srv-lr2600 kernel: Freeing unused kernel memory: 128k freed
Aug 15 15:25:27 srv-lr2600 kernel: NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
Aug 15 15:25:27 srv-lr2600 kernel: Adding Swap: 289160k swap-space (priority 1)
Aug 15 15:25:27 srv-lr2600 kernel: Adding Swap: 289160k swap-space (priority 1)
Aug 15 15:25:27 srv-lr2600 kernel: Adding Swap: 385520k swap-space (priority 1)
Aug 15 15:25:27 srv-lr2600 kernel: Adding Swap: 511992k swap-space (priority 2)
Aug 15 15:25:27 srv-lr2600 kernel: Real Time Clock Driver v1.10e
Aug 15 15:25:27 srv-lr2600 kernel: usb.c: registered new driver usbdevfs
Aug 15 15:25:27 srv-lr2600 kernel: usb.c: registered new driver hub
Aug 15 15:25:27 srv-lr2600 kernel: usb-uhci.c: $Revision: 1.275 $ time 13:37:00 Jul 21 2003
Aug 15 15:25:27 srv-lr2600 kernel: usb-uhci.c: High bandwidth mode enabled
Aug 15 15:25:27 srv-lr2600 kernel: usb-uhci.c: USB UHCI at I/O 0xb000, IRQ 21
Aug 15 15:25:27 srv-lr2600 kernel: usb-uhci.c: Detected 2 ports
Aug 15 15:25:27 srv-lr2600 kernel: usb.c: new USB bus registered, assigned bus number 1
Aug 15 15:25:27 srv-lr2600 kernel: hub.c: USB hub found
Aug 15 15:25:27 srv-lr2600 kernel: hub.c: 2 ports detected
Aug 15 15:25:27 srv-lr2600 kernel: usb-uhci.c: USB UHCI at I/O 0xa800, IRQ 21
Aug 15 15:25:27 srv-lr2600 kernel: usb-uhci.c: Detected 2 ports
Aug 15 15:25:27 srv-lr2600 kernel: usb.c: new USB bus registered, assigned bus number 2
Aug 15 15:25:27 srv-lr2600 kernel: hub.c: USB hub found
Aug 15 15:25:27 srv-lr2600 kernel: hub.c: 2 ports detected
Aug 15 15:25:27 srv-lr2600 kernel: usb-uhci.c: USB UHCI at I/O 0xa400, IRQ 21
Aug 15 15:25:27 srv-lr2600 kernel: usb-uhci.c: Detected 2 ports
Aug 15 15:25:27 srv-lr2600 kernel: usb.c: new USB bus registered, assigned bus number 3
Aug 15 15:25:27 srv-lr2600 kernel: hub.c: USB hub found
Aug 15 15:25:27 srv-lr2600 kernel: hub.c: 2 ports detected
Aug 15 15:25:27 srv-lr2600 kernel: usb-uhci.c: v1.275:USB Universal Host Controller Interface driver
Aug 15 15:25:27 srv-lr2600 kernel: usb.c: registered new driver usbkbd
Aug 15 15:25:27 srv-lr2600 kernel: usbkbd.c: :USB HID Boot Protocol keyboard driver
Aug 15 15:25:27 srv-lr2600 kernel: via-rhine.c:v1.10-LK1.1.18  July-4-2003  Written by Donald Becker
Aug 15 15:25:27 srv-lr2600 kernel:   http://www.scyld.com/network/via-rhine.html
Aug 15 15:25:27 srv-lr2600 kernel: eth0: VIA VT6102 Rhine-II at 0xfb000000, 00:0c:6e:1f:81:95, IRQ 23.
Aug 15 15:25:27 srv-lr2600 kernel: eth0: MII PHY found at address 1, status 0x786d advertising 01e1 Link 45e1.
Aug 15 15:25:27 srv-lr2600 kernel: EXT2-fs: unable to read superblock
Aug 15 15:25:27 srv-lr2600 kernel: eth0: Setting full-duplex based on MII #1 link partner capability of 45e1.
Aug 15 15:25:27 srv-lr2600 kernel: hdc: attached ide-cdrom driver.
Aug 15 15:25:27 srv-lr2600 kernel: hdc: ATAPI 40X CD-ROM CD-R/RW drive, 8192kB Cache, UDMA(25)
Aug 15 15:25:27 srv-lr2600 kernel: Uniform CD-ROM driver Revision: 3.12
Aug 15 15:25:28 srv-lr2600 kernel: hdc: drive_cmd: status=0x51 { DriveReady SeekComplete Error }
Aug 15 15:25:28 srv-lr2600 kernel: hdc: drive_cmd: error=0x04Aborted Command 
Aug 15 15:35:26 srv-lr2600 kernel: md: trying to hot-add hda3 to md0 ... 
Aug 15 15:35:26 srv-lr2600 kernel: md: bind<hda3,3>
Aug 15 15:35:26 srv-lr2600 kernel: RAID5 conf printout:
Aug 15 15:35:26 srv-lr2600 kernel:  --- rd:3 wd:2 fd:1
Aug 15 15:35:26 srv-lr2600 kernel:  disk 0, s:0, o:1, n:0 rd:0 us:1 dev:hde3
Aug 15 15:35:26 srv-lr2600 kernel:  disk 1, s:0, o:1, n:1 rd:1 us:1 dev:hdg3
Aug 15 15:35:26 srv-lr2600 kernel:  disk 2, s:0, o:0, n:0 rd:0 us:0 dev:[dev 00:00]
Aug 15 15:35:26 srv-lr2600 kernel: RAID5 conf printout:
Aug 15 15:35:26 srv-lr2600 kernel:  --- rd:3 wd:2 fd:1
Aug 15 15:35:26 srv-lr2600 kernel:  disk 0, s:0, o:1, n:0 rd:0 us:1 dev:hde3
Aug 15 15:35:26 srv-lr2600 kernel:  disk 1, s:0, o:1, n:1 rd:1 us:1 dev:hdg3
Aug 15 15:35:26 srv-lr2600 kernel:  disk 2, s:0, o:0, n:0 rd:0 us:0 dev:[dev 00:00]
Aug 15 15:35:26 srv-lr2600 kernel: md: updating md0 RAID superblock on device
Aug 15 15:35:26 srv-lr2600 kernel: md: hda3 [events: 0001b800]<6>(write) hda3's sb offset: 159694016
Aug 15 15:35:26 srv-lr2600 kernel: md: hdg3 [events: 0001b800]<6>(write) hdg3's sb offset: 159694016
Aug 15 15:35:26 srv-lr2600 kernel: md: hde3 [events: 0001b800]<6>(write) hde3's sb offset: 159694016
Aug 15 15:35:27 srv-lr2600 kernel: md: recovery thread got woken up ...
Aug 15 15:35:27 srv-lr2600 kernel: md0: resyncing spare disk hda3 to replace failed disk
Aug 15 15:35:27 srv-lr2600 kernel: RAID5 conf printout:
Aug 15 15:35:27 srv-lr2600 kernel:  --- rd:3 wd:2 fd:1
Aug 15 15:35:27 srv-lr2600 kernel:  disk 0, s:0, o:1, n:0 rd:0 us:1 dev:hde3
Aug 15 15:35:27 srv-lr2600 kernel:  disk 1, s:0, o:1, n:1 rd:1 us:1 dev:hdg3
Aug 15 15:35:27 srv-lr2600 kernel:  disk 2, s:0, o:0, n:0 rd:0 us:0 dev:[dev 00:00]
Aug 15 15:35:27 srv-lr2600 kernel: RAID5 conf printout:
Aug 15 15:35:27 srv-lr2600 kernel:  --- rd:3 wd:2 fd:1
Aug 15 15:35:27 srv-lr2600 kernel:  disk 0, s:0, o:1, n:0 rd:0 us:1 dev:hde3
Aug 15 15:35:27 srv-lr2600 kernel:  disk 1, s:0, o:1, n:1 rd:1 us:1 dev:hdg3
Aug 15 15:35:27 srv-lr2600 kernel:  disk 2, s:0, o:0, n:0 rd:0 us:0 dev:[dev 00:00]
Aug 15 15:35:27 srv-lr2600 kernel: md: syncing RAID array md0
Aug 15 15:35:27 srv-lr2600 kernel: md: minimum _guaranteed_ reconstruction speed: 100 KB/sec/disc.
Aug 15 15:35:27 srv-lr2600 kernel: md: using maximum available idle IO bandwith (but not more than 100000 KB/sec) for reconstruction.
Aug 15 15:35:27 srv-lr2600 kernel: md: using 124k window, over a total of 159694016 blocks.
Aug 15 16:44:22 srv-lr2600 kernel: md: md0: sync done.
Aug 15 16:44:22 srv-lr2600 kernel: RAID5 conf printout:
Aug 15 16:44:22 srv-lr2600 kernel:  --- rd:3 wd:2 fd:1
Aug 15 16:44:22 srv-lr2600 kernel:  disk 0, s:0, o:1, n:0 rd:0 us:1 dev:hde3
Aug 15 16:44:22 srv-lr2600 kernel:  disk 1, s:0, o:1, n:1 rd:1 us:1 dev:hdg3
Aug 15 16:44:22 srv-lr2600 kernel:  disk 2, s:0, o:0, n:0 rd:0 us:0 dev:[dev 00:00]
Aug 15 16:44:22 srv-lr2600 kernel: md: bug in file raid5.c, line 1909

And why did I get this bug?

Aug 15 16:44:22 srv-lr2600 kernel: 
Aug 15 16:44:22 srv-lr2600 kernel: md:^I**********************************
Aug 15 16:44:22 srv-lr2600 kernel: md:^I* <COMPLETE RAID STATE PRINTOUT> *
Aug 15 16:44:22 srv-lr2600 kernel: md:^I**********************************
Aug 15 16:44:22 srv-lr2600 kernel: md0: <hda3><hdg3><hde3> array superblock:
Aug 15 16:44:22 srv-lr2600 kernel: md:  SB: (V:0.90.0) ID:<dea08cef.28d34b00.79cd55bc.46bdbe06> CT:3f34718d
Aug 15 16:44:22 srv-lr2600 kernel: md:     L5 S159694016 ND:3 RD:3 md0 LO:0 CS:65536
Aug 15 16:44:23 srv-lr2600 kernel: md:     UT:3f3d602e ST:0 AD:2 WD:3 FD:0 SD:1 CSUM:f9253789 E:0001b800
Aug 15 16:44:23 srv-lr2600 kernel:      D  0:  DISK<N:0,hde3(33,3),R:0,S:6>
Aug 15 16:44:23 srv-lr2600 kernel:      D  1:  DISK<N:1,hdg3(34,3),R:1,S:6>
Aug 15 16:44:23 srv-lr2600 kernel:      D  2:  DISK<N:2,[dev 00:00](0,0),R:2,S:8>
Aug 15 16:44:23 srv-lr2600 kernel:      D  3:  DISK<N:3,hda3(3,3),R:3,S:0>
Aug 15 16:44:23 srv-lr2600 kernel: md:     THIS:  DISK<N:1,hdg3(34,3),R:1,S:6>
Aug 15 16:44:23 srv-lr2600 kernel: md: rdev hda3: O:hda3, SZ:159694016 F:0 DN:3 <6>md: rdev superblock:
Aug 15 16:44:23 srv-lr2600 kernel: md:  SB: (V:0.90.0) ID:<dea08cef.28d34b00.79cd55bc.46bdbe06> CT:3f34718d
Aug 15 16:44:23 srv-lr2600 kernel: md:     L5 S159694016 ND:3 RD:3 md0 LO:0 CS:65536
Aug 15 16:44:23 srv-lr2600 kernel: md:     UT:3f3d602e ST:0 AD:2 WD:3 FD:0 SD:1 CSUM:f9253a6a E:0001b800
Aug 15 16:44:23 srv-lr2600 kernel:      D  0:  DISK<N:0,hde3(33,3),R:0,S:6>
Aug 15 16:44:23 srv-lr2600 kernel:      D  1:  DISK<N:1,hdg3(34,3),R:1,S:6>
Aug 15 16:44:23 srv-lr2600 kernel:      D  2:  DISK<N:2,[dev 00:00](0,0),R:2,S:8>
Aug 15 16:44:23 srv-lr2600 kernel:      D  3:  DISK<N:3,hda3(3,3),R:3,S:0>
Aug 15 16:44:23 srv-lr2600 kernel: md:     THIS:  DISK<N:3,hda3(3,3),R:3,S:0>
Aug 15 16:44:23 srv-lr2600 kernel: md: rdev hdg3: O:hdg3, SZ:159694016 F:0 DN:1 <6>md: rdev superblock:
Aug 15 16:44:23 srv-lr2600 kernel: md:  SB: (V:0.90.0) ID:<dea08cef.28d34b00.79cd55bc.46bdbe06> CT:3f34718d
Aug 15 16:44:23 srv-lr2600 kernel: md:     L5 S159694016 ND:3 RD:3 md0 LO:0 CS:65536
Aug 15 16:44:23 srv-lr2600 kernel: md:     UT:3f3d602e ST:0 AD:2 WD:3 FD:0 SD:1 CSUM:f9253a8b E:0001b800
Aug 15 16:44:23 srv-lr2600 kernel:      D  0:  DISK<N:0,hde3(33,3),R:0,S:6>
Aug 15 16:44:23 srv-lr2600 kernel:      D  1:  DISK<N:1,hdg3(34,3),R:1,S:6>
Aug 15 16:44:23 srv-lr2600 kernel:      D  2:  DISK<N:2,[dev 00:00](0,0),R:2,S:8>
Aug 15 16:44:23 srv-lr2600 kernel:      D  3:  DISK<N:3,hda3(3,3),R:3,S:0>
Aug 15 16:44:23 srv-lr2600 kernel: md:     THIS:  DISK<N:1,hdg3(34,3),R:1,S:6>
Aug 15 16:44:23 srv-lr2600 kernel: md: rdev hde3: O:hde3, SZ:159694016 F:0 DN:0 <6>md: rdev superblock:
Aug 15 16:44:23 srv-lr2600 kernel: md:  SB: (V:0.90.0) ID:<dea08cef.28d34b00.79cd55bc.46bdbe06> CT:3f34718d
Aug 15 16:44:23 srv-lr2600 kernel: md:     L5 S159694016 ND:3 RD:3 md0 LO:0 CS:65536
Aug 15 16:44:23 srv-lr2600 kernel: md:     UT:3f3d602e ST:0 AD:2 WD:3 FD:0 SD:1 CSUM:f9253a88 E:0001b800
Aug 15 16:44:23 srv-lr2600 kernel:      D  0:  DISK<N:0,hde3(33,3),R:0,S:6>
Aug 15 16:44:23 srv-lr2600 kernel:      D  1:  DISK<N:1,hdg3(34,3),R:1,S:6>
Aug 15 16:44:23 srv-lr2600 kernel:      D  2:  DISK<N:2,[dev 00:00](0,0),R:2,S:8>
Aug 15 16:44:23 srv-lr2600 kernel:      D  3:  DISK<N:3,hda3(3,3),R:3,S:0>
Aug 15 16:44:23 srv-lr2600 kernel: md:     THIS:  DISK<N:0,hde3(33,3),R:0,S:6>
Aug 15 16:44:23 srv-lr2600 kernel: md:^I**********************************
Aug 15 16:44:23 srv-lr2600 kernel: 
Aug 15 16:44:23 srv-lr2600 kernel: RAID5 conf printout:
Aug 15 16:44:23 srv-lr2600 kernel:  --- rd:3 wd:2 fd:1
Aug 15 16:44:23 srv-lr2600 kernel:  disk 0, s:0, o:1, n:0 rd:0 us:1 dev:hde3
Aug 15 16:44:23 srv-lr2600 kernel:  disk 1, s:0, o:1, n:1 rd:1 us:1 dev:hdg3
Aug 15 16:44:23 srv-lr2600 kernel:  disk 2, s:0, o:0, n:0 rd:0 us:0 dev:[dev 00:00]
Aug 15 16:44:23 srv-lr2600 kernel: md: updating md0 RAID superblock on device
Aug 15 16:44:23 srv-lr2600 kernel: md: hda3 [events: 0001b801]<6>(write) hda3's sb offset: 159694016
Aug 15 16:44:23 srv-lr2600 kernel: md: hdg3 [events: 0001b801]<6>(write) hdg3's sb offset: 159694016
Aug 15 16:44:23 srv-lr2600 kernel: md: hde3 [events: 0001b801]<6>(write) hde3's sb offset: 159694016
Aug 15 16:44:23 srv-lr2600 kernel: md: recovery thread finished ...
Aug 15 16:50:35 srv-lr2600 kernel: Kernel logging (proc) stopped.

--4SFOXa2GPu3tIq4H
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="config-2.4.22-pre7"

#
# Automatically generated make config: don't edit
#
CONFIG_X86=y
# CONFIG_SBUS is not set
CONFIG_UID16=y

#
# Code maturity level options
#
CONFIG_EXPERIMENTAL=y

#
# Loadable module support
#
CONFIG_MODULES=y
# CONFIG_MODVERSIONS is not set
CONFIG_KMOD=y

#
# Processor type and features
#
# CONFIG_M386 is not set
# CONFIG_M486 is not set
CONFIG_M586=y
# CONFIG_M586TSC is not set
# CONFIG_M586MMX is not set
# CONFIG_M686 is not set
# CONFIG_MPENTIUMIII is not set
# CONFIG_MPENTIUM4 is not set
# CONFIG_MK6 is not set
# CONFIG_MK7 is not set
# CONFIG_MK8 is not set
# CONFIG_MELAN is not set
# CONFIG_MCRUSOE is not set
# CONFIG_MWINCHIPC6 is not set
# CONFIG_MWINCHIP2 is not set
# CONFIG_MWINCHIP3D is not set
# CONFIG_MCYRIXIII is not set
# CONFIG_MVIAC3_2 is not set
CONFIG_X86_WP_WORKS_OK=y
CONFIG_X86_INVLPG=y
CONFIG_X86_CMPXCHG=y
CONFIG_X86_XADD=y
CONFIG_X86_BSWAP=y
CONFIG_X86_POPAD_OK=y
# CONFIG_RWSEM_GENERIC_SPINLOCK is not set
CONFIG_RWSEM_XCHGADD_ALGORITHM=y
CONFIG_X86_L1_CACHE_SHIFT=5
CONFIG_X86_USE_STRING_486=y
CONFIG_X86_ALIGNMENT_16=y
CONFIG_X86_PPRO_FENCE=y
# CONFIG_X86_F00F_WORKS_OK is not set
CONFIG_X86_MCE=y
CONFIG_TOSHIBA=m
CONFIG_I8K=m
CONFIG_MICROCODE=m
CONFIG_X86_MSR=m
CONFIG_X86_CPUID=m
# CONFIG_NOHIGHMEM is not set
CONFIG_HIGHMEM4G=y
# CONFIG_HIGHMEM64G is not set
CONFIG_HIGHMEM=y
CONFIG_HIGHIO=y
# CONFIG_MATH_EMULATION is not set
CONFIG_MTRR=y
CONFIG_SMP=y
# CONFIG_X86_NUMA is not set
# CONFIG_X86_TSC_DISABLE is not set
CONFIG_HAVE_DEC_LOCK=y

#
# General setup
#
CONFIG_NET=y
CONFIG_X86_IO_APIC=y
CONFIG_X86_LOCAL_APIC=y
CONFIG_PCI=y
# CONFIG_PCI_GOBIOS is not set
# CONFIG_PCI_GODIRECT is not set
CONFIG_PCI_GOANY=y
CONFIG_PCI_BIOS=y
CONFIG_PCI_DIRECT=y
CONFIG_ISA=y
CONFIG_PCI_NAMES=y
# CONFIG_EISA is not set
# CONFIG_MCA is not set
CONFIG_HOTPLUG=y

#
# PCMCIA/CardBus support
#
# CONFIG_PCMCIA is not set

#
# PCI Hotplug Support
#
CONFIG_HOTPLUG_PCI=m
CONFIG_HOTPLUG_PCI_COMPAQ=m
# CONFIG_HOTPLUG_PCI_COMPAQ_NVRAM is not set
CONFIG_HOTPLUG_PCI_IBM=m
CONFIG_HOTPLUG_PCI_ACPI=m
CONFIG_SYSVIPC=y
CONFIG_BSD_PROCESS_ACCT=y
CONFIG_SYSCTL=y
CONFIG_KCORE_ELF=y
# CONFIG_KCORE_AOUT is not set
# CONFIG_BINFMT_AOUT is not set
CONFIG_BINFMT_ELF=y
CONFIG_BINFMT_MISC=m
CONFIG_PM=y
CONFIG_APM=y
# CONFIG_APM_IGNORE_USER_SUSPEND is not set
CONFIG_APM_DO_ENABLE=y
# CONFIG_APM_CPU_IDLE is not set
CONFIG_APM_DISPLAY_BLANK=y
# CONFIG_APM_RTC_IS_GMT is not set
# CONFIG_APM_ALLOW_INTS is not set
CONFIG_APM_REAL_MODE_POWER_OFF=y

#
# ACPI Support
#
CONFIG_ACPI=y
# CONFIG_ACPI_HT_ONLY is not set
CONFIG_ACPI_BOOT=y
CONFIG_ACPI_BUS=y
CONFIG_ACPI_INTERPRETER=y
CONFIG_ACPI_EC=y
CONFIG_ACPI_POWER=y
CONFIG_ACPI_PCI=y
CONFIG_ACPI_SLEEP=y
CONFIG_ACPI_SYSTEM=y
CONFIG_ACPI_AC=y
CONFIG_ACPI_BATTERY=m
CONFIG_ACPI_BUTTON=y
CONFIG_ACPI_FAN=y
CONFIG_ACPI_PROCESSOR=y
CONFIG_ACPI_THERMAL=y
# CONFIG_ACPI_ASUS is not set
# CONFIG_ACPI_TOSHIBA is not set
CONFIG_ACPI_DEBUG=y
# CONFIG_ACPI_RELAXED_AML is not set

#
# Memory Technology Devices (MTD)
#
# CONFIG_MTD is not set

#
# Parallel port support
#
CONFIG_PARPORT=m
CONFIG_PARPORT_PC=m
CONFIG_PARPORT_PC_CML1=m
CONFIG_PARPORT_SERIAL=m
CONFIG_PARPORT_PC_FIFO=y
CONFIG_PARPORT_PC_SUPERIO=y
# CONFIG_PARPORT_AMIGA is not set
# CONFIG_PARPORT_MFC3 is not set
# CONFIG_PARPORT_ATARI is not set
# CONFIG_PARPORT_GSC is not set
# CONFIG_PARPORT_SUNBPP is not set
# CONFIG_PARPORT_OTHER is not set
CONFIG_PARPORT_1284=y

#
# Plug and Play configuration
#
CONFIG_PNP=y
CONFIG_ISAPNP=y

#
# Block devices
#
CONFIG_BLK_DEV_FD=m
# CONFIG_BLK_DEV_XD is not set
CONFIG_PARIDE=m
CONFIG_PARIDE_PARPORT=m

#
# Parallel IDE high-level drivers
#
CONFIG_PARIDE_PD=m
CONFIG_PARIDE_PCD=m
CONFIG_PARIDE_PF=m
CONFIG_PARIDE_PT=m
CONFIG_PARIDE_PG=m

#
# Parallel IDE protocol modules
#
CONFIG_PARIDE_ATEN=m
CONFIG_PARIDE_BPCK=m
CONFIG_PARIDE_BPCK6=m
CONFIG_PARIDE_COMM=m
CONFIG_PARIDE_DSTR=m
CONFIG_PARIDE_FIT2=m
CONFIG_PARIDE_FIT3=m
CONFIG_PARIDE_EPAT=m
CONFIG_PARIDE_EPATC8=y
CONFIG_PARIDE_EPIA=m
CONFIG_PARIDE_FRIQ=m
CONFIG_PARIDE_FRPW=m
CONFIG_PARIDE_KBIC=m
CONFIG_PARIDE_KTTI=m
CONFIG_PARIDE_ON20=m
CONFIG_PARIDE_ON26=m
CONFIG_BLK_CPQ_DA=m
CONFIG_BLK_CPQ_CISS_DA=m
CONFIG_CISS_SCSI_TAPE=y
CONFIG_BLK_DEV_DAC960=m
CONFIG_BLK_DEV_UMEM=m
CONFIG_BLK_DEV_LOOP=m
CONFIG_BLK_DEV_NBD=m
CONFIG_BLK_DEV_RAM=m
CONFIG_BLK_DEV_RAM_SIZE=4096
# CONFIG_BLK_DEV_INITRD is not set
CONFIG_BLK_STATS=y

#
# Multi-device support (RAID and LVM)
#
CONFIG_MD=y
CONFIG_BLK_DEV_MD=y
CONFIG_MD_LINEAR=y
CONFIG_MD_RAID0=y
CONFIG_MD_RAID1=y
CONFIG_MD_RAID5=y
# CONFIG_MD_MULTIPATH is not set
CONFIG_BLK_DEV_LVM=y

#
# Networking options
#
CONFIG_PACKET=m
CONFIG_PACKET_MMAP=y
CONFIG_NETLINK_DEV=m
CONFIG_NETFILTER=y
# CONFIG_NETFILTER_DEBUG is not set
CONFIG_FILTER=y
CONFIG_UNIX=m
CONFIG_INET=y
CONFIG_IP_MULTICAST=y
CONFIG_IP_ADVANCED_ROUTER=y
CONFIG_IP_MULTIPLE_TABLES=y
CONFIG_IP_ROUTE_FWMARK=y
CONFIG_IP_ROUTE_NAT=y
CONFIG_IP_ROUTE_MULTIPATH=y
CONFIG_IP_ROUTE_TOS=y
CONFIG_IP_ROUTE_VERBOSE=y
# CONFIG_IP_PNP is not set
CONFIG_NET_IPIP=m
CONFIG_NET_IPGRE=m
CONFIG_NET_IPGRE_BROADCAST=y
# CONFIG_IP_MROUTE is not set
# CONFIG_ARPD is not set
# CONFIG_INET_ECN is not set
CONFIG_SYN_COOKIES=y

#
#   IP: Netfilter Configuration
#
CONFIG_IP_NF_CONNTRACK=m
CONFIG_IP_NF_FTP=m
CONFIG_IP_NF_AMANDA=m
CONFIG_IP_NF_TFTP=m
CONFIG_IP_NF_IRC=m
CONFIG_IP_NF_QUEUE=m
CONFIG_IP_NF_IPTABLES=m
CONFIG_IP_NF_MATCH_LIMIT=m
CONFIG_IP_NF_MATCH_MAC=m
CONFIG_IP_NF_MATCH_PKTTYPE=m
CONFIG_IP_NF_MATCH_MARK=m
CONFIG_IP_NF_MATCH_MULTIPORT=m
CONFIG_IP_NF_MATCH_TOS=m
CONFIG_IP_NF_MATCH_RECENT=m
CONFIG_IP_NF_MATCH_ECN=m
CONFIG_IP_NF_MATCH_DSCP=m
CONFIG_IP_NF_MATCH_AH_ESP=m
CONFIG_IP_NF_MATCH_LENGTH=m
CONFIG_IP_NF_MATCH_TTL=m
CONFIG_IP_NF_MATCH_TCPMSS=m
CONFIG_IP_NF_MATCH_HELPER=m
CONFIG_IP_NF_MATCH_STATE=m
CONFIG_IP_NF_MATCH_CONNTRACK=m
CONFIG_IP_NF_MATCH_UNCLEAN=m
CONFIG_IP_NF_MATCH_OWNER=m
CONFIG_IP_NF_FILTER=m
CONFIG_IP_NF_TARGET_REJECT=m
CONFIG_IP_NF_TARGET_MIRROR=m
CONFIG_IP_NF_NAT=m
CONFIG_IP_NF_NAT_NEEDED=y
CONFIG_IP_NF_TARGET_MASQUERADE=m
CONFIG_IP_NF_TARGET_REDIRECT=m
CONFIG_IP_NF_NAT_AMANDA=m
CONFIG_IP_NF_NAT_LOCAL=y
CONFIG_IP_NF_NAT_SNMP_BASIC=m
CONFIG_IP_NF_NAT_IRC=m
CONFIG_IP_NF_NAT_FTP=m
CONFIG_IP_NF_NAT_TFTP=m
CONFIG_IP_NF_MANGLE=m
CONFIG_IP_NF_TARGET_TOS=m
CONFIG_IP_NF_TARGET_ECN=m
CONFIG_IP_NF_TARGET_DSCP=m
CONFIG_IP_NF_TARGET_MARK=m
CONFIG_IP_NF_TARGET_LOG=m
CONFIG_IP_NF_TARGET_ULOG=m
CONFIG_IP_NF_TARGET_TCPMSS=m
CONFIG_IP_NF_ARPTABLES=m
CONFIG_IP_NF_ARPFILTER=m
CONFIG_IP_NF_ARP_MANGLE=m
# CONFIG_IP_NF_COMPAT_IPCHAINS is not set
# CONFIG_IP_NF_COMPAT_IPFWADM is not set
# CONFIG_IPV6 is not set
# CONFIG_KHTTPD is not set
# CONFIG_ATM is not set
CONFIG_VLAN_8021Q=m

#
#  
#
# CONFIG_IPX is not set
CONFIG_ATALK=m

#
# Appletalk devices
#
# CONFIG_DEV_APPLETALK is not set
# CONFIG_DECNET is not set
CONFIG_BRIDGE=m
# CONFIG_X25 is not set
# CONFIG_LAPB is not set
# CONFIG_LLC is not set
# CONFIG_NET_DIVERT is not set
# CONFIG_ECONET is not set
# CONFIG_WAN_ROUTER is not set
# CONFIG_NET_FASTROUTE is not set
CONFIG_NET_HW_FLOWCONTROL=y

#
# QoS and/or fair queueing
#
CONFIG_NET_SCHED=y
CONFIG_NET_SCH_CBQ=m
CONFIG_NET_SCH_HTB=m
CONFIG_NET_SCH_CSZ=m
CONFIG_NET_SCH_PRIO=m
CONFIG_NET_SCH_RED=m
CONFIG_NET_SCH_SFQ=m
CONFIG_NET_SCH_TEQL=m
CONFIG_NET_SCH_TBF=m
CONFIG_NET_SCH_GRED=m
CONFIG_NET_SCH_DSMARK=m
CONFIG_NET_SCH_INGRESS=m
CONFIG_NET_QOS=y
CONFIG_NET_ESTIMATOR=y
CONFIG_NET_CLS=y
CONFIG_NET_CLS_TCINDEX=m
CONFIG_NET_CLS_ROUTE4=m
CONFIG_NET_CLS_ROUTE=y
CONFIG_NET_CLS_FW=m
CONFIG_NET_CLS_U32=m
CONFIG_NET_CLS_RSVP=m
CONFIG_NET_CLS_RSVP6=m
CONFIG_NET_CLS_POLICE=y

#
# Network testing
#
CONFIG_NET_PKTGEN=m
CONFIG_IPSEC=m

#
# IPSec options (FreeS/WAN)
#
CONFIG_IPSEC_IPIP=y
CONFIG_IPSEC_AH=y
CONFIG_IPSEC_AUTH_HMAC_MD5=y
CONFIG_IPSEC_AUTH_HMAC_SHA1=y
CONFIG_IPSEC_ESP=y
CONFIG_IPSEC_ENC_3DES=y
CONFIG_IPSEC_IPCOMP=y
CONFIG_IPSEC_DEBUG=y

#
# Telephony Support
#
# CONFIG_PHONE is not set
# CONFIG_PHONE_IXJ is not set
# CONFIG_PHONE_IXJ_PCMCIA is not set

#
# ATA/IDE/MFM/RLL support
#
CONFIG_IDE=y

#
# IDE, ATA and ATAPI Block devices
#
CONFIG_BLK_DEV_IDE=y

#
# Please see Documentation/ide.txt for help/info on IDE drives
#
# CONFIG_BLK_DEV_HD_IDE is not set
# CONFIG_BLK_DEV_HD is not set
CONFIG_BLK_DEV_IDEDISK=y
CONFIG_IDEDISK_MULTI_MODE=y
CONFIG_IDEDISK_STROKE=y
# CONFIG_BLK_DEV_IDECS is not set
CONFIG_BLK_DEV_IDECD=m
CONFIG_BLK_DEV_IDETAPE=m
CONFIG_BLK_DEV_IDEFLOPPY=m
CONFIG_BLK_DEV_IDESCSI=m
# CONFIG_IDE_TASK_IOCTL is not set

#
# IDE chipset support/bugfixes
#
CONFIG_BLK_DEV_CMD640=y
# CONFIG_BLK_DEV_CMD640_ENHANCED is not set
# CONFIG_BLK_DEV_ISAPNP is not set
CONFIG_BLK_DEV_IDEPCI=y
CONFIG_BLK_DEV_GENERIC=y
CONFIG_IDEPCI_SHARE_IRQ=y
CONFIG_BLK_DEV_IDEDMA_PCI=y
# CONFIG_BLK_DEV_OFFBOARD is not set
# CONFIG_BLK_DEV_IDEDMA_FORCED is not set
CONFIG_IDEDMA_PCI_AUTO=y
# CONFIG_IDEDMA_ONLYDISK is not set
CONFIG_BLK_DEV_IDEDMA=y
CONFIG_IDEDMA_PCI_WIP=y
CONFIG_BLK_DEV_ADMA100=y
CONFIG_BLK_DEV_AEC62XX=y
CONFIG_BLK_DEV_ALI15X3=y
# CONFIG_WDC_ALI15X3 is not set
CONFIG_BLK_DEV_AMD74XX=y
CONFIG_AMD74XX_OVERRIDE=y
CONFIG_BLK_DEV_CMD64X=y
CONFIG_BLK_DEV_TRIFLEX=y
CONFIG_BLK_DEV_CY82C693=y
CONFIG_BLK_DEV_CS5530=y
CONFIG_BLK_DEV_HPT34X=y
CONFIG_HPT34X_AUTODMA=y
CONFIG_BLK_DEV_HPT366=y
CONFIG_BLK_DEV_PIIX=y
CONFIG_BLK_DEV_NS87415=y
CONFIG_BLK_DEV_OPTI621=m
CONFIG_BLK_DEV_PDC202XX_OLD=y
CONFIG_PDC202XX_BURST=y
CONFIG_BLK_DEV_PDC202XX_NEW=y
CONFIG_PDC202XX_FORCE=y
CONFIG_BLK_DEV_RZ1000=y
CONFIG_BLK_DEV_SC1200=y
CONFIG_BLK_DEV_SVWKS=y
CONFIG_BLK_DEV_SIIMAGE=y
CONFIG_BLK_DEV_SIS5513=y
CONFIG_BLK_DEV_SLC90E66=y
CONFIG_BLK_DEV_TRM290=y
CONFIG_BLK_DEV_VIA82CXXX=y
# CONFIG_IDE_CHIPSETS is not set
CONFIG_IDEDMA_AUTO=y
# CONFIG_IDEDMA_IVB is not set
# CONFIG_DMA_NONPCI is not set
CONFIG_BLK_DEV_PDC202XX=y
CONFIG_BLK_DEV_IDE_MODES=y
# CONFIG_BLK_DEV_ATARAID is not set
# CONFIG_BLK_DEV_ATARAID_PDC is not set
# CONFIG_BLK_DEV_ATARAID_HPT is not set
# CONFIG_BLK_DEV_ATARAID_SII is not set

#
# SCSI support
#
CONFIG_SCSI=y

#
# SCSI support type (disk, tape, CD-ROM)
#
CONFIG_BLK_DEV_SD=y
CONFIG_SD_EXTRA_DEVS=40
CONFIG_CHR_DEV_ST=m
CONFIG_CHR_DEV_OSST=m
CONFIG_BLK_DEV_SR=m
CONFIG_BLK_DEV_SR_VENDOR=y
CONFIG_SR_EXTRA_DEVS=2
CONFIG_CHR_DEV_SG=m

#
# Some SCSI devices (e.g. CD jukebox) support multiple LUNs
#
# CONFIG_SCSI_DEBUG_QUEUES is not set
# CONFIG_SCSI_MULTI_LUN is not set
# CONFIG_SCSI_CONSTANTS is not set
CONFIG_SCSI_LOGGING=y

#
# SCSI low-level drivers
#
CONFIG_BLK_DEV_3W_XXXX_RAID=m
# CONFIG_SCSI_7000FASST is not set
# CONFIG_SCSI_ACARD is not set
CONFIG_SCSI_AHA152X=m
CONFIG_SCSI_AHA1542=m
CONFIG_SCSI_AHA1740=m
CONFIG_SCSI_AACRAID=m
CONFIG_SCSI_AIC7XXX=y
CONFIG_AIC7XXX_CMDS_PER_DEVICE=4
CONFIG_AIC7XXX_RESET_DELAY_MS=15000
# CONFIG_AIC7XXX_PROBE_EISA_VL is not set
# CONFIG_AIC7XXX_BUILD_FIRMWARE is not set
# CONFIG_AIC7XXX_DEBUG_ENABLE is not set
CONFIG_AIC7XXX_DEBUG_MASK=0
# CONFIG_AIC7XXX_REG_PRETTY_PRINT is not set
CONFIG_SCSI_AIC79XX=m
CONFIG_AIC79XX_CMDS_PER_DEVICE=4
CONFIG_AIC79XX_RESET_DELAY_MS=15000
# CONFIG_AIC79XX_BUILD_FIRMWARE is not set
CONFIG_AIC79XX_ENABLE_RD_STRM=y
# CONFIG_AIC79XX_DEBUG_ENABLE is not set
CONFIG_AIC79XX_DEBUG_MASK=0
# CONFIG_AIC79XX_REG_PRETTY_PRINT is not set
# CONFIG_SCSI_DPT_I2O is not set
# CONFIG_SCSI_ADVANSYS is not set
# CONFIG_SCSI_IN2000 is not set
# CONFIG_SCSI_AM53C974 is not set
# CONFIG_SCSI_MEGARAID is not set
# CONFIG_SCSI_BUSLOGIC is not set
# CONFIG_SCSI_CPQFCTS is not set
# CONFIG_SCSI_DMX3191D is not set
# CONFIG_SCSI_DTC3280 is not set
# CONFIG_SCSI_EATA is not set
# CONFIG_SCSI_EATA_DMA is not set
# CONFIG_SCSI_EATA_PIO is not set
# CONFIG_SCSI_FUTURE_DOMAIN is not set
# CONFIG_SCSI_GDTH is not set
# CONFIG_SCSI_GENERIC_NCR5380 is not set
# CONFIG_SCSI_IPS is not set
# CONFIG_SCSI_INITIO is not set
# CONFIG_SCSI_INIA100 is not set
CONFIG_SCSI_PPA=m
CONFIG_SCSI_IMM=m
# CONFIG_SCSI_IZIP_EPP16 is not set
# CONFIG_SCSI_IZIP_SLOW_CTR is not set
# CONFIG_SCSI_NCR53C406A is not set
# CONFIG_SCSI_NCR53C7xx is not set
CONFIG_SCSI_SYM53C8XX_2=y
CONFIG_SCSI_SYM53C8XX_DMA_ADDRESSING_MODE=1
CONFIG_SCSI_SYM53C8XX_DEFAULT_TAGS=16
CONFIG_SCSI_SYM53C8XX_MAX_TAGS=64
# CONFIG_SCSI_SYM53C8XX_IOMAPPED is not set
# CONFIG_SCSI_PAS16 is not set
# CONFIG_SCSI_PCI2000 is not set
# CONFIG_SCSI_PCI2220I is not set
# CONFIG_SCSI_PSI240I is not set
# CONFIG_SCSI_QLOGIC_FAS is not set
# CONFIG_SCSI_QLOGIC_ISP is not set
# CONFIG_SCSI_QLOGIC_FC is not set
# CONFIG_SCSI_QLOGIC_1280 is not set
# CONFIG_SCSI_SEAGATE is not set
# CONFIG_SCSI_SIM710 is not set
# CONFIG_SCSI_SYM53C416 is not set
# CONFIG_SCSI_DC390T is not set
# CONFIG_SCSI_T128 is not set
# CONFIG_SCSI_U14_34F is not set
# CONFIG_SCSI_ULTRASTOR is not set
# CONFIG_SCSI_NSP32 is not set
# CONFIG_SCSI_DEBUG is not set

#
# Fusion MPT device support
#
# CONFIG_FUSION is not set
# CONFIG_FUSION_BOOT is not set
# CONFIG_FUSION_ISENSE is not set
# CONFIG_FUSION_CTL is not set
# CONFIG_FUSION_LAN is not set

#
# IEEE 1394 (FireWire) support (EXPERIMENTAL)
#
CONFIG_IEEE1394=m

#
# Device Drivers
#
CONFIG_IEEE1394_PCILYNX=m
CONFIG_IEEE1394_OHCI1394=m

#
# Protocol Drivers
#
CONFIG_IEEE1394_VIDEO1394=m
CONFIG_IEEE1394_SBP2=m
CONFIG_IEEE1394_SBP2_PHYS_DMA=y
CONFIG_IEEE1394_ETH1394=m
CONFIG_IEEE1394_DV1394=m
CONFIG_IEEE1394_RAWIO=m
CONFIG_IEEE1394_CMP=m
CONFIG_IEEE1394_AMDTP=m
# CONFIG_IEEE1394_VERBOSEDEBUG is not set
CONFIG_IEEE1394_OUI_DB=y

#
# I2O device support
#
# CONFIG_I2O is not set
# CONFIG_I2O_PCI is not set
# CONFIG_I2O_BLOCK is not set
# CONFIG_I2O_LAN is not set
# CONFIG_I2O_SCSI is not set
# CONFIG_I2O_PROC is not set

#
# Network device support
#
CONFIG_NETDEVICES=y

#
# ARCnet devices
#
# CONFIG_ARCNET is not set
CONFIG_DUMMY=m
CONFIG_BONDING=m
CONFIG_EQUALIZER=m
CONFIG_TUN=m
CONFIG_ETHERTAP=m
CONFIG_NET_SB1000=m

#
# Ethernet (10 or 100Mbit)
#
CONFIG_NET_ETHERNET=y
# CONFIG_SUNLANCE is not set
# CONFIG_HAPPYMEAL is not set
# CONFIG_SUNBMAC is not set
# CONFIG_SUNQE is not set
# CONFIG_SUNGEM is not set
CONFIG_NET_VENDOR_3COM=y
CONFIG_EL1=m
CONFIG_EL2=m
CONFIG_ELPLUS=m
CONFIG_EL16=m
CONFIG_EL3=m
CONFIG_3C515=m
# CONFIG_ELMC is not set
# CONFIG_ELMC_II is not set
CONFIG_VORTEX=m
CONFIG_TYPHOON=m
CONFIG_LANCE=m
CONFIG_NET_VENDOR_SMC=y
CONFIG_WD80x3=m
# CONFIG_ULTRAMCA is not set
CONFIG_ULTRA=m
# CONFIG_ULTRA32 is not set
CONFIG_SMC9194=m
CONFIG_NET_VENDOR_RACAL=y
CONFIG_NI5010=m
CONFIG_NI52=m
CONFIG_NI65=m
CONFIG_AT1700=m
CONFIG_DEPCA=m
CONFIG_HP100=m
CONFIG_NET_ISA=y
CONFIG_E2100=m
CONFIG_EWRK3=m
CONFIG_EEXPRESS=m
CONFIG_EEXPRESS_PRO=m
CONFIG_HPLAN_PLUS=m
CONFIG_HPLAN=m
CONFIG_LP486E=m
CONFIG_ETH16I=m
CONFIG_NE2000=m
CONFIG_NET_PCI=y
CONFIG_PCNET32=m
CONFIG_AMD8111_ETH=m
CONFIG_ADAPTEC_STARFIRE=m
CONFIG_AC3200=m
CONFIG_APRICOT=m
CONFIG_CS89x0=m
CONFIG_TULIP=m
CONFIG_TULIP_MWI=y
CONFIG_TULIP_MMIO=y
CONFIG_DE4X5=m
CONFIG_DGRS=m
CONFIG_DM9102=m
CONFIG_EEPRO100=m
# CONFIG_EEPRO100_PIO is not set
CONFIG_E100=m
# CONFIG_LNE390 is not set
CONFIG_FEALNX=m
CONFIG_NATSEMI=m
CONFIG_NE2K_PCI=m
# CONFIG_NE3210 is not set
# CONFIG_ES3210 is not set
CONFIG_8139CP=m
CONFIG_8139TOO=m
# CONFIG_8139TOO_PIO is not set
# CONFIG_8139TOO_TUNE_TWISTER is not set
# CONFIG_8139TOO_8129 is not set
# CONFIG_8139_OLD_RX_RESET is not set
CONFIG_SIS900=m
CONFIG_EPIC100=m
CONFIG_SUNDANCE=m
CONFIG_SUNDANCE_MMIO=y
CONFIG_TLAN=m
CONFIG_TC35815=m
CONFIG_VIA_RHINE=m
CONFIG_VIA_RHINE_MMIO=y
CONFIG_WINBOND_840=m
# CONFIG_NET_POCKET is not set

#
# Ethernet (1000 Mbit)
#
# CONFIG_ACENIC is not set
# CONFIG_DL2K is not set
# CONFIG_E1000 is not set
# CONFIG_MYRI_SBUS is not set
# CONFIG_NS83820 is not set
# CONFIG_HAMACHI is not set
# CONFIG_YELLOWFIN is not set
# CONFIG_R8169 is not set
# CONFIG_SK98LIN is not set
# CONFIG_TIGON3 is not set
# CONFIG_FDDI is not set
# CONFIG_HIPPI is not set
CONFIG_PLIP=m
CONFIG_PPP=m
CONFIG_PPP_MULTILINK=y
CONFIG_PPP_FILTER=y
CONFIG_PPP_ASYNC=m
CONFIG_PPP_SYNC_TTY=m
CONFIG_PPP_DEFLATE=m
CONFIG_PPP_BSDCOMP=m
CONFIG_PPPOE=m
CONFIG_SLIP=m
CONFIG_SLIP_COMPRESSED=y
CONFIG_SLIP_SMART=y
# CONFIG_SLIP_MODE_SLIP6 is not set

#
# Wireless LAN (non-hamradio)
#
CONFIG_NET_RADIO=y
CONFIG_STRIP=m
CONFIG_WAVELAN=m
CONFIG_ARLAN=m
CONFIG_AIRONET4500=m
CONFIG_AIRONET4500_NONCS=m
CONFIG_AIRONET4500_PNP=y
CONFIG_AIRONET4500_PCI=y
CONFIG_AIRONET4500_ISA=y
CONFIG_AIRONET4500_I365=y
CONFIG_AIRONET4500_PROC=m
CONFIG_AIRO=m
CONFIG_HERMES=m
CONFIG_PLX_HERMES=m
CONFIG_PCI_HERMES=m
CONFIG_NET_WIRELESS=y

#
# Token Ring devices
#
# CONFIG_TR is not set
# CONFIG_NET_FC is not set
# CONFIG_RCPCI is not set
# CONFIG_SHAPER is not set

#
# Wan interfaces
#
# CONFIG_WAN is not set

#
# Amateur Radio support
#
# CONFIG_HAMRADIO is not set

#
# IrDA (infrared) support
#
# CONFIG_IRDA is not set

#
# ISDN subsystem
#
# CONFIG_ISDN is not set

#
# Old CD-ROM drivers (not SCSI, not IDE)
#
# CONFIG_CD_NO_IDESCSI is not set

#
# Input core support
#
CONFIG_INPUT=m
CONFIG_INPUT_KEYBDEV=m
CONFIG_INPUT_MOUSEDEV=m
CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
CONFIG_INPUT_JOYDEV=m
CONFIG_INPUT_EVDEV=m

#
# Character devices
#
CONFIG_VT=y
CONFIG_VT_CONSOLE=y
CONFIG_SERIAL=y
CONFIG_SERIAL_CONSOLE=y
CONFIG_SERIAL_EXTENDED=y
CONFIG_SERIAL_MANY_PORTS=y
CONFIG_SERIAL_SHARE_IRQ=y
CONFIG_SERIAL_DETECT_IRQ=y
# CONFIG_SERIAL_MULTIPORT is not set
# CONFIG_HUB6 is not set
# CONFIG_SERIAL_NONSTANDARD is not set
CONFIG_UNIX98_PTYS=y
CONFIG_UNIX98_PTY_COUNT=256
CONFIG_PRINTER=m
CONFIG_LP_CONSOLE=y
CONFIG_PPDEV=m
CONFIG_TIPAR=m

#
# I2C support
#
CONFIG_I2C=m
CONFIG_I2C_ALGOBIT=m
CONFIG_I2C_PHILIPSPAR=m
CONFIG_I2C_ELV=m
CONFIG_I2C_VELLEMAN=m
CONFIG_SCx200_I2C=m
CONFIG_SCx200_I2C_SCL=12
CONFIG_SCx200_I2C_SDA=13
CONFIG_SCx200_ACB=m
CONFIG_I2C_ALGOPCF=m
CONFIG_I2C_ELEKTOR=m
CONFIG_I2C_CHARDEV=m
CONFIG_I2C_PROC=m

#
# Mice
#
# CONFIG_BUSMOUSE is not set
CONFIG_MOUSE=m
CONFIG_PSMOUSE=y
# CONFIG_82C710_MOUSE is not set
# CONFIG_PC110_PAD is not set
# CONFIG_MK712_MOUSE is not set

#
# Joysticks
#
CONFIG_INPUT_GAMEPORT=m
CONFIG_INPUT_NS558=m
CONFIG_INPUT_LIGHTNING=m
CONFIG_INPUT_PCIGAME=m
CONFIG_INPUT_CS461X=m
CONFIG_INPUT_EMU10K1=m
CONFIG_INPUT_SERIO=m
CONFIG_INPUT_SERPORT=m

#
# Joysticks
#
CONFIG_INPUT_ANALOG=m
CONFIG_INPUT_A3D=m
CONFIG_INPUT_ADI=m
CONFIG_INPUT_COBRA=m
CONFIG_INPUT_GF2K=m
CONFIG_INPUT_GRIP=m
CONFIG_INPUT_INTERACT=m
CONFIG_INPUT_TMDC=m
CONFIG_INPUT_SIDEWINDER=m
CONFIG_INPUT_IFORCE_USB=m
CONFIG_INPUT_IFORCE_232=m
CONFIG_INPUT_WARRIOR=m
CONFIG_INPUT_MAGELLAN=m
CONFIG_INPUT_SPACEORB=m
CONFIG_INPUT_SPACEBALL=m
CONFIG_INPUT_STINGER=m
CONFIG_INPUT_DB9=m
CONFIG_INPUT_GAMECON=m
CONFIG_INPUT_TURBOGRAFX=m
CONFIG_QIC02_TAPE=m
CONFIG_QIC02_DYNCONF=y

#
#   Setting runtime QIC-02 configuration is done with qic02conf
#

#
#   from the tpqic02-support package.  It is available at
#

#
#   metalab.unc.edu or ftp://titus.cfw.com/pub/Linux/util/
#
CONFIG_IPMI_HANDLER=m
CONFIG_IPMI_PANIC_EVENT=y
CONFIG_IPMI_DEVICE_INTERFACE=m
CONFIG_IPMI_KCS=m
CONFIG_IPMI_WATCHDOG=m

#
# Watchdog Cards
#
CONFIG_WATCHDOG=y
# CONFIG_WATCHDOG_NOWAYOUT is not set
# CONFIG_ACQUIRE_WDT is not set
# CONFIG_ADVANTECH_WDT is not set
# CONFIG_ALIM1535_WDT is not set
# CONFIG_ALIM7101_WDT is not set
# CONFIG_SC520_WDT is not set
# CONFIG_PCWATCHDOG is not set
# CONFIG_EUROTECH_WDT is not set
# CONFIG_IB700_WDT is not set
# CONFIG_WAFER_WDT is not set
CONFIG_I810_TCO=m
# CONFIG_MIXCOMWD is not set
# CONFIG_60XX_WDT is not set
# CONFIG_SC1200_WDT is not set
# CONFIG_SCx200_WDT is not set
CONFIG_SOFT_WATCHDOG=m
# CONFIG_W83877F_WDT is not set
# CONFIG_WDT is not set
# CONFIG_WDTPCI is not set
# CONFIG_MACHZ_WDT is not set
# CONFIG_AMD7XX_TCO is not set
# CONFIG_SCx200_GPIO is not set
CONFIG_AMD_RNG=m
CONFIG_INTEL_RNG=m
CONFIG_AMD_PM768=m
CONFIG_NVRAM=m
CONFIG_RTC=m
# CONFIG_DTLK is not set
# CONFIG_R3964 is not set
# CONFIG_APPLICOM is not set
# CONFIG_SONYPI is not set

#
# Ftape, the floppy tape device driver
#
# CONFIG_FTAPE is not set
CONFIG_AGP=m
CONFIG_AGP_INTEL=y
CONFIG_AGP_I810=y
CONFIG_AGP_VIA=y
CONFIG_AGP_AMD=y
CONFIG_AGP_AMD_8151=y
CONFIG_AGP_SIS=y
CONFIG_AGP_ALI=y
CONFIG_AGP_SWORKS=y
CONFIG_AGP_NVIDIA=y
CONFIG_DRM=y
# CONFIG_DRM_OLD is not set

#
# DRM 4.1 drivers
#
CONFIG_DRM_NEW=y
CONFIG_DRM_TDFX=m
CONFIG_DRM_R128=m
CONFIG_DRM_RADEON=m
CONFIG_DRM_I810=m
CONFIG_DRM_I810_XFREE_41=y
CONFIG_DRM_I830=m
CONFIG_DRM_MGA=m
CONFIG_DRM_SIS=m
# CONFIG_MWAVE is not set

#
# Multimedia devices
#
# CONFIG_VIDEO_DEV is not set

#
# File systems
#
CONFIG_QUOTA=y
CONFIG_QFMT_V2=m
CONFIG_AUTOFS_FS=m
CONFIG_AUTOFS4_FS=m
CONFIG_REISERFS_FS=y
# CONFIG_REISERFS_CHECK is not set
CONFIG_REISERFS_PROC_INFO=y
# CONFIG_ADFS_FS is not set
# CONFIG_ADFS_FS_RW is not set
# CONFIG_AFFS_FS is not set
CONFIG_HFS_FS=m
CONFIG_HFSPLUS_FS=m
# CONFIG_BEFS_FS is not set
# CONFIG_BEFS_DEBUG is not set
# CONFIG_BFS_FS is not set
CONFIG_EXT3_FS=y
CONFIG_JBD=y
# CONFIG_JBD_DEBUG is not set
CONFIG_FAT_FS=m
# CONFIG_MSDOS_FS is not set
# CONFIG_UMSDOS_FS is not set
CONFIG_VFAT_FS=m
# CONFIG_EFS_FS is not set
# CONFIG_JFFS_FS is not set
# CONFIG_JFFS2_FS is not set
CONFIG_CRAMFS=m
CONFIG_TMPFS=y
CONFIG_RAMFS=y
CONFIG_ISO9660_FS=m
CONFIG_JOLIET=y
CONFIG_ZISOFS=y
CONFIG_JFS_FS=m
# CONFIG_JFS_DEBUG is not set
CONFIG_JFS_STATISTICS=y
# CONFIG_MINIX_FS is not set
# CONFIG_VXFS_FS is not set
CONFIG_NTFS_FS=m
# CONFIG_NTFS_RW is not set
# CONFIG_HPFS_FS is not set
CONFIG_PROC_FS=y
# CONFIG_DEVFS_FS is not set
# CONFIG_DEVFS_MOUNT is not set
# CONFIG_DEVFS_DEBUG is not set
CONFIG_DEVPTS_FS=y
# CONFIG_QNX4FS_FS is not set
# CONFIG_QNX4FS_RW is not set
# CONFIG_ROMFS_FS is not set
CONFIG_EXT2_FS=m
# CONFIG_SYSV_FS is not set
CONFIG_UDF_FS=m
# CONFIG_UDF_RW is not set
# CONFIG_UFS_FS is not set
# CONFIG_UFS_FS_WRITE is not set

#
# Network File Systems
#
CONFIG_CODA_FS=m
CONFIG_INTERMEZZO_FS=m
CONFIG_NFS_FS=m
CONFIG_NFS_V3=y
# CONFIG_NFS_DIRECTIO is not set
# CONFIG_ROOT_NFS is not set
CONFIG_NFSD=m
CONFIG_NFSD_V3=y
CONFIG_NFSD_TCP=y
CONFIG_SUNRPC=m
CONFIG_LOCKD=m
CONFIG_LOCKD_V4=y
CONFIG_SMB_FS=m
CONFIG_SMB_NLS_DEFAULT=y
CONFIG_SMB_NLS_REMOTE="cp437"
# CONFIG_NCP_FS is not set
# CONFIG_NCPFS_PACKET_SIGNING is not set
# CONFIG_NCPFS_IOCTL_LOCKING is not set
# CONFIG_NCPFS_STRONG is not set
# CONFIG_NCPFS_NFS_NS is not set
# CONFIG_NCPFS_OS2_NS is not set
# CONFIG_NCPFS_SMALLDOS is not set
# CONFIG_NCPFS_NLS is not set
# CONFIG_NCPFS_EXTRAS is not set
CONFIG_ZISOFS_FS=m

#
# Partition Types
#
CONFIG_PARTITION_ADVANCED=y
# CONFIG_ACORN_PARTITION is not set
# CONFIG_OSF_PARTITION is not set
# CONFIG_AMIGA_PARTITION is not set
# CONFIG_ATARI_PARTITION is not set
CONFIG_MAC_PARTITION=y
CONFIG_MSDOS_PARTITION=y
# CONFIG_BSD_DISKLABEL is not set
# CONFIG_MINIX_SUBPARTITION is not set
# CONFIG_SOLARIS_X86_PARTITION is not set
# CONFIG_UNIXWARE_DISKLABEL is not set
CONFIG_LDM_PARTITION=y
# CONFIG_LDM_DEBUG is not set
# CONFIG_SGI_PARTITION is not set
# CONFIG_ULTRIX_PARTITION is not set
# CONFIG_SUN_PARTITION is not set
# CONFIG_EFI_PARTITION is not set
CONFIG_SMB_NLS=y
CONFIG_NLS=y

#
# Native Language Support
#
CONFIG_NLS_DEFAULT="cp437"
CONFIG_NLS_CODEPAGE_437=m
CONFIG_NLS_CODEPAGE_737=m
CONFIG_NLS_CODEPAGE_775=m
CONFIG_NLS_CODEPAGE_850=m
CONFIG_NLS_CODEPAGE_852=m
CONFIG_NLS_CODEPAGE_855=m
CONFIG_NLS_CODEPAGE_857=m
CONFIG_NLS_CODEPAGE_860=m
CONFIG_NLS_CODEPAGE_861=m
CONFIG_NLS_CODEPAGE_862=m
CONFIG_NLS_CODEPAGE_863=m
CONFIG_NLS_CODEPAGE_864=m
CONFIG_NLS_CODEPAGE_865=m
CONFIG_NLS_CODEPAGE_866=m
CONFIG_NLS_CODEPAGE_869=m
CONFIG_NLS_CODEPAGE_936=m
CONFIG_NLS_CODEPAGE_950=m
CONFIG_NLS_CODEPAGE_932=m
CONFIG_NLS_CODEPAGE_949=m
CONFIG_NLS_CODEPAGE_874=m
CONFIG_NLS_ISO8859_8=m
CONFIG_NLS_CODEPAGE_1250=m
CONFIG_NLS_CODEPAGE_1251=m
CONFIG_NLS_ISO8859_1=m
CONFIG_NLS_ISO8859_2=m
CONFIG_NLS_ISO8859_3=m
CONFIG_NLS_ISO8859_4=m
CONFIG_NLS_ISO8859_5=m
CONFIG_NLS_ISO8859_6=m
CONFIG_NLS_ISO8859_7=m
CONFIG_NLS_ISO8859_9=m
CONFIG_NLS_ISO8859_13=m
CONFIG_NLS_ISO8859_14=m
CONFIG_NLS_ISO8859_15=m
CONFIG_NLS_KOI8_R=m
CONFIG_NLS_KOI8_U=m
CONFIG_NLS_UTF8=m

#
# Console drivers
#
CONFIG_VGA_CONSOLE=y
CONFIG_VIDEO_SELECT=y
# CONFIG_MDA_CONSOLE is not set

#
# Frame-buffer support
#
# CONFIG_FB is not set

#
# Sound
#
CONFIG_SOUND=m
CONFIG_SOUND_ALI5455=m
CONFIG_SOUND_BT878=m
CONFIG_SOUND_CMPCI=m
# CONFIG_SOUND_CMPCI_FM is not set
# CONFIG_SOUND_CMPCI_MIDI is not set
CONFIG_SOUND_CMPCI_JOYSTICK=y
CONFIG_SOUND_CMPCI_CM8738=y
# CONFIG_SOUND_CMPCI_SPDIFINVERSE is not set
# CONFIG_SOUND_CMPCI_SPDIFLOOP is not set
CONFIG_SOUND_CMPCI_SPEAKERS=2
CONFIG_SOUND_EMU10K1=m
CONFIG_MIDI_EMU10K1=y
# CONFIG_SOUND_FUSION is not set
CONFIG_SOUND_CS4281=m
CONFIG_SOUND_ES1370=m
CONFIG_SOUND_ES1371=m
CONFIG_SOUND_ESSSOLO1=m
CONFIG_SOUND_MAESTRO=m
CONFIG_SOUND_MAESTRO3=m
CONFIG_SOUND_FORTE=m
CONFIG_SOUND_ICH=m
CONFIG_SOUND_RME96XX=m
CONFIG_SOUND_SONICVIBES=m
CONFIG_SOUND_TRIDENT=m
CONFIG_SOUND_MSNDCLAS=m
# CONFIG_MSNDCLAS_HAVE_BOOT is not set
CONFIG_MSNDCLAS_INIT_FILE="/etc/sound/msndinit.bin"
CONFIG_MSNDCLAS_PERM_FILE="/etc/sound/msndperm.bin"
CONFIG_SOUND_MSNDPIN=m
# CONFIG_MSNDPIN_HAVE_BOOT is not set
CONFIG_MSNDPIN_INIT_FILE="/etc/sound/pndspini.bin"
CONFIG_MSNDPIN_PERM_FILE="/etc/sound/pndsperm.bin"
CONFIG_SOUND_VIA82CXXX=m
CONFIG_MIDI_VIA82CXXX=y
CONFIG_SOUND_OSS=m
# CONFIG_SOUND_TRACEINIT is not set
CONFIG_SOUND_DMAP=y
CONFIG_SOUND_AD1816=m
CONFIG_SOUND_AD1889=m
CONFIG_SOUND_SGALAXY=m
CONFIG_SOUND_ADLIB=m
CONFIG_SOUND_ACI_MIXER=m
CONFIG_SOUND_CS4232=m
CONFIG_SOUND_SSCAPE=m
CONFIG_SOUND_GUS=m
CONFIG_SOUND_GUS16=y
CONFIG_SOUND_GUSMAX=y
CONFIG_SOUND_VMIDI=m
CONFIG_SOUND_TRIX=m
CONFIG_SOUND_MSS=m
CONFIG_SOUND_MPU401=m
CONFIG_SOUND_NM256=m
CONFIG_SOUND_MAD16=m
CONFIG_MAD16_OLDCARD=y
CONFIG_SOUND_PAS=m
# CONFIG_PAS_JOYSTICK is not set
CONFIG_SOUND_PSS=m
CONFIG_PSS_MIXER=y
# CONFIG_PSS_HAVE_BOOT is not set
CONFIG_SOUND_SB=m
CONFIG_SOUND_AWE32_SYNTH=m
CONFIG_SOUND_KAHLUA=m
CONFIG_SOUND_WAVEFRONT=m
CONFIG_SOUND_MAUI=m
CONFIG_SOUND_YM3812=m
CONFIG_SOUND_OPL3SA1=m
CONFIG_SOUND_OPL3SA2=m
CONFIG_SOUND_YMFPCI=m
CONFIG_SOUND_YMFPCI_LEGACY=y
CONFIG_SOUND_UART6850=m
CONFIG_SOUND_AEDSP16=m
CONFIG_SC6600=y
CONFIG_SC6600_JOY=y
CONFIG_SC6600_CDROM=4
CONFIG_SC6600_CDROMBASE=0
CONFIG_AEDSP16_SBPRO=y
CONFIG_AEDSP16_MPU401=y
CONFIG_SOUND_TVMIXER=m

#
# USB support
#
CONFIG_USB=m
# CONFIG_USB_DEBUG is not set

#
# Miscellaneous USB options
#
CONFIG_USB_DEVICEFS=y
CONFIG_USB_BANDWIDTH=y

#
# USB Host Controller Drivers
#
CONFIG_USB_EHCI_HCD=m
CONFIG_USB_UHCI=m
CONFIG_USB_UHCI_ALT=m
CONFIG_USB_OHCI=m

#
# USB Device Class drivers
#
CONFIG_USB_AUDIO=m
CONFIG_USB_EMI26=m
CONFIG_USB_BLUETOOTH=m
CONFIG_USB_MIDI=m
CONFIG_USB_STORAGE=m
CONFIG_USB_STORAGE_DEBUG=y
CONFIG_USB_STORAGE_DATAFAB=y
CONFIG_USB_STORAGE_FREECOM=y
CONFIG_USB_STORAGE_ISD200=y
CONFIG_USB_STORAGE_DPCM=y
CONFIG_USB_STORAGE_HP8200e=y
CONFIG_USB_STORAGE_SDDR09=y
CONFIG_USB_STORAGE_SDDR55=y
CONFIG_USB_STORAGE_JUMPSHOT=y
CONFIG_USB_ACM=m
CONFIG_USB_PRINTER=m

#
# USB Human Interface Devices (HID)
#
CONFIG_USB_HID=m
CONFIG_USB_HIDINPUT=y
CONFIG_USB_HIDDEV=y
CONFIG_USB_KBD=m
CONFIG_USB_MOUSE=m
CONFIG_USB_AIPTEK=m
CONFIG_USB_WACOM=m
CONFIG_USB_KBTAB=m
CONFIG_USB_POWERMATE=m

#
# USB Imaging devices
#
CONFIG_USB_DC2XX=m
CONFIG_USB_MDC800=m
CONFIG_USB_SCANNER=m
CONFIG_USB_MICROTEK=m
CONFIG_USB_HPUSBSCSI=m

#
# USB Multimedia devices
#

#
#   Video4Linux support is needed for USB Multimedia device support
#

#
# USB Network adaptors
#
CONFIG_USB_PEGASUS=m
CONFIG_USB_RTL8150=m
CONFIG_USB_KAWETH=m
CONFIG_USB_CATC=m
CONFIG_USB_AX8817X=m
CONFIG_USB_CDCETHER=m
CONFIG_USB_USBNET=m

#
# USB port drivers
#
CONFIG_USB_USS720=m

#
# USB Serial Converter support
#
CONFIG_USB_SERIAL=m
# CONFIG_USB_SERIAL_DEBUG is not set
CONFIG_USB_SERIAL_GENERIC=y
CONFIG_USB_SERIAL_BELKIN=m
CONFIG_USB_SERIAL_WHITEHEAT=m
CONFIG_USB_SERIAL_DIGI_ACCELEPORT=m
CONFIG_USB_SERIAL_EMPEG=m
CONFIG_USB_SERIAL_FTDI_SIO=m
CONFIG_USB_SERIAL_VISOR=m
CONFIG_USB_SERIAL_IPAQ=m
CONFIG_USB_SERIAL_IR=m
CONFIG_USB_SERIAL_EDGEPORT=m
CONFIG_USB_SERIAL_EDGEPORT_TI=m
CONFIG_USB_SERIAL_KEYSPAN_PDA=m
CONFIG_USB_SERIAL_KEYSPAN=m
CONFIG_USB_SERIAL_KEYSPAN_USA28=y
CONFIG_USB_SERIAL_KEYSPAN_USA28X=y
CONFIG_USB_SERIAL_KEYSPAN_USA28XA=y
CONFIG_USB_SERIAL_KEYSPAN_USA28XB=y
CONFIG_USB_SERIAL_KEYSPAN_USA19=y
CONFIG_USB_SERIAL_KEYSPAN_USA18X=y
CONFIG_USB_SERIAL_KEYSPAN_USA19W=y
CONFIG_USB_SERIAL_KEYSPAN_USA19QW=y
CONFIG_USB_SERIAL_KEYSPAN_USA19QI=y
CONFIG_USB_SERIAL_KEYSPAN_MPR=y
CONFIG_USB_SERIAL_KEYSPAN_USA49W=y
CONFIG_USB_SERIAL_KEYSPAN_USA49WLC=y
CONFIG_USB_SERIAL_MCT_U232=m
CONFIG_USB_SERIAL_KLSI=m
CONFIG_USB_SERIAL_KOBIL_SCT=m
CONFIG_USB_SERIAL_PL2303=m
CONFIG_USB_SERIAL_CYBERJACK=m
CONFIG_USB_SERIAL_XIRCOM=m
CONFIG_USB_SERIAL_OMNINET=m

#
# USB Miscellaneous drivers
#
CONFIG_USB_RIO500=m
CONFIG_USB_AUERSWALD=m
CONFIG_USB_TIGL=m
CONFIG_USB_BRLVGER=m
CONFIG_USB_LCD=m
# CONFIG_USB_SPEEDTOUCH is not set

#
# Bluetooth support
#
# CONFIG_BLUEZ is not set

#
# Kernel hacking
#
CONFIG_DEBUG_KERNEL=y
CONFIG_DEBUG_STACKOVERFLOW=y
# CONFIG_DEBUG_HIGHMEM is not set
CONFIG_DEBUG_SLAB=y
# CONFIG_DEBUG_IOVIRT is not set
CONFIG_MAGIC_SYSRQ=y
# CONFIG_DEBUG_SPINLOCK is not set
CONFIG_FRAME_POINTER=y

#
# Cryptographic options
#
CONFIG_CRYPTO=y
CONFIG_CRYPTO_HMAC=y
# CONFIG_CRYPTO_NULL is not set
CONFIG_CRYPTO_MD4=m
CONFIG_CRYPTO_MD5=m
CONFIG_CRYPTO_SHA1=m
CONFIG_CRYPTO_SHA256=m
CONFIG_CRYPTO_SHA512=m
CONFIG_CRYPTO_DES=m
CONFIG_CRYPTO_BLOWFISH=m
CONFIG_CRYPTO_TWOFISH=m
CONFIG_CRYPTO_SERPENT=m
CONFIG_CRYPTO_AES=m
CONFIG_CRYPTO_DEFLATE=m
CONFIG_CRYPTO_TEST=m

#
# Library routines
#
CONFIG_CRC32=y
CONFIG_ZLIB_INFLATE=m
CONFIG_ZLIB_DEFLATE=m

--4SFOXa2GPu3tIq4H--
