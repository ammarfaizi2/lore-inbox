Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266347AbTAYMID>; Sat, 25 Jan 2003 07:08:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266354AbTAYMID>; Sat, 25 Jan 2003 07:08:03 -0500
Received: from vsmtp1.tin.it ([212.216.176.221]:196 "EHLO smtp1.cp.tin.it")
	by vger.kernel.org with ESMTP id <S266347AbTAYMH6>;
	Sat, 25 Jan 2003 07:07:58 -0500
Message-ID: <3F61ABC3.1080502@tin.it>
Date: Fri, 12 Sep 2003 13:19:31 +0200
From: AnonimoVeneziano <voloterreno@tin.it>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021226 Debian/1.2.1-9
X-Accept-Language: en
MIME-Version: 1.0
To: LKML <linux-kernel@vger.kernel.org>
Subject: Probably buggy MP Table and ACPI doesn't works
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, I've compiled my kernel with Local APIC and IO-APIC function on a 
UniProcessor system (MSI KT4 Ultra + Athlon 2400+) and at the system 
start I see this (kernel 2.4.21-pre3-ac4 , but is similar with all the 
kernels) :

Linux version 2.4.21-pre3-ac4 (root@valinor) (gcc version 3.2.2 20030109 
(Debian prerelease)) #1 ven set 12 00:56:30 CEST 2003
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000001fff0000 (usable)
 BIOS-e820: 000000001fff0000 - 000000001fff8000 (ACPI data)
 BIOS-e820: 000000001fff8000 - 0000000020000000 (ACPI NVS)
 BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
 BIOS-e820: 00000000fff80000 - 0000000100000000 (reserved)
511MB LOWMEM available.
found SMP MP-table at 000fb930
hm, page 000fb000 reserved twice.
hm, page 000fc000 reserved twice.
hm, page 000f6000 reserved twice.
hm, page 000f7000 reserved twice.
On node 0 totalpages: 131056
zone(0): 4096 pages.
zone(1): 126960 pages.
zone(2): 0 pages.
Intel MultiProcessor Specification v1.4
    Virtual Wire compatibility mode.
OEM ID: VIA      Product ID: VT5440B      APIC at: 0xFEE00000
Processor #0 Pentium(tm) Pro APIC version 17
I/O APIC #2 Version 3 at 0xFEC00000.
Enabling APIC mode: Flat.    Using 1 I/O APICs
Processors: 1
Kernel command line: auto BOOT_IMAGE=Linux ro root=305 video=vesa:ywrap,mtrr
Initializing CPU#0
Detected 2000.130 MHz processor.
Console: colour dummy device 80x25
Calibrating delay loop... 3984.58 BogoMIPS
Memory: 516224k/524224k available (1192k kernel code, 7612k reserved, 
412k data, 104k init, 0k highmem)
Dentry cache hash table entries: 65536 (order: 7, 524288 bytes)
Inode cache hash table entries: 32768 (order: 6, 262144 bytes)
Mount cache hash table entries: 512 (order: 0, 4096 bytes)
Buffer cache hash table entries: 32768 (order: 5, 131072 bytes)
Page-cache hash table entries: 131072 (order: 7, 524288 bytes)
CPU: CLK_CTL MSR was 6003d22f. Reprogramming to 2003d22f
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 256K (64 bytes/line)
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU:     After generic, caps: 0383fbff c1c3fbff 00000000 00000000
CPU:             Common caps: 0383fbff c1c3fbff 00000000 00000000
CPU: AMD Athlon(tm) XP 2400+ stepping 01
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000080
ESR value after enabling vector: 00000000
ENABLING IO-APIC IRQs
Setting 2 in the phys_id_present_map
...changing IO-APIC physical APIC ID to 2 ... ok.
init IO_APIC IRQs
 IO-APIC (apicid-pin) 2-0, 2-5, 2-9, 2-10, 2-11, 2-17, 2-18, 2-20, 2-22, 
2-23 not connected.
..TIMER: vector=0x31 pin1=2 pin2=0
number of MP IRQ sources: 19.
number of IO-APIC #2 registers: 24.
testing the IO APIC.......................

IO APIC #2......
.... register #00: 02000000
.......    : physical APIC id: 02
.... register #01: 00178003
.......     : max redirection entries: 0017
.......     : PRQ implemented: 1
.......     : IO APIC version: 0003
An unexpected IO-APIC was found. If this kernel release is less than
three months old please report this to linux-smp@vger.kernel.org
.... IRQ redirection table:
 NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:  
 00 000 00  1    0    0   0   0    0    0    00
 01 001 01  0    0    0   0   0    1    1    39
 02 001 01  0    0    0   0   0    1    1    31
 03 001 01  0    0    0   0   0    1    1    41
 04 001 01  0    0    0   0   0    1    1    49
 05 000 00  1    0    0   0   0    0    0    00
 06 001 01  0    0    0   0   0    1    1    51
 07 001 01  0    0    0   0   0    1    1    59
 08 001 01  0    0    0   0   0    1    1    61
 09 000 00  1    0    0   0   0    0    0    00
 0a 000 00  1    0    0   0   0    0    0    00
 0b 000 00  1    0    0   0   0    0    0    00
 0c 001 01  0    0    0   0   0    1    1    69
 0d 001 01  0    0    0   0   0    1    1    71
 0e 001 01  0    0    0   0   0    1    1    79
 0f 001 01  0    0    0   0   0    1    1    81
 10 001 01  1    1    0   1   0    1    1    89
 11 000 00  1    0    0   0   0    0    0    00
 12 000 00  1    0    0   0   0    0    0    00
 13 001 01  1    1    0   1   0    1    1    91
 14 000 00  1    0    0   0   0    0    0    00
 15 001 01  1    1    0   1   0    1    1    99
 16 000 00  1    0    0   0   0    0    0    00
 17 000 00  1    0    0   0   0    0    0    00
