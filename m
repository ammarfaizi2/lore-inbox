Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263557AbUDUR0m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263557AbUDUR0m (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Apr 2004 13:26:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263558AbUDUR0m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Apr 2004 13:26:42 -0400
Received: from dim.w-m.ru ([81.13.59.23]:59008 "HELO dim.w-m.ru")
	by vger.kernel.org with SMTP id S263557AbUDUR0M (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Apr 2004 13:26:12 -0400
To: zwane@linux.realnet.co.sz
Cc: linux-kernel@vger.kernel.org
Subject: flooded by "CPU#0: Running in modulated clock mode"
From: Alexey Mahotkin <alexm@w-m.ru>
Organization: http://www.w-m.ru/
Date: Wed, 21 Apr 2004 21:25:51 +0400
Message-ID: <87llkpmee8.fsf@dim.w-m.ru>
User-Agent: Gnus/5.090024 (Oort Gnus v0.24) XEmacs/21.4 (Reasonable
 Discussion, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Zwane and all,

I'm running 2.6.5, compiled for i686 architecture, on Celeron 1.8GHz.
Motherboard is ASUS P4S800-MX.  The machine has 1U form-factor.

Usually processor runs at ~40C, according to lm-sensors (and BIOS
agrees with it).

When I start CPU hog (prime-net client), the temperature rises to ~62C
in several minutes.  After that I'm getting a swamp of messages:


        CPU#0: Running in modulated clock mode
        CPU#0: Temperature/speed normal
        CPU#0: Temperature above threshold
        CPU#0: Running in modulated clock mode
        CPU#0: Temperature/speed normal
        CPU#0: Temperature above threshold
        [ ...endless... ]

When I stop it, messages stop immediately, and processor cools down
back to 40C.

However, according to google, maximum Celeron temperature must be
somewhere near 80C.  Also, AFAIU, if it were overheating, I'd get a
single message about "Temperature above threshold".

Why is it flooding me on KERN_EMERG level?  How can I change the
temperature threshold?


Should I try noapic?  Should I try acpi=off? 


Thanks,


Here is my dmesg output from the start:

Linux version 2.6.5-1-686 (tretkowski@rollcage) (gcc version 2.95.4 20011002 (Debian prerelease)) #1 Fri Apr 9 12:46:05 CEST 2004
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000001dffc000 (usable)
 BIOS-e820: 000000001dffc000 - 000000001dfff000 (ACPI data)
 BIOS-e820: 000000001dfff000 - 000000001e000000 (ACPI NVS)
 BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
0MB HIGHMEM available.
479MB LOWMEM available.
On node 0 totalpages: 122876
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 118780 pages, LIFO batch:16
  HighMem zone: 0 pages, LIFO batch:1
DMI 2.3 present.
ACPI: RSDP (v000 ASUS                                      ) @ 0x000f5700
ACPI: RSDT (v001 ASUS   P4S800MX 0x42302e31 MSFT 0x31313031) @ 0x1dffc000
ACPI: FADT (v001 ASUS   P4S800MX 0x42302e31 MSFT 0x31313031) @ 0x1dffc0c0
ACPI: BOOT (v001 ASUS   P4S800MX 0x42302e31 MSFT 0x31313031) @ 0x1dffc030
ACPI: MADT (v001 ASUS   P4S800MX 0x42302e31 MSFT 0x31313031) @ 0x1dffc058
ACPI: DSDT (v001   ASUS P4S800MX 0x00001000 MSFT 0x0100000b) @ 0x00000000
ACPI: PM-Timer IO Port: 0xe408
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
Processor #0 15:1 APIC version 20
ACPI: LAPIC_NMI (acpi_id[0x00] high edge lint[0x1])
ACPI: IOAPIC (id[0x02] address[0xfec00000] global_irq_base[0x0])
IOAPIC[0]: Assigned apic_id 2
IOAPIC[0]: apic_id 2, version 128, address 0xfec00000, GSI 0-23
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl edge)
ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 20 low level)
Enabling APIC mode:  Flat.  Using 1 I/O APICs
Using ACPI (MADT) for SMP configuration information
Built 1 zonelists
Kernel command line: auto BOOT_IMAGE=Linux ro root=302 nothermal
Initializing CPU#0
PID hash table entries: 2048 (order 11: 16384 bytes)
Detected 1800.787 MHz processor.
Using pmtmr for high-res timesource
Console: colour VGA+ 80x25
Memory: 479320k/491504k available (1349k kernel code, 11436k reserved, 712k data, 128k init, 0k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay loop... 3571.71 BogoMIPS
Security Scaffold v1.0.0 initialized
Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
checking if image is initramfs...it isn't (ungzip failed); looks like an initrd
Freeing initrd memory: 4144k freed
CPU:     After generic identify, caps: 3febfbff 00000000 00000000 00000000
CPU:     After vendor identify, caps: 3febfbff 00000000 00000000 00000000
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 128K
CPU:     After all inits, caps: 3febfbff 00000000 00000000 00000080
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU#0: Intel P4/Xeon Extended MCE MSRs (12) available
CPU#0: Thermal monitoring enabled
CPU: Intel(R) Celeron(R) CPU 1.80GHz stepping 03
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
ENABLING IO-APIC IRQs
init IO_APIC IRQs
 IO-APIC (apicid-pin) 2-0, 2-16, 2-17, 2-18, 2-19, 2-21, 2-22, 2-23 not connected.
..TIMER: vector=0x31 pin1=2 pin2=-1
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 1799.0834 MHz.
..... host bus clock speed is 99.0990 MHz.
NET: Registered protocol family 16
PCI: PCI BIOS revision 2.10 entry at 0xf10c0, last bus=1
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
ACPI: Subsystem revision 20040326
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 10 11 *12 14 15)
ACPI: PCI Interrupt Link [LNKE] (IRQs *3 4 5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 *5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 6 7 10 11 12 14 15)
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
Enabling SiS 96x SMBus.
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCI1._PRT]
Linux Plug and Play Support v0.97 (c) Adam Belay
PnPBIOS: Scanning system for PnP BIOS support...
PnPBIOS: Found PnP BIOS installation structure at 0xc00f95f0
PnPBIOS: PnP BIOS version 1.0, entry 0xf0000:0x9620, dseg 0xf0000
pnp: 00:12: ioport range 0xe600-0xe61f has been reserved
pnp: 00:12: ioport range 0xe400-0xe47f has been reserved
PnPBIOS: 14 nodes reported by PnP BIOS; 14 recorded by driver
IOAPIC[0]: Set PCI routing entry (2-16 -> 0xb1 -> IRQ 16 Mode:1 Active:1)
00:00:02[A] -> 2-16 -> IRQ 16
IOAPIC[0]: Set PCI routing entry (2-17 -> 0xb9 -> IRQ 17 Mode:1 Active:1)
00:00:02[B] -> 2-17 -> IRQ 17
IOAPIC[0]: Set PCI routing entry (2-18 -> 0xc1 -> IRQ 18 Mode:1 Active:1)
00:00:02[C] -> 2-18 -> IRQ 18
IOAPIC[0]: Set PCI routing entry (2-19 -> 0xc9 -> IRQ 19 Mode:1 Active:1)
00:00:02[D] -> 2-19 -> IRQ 19
IOAPIC[0]: Set PCI routing entry (2-21 -> 0xd1 -> IRQ 21 Mode:1 Active:1)
00:00:03[B] -> 2-21 -> IRQ 21
IOAPIC[0]: Set PCI routing entry (2-22 -> 0xd9 -> IRQ 22 Mode:1 Active:1)
00:00:03[C] -> 2-22 -> IRQ 22
IOAPIC[0]: Set PCI routing entry (2-23 -> 0xe1 -> IRQ 23 Mode:1 Active:1)
00:00:03[D] -> 2-23 -> IRQ 23
number of MP IRQ sources: 16.
number of IO-APIC #2 registers: 24.
testing the IO APIC.......................
IO APIC #2......
.... register #00: 02000000
.......    : physical APIC id: 02
.......    : Delivery Type: 0
.......    : LTS          : 0
.... register #01: 00178080
.......     : max redirection entries: 0017
.......     : PRQ implemented: 1
.......     : IO APIC version: 0080
.... register #02: 02000000
.......     : arbitration: 02
.... register #03: 00000001
.......     : Boot DT    : 1
.... IRQ redirection table:
 NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:   
 00 000 00  1    0    0   0   0    0    0    00
 01 001 01  0    0    0   0   0    1    1    39
 02 001 01  0    0    0   0   0    1    1    31
 03 001 01  0    0    0   0   0    1    1    41
 04 001 01  0    0    0   0   0    1    1    49
 05 001 01  0    0    0   0   0    1    1    51
 06 001 01  0    0    0   0   0    1    1    59
 07 001 01  0    0    0   0   0    1    1    61
 08 001 01  0    0    0   0   0    1    1    69
 09 001 01  0    0    0   0   0    1    1    71
 0a 001 01  0    0    0   0   0    1    1    79
 0b 001 01  0    0    0   0   0    1    1    81
 0c 001 01  0    0    0   0   0    1    1    89
 0d 001 01  0    0    0   0   0    1    1    91
 0e 001 01  0    0    0   0   0    1    1    99
 0f 001 01  0    0    0   0   0    1    1    A1
 10 001 01  1    1    0   1   0    1    1    B1
 11 001 01  1    1    0   1   0    1    1    B9
 12 001 01  1    1    0   1   0    1    1    C1
 13 001 01  1    1    0   1   0    1    1    C9
 14 001 01  0    1    0   1   0    1    1    A9
 15 001 01  1    1    0   1   0    1    1    D1
 16 001 01  1    1    0   1   0    1    1    D9
 17 001 01  1    1    0   1   0    1    1    E1
