Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129401AbQLDTYq>; Mon, 4 Dec 2000 14:24:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129458AbQLDTYh>; Mon, 4 Dec 2000 14:24:37 -0500
Received: from zmamail05.zma.compaq.com ([161.114.64.105]:22281 "HELO
	zmamail05.zma.compaq.com") by vger.kernel.org with SMTP
	id <S129401AbQLDTYS>; Mon, 4 Dec 2000 14:24:18 -0500
Date: Mon, 4 Dec 2000 13:53:42 -0500 (EST)
From: Phillip Ezolt <ezolt@perf.zko.dec.com>
Reply-To: Phillip Ezolt <ezolt@perf.zko.dec.com>
To: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Cc: Andrea Arcangeli <andrea@suse.de>, rth@twiddle.net,
        Jay.Estabrook@compaq.com, linux-kernel@vger.kernel.org,
        wcarr@perf.zko.dec.com
Subject: Re: Alpha SCSI error on 2.4.0-test11
In-Reply-To: <20001202011104.A2089@jurassic.park.msu.ru>
Message-ID: <Pine.OSF.3.96.1001204134014.11945C-100000@perf.zko.dec.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ivan,
	I've recompiled as you have suggested.  Any ideas? 

Here is my dmesg output:


Linux version 2.4.0-test12 (ezolt@pulitzer.zko.dec.com) (gcc version egcs-2.91.66 19990314/Linux (egcs-1.1.2 release)) #3 Mon Dec 4 02:38:18 EST 2000
Booting GENERIC on Miata using machine vector Miata from SRM
Command line: console=tty0 console=ttyS0,9600 root=/dev/fd0
memcluster 0, usage 1, start        0, end      236
memcluster 1, usage 0, start      236, end   147455
memcluster 2, usage 1, start   147455, end   147456
freeing pages 236:384
freeing pages 754:147455
pci: cia revision 1 (pyxis)
On node 0 totalpages: 147456
zone(0): 147456 pages.
zone(1): 0 pages.
zone(2): 0 pages.
Kernel command line: console=tty0 console=ttyS0,9600 root=/dev/fd0
Using epoch = 1952
Console: colour VGA+ 80x25
Calibrating delay loop... 1191.18 BogoMIPS
Memory: 1155136k/1179640k available (1602k kernel code, 22616k reserved, 515k data, 376k init)
Dentry-cache hash table entries: 262144 (order: 9, 4194304 bytes)
Buffer-cache hash table entries: 65536 (order: 6, 524288 bytes)
Page-cache hash table entries: 262144 (order: 8, 2097152 bytes)
Inode-cache hash table entries: 131072 (order: 8, 2097152 bytes)
POSIX conformance testing by UNIFIX
pci: passed tb register update test
pci: passed sg loopback i/o read test
pci: passed tbia test
pci: passed pte write cache snoop test
pci: failed valid tag invalid pte reload test (mcheck; workaround available)
pci: passed pci machine check test
  got res[8000:807f] for resource 0 of Digital Equipment Corporation DECchip 21142/43
  got res[8080:80ff] for resource 1 of Digital Equipment Corporation DEFPA
  got res[8400:840f] for resource 4 of Contaq Microsystems 82c693 (#2)
  got res[9000000:97fffff] for resource 1 of Matrox Graphics, Inc. MGA 2064W [Millennium]
  got res[9800000:983ffff] for resource 6 of Digital Equipment Corporation DECchip 21142/43
  got res[9840000:984ffff] for resource 4 of Contaq Microsystems 82c693 (#3)
  got res[9850000:985ffff] for resource 6 of Matrox Graphics, Inc. MGA 2064W [Millennium]
  got res[9860000:986ffff] for resource 2 of Digital Equipment Corporation DEFPA
  got res[9870000:9873fff] for resource 0 of Matrox Graphics, Inc. MGA 2064W [Millennium]
  got res[9874000:9874fff] for resource 0 of Contaq Microsystems 82c693 (#4)
  got res[9875000:987507f] for resource 1 of Digital Equipment Corporation DECchip 21142/43
  got res[9876000:987607f] for resource 0 of Digital Equipment Corporation DEFPA
  got res[9000:90ff] for resource 0 of Q Logic ISP1020
  got res[9400:947f] for resource 0 of Digital Equipment Corporation DECchip 21040 [Tulip]
  got res[9900000:990ffff] for resource 6 of Q Logic ISP1020
  got res[9910000:9910fff] for resource 1 of Q Logic ISP1020
  got res[9911000:991107f] for resource 1 of Digital Equipment Corporation DECchip 21040 [Tulip]
PCI: Bus 1, bridge: Digital Equipment Corporation DECchip 21152
  IO window: 9000-9fff
  MEM window: 09900000-099fffff
PCI enable device: (Digital Equipment Corporation DECchip 21142/43)
  cmd reg 0x47
PCI enable device: (Contaq Microsystems 82c693)
  cmd reg 0x47
PCI enable device: (Contaq Microsystems 82c693 (#2))
  cmd reg 0x45
PCI enable device: (Contaq Microsystems 82c693 (#3))
  cmd reg 0x47
PCI enable device: (Contaq Microsystems 82c693 (#4))
  cmd reg 0x46
PCI enable device: (Matrox Graphics, Inc. MGA 2064W [Millennium])
  cmd reg 0x87
PCI enable device: (Digital Equipment Corporation DEFPA)
  cmd reg 0x47
PCI enable device: (Digital Equipment Corporation DECchip 21152)
  cmd reg 0x107
PCI enable device: (Q Logic ISP1020)
  cmd reg 0x47
PCI enable device: (Digital Equipment Corporation DECchip 21040 [Tulip])
  cmd reg 0x47
SMC37c669 Super I/O Controller found @ 0x370
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Starting kswapd v1.8
pty: 256 Unix98 ptys configured
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
CY82C693: IDE controller on PCI bus 00 dev 39
CY82C693: chipset revision 0
CY82C693: not 100% native mode: will probe irqs later
CY82C693U driver v0.34 99-13-12 Andreas S. Krebs (akrebs@altavista.net)
    ide0: BM-DMA at 0x8400-0x8407<7>pci_map_single: [fffffc0001910000,1000] -> direct 41910000 from fffffc000031afa8
, BIOS settings: hda:pio, hdb:pio
    ide1: BM-DMA at 0x8408-0x840f<7>pci_map_single: [fffffc00001fa000,1000] -> direct 401fa000 from fffffc000031afa8
, BIOS settings: hdc:pio, hdd:pio
hda: TOSHIBA CD-ROM XM-5702B, ATAPI CDROM drive
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hda: ATAPI 12X CD-ROM drive, 256kB Cache
Uniform CD-ROM driver Revision: 3.11
Floppy drive(s): fd0 is 2.88M
FDC 0 is a post-1991 82077
Serial driver version 5.02 (2000-08-09) with MANY_PORTS SHARE_IRQ SERIAL_PCI enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
ttyS01 at 0x02f8 (irq = 3) is a 16550A
rtc: Digital UNIX epoch (1952) detected
Real Time Clock Driver v1.10d
Linux Tulip driver version 0.9.11 (November 3, 2000)
eth0: Digital DS21143 Tulip rev 48 at 0x8000, 00:00:F8:76:72:DA, IRQ 24.
eth0:  EEPROM default media type Autosense.
eth0:  Index #0 - Media 10baseT (#0) described by a 21142 Serial PHY (2) block.
eth0:  Index #1 - Media 10baseT-FD (#4) described by a 21142 Serial PHY (2) block.
eth0:  Index #2 - Media 10base2 (#1) described by a 21142 Serial PHY (2) block.
eth0:  Index #3 - Media AUI (#2) described by a 21142 Serial PHY (2) block.
eth0:  Index #4 - Media MII (#11) described by a 21142 MII PHY (3) block.
eth0:  MII transceiver #5 config 2000 status 784b advertising 01e1.
eth1: Digital DC21040 Tulip rev 35 at 0x9400, 08:00:2B:E4:1E:CB, IRQ 44.
SCSI subsystem driver Revision: 1.00
qlogicisp : new isp1020 revision ID (5)
scsi0 : QLogic ISP1020 SCSI on PCI bus 01 device 20 irq 27 I/O base 0x9000
CIA machine check: vector=0x660 pc=0xfffffc0000310764 code=0x813
machine check type: unknown
pc = [<fffffc0000310764>]  ra = [<fffffc000032dc3c>]  ps = 0000
v0 = 0000000047fe03b8  t0 = fffffc0000310a10  t1 = 0000000000000001
t2 = 0000000000000001  t3 = fffffc0001914000  t4 = fffffc0000562208
t5 = 0000000000000057  t6 = fffffc0000560d88  t7 = fffffc0001914000
a0 = 00000000019143b8  a1 = fffffc0047fe0000  a2 = fffffc000032e304
a3 = fffffffffffffffe  a4 = 000000000000000f  a5 = 0000000000000000
t8 = 0000000000000000  t9 = 0000000063001812  t10= 0000000000000000
t11= 0000000000000010  pv = fffffc0000310a00  at = fffffc000052c080
gp = fffffc0000585890  sp = fffffc0001917c00

--Phil

Compaq:  High Performance Server Division/Benchmark Performance Engineering 
---------------- Alpha, The Fastest Processor on Earth --------------------
Phillip.Ezolt@compaq.com        |C|O|M|P|A|Q|        ezolt@perf.zko.dec.com
------------------- See the results at www.spec.org -----------------------

On Sat, 2 Dec 2000, Ivan Kokshaysky wrote:

> On Fri, Dec 01, 2000 at 02:56:43PM -0500, Phillip Ezolt wrote:
> > What data structure's would I look at?  What should I investigate to
> > verify this?
> 
> In the arch/alpha/kernel/pci_iommu.c change
> #define DEBUG_ALLOC 0
> to
> #define DEBUG_ALLOC 2
> 
> Perhaps this will give us more info.
> At the first look window 1 is being set up properly.
> 
> Ivan.
> 
> 

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
