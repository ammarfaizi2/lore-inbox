Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266564AbSL2Mxg>; Sun, 29 Dec 2002 07:53:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266576AbSL2Mxg>; Sun, 29 Dec 2002 07:53:36 -0500
Received: from oe31.law11.hotmail.com ([64.4.16.88]:23820 "EHLO hotmail.com")
	by vger.kernel.org with ESMTP id <S266564AbSL2Mxe>;
	Sun, 29 Dec 2002 07:53:34 -0500
X-Originating-IP: [66.108.18.44]
From: "Linux Kernel Developer" <linux_developer@hotmail.com>
To: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Subject: Trying to get Linux to recognize PCI serial ports
Date: Sun, 29 Dec 2002 08:00:13 -0500
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_005C_01C2AF10.51387FF0"
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1106
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Message-ID: <OE31dyl6ds7s07Bj89N00004d62@hotmail.com>
X-OriginalArrivalTime: 29 Dec 2002 13:01:50.0567 (UTC) FILETIME=[73CE7770:01C2AF3A]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

------=_NextPart_000_005C_01C2AF10.51387FF0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit

Hi all,

    I've been trying to get my system to recognize my new CompUSA PCI serial
ports.  The serial ports are part of a multiport 2 serial/1 parallel PCI I/O
card based on the Nm9835CV chipset.  According from what I have read in the
archives and in the kernel source these ports should be supported by the
latest kernel.  (I'm running 2.4.20)  I've tried both serial.o and
parport_serial.o drivers.  Neither seam to recognize and configure my serial
ports.  I've searched google and the linux kernel mailing list archives to
no avail.  Can anyone give my any information on how I could configure these
ports?  Thank you.

PS.

    I've attached my dmesg and lspci output for this device.

Thanks for any help.

------=_NextPart_000_005C_01C2AF10.51387FF0
Content-Type: text/plain;
	name="lspci.txt"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="lspci.txt"

00:09.0 Serial controller: NetMos Technology 222N-2 I/O Card (2S+1P) =
(rev 01) (prog-if 02 [16550])=0A=
	Subsystem: LSI Logic / Symbios Logic (formerly NCR): Unknown device 0012=0A=
	Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- =
Stepping- SERR- FastB2B-=0A=
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- =
<TAbort- <MAbort- >SERR- <PERR-=0A=
	Interrupt: pin A routed to IRQ 10=0A=
	Region 0: I/O ports at cc00 [size=3D8]=0A=
	Region 1: I/O ports at d000 [size=3D8]=0A=
	Region 2: I/O ports at d400 [size=3D8]=0A=
	Region 3: I/O ports at d800 [size=3D8]=0A=
	Region 4: I/O ports at dc00 [size=3D8]=0A=
	Region 5: I/O ports at e000 [size=3D16]=0A=
=0A=

------=_NextPart_000_005C_01C2AF10.51387FF0
Content-Type: text/plain;
	name="dmesg.txt"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="dmesg.txt"

Linux version 2.4.20 (root@Miyu) (gcc version 2.95.3 20010315 (release)) =
#4 Wed Dec 11 17:29:58 EST 2002=0A=
BIOS-provided physical RAM map:=0A=
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)=0A=
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)=0A=
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)=0A=
 BIOS-e820: 0000000000100000 - 0000000007ff0000 (usable)=0A=
 BIOS-e820: 0000000007ff0000 - 0000000007ff0800 (ACPI NVS)=0A=
 BIOS-e820: 0000000007ff0800 - 0000000008000000 (ACPI data)=0A=
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)=0A=
127MB LOWMEM available.=0A=
On node 0 totalpages: 32752=0A=
zone(0): 4096 pages.=0A=
zone(1): 28656 pages.=0A=
zone(2): 0 pages.=0A=
Kernel command line: auto BOOT_IMAGE=3DLinux ro root=3D301=0A=
Initializing CPU#0=0A=
Detected 451.035 MHz processor.=0A=
Console: colour VGA+ 80x25=0A=
Calibrating delay loop... 897.84 BogoMIPS=0A=
Memory: 127612k/131008k available (934k kernel code, 3008k reserved, =
379k data, 64k init, 0k highmem)=0A=
Dentry cache hash table entries: 16384 (order: 5, 131072 bytes)=0A=
Inode cache hash table entries: 8192 (order: 4, 65536 bytes)=0A=
Mount-cache hash table entries: 2048 (order: 2, 16384 bytes)=0A=
Buffer-cache hash table entries: 4096 (order: 2, 16384 bytes)=0A=
Page-cache hash table entries: 32768 (order: 5, 131072 bytes)=0A=
CPU: L1 I Cache: 32K (32 bytes/line), D cache 32K (32 bytes/line)=0A=
CPU:     After generic, caps: 008021bf 808029bf 00000000 00000002=0A=
CPU:             Common caps: 008021bf 808029bf 00000000 00000002=0A=
CPU: AMD-K6(tm) 3D processor stepping 0c=0A=
Checking 'hlt' instruction... OK.=0A=
POSIX conformance testing by UNIFIX=0A=
mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)=0A=
mtrr: detected mtrr type: AMD K6=0A=
PCI: PCI BIOS revision 2.10 entry at 0xfb360, last bus=3D2=0A=
PCI: Using configuration type 1=0A=
PCI: Probing PCI hardware=0A=
PCI: 00:07.3: class 604 doesn't match header type 00. Ignoring class.=0A=
PCI: Using IRQ router VIA [1106/0586] at 00:07.0=0A=
Activating ISA DMA hang workarounds.=0A=
Linux NET4.0 for Linux 2.4=0A=
Based upon Swansea University Computer Society NET3.039=0A=
Initializing RT netlink socket=0A=
Starting kswapd=0A=
VFS: Diskquotas version dquot_6.4.0 initialized=0A=
Journalled Block Device driver loaded=0A=
ACPI: Core Subsystem version [20011018]=0A=
ACPI: Subsystem enabled=0A=
pty: 512 Unix98 ptys configured=0A=
Uniform Multi-Platform E-IDE driver Revision: 6.31=0A=
ide: Assuming 33MHz system bus speed for PIO modes; override with =
idebus=3Dxx=0A=
VP_IDE: IDE controller on PCI bus 00 dev 39=0A=
VP_IDE: chipset revision 6=0A=
VP_IDE: not 100% native mode: will probe irqs later=0A=
ide: Assuming 33MHz system bus speed for PIO modes; override with =
idebus=3Dxx=0A=
VP_IDE: VIA vt82c586b (rev 41) IDE UDMA33 controller on pci00:07.1=0A=
    ide0: BM-DMA at 0xc400-0xc407, BIOS settings: hda:DMA, hdb:DMA=0A=
    ide1: BM-DMA at 0xc408-0xc40f, BIOS settings: hdc:DMA, hdd:DMA=0A=