IRQ to pin mappings:
IRQ0 -> 0:2
IRQ1 -> 0:1
IRQ3 -> 0:3
IRQ4 -> 0:4
IRQ5 -> 0:5
IRQ6 -> 0:6
IRQ7 -> 0:7
IRQ8 -> 0:8
IRQ9 -> 0:9
IRQ10 -> 0:10
IRQ11 -> 0:11
IRQ12 -> 0:12
IRQ13 -> 0:13
IRQ14 -> 0:14
IRQ15 -> 0:15
IRQ16 -> 0:16
IRQ17 -> 0:17
IRQ18 -> 0:18
IRQ19 -> 0:19
IRQ20 -> 0:20
IRQ21 -> 0:21
IRQ22 -> 0:22
IRQ23 -> 0:23
.................................... done.
PCI: Using ACPI for IRQ routing
PCI: if you experience problems, try using option 'pci=noacpi' or even 'acpi=off'
PCI: Cannot allocate resource region 4 of device 0000:00:02.1
Simple Boot Flag at 0x3a set to 0x1
VFS: Disk quotas dquot_6.5.1
devfs: 2004-01-31 Richard Gooch (rgooch@atnf.csiro.au)
devfs: boot_options: 0x0
Initializing Cryptographic API
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
Serial: 8250/16550 driver $Revision: 1.90 $ 48 ports, IRQ sharing enabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
RAMDISK driver initialized: 16 RAM disks of 8192K size 1024 blocksize
serio: i8042 KBD port at 0x60,0x64 irq 1
input: AT Translated Set 2 keyboard on isa0060/serio0
NET: Registered protocol family 2
IP: routing cache hash table of 4096 buckets, 32Kbytes
TCP: Hash tables configured (established 32768 bind 32768)
NET: Registered protocol family 8
NET: Registered protocol family 20
ACPI: (supports S0 S1 S4 S5)
RAMDISK: cramfs filesystem found at block 0
RAMDISK: Loading 4144 blocks [1 disk] into ram disk...done.
VFS: Mounted root (cramfs filesystem) readonly.
Freeing unused kernel memory: 128k freed
NET: Registered protocol family 1
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
SIS5513: IDE controller at PCI slot 0000:00:02.5
SIS5513: chipset revision 0
SIS5513: not 100% native mode: will probe irqs later
SIS5513: SiS 962/963 MuTIOL IDE UDMA133 controller
    ide0: BM-DMA at 0xa400-0xa407, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xa408-0xa40f, BIOS settings: hdc:pio, hdd:pio
