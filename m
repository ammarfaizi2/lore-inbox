Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263806AbUGYKCp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263806AbUGYKCp (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jul 2004 06:02:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263815AbUGYKCp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jul 2004 06:02:45 -0400
Received: from smtp.dkm.cz ([62.24.64.34]:39952 "HELO smtp.dkm.cz")
	by vger.kernel.org with SMTP id S263806AbUGYKCb convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jul 2004 06:02:31 -0400
From: "Bc. Michal Semler" <cijoml@volny.cz>
Reply-To: cijoml@volny.cz
To: linux-kernel@vger.kernel.org
Subject: Re: 3C905 and ethtool
Date: Sun, 25 Jul 2004 12:02:28 +0200
User-Agent: KMail/1.6.2
References: <200407251016.22001.cijoml@volny.cz> <200407250528.56452.rpc@cafe4111.org>
In-Reply-To: <200407250528.56452.rpc@cafe4111.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 8BIT
Message-Id: <200407251202.28759.cijoml@volny.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

my computer is Dell workstation 400 with SMP support

# lspci
00:00.0 Host bridge: Intel Corp. 440FX - 82441FX PMC [Natoma] (rev 02)
00:0d.0 ISA bridge: Intel Corp. 82371SB PIIX3 ISA [Natoma/Triton II] (rev 01)
00:0d.1 IDE interface: Intel Corp. 82371SB PIIX3 IDE [Natoma/Triton II]
00:0d.2 USB Controller: Intel Corp. 82371SB PIIX3 USB [Natoma/Triton II] (rev 
01)
00:0e.0 PCI bridge: Digital Equipment Corporation DECchip 21152 (rev 02)
00:10.0 VGA compatible controller: Matrox Graphics, Inc. MGA 2164W [Millennium 
II]
00:11.0 Ethernet controller: 3Com Corporation 3c905B 100BaseTX [Cyclone] (rev 
30)
01:08.0 Ethernet controller: 3Com Corporation 3c905 100BaseTX [Boomerang]
01:09.0 Network controller: Harris Semiconductor Prism 2.5 Wavelan chipset 
(rev 01)
01:0b.0 SCSI storage controller: Adaptec AHA-2940U/UW/D / AIC-7881U

dmesg:
Linux version 2.4.26 (root@Liboc01) (gcc version 3.0.4) #2 SMP Thu Apr 15 
22:26:31 CEST 2004
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 00000000000a0000 (usable)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 0000000008000000 (usable)
 BIOS-e820: 00000000fec00000 - 00000000fec10000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee10000 (reserved)
 BIOS-e820: 00000000fff80000 - 0000000100000000 (reserved)
128MB LOWMEM available.
found SMP MP-table at 000fe710
hm, page 000fe000 reserved twice.
hm, page 000ff000 reserved twice.
hm, page 000f0000 reserved twice.
On node 0 totalpages: 32768
zone(0): 4096 pages.
zone(1): 28672 pages.
zone(2): 0 pages.
DMI not present.
ACPI: Unable to locate RSDP
Intel MultiProcessor Specification v1.4
    Virtual Wire compatibility mode.
OEM ID: DELL     Product ID: WS 400       APIC at: 0xFEE00000
Processor #0 Pentium(tm) Pro APIC version 17
Processor #1 Pentium(tm) Pro APIC version 17
I/O APIC #2 Version 17 at 0xFEC00000.
Enabling APIC mode: Flat.       Using 1 I/O APICs
Processors: 2
Kernel command line: auto BOOT_IMAGE=linux ro root=801 
video=matrox:vesa:0x1B8,depth:32 apm=smp apm=power-off
Initializing CPU#0
Detected 332.389 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 663.55 BogoMIPS
Memory: 126404k/131072k available (1813k kernel code, 4284k reserved, 425k 
data, 332k init, 0k highmem)
Dentry cache hash table entries: 16384 (order: 5, 131072 bytes)
Inode cache hash table entries: 8192 (order: 4, 65536 bytes)
Mount cache hash table entries: 512 (order: 0, 4096 bytes)
Buffer cache hash table entries: 8192 (order: 3, 32768 bytes)
Page-cache hash table entries: 32768 (order: 5, 131072 bytes)
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 512K
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU:     After generic, caps: 0183fbff 00000000 00000000 00000000
CPU:             Common caps: 0183fbff 00000000 00000000 00000000
Enabling fast FPU save and restore... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: Intel
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 512K
Intel machine check reporting enabled on CPU#0.
CPU:     After generic, caps: 0183fbff 00000000 00000000 00000000
CPU:             Common caps: 0183fbff 00000000 00000000 00000000
CPU0: Intel Pentium II (Deschutes) stepping 00
per-CPU timeslice cutoff: 1461.86 usecs.
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000040
ESR value after enabling vector: 00000000
Booting processor 1/1 eip 2000
Initializing CPU#1
masked ExtINT on CPU#1
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Calibrating delay loop... 663.55 BogoMIPS
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 512K
Intel machine check reporting enabled on CPU#1.
CPU:     After generic, caps: 0183fbff 00000000 00000000 00000000
CPU:             Common caps: 0183fbff 00000000 00000000 00000000
CPU1: Intel Pentium II (Deschutes) stepping 00
Total of 2 processors activated (1327.10 BogoMIPS).
ENABLING IO-APIC IRQs
Setting 2 in the phys_id_present_map
...changing IO-APIC physical APIC ID to 2 ... ok.
init IO_APIC IRQs
 IO-APIC (apicid-pin) 2-0, 2-2, 2-20, 2-21, 2-22, 2-23 not connected.
..TIMER: vector=0x31 pin1=-1 pin2=0
...trying to set up timer (IRQ0) through the 8259A ...
..... (found pin 0) ...works.
number of MP IRQ sources: 37.
number of IO-APIC #2 registers: 24.
testing the IO APIC.......................

IO APIC #2......
.... register #00: 02000000
.......    : physical APIC id: 02
.......    : Delivery Type: 0
.......    : LTS          : 0
.... register #01: 00170011
.......     : max redirection entries: 0017
.......     : PRQ implemented: 0
.......     : IO APIC version: 0011
.... register #02: 00000000
.......     : arbitration: 00
.... IRQ redirection table:
 NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:
 00 003 03  0    0    0   0   0    1    1    31
 01 003 03  0    0    0   0   0    1    1    39
 02 000 00  1    0    0   0   0    0    0    00
 03 003 03  0    0    0   0   0    1    1    41
 04 003 03  0    0    0   0   0    1    1    49
 05 003 03  0    0    0   0   0    1    1    51
 06 003 03  0    0    0   0   0    1    1    59
 07 003 03  0    0    0   0   0    1    1    61
 08 003 03  0    0    0   0   0    1    1    69
 09 003 03  0    0    0   0   0    1    1    71
 0a 003 03  0    0    0   0   0    1    1    79
 0b 003 03  0    0    0   0   0    1    1    81
 0c 003 03  0    0    0   0   0    1    1    89
 0d 003 03  0    0    0   0   0    1    1    91
 0e 003 03  0    0    0   0   0    1    1    99
 0f 003 03  0    0    0   0   0    1    1    A1
 10 003 03  1    1    0   1   0    1    1    A9
 11 003 03  1    1    0   1   0    1    1    B1
 12 003 03  1    1    0   1   0    1    1    B9
 13 003 03  1    1    0   1   0    1    1    C1
 14 000 00  1    0    0   0   0    0    0    00
 15 000 00  1    0    0   0   0    0    0    00
 16 000 00  1    0    0   0   0    0    0    00
 17 000 00  1    0    0   0   0    0    0    00
IRQ to pin mappings:
IRQ0 -> 0:0
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
.................................... done.
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 332.3765 MHz.
..... host bus clock speed is 66.4752 MHz.
cpu: 0, clocks: 664752, slice: 221584
CPU0<T0:664752,T1:443168,D:0,S:221584,C:664752>
cpu: 1, clocks: 664752, slice: 221584
CPU1<T0:664752,T1:221584,D:0,S:221584,C:664752>
checking TSC synchronization across CPUs: passed.
Waiting on wait_init_idle (map = 0x2)
All processors have done init_idle
PCI: PCI BIOS revision 2.10 entry at 0xfcbfe, last bus=1
PCI: Using configuration type 1
PCI: Probing PCI hardware
PCI: Probing PCI hardware (bus 00)
PCI->APIC IRQ transform: (B0,I13,P3) -> 19
PCI->APIC IRQ transform: (B0,I16,P0) -> 16
PCI->APIC IRQ transform: (B0,I17,P0) -> 17
PCI->APIC IRQ transform: (B1,I8,P0) -> 19
PCI->APIC IRQ transform: (B1,I9,P0) -> 19
PCI->APIC IRQ transform: (B1,I11,P0) -> 18
PCI: Cannot allocate resource region 4 of device 00:0d.1
Limiting direct PCI/PCI transfers.
Activating ISA DMA hang workarounds.
isapnp: Scanning for PnP cards...
isapnp: Card 'CS4236'
isapnp: 1 Plug & Play card detected total
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
IA-32 Microcode Update Driver: v1.14 <tigran@veritas.com>
apm: BIOS version 1.2 Flags 0x03 (Driver version 1.16)
Starting kswapd
VFS: Disk quotas vdquot_6.5.1
Journalled Block Device driver loaded
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
matroxfb: Matrox Millennium II (PCI) detected
matroxfb: MTRR's turned on
matroxfb: 1024x768x32bpp (virtual: 1024x1024)
matroxfb: framebuffer at 0xF8000000, mapped to 0xc8805000, size 4194304
Console: switching to colour frame buffer device 128x48
fb0: MATROX VGA frame buffer device
Detected PS/2 Mouse Port.
pty: 256 Unix98 ptys configured
keyboard: Timeout - AT keyboard not present?(ed)
keyboard: Timeout - AT keyboard not present?(f4)
Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ SERIAL_PCI 
ISAPNP enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
ttyS01 at 0x02f8 (irq = 3) is a 16550A
Floppy drive(s): fd0 is 1.44M
FDC 0 is a National Semiconductor PC87306
3c59x: Donald Becker and others. www.scyld.com/network/vortex.html
See Documentation/networking/vortex.txt
00:11.0: 3Com PCI 3c905B Cyclone 100baseTx at 0xec00. Vers LK1.1.18-ac
 00:50:04:0b:73:4a, IRQ 17
  product code 5451 rev 00.12 date 01-08-99
  Internal config register is 1800000, transceivers 0xa.
  8K byte-wide RAM 5:3 Rx:Tx split, autoselect/Autonegotiate interface.
  MII transceiver found at address 24, status 786d.
  Enabling bus-master transmits and whole-frame receives.
00:11.0: scatter/gather enabled. h/w checksums enabled
See Documentation/networking/vortex.txt
01:08.0: 3Com PCI 3c905 Boomerang 100baseTx at 0xfcc0. Vers LK1.1.18-ac
 00:c0:4f:a2:ed:0e, IRQ 19
  product code 0000 rev 00.0 date 07-03-97
  Internal config register is 1630218, transceivers 0xe040.
  8K word-wide RAM 3:5 Rx:Tx split, autoselect/MII interface.
  MII transceiver found at address 24, status 786f.
  Enabling bus-master transmits and whole-frame receives.
01:08.0: scatter/gather enabled. h/w checksums disabled
eth1: Dropping NETIF_F_SG since no checksum feature.
Uniform Multi-Platform E-IDE driver Revision: 7.00beta4-2.4
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
PIIX3: IDE controller at PCI slot 00:0d.1
PIIX3: chipset revision 0
PIIX3: not 100% native mode: will probe irqs later
PIIX3: neither IDE port enabled (BIOS)
SCSI subsystem driver Revision: 1.00
scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.36
        <Adaptec 2940 Ultra SCSI adapter>
        aic7880: Ultra Wide Channel A, SCSI Id=7, 16/253 SCBs

(scsi0:A:0): 40.000MB/s transfers (20.000MHz, offset 8, 16bit)
  Vendor: WDIGTL    Model: WDE4360-1807A3    Rev: 1.80
  Type:   Direct-Access                      ANSI SCSI revision: 02
(scsi0:A:5): 10.000MB/s transfers (10.000MHz, offset 15)
  Vendor: NEC       Model: CD-ROM DRIVE:464  Rev: 1.05
  Type:   CD-ROM                             ANSI SCSI revision: 02
scsi0:A:0:0: Tagged Queuing enabled.  Depth 253
Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
SCSI device sda: 8388314 512-byte hdwr sectors (4295 MB)
Partition check:
 sda: sda1 sda2
usb.c: registered new driver usbdevfs
usb.c: registered new driver hub
host/usb-uhci.c: $Revision: 1.275 $ time 22:27:50 Apr 15 2004
host/usb-uhci.c: High bandwidth mode enabled
host/usb-uhci.c: USB UHCI at I/O 0xece0, IRQ 19
host/usb-uhci.c: Detected 2 ports
usb.c: new USB bus registered, assigned bus number 1
hub.c: USB hub found
hub.c: 2 ports detected
host/usb-uhci.c: v1.275:USB Universal Host Controller Interface driver
Initializing Cryptographic API
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 1024 buckets, 8Kbytes
TCP: Hash tables configured (established 8192 bind 8192)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 332k freed
Adding Swap: 192772k swap-space (priority -1)
EXT3 FS 2.4-0.9.19, 19 August 2002 on sd(8,1), internal journal
Real Time Clock Driver v1.10f
ip_conntrack version 2.1 (1024 buckets, 8192 max) - 288 bytes per conntrack
ip_tables: (C) 2000-2002 Netfilter core team
hostap_crypt: registered algorithm 'NULL'
hostap_pci: 0.1.3 - 2004-02-08 (Jouni Malinen <jkmaline@cc.hut.fi>)
hostap_pci: Registered netdevice wlan0
wlan0: trying to read PDA from 0x007f0000: OK
wlan0: NIC: id=0x8013 v1.0.0
wlan0: PRI: id=0x15 v1.1.1
wlan0: STA: id=0x1f v1.8.0
wlan0: Intersil Prism2.5 PCI: mem=0xfafff000, irq=19
hostap_crypt: registered algorithm 'WEP'


Dne ne 25. èervence 2004 11:28 Rob Couto napsal(a):
> On Sunday 25 July 2004 04:16 am, Bc. Michal Semler wrote:
> > Hi,
> >
> > I wanted to get info about my NIC via ethtool, but it writes:
> > # ethtool eth0
> > Cannot get device settings: Operation not supported
> > # ethtool eth1
> > Cannot get device settings: Operation not supported
> >
> > 00:11.0 Ethernet controller: 3Com Corporation 3c905B 100BaseTX [Cyclone]
> > (rev 30)
> > 01:08.0 Ethernet controller: 3Com Corporation 3c905 100BaseTX [Boomerang]
>
> what are the odds!? look at this...
> (slackware 10, 2.4.26 with only Win4Lin patch)
>
> bash-2.05b# lspci
> 00:00.0 Host bridge: Intel Corp. 82815 815 Chipset Host Bridge and Memory
> Controller Hub (rev 02)
> 00:01.0 PCI bridge: Intel Corp. 82815 815 Chipset AGP Bridge (rev 02)
> 00:1e.0 PCI bridge: Intel Corp. 82801BA/CA/DB/EB/ER Hub interface to PCI
> Bridge (rev 02)
> 00:1f.0 ISA bridge: Intel Corp. 82801BA ISA Bridge (LPC) (rev 02)
> 00:1f.1 IDE interface: Intel Corp. 82801BA IDE U100 (rev 02)
> 00:1f.2 USB Controller: Intel Corp. 82801BA/BAM USB (Hub #1) (rev 02)
> 00:1f.3 SMBus: Intel Corp. 82801BA/BAM SMBus (rev 02)
> 00:1f.4 USB Controller: Intel Corp. 82801BA/BAM USB (Hub #2) (rev 02)
> 01:00.0 VGA compatible controller: ATI Technologies Inc 3D Rage Pro AGP
> 1X/2X (rev 5c)
> 02:04.0 Ethernet controller: 3Com Corporation 3c905 100BaseTX [Boomerang]
> 02:07.0 Ethernet controller: 3Com Corporation 3c905B 100BaseTX [Cyclone]
> (rev 64)
> 02:0a.0 RAID bus controller: Promise Technology, Inc. 20265 (rev 02)
> bash-2.05b# ethtool eth0
> Settings for eth0:
> No data available
> bash-2.05b# ethtool eth1
> Settings for eth1:
> No data available