hda: WDC WD102BA, ATA DISK drive=0A=
hdc: CREATIVEDVD8400E, ATAPI CD/DVD-ROM drive=0A=
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14=0A=
ide1 at 0x170-0x177,0x376 on irq 15=0A=
blk: queue c0283aa4, I/O limit 4095Mb (mask 0xffffffff)=0A=
hda: 20028960 sectors (10255 MB) w/1961KiB Cache, CHS=3D1246/255/63, =
UDMA(33)=0A=
Partition check:=0A=
 hda:<7>ldm_validate_partition_table(): Found an MS-DOS partition table, =
not a dynamic disk.=0A=
 hda1 hda2=0A=
NET4: Linux TCP/IP 1.0 for NET4.0=0A=
IP Protocols: ICMP, UDP, TCP, IGMP=0A=
IP: routing cache hash table of 512 buckets, 4Kbytes=0A=
TCP: Hash tables configured (established 8192 bind 8192)=0A=
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.=0A=
kjournald starting.  Commit interval 5 seconds=0A=
EXT3-fs: mounted filesystem with ordered data mode.=0A=
VFS: Mounted root (ext3 filesystem) readonly.=0A=
Freeing unused kernel memory: 64k freed=0A=
Adding Swap: 530104k swap-space (priority -1)=0A=
EXT3 FS 2.4-0.9.19, 19 August 2002 on ide0(3,1), internal journal=0A=
Real Time Clock Driver v1.10e=0A=
PCI: Assigned IRQ 5 for device 00:08.0=0A=
3c59x: Donald Becker and others. www.scyld.com/network/vortex.html=0A=
00:08.0: 3Com PCI 3c905B Cyclone 100baseTx at 0xc800. Vers LK1.1.16=0A=
parport0: PC-style at 0x378 (0x778), irq 7, dma 3 =
[PCSPP,TRISTATE,COMPAT,EPP,ECP,DMA]=0A=
isapnp: Scanning for PnP cards...=0A=
isapnp: No Plug & Play device found=0A=
Serial driver version 5.05c (2001-07-08) with MANY_PORTS MULTIPORT =
SHARE_IRQ DETECT_IRQ SERIAL_PCI ISAPNP enabled=0A=
PCI: Found IRQ 10 for device 00:09.0=0A=

------=_NextPart_000_005C_01C2AF10.51387FF0--
