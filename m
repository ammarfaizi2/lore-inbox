Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314300AbSEFJsi>; Mon, 6 May 2002 05:48:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314303AbSEFJsh>; Mon, 6 May 2002 05:48:37 -0400
Received: from [212.3.242.3] ([212.3.242.3]:7438 "HELO mail.i4gate.net")
	by vger.kernel.org with SMTP id <S314300AbSEFJsf>;
	Mon, 6 May 2002 05:48:35 -0400
Content-Type: text/plain;
  charset="us-ascii"
From: DevilKin <devilkin-lkml@blindguardian.org>
To: linux-kernel@vger.kernel.org
Subject: ide harddisk trouble
Date: Mon, 6 May 2002 11:13:50 +0200
X-Mailer: KMail [version 1.4]
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <200205061113.50956.devilkin-lkml@blindguardian.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I have a problem with a harddisk (QUANTUM MAVERICK 270A, Rev=A06.06). The disk 
works perfectly in another pc (running dos). If i connect it to this pc i get 
the output below with a backup kernel (2.4.9).

If i boot up with a more recent kernel (2.4.19-pre7-ac4, new ide stuff not 
enabled) the system just hangs at partition check.

When attempting to do smthing with hdparm for instance, i get  interrupt 
dropped in the logs.

Any hints?

Thanks!

DK


relevant logs/info:


dmesg output:

scratchy:/var/log# dmesg
Linux version 2.4.9 (root@scratchy) (gcc version 2.95.3 20010315 (release)) 
#1 Sat Sep 8 14:15:22 CEST 2001
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000e0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 0000000008000000 (usable)
 BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
 BIOS-e820: 00000000fffe0000 - 0000000100000000 (reserved)
Scan SMP from c0000000 for 1024 bytes.
Scan SMP from c009fc00 for 1024 bytes.
Scan SMP from c00f0000 for 65536 bytes.
Scan SMP from c009fc00 for 4096 bytes.
On node 0 totalpages: 32768
zone(0): 4096 pages.
zone(1): 28672 pages.
zone(2): 0 pages.
mapped APIC to ffffe000 (01222000)
Kernel command line: BOOT_IMAGE=linux-bak ro root=303
Initializing CPU#0
Detected 199.967 MHz processor.
Console: colour VGA+ 132x43
Calibrating delay loop... 398.95 BogoMIPS
Memory: 126568k/131072k available (1088k kernel code, 4116k reserved, 386k 
data, 220k init, 0k highmem)Dentry-cache hash table entries: 16384 (order: 5, 
131072 bytes)
Inode-cache hash table entries: 8192 (order: 4, 65536 bytes)
Mount-cache hash table entries: 2048 (order: 2, 16384 bytes)
Buffer-cache hash table entries: 8192 (order: 3, 32768 bytes)
Page-cache hash table entries: 32768 (order: 5, 131072 bytes)
CPU: Before vendor init, caps: 008001bf 00000000 00000000, vendor = 0
Intel Pentium with F0 0F bug - workaround enabled.
Intel old style machine check architecture supported.
Intel old style machine check reporting enabled on CPU#0.
CPU: After vendor init, caps: 008001bf 00000000 00000000 00000000
CPU:     After generic, caps: 008001bf 00000000 00000000 00000000
CPU:             Common caps: 008001bf 00000000 00000000 00000000
CPU: Intel Pentium MMX stepping 03
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: none
PCI: PCI BIOS revision 2.10 entry at 0xfdb11, last bus=0
PCI: Using configuration type 1
PCI: Probing PCI hardware
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
Starting kswapd v1.8
udf: registering filesystem
0x378: FIFO is 16 bytes
0x378: writeIntrThreshold is 1
0x378: readIntrThreshold is 1
0x378: PWord is 8 bits
0x378: Interrupts are ISA-Pulses
0x378: ECP port cfgA=0x10 cfgB=0x4b
0x378: ECP settings irq=7 dma=3
parport0: PC-style at 0x378 (0x778) [PCSPP,TRISTATE,COMPAT,ECP]
parport0: irq 7 detected
parport0: cpp_daisy: aa5500ff(38)
parport0: assign_addrs: aa5500ff(38)
parport0: cpp_daisy: aa5500ff(38)
parport0: assign_addrs: aa5500ff(38)
Detected PS/2 Mouse Port.
pty: 256 Unix98 ptys configured
Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ SERIAL_PCI 
ISAPNP enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
ttyS01 at 0x02f8 (irq = 3) is a 16550A
lp0: using parport0 (polling).
Real Time Clock Driver v1.10d
block: 128 slots per queue, batch=16
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ALI15X3: IDE controller on PCI bus 00 dev 58
PCI: No IRQ known for interrupt pin A of device 00:0b.0. Please try using 
pci=biosirq.
ALI15X3: chipset revision 32
ALI15X3: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xffa0-0xffa7, BIOS settings: hda:pio, hdb:pio
    ide1: BM-DMA at 0xffa8-0xffaf, BIOS settings: hdc:pio, hdd:pio
