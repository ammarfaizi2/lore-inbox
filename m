Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313189AbSERPVj>; Sat, 18 May 2002 11:21:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313190AbSERPVi>; Sat, 18 May 2002 11:21:38 -0400
Received: from pointblue.com.pl ([62.121.131.135]:23046 "EHLO pointblue.com.pl")
	by vger.kernel.org with ESMTP id <S313189AbSERPVf>;
	Sat, 18 May 2002 11:21:35 -0400
Subject: Re: ata + ide cdrom problem, off group - answers to private addr
From: Grzegorz Jaskiewicz <gj@pointblue.com.pl>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <E1795SM-00008D-00@the-village.bc.nu>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 18 May 2002 17:20:25 +0000
Message-Id: <1021742427.18456.23.camel@blizniaki.gj.pl>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2002-05-18 at 14:45, Alan Cox wrote:
> > 00:09.0 RAID bus controller: CMD Technology Inc PCI0680 (rev 01)
> > dmesg and others on demand.
> 
> dmesg and full lspci would be useful yes. 

i did't want to polute list :-)
but...


there you go:
lspci -v -t 

00:02.0 "Non-VGA unclassified device" "Intel Corp." "82375EB" -r05 "" ""
00:08.0 "Multimedia audio controller" "Ensoniq" "ES1371 [AudioPCI-97]"
-r08 "Ensoniq" "Creative Sound Blaster AudioPCI64V, AudioPCI128"
00:09.0 "RAID bus controller" "CMD Technology Inc" "PCI0680" -r01 "CMD
Technology Inc" "0680"
00:0a.0 "VGA compatible controller" "3Dfx Interactive, Inc." "Voodoo 3"
-r01 "3Dfx Interactive, Inc." "Voodoo3"
00:0b.0 "Ethernet controller" "Realtek Semiconductor Co., Ltd."
"RTL-8029(AS)" "Realtek Semiconductor Co., Ltd." "RT8029(AS)"
00:14.0 "RAM memory" "Intel Corp." "450KX/GX [Orion] - 82453KX/GX Memory
controller" -r04 "" ""
00:19.0 "Host bridge" "Intel Corp." "450KX/GX [Orion] - 82454KX/GX PCI
bridge" -r04 "" ""
00:02.0 Non-VGA unclassified device: Intel Corp. 82375EB (rev 05)
        Flags: bus master, medium devsel, latency 248

00:08.0 Multimedia audio controller: Ensoniq ES1371 [AudioPCI-97] (rev
08)
        Subsystem: Ensoniq Creative Sound Blaster AudioPCI64V,
AudioPCI128
        Flags: bus master, slow devsel, latency 72, IRQ 5
        I/O ports at ff00 [size=64]
        Capabilities: [dc] Power Management version 1

00:09.0 RAID bus controller: CMD Technology Inc PCI0680 (rev 01)
        Subsystem: CMD Technology Inc: Unknown device 3680
        Flags: bus master, medium devsel, latency 64, IRQ 12
        I/O ports at fe00 [size=8]
        I/O ports at fd00 [size=4]
        I/O ports at fc00 [size=8]
        I/O ports at fb00 [size=4]
        I/O ports at fa00 [size=16]
        Memory at fbfff000 (32-bit, non-prefetchable) [size=256]
        Expansion ROM at <unassigned> [disabled] [size=512K]
        Capabilities: [60] Power Management version 2

00:0a.0 VGA compatible controller: 3Dfx Interactive, Inc. Voodoo 3 (rev
01) (prog-if 00 [VGA])
        Subsystem: 3Dfx Interactive, Inc. Voodoo3
        Flags: fast devsel, IRQ 10
        Memory at f8000000 (32-bit, non-prefetchable) [size=32M]
        Memory at f6000000 (32-bit, prefetchable) [size=32M]
        I/O ports at f900 [size=256]
        Expansion ROM at <unassigned> [disabled] [size=64K]
        Capabilities: [60] Power Management version 1

00:0b.0 Ethernet controller: Realtek Semiconductor Co., Ltd.
RTL-8029(AS)
        Subsystem: Realtek Semiconductor Co., Ltd. RT8029(AS)
        Flags: medium devsel, IRQ 11
        I/O ports at f800 [size=32]

00:14.0 RAM memory: Intel Corp. 450KX/GX [Orion] - 82453KX/GX Memory
controller (rev 04)
        Flags: fast devsel

00:19.0 Host bridge: Intel Corp. 450KX/GX [Orion] - 82454KX/GX PCI
bridge (rev 04)
        Flags: bus master, medium devsel, latency 32