hda: ST3160023A, ATA DISK drive
Using anticipatory io scheduler
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hda: max request size: 1024KiB
hda: 312581808 sectors (160041 MB) w/8192KiB Cache, CHS=19457/255/63, UDMA(100)
 /dev/ide/host0/bus0/target0/lun0: p1 p2 p3 p4 < p5 p6 p7 p8 p9 p10 p11 p12 >
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
Adding 1959888k swap on /dev/hda11.  Priority:-1 extents:1
EXT3 FS on hda2, internal journal
Real Time Clock Driver v1.12
NET: Registered protocol family 17
sis900.c: v1.08.07 11/02/2003
eth0: VIA 6103 PHY transceiver found at address 1.
eth0: Using transceiver found at address 1 as default
eth0: SiS 900 PCI Fast Ethernet at 0x8800, IRQ 19, 00:0e:a6:06:d0:93.
i2c-sis96x version 1.0.0
sis96x smbus 0000:00:02.1: SiS96x SMBus base address: 0x1000
ttyS1: LSR safety check engaged!
ttyS1: LSR safety check engaged!
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hda1, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3-fs warning: maximal mount count reached, running e2fsck is recommended
EXT3 FS on hda3, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hda5, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hda6, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hda7, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hda8, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hda9, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hda10, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hda12, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
eth0: Media Link On 100mbps full-duplex 
NET: Registered protocol family 10
Disabled Privacy Extensions on device c02d8820(lo)
IPv6 over IPv4 tunneling driver
eth0: no IPv6 routers present

--alexm