hda: ST320423A, ATA DISK drive
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
hdc: QUANTUM MAVERICK 270A, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: 40011300 sectors (20486 MB) w/512KiB Cache, CHS=2490/255/63, (U)DMA
hdc: 528640 sectors (271 MB) w/98KiB Cache, CHS=944/14/40, DMA
Partition check:
 hda: hda1 hda2 hda3
 hdc:hdc: timeout waiting for DMA
ide_dmaproc: chipset supported ide_dma_timeout func only: 14
hdc: status error: status=0x58 { DriveReady SeekComplete DataRequest }
hdc: drive not ready for command
spurious 8259A interrupt: IRQ7.
 unknown partition table
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
loop: loaded (max 8 devices)
plip: parport0 has no IRQ. Using IRQ-less mode,which is fairly inefficient!
NET3 PLIP version 2.4-parport gniibe@mri.co.jp
plip0: Parallel port at 0x378, not using IRQ.
ne2k-pci.c:v1.02 10/19/2000 D. Becker/P. Gortmaker
  http://www.scyld.com/network/ne2k-pci.html
eth0: RealTek RTL-8029 found at 0xee80, IRQ 11, 00:20:18:52:EF:81.
eth1: RealTek RTL-8029 found at 0xed80, IRQ 9, 00:40:05:64:E5:AC.
8139too Fast Ethernet driver 0.9.18a
eth2: RealTek RTL8139 Fast Ethernet at 0xc8802f00, 00:50:bf:7a:d3:9f, IRQ 5
eth2:  Identified 8139 chip type 'RTL-8139C'
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 1024 buckets, 8Kbytes
TCP: Hash tables configured (established 8192 bind 8192)
IPv4 over IPv4 tunneling driver
GRE over IPv4 tunneling driver
Linux IP multicast router 0.06 plus PIM-SM
ip_conntrack (1024 buckets, 8192 max)
ip_tables: (c)2000 Netfilter core team
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
VFS: Mounted root (ext2 filesystem) readonly.
Freeing unused kernel memory: 220k freed
Adding Swap: 136544k swap-space (priority -1)
eth2: Setting 100mbps full-duplex based on auto-negotiated partner ability 
45e1.

/var/log/messages:

--snip--
May  6 09:38:39 scratchy kernel: Uniform Multi-Platform E-IDE driver 
Revision: 6.31
May  6 09:38:39 scratchy kernel: hda: 40011300 sectors (20486 MB) w/512KiB 
Cache, CHS=2490/255/63, (U)DMA
May  6 09:38:39 scratchy kernel: hdc: 528640 sectors (271 MB) w/98KiB Cache, 
CHS=944/14/40, DMA
May  6 09:38:39 scratchy kernel: Partition check:
May  6 09:38:39 scratchy kernel:  hda: hda1 hda2 hda3
May  6 09:38:39 scratchy kernel:  hdc:hdc: timeout waiting for DMA
--snip--

/var/log/kernel:

--snip--
May  6 09:38:39 scratchy kernel: Uniform Multi-Platform E-IDE driver 
Revision: 6.31
May  6 09:38:39 scratchy kernel: ide: Assuming 33MHz system bus speed for PIO 
modes; override with idebus=xx
May  6 09:38:39 scratchy kernel: ALI15X3: IDE controller on PCI bus 00 dev 58
May  6 09:38:39 scratchy kernel: PCI: No IRQ known for interrupt pin A of 
device 00:0b.0. Please try using pci=biosirq.
May  6 09:38:39 scratchy kernel: ALI15X3: chipset revision 32
May  6 09:38:39 scratchy kernel: ALI15X3: not 100% native mode: will probe 
irqs later
May  6 09:38:39 scratchy kernel:     ide0: BM-DMA at 0xffa0-0xffa7, BIOS 
settings: hda:pio, hdb:pio
May  6 09:38:39 scratchy kernel:     ide1: BM-DMA at 0xffa8-0xffaf, BIOS 
settings: hdc:pio, hdd:pio
May  6 09:38:39 scratchy kernel: hda: ST320423A, ATA DISK drive
May  6 09:38:39 scratchy kernel: ide: Assuming 33MHz system bus speed for PIO 
modes; override with idebus=xx
May  6 09:38:39 scratchy kernel: hdc: QUANTUM MAVERICK 270A, ATA DISK drive
May  6 09:38:39 scratchy kernel: ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
May  6 09:38:39 scratchy kernel: ide1 at 0x170-0x177,0x376 on irq 15
May  6 09:38:39 scratchy kernel: hda: 40011300 sectors (20486 MB) w/512KiB 
Cache, CHS=2490/255/63, (U)DMA
May  6 09:38:39 scratchy kernel: hdc: 528640 sectors (271 MB) w/98KiB Cache, 
CHS=944/14/40, DMA
May  6 09:38:39 scratchy kernel: Partition check:
May  6 09:38:39 scratchy kernel:  hda: hda1 hda2 hda3
May  6 09:38:39 scratchy kernel:  hdc:hdc: timeout waiting for DMA
May  6 09:38:39 scratchy kernel: ide_dmaproc: chipset supported 
ide_dma_timeout func only: 14
May  6 09:38:39 scratchy kernel: hdc: status error: status=0x58 { DriveReady 
SeekComplete DataRequest }May  6 09:38:39 scratchy kernel: hdc: drive not 
ready for command
May  6 09:38:39 scratchy kernel: spurious 8259A interrupt: IRQ7.
May  6 09:38:39 scratchy kernel:  unknown partition table
--snip--


lspci -vv:

scratchy:/var/log# lspci -vv
00:0b.0 IDE interface: Acer Laboratories Inc. M5229 (rev 20) (prog-if fa)
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 2 min, 4 max, 32 set
        Interrupt: pin A routed to IRQ 0
        Region 4: I/O ports at ffa0

CPU Info:

scratchy:/var/log# cat /proc/cpuinfo
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 5
model           : 4
model name      : Pentium MMX
stepping        : 3
cpu MHz         : 199.967
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : yes
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr mce cx8 mmx
bogomips        : 398.95

harddisk information:

scratchy:/var/log# hdparm -i /dev/hdc

/dev/hdc:

 Model=QUANTUM MAVERICK 270A, FwRev=A06.06, SerialNo=332433394471
 Config={ HardSect NotMFM HdSw>15uSec Fixed DTR>5Mbs RotSpdTol>.5% }
 RawCHS=944/14/40, TrkSize=20480, SectSize=512, ECCbytes=4
 BuffType=3(DualPortCache), BuffSize=98kB, MaxMultSect=8, MultSect=8
 DblWordIO=no, maxPIO=2(fast), DMA=yes, maxDMA=2(fast)
 CurCHS=944/14/40, CurSects=528640, LBA=yes, LBA=yes,LBAsects=528640
 tDMA={min:150,rec:150}, DMA modes: sword0 sword1 sword2 mword0 *mword1
 IORDY=on/off, tPIO={min:333,w/IORDY:180}, PIO modes: mode3
