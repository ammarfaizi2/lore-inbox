Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264238AbUBKLv4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Feb 2004 06:51:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264267AbUBKLvz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Feb 2004 06:51:55 -0500
Received: from shark.pro-futura.com ([161.58.178.219]:188 "EHLO
	shark.pro-futura.com") by vger.kernel.org with ESMTP
	id S264141AbUBKLvH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Feb 2004 06:51:07 -0500
From: "Tvrtko A. =?iso-8859-2?q?Ur=B9ulin?=" <tvrtko@croadria.com>
Organization: Croadria Internet usluge
To: linux-kernel@vger.kernel.org, grsecurity@grsecurity.net,
       linux-net@vger.kernel.org
Subject: tg3 doesn't work (strange)
Date: Wed, 11 Feb 2004 12:52:41 +0100
User-Agent: KMail/1.6
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_JehKATNpOWbQHug"
Message-Id: <200402111252.41663.tvrtko@croadria.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_JehKATNpOWbQHug
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


Hello all,

On my HP tc2120 server onboard Broadcom NIC doesn't work under vanilla 2.4.24 
kernel. But it works under 2.4.24-grsec. Strange... read on...

xen:~ # lspci
00:00.0 Host bridge: ServerWorks GCNB-LE Host Bridge (rev 32)
00:00.1 Host bridge: ServerWorks GCNB-LE Host Bridge
00:03.0 Ethernet controller: Broadcom Corporation NetXtreme BCM5702 Gigabit 
Ethernet (rev 02)
00:04.0 SCSI storage controller: Adaptec AIC-7892A U160/m (rev 02)
00:06.0 Ethernet controller: 3Com Corporation 3c905C-TX/TX-M [Tornado] (rev 
78)
00:09.0 VGA compatible controller: ATI Technologies Inc Rage XL (rev 27)
00:0f.0 ISA bridge: ServerWorks CSB6 South Bridge (rev a0)
00:0f.1 IDE interface: ServerWorks CSB6 RAID/IDE Controller (rev a0)
00:0f.2 USB Controller: ServerWorks CSB6 OHCI USB Controller (rev 05)
00:0f.3 Host bridge: ServerWorks GCLE-2 Host Bridge

2.4.24:

tg3.c:v2.3 (November 5, 2003)
tg3: Could not obtain valid ethernet address, aborting.

2.4.24-grsec:

tg3.c:v2.3 (November 5, 2003)
eth0: Tigon3 [partno(BCM95702A20) rev 1002 PHY(5703)] (PCI:33MHz:32-bit) 
10/100/1000BaseT Ethernet 00:08:02:f7:c1:fa
tg3: eth0: Link is up at 100 Mbps, full duplex.
tg3: eth0: Flow control is off for TX and off for RX.



Complete kernel boot logs differ only in memory usage and CPU speed detection. 
Complete logs are attached.


--Boundary-00=_JehKATNpOWbQHug
Content-Type: text/x-log;
  charset="iso-8859-2";
  name="2.4.24.log"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="2.4.24.log"

xen:~ # cat /var/log/boot.msg
Inspecting /boot/System.map-2.4.24
Loaded 18092 symbols from /boot/System.map-2.4.24.
Symbols match kernel version 2.4.24.
No module symbols loaded.
klogd 1.4.1, log source = ksyslog started.
 version 17, address 0xfec02000, IRQ 32-47
<6>ACPI: INT_SRC_OVR (bus[0] irq[0x0] global_irq[0x2] polarity[0x0] trigger[0x1])
<6>ACPI: INT_SRC_OVR (bus[0] irq[0x9] global_irq[0x9] polarity[0x3] trigger[0x3])
<4>ACPI BALANCE SET
<6>Using ACPI (MADT) for SMP configuration information
<4>Kernel command line: root=/dev/sda3
<6>Initializing CPU#0
<4>Detected 2665.999 MHz processor.
<4>Console: colour VGA+ 80x25
<4>Calibrating delay loop... 5321.52 BogoMIPS
<6>Memory: 1033492k/1048556k available (1462k kernel code, 14676k reserved, 490k data, 104k init, 131052k highmem)
<6>Dentry cache hash table entries: 131072 (order: 8, 1048576 bytes)
<6>Inode cache hash table entries: 65536 (order: 7, 524288 bytes)
<6>Mount cache hash table entries: 512 (order: 0, 4096 bytes)
<6>Buffer cache hash table entries: 65536 (order: 6, 262144 bytes)
<4>Page-cache hash table entries: 262144 (order: 8, 1048576 bytes)
<6>CPU: Trace cache: 12K uops, L1 D cache: 8K
<6>CPU: L2 cache: 512K
<6>Intel machine check architecture supported.
<6>Intel machine check reporting enabled on CPU#0.
<7>CPU:     After generic, caps: bfebfbff 00000000 00000000 00000000
<7>CPU:             Common caps: bfebfbff 00000000 00000000 00000000
<4>CPU: Intel(R) Pentium(R) 4 CPU 2.66GHz stepping 09
<6>Enabling fast FPU save and restore... done.
<6>Enabling unmasked SIMD FPU exception support... done.
<6>Checking 'hlt' instruction... OK.
<4>POSIX conformance testing by UNIFIX
<4>enabled ExtINT on CPU#0
<4>ESR value before enabling vector: 00000000
<4>ESR value after enabling vector: 00000000
<4>ENABLING IO-APIC IRQs
<7>init IO_APIC IRQs
<7> IO-APIC (apicid-pin) 2-0, 3-0, 3-1, 3-2, 3-3, 3-4, 3-5, 3-6, 3-7, 3-8, 3-9, 3-10, 3-11, 3-12, 3-13, 3-14, 3-15, 4-0, 4-1, 4-2, 4-3, 4-4, 4-5, 4-6, 4-7, 4-8, 4-9, 4-10, 4-11, 4-12, 4-13, 4-14, 4-15 not connected.
<6>..TIMER: vector=0x31 pin1=2 pin2=-1
<3>..MP-BIOS bug: 8254 timer not connected to IO-APIC
<6>...trying to set up timer (IRQ0) through the 8259A ...  failed.
<6>...trying to set up timer as Virtual Wire IRQ... works.
<4>Using local APIC timer interrupts.
<4>calibrating APIC timer ...
<4>..... CPU clock speed is 2666.1897 MHz.
<4>..... host bus clock speed is 133.3092 MHz.
<4>cpu: 0, clocks: 1333092, slice: 666546
<4>CPU0<T0:1333088,T1:666528,D:14,S:666546,C:1333092>
<4>mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
<4>mtrr: detected mtrr type: Intel
<6>ACPI: Subsystem revision 20031002
<6>PCI: PCI BIOS revision 2.10 entry at 0xf17b0, last bus=0
<6>PCI: Using configuration type 1
<7>IOAPIC[0]: Set PCI routing entry (2-9 -> 0x71 -> IRQ 9 Mode:1 Active:1)
<6>ACPI: Interpreter enabled
<6>ACPI: Using IOAPIC for interrupt routing
<6>ACPI: System [ACPI] (supports S0 S1 S4 S5)
<4>ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 9 10 11 12 14 15)
<4>ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 9 10 11 12 14 15)
<4>ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 9 10 11 *12 14 15)
<4>ACPI: PCI Interrupt Link [LNKD] (IRQs *3 4 5 6 7 9 10 11 12 14 15)
<4>ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 7 9 10 11 12 14 15)
<4>ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 *5 6 7 9 10 11 12 14 15)
<4>ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 7 9 10 11 12 14 15)
<4>ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 6 7 9 10 11 12 14 15)
<4>ACPI: PCI Interrupt Link [LNKI] (IRQs 3 4 5 6 7 9 10 11 12 14 15)
<4>ACPI: PCI Interrupt Link [LNKJ] (IRQs 3 4 5 6 7 9 10 11 12 14 15)
<4>ACPI: PCI Interrupt Link [LNKK] (IRQs 3 4 5 6 7 9 10 11 12 14 15)
<4>ACPI: PCI Interrupt Link [LNKL] (IRQs 3 4 5 6 7 9 10 11 12 14 15)
<4>ACPI: PCI Interrupt Link [LNKM] (IRQs 3 4 5 6 7 9 10 11 12 14 15)
<4>ACPI: PCI Interrupt Link [LNKN] (IRQs 3 4 5 6 7 9 10 11 12 14 15)
<4>ACPI: PCI Interrupt Link [LNKO] (IRQs 3 4 5 6 7 9 10 11 12 14 15)
<4>ACPI: PCI Interrupt Link [LNKP] (IRQs 3 4 5 6 7 9 10 11 12 14 15)
<4>ACPI: PCI Interrupt Link [LNKQ] (IRQs 3 4 5 6 7 9 10 11 12 14 15)
<4>ACPI: PCI Interrupt Link [LNKR] (IRQs 3 4 5 6 7 9 10 11 12 14 15)
<4>ACPI: PCI Interrupt Link [LNKS] (IRQs 3 4 5 6 7 9 10 11 12 14 15)
<4>ACPI: PCI Interrupt Link [LNKT] (IRQs 3 4 5 6 7 9 10 11 12 14 15)
<4>ACPI: PCI Interrupt Link [LNKU] (IRQs 3 4 5 6 7 9 10 11 12 14 15)
<4>ACPI: PCI Interrupt Link [LNKV] (IRQs 3 4 5 6 7 9 10 11 12 14 15)
<4>ACPI: PCI Interrupt Link [LNKW] (IRQs 3 4 5 6 7 9 10 11 12 14 15)
<4>ACPI: PCI Interrupt Link [LNKX] (IRQs 3 4 5 6 7 9 10 11 12 14 15)
<4>ACPI: PCI Interrupt Link [LNKY] (IRQs 3 4 5 6 7 9 10 11 12 14 15)
<4>ACPI: PCI Interrupt Link [LNKZ] (IRQs 3 4 5 6 7 9 10 11 12 14 15)
<4>ACPI: PCI Interrupt Link [LNK0] (IRQs 3 4 5 6 7 9 10 11 12 14 15)
<4>ACPI: PCI Interrupt Link [LNK1] (IRQs 3 4 5 6 7 9 10 11 12 14 15)
<4>ACPI: PCI Interrupt Link [LNK2] (IRQs 3 4 5 6 7 9 10 11 12 14 15)
<4>ACPI: PCI Interrupt Link [LNK3] (IRQs 3 4 5 6 7 9 10 11 12 14 15)
<4>ACPI: PCI Interrupt Link [LNK4] (IRQs 11)
<4>ACPI: PCI Interrupt Link [LNK5] (IRQs 5 10 11 12 14 15)
<6>ACPI: PCI Root Bridge [PCI0] (00:00)
<4>PCI: Probing PCI hardware (bus 00)
<6>PCI: Ignoring BAR0-3 of IDE controller 00:0f.1
<7>ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
<6>ACPI: Power Resource [FDDP] (off)
<6>ACPI: Power Resource [LPTP] (off)
<6>ACPI: Power Resource [URP1] (off)
<6>ACPI: Power Resource [URP2] (off)
<6>PCI: Probing PCI hardware
<4>_CRS returns NULL! Using IRQ 10 fordevice (PCI Interrupt Link [LNK5]).
<4>ACPI: PCI Interrupt Link [LNK5] enabled at IRQ 10
<7>IOAPIC[0]: Set PCI routing entry (2-10 -> 0x79 -> IRQ 10 Mode:1 Active:1)
<7>00:00:0f[A] -> 2-10 -> IRQ 10
<4>_CRS returns NULL! Using IRQ 11 fordevice (PCI Interrupt Link [LNK4]).
<4>ACPI: PCI Interrupt Link [LNK4] enabled at IRQ 11
<7>IOAPIC[0]: Set PCI routing entry (2-11 -> 0x81 -> IRQ 11 Mode:1 Active:1)
<7>00:00:0e[A] -> 2-11 -> IRQ 11
<7>Pin 2-11 already programmed
<7>Pin 2-11 already programmed
<7>Pin 2-11 already programmed
<7>IOAPIC[1]: Set PCI routing entry (3-1 -> 0xa9 -> IRQ 17 Mode:1 Active:1)
<7>00:00:09[A] -> 3-1 -> IRQ 17
<7>IOAPIC[1]: Set PCI routing entry (3-2 -> 0xb1 -> IRQ 18 Mode:1 Active:1)
<7>00:00:03[A] -> 3-2 -> IRQ 18
<7>IOAPIC[1]: Set PCI routing entry (3-15 -> 0xb9 -> IRQ 31 Mode:1 Active:1)
<7>00:00:02[A] -> 3-15 -> IRQ 31
<7>IOAPIC[1]: Set PCI routing entry (3-3 -> 0xc1 -> IRQ 19 Mode:1 Active:1)
<7>00:00:04[A] -> 3-3 -> IRQ 19
<7>IOAPIC[1]: Set PCI routing entry (3-8 -> 0xc9 -> IRQ 24 Mode:1 Active:1)
<7>00:00:04[B] -> 3-8 -> IRQ 24
<7>IOAPIC[1]: Set PCI routing entry (3-13 -> 0xd1 -> IRQ 29 Mode:1 Active:1)
<7>00:00:04[C] -> 3-13 -> IRQ 29
<7>IOAPIC[1]: Set PCI routing entry (3-10 -> 0xd9 -> IRQ 26 Mode:1 Active:1)
<7>00:00:04[D] -> 3-10 -> IRQ 26
<7>IOAPIC[1]: Set PCI routing entry (3-4 -> 0xe1 -> IRQ 20 Mode:1 Active:1)
<7>00:00:05[A] -> 3-4 -> IRQ 20
<7>IOAPIC[1]: Set PCI routing entry (3-9 -> 0xe9 -> IRQ 25 Mode:1 Active:1)
<7>00:00:05[B] -> 3-9 -> IRQ 25
<7>IOAPIC[1]: Set PCI routing entry (3-14 -> 0x32 -> IRQ 30 Mode:1 Active:1)
<7>00:00:05[C] -> 3-14 -> IRQ 30
<7>IOAPIC[1]: Set PCI routing entry (3-11 -> 0x3a -> IRQ 27 Mode:1 Active:1)
<7>00:00:05[D] -> 3-11 -> IRQ 27
<7>IOAPIC[1]: Set PCI routing entry (3-5 -> 0x42 -> IRQ 21 Mode:1 Active:1)
<7>00:00:06[A] -> 3-5 -> IRQ 21
<7>Pin 3-10 already programmed
<7>Pin 3-15 already programmed
<7>IOAPIC[1]: Set PCI routing entry (3-12 -> 0x4a -> IRQ 28 Mode:1 Active:1)
<7>00:00:06[D] -> 3-12 -> IRQ 28
<7>IOAPIC[1]: Set PCI routing entry (3-6 -> 0x52 -> IRQ 22 Mode:1 Active:1)
<7>00:00:07[A] -> 3-6 -> IRQ 22
<7>Pin 3-11 already programmed
<7>Pin 3-8 already programmed
<7>Pin 3-13 already programmed
<7>IOAPIC[1]: Set PCI routing entry (3-7 -> 0x5a -> IRQ 23 Mode:1 Active:1)
<7>00:00:08[A] -> 3-7 -> IRQ 23
<7>Pin 3-12 already programmed
<7>Pin 3-9 already programmed
<7>Pin 3-14 already programmed
<7>number of MP IRQ sources: 15.
<7>number of IO-APIC #2 registers: 16.
<7>number of IO-APIC #3 registers: 16.
<7>number of IO-APIC #4 registers: 16.
<6>testing the IO APIC.......................
<4>
<7>IO APIC #2......
<7>.... register #00: 02000000
<7>.......    : physical APIC id: 02
<7>.......    : Delivery Type: 0
<7>.......    : LTS          : 0
<7>.... register #01: 000F0011
<7>.......     : max redirection entries: 000F
<7>.......     : PRQ implemented: 0
<7>.......     : IO APIC version: 0011
<7>.... register #02: 02000000
<7>.......     : arbitration: 02
<7>.... IRQ redirection table:
<7> NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:
<7> 00 000 00  1    0    0   0   0    0    0    00
<7> 01 001 01  0    0    0   0   0    1    1    39
<7> 02 000 00  1    0    0   0   0    0    0    00
<7> 03 001 01  0    0    0   0   0    1    1    41
<7> 04 001 01  0    0    0   0   0    1    1    49
<7> 05 001 01  0    0    0   0   0    1    1    51
<7> 06 001 01  0    0    0   0   0    1    1    59
<7> 07 001 01  0    0    0   0   0    1    1    61
<7> 08 001 01  0    0    0   0   0    1    1    69
<7> 09 001 01  0    1    0   1   0    1    1    71
<7> 0a 001 01  1    1    0   1   0    1    1    79
<7> 0b 001 01  1    1    0   1   0    1    1    81
<7> 0c 001 01  0    0    0   0   0    1    1    89
<7> 0d 001 01  0    0    0   0   0    1    1    91
<7> 0e 001 01  0    0    0   0   0    1    1    99
<7> 0f 001 01  0    0    0   0   0    1    1    A1
<4>
<7>IO APIC #3......
<7>.... register #00: 03000000
<7>.......    : physical APIC id: 03
<7>.......    : Delivery Type: 0
<7>.......    : LTS          : 0
<7>.... register #01: 000F0011
<7>.......     : max redirection entries: 000F
<7>.......     : PRQ implemented: 0
<7>.......     : IO APIC version: 0011
<7>.... register #02: 03000000
<7>.......     : arbitration: 03
<7>.... IRQ redirection table:
<7> NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:
<7> 00 000 00  1    0    0   0   0    0    0    00
<7> 01 001 01  1    1    0   1   0    1    1    A9
<7> 02 001 01  1    1    0   1   0    1    1    B1
<7> 03 001 01  1    1    0   1   0    1    1    C1
<7> 04 001 01  1    1    0   1   0    1    1    E1
<7> 05 001 01  1    1    0   1   0    1    1    42
<7> 06 001 01  1    1    0   1   0    1    1    52
<7> 07 001 01  1    1    0   1   0    1    1    5A
<7> 08 001 01  1    1    0   1   0    1    1    C9
<7> 09 001 01  1    1    0   1   0    1    1    E9
<7> 0a 001 01  1    1    0   1   0    1    1    D9
<7> 0b 001 01  1    1    0   1   0    1    1    3A
<7> 0c 001 01  1    1    0   1   0    1    1    4A
<7> 0d 001 01  1    1    0   1   0    1    1    D1
<7> 0e 001 01  1    1    0   1   0    1    1    32
<7> 0f 001 01  1    1    0   1   0    1    1    B9
<4>
<7>IO APIC #4......
<7>.... register #00: 04000000
<7>.......    : physical APIC id: 04
<7>.......    : Delivery Type: 0
<7>.......    : LTS          : 0
<7>.... register #01: 000F0011
<7>.......     : max redirection entries: 000F
<7>.......     : PRQ implemented: 0
<7>.......     : IO APIC version: 0011
<7>.... register #02: 04000000
<7>.......     : arbitration: 04
<7>.... IRQ redirection table:
<7> NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:
<7> 00 000 00  1    0    0   0   0    0    0    00
<7> 01 000 00  1    0    0   0   0    0    0    00
<7> 02 000 00  1    0    0   0   0    0    0    00
<7> 03 000 00  1    0    0   0   0    0    0    00
<7> 04 000 00  1    0    0   0   0    0    0    00
<7> 05 000 00  1    0    0   0   0    0    0    00
<7> 06 000 00  1    0    0   0   0    0    0    00
<7> 07 000 00  1    0    0   0   0    0    0    00
<7> 08 000 00  1    0    0   0   0    0    0    00
<7> 09 000 00  1    0    0   0   0    0    0    00
<7> 0a 000 00  1    0    0   0   0    0    0    00
<7> 0b 000 00  1    0    0   0   0    0    0    00
<7> 0c 000 00  1    0    0   0   0    0    0    00
<7> 0d 000 00  1    0    0   0   0    0    0    00
<7> 0e 000 00  1    0    0   0   0    0    0    00
<7> 0f 000 00  1    0    0   0   0    0    0    00
<7>IRQ to pin mappings:
<7>IRQ0 -> 0:2
<7>IRQ1 -> 0:1
<7>IRQ3 -> 0:3
<7>IRQ4 -> 0:4
<7>IRQ5 -> 0:5
<7>IRQ6 -> 0:6
<7>IRQ7 -> 0:7
<7>IRQ8 -> 0:8
<7>IRQ9 -> 0:9-> 0:9
<7>IRQ10 -> 0:10-> 0:10
<7>IRQ11 -> 0:11-> 0:11
<7>IRQ12 -> 0:12
<7>IRQ13 -> 0:13
<7>IRQ14 -> 0:14
<7>IRQ15 -> 0:15
<7>IRQ17 -> 1:1
<7>IRQ18 -> 1:2
<7>IRQ19 -> 1:3
<7>IRQ20 -> 1:4
<7>IRQ21 -> 1:5
<7>IRQ22 -> 1:6
<7>IRQ23 -> 1:7
<7>IRQ24 -> 1:8
<7>IRQ25 -> 1:9
<7>IRQ26 -> 1:10
<7>IRQ27 -> 1:11
<7>IRQ28 -> 1:12
<7>IRQ29 -> 1:13
<7>IRQ30 -> 1:14
<7>IRQ31 -> 1:15
<6>.................................... done.
<6>PCI: Using ACPI for IRQ routing
<6>PCI: if you experience problems, try using option 'pci=noacpi' or even 'acpi=off'
<6>Linux NET4.0 for Linux 2.4
<6>Based upon Swansea University Computer Society NET3.039
<4>Initializing RT netlink socket
<4>Starting kswapd
<4>allocated 32 pages and 32 bhs reserved for the highmem bounces
<6>Journalled Block Device driver loaded
<6>ACPI: Power Button (FF) [PWRF]
<6>ACPI: Processor [CPU0] (supports C1)
<6>Detected PS/2 Mouse Port.
<4>pty: 256 Unix98 ptys configured
<6>Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ SERIAL_PCI enabled
<6>ttyS00 at 0x03f8 (irq = 4) is a 16550A
<6>Real Time Clock Driver v1.10e
<6>Uniform Multi-Platform E-IDE driver Revision: 7.00beta4-2.4
<6>ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
<6>SvrWks CSB6: IDE controller at PCI slot 00:0f.1
<6>SvrWks CSB6: chipset revision 160
<6>SvrWks CSB6: not 100%% native mode: will probe irqs later
<6>    ide0: BM-DMA at 0xa400-0xa407, BIOS settings: hda:pio, hdb:pio
<6>    ide1: BM-DMA at 0xa408-0xa40f, BIOS settings: hdc:DMA, hdd:pio
<4>hdc: HL-DT-ST CD-ROM GCR-8482B, ATAPI CD/DVD-ROM drive
<4>ide1 at 0x170-0x177,0x376 on irq 15
<6>SCSI subsystem driver Revision: 1.00
<6>scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.36
<4>        <Adaptec (Compaq OEM) 29160 Ultra160 SCSI adapter>
<4>        aic7892: Ultra160 Wide Channel A, SCSI Id=7, 32/253 SCBs
<4>
<4>(scsi0:A:0): 160.000MB/s transfers (80.000MHz DT, offset 127, 16bit)
<4>(scsi0:A:1): 160.000MB/s transfers (80.000MHz DT, offset 127, 16bit)
<4>(scsi0:A:2): 160.000MB/s transfers (80.000MHz DT, offset 127, 16bit)
<4>  Vendor: COMPAQ    Model: BD03695CC8        Rev: HPB6
<4>  Type:   Direct-Access                      ANSI SCSI revision: 03
<4>  Vendor: MAXTOR    Model: ATLAS10K4_36WLS   Rev: DFV0
<4>  Type:   Direct-Access                      ANSI SCSI revision: 03
<4>  Vendor: MAXTOR    Model: ATLAS10K4_36WLS   Rev: DFV0
<4>  Type:   Direct-Access                      ANSI SCSI revision: 03
<4>scsi0:A:0:0: Tagged Queuing enabled.  Depth 32
<4>scsi0:A:1:0: Tagged Queuing enabled.  Depth 32
<4>scsi0:A:2:0: Tagged Queuing enabled.  Depth 32
<4>Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
<4>Attached scsi disk sdb at scsi0, channel 0, id 1, lun 0
<4>Attached scsi disk sdc at scsi0, channel 0, id 2, lun 0
<4>SCSI device sda: 71132000 512-byte hdwr sectors (36420 MB)
<6>Partition check:
<6> sda: sda1 sda2 sda3 sda4
<4>SCSI device sdb: 71833096 512-byte hdwr sectors (36779 MB)
<6> sdb: sdb1
<4>SCSI device sdc: 71833096 512-byte hdwr sectors (36779 MB)
<6> sdc: unknown partition table
<6>md: linear personality registered as nr 1
<6>md: raid0 personality registered as nr 2
<6>md: raid1 personality registered as nr 3
<6>md: raid5 personality registered as nr 4
<6>raid5: measuring checksumming speed
<4>   8regs     :  3109.200 MB/sec
<4>   32regs    :  1892.400 MB/sec
<4>   pIII_sse  :  3476.400 MB/sec
<4>   pII_mmx   :  3092.800 MB/sec
<4>   p5_mmx    :  3078.400 MB/sec
<4>raid5: using function: pIII_sse (3476.400 MB/sec)
<6>md: md driver 0.90.0 MAX_MD_DEVS=256, MD_SB_DISKS=27
<6>md: Autodetecting RAID arrays.
<6>md: autorun ...
<6>md: ... autorun DONE.
<6>Initializing Cryptographic API
<6>NET4: Linux TCP/IP 1.0 for NET4.0
<6>IP Protocols: ICMP, UDP, TCP, IGMP
<6>IP: routing cache hash table of 8192 buckets, 64Kbytes
<6>TCP: Hash tables configured (established 262144 bind 65536)
<6>NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
<6>kjournald starting.  Commit interval 5 seconds
<6>EXT3-fs: mounted filesystem with ordered data mode.
<4>VFS: Mounted root (ext3 filesystem) readonly.
<6>Freeing unused kernel memory: 104k freed
<6>md: Autodetecting RAID arrays.
<6>md: autorun ...
<6>md: ... autorun DONE.
<6>Adding Swap: 530136k swap-space (priority 42)
<6>EXT3 FS 2.4-0.9.19, 19 August 2002 on sd(8,3), internal journal
<6>kjournald starting.  Commit interval 5 seconds
<6>EXT3 FS 2.4-0.9.19, 19 August 2002 on sd(8,1), internal journal
<6>EXT3-fs: mounted filesystem with ordered data mode.
Kernel logging (ksyslog) stopped.
Kernel log daemon terminating.

