Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261187AbVFTIJ7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261187AbVFTIJ7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Jun 2005 04:09:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261239AbVFTIJ6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Jun 2005 04:09:58 -0400
Received: from osten.wh.Uni-Dortmund.DE ([129.217.129.130]:47318 "EHLO
	osten.wh.uni-dortmund.de") by vger.kernel.org with ESMTP
	id S261187AbVFTIIt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Jun 2005 04:08:49 -0400
Message-ID: <42B6798F.1060200@web.de>
Date: Mon, 20 Jun 2005 10:08:47 +0200
From: Alexander Fieroch <fieroch@web.de>
User-Agent: Debian Thunderbird 1.0.2 (X11/20050402)
X-Accept-Language: de-de, en-us, en
MIME-Version: 1.0
Newsgroups: gmane.linux.kernel
Cc: "Protasevich, Natalie" <Natalie.Protasevich@UNISYS.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, bzolnier@gmail.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, axboe@suse.de,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Subject: Re: [2.6.12rc4] PROBLEM: "drive appears confused" and "irq 18:  
   nobody cared!"
References: <19D0D50E9B1D0A40A9F0323DBFA04ACCE04BFF@USRV-EXCH4.na.uis.unisys.com>
In-Reply-To: <19D0D50E9B1D0A40A9F0323DBFA04ACCE04BFF@USRV-EXCH4.na.uis.unisys.com>
Content-Type: multipart/mixed;
 boundary="------------090006040700090304050104"
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------090006040700090304050104
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Protasevich, Natalie wrote:
> I would also recommend booting with pci=routeirq, this will show the
> pre-disposition of each GSI->IRQ pair, although sometimes it changes IRQ
> distribution, and you may get different error. Also try using apic=debug
> or acpi=verbose to see the IO-APIC lines setup.

I've booted kernel 2.6.12-git1 + iteraid.patch from Andrew with kernel
parameters pci=routeirq and apic=debug. You'll find the complete syslog
as attachment.
Hope, that helps you.

> For debug failed IRQs, I
> sometimes insert print_io_APIC() after each PCI device IRQ registration,
> to see it got edge or level triggered and other details. 
> The other one that I saw causing problems especially for ISA devices is
> ACPI PnP (and still does, I'm researching a similar problem on ES7000),
> and in this case I get my system booted with pnpacpi=off.

I don't have any ISA devices on my board.

Regards,
Alexander


--------------090006040700090304050104
Content-Type: text/plain;
 name="syslog2612git1iteraid"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline;
 filename="syslog2612git1iteraid"

Jun 20 09:54:04 orclex syslog-ng[4228]: syslog-ng version 1.6.7 starting
Jun 20 09:54:04 orclex syslog-ng[4228]: Changing permissions on special file /dev/xconsole
Jun 20 09:54:04 orclex syslog-ng[4228]: Cannot open file /dev/xconsole for writing (No such file or directory)
Jun 20 09:54:04 orclex kernel: Bootdata ok (command line is root=/dev/sda3 vga=792 pci=routeirq apic=debug)
Jun 20 09:54:04 orclex kernel: Linux version 2.6.12-git1 (root@orclex) (gcc-Version 3.3.6 (Debian 1:3.3.6-5)) #2 SMP Mon Jun 20 09:49:05 CEST 2005
Jun 20 09:54:04 orclex kernel: BIOS-provided physical RAM map:
Jun 20 09:54:04 orclex kernel: BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
Jun 20 09:54:04 orclex kernel: BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
Jun 20 09:54:04 orclex kernel: BIOS-e820: 00000000000e4000 - 0000000000100000 (reserved)
Jun 20 09:54:04 orclex kernel: BIOS-e820: 0000000000100000 - 000000003ffb0000 (usable)
Jun 20 09:54:04 orclex kernel: BIOS-e820: 000000003ffb0000 - 000000003ffbe000 (ACPI data)
Jun 20 09:54:04 orclex kernel: BIOS-e820: 000000003ffbe000 - 000000003fff0000 (ACPI NVS)
Jun 20 09:54:04 orclex kernel: BIOS-e820: 000000003fff0000 - 0000000040000000 (reserved)
Jun 20 09:54:04 orclex kernel: BIOS-e820: 00000000ffb00000 - 0000000100000000 (reserved)
Jun 20 09:54:04 orclex kernel: ACPI: RSDP (v002 ACPIAM                                ) @ 0x00000000000fb070
Jun 20 09:54:04 orclex kernel: ACPI: XSDT (v001 A M I  OEMXSDT  0x03000521 MSFT 0x00000097) @ 0x000000003ffb0100
Jun 20 09:54:04 orclex kernel: ACPI: FADT (v003 A M I  OEMFACP  0x03000521 MSFT 0x00000097) @ 0x000000003ffb0290
Jun 20 09:54:04 orclex kernel: ACPI: MADT (v001 A M I  OEMAPIC  0x03000521 MSFT 0x00000097) @ 0x000000003ffb0390
Jun 20 09:54:04 orclex kernel: ACPI: OEMB (v001 A M I  AMI_OEM  0x03000521 MSFT 0x00000097) @ 0x000000003ffbe040
Jun 20 09:54:04 orclex kernel: ACPI: MCFG (v001 A M I  OEMMCFG  0x03000521 MSFT 0x00000097) @ 0x000000003ffb6c60
Jun 20 09:54:04 orclex kernel: ACPI: DSDT (v001  A0086 A0086003 0x00000003 INTL 0x02002026) @ 0x0000000000000000
Jun 20 09:54:04 orclex kernel: On node 0 totalpages: 262064
Jun 20 09:54:04 orclex kernel: DMA zone: 4096 pages, LIFO batch:1
Jun 20 09:54:04 orclex kernel: Normal zone: 257968 pages, LIFO batch:31
Jun 20 09:54:04 orclex kernel: HighMem zone: 0 pages, LIFO batch:1
Jun 20 09:54:04 orclex kernel: ACPI: PM-Timer IO Port: 0x808
Jun 20 09:54:04 orclex kernel: ACPI: Local APIC address 0xfee00000
Jun 20 09:54:04 orclex kernel: ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
Jun 20 09:54:04 orclex kernel: Processor #0 15:4 APIC version 16
Jun 20 09:54:04 orclex kernel: ACPI: LAPIC (acpi_id[0x02] lapic_id[0x01] enabled)
Jun 20 09:54:04 orclex kernel: Processor #1 15:4 APIC version 16
Jun 20 09:54:04 orclex kernel: ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])
Jun 20 09:54:04 orclex kernel: IOAPIC[0]: apic_id 2, version 32, address 0xfec00000, GSI 0-23
Jun 20 09:54:04 orclex kernel: ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
Jun 20 09:54:04 orclex kernel: ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
Jun 20 09:54:04 orclex kernel: ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
Jun 20 09:54:04 orclex kernel: ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
Jun 20 09:54:04 orclex kernel: ACPI: IRQ0 used by override.
Jun 20 09:54:04 orclex kernel: ACPI: IRQ2 used by override.
Jun 20 09:54:04 orclex kernel: ACPI: IRQ9 used by override.
Jun 20 09:54:04 orclex kernel: Setting APIC routing to flat
Jun 20 09:54:04 orclex kernel: Using ACPI (MADT) for SMP configuration information
Jun 20 09:54:04 orclex kernel: Allocating PCI resources starting at 40000000 (gap: 40000000:bfb00000)
Jun 20 09:54:04 orclex kernel: Built 1 zonelists
Jun 20 09:54:04 orclex kernel: Kernel command line: root=/dev/sda3 vga=792 pci=routeirq apic=debug
Jun 20 09:54:04 orclex kernel: Initializing CPU#0
Jun 20 09:54:04 orclex kernel: PID hash table entries: 4096 (order: 12, 131072 bytes)
Jun 20 09:54:04 orclex kernel: time.c: Using 3.579545 MHz PM timer.
Jun 20 09:54:04 orclex kernel: time.c: Detected 3010.804 MHz processor.
Jun 20 09:54:04 orclex kernel: Console: colour dummy device 80x25
Jun 20 09:54:04 orclex kernel: Dentry cache hash table entries: 262144 (order: 9, 2097152 bytes)
Jun 20 09:54:04 orclex kernel: Inode-cache hash table entries: 131072 (order: 8, 1048576 bytes)
Jun 20 09:54:04 orclex kernel: Memory: 1023836k/1048256k available (3317k kernel code, 23728k reserved, 1760k data, 228k init)
Jun 20 09:54:04 orclex kernel: Calibrating delay loop... 5947.39 BogoMIPS (lpj=2973696)
Jun 20 09:54:04 orclex kernel: Security Framework v1.0.0 initialized
Jun 20 09:54:04 orclex kernel: Capability LSM initialized
Jun 20 09:54:04 orclex kernel: Mount-cache hash table entries: 256
Jun 20 09:54:04 orclex kernel: CPU: Trace cache: 12K uops, L1 D cache: 16K
Jun 20 09:54:04 orclex kernel: CPU: L2 cache: 2048K
Jun 20 09:54:04 orclex kernel: using mwait in idle threads.
Jun 20 09:54:04 orclex kernel: CPU: Physical Processor ID: 0
Jun 20 09:54:04 orclex kernel: CPU0: Thermal monitoring enabled (TM1)
Jun 20 09:54:04 orclex kernel: enabled ExtINT on CPU#0
Jun 20 09:54:04 orclex kernel: ENABLING IO-APIC IRQs
Jun 20 09:54:04 orclex kernel: init IO_APIC IRQs
Jun 20 09:54:04 orclex kernel: IO-APIC (apicid-pin) 2-0, 2-16, 2-17, 2-18, 2-19, 2-20, 2-21, 2-22, 2-23 not connected.
Jun 20 09:54:04 orclex kernel: ..TIMER: vector=0x31 pin1=2 pin2=-1
Jun 20 09:54:04 orclex kernel: Using local APIC timer interrupts.
Jun 20 09:54:04 orclex kernel: Detected 12.544 MHz APIC timer.
Jun 20 09:54:04 orclex kernel: Booting processor 1/1 rip 6000 rsp ffff810002191f58
Jun 20 09:54:04 orclex kernel: Initializing CPU#1
Jun 20 09:54:04 orclex kernel: masked ExtINT on CPU#1
Jun 20 09:54:04 orclex kernel: Calibrating delay loop... 6012.92 BogoMIPS (lpj=3006464)
Jun 20 09:54:04 orclex kernel: CPU: Trace cache: 12K uops, L1 D cache: 16K
Jun 20 09:54:04 orclex kernel: CPU: L2 cache: 2048K
Jun 20 09:54:04 orclex kernel: CPU: Physical Processor ID: 0
Jun 20 09:54:04 orclex kernel: CPU1: Thermal monitoring enabled (TM1)
Jun 20 09:54:04 orclex kernel: Intel(R) Pentium(R) 4 CPU 3.00GHz stepping 03
Jun 20 09:54:04 orclex kernel: APIC error on CPU1: 00(40)
Jun 20 09:54:04 orclex kernel: CPU 1: Syncing TSC to CPU 0.
Jun 20 09:54:04 orclex kernel: Brought up 2 CPUs
Jun 20 09:54:04 orclex kernel: CPU 1: synchronized TSC with CPU 0 (last diff -1 cycles, maxerr 773 cycles)
Jun 20 09:54:04 orclex kernel: time.c: Using PIT/TSC based timekeeping.
Jun 20 09:54:04 orclex kernel: testing NMI watchdog ... OK.
Jun 20 09:54:04 orclex kernel: CPU0 attaching sched-domain:
Jun 20 09:54:04 orclex kernel: domain 0: span 03
Jun 20 09:54:04 orclex kernel: groups: 01 02
Jun 20 09:54:04 orclex kernel: domain 1: span 03
Jun 20 09:54:04 orclex kernel: groups: 03
Jun 20 09:54:04 orclex kernel: CPU1 attaching sched-domain:
Jun 20 09:54:04 orclex kernel: domain 0: span 03
Jun 20 09:54:04 orclex kernel: groups: 02 01
Jun 20 09:54:04 orclex kernel: domain 1: span 03
Jun 20 09:54:04 orclex kernel: groups: 03
Jun 20 09:54:04 orclex kernel: NET: Registered protocol family 16
Jun 20 09:54:04 orclex kernel: PCI: Using configuration type 1
Jun 20 09:54:04 orclex kernel: PCI: Using MMCONFIG at e0000000
Jun 20 09:54:04 orclex kernel: mtrr: v2.0 (20020519)
Jun 20 09:54:04 orclex kernel: ACPI: Subsystem revision 20050309
Jun 20 09:54:04 orclex kernel: ACPI: Interpreter enabled
Jun 20 09:54:04 orclex kernel: ACPI: Using IOAPIC for interrupt routing
Jun 20 09:54:04 orclex kernel: ACPI: PCI Root Bridge [PCI0] (0000:00)
Jun 20 09:54:04 orclex kernel: PCI: Probing PCI hardware (bus 00)
Jun 20 09:54:04 orclex kernel: Boot video device is 0000:04:00.0
Jun 20 09:54:04 orclex kernel: PCI: Transparent bridge - 0000:00:1e.0
Jun 20 09:54:04 orclex kernel: ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
Jun 20 09:54:04 orclex kernel: ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P0P1._PRT]
Jun 20 09:54:04 orclex kernel: ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P0P3._PRT]
Jun 20 09:54:04 orclex kernel: ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P0P4._PRT]
Jun 20 09:54:04 orclex kernel: ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P0P5._PRT]
Jun 20 09:54:04 orclex kernel: ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 10 *11 12 14 15)
Jun 20 09:54:04 orclex kernel: ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 *5 6 7 10 11 12 14 15)
Jun 20 09:54:04 orclex kernel: ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 10 11 12 14 *15)
Jun 20 09:54:04 orclex kernel: ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 10 11 12 *14 15)
Jun 20 09:54:04 orclex kernel: ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, disabled.
Jun 20 09:54:04 orclex kernel: ACPI: PCI Interrupt Link [LNKF] (IRQs *3 4 5 6 7 10 11 12 14 15)
Jun 20 09:54:04 orclex kernel: ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, disabled.
Jun 20 09:54:04 orclex kernel: ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 *5 6 7 10 11 12 14 15)
Jun 20 09:54:04 orclex kernel: Linux Plug and Play Support v0.97 (c) Adam Belay
Jun 20 09:54:04 orclex kernel: pnp: PnP ACPI init
Jun 20 09:54:04 orclex kernel: IOAPIC[0]: Set PCI routing entry (2-8 -> 0x69 -> IRQ 8 Mode:0 Active:0)
Jun 20 09:54:04 orclex kernel: IOAPIC[0]: Set PCI routing entry (2-13 -> 0x91 -> IRQ 13 Mode:0 Active:0)
Jun 20 09:54:04 orclex kernel: IOAPIC[0]: Set PCI routing entry (2-6 -> 0x59 -> IRQ 6 Mode:0 Active:0)
Jun 20 09:54:04 orclex kernel: IOAPIC[0]: Set PCI routing entry (2-7 -> 0x61 -> IRQ 7 Mode:0 Active:0)
Jun 20 09:54:04 orclex kernel: IOAPIC[0]: Set PCI routing entry (2-1 -> 0x39 -> IRQ 1 Mode:0 Active:0)
Jun 20 09:54:04 orclex kernel: IOAPIC[0]: Set PCI routing entry (2-10 -> 0x79 -> IRQ 10 Mode:0 Active:0)
Jun 20 09:54:04 orclex kernel: IOAPIC[0]: Set PCI routing entry (2-4 -> 0x49 -> IRQ 4 Mode:0 Active:0)
Jun 20 09:54:04 orclex kernel: pnp: PnP ACPI: found 19 devices
Jun 20 09:54:04 orclex kernel: SCSI subsystem initialized
Jun 20 09:54:04 orclex kernel: usbcore: registered new driver usbfs
Jun 20 09:54:04 orclex kernel: usbcore: registered new driver hub
Jun 20 09:54:04 orclex kernel: PCI: Using ACPI for IRQ routing
Jun 20 09:54:04 orclex kernel: PCI: Routing PCI interrupts for all devices because "pci=routeirq" specified
Jun 20 09:54:04 orclex kernel: IOAPIC[0]: Set PCI routing entry (2-16 -> 0xa9 -> IRQ 16 Mode:1 Active:1)
Jun 20 09:54:04 orclex kernel: ACPI: PCI Interrupt 0000:00:01.0[A] -> GSI 16 (level, low) -> IRQ 169
Jun 20 09:54:04 orclex kernel: ACPI: PCI Interrupt 0000:00:1b.0[A] -> GSI 16 (level, low) -> IRQ 169
Jun 20 09:54:04 orclex kernel: ACPI: PCI Interrupt 0000:00:1c.0[A] -> GSI 16 (level, low) -> IRQ 169
Jun 20 09:54:04 orclex kernel: IOAPIC[0]: Set PCI routing entry (2-17 -> 0xb1 -> IRQ 17 Mode:1 Active:1)
Jun 20 09:54:04 orclex kernel: ACPI: PCI Interrupt 0000:00:1c.1[B] -> GSI 17 (level, low) -> IRQ 177
Jun 20 09:54:04 orclex kernel: IOAPIC[0]: Set PCI routing entry (2-23 -> 0xb9 -> IRQ 23 Mode:1 Active:1)
Jun 20 09:54:04 orclex kernel: ACPI: PCI Interrupt 0000:00:1d.0[A] -> GSI 23 (level, low) -> IRQ 185
Jun 20 09:54:04 orclex kernel: IOAPIC[0]: Set PCI routing entry (2-19 -> 0xc1 -> IRQ 19 Mode:1 Active:1)
Jun 20 09:54:04 orclex kernel: ACPI: PCI Interrupt 0000:00:1d.1[B] -> GSI 19 (level, low) -> IRQ 193
Jun 20 09:54:04 orclex kernel: IOAPIC[0]: Set PCI routing entry (2-18 -> 0xc9 -> IRQ 18 Mode:1 Active:1)
Jun 20 09:54:04 orclex kernel: ACPI: PCI Interrupt 0000:00:1d.2[C] -> GSI 18 (level, low) -> IRQ 201
Jun 20 09:54:04 orclex kernel: ACPI: PCI Interrupt 0000:00:1d.3[D] -> GSI 16 (level, low) -> IRQ 169
Jun 20 09:54:04 orclex kernel: ACPI: PCI Interrupt 0000:00:1d.7[A] -> GSI 23 (level, low) -> IRQ 185
Jun 20 09:54:04 orclex kernel: ACPI: PCI Interrupt 0000:00:1f.1[A] -> GSI 18 (level, low) -> IRQ 201
Jun 20 09:54:04 orclex kernel: ACPI: PCI Interrupt 0000:00:1f.2[B] -> GSI 19 (level, low) -> IRQ 193
Jun 20 09:54:04 orclex kernel: ACPI: PCI Interrupt 0000:00:1f.3[B] -> GSI 19 (level, low) -> IRQ 193
Jun 20 09:54:04 orclex kernel: ACPI: PCI Interrupt 0000:04:00.0[A] -> GSI 16 (level, low) -> IRQ 169
Jun 20 09:54:04 orclex kernel: ACPI: PCI Interrupt 0000:02:00.0[A] -> GSI 17 (level, low) -> IRQ 177
Jun 20 09:54:04 orclex kernel: IOAPIC[0]: Set PCI routing entry (2-21 -> 0xd1 -> IRQ 21 Mode:1 Active:1)
Jun 20 09:54:04 orclex kernel: ACPI: PCI Interrupt 0000:01:03.0[A] -> GSI 21 (level, low) -> IRQ 209
Jun 20 09:54:04 orclex kernel: ACPI: PCI Interrupt 0000:01:04.0[A] -> GSI 23 (level, low) -> IRQ 185
Jun 20 09:54:04 orclex kernel: ACPI: PCI Interrupt 0000:01:06.0[A] -> GSI 16 (level, low) -> IRQ 169
Jun 20 09:54:04 orclex kernel: ACPI: PCI Interrupt 0000:01:09.0[A] -> GSI 17 (level, low) -> IRQ 177
Jun 20 09:54:04 orclex kernel: ACPI: PCI Interrupt 0000:01:09.1[A] -> GSI 17 (level, low) -> IRQ 177
Jun 20 09:54:04 orclex kernel: ACPI: PCI Interrupt 0000:01:0a.0[A] -> GSI 21 (level, low) -> IRQ 209
Jun 20 09:54:04 orclex kernel: number of MP IRQ sources: 17.
Jun 20 09:54:04 orclex kernel: number of IO-APIC #2 registers: 24.
Jun 20 09:54:04 orclex kernel: testing the IO APIC.......................
Jun 20 09:54:04 orclex kernel: 
Jun 20 09:54:04 orclex kernel: IO APIC #2......
Jun 20 09:54:04 orclex kernel: .... register #00: 02000000
Jun 20 09:54:04 orclex kernel: .......    : physical APIC id: 02
Jun 20 09:54:04 orclex kernel: .... register #01: 00170020
Jun 20 09:54:04 orclex kernel: .......     : max redirection entries: 0017
Jun 20 09:54:04 orclex kernel: .......     : PRQ implemented: 0
Jun 20 09:54:04 orclex kernel: .......     : IO APIC version: 0020
Jun 20 09:54:04 orclex kernel: .... register #02: 00170020
Jun 20 09:54:04 orclex kernel: .......     : arbitration: 00
Jun 20 09:54:04 orclex kernel: .... IRQ redirection table:
Jun 20 09:54:04 orclex kernel: NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:   
Jun 20 09:54:04 orclex kernel: 00 000 00  1    0    0   0   0    0    0    00
Jun 20 09:54:04 orclex kernel: 01 003 03  1    0    0   0   0    1    1    39
Jun 20 09:54:04 orclex kernel: 02 003 03  0    0    0   0   0    1    1    31
Jun 20 09:54:04 orclex kernel: 03 003 03  0    0    0   0   0    1    1    41
Jun 20 09:54:04 orclex kernel: 04 003 03  1    0    0   0   0    1    1    49
Jun 20 09:54:04 orclex kernel: 05 003 03  0    0    0   0   0    1    1    51
Jun 20 09:54:04 orclex kernel: 06 003 03  1    0    0   0   0    1    1    59
Jun 20 09:54:04 orclex kernel: 07 003 03  1    0    0   0   0    1    1    61
Jun 20 09:54:04 orclex kernel: 08 003 03  1    0    0   0   0    1    1    69
Jun 20 09:54:04 orclex kernel: 09 003 03  0    1    0   0   0    1    1    71
Jun 20 09:54:04 orclex kernel: 0a 003 03  1    0    0   0   0    1    1    79
Jun 20 09:54:04 orclex kernel: 0b 003 03  0    0    0   0   0    1    1    81
Jun 20 09:54:04 orclex kernel: 0c 003 03  0    0    0   0   0    1    1    89
Jun 20 09:54:04 orclex kernel: 0d 003 03  1    0    0   0   0    1    1    91
Jun 20 09:54:04 orclex kernel: 0e 003 03  0    0    0   0   0    1    1    99
Jun 20 09:54:04 orclex kernel: 0f 003 03  0    0    0   0   0    1    1    A1
Jun 20 09:54:04 orclex kernel: 10 003 03  1    1    0   1   0    1    1    A9
Jun 20 09:54:04 orclex kernel: 11 003 03  1    1    0   1   0    1    1    B1
Jun 20 09:54:04 orclex kernel: 12 003 03  1    1    0   1   0    1    1    C9
Jun 20 09:54:04 orclex kernel: 13 003 03  1    1    0   1   0    1    1    C1
Jun 20 09:54:04 orclex kernel: 14 000 00  1    0    0   0   0    0    0    00
Jun 20 09:54:04 orclex kernel: 15 003 03  1    1    0   1   0    1    1    D1
Jun 20 09:54:04 orclex kernel: 16 000 00  1    0    0   0   0    0    0    00
Jun 20 09:54:04 orclex kernel: 17 003 03  1    1    0   1   0    1    1    B9
Jun 20 09:54:04 orclex kernel: Using vector-based indexing
Jun 20 09:54:04 orclex kernel: IRQ to pin mappings:
Jun 20 09:54:04 orclex kernel: IRQ0 -> 0:2
Jun 20 09:54:04 orclex kernel: IRQ1 -> 0:1
Jun 20 09:54:04 orclex kernel: IRQ3 -> 0:3
Jun 20 09:54:04 orclex kernel: IRQ4 -> 0:4
Jun 20 09:54:04 orclex kernel: IRQ5 -> 0:5
Jun 20 09:54:04 orclex kernel: IRQ6 -> 0:6
Jun 20 09:54:04 orclex kernel: IRQ7 -> 0:7
Jun 20 09:54:04 orclex kernel: IRQ8 -> 0:8
Jun 20 09:54:04 orclex kernel: IRQ9 -> 0:9
Jun 20 09:54:04 orclex kernel: IRQ10 -> 0:10
Jun 20 09:54:04 orclex kernel: IRQ11 -> 0:11
Jun 20 09:54:04 orclex kernel: IRQ12 -> 0:12
Jun 20 09:54:04 orclex kernel: IRQ13 -> 0:13
Jun 20 09:54:04 orclex kernel: IRQ14 -> 0:14
Jun 20 09:54:04 orclex kernel: IRQ15 -> 0:15
Jun 20 09:54:04 orclex kernel: IRQ169 -> 0:16
Jun 20 09:54:04 orclex kernel: IRQ177 -> 0:17
Jun 20 09:54:04 orclex kernel: IRQ201 -> 0:18
Jun 20 09:54:04 orclex kernel: IRQ193 -> 0:19
Jun 20 09:54:04 orclex kernel: IRQ209 -> 0:21
Jun 20 09:54:04 orclex kernel: IRQ185 -> 0:23
Jun 20 09:54:04 orclex kernel: .................................... done.
Jun 20 09:54:04 orclex kernel: TC classifier action (bugs to netdev@vger.kernel.org cc hadi@cyberus.ca)
Jun 20 09:54:04 orclex kernel: pnp: 00:07: ioport range 0x290-0x297 has been reserved
Jun 20 09:54:04 orclex kernel: pnp: 00:09: ioport range 0x3f6-0x3f6 has been reserved
Jun 20 09:54:04 orclex kernel: IA-32 Microcode Update Driver: v1.14 <tigran@veritas.com>
Jun 20 09:54:04 orclex kernel: IA32 emulation $Id: sys_ia32.c,v 1.32 2002/03/24 13:02:28 ak Exp $
Jun 20 09:54:04 orclex kernel: NTFS driver 2.1.22 [Flags: R/O].
Jun 20 09:54:04 orclex kernel: Initializing Cryptographic API
Jun 20 09:54:04 orclex kernel: ACPI: PCI Interrupt 0000:00:01.0[A] -> GSI 16 (level, low) -> IRQ 169
Jun 20 09:54:04 orclex kernel: PCI: Setting latency timer of device 0000:00:01.0 to 64
Jun 20 09:54:04 orclex kernel: assign_interrupt_mode Found MSI capability
Jun 20 09:54:04 orclex kernel: Allocate Port Service[pcie00]
Jun 20 09:54:04 orclex kernel: Allocate Port Service[pcie03]
Jun 20 09:54:04 orclex kernel: ACPI: PCI Interrupt 0000:00:1c.0[A] -> GSI 16 (level, low) -> IRQ 169
Jun 20 09:54:04 orclex kernel: PCI: Setting latency timer of device 0000:00:1c.0 to 64
Jun 20 09:54:04 orclex kernel: assign_interrupt_mode Found MSI capability
Jun 20 09:54:04 orclex kernel: Allocate Port Service[pcie00]
Jun 20 09:54:04 orclex kernel: Allocate Port Service[pcie02]
Jun 20 09:54:04 orclex kernel: Allocate Port Service[pcie03]
Jun 20 09:54:04 orclex kernel: ACPI: PCI Interrupt 0000:00:1c.1[B] -> GSI 17 (level, low) -> IRQ 177
Jun 20 09:54:04 orclex kernel: PCI: Setting latency timer of device 0000:00:1c.1 to 64
Jun 20 09:54:04 orclex kernel: assign_interrupt_mode Found MSI capability
Jun 20 09:54:04 orclex kernel: Allocate Port Service[pcie00]
Jun 20 09:54:04 orclex kernel: Allocate Port Service[pcie02]
Jun 20 09:54:04 orclex kernel: Allocate Port Service[pcie03]
Jun 20 09:54:04 orclex kernel: vesafb: framebuffer at 0xd8000000, mapped to 0xffffc20010100000, using 6144k, total 131072k
Jun 20 09:54:04 orclex kernel: vesafb: mode is 1024x768x32, linelength=4096, pages=1
Jun 20 09:54:04 orclex kernel: vesafb: scrolling: redraw
Jun 20 09:54:04 orclex kernel: vesafb: Truecolor: size=8:8:8:8, shift=24:16:8:0
Jun 20 09:54:04 orclex kernel: Console: switching to colour frame buffer device 128x48
Jun 20 09:54:04 orclex kernel: fb0: VESA VGA frame buffer device
Jun 20 09:54:04 orclex kernel: vga16fb: initializing
Jun 20 09:54:04 orclex kernel: vga16fb: mapped to 0xffff8100000a0000
Jun 20 09:54:04 orclex kernel: fb1: VGA16 VGA frame buffer device
Jun 20 09:54:04 orclex kernel: ACPI: Power Button (FF) [PWRF]
Jun 20 09:54:04 orclex kernel: ACPI: Processor [CPU1] (supports 8 throttling states)
Jun 20 09:54:04 orclex kernel: Real Time Clock Driver v1.12
Jun 20 09:54:04 orclex kernel: Linux agpgart interface v0.101 (c) Dave Jones
Jun 20 09:54:04 orclex kernel: [drm] Initialized drm 1.0.0 20040925
Jun 20 09:54:04 orclex kernel: Hangcheck: starting hangcheck timer 0.9.0 (tick is 180 seconds, margin is 60 seconds).
Jun 20 09:54:04 orclex kernel: Hangcheck: Using monotonic_clock().
Jun 20 09:54:04 orclex kernel: PNP: PS/2 controller doesn't have AUX irq; using default 0xc
Jun 20 09:54:04 orclex kernel: PNP: PS/2 Controller [PNP0303:PS2K] at 0x60,0x64 irq 112
Jun 20 09:54:04 orclex kernel: serio: i8042 AUX port at 0x60,0x64 irq 12
Jun 20 09:54:04 orclex kernel: serio: i8042 KBD port at 0x60,0x64 irq 1
Jun 20 09:54:04 orclex kernel: io scheduler noop registered
Jun 20 09:54:04 orclex kernel: io scheduler anticipatory registered
Jun 20 09:54:04 orclex kernel: io scheduler deadline registered
Jun 20 09:54:04 orclex kernel: io scheduler cfq registered
Jun 20 09:54:04 orclex kernel: Floppy drive(s): fd0 is 1.44M
Jun 20 09:54:04 orclex kernel: FDC 0 is a post-1991 82077
Jun 20 09:54:04 orclex kernel: RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
Jun 20 09:54:04 orclex kernel: loop: loaded (max 8 devices)
Jun 20 09:54:04 orclex kernel: pktcdvd: v0.2.0a 2004-07-14 Jens Axboe (axboe@suse.de) and petero2@telia.com
Jun 20 09:54:04 orclex kernel: ACPI: PCI Interrupt 0000:01:06.0[A] -> GSI 16 (level, low) -> IRQ 169
Jun 20 09:54:04 orclex kernel: skge addr 0xcfefc000 irq 169 chip Yukon-Lite rev 7
Jun 20 09:54:04 orclex kernel: skge eth0: addr 00:11:2f:1c:f0:91
Jun 20 09:54:04 orclex kernel: PPP generic driver version 2.4.2
Jun 20 09:54:04 orclex kernel: PPP Deflate Compression module registered
Jun 20 09:54:04 orclex kernel: NET: Registered protocol family 24
Jun 20 09:54:04 orclex kernel: dmfe: Davicom DM9xxx net driver, version 1.36.4 (2002-01-17)
Jun 20 09:54:04 orclex kernel: Linux video capture interface: v1.00
Jun 20 09:54:04 orclex kernel: bttv: driver version 0.9.15 loaded
Jun 20 09:54:04 orclex kernel: bttv: using 8 buffers with 2080k (520 pages) each for capture
Jun 20 09:54:04 orclex kernel: bttv: Bt8xx card found (0).
Jun 20 09:54:04 orclex kernel: ACPI: PCI Interrupt 0000:01:09.0[A] -> GSI 17 (level, low) -> IRQ 177
Jun 20 09:54:04 orclex kernel: bttv0: Bt878 (rev 2) at 0000:01:09.0, irq: 177, latency: 64, mmio: 0xd7ffe000
Jun 20 09:54:04 orclex kernel: bttv0: detected: Hauppauge WinTV [card=10], PCI subsystem ID is 0070:13eb
Jun 20 09:54:04 orclex kernel: bttv0: using: Hauppauge (bt878) [card=10,autodetected]
Jun 20 09:54:04 orclex kernel: bttv0: gpio: en=00000000, out=00000000 in=00ffffdb [init]
Jun 20 09:54:04 orclex kernel: bttv0: Hauppauge/Voodoo msp34xx: reset line init [5]
Jun 20 09:54:04 orclex kernel: tveeprom: Hauppauge: model = 61334, rev = B   , serial# = 3026517
Jun 20 09:54:04 orclex kernel: tveeprom: tuner = Philips FM1216 (idx = 21, type = 5)
Jun 20 09:54:04 orclex kernel: tveeprom: tuner fmt = PAL(B/G) (eeprom = 0x04, v4l2 = 0x00000007)
Jun 20 09:54:04 orclex kernel: tveeprom: audio_processor = MSP3415 (type = 6)
Jun 20 09:54:04 orclex kernel: bttv0: using tuner=5
Jun 20 09:54:04 orclex kernel: bttv0: registered device video0
Jun 20 09:54:04 orclex kernel: bttv0: registered device vbi0
Jun 20 09:54:04 orclex kernel: bttv0: registered device radio0
Jun 20 09:54:04 orclex kernel: bttv0: PLL: 28636363 => 35468950 .. ok
Jun 20 09:54:04 orclex kernel: msp34xx: init: chip=MSP3410D-B4 +nicam +simple mode=simple
Jun 20 09:54:04 orclex kernel: msp3410: daemon started
Jun 20 09:54:04 orclex kernel: tvaudio: TV audio decoder + audio/video mux driver
Jun 20 09:54:04 orclex kernel: tvaudio: known chips: tda9840,tda9873h,tda9874h/a,tda9850,tda9855,tea6300,tea6320,tea6420,tda8425,pic16c54 (PV951),ta8874z
Jun 20 09:54:04 orclex kernel: SAA5246A (or compatible) Teletext decoder driver version 1.8
Jun 20 09:54:04 orclex kernel: SAA5249 driver (SAA5249 interface) for VideoText version 1.8
Jun 20 09:54:04 orclex kernel: tuner 0-0061: chip found @ 0xc2 (bt878 #0 [sw])
Jun 20 09:54:04 orclex kernel: tuner 0-0061: type set to 5 (Philips PAL_BG (FI1216 and compatibles))
Jun 20 09:54:04 orclex kernel: Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
Jun 20 09:54:04 orclex kernel: ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
Jun 20 09:54:04 orclex kernel: ICH6: IDE controller at PCI slot 0000:00:1f.1
Jun 20 09:54:04 orclex kernel: ACPI: PCI Interrupt 0000:00:1f.1[A] -> GSI 18 (level, low) -> IRQ 201
Jun 20 09:54:04 orclex kernel: ICH6: chipset revision 3
Jun 20 09:54:04 orclex kernel: ICH6: 100% native mode on irq 201
Jun 20 09:54:04 orclex kernel: ide0: BM-DMA at 0x5800-0x5807, BIOS settings: hda:DMA, hdb:pio
Jun 20 09:54:04 orclex kernel: ide1: BM-DMA at 0x5808-0x580f, BIOS settings: hdc:pio, hdd:pio
Jun 20 09:54:04 orclex kernel: Probing IDE interface ide0...
Jun 20 09:54:04 orclex kernel: hda: IC35L060AVV207-0, ATA DISK drive
Jun 20 09:54:04 orclex kernel: ide0 at 0x7000-0x7007,0x6802 on irq 201
Jun 20 09:54:04 orclex kernel: Probing IDE interface ide1...
Jun 20 09:54:04 orclex kernel: Probing IDE interface ide1...
Jun 20 09:54:04 orclex kernel: Probing IDE interface ide2...
Jun 20 09:54:04 orclex kernel: Probing IDE interface ide3...
Jun 20 09:54:04 orclex kernel: Probing IDE interface ide4...
Jun 20 09:54:04 orclex kernel: Probing IDE interface ide5...
Jun 20 09:54:04 orclex kernel: hda: max request size: 1024KiB
Jun 20 09:54:04 orclex kernel: hda: 120103200 sectors (61492 MB) w/1821KiB Cache, CHS=16383/255/63, UDMA(100)
Jun 20 09:54:04 orclex kernel: hda: cache flushes supported
Jun 20 09:54:04 orclex kernel: hda: hda1 hda2
Jun 20 09:54:04 orclex kernel: ACPI: PCI Interrupt 0000:01:04.0[A] -> GSI 23 (level, low) -> IRQ 185
Jun 20 09:54:04 orclex kernel: Found Controller: IT8212 UDMA/ATA133 RAID Controller
Jun 20 09:54:04 orclex kernel: irq 201: nobody cared!
Jun 20 09:54:04 orclex kernel: 
Jun 20 09:54:04 orclex kernel: Call Trace: <IRQ> <ffffffff801540b0>{__report_bad_irq+48} <ffffffff80154174>{note_interrupt+91}
Jun 20 09:54:04 orclex kernel: <ffffffff80153b2c>{__do_IRQ+234} <ffffffff8011049d>{do_IRQ+67}
Jun 20 09:54:04 orclex kernel: <ffffffff8010dded>{ret_from_intr+0}  <EOI> <ffffffff8010df1d>{retint_kernel+38}
Jun 20 09:54:04 orclex kernel: <ffffffff8010bb2c>{mwait_idle+94} <ffffffff8010bab0>{cpu_idle+71}
Jun 20 09:54:04 orclex kernel: <ffffffff80680876>{start_kernel+445} <ffffffff8068022c>{x86_64_start_kernel+320}
Jun 20 09:54:04 orclex kernel: 
Jun 20 09:54:04 orclex kernel: handlers:
Jun 20 09:54:04 orclex kernel: [<ffffffff8030f8b1>] (ide_intr+0x0/0x17a)
Jun 20 09:54:04 orclex kernel: Disabling IRQ #201
Jun 20 09:54:04 orclex kernel: iteraid_find_device: channel 0 device 1 is ATAPI.
Jun 20 09:54:04 orclex kernel: Channel[0] BM-DMA at 0x9800-0x9807
Jun 20 09:54:04 orclex kernel: IssueIdentify: resetting channel.
Jun 20 09:54:04 orclex kernel: IssueIdentify(IDE): disk[0] not ready. status=0x20
Jun 20 09:54:04 orclex kernel: FindDevices: device 2 is not present
Jun 20 09:54:04 orclex kernel: iteraid_find_device: channel 1 device 1 is ATAPI.
Jun 20 09:54:04 orclex kernel: Channel[1] BM-DMA at 0x9808-0x980F
Jun 20 09:54:04 orclex kernel: scsi0 : ITE RAIDExpress133
Jun 20 09:54:04 orclex kernel: Losing some ticks... checking if CPU frequency changed.
Jun 20 09:54:04 orclex kernel: Vendor: SONY      Model: CD-RW  CRX210E1   Rev: 2YS1
Jun 20 09:54:04 orclex kernel: Type:   CD-ROM                             ANSI SCSI revision: 02
Jun 20 09:54:04 orclex kernel: AtapiInterrupt: 23 words requested; 24 words xferred
Jun 20 09:54:04 orclex kernel: AtapiInterrupt error
Jun 20 09:54:04 orclex kernel: MapError: error register is b0
Jun 20 09:54:04 orclex kernel: ATAPI: command Aborted
Jun 20 09:54:04 orclex kernel: AtapiInterrupt: 32 words requested; 9 words xferred
Jun 20 09:54:04 orclex kernel: AtapiResetController enter
Jun 20 09:54:04 orclex kernel: IT8212ResetAdapter: perform ATAPI soft reset (0, 1)
Jun 20 09:54:04 orclex kernel: IT8212ResetAdapter: perform ATAPI soft reset (1, 1)
Jun 20 09:54:04 orclex kernel: IT8212ResetAdapter Success!
Jun 20 09:54:04 orclex kernel: AtapiResetController exit
Jun 20 09:54:04 orclex kernel: AtapiResetController enter
Jun 20 09:54:04 orclex kernel: IT8212ResetAdapter: perform ATAPI soft reset (0, 1)
Jun 20 09:54:04 orclex kernel: IT8212ResetAdapter: perform ATAPI soft reset (1, 1)
Jun 20 09:54:04 orclex kernel: IT8212ResetAdapter Success!
Jun 20 09:54:04 orclex kernel: AtapiResetController exit
Jun 20 09:54:04 orclex kernel: AtapiInterrupt error
Jun 20 09:54:04 orclex kernel: MapError: error register is 60
Jun 20 09:54:04 orclex kernel: ATAPI: unit attention
Jun 20 09:54:04 orclex kernel: scsi: Device offlined - not ready after error recovery: host 0 channel 0 id 3 lun 0
Jun 20 09:54:04 orclex kernel: scsi scan: 47 byte inquiry failed.  Consider BLIST_INQUIRY_36 for this device
Jun 20 09:54:04 orclex kernel: scsi0 (3:0): rejecting I/O to offline device
Jun 20 09:54:04 orclex kernel: libata version 1.11 loaded.
Jun 20 09:54:04 orclex kernel: ahci version 1.01
Jun 20 09:54:04 orclex kernel: ACPI: PCI Interrupt 0000:00:1f.2[B] -> GSI 19 (level, low) -> IRQ 193
Jun 20 09:54:04 orclex kernel: PCI: Setting latency timer of device 0000:00:1f.2 to 64
Jun 20 09:54:04 orclex kernel: ahci(0000:00:1f.2) AHCI 0001.0000 32 slots 4 ports 1.5 Gbps 0xf impl IDE mode
Jun 20 09:54:04 orclex kernel: ahci(0000:00:1f.2) flags: 64bit ncq pm led slum part 
Jun 20 09:54:04 orclex kernel: ata1: SATA max UDMA/133 cmd 0xFFFFC20000026D00 ctl 0x0 bmdma 0x0 irq 193
Jun 20 09:54:04 orclex kernel: ata2: SATA max UDMA/133 cmd 0xFFFFC20000026D80 ctl 0x0 bmdma 0x0 irq 193
Jun 20 09:54:04 orclex kernel: ata3: SATA max UDMA/133 cmd 0xFFFFC20000026E00 ctl 0x0 bmdma 0x0 irq 193
Jun 20 09:54:04 orclex kernel: ata4: SATA max UDMA/133 cmd 0xFFFFC20000026E80 ctl 0x0 bmdma 0x0 irq 193
Jun 20 09:54:04 orclex kernel: ata1: dev 0 cfg 49:2f00 82:346b 83:7d01 84:4023 85:3469 86:3c01 87:4023 88:207f
Jun 20 09:54:04 orclex kernel: ata1: dev 0 ATA, max UDMA/133, 488397168 sectors: lba48
Jun 20 09:54:04 orclex kernel: ata1: dev 0 configured for UDMA/133
Jun 20 09:54:04 orclex kernel: scsi1 : ahci
Jun 20 09:54:04 orclex kernel: ata2: no device found (phy stat 00000000)
Jun 20 09:54:04 orclex kernel: scsi2 : ahci
Jun 20 09:54:04 orclex kernel: ata3: no device found (phy stat 00000000)
Jun 20 09:54:04 orclex kernel: scsi3 : ahci
Jun 20 09:54:04 orclex kernel: ata4: no device found (phy stat 00000000)
Jun 20 09:54:04 orclex kernel: scsi4 : ahci
Jun 20 09:54:04 orclex kernel: Vendor: ATA       Model: ST3250823AS       Rev: 3.02
Jun 20 09:54:04 orclex kernel: Type:   Direct-Access                      ANSI SCSI revision: 05
Jun 20 09:54:04 orclex kernel: SCSI device sda: 488397168 512-byte hdwr sectors (250059 MB)
Jun 20 09:54:04 orclex kernel: SCSI device sda: drive cache: write back
Jun 20 09:54:04 orclex kernel: SCSI device sda: 488397168 512-byte hdwr sectors (250059 MB)
Jun 20 09:54:04 orclex kernel: SCSI device sda: drive cache: write back
Jun 20 09:54:04 orclex kernel: sda: sda1 sda2 < sda5 > sda3
Jun 20 09:54:04 orclex kernel: Attached scsi disk sda at scsi1, channel 0, id 0, lun 0
Jun 20 09:54:04 orclex kernel: AtapiInterrupt error
Jun 20 09:54:04 orclex kernel: MapError: error register is 60
Jun 20 09:54:04 orclex kernel: ATAPI: unit attention
Jun 20 09:54:04 orclex kernel: AtapiInterrupt: 32 words requested; 9 words xferred
Jun 20 09:54:04 orclex kernel: AtapiResetController enter
Jun 20 09:54:04 orclex kernel: IT8212ResetAdapter: perform ATAPI soft reset (0, 1)
Jun 20 09:54:04 orclex kernel: IT8212ResetAdapter: perform ATAPI soft reset (1, 1)
Jun 20 09:54:04 orclex kernel: IT8212ResetAdapter Success!
Jun 20 09:54:04 orclex kernel: AtapiResetController exit
Jun 20 09:54:04 orclex kernel: AtapiResetController enter
Jun 20 09:54:04 orclex kernel: IT8212ResetAdapter: perform ATAPI soft reset (0, 1)
Jun 20 09:54:04 orclex kernel: IT8212ResetAdapter: perform ATAPI soft reset (1, 1)
Jun 20 09:54:04 orclex kernel: IT8212ResetAdapter Success!
Jun 20 09:54:04 orclex kernel: AtapiResetController exit
Jun 20 09:54:04 orclex kernel: AtapiInterrupt error
Jun 20 09:54:04 orclex kernel: MapError: error register is 60
Jun 20 09:54:04 orclex kernel: ATAPI: unit attention
Jun 20 09:54:04 orclex kernel: scsi: Device offlined - not ready after error recovery: host 0 channel 0 id 1 lun 0
Jun 20 09:54:04 orclex kernel: scsi0 (1:0): rejecting I/O to offline device
Jun 20 09:54:04 orclex kernel: scsi0 (1:0): rejecting I/O to offline device
Jun 20 09:54:04 orclex kernel: scsi0 (1:0): rejecting I/O to offline device
Jun 20 09:54:04 orclex kernel: scsi0 (1:0): rejecting I/O to offline device
Jun 20 09:54:04 orclex kernel: scsi0 (1:0): rejecting I/O to offline device
Jun 20 09:54:04 orclex kernel: sr0: scsi3-mmc drive: 0x/0x caddy
Jun 20 09:54:04 orclex kernel: Uniform CD-ROM driver Revision: 3.20
Jun 20 09:54:04 orclex kernel: Attached scsi CD-ROM sr0 at scsi0, channel 0, id 1, lun 0
Jun 20 09:54:04 orclex kernel: Attached scsi generic sg0 at scsi0, channel 0, id 1, lun 0,  type 5
Jun 20 09:54:04 orclex kernel: Attached scsi generic sg1 at scsi1, channel 0, id 0, lun 0,  type 0
Jun 20 09:54:04 orclex kernel: ohci1394: $Rev: 1250 $ Ben Collins <bcollins@debian.org>
Jun 20 09:54:04 orclex kernel: ACPI: PCI Interrupt 0000:01:03.0[A] -> GSI 21 (level, low) -> IRQ 209
Jun 20 09:54:04 orclex kernel: ohci1394: fw-host0: OHCI-1394 1.1 (PCI): IRQ=[209]  MMIO=[cfefb800-cfefbfff]  Max Packet=[4096]
Jun 20 09:54:04 orclex kernel: ieee1394: raw1394: /dev/raw1394 device initialized
Jun 20 09:54:04 orclex kernel: usbmon: debugs is not available
Jun 20 09:54:04 orclex kernel: ACPI: PCI Interrupt 0000:00:1d.7[A] -> GSI 23 (level, low) -> IRQ 185
Jun 20 09:54:04 orclex kernel: PCI: Setting latency timer of device 0000:00:1d.7 to 64
Jun 20 09:54:04 orclex kernel: ehci_hcd 0000:00:1d.7: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) USB2 EHCI Controller
Jun 20 09:54:04 orclex kernel: ehci_hcd 0000:00:1d.7: debug port 1
Jun 20 09:54:04 orclex kernel: ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus number 1
Jun 20 09:54:04 orclex kernel: ehci_hcd 0000:00:1d.7: irq 185, io mem 0xcfdff800
Jun 20 09:54:04 orclex kernel: PCI: cache line size of 128 is not supported by device 0000:00:1d.7
Jun 20 09:54:04 orclex kernel: ehci_hcd 0000:00:1d.7: USB 2.0 initialized, EHCI 1.00, driver 10 Dec 2004
Jun 20 09:54:04 orclex kernel: hub 1-0:1.0: USB hub found
Jun 20 09:54:04 orclex kernel: hub 1-0:1.0: 8 ports detected
Jun 20 09:54:04 orclex kernel: ohci_hcd: 2004 Nov 08 USB 1.1 'Open' Host Controller (OHCI) Driver (PCI)
Jun 20 09:54:04 orclex kernel: USB Universal Host Controller Interface driver v2.2
Jun 20 09:54:04 orclex kernel: ACPI: PCI Interrupt 0000:00:1d.0[A] -> GSI 23 (level, low) -> IRQ 185
Jun 20 09:54:04 orclex kernel: PCI: Setting latency timer of device 0000:00:1d.0 to 64
Jun 20 09:54:04 orclex kernel: uhci_hcd 0000:00:1d.0: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) USB UHCI #1
Jun 20 09:54:04 orclex kernel: uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 2
Jun 20 09:54:04 orclex kernel: uhci_hcd 0000:00:1d.0: irq 185, io base 0x00004400
Jun 20 09:54:04 orclex kernel: hub 2-0:1.0: USB hub found
Jun 20 09:54:04 orclex kernel: hub 2-0:1.0: 2 ports detected
Jun 20 09:54:04 orclex kernel: ACPI: PCI Interrupt 0000:00:1d.1[B] -> GSI 19 (level, low) -> IRQ 193
Jun 20 09:54:04 orclex kernel: PCI: Setting latency timer of device 0000:00:1d.1 to 64
Jun 20 09:54:04 orclex kernel: uhci_hcd 0000:00:1d.1: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) USB UHCI #2
Jun 20 09:54:04 orclex kernel: uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 3
Jun 20 09:54:04 orclex kernel: uhci_hcd 0000:00:1d.1: irq 193, io base 0x00004800
Jun 20 09:54:04 orclex kernel: hub 3-0:1.0: USB hub found
Jun 20 09:54:04 orclex kernel: hub 3-0:1.0: 2 ports detected
Jun 20 09:54:04 orclex kernel: ACPI: PCI Interrupt 0000:00:1d.2[C] -> GSI 18 (level, low) -> IRQ 201
Jun 20 09:54:04 orclex kernel: PCI: Setting latency timer of device 0000:00:1d.2 to 64
Jun 20 09:54:04 orclex kernel: uhci_hcd 0000:00:1d.2: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) USB UHCI #3
Jun 20 09:54:04 orclex kernel: uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus number 4
Jun 20 09:54:04 orclex kernel: uhci_hcd 0000:00:1d.2: irq 201, io base 0x00005000
Jun 20 09:54:04 orclex kernel: hub 4-0:1.0: USB hub found
Jun 20 09:54:04 orclex kernel: hub 4-0:1.0: 2 ports detected
Jun 20 09:54:04 orclex kernel: ACPI: PCI Interrupt 0000:00:1d.3[D] -> GSI 16 (level, low) -> IRQ 169
Jun 20 09:54:04 orclex kernel: PCI: Setting latency timer of device 0000:00:1d.3 to 64
Jun 20 09:54:04 orclex kernel: uhci_hcd 0000:00:1d.3: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) USB UHCI #4
Jun 20 09:54:04 orclex kernel: uhci_hcd 0000:00:1d.3: new USB bus registered, assigned bus number 5
Jun 20 09:54:04 orclex kernel: uhci_hcd 0000:00:1d.3: irq 169, io base 0x00005400
Jun 20 09:54:04 orclex kernel: hub 5-0:1.0: USB hub found
Jun 20 09:54:04 orclex kernel: hub 5-0:1.0: 2 ports detected
Jun 20 09:54:04 orclex kernel: Initializing USB Mass Storage driver...
Jun 20 09:54:04 orclex kernel: usbcore: registered new driver usb-storage
Jun 20 09:54:04 orclex kernel: USB Mass Storage support registered.
Jun 20 09:54:04 orclex kernel: usb 2-1: new low speed USB device using uhci_hcd and address 2
Jun 20 09:54:04 orclex kernel: usbcore: registered new driver hiddev
Jun 20 09:54:04 orclex kernel: usb 3-1: new low speed USB device using uhci_hcd and address 2
Jun 20 09:54:04 orclex kernel: input: USB HID v1.00 Joystick [Microsoft Microsoft SideWinder game controller] on usb-0000:00:1d.0-1
Jun 20 09:54:04 orclex kernel: input: USB HID v1.00 Mouse [Microsoft Microsoft Wheel Mouse Optical®] on usb-0000:00:1d.1-1
Jun 20 09:54:04 orclex kernel: usbcore: registered new driver usbhid
Jun 20 09:54:04 orclex kernel: drivers/usb/input/hid-core.c: v2.01:USB HID core driver
Jun 20 09:54:04 orclex kernel: mice: PS/2 mouse device common for all mice
Jun 20 09:54:04 orclex kernel: input: PC Speaker
Jun 20 09:54:04 orclex kernel: md: md driver 0.90.1 MAX_MD_DEVS=256, MD_SB_DISKS=27
Jun 20 09:54:04 orclex kernel: device-mapper: 4.4.0-ioctl (2005-01-12) initialised: dm-devel@redhat.com
Jun 20 09:54:04 orclex kernel: GACT probability on
Jun 20 09:54:04 orclex kernel: Mirror/redirect action on
Jun 20 09:54:04 orclex kernel: u32 classifier
Jun 20 09:54:04 orclex kernel: Perfomance counters on
Jun 20 09:54:04 orclex kernel: input device check on 
Jun 20 09:54:04 orclex kernel: Actions configured 
Jun 20 09:54:04 orclex kernel: NET: Registered protocol family 2
Jun 20 09:54:04 orclex kernel: IP: routing cache hash table of 4096 buckets, 64Kbytes
Jun 20 09:54:04 orclex kernel: TCP established hash table entries: 262144 (order: 10, 4194304 bytes)
Jun 20 09:54:04 orclex kernel: TCP bind hash table entries: 65536 (order: 8, 1048576 bytes)
Jun 20 09:54:04 orclex kernel: TCP: Hash tables configured (established 262144 bind 65536)
Jun 20 09:54:04 orclex kernel: IPv4 over IPv4 tunneling driver
Jun 20 09:54:04 orclex kernel: ip_conntrack version 2.1 (4094 buckets, 32752 max) - 304 bytes per conntrack
Jun 20 09:54:04 orclex kernel: input: AT Translated Set 2 keyboard on isa0060/serio0
Jun 20 09:54:04 orclex kernel: ip_tables: (C) 2000-2002 Netfilter core team
Jun 20 09:54:04 orclex kernel: ipt_recent v0.3.1: Stephen Frost <sfrost@snowman.net>.  http://snowman.net/projects/ipt_recent/
Jun 20 09:54:04 orclex kernel: Initializing IPsec netlink socket
Jun 20 09:54:04 orclex kernel: NET: Registered protocol family 1
Jun 20 09:54:04 orclex kernel: NET: Registered protocol family 17
Jun 20 09:54:04 orclex kernel: NET: Registered protocol family 15
Jun 20 09:54:04 orclex kernel: swsusp: Suspend partition has wrong signature?
Jun 20 09:54:04 orclex kernel: md: Autodetecting RAID arrays.
Jun 20 09:54:04 orclex kernel: md: autorun ...
Jun 20 09:54:04 orclex kernel: md: ... autorun DONE.
Jun 20 09:54:04 orclex kernel: kjournald starting.  Commit interval 5 seconds
Jun 20 09:54:04 orclex kernel: EXT3-fs: mounted filesystem with ordered data mode.
Jun 20 09:54:04 orclex kernel: VFS: Mounted root (ext3 filesystem) readonly.
Jun 20 09:54:04 orclex kernel: Freeing unused kernel memory: 228k freed
Jun 20 09:54:04 orclex kernel: ieee1394: Host added: ID:BUS[0-00:1023]  GUID[00e01800007ef52b]
Jun 20 09:54:04 orclex kernel: Adding 2658716k swap on /dev/sda5.  Priority:-1 extents:1
Jun 20 09:54:04 orclex kernel: EXT3 FS on sda3, internal journal
Jun 20 09:54:04 orclex kernel: ACPI: PCI Interrupt 0000:01:0a.0[A] -> GSI 21 (level, low) -> IRQ 209
Jun 20 09:54:04 orclex kernel: hda: dma_timer_expiry: dma status == 0x24
Jun 20 09:54:04 orclex kernel: hda: DMA interrupt recovery
Jun 20 09:54:04 orclex kernel: hda: lost interrupt
Jun 20 09:54:04 orclex kernel: kjournald starting.  Commit interval 5 seconds
Jun 20 09:54:04 orclex kernel: EXT3 FS on sda1, internal journal
Jun 20 09:54:04 orclex kernel: EXT3-fs: mounted filesystem with ordered data mode.
Jun 20 09:54:04 orclex kernel: ACPI: PCI Interrupt 0000:00:1b.0[A] -> GSI 16 (level, low) -> IRQ 169
Jun 20 09:54:04 orclex kernel: PCI: Setting latency timer of device 0000:00:1b.0 to 64
Jun 20 09:54:04 orclex kernel: ACPI: PCI Interrupt 0000:01:09.1[A] -> GSI 17 (level, low) -> IRQ 177
Jun 20 09:54:04 orclex kernel: parport: PnPBIOS parport detected.
Jun 20 09:54:04 orclex kernel: parport0: PC-style at 0x378 (0x778), irq 7, dma 3 [PCSPP,TRISTATE,COMPAT,EPP,ECP,DMA]
Jun 20 09:54:04 orclex kernel: Serial: 8250/16550 driver $Revision: 1.90 $ 8 ports, IRQ sharing disabled
Jun 20 09:54:04 orclex kernel: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
Jun 20 09:54:04 orclex kernel: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
Jun 20 09:54:04 orclex kernel: skge eth0: enabling interface
Jun 20 09:54:04 orclex kernel: skge eth0: Link is up at 100 Mbps, full duplex, flow control none
Jun 20 09:54:05 orclex cpufreqd: libsys_init() - no batteries found, not a laptop?
Jun 20 09:54:07 orclex kernel: lp0: using parport0 (interrupt-driven).
Jun 20 09:54:07 orclex udev[4338]: creating device node '/dev/lp0'
Jun 20 09:54:08 orclex kernel: scsi: unknown opcode 0x85
Jun 20 09:54:08 orclex lpd[4438]: restarted
Jun 20 09:54:08 orclex hddtemp[4429]: /dev/hda: IC35L060AVV207-0: 34 C
Jun 20 09:54:09 orclex /usr/sbin/gpm[4401]: Detected EXPS/2 protocol mouse.
Jun 20 09:54:09 orclex nmbd[4448]: [2005/06/20 09:54:09, 0, pid=4448] nmbd/asyncdns.c:start_async_dns(149)
Jun 20 09:54:09 orclex nmbd[4448]:   started asyncdns process 4449
Jun 20 09:54:09 orclex kernel: irq 201: nobody cared!
Jun 20 09:54:09 orclex kernel: 
Jun 20 09:54:09 orclex kernel: Call Trace: <IRQ> <ffffffff801540b0>{__report_bad_irq+48} <ffffffff80154174>{note_interrupt+91}
Jun 20 09:54:09 orclex kernel: <ffffffff80153b2c>{__do_IRQ+234} <ffffffff8011049d>{do_IRQ+67}
Jun 20 09:54:09 orclex kernel: <ffffffff8010dded>{ret_from_intr+0}  <EOI> <ffffffff8010d84a>{system_call+126}
Jun 20 09:54:09 orclex kernel: 
Jun 20 09:54:09 orclex kernel: handlers:
Jun 20 09:54:09 orclex kernel: [<ffffffff8030f8b1>] (ide_intr+0x0/0x17a)
Jun 20 09:54:09 orclex kernel: [<ffffffff8035a0b5>] (usb_hcd_irq+0x0/0x68)
Jun 20 09:54:09 orclex kernel: Disabling IRQ #201
Jun 20 09:54:10 orclex smartd[4455]: smartd version 5.32 Copyright (C) 2002-4 Bruce Allen
Jun 20 09:54:10 orclex smartd[4455]: Home page is http://smartmontools.sourceforge.net/
Jun 20 09:54:10 orclex smartd[4455]: Opened configuration file /etc/smartd.conf
Jun 20 09:54:10 orclex smartd[4455]: Drive: DEVICESCAN, implied '-a' Directive on line 23 of file /etc/smartd.conf
Jun 20 09:54:10 orclex smartd[4455]: Configuration file /etc/smartd.conf was parsed, found DEVICESCAN, scanning devices
Jun 20 09:54:10 orclex smartd[4455]: Device: /dev/hda, opened
Jun 20 09:54:20 orclex kernel: hda: lost interrupt
Jun 20 09:54:20 orclex smartd[4455]: Device: /dev/hda, found in smartd database.
Jun 20 09:54:21 orclex smartd[4455]: Device: /dev/hda, is SMART capable. Adding to "monitor" list.
Jun 20 09:54:21 orclex smartd[4455]: Device: /dev/sda, opened
Jun 20 09:54:21 orclex kernel: program smartd is using a deprecated SCSI ioctl, please convert it to SG_IO
Jun 20 09:54:21 orclex kernel: program smartd is using a deprecated SCSI ioctl, please convert it to SG_IO
Jun 20 09:54:21 orclex smartd[4455]: Device: /dev/sda, IE (SMART) not enabled, skip device Try 'smartctl -s on /dev/sda' to turn on SMART features
Jun 20 09:54:21 orclex smartd[4455]: Unable to register SCSI device /dev/sda at line 23 of file /etc/smartd.conf
Jun 20 09:54:21 orclex smartd[4455]: Monitoring 1 ATA and 0 SCSI devices
Jun 20 09:54:21 orclex kernel: irq 201: nobody cared!
Jun 20 09:54:21 orclex kernel: 
Jun 20 09:54:21 orclex kernel: Call Trace: <IRQ> <ffffffff801540b0>{__report_bad_irq+48} <ffffffff80154174>{note_interrupt+91}
Jun 20 09:54:21 orclex kernel: <ffffffff80153b2c>{__do_IRQ+234} <ffffffff8011049d>{do_IRQ+67}
Jun 20 09:54:21 orclex kernel: <ffffffff8010dded>{ret_from_intr+0}  <EOI> <ffffffff8010df1d>{retint_kernel+38}
Jun 20 09:54:21 orclex kernel: <ffffffff8010bb2c>{mwait_idle+94} <ffffffff8010bab0>{cpu_idle+71}
Jun 20 09:54:21 orclex kernel: <ffffffff80680876>{start_kernel+445} <ffffffff8068022c>{x86_64_start_kernel+320}
Jun 20 09:54:21 orclex kernel: 
Jun 20 09:54:21 orclex kernel: handlers:
Jun 20 09:54:21 orclex kernel: [<ffffffff8030f8b1>] (ide_intr+0x0/0x17a)
Jun 20 09:54:21 orclex kernel: [<ffffffff8035a0b5>] (usb_hcd_irq+0x0/0x68)
Jun 20 09:54:21 orclex kernel: Disabling IRQ #201
Jun 20 09:54:31 orclex kernel: hda: lost interrupt
Jun 20 09:54:31 orclex smartd[4458]: smartd has fork()ed into background mode. New PID=4458.
Jun 20 09:54:31 orclex smartd[4458]: file /var/run/smartd.pid written containing PID 4458
Jun 20 09:54:32 orclex kernel: irq 201: nobody cared!
Jun 20 09:54:32 orclex kernel: 
Jun 20 09:54:32 orclex kernel: Call Trace: <IRQ> <ffffffff801540b0>{__report_bad_irq+48} <ffffffff80154174>{note_interrupt+91}
Jun 20 09:54:32 orclex kernel: <ffffffff80153b2c>{__do_IRQ+234} <ffffffff8011049d>{do_IRQ+67}
Jun 20 09:54:32 orclex kernel: <ffffffff8010dded>{ret_from_intr+0}  <EOI> <ffffffff8010df1d>{retint_kernel+38}
Jun 20 09:54:32 orclex kernel: <ffffffff8010bb2c>{mwait_idle+94} <ffffffff8010bab0>{cpu_idle+71}
Jun 20 09:54:32 orclex kernel: <ffffffff80680876>{start_kernel+445} <ffffffff8068022c>{x86_64_start_kernel+320}
Jun 20 09:54:32 orclex kernel: 
Jun 20 09:54:32 orclex kernel: handlers:
Jun 20 09:54:32 orclex kernel: [<ffffffff8030f8b1>] (ide_intr+0x0/0x17a)
Jun 20 09:54:32 orclex kernel: [<ffffffff8035a0b5>] (usb_hcd_irq+0x0/0x68)
Jun 20 09:54:32 orclex kernel: Disabling IRQ #201
Jun 20 09:54:33 orclex rpc.statd[4575]: Version 1.0.7 Starting
Jun 20 09:54:33 orclex rpc.statd[4575]: statd running as root. chown /var/lib/nfs/sm to choose different user
Jun 20 09:54:33 orclex Xprt_64: No matching visual for __GLcontextMode with visual class = 0 (32775), nplanes = 8
Jun 20 09:54:33 orclex anacron[4584]: Anacron 2.3 started on 2005-06-20
Jun 20 09:54:33 orclex anacron[4584]: Will run job `cron.weekly' in 10 min.
Jun 20 09:54:33 orclex anacron[4584]: Jobs will be executed sequentially
Jun 20 09:54:33 orclex /usr/sbin/cron[4589]: (CRON) INFO (pidfile fd = 3)
Jun 20 09:54:33 orclex /usr/sbin/cron[4590]: (CRON) STARTUP (fork ok)
Jun 20 09:54:34 orclex /usr/sbin/cron[4590]: (CRON) INFO (Running @reboot jobs)
Jun 20 09:54:35 orclex udev[4610]: creating device node '/dev/vcs2'
Jun 20 09:54:35 orclex udev[4612]: creating device node '/dev/vcsa2'
Jun 20 09:54:35 orclex udev[4624]: creating device node '/dev/vcs3'
Jun 20 09:54:35 orclex udev[4629]: creating device node '/dev/vcsa3'
Jun 20 09:54:35 orclex udev[4639]: creating device node '/dev/vcs4'
Jun 20 09:54:35 orclex udev[4640]: creating device node '/dev/vcsa4'
Jun 20 09:54:36 orclex udev[4642]: creating device node '/dev/vcs5'
Jun 20 09:54:36 orclex udev[4650]: creating device node '/dev/vcsa5'
Jun 20 09:54:36 orclex udev[4671]: creating device node '/dev/vcs7'
Jun 20 09:54:36 orclex udev[4669]: creating device node '/dev/vcs6'
Jun 20 09:54:36 orclex udev[4670]: creating device node '/dev/vcsa6'
Jun 20 09:54:36 orclex udev[4700]: creating device node '/dev/vcsa7'
Jun 20 09:54:36 orclex udev[4722]: removing device node '/dev/vcsa4'
Jun 20 09:54:36 orclex udev[4723]: removing device node '/dev/vcsa3'
Jun 20 09:54:36 orclex udev[4726]: removing device node '/dev/vcs3'
Jun 20 09:54:36 orclex udev[4752]: removing device node '/dev/vcsa5'
Jun 20 09:54:36 orclex udev[4745]: removing device node '/dev/vcsa6'
Jun 20 09:54:36 orclex udev[4746]: removing device node '/dev/vcs2'
Jun 20 09:54:36 orclex udev[4747]: removing device node '/dev/vcsa2'
Jun 20 09:54:36 orclex udev[4748]: removing device node '/dev/vcs4'
Jun 20 09:54:36 orclex udev[4765]: removing device node '/dev/vcs5'
Jun 20 09:54:36 orclex udev[4791]: removing device node '/dev/vcs6'
Jun 20 09:54:36 orclex udev[4817]: removing device node '/dev/vcs7'
Jun 20 09:54:36 orclex udev[4818]: removing device node '/dev/vcsa7'
Jun 20 09:54:36 orclex udev[4841]: creating device node '/dev/vcs7'
Jun 20 09:54:36 orclex udev[4842]: creating device node '/dev/vcsa7'
Jun 20 09:54:36 orclex udev[4859]: creating device node '/dev/vcsa2'
Jun 20 09:54:36 orclex udev[4863]: creating device node '/dev/vcsa3'
Jun 20 09:54:36 orclex udev[4861]: creating device node '/dev/vcs3'
Jun 20 09:54:36 orclex udev[4858]: creating device node '/dev/vcs2'
Jun 20 09:54:36 orclex udev[4874]: creating device node '/dev/vcs5'
Jun 20 09:54:36 orclex udev[4875]: creating device node '/dev/vcsa4'
Jun 20 09:54:36 orclex udev[4892]: creating device node '/dev/vcsa5'
Jun 20 09:54:36 orclex udev[4893]: creating device node '/dev/vcs6'
Jun 20 09:54:36 orclex udev[4894]: creating device node '/dev/vcsa6'
Jun 20 09:54:36 orclex udev[4870]: creating device node '/dev/vcs4'
Jun 20 09:54:37 orclex udev[4951]: removing device node '/dev/vcs7'
Jun 20 09:54:37 orclex udev[4952]: removing device node '/dev/vcsa7'
Jun 20 09:54:37 orclex gdm[4608]: gdm_slave_xioerror_handler: Schwerwiegender X-Fehler - :0 wird neu gestartet
Jun 20 09:54:40 orclex udev[4969]: creating device node '/dev/vcs7'
Jun 20 09:54:40 orclex udev[4987]: removing device node '/dev/vcs7'
Jun 20 09:54:40 orclex udev[5005]: creating device node '/dev/vcsa7'
Jun 20 09:54:40 orclex udev[5013]: creating device node '/dev/vcs7'
Jun 20 09:54:42 orclex udev[5025]: removing device node '/dev/vcs7'
Jun 20 09:54:42 orclex gdm[4967]: gdm_slave_xioerror_handler: Schwerwiegender X-Fehler - :0 wird neu gestartet
Jun 20 09:54:42 orclex udev[5027]: removing device node '/dev/vcsa7'
Jun 20 09:54:45 orclex udev[5044]: creating device node '/dev/vcs7'
Jun 20 09:54:45 orclex udev[5072]: creating device node '/dev/vcsa7'
Jun 20 09:54:45 orclex udev[5080]: removing device node '/dev/vcs7'
Jun 20 09:54:45 orclex udev[5088]: creating device node '/dev/vcs7'
Jun 20 09:54:46 orclex udev[5101]: removing device node '/dev/vcs7'
Jun 20 09:54:46 orclex udev[5102]: removing device node '/dev/vcsa7'
Jun 20 09:54:46 orclex gdm[5035]: gdm_slave_xioerror_handler: Schwerwiegender X-Fehler - :0 wird neu gestartet
Jun 20 09:54:46 orclex gdm[4607]: deal_with_x_crashes: Das Skript XKeepsCrashing wird gestartet
Jun 20 09:54:46 orclex udev[5137]: creating device node '/dev/vcs7'
Jun 20 09:54:46 orclex udev[5138]: creating device node '/dev/vcsa7'
Jun 20 09:54:47 orclex udev[5175]: removing device node '/dev/vcs7'
Jun 20 09:54:47 orclex udev[5176]: removing device node '/dev/vcsa7'
Jun 20 09:54:47 orclex gdm[4607]: X-Server konnte nicht in kurzen Zeitabständen gestartet werden; Anzeige :0 wird deaktiviert

--------------090006040700090304050104--