dmesg:
Linux version 2.4.18-0.13custom (root@some.pl) (gcc version 2.96
20000731 (Red Hat Linux 7.2 2.96-109)) #1 SMP Sat Apr 20 19:38:29 CEST
2002
BIOS-provided physical RAM map:
 BIOS-88: 0000000000000000 - 000000000009f000 (usable)
 BIOS-88: 0000000000100000 - 0000000004000000 (usable)
found SMP MP-table at 000fc690
hm, page 000fc000 reserved twice.
hm, page 000fd000 reserved twice.
hm, page 000fc000 reserved twice.
hm, page 000fd000 reserved twice.
On node 0 totalpages: 16384
zone(0): 4096 pages.
zone(1): 12288 pages.
zone(2): 0 pages.
Intel MultiProcessor Specification v1.1
    Virtual Wire compatibility mode.
OEM ID: OEM12345 Product ID: PROD12345678 APIC at: 0xFEE00000
Processor #0 Pentium(tm) Pro APIC version 16
Processor #1 Pentium(tm) Pro APIC version 16
I/O APIC #2 Version 17 at 0xFEC00000.
Processors: 2
Kernel command line: BOOT_IMAGE=l ro root=304 BOOT_FILE=/boot/linux.gj
hdb=ide-scsi
ide_setup: hdb=ide-scsi
Initializing CPU#0
Detected 199.949 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 398.95 BogoMIPS
Memory: 60640k/65536k available (2104k kernel code, 4508k reserved, 424k
data, 308k init, 0k highmem)
Dentry cache hash table entries: 8192 (order: 4, 65536 bytes)
Inode cache hash table entries: 4096 (order: 3, 32768 bytes)
Mount-cache hash table entries: 1024 (order: 1, 8192 bytes)
Buffer cache hash table entries: 4096 (order: 2, 16384 bytes)
Page-cache hash table entries: 16384 (order: 4, 65536 bytes)
CPU: Before vendor init, caps: 0000fbff 00000000 00000000, vendor = 0
CPU: L1 I cache: 8K, L1 D cache: 8K
CPU: L2 cache: 256K
CPU: After vendor init, caps: 0000fbff 00000000 00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU:     After generic, caps: 0000fbff 00000000 00000000 00000000
CPU:             Common caps: 0000fbff 00000000 00000000 00000000
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: Intel
CPU: Before vendor init, caps: 0000fbff 00000000 00000000, vendor = 0
CPU: L1 I cache: 8K, L1 D cache: 8K
CPU: L2 cache: 256K
CPU: After vendor init, caps: 0000fbff 00000000 00000000 00000000
Intel machine check reporting enabled on CPU#0.
CPU:     After generic, caps: 0000fbff 00000000 00000000 00000000
CPU:             Common caps: 0000fbff 00000000 00000000 00000000
CPU0: Intel Pentium Pro stepping 07
per-CPU timeslice cutoff: 733.92 usecs.
task migration cache decay timeout: 10 msecs.
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Booting processor 1/1 eip 2000
Initializing CPU#1
masked ExtINT on CPU#1
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Calibrating delay loop... 399.76 BogoMIPS
CPU: Before vendor init, caps: 0000fbff 00000000 00000000, vendor = 0
CPU: L1 I cache: 8K, L1 D cache: 8K
CPU: L2 cache: 256K
CPU: After vendor init, caps: 0000fbff 00000000 00000000 00000000
Intel machine check reporting enabled on CPU#1.
CPU:     After generic, caps: 0000fbff 00000000 00000000 00000000
CPU:             Common caps: 0000fbff 00000000 00000000 00000000
CPU1: Intel Pentium Pro stepping 07
Total of 2 processors activated (798.72 BogoMIPS).
ENABLING IO-APIC IRQs
Setting 2 in the phys_id_present_map
...changing IO-APIC physical APIC ID to 2 ... ok.
init IO_APIC IRQs
 IO-APIC (apicid-pin) 2-0 not connected.
..TIMER: vector=0x31 pin1=2 pin2=0
number of MP IRQ sources: 16.
number of IO-APIC #2 registers: 16.
testing the IO APIC.......................