--Boundary-00=_JehKATNpOWbQHug
Content-Type: text/x-log;
  charset="iso-8859-2";
  name="2.4.24-grsec.log"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="2.4.24-grsec.log"

xen:~ # cat /var/log/boot.msg
Inspecting /boot/System.map-2.4.24-grsec
Loaded 18394 symbols from /boot/System.map-2.4.24-grsec.
Symbols match kernel version 2.4.24.
No module symbols loaded.
klogd 1.4.1, log source = ksyslog started.
 version 17, address 0xfec02000, IRQ 32-47
<6>ACPI: INT_SRC_OVR (bus[0] irq[0x0] global_irq[0x2] polarity[0x0] trigger[0x1])
<6>ACPI: INT_SRC_OVR (bus[0] irq[0x9] global_irq[0x9] polarity[0x3] trigger[0x3])
<4>ACPI BALANCE SET
<6>Using ACPI (MADT) for SMP configuration information
<4>Kernel command line: root=/dev/sda3
<6>Initializing CPU#0
<4>Detected 2665.999 MHz processor.
<4>Console: colour VGA+ 80x25
<4>Calibrating delay loop... 5321.52 BogoMIPS
<6>Memory: 1033324k/1048556k available (1572k kernel code, 14844k reserved, 307k data, 116k init, 131052k highmem)
<6>Dentry cache hash table entries: 131072 (order: 8, 1048576 bytes)
<6>Inode cache hash table entries: 65536 (order: 7, 524288 bytes)
<6>Mount cache hash table entries: 512 (order: 0, 4096 bytes)
<6>Buffer cache hash table entries: 65536 (order: 6, 262144 bytes)
<4>Page-cache hash table entries: 262144 (order: 8, 1048576 bytes)
<6>CPU: Trace cache: 12K uops, L1 D cache: 8K
<6>CPU: L2 cache: 512K
<6>Intel machine check architecture supported.
<6>Intel machine check reporting enabled on CPU#0.
<7>CPU:     After generic, caps: bfebfbff 00000000 00000000 00000000
<7>CPU:             Common caps: bfebfbff 00000000 00000000 00000000
<4>CPU: Intel(R) Pentium(R) 4 CPU 2.66GHz stepping 09
<6>Enabling fast FPU save and restore... done.
<6>Enabling unmasked SIMD FPU exception support... done.
<6>Checking 'hlt' instruction... OK.
<4>POSIX conformance testing by UNIFIX
<4>enabled ExtINT on CPU#0
<4>ESR value before enabling vector: 00000000
<4>ESR value after enabling vector: 00000000
<4>ENABLING IO-APIC IRQs
<7>init IO_APIC IRQs
<7> IO-APIC (apicid-pin) 2-0, 3-0, 3-1, 3-2, 3-3, 3-4, 3-5, 3-6, 3-7, 3-8, 3-9, 3-10, 3-11, 3-12, 3-13, 3-14, 3-15, 4-0, 4-1, 4-2, 4-3, 4-4, 4-5, 4-6, 4-7, 4-8, 4-9, 4-10, 4-11, 4-12, 4-13, 4-14, 4-15 not connected.
<6>..TIMER: vector=0x31 pin1=2 pin2=-1
<3>..MP-BIOS bug: 8254 timer not connected to IO-APIC
<6>...trying to set up timer (IRQ0) through the 8259A ...  failed.
<6>...trying to set up timer as Virtual Wire IRQ... works.
<4>Using local APIC timer interrupts.
<4>calibrating APIC timer ...
<4>..... CPU clock speed is 2665.8824 MHz.
<4>..... host bus clock speed is 133.2940 MHz.
<4>cpu: 0, clocks: 1332940, slice: 666470
<4>CPU0<T0:1332928,T1:666448,D:10,S:666470,C:1332940>
<4>mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
<4>mtrr: detected mtrr type: Intel
<6>ACPI: Subsystem revision 20031002
<6>PCI: PCI BIOS revision 2.10 entry at 0xf17b0, last bus=0
<6>PCI: Using configuration type 1
<7>IOAPIC[0]: Set PCI routing entry (2-9 -> 0x71 -> IRQ 9 Mode:1 Active:1)
<6>ACPI: Interpreter enabled
<6>ACPI: Using IOAPIC for interrupt routing
<6>ACPI: System [ACPI] (supports S0 S1 S4 S5)
<4>ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 9 10 11 12 14 15)
<4>ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 9 10 11 12 14 15)
<4>ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 9 10 11 *12 14 15)
<4>ACPI: PCI Interrupt Link [LNKD] (IRQs *3 4 5 6 7 9 10 11 12 14 15)
<4>ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 7 9 10 11 12 14 15)
<4>ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 *5 6 7 9 10 11 12 14 15)
<4>ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 7 9 10 11 12 14 15)
<4>ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 6 7 9 10 11 12 14 15)
<4>ACPI: PCI Interrupt Link [LNKI] (IRQs 3 4 5 6 7 9 10 11 12 14 15)
<4>ACPI: PCI Interrupt Link [LNKJ] (IRQs 3 4 5 6 7 9 10 11 12 14 15)
<4>ACPI: PCI Interrupt Link [LNKK] (IRQs 3 4 5 6 7 9 10 11 12 14 15)
<4>ACPI: PCI Interrupt Link [LNKL] (IRQs 3 4 5 6 7 9 10 11 12 14 15)
<4>ACPI: PCI Interrupt Link [LNKM] (IRQs 3 4 5 6 7 9 10 11 12 14 15)
<4>ACPI: PCI Interrupt Link [LNKN] (IRQs 3 4 5 6 7 9 10 11 12 14 15)
<4>ACPI: PCI Interrupt Link [LNKO] (IRQs 3 4 5 6 7 9 10 11 12 14 15)
<4>ACPI: PCI Interrupt Link [LNKP] (IRQs 3 4 5 6 7 9 10 11 12 14 15)
<4>ACPI: PCI Interrupt Link [LNKQ] (IRQs 3 4 5 6 7 9 10 11 12 14 15)
<4>ACPI: PCI Interrupt Link [LNKR] (IRQs 3 4 5 6 7 9 10 11 12 14 15)
<4>ACPI: PCI Interrupt Link [LNKS] (IRQs 3 4 5 6 7 9 10 11 12 14 15)
<4>ACPI: PCI Interrupt Link [LNKT] (IRQs 3 4 5 6 7 9 10 11 12 14 15)
<4>ACPI: PCI Interrupt Link [LNKU] (IRQs 3 4 5 6 7 9 10 11 12 14 15)
<4>ACPI: PCI Interrupt Link [LNKV] (IRQs 3 4 5 6 7 9 10 11 12 14 15)
<4>ACPI: PCI Interrupt Link [LNKW] (IRQs 3 4 5 6 7 9 10 11 12 14 15)
<4>ACPI: PCI Interrupt Link [LNKX] (IRQs 3 4 5 6 7 9 10 11 12 14 15)
<4>ACPI: PCI Interrupt Link [LNKY] (IRQs 3 4 5 6 7 9 10 11 12 14 15)
<4>ACPI: PCI Interrupt Link [LNKZ] (IRQs 3 4 5 6 7 9 10 11 12 14 15)
<4>ACPI: PCI Interrupt Link [LNK0] (IRQs 3 4 5 6 7 9 10 11 12 14 15)
<4>ACPI: PCI Interrupt Link [LNK1] (IRQs 3 4 5 6 7 9 10 11 12 14 15)
<4>ACPI: PCI Interrupt Link [LNK2] (IRQs 3 4 5 6 7 9 10 11 12 14 15)
<4>ACPI: PCI Interrupt Link [LNK3] (IRQs 3 4 5 6 7 9 10 11 12 14 15)
<4>ACPI: PCI Interrupt Link [LNK4] (IRQs 11)
<4>ACPI: PCI Interrupt Link [LNK5] (IRQs 5 10 11 12 14 15)
<6>ACPI: PCI Root Bridge [PCI0] (00:00)
<4>PCI: Probing PCI hardware (bus 00)
<6>PCI: Ignoring BAR0-3 of IDE controller 00:0f.1
<7>ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
<6>ACPI: Power Resource [FDDP] (off)
<6>ACPI: Power Resource [LPTP] (off)
<6>ACPI: Power Resource [URP1] (off)
<6>ACPI: Power Resource [URP2] (off)
<6>PCI: Probing PCI hardware
<4>_CRS returns NULL! Using IRQ 10 fordevice (PCI Interrupt Link [LNK5]).
<4>ACPI: PCI Interrupt Link [LNK5] enabled at IRQ 10
<7>IOAPIC[0]: Set PCI routing entry (2-10 -> 0x79 -> IRQ 10 Mode:1 Active:1)
<7>00:00:0f[A] -> 2-10 -> IRQ 10
<4>_CRS returns NULL! Using IRQ 11 fordevice (PCI Interrupt Link [LNK4]).
<4>ACPI: PCI Interrupt Link [LNK4] enabled at IRQ 11
<7>IOAPIC[0]: Set PCI routing entry (2-11 -> 0x81 -> IRQ 11 Mode:1 Active:1)
<7>00:00:0e[A] -> 2-11 -> IRQ 11
<7>Pin 2-11 already programmed
<7>Pin 2-11 already programmed
<7>Pin 2-11 already programmed
<7>IOAPIC[1]: Set PCI routing entry (3-1 -> 0xa9 -> IRQ 17 Mode:1 Active:1)
<7>00:00:09[A] -> 3-1 -> IRQ 17
<7>IOAPIC[1]: Set PCI routing entry (3-2 -> 0xb1 -> IRQ 18 Mode:1 Active:1)
<7>00:00:03[A] -> 3-2 -> IRQ 18
<7>IOAPIC[1]: Set PCI routing entry (3-15 -> 0xb9 -> IRQ 31 Mode:1 Active:1)
<7>00:00:02[A] -> 3-15 -> IRQ 31
<7>IOAPIC[1]: Set PCI routing entry (3-3 -> 0xc1 -> IRQ 19 Mode:1 Active:1)
<7>00:00:04[A] -> 3-3 -> IRQ 19
<7>IOAPIC[1]: Set PCI routing entry (3-8 -> 0xc9 -> IRQ 24 Mode:1 Active:1)
<7>00:00:04[B] -> 3-8 -> IRQ 24
<7>IOAPIC[1]: Set PCI routing entry (3-13 -> 0xd1 -> IRQ 29 Mode:1 Active:1)
<7>00:00:04[C] -> 3-13 -> IRQ 29
<7>IOAPIC[1]: Set PCI routing entry (3-10 -> 0xd9 -> IRQ 26 Mode:1 Active:1)
<7>00:00:04[D] -> 3-10 -> IRQ 26
<7>IOAPIC[1]: Set PCI routing entry (3-4 -> 0xe1 -> IRQ 20 Mode:1 Active:1)
<7>00:00:05[A] -> 3-4 -> IRQ 20
<7>IOAPIC[1]: Set PCI routing entry (3-9 -> 0xe9 -> IRQ 25 Mode:1 Active:1)
<7>00:00:05[B] -> 3-9 -> IRQ 25
<7>IOAPIC[1]: Set PCI routing entry (3-14 -> 0x32 -> IRQ 30 Mode:1 Active:1)
<7>00:00:05[C] -> 3-14 -> IRQ 30
<7>IOAPIC[1]: Set PCI routing entry (3-11 -> 0x3a -> IRQ 27 Mode:1 Active:1)
<7>00:00:05[D] -> 3-11 -> IRQ 27
<7>IOAPIC[1]: Set PCI routing entry (3-5 -> 0x42 -> IRQ 21 Mode:1 Active:1)
<7>00:00:06[A] -> 3-5 -> IRQ 21
<7>Pin 3-10 already programmed
<7>Pin 3-15 already programmed
<7>IOAPIC[1]: Set PCI routing entry (3-12 -> 0x4a -> IRQ 28 Mode:1 Active:1)
<7>00:00:06[D] -> 3-12 -> IRQ 28
<7>IOAPIC[1]: Set PCI routing entry (3-6 -> 0x52 -> IRQ 22 Mode:1 Active:1)
<7>00:00:07[A] -> 3-6 -> IRQ 22
<7>Pin 3-11 already programmed
<7>Pin 3-8 already programmed
<7>Pin 3-13 already programmed
<7>IOAPIC[1]: Set PCI routing entry (3-7 -> 0x5a -> IRQ 23 Mode:1 Active:1)
<7>00:00:08[A] -> 3-7 -> IRQ 23
<7>Pin 3-12 already programmed
<7>Pin 3-9 already programmed
<7>Pin 3-14 already programmed
<7>number of MP IRQ sources: 15.
<7>number of IO-APIC #2 registers: 16.
<7>number of IO-APIC #3 registers: 16.
<7>number of IO-APIC #4 registers: 16.
<6>testing the IO APIC.......................
<4>
<7>IO APIC #2......
<7>.... register #00: 02000000
<7>.......    : physical APIC id: 02
<7>.......    : Delivery Type: 0
<7>.......    : LTS          : 0
<7>.... register #01: 000F0011
<7>.......     : max redirection entries: 000F
<7>.......     : PRQ implemented: 0
<7>.......     : IO APIC version: 0011
<7>.... register #02: 02000000
<7>.......     : arbitration: 02
<7>.... IRQ redirection table:
<7> NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:
<7> 00 000 00  1    0    0   0   0    0    0    00
<7> 01 001 01  0    0    0   0   0    1    1    39
<7> 02 000 00  1    0    0   0   0    0    0    00
<7> 03 001 01  0    0    0   0   0    1    1    41
<7> 04 001 01  0    0    0   0   0    1    1    49
<7> 05 001 01  0    0    0   0   0    1    1    51
<7> 06 001 01  0    0    0   0   0    1    1    59
<7> 07 001 01  0    0    0   0   0    1    1    61
<7> 08 001 01  0    0    0   0   0    1    1    69
<7> 09 001 01  0    1    0   1   0    1    1    71
<7> 0a 001 01  1    1    0   1   0    1    1    79
<7> 0b 001 01  1    1    0   1   0    1    1    81
<7> 0c 001 01  0    0    0   0   0    1    1    89
<7> 0d 001 01  0    0    0   0   0    1    1    91
<7> 0e 001 01  0    0    0   0   0    1    1    99
<7> 0f 001 01  0    0    0   0   0    1    1    A1
<4>
<7>IO APIC #3......
<7>.... register #00: 03000000
<7>.......    : physical APIC id: 03
<7>.......    : Delivery Type: 0
<7>.......    : LTS          : 0
<7>.... register #01: 000F0011
<7>.......     : max redirection entries: 000F
<7>.......     : PRQ implemented: 0
<7>.......     : IO APIC version: 0011
<7>.... register #02: 03000000
<7>.......     : arbitration: 03
<7>.... IRQ redirection table:
<7> NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:
<7> 00 000 00  1    0    0   0   0    0    0    00
<7> 01 001 01  1    1    0   1   0    1    1    A9
<7> 02 001 01  1    1    0   1   0    1    1    B1
<7> 03 001 01  1    1    0   1   0    1    1    C1
<7> 04 001 01  1    1    0   1   0    1    1    E1
<7> 05 001 01  1    1    0   1   0    1    1    42
<7> 06 001 01  1    1    0   1   0    1    1    52
<7> 07 001 01  1    1    0   1   0    1    1    5A
<7> 08 001 01  1    1    0   1   0    1    1    C9
<7> 09 001 01  1    1    0   1   0    1    1    E9
<7> 0a 001 01  1    1    0   1   0    1    1    D9
<7> 0b 001 01  1    1    0   1   0    1    1    3A
<7> 0c 001 01  1    1    0   1   0    1    1    4A
<7> 0d 001 01  1    1    0   1   0    1    1    D1
<7> 0e 001 01  1    1    0   1   0    1    1    32
<7> 0f 001 01  1    1    0   1   0    1    1    B9
<4>
<7>IO APIC #4......
<7>.... register #00: 04000000
<7>.......    : physical APIC id: 04
<7>.......    : Delivery Type: 0
<7>.......    : LTS          : 0
<7>.... register #01: 000F0011
<7>.......     : max redirection entries: 000F
<7>.......     : PRQ implemented: 0
<7>.......     : IO APIC version: 0011
<7>.... register #02: 04000000
<7>.......     : arbitration: 04
<7>.... IRQ redirection table:
<7> NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:
<7> 00 000 00  1    0    0   0   0    0    0    00
<7> 01 000 00  1    0    0   0   0    0    0    00
<7> 02 000 00  1    0    0   0   0    0    0    00
<7> 03 000 00  1    0    0   0   0    0    0    00
<7> 04 000 00  1    0    0   0   0    0    0    00
<7> 05 000 00  1    0    0   0   0    0    0    00
<7> 06 000 00  1    0    0   0   0    0    0    00
<7> 07 000 00  1    0    0   0   0    0    0    00
<7> 08 000 00  1    0    0   0   0    0    0    00
<7> 09 000 00  1    0    0   0   0    0    0    00
<7> 0a 000 00  1    0    0   0   0    0    0    00
<7> 0b 000 00  1    0    0   0   0    0    0    00
<7> 0c 000 00  1    0    0   0   0    0    0    00
<7> 0d 000 00  1    0    0   0   0    0    0    00
<7> 0e 000 00  1    0    0   0   0    0    0    00
<7> 0f 000 00  1    0    0   0   0    0    0    00
<7>IRQ to pin mappings:
<7>IRQ0 -> 0:2
<7>IRQ1 -> 0:1
<7>IRQ3 -> 0:3
<7>IRQ4 -> 0:4
<7>IRQ5 -> 0:5
<7>IRQ6 -> 0:6
<7>IRQ7 -> 0:7
<7>IRQ8 -> 0:8
<7>IRQ9 -> 0:9-> 0:9
<7>IRQ10 -> 0:10-> 0:10
<7>IRQ11 -> 0:11-> 0:11
<7>IRQ12 -> 0:12
<7>IRQ13 -> 0:13
<7>IRQ14 -> 0:14
<7>IRQ15 -> 0:15
<7>IRQ17 -> 1:1
<7>IRQ18 -> 1:2
<7>IRQ19 -> 1:3
<7>IRQ20 -> 1:4
<7>IRQ21 -> 1:5
<7>IRQ22 -> 1:6
<7>IRQ23 -> 1:7
<7>IRQ24 -> 1:8
<7>IRQ25 -> 1:9
<7>IRQ26 -> 1:10
<7>IRQ27 -> 1:11
<7>IRQ28 -> 1:12
<7>IRQ29 -> 1:13
<7>IRQ30 -> 1:14
<7>IRQ31 -> 1:15
<6>.................................... done.
<6>PCI: Using ACPI for IRQ routing
<6>PCI: if you experience problems, try using option 'pci=noacpi' or even 'acpi=off'
<6>Linux NET4.0 for Linux 2.4
<6>Based upon Swansea University Computer Society NET3.039
<4>Initializing RT netlink socket
<4>Starting kswapd
<4>allocated 32 pages and 32 bhs reserved for the highmem bounces
<6>Journalled Block Device driver loaded
<6>ACPI: Power Button (FF) [PWRF]
<6>ACPI: Processor [CPU0] (supports C1)
<6>Detected PS/2 Mouse Port.
<4>pty: 256 Unix98 ptys configured
<6>Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ SERIAL_PCI enabled
<6>ttyS00 at 0x03f8 (irq = 4) is a 16550A
<6>Real Time Clock Driver v1.10e
<6>Uniform Multi-Platform E-IDE driver Revision: 7.00beta4-2.4
<6>ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
<6>SvrWks CSB6: IDE controller at PCI slot 00:0f.1
<6>SvrWks CSB6: chipset revision 160
<6>SvrWks CSB6: not 100%% native mode: will probe irqs later
<6>    ide0: BM-DMA at 0xa400-0xa407, BIOS settings: hda:pio, hdb:pio
<6>    ide1: BM-DMA at 0xa408-0xa40f, BIOS settings: hdc:DMA, hdd:pio
<4>hdc: HL-DT-ST CD-ROM GCR-8482B, ATAPI CD/DVD-ROM drive
<4>ide1 at 0x170-0x177,0x376 on irq 15
<6>SCSI subsystem driver Revision: 1.00
<6>scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.36
<4>        <Adaptec (Compaq OEM) 29160 Ultra160 SCSI adapter>
<4>        aic7892: Ultra160 Wide Channel A, SCSI Id=7, 32/253 SCBs
<4>
<4>(scsi0:A:0): 160.000MB/s transfers (80.000MHz DT, offset 127, 16bit)
<4>(scsi0:A:1): 160.000MB/s transfers (80.000MHz DT, offset 127, 16bit)
<4>(scsi0:A:2): 160.000MB/s transfers (80.000MHz DT, offset 127, 16bit)
<4>  Vendor: COMPAQ    Model: BD03695CC8        Rev: HPB6
<4>  Type:   Direct-Access                      ANSI SCSI revision: 03
<4>  Vendor: MAXTOR    Model: ATLAS10K4_36WLS   Rev: DFV0
<4>  Type:   Direct-Access                      ANSI SCSI revision: 03
<4>  Vendor: MAXTOR    Model: ATLAS10K4_36WLS   Rev: DFV0
<4>  Type:   Direct-Access                      ANSI SCSI revision: 03
<4>scsi0:A:0:0: Tagged Queuing enabled.  Depth 32
<4>scsi0:A:1:0: Tagged Queuing enabled.  Depth 32
<4>scsi0:A:2:0: Tagged Queuing enabled.  Depth 32
<4>Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
<4>Attached scsi disk sdb at scsi0, channel 0, id 1, lun 0
<4>Attached scsi disk sdc at scsi0, channel 0, id 2, lun 0
<4>SCSI device sda: 71132000 512-byte hdwr sectors (36420 MB)
<6>Partition check:
<6> sda: sda1 sda2 sda3 sda4
<4>SCSI device sdb: 71833096 512-byte hdwr sectors (36779 MB)
<6> sdb: sdb1
<4>SCSI device sdc: 71833096 512-byte hdwr sectors (36779 MB)
<6> sdc: unknown partition table
<6>md: linear personality registered as nr 1
<6>md: raid0 personality registered as nr 2
<6>md: raid1 personality registered as nr 3
<6>md: raid5 personality registered as nr 4
<6>raid5: measuring checksumming speed
<4>   8regs     :  3140.400 MB/sec
<4>   32regs    :  1874.800 MB/sec
<4>   pIII_sse  :  3485.600 MB/sec
<4>   pII_mmx   :  3118.000 MB/sec
<4>   p5_mmx    :  3110.000 MB/sec
<4>raid5: using function: pIII_sse (3485.600 MB/sec)
<6>md: md driver 0.90.0 MAX_MD_DEVS=256, MD_SB_DISKS=27
<6>md: Autodetecting RAID arrays.
<6>md: autorun ...
<6>md: ... autorun DONE.
<6>Initializing Cryptographic API
<6>NET4: Linux TCP/IP 1.0 for NET4.0
<6>IP Protocols: ICMP, UDP, TCP, IGMP
<6>IP: routing cache hash table of 8192 buckets, 64Kbytes
<6>TCP: Hash tables configured (established 262144 bind 65536)
<6>NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
<6>kjournald starting.  Commit interval 5 seconds
<6>EXT3-fs: mounted filesystem with ordered data mode.
<4>VFS: Mounted root (ext3 filesystem) readonly.
<6>Freeing unused kernel memory: 116k freed
<6>md: Autodetecting RAID arrays.
<6>md: autorun ...
<6>md: ... autorun DONE.
<6>Adding Swap: 530136k swap-space (priority 42)
<6>EXT3 FS 2.4-0.9.19, 19 August 2002 on sd(8,3), internal journal
<6>kjournald starting.  Commit interval 5 seconds
<6>EXT3 FS 2.4-0.9.19, 19 August 2002 on sd(8,1), internal journal
<6>EXT3-fs: mounted filesystem with ordered data mode.
Kernel logging (ksyslog) stopped.
Kernel log daemon terminating.

--Boundary-00=_JehKATNpOWbQHug--
