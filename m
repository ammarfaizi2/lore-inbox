Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264690AbTFASFh (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Jun 2003 14:05:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264689AbTFASFh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Jun 2003 14:05:37 -0400
Received: from chaos.analogic.com ([204.178.40.224]:11148 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S264029AbTFASFV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Jun 2003 14:05:21 -0400
Date: Sun, 1 Jun 2003 14:21:32 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: DevilKin-LKML <devilkin-lkml@blindguardian.org>
cc: LKML <linux-kernel@vger.kernel.org>, SMP <linux-smp@vger.kernel.org>
Subject: Re: Hyper-threading
In-Reply-To: <200306011849.42654.devilkin-lkml@blindguardian.org>
Message-ID: <Pine.LNX.4.53.0306011419010.11852@chaos>
References: <Pine.LNX.4.53.0306011245090.11595@chaos>
 <200306011849.42654.devilkin-lkml@blindguardian.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 1 Jun 2003, DevilKin-LKML wrote:

> On Sunday 01 June 2003 18:46, Richard B. Johnson wrote:
> > Hello,
> >
> > Anybody know how to enable hyperthreading? I
> > have an ABIT IC7-G motherboard (absolute garbage)
> > with a Phoenix AwardBIOS. They don't provide
> > any BIOS upgrades and say you have to contact
> > the board vendor. ABIT doesn't answer email
> > and www.abit.com ends up being answered by
> > www.motherboards.com that doesn't provide
> > any support.
>
> Please check http://www.abit-usa.com, or http://www.abit.com.tw.
>
> Jan
> --


Okay. Thanks to you all for the site info. The two US sites
refused connections, but Tiwan worked.

I downloaded the latest, compiled May, 19, 2003. BIOS
release 1.3.

This converted the motherboard into a DOS-only machine.
It would not boot Linux much beyond the LILO prompt  but
it would boot DOS off from a floppy fine.

There was nothing in the BIOS setup to enable or disable
hyper-threading. There was some junk about enabling
'ultra', 'turbo' and 'fast'. If 'turbo' was enabled,
I was able to boot Linux-2.4.20. This is the dmesg
output. It will not boot in any other 'position'.

Linux version 2.4.20 (root@skunkworks.analogic.com) (gcc version 3.2.2 20030222 (Red Hat Linux 3.2.2-5)) #10 SMP Sun Jun 1 11:55:01 EDT 2003
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009f800 (usable)
 BIOS-e820: 000000000009f800 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000007fff0000 (usable)
 BIOS-e820: 000000007fff0000 - 000000007fff3000 (ACPI NVS)
 BIOS-e820: 000000007fff3000 - 0000000080000000 (ACPI data)
 BIOS-e820: 00000000fec00000 - 0000000100000000 (reserved)
1151MB HIGHMEM available.
896MB LOWMEM available.
found SMP MP-table at 000f5ce0
hm, page 000f5000 reserved twice.
hm, page 000f6000 reserved twice.
hm, page 000f0000 reserved twice.
hm, page 000f1000 reserved twice.
On node 0 totalpages: 524272
zone(0): 4096 pages.
zone(1): 225280 pages.
zone(2): 294896 pages.
ACPI: Searched entire block, no RSDP was found.
ACPI: RSDP located at physical address c00f7b10
RSD PTR  v0 [IntelR]
__va_range(0x7fff3000, 0x68): idx=8 mapped at ffff6000
ACPI table found: RSDT v1 [IntelR AWRDACPI 16944.11825]
__va_range(0x7fff3040, 0x24): idx=8 mapped at ffff6000
__va_range(0x7fff3040, 0x74): idx=8 mapped at ffff6000
ACPI table found: FACP v1 [IntelR AWRDACPI 16944.11825]
__va_range(0x7fff7b80, 0x24): idx=8 mapped at ffff6000
__va_range(0x7fff7b80, 0x68): idx=8 mapped at ffff6000
ACPI table found: APIC v1 [IntelR AWRDACPI 16944.11825]
__va_range(0x7fff7b80, 0x68): idx=8 mapped at ffff6000
LAPIC (acpi_id[0x0000] id[0x0] enabled[1])
CPU 0 (0x0000) enabledProcessor #0 Pentium 4(tm) XEON(tm) APIC version 16

LAPIC (acpi_id[0x0001] id[0x1] enabled[0])
CPU 1 (0x0100) disabled
IOAPIC (id[0x2] address[0xfec00000] global_irq_base[0x0])
INT_SRC_OVR (bus[0] irq[0x0] global_irq[0x2] polarity[0x0] trigger[0x0])
INT_SRC_OVR (bus[0] irq[0x9] global_irq[0x9] polarity[0x1] trigger[0x3])
LAPIC_NMI (acpi_id[0x0000] polarity[0x1] trigger[0x1] lint[0x1])
LAPIC_NMI (acpi_id[0x0001] polarity[0x1] trigger[0x1] lint[0x1])
2 CPUs total
Local APIC address fee00000
Enabling the CPU's according to the ACPI table
Intel MultiProcessor Specification v1.4
    Virtual Wire compatibility mode.
OEM ID: OEM00000 Product ID: PROD00000000 APIC at: 0xFEE00000
I/O APIC #2 Version 17 at 0xFEC00000.
Processors: 1
Kernel command line: auto BOOT_IMAGE=linux-2.4.20 ro root=802 BOOT_FILE=/boot/vmlinuz-2.4.20
Initializing CPU#0
Detected 2672.778 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 5334.63 BogoMIPS
Memory: 2069136k/2097088k available (1366k kernel code, 27564k reserved, 474k data, 148k init, 1179584k highmem)
Dentry cache hash table entries: 262144 (order: 9, 2097152 bytes)
Inode cache hash table entries: 131072 (order: 8, 1048576 bytes)
Mount-cache hash table entries: 32768 (order: 6, 262144 bytes)
Buffer-cache hash table entries: 131072 (order: 7, 524288 bytes)
Page-cache hash table entries: 524288 (order: 9, 2097152 bytes)
CPU: L1 I cache: 0K, L1 D cache: 8K
CPU: L2 cache: 512K
CPU: Hyper-Threading is disabled
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU:     After generic, caps: bfebfbff 00000000 00000000 00000000
CPU:             Common caps: bfebfbff 00000000 00000000 00000000
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: Intel
CPU: L1 I cache: 0K, L1 D cache: 8K
CPU: L2 cache: 512K
CPU: Hyper-Threading is disabled
Intel machine check reporting enabled on CPU#0.
CPU:     After generic, caps: bfebfbff 00000000 00000000 00000000
CPU:             Common caps: bfebfbff 00000000 00000000 00000000
CPU0: Intel(R) Pentium(R) 4 CPU 2.66GHz stepping 07
per-CPU timeslice cutoff: 1463.20 usecs.
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Error: only one processor found.
ENABLING IO-APIC IRQs
Setting 2 in the phys_id_present_map
...changing IO-APIC physical APIC ID to 2 ... ok.
init IO_APIC IRQs
 IO-APIC (apicid-pin) 2-0, 2-5, 2-9, 2-10, 2-11, 2-14, 2-15, 2-20 not connected.
..TIMER: vector=0x31 pin1=2 pin2=0
number of MP IRQ sources: 24.
number of IO-APIC #2 registers: 24.
testing the IO APIC.......................

IO APIC #2......
.... register #00: 02000000
.......    : physical APIC id: 02
.... register #01: 00178020
.......     : max redirection entries: 0017
.......     : PRQ implemented: 1
.......     : IO APIC version: 0020
.... register #02: 00178020
.......     : arbitration: 00
 WARNING: unexpected IO-APIC, please mail
          to linux-smp@vger.kernel.org
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
 0e 000 00  1    0    0   0   0    0    0    00
 0f 000 00  1    0    0   0   0    0    0    00
 10 001 01  1    1    0   1   0    1    1    79
 11 001 01  1    1    0   1   0    1    1    81
 12 001 01  1    1    0   1   0    1    1    89
 13 001 01  1    1    0   1   0    1    1    91
 14 000 00  1    0    0   0   0    0    0    00
 15 001 01  1    1    0   1   0    1    1    99
 16 001 01  1    1    0   1   0    1    1    A1
 17 001 01  1    1    0   1   0    1    1    A9
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
IRQ16 -> 0:16
IRQ17 -> 0:17
IRQ18 -> 0:18
IRQ19 -> 0:19
IRQ21 -> 0:21
IRQ22 -> 0:22
IRQ23 -> 0:23
.................................... done.
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 2672.7802 MHz.
..... host bus clock speed is 133.6388 MHz.
cpu: 0, clocks: 1336388, slice: 668194
CPU0<T0:1336384,T1:668176,D:14,S:668194,C:1336388>
Waiting on wait_init_idle (map = 0x0)
All processors have done init_idle
PCI: PCI BIOS revision 2.10 entry at 0xfbb50, last bus=2
PCI: Using configuration type 1
PCI: Probing PCI hardware
Transparent bridge - Intel Corp. 82801BA/CA/DB PCI Bridge
PCI: Using IRQ router PIIX [8086/24d0] at 00:1f.0
PCI->APIC IRQ transform: (B0,I29,P0) -> 16
PCI->APIC IRQ transform: (B0,I29,P1) -> 19
PCI->APIC IRQ transform: (B0,I29,P2) -> 18
PCI->APIC IRQ transform: (B0,I29,P0) -> 16
PCI->APIC IRQ transform: (B0,I29,P3) -> 23
PCI->APIC IRQ transform: (B0,I31,P1) -> 17
PCI->APIC IRQ transform: (B0,I31,P1) -> 17
PCI->APIC IRQ transform: (B1,I0,P0) -> 16
PCI->APIC IRQ transform: (B2,I2,P0) -> 18
PCI->APIC IRQ transform: (B2,I5,P0) -> 21
PCI->APIC IRQ transform: (B2,I6,P0) -> 22
PCI->APIC IRQ transform: (B2,I7,P0) -> 23
PCI->APIC IRQ transform: (B2,I9,P0) -> 17
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
apm: BIOS not found.
Starting kswapd
allocated 32 pages and 32 bhs reserved for the highmem bounces
VFS: Diskquotas version dquot_6.4.0 initialized
pty: 2048 Unix98 ptys configured
Serial driver version 5.05c (2001-07-08) with MANY_PORTS MULTIPORT SHARE_IRQ SERIAL_PCI ISAPNP enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
ttyS01 at 0x02f8 (irq = 3) is a 16550A
Real Time Clock Driver v1.10e
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ide-floppy driver 0.99.newide
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
NET4: Frame Diverter 0.46
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
ide-floppy driver 0.99.newide
md: md driver 0.90.0 MAX_MD_DEVS=256, MD_SB_DISKS=27
md: Autodetecting RAID arrays.
md: autorun ...
md: ... autorun DONE.
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 16384 buckets, 128Kbytes
TCP: Hash tables configured (established 262144 bind 65536)
Linux IP multicast router 0.06 plus PIM-SM
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
RAMDISK: Compressed image found at block 0
Freeing initrd memory: 267k freed
VFS: Mounted root (ext2 filesystem).
SCSI subsystem driver Revision: 1.00
scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.8
        <Adaptec 2930 Ultra2 SCSI adapter>
        aic7890/91: Ultra2 Wide Channel A, SCSI Id=7, 32/253 SCBs

blk: queue f7bc1418, I/O limit 4095Mb (mask 0xffffffff)
  Vendor: SEAGATE   Model: ST118273LW        Rev: 6246
  Type:   Direct-Access                      ANSI SCSI revision: 02
blk: queue f7bc1218, I/O limit 4095Mb (mask 0xffffffff)
  Vendor: PLEXTOR   Model: CD-R   PX-W1210S  Rev: 1.05
  Type:   CD-ROM                             ANSI SCSI revision: 02
blk: queue f76a7818, I/O limit 4095Mb (mask 0xffffffff)
scsi0:A:0:0: Tagged Queuing enabled.  Depth 253
Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
(scsi0:A:0): 80.000MB/s transfers (40.000MHz, offset 15, 16bit)
SCSI device sda: 35566480 512-byte hdwr sectors (18210 MB)
Partition check:
 sda: sda1 sda2 sda3
Journalled Block Device driver loaded
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
Freeing unused kernel memory: 148k freed
usb.c: registered new driver usbdevfs
usb.c: registered new driver hub
usb-uhci.c: $Revision: 1.275 $ time 18:06:45 May  7 2003
usb-uhci.c: High bandwidth mode enabled
PCI: Setting latency timer of device 00:1d.0 to 64
usb-uhci.c: USB UHCI at I/O 0xac00, IRQ 16
usb-uhci.c: Detected 2 ports
usb.c: new USB bus registered, assigned bus number 1
hub.c: USB hub found
hub.c: 2 ports detected
PCI: Setting latency timer of device 00:1d.1 to 64
usb-uhci.c: USB UHCI at I/O 0xa000, IRQ 19
usb-uhci.c: Detected 2 ports
usb.c: new USB bus registered, assigned bus number 2
hub.c: USB hub found
hub.c: 2 ports detected
PCI: Setting latency timer of device 00:1d.2 to 64
usb-uhci.c: USB UHCI at I/O 0xa400, IRQ 18
usb-uhci.c: Detected 2 ports
usb.c: new USB bus registered, assigned bus number 3
hub.c: USB hub found
hub.c: 2 ports detected
PCI: Setting latency timer of device 00:1d.3 to 64
usb-uhci.c: USB UHCI at I/O 0xa800, IRQ 16
usb-uhci.c: Detected 2 ports
usb.c: new USB bus registered, assigned bus number 4
hub.c: USB hub found
hub.c: 2 ports detected
usb-uhci.c: v1.275:USB Universal Host Controller Interface driver
PCI: Setting latency timer of device 00:1d.7 to 64
hcd.c: ehci-hcd @ 00:1d.7, PCI device 8086:24dd (Intel Corp.)
hcd.c: irq 23, pci mem f8896000
usb.c: new USB bus registered, assigned bus number 5
ehci-hcd.c: restricting 64bit DMA mappings to segment 0 ...
ehci-hcd.c: USB 2.0 support enabled, EHCI rev 1. 0
hub.c: USB hub found
hub.c: 8 ports detected
usb.c: registered new driver hiddev
usb.c: registered new driver hid
hid-core.c: v1.8.1 Andreas Gal, Vojtech Pavlik <vojtech@suse.cz>
hid-core.c: USB HID support drivers
mice: PS/2 mouse device common for all mice
EXT3 FS 2.4-0.9.19, 19 August 2002 on sd(8,2), internal journal
Adding Swap: 2040244k swap-space (priority -1)
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.19, 19 August 2002 on sd(8,1), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
ohci1394: $Rev: 578 $ Ben Collins <bcollins@debian.org>
ohci1394_0: OHCI-1394 1.1 (PCI): IRQ=[18]  MMIO=[f6126000-f61267ff]  Max Packet=[2048]
ieee1394: Device added: Node[00:1023]  GUID[0010b90101319602]  [Maxtor  ]
ieee1394: Host added: Node[01:1023]  GUID[00508d0000fcc3a0]  [Linux OHCI-1394]
ieee1394: sbp2: Logged into SBP-2 device
ieee1394: sbp2: Node[00:1023]: Max speed [S400] - Max payload [2048]
scsi1 : IEEE-1394 SBP-2 protocol driver (host: ohci1394)
$Rev: 584 $ James Goodwin <jamesg@filanet.com>
SBP-2 module load options:
- Max speed supported: S400
- Max sectors per I/O supported: 255
- Max outstanding commands supported: 8
- Max outstanding commands per lun supported: 1
- Serialized I/O (debug): no
- Exclusive login: yes
  Vendor: Maxtor    Model: 1394 storage      Rev: v1.3
  Type:   Direct-Access                      ANSI SCSI revision: 06
Attached scsi disk sdb at scsi1, channel 0, id 0, lun 0
SCSI device sdb: 320173056 512-byte hdwr sectors (163929 MB)
 sdb: sdb1
parport0: PC-style at 0x378 [PCSPP,TRISTATE]
Attached scsi CD-ROM sr0 at scsi0, channel 0, id 4, lun 0
(scsi0:A:4): 20.000MB/s transfers (20.000MHz, offset 16)
sr0: scsi3-mmc drive: 32x/32x writer cd/rw xa/form2 cdda tray
Uniform CD-ROM driver Revision: 3.12
ip_tables: (C) 2000-2002 Netfilter core team
eepro100.c:v1.09j-t 9/29/99 Donald Becker http://www.scyld.com/network/eepro100.html
eepro100.c: $Revision: 1.36 $ 2000/11/17 Modified by Andrey V. Savochkin <saw@saw.sw.com.sg> and others
divert: allocating divert_blk for eth0
eth0: Intel Corp. 82557/8/9 [Ethernet Pro 100], 00:02:B3:BC:58:27, IRQ 21.
  Board assembly 751767-004, Physical connectors present: RJ45
  Primary interface chip i82555 PHY #1.
    Secondary interface chip i82555.
  General self-test: passed.
  Serial sub-system self-test: passed.
  Internal registers self-test: passed.
  ROM checksum self-test: passed (0x3258698e).
divert: allocating divert_blk for eth1
eth1: Intel Corp. 82557/8/9 [Ethernet Pro 100] (#2), 00:02:B3:03:36:A6, IRQ 22.
  Board assembly 721383-016, Physical connectors present: RJ45
  Primary interface chip i82555 PHY #1.
  General self-test: passed.
  Serial sub-system self-test: passed.
  Internal registers self-test: passed.
  ROM checksum self-test: passed (0x04f4518b).
ip_tables: (C) 2000-2002 Netfilter core team
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
parport0: PC-style at 0x378 [PCSPP,TRISTATE]
lp0: using parport0 (polling).
lp0: console ready

Cheers,
Dick Johnson
Penguin : Linux version 2.4.20 on an i686 machine (797.90 BogoMips).
Why is the government concerned about the lunatic fringe? Think about it.