IRQ to pin mappings:
IRQ0 -> 0:2
IRQ1 -> 0:1
IRQ3 -> 0:3
IRQ4 -> 0:4
IRQ6 -> 0:6
IRQ7 -> 0:7
IRQ8 -> 0:8
IRQ12 -> 0:12
IRQ13 -> 0:13
IRQ14 -> 0:14
IRQ15 -> 0:15
IRQ16 -> 0:16
IRQ19 -> 0:19
IRQ21 -> 0:21
.................................... done.
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 2000.2553 MHz.
..... host bus clock speed is 266.7008 MHz.
cpu: 0, clocks: 2667008, slice: 1333504
CPU0<T0:2667008,T1:1333504,D:0,S:1333504,C:2667008>
mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: Intel
PCI: PCI BIOS revision 2.10 entry at 0xfdaf1, last bus=1
PCI: Using configuration type 1
PCI: Probing PCI hardware
PCI: Using IRQ router default [1106/3177] at 00:11.0
PCI->APIC IRQ transform: (B0,I7,P0) -> 19
PCI->APIC IRQ transform: (B0,I12,P0) -> 16
PCI->APIC IRQ transform: (B0,I16,P0) -> 21
PCI->APIC IRQ transform: (B0,I16,P1) -> 21
PCI->APIC IRQ transform: (B0,I16,P2) -> 21
PCI->APIC IRQ transform: (B0,I16,P3) -> 21
PCI->APIC IRQ transform: (B1,I0,P0) -> 16
PCI: Via IRQ fixup for 00:10.2, from 10 to 5
PCI: Via IRQ fixup for 00:10.0, from 11 to 5
PnPBIOS: Found PnP BIOS installation structure at 0xc00f79a0
PnPBIOS: PnP BIOS version 1.0, entry 0xf0000:0x686b, dseg 0xf0000
PnPBIOS: 14 nodes reported by PnP BIOS; 14 recorded by driver
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
Starting kswapd
devfs: v1.12c (20020818) Richard Gooch (rgooch@atnf.csiro.au)
devfs: boot_options: 0x1
ACPI: Core Subsystem version [20011018]
ACPI: Subsystem enabled
vesafb: framebuffer at 0xd8000000, mapped to 0xe0807000, size 65536k
vesafb: mode is 1024x768x32, linelength=4096, pages=1
vesafb: protected mode interface info at c000:b7d0
vesafb: pmi: set display start = c00cb815, set palette = c00cb89a
vesafb: pmi: ports = 3b4 3b5 3ba 3c0 3c1 3c4 3c5 3c6 3c7 3c8 3c9 3cc 3ce 
3cf 3d0 3d1 3d2 3d3 3d4 3d5 3da
vesafb: scrolling: ywrap using protected mode interface, yres_virtual=16384
vesafb: directcolor: size=8:8:8:8, shift=24:16:8:0
Console: switching to colour frame buffer device 128x48
fb0: VESA VGA frame buffer device
pty: 256 Unix98 ptys configured
Real Time Clock Driver v1.10e
Uniform Multi-Platform E-IDE driver Revision: 7.00beta-2.4
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: IDE controller at PCI slot 00:11.1
PCI: No IRQ known for interrupt pin A of device 00:11.1. Probably buggy 
MP table.
VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: VIA vt8235 (rev 00) IDE UDMA133 controller on pci00:11.1
    ide0: BM-DMA at 0xfc00-0xfc07, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0xfc08-0xfc0f, BIOS settings: hdc:DMA, hdd:DMA