IO APIC #2......
.... register #00: 02000000
.......    : physical APIC id: 02
.... register #01: 000F0011
.......     : max redirection entries: 000F
.......     : PRQ implemented: 0
.......     : IO APIC version: 0011
.... register #02: 00000000
.......     : arbitration: 00
.... IRQ redirection table:
 NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:
 00 000 00  1    0    0   0   0    0    0    00
 01 003 03  0    0    0   0   0    1    1    39
 02 003 03  0    0    0   0   0    1    1    31
 03 003 03  0    0    0   0   0    1    1    41
 04 003 03  0    0    0   0   0    1    1    49
 05 003 03  1    1    0   0   0    1    1    51
 06 003 03  0    0    0   0   0    1    1    59
 07 003 03  0    0    0   0   0    1    1    61
 08 003 03  0    0    0   0   0    1    1    69
 09 003 03  0    0    0   0   0    1    1    71
 0a 003 03  1    1    0   0   0    1    1    79
 0b 003 03  1    1    0   0   0    1    1    81
 0c 003 03  1    1    0   0   0    1    1    89
 0d 003 03  0    0    0   0   0    1    1    91
 0e 003 03  0    0    0   0   0    1    1    99
 0f 003 03  0    0    0   0   0    1    1    A1
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
.................................... done.
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 199.9574 MHz.
..... host bus clock speed is 66.6523 MHz.
cpu: 0, clocks: 666523, slice: 222174
CPU0<T0:666512,T1:444336,D:2,S:222174,C:666523>
cpu: 1, clocks: 666523, slice: 222174
CPU1<T0:666512,T1:222160,D:4,S:222174,C:666523>
checking TSC synchronization across CPUs: passed.
PCI: PCI BIOS revision 2.10 entry at 0xe7840, last bus=0
PCI: Using configuration type 1
PCI: Probing PCI hardware
PCI: i440KX/GX host bridge 00:19.0: secondary bus 00
PCI BIOS passed nonexistent PCI bus 0!
PCI BIOS passed nonexistent PCI bus 0!
PCI BIOS passed nonexistent PCI bus 0!
PCI BIOS passed nonexistent PCI bus 0!
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
apm: BIOS not found.
Starting kswapd
VFS: Diskquotas version dquot_6.5.0 initialized
aio_setup: okay!
aio_setup: sizeof(struct page) = 56
Detected PS/2 Mouse Port.
pty: 2048 Unix98 ptys configured
Serial driver version 5.05c (2001-07-08) with MANY_PORTS MULTIPORT
SHARE_IRQ SERIAL_PCI ISAPNP enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
ttyS01 at 0x02f8 (irq = 3) is a 16550A
Real Time Clock Driver v1.10e
block: 112 slots per queue, batch=28
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with
idebus=xx
CMD680: IDE controller on PCI bus 00 dev 48
CMD680: chipset revision 1
CMD680: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xfa00-0xfa07, BIOS settings: hda:pio, hdb:pio
    ide1: BM-DMA at 0xfa08-0xfa0f, BIOS settings: hdc:pio, hdd:pio
hda: ST340810A, ATA DISK drive
ide0 at 0xfe00-0xfe07,0xfd02 on irq 12
hda: 78165360 sectors (40021 MB) w/2048KiB Cache, CHS=77545/16/63,
UDMA(100)
ide-floppy driver 0.99.newide
Partition check:
 hda: [PTBL] [4865/255/63] hda1 hda2 < hda5 hda6 > hda3 hda4
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
ide-floppy driver 0.99.newide
SCSI subsystem driver Revision: 1.00
scsi0 : SCSI host adapter emulation for IDE ATAPI devices
md: md driver 0.90.0 MAX_MD_DEVS=256, MD_SB_DISKS=27
md: Autodetecting RAID arrays.
md: autorun ...
md: ... autorun DONE.
pci_hotplug: PCI Hot Plug PCI Core version: 0.4
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 256 buckets, 4Kbytes
TCP: Hash tables configured (established 2048 bind 2730)
Linux IP multicast router 0.06 plus PIM-SM
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
RAMDISK: Compressed image found at block 0
Freeing initrd memory: 128k freed
VFS: Mounted root (ext2 filesystem).
Journalled Block Device driver loaded
EXT3-fs: INFO: recovery required on readonly filesystem.
EXT3-fs: write access will be enabled during recovery.
kjournald starting.  Commit interval 5 seconds
EXT3-fs: recovery complete.
EXT3-fs: mounted filesystem with ordered data mode.
Freeing unused kernel memory: 308k freed
Adding Swap: 465876k swap-space (priority -1)
EXT3 FS 2.4-0.9.17, 10 Jan 2002 on ide0(3,4), internal journal
scsi1 : SCSI host adapter emulation for IDE ATAPI devices
parport0: PC-style at 0x378 [PCSPP,TRISTATE,EPP]
ip_conntrack (512 buckets, 4096 max)
ne2k-pci.c:v1.02 10/19/2000 D. Becker/P. Gortmaker
  http://www.scyld.com/network/ne2k-pci.html
eth0: RealTek RTL-8029 found at 0xf800, IRQ 11, 00:00:21:EC:47:55.
es1371: version v0.30 time 14:49:28 Apr  1 2002
es1371: found chip, vendor id 0x1274 device id 0x1371 revision 0x08
es1371: found es1371 rev 8 at io 0xff00 irq 5
es1371: features: joystick 0x0
ac97_codec: AC97 Audio codec, id: 0x4352:0x5913 (Cirrus Logic CS4297A
rev A)



