Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316473AbSEOTTc>; Wed, 15 May 2002 15:19:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316474AbSEOTTb>; Wed, 15 May 2002 15:19:31 -0400
Received: from romulus.cs.ut.ee ([193.40.5.125]:35266 "EHLO romulus.cs.ut.ee")
	by vger.kernel.org with ESMTP id <S316473AbSEOTTa>;
	Wed, 15 May 2002 15:19:30 -0400
Date: Wed, 15 May 2002 22:19:19 +0300 (EEST)
From: Meelis Roos <mroos@linux.ee>
To: "Justin T. Gibbs" <gibbs@scsiguy.com>
cc: linux-kernel@vger.kernel.org
Subject: AIC7XXX, 2.4.19-pre8 & AIC7850 problem
In-Reply-To: <200205151437.g4FEb5990247@aslan.scsiguy.com>
Message-ID: <Pine.GSO.4.43.0205152213360.22236-100000@romulus.cs.ut.ee>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Please do.  They are invaluable in diagnosing the cause of such problems.

This is from Digital Celebris GL 5133 ST, using Doug Ledford's old
driver works OK so the hardware should be OK. AIC7850 is onboard.

Linux version 2.4.19-pre8 (mroos@vaarikas) (gcc version 2.95.4 20011002 (Debian prerelease)) #5 K mai 15 21:08:51 EEST 2002
BIOS-provided physical RAM map:
 BIOS-e801: 0000000000000000 - 000000000009f000 (usable)
 BIOS-e801: 0000000000100000 - 0000000002800000 (usable)
40MB LOWMEM available.
On node 0 totalpages: 10240
zone(0): 4096 pages.
zone(1): 6144 pages.
zone(2): 0 pages.
Kernel command line: PAMSkadabra ro root=0803 console=ttyS0,9600,8,n,1 blaah blaah blaah
Initializing CPU#0
Detected 132.728 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 264.60 BogoMIPS
Memory: 38460k/40960k available (928k kernel code, 2112k reserved, 302k data, 228k init, 0k highmem)
Dentry cache hash table entries: 8192 (order: 4, 65536 bytes)
Inode cache hash table entries: 4096 (order: 3, 32768 bytes)
Mount-cache hash table entries: 1024 (order: 1, 8192 bytes)
Buffer-cache hash table entries: 1024 (order: 0, 4096 bytes)
Page-cache hash table entries: 16384 (order: 4, 65536 bytes)
Intel Pentium with F0 0F bug - workaround enabled.
CPU: Intel Pentium 75 - 200 stepping 0c
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
PCI: PCI BIOS revision 2.10 entry at 0xfd8d1, last bus=0
PCI: Using configuration type 1
PCI: Probing PCI hardware
Limiting direct PCI/PCI transfers.
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
apm: BIOS not found.
Starting kswapd
VFS: Diskquotas version dquot_6.4.0 initialized
pty: 256 Unix98 ptys configured
Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ DETECT_IRQ SERIAL_PCI ISAPNP enabled
ÿttyS00 at 0x03f8 (irq = 4) is a 16550A
ttyS01 at 0x02f8 (irq = 3) is a 16550A
Linux Tulip driver version 0.9.15-pre10 (Mar 8, 2002)
eth0: Digital DC21040 Tulip rev 36 at 0xf080, 00:00:F8:21:E5:F3, IRQ 11.
SCSI subsystem driver Revision: 1.00
ahc_pci:0:8:0: Using left over BIOS settings
scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.7
        <Adaptec aic7850 SCSI adapter>
        aic7850: Single Channel A, SCSI Id=7, 3/253 SCBs

scsi0:0:0:0: Attempting to queue an ABORT message
scsi0: Dumping Card State in Status phase, at SEQADDR 0x15c
ACCUM = 0xc0, SINDEX = 0x61, DINDEX = 0x65, ARG_2 = 0xff
HCNT = 0x0 SCBPTR = 0x0
SCSISEQ = 0x12, SBLKCTL = 0x0
 DFCNTRL = 0x0, DFSTATUS = 0x2d