hda: QUANTUM FIREBALLP AS30.0, ATA DISK drive
hdb: MAXTOR 6L060J3, ATA DISK drive
hda: DMA disabled
blk: queue c02d8860, I/O limit 4095Mb (mask 0xffffffff)
hdb: DMA disabled
blk: queue c02d899c, I/O limit 4095Mb (mask 0xffffffff)
hdc: _NEC DV-5800A, ATAPI CD/DVD-ROM drive
hdd: Hewlett-Packard CD-Writer Plus 8100, ATAPI CD/DVD-ROM drive
hdc: DMA disabled
hdd: DMA disabled
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: host protected area => 1
hda: 58633344 sectors (30020 MB) w/1902KiB Cache, CHS=3649/255/63, UDMA(100)
hdb: host protected area => 1
hdb: 117266688 sectors (60041 MB) w/1819KiB Cache, CHS=7299/255/63, 
UDMA(133)
Partition check:
 /dev/ide/host0/bus0/target0/lun0: p1 p2 p3 < p5 p6 p7 p8 >
 /dev/ide/host0/bus0/target1/lun0: p1 p2 p3 < p5 > p4
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 4096 buckets, 32Kbytes
TCP: Hash tables configured (established 32768 bind 65536)
reiserfs: checking transaction log (device 03:05) ...
Using r5 hash to sort names
ReiserFS version 3.6.25
VFS: Mounted root (reiserfs filesystem) readonly.
Mounted devfs on /dev
Freeing unused kernel memory: 104k freed
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
Adding Swap: 506036k swap-space (priority -1)
Adding Swap: 506036k swap-space (priority -2)
IA-32 Microcode Update Driver: v1.11 <tigran@veritas.com>
i2c-core.o: i2c core module
8139too Fast Ethernet driver 0.9.26
eth0: RealTek RTL8139 Fast Ethernet at 0xe4952f00, 00:40:f4:55:a1:40, IRQ 19
eth0:  Identified 8139 chip type 'RTL-8139C'
Power Resource: found
Power Resource: found
Power Resource: found
Power Resource: found
ACPI: Power Button (FF) found
ACPI: Multiple power buttons detected, ignoring fixed-feature
ACPI: Power Button (CM) found
ACPI: Sleep Button (CM) found
ACPI: System firmware supports S0 S1 S4 S5
Processor[0]: C0 C1, 8 throttling states
Non-volatile memory driver v1.2
SCSI subsystem driver Revision: 1.00
scsi0 : SCSI host adapter emulation for IDE ATAPI devices
  Vendor: _NEC      Model: DV-5800A          Rev: 1.90
  Type:   CD-ROM                             ANSI SCSI revision: 02
  Vendor: HP        Model: CD-Writer+ 8100   Rev: 1.0g
  Type:   CD-ROM                             ANSI SCSI revision: 02
cmpci: version $Revision: 5.64 $ time 01:00:52 Sep 12 2003
cmpci: found CM8738 adapter at io 0xe800 irq 16
cmpci: chip version = 055
cmpci: Inverse SPDIF-in
cmpci: Enable SPDIF loop
arp_tables: (C) 2002 David S. Miller
ip_conntrack version 2.1 (4095 buckets, 32760 max) - 292 bytes per conntrack
ip_tables: (C) 2000-2002 Netfilter core team
ASSERT ip_conntrack_core.c:624 &ip_conntrack_lock not readlocked
ASSERT ip_conntrack_core.c:624 &ip_conntrack_lock not readlocked
parport0: PC-style at 0x378 (0x778) [PCSPP(,...)]
parport0: irq 7
ide: no cache flush required.
ide: no cache flush required.
ide: no cache flush required.
ide: no cache flush required.
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ 
SERIAL_PCI ISAPNP enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
ttyS01 at 0x02f8 (irq = 3) is a 16550A
reiserfs: checking transaction log (device 03:01) ...
Using r5 hash to sort names
ReiserFS version 3.6.25
reiserfs: checking transaction log (device 03:06) ...
Using r5 hash to sort names
ReiserFS version 3.6.25
reiserfs: checking transaction log (device 03:07) ...
Using r5 hash to sort names
ReiserFS version 3.6.25
reiserfs: checking transaction log (device 03:08) ...
Using r5 hash to sort names
ReiserFS version 3.6.25
Journalled Block Device driver loaded
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.19, 19 August 2002 on ide0(3,68), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.19, 19 August 2002 on ide0(3,69), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
ide: no cache flush required.
ide: no cache flush required.
eth0: Setting half-duplex based on auto-negotiated partner ability 0000.
 detected

What does mean buggy MP table on device 00.11.1 ?? (That is the IDE 
controller I think) In my bios I can select 1.4. and 1.1. MPS table, 
I've tried both but the situation doesn't change. This messsage is 
appeared recently , with the bios upgrade from 1.1 to 1.3. Doing lspci 
-vvvxxx I've noticed that the IRQ of 00.11.1 is routed to IRQ 0 .

And there is another problem. With IO-APIC activated in the kernel ACPI 
works in a strange way. I can't shutdown the system by pressing the 
 On/Off button, and when I do "shutdown -h now" the system instead to 
halt it reboots . I hear the HD that are Off, but the fans and the PSU 
remain  Switch On, after few seconds the HDs switch on again and the 
system restarts. Why??

If I disable IO-APIC and use Local APIC only ACPI works correctly, but I 
recive the message "spurious 8259A interrupt: IRQ7" during the boot or 
few time later after the boot. Should I disable APIC at all?? This 
problem of ACPI is present with 1.1 bios too

Thanks

Bye

Marcello