LASTPHASE = 0xc0, SCSISIGI = 0xc6, SXFRCTL0 = 0x88
SSTAT0 = 0x5, SSTAT1 = 0x2
STACK == 0x186, 0x0, 0x0, 0x35
SCB count = 4
Kernel NEXTQSCB = 2
Card NEXTQSCB = 2
QINFIFO entries:
Waiting Queue entries:
Disconnected Queue entries:
QOUTFIFO entries:
Sequencer Free SCB List: 1 2
Sequencer SCB Info: 0(c 0x40, s 0x7, l 0, t 0x3) 1(c 0x0, s 0x8, l 0, t 0xff) 2(c 0x0, s 0xff, l 255, t 0xff)
Pending list: 3(c 0x40, s 0x7, l 0)
Kernel Free SCB list: 1 0
Untagged Q(0): 3
DevQ(0:0:0): 0 waiting
scsi0:0:0:0: Device is active, asserting ATN
scsi0: brkadrint, Scratch or SCB Memory Parity Error at seqaddr = 0x15c
scsi0: Dumping Card State in Status phase, at SEQADDR 0x15c
ACCUM = 0xc0, SINDEX = 0x61, DINDEX = 0x65, ARG_2 = 0xff
HCNT = 0x0 SCBPTR = 0x0
SCSISEQ = 0x12, SBLKCTL = 0x0
 DFCNTRL = 0x0, DFSTATUS = 0x2d
LASTPHASE = 0xc0, SCSISIGI = 0xd6, SXFRCTL0 = 0x88
SSTAT0 = 0x5, SSTAT1 = 0x2
STACK == 0x186, 0x0, 0x0, 0x35
SCB count = 4
Kernel NEXTQSCB = 2
Card NEXTQSCB = 2
QINFIFO entries:
Waiting Queue entries:
Disconnected Queue entries:
QOUTFIFO entries:
Sequencer Free SCB List: 1 2
Sequencer SCB Info: 0(c 0x40, s 0x7, l 0, t 0x3) 1(c 0x0, s 0x8, l 0, t 0xff) 2(c 0x0, s 0xff, l 255, t 0xff)
Pending list: 3(c 0x40, s 0x7, l 0)
Kernel Free SCB list: 1 0
Untagged Q(0): 3
DevQ(0:0:0): 0 waiting
Recovery SCB completes
Recovery code sleeping
Recovery code awake
aic7xxx_abort returns 0x2002
scsi0:0:0:0: Attempting to queue an ABORT message
scsi0: Dumping Card State in Data-out phase, at SEQADDR 0x0
ACCUM = 0x0, SINDEX = 0x0, DINDEX = 0x0, ARG_2 = 0x0
HCNT = 0x0 SCBPTR = 0x0
SCSISEQ = 0x0, SBLKCTL = 0xc0
 DFCNTRL = 0x0, DFSTATUS = 0x29
LASTPHASE = 0x0, SCSISIGI = 0xc6, SXFRCTL0 = 0x0
SSTAT0 = 0x0, SSTAT1 = 0x0
STACK == 0x0, 0x0, 0x0, 0x0
SCB count = 4
Kernel NEXTQSCB = 3
Card NEXTQSCB = 0
QINFIFO entries: 3 2
Waiting Queue entries: 0:255 1:255 2:255
Disconnected Queue entries: 0:255 1:255 2:255
QOUTFIFO entries:
Sequencer Free SCB List: 0 1 2
Sequencer SCB Info: 0(c 0x40, s 0x7, l 0, t 0xff) 1(c 0x0, s 0x8, l 0, t 0xff) 2(c 0x0, s 0xff, l 255, t 0xff)
Pending list: 2(c 0x40, s 0x7, l 0)
Kernel Free SCB list: 1 0
Untagged Q(0): 2
DevQ(0:0:0): 0 waiting
qinpos = 0, SCB index = 3
Kernel panic: Loop 1

 €

-- 
Meelis Roos (mroos@linux.ee)

