Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313706AbSD0NJa>; Sat, 27 Apr 2002 09:09:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313743AbSD0NJ3>; Sat, 27 Apr 2002 09:09:29 -0400
Received: from mx0.gmx.de ([213.165.64.100]:383 "HELO mx0.gmx.net")
	by vger.kernel.org with SMTP id <S313706AbSD0NJ0>;
	Sat, 27 Apr 2002 09:09:26 -0400
Date: Sat, 27 Apr 2002 15:09:20 +0200 (MEST)
From: Michael Mertins <mime@gmx.li>
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Subject: ide-scsi-emulation bugreport 
X-Priority: 3 (Normal)
X-Authenticated-Sender: #0007692942@gmx.net
X-Authenticated-IP: [217.81.96.134]
Message-ID: <8543.1019912960@www50.gmx.net>
X-Mailer: WWW-Mail 1.5 (Global Message Exchange)
X-Flags: 0001
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,
for a while burning runs fine but then always the following error occurs no
matter what 2.4 kernel I use. So I am living with this error for quite a
while already but since it is not getting better with each new kernel I install I
feel urged to submit this.
Cdrecord/Cdrdao is starting, doing OPC check, the burner blinks as if it
would burn correctly but then instead of writing it states an error-message like
this:

--- CDRDAO ---

Using libscg version 'schily-0.5'

0,0,0: TEAC CD-W512EB   Rev: 2.0B
Using driver: Generic SCSI-3/MMC - Version 1.2 (options 0x0010)

Starting write at speed 12...
Pausing 10 seconds - hit CTRL-C to abort.
Process can be aborted with QUIT signal (usually CTRL-\).
Turning BURN-Proof on
Executing power calibration...
Power calibration successful.
ERROR: Write data failed.
ERROR: Writing failed.
?: Input/output error.  : scsi sendcmd: no error
CDB:  1E 00 00 00 00 00
status: 0x2 (CHECK CONDITION)
Sense Bytes: 70 00 06 00 00 00 00 0A 00 00 00 00 29 00 00 00
Sense Key: 0x6 Unit Attention, Segment 0
Sense Code: 0x29 Qual 0x00 (power on, reset, or bus device reset occurred)
Fru 0x0
Sense flags: Blk 0 (not valid) 
cmd finished after 0.004s timeout 180s
ERROR: Cannot prevent/allow medium removal.


---CDRECORD---

Cdrecord 1.10 (i686-pc-linux-gnu) Copyright (C) 1995-2001 Jörg Schilling
TOC Type: 1 = CD-ROM
Using libscg version 'schily-0.5'
Driveropts: 'burnproof'
atapi: 1
Device type    : Removable CD-ROM
Version        : 0
Response Format: 1
Vendor_info    : 'TEAC    '
Identifikation : 'CD-W512EB       '
Revision       : '2.0B'
Device seems to be: Generic mmc CD-RW.
Using generic SCSI-3/mmc CD-R driver (mmc_cdr).
Driver flags   : SWABAUDIO
Drive buf size : 3462144 = 3381 KB
FIFO size      : 4194304 = 4096 KB
scsidev: '0,0,0'
scsibus: 0 target: 0 lun: 0
Linux sg driver version: 3.1.23
Track 01: data  unknown length padsize:  30 KB
Lout start:       0 MB (00:02/00) = 0 sectors
Current Secsize: 2048
ATIP info from disk:
  Indicated writing power: 5
  Is not unrestricted
  Is not erasable
  Disk sub type: Medium Type B, low Beta category (B-) (4)
  ATIP start of lead in:  -12369 (97:17/06)
  ATIP start of lead out: 359849 (79:59/74)
Disk type:    unknown
Manuf. index: -1
Manufacturer: unknown (not in table)
Starting to write CD/DVD at speed 12 in write mode for single session.
/usr/bin/cdrecord: WARNING: Track size unknown. Data may not fit on disk.
Performing OPC...
/usr/bin/cdrecord: Turning BURN-Proof on

/usr/bin/cdrecord: Input/output error. write_g1: scsi sendcmd: retryable
error
CDB:  2A 00 00 00 00 00 00 00 1F 00
status: 0x0 (GOOD STATUS)
cmd finished after 40.099s timeout 40s
Track 01:   0 MB written.
write track data: error after 0 bytes
Trouble flushing the cache
Writing  time:   53.885s
Sense Bytes: 71 00 03 00 00 00 00 0A 00 00 00 00 02 00 00 00 00 00
/usr/bin/cdrecord: Input/output error. flush cache: scsi sendcmd: no error
CDB:  35 00 00 00 00 00 00 00 00 00
status: 0x2 (CHECK CONDITION)
Sense Bytes: 70 00 06 00 00 00 00 0A 00 00 00 00 29 00 00 00
Sense Key: 0x6 Unit Attention, Segment 0
Sense Code: 0x29 Qual 0x00 (power on, reset, or bus device reset occurred)
Fru 0x0
Sense flags: Blk 0 (not valid) 
cmd finished after 0.001s timeout 120s
/usr/bin/cdrecord: Input/output error. close track/session: scsi sendcmd: no
error
CDB:  5B 00 02 00 00 00 00 00 00 00
status: 0x2 (CHECK CONDITION)
Sense Bytes: 70 00 05 00 00 00 00 0A 00 00 00 00 72 03 00 00
Sense Key: 0x5 Illegal Request, Segment 0
Sense Code: 0x72 Qual 0x03 (session fixation error - incomplete track in
session) Fru 0x0
Sense flags: Blk 0 (not valid) 
cmd finished after 0.002s timeout 480s
cmd finished after 0.002s timeout 480s
/usr/bin/cdrecord: fifo had 64 puts and 1 gets.
/usr/bin/cdrecord: fifo was 0 times empty and 0 times full, min fill was
100%.





I am using Debian 3.0, 2.4.19pre4ac3 kernel and dma enabled. I used 16 and
32bit access mode with hdparm but both show this.
The really weird thing is: after a reboot the error is gone and occurs back
after a few burned cds.
I really hope you know what this means...
My burner is hdc or scd0 and the corresponding dmesg-output seems to be:

Attached scsi CD-ROM sr0 at scsi0, channel 0, id 0, lun 0
sr0: CDROM (ioctl) error, command: 0x1a 00 2a 00 80 00 
Deferred sr00:00: sns = 71  3
ASC= 2 ASCQ= 0
Raw sense data:0x71 0x00 0x03 0x00 0x00 0x00 0x00 0x0a 0x00 0x00 0x00 0x00
0x02 0x00 0x00 0x00 0x00 0x00 
sr0: scsi-1 drive
VFS: Disk change detected on device sr(11,0)
VFS: Disk change detected on device ide1(22,64)
scsi : aborting command due to timeout : pid 45693, scsi0, channel 0, id 0,
lun 0 0x2a 00 ff ff ff 6a 00 00 1b 00 
hdc: irq timeout: status=0xd0 { Busy }
hdc: ATAPI reset complete




LSPCI-OUTPUT

00:00.0 Host bridge: Intel Corp. 82815 815 Chipset Host Bridge and Memory
Controller Hub (rev 02)
00:01.0 PCI bridge: Intel Corp.: Unknown device 1131 (rev 02)
00:1e.0 PCI bridge: Intel Corp. 82820 820 (Camino 2) Chipset PCI (rev 05)
00:1f.0 ISA bridge: Intel Corp. 82820 820 (Camino 2) Chipset ISA Bridge
(ICH2) (rev 05)
00:1f.1 IDE interface: Intel Corp. 82820 820 (Camino 2) Chipset IDE U100
(rev 05)
00:1f.2 USB Controller: Intel Corp. 82820 820 (Camino 2) Chipset USB (Hub A)
(rev 05)
00:1f.3 SMBus: Intel Corp. 82820 820 (Camino 2) Chipset SMBus (rev 05)
00:1f.4 USB Controller: Intel Corp. 82820 820 (Camino 2) Chipset USB (Hub B)
(rev 05)
01:00.0 VGA compatible controller: 3Dfx Interactive, Inc. Voodoo 3 (rev 01)
02:0a.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8029(AS)
02:0b.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139 (rev
10)
02:0d.0 Multimedia audio controller: Creative Labs SB Live! EMU10k1 (rev 05)
02:0d.1 Input device controller: Creative Labs SB Live! (rev 05)
02:0e.0 Multimedia video controller: Brooktree Corporation Bt848 TV with DMA
push (rev 11)



WHOLE DMESG

Linux version 2.4.19-pre4-ac3 (root@debian) (gcc version 2.95.4 20011002
(Debian prerelease)) #1 Mit Apr 17 01:59:49 CEST 2002
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 00000000000a0000 (usable)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000001ffeb000 (usable)
 BIOS-e820: 000000001ffeb000 - 000000001ffef000 (ACPI data)
 BIOS-e820: 000000001ffef000 - 000000001ffff000 (reserved)
 BIOS-e820: 000000001ffff000 - 0000000020000000 (ACPI NVS)
 BIOS-e820: 00000000fec00000 - 00000000fec10000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
 BIOS-e820: 00000000fff80000 - 0000000100000000 (reserved)
On node 0 totalpages: 131051
zone(0): 4096 pages.
zone(1): 126955 pages.
zone(2): 0 pages.
Kernel command line: BOOT_IMAGE=LinuxOLD ro root=301 hdc=ide-scsi
video=tdfxfb:1024x768-16@90
ide_setup: hdc=ide-scsi
Local APIC disabled by BIOS -- reenabling.
Found and enabled local APIC!
Initializing CPU#0
Detected 1351.969 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 2700.08 BogoMIPS
Memory: 514808k/524204k available (1388k kernel code, 9012k reserved, 419k
data, 268k init, 0k highmem)
Dentry cache hash table entries: 65536 (order: 7, 524288 bytes)
Inode cache hash table entries: 32768 (order: 6, 262144 bytes)
Mount cache hash table entries: 8192 (order: 4, 65536 bytes)
Buffer cache hash table entries: 32768 (order: 5, 131072 bytes)
Page-cache hash table entries: 131072 (order: 7, 524288 bytes)
CPU: Before vendor init, caps: 0383fbff 00000000 00000000, vendor = 0
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 256K
CPU: After vendor init, caps: 0383fbff 00000000 00000000 00000000
CPU:     After generic, caps: 0383fbff 00000000 00000000 00000000
CPU:             Common caps: 0383fbff 00000000 00000000 00000000
CPU: Intel(R) Celeron(TM) CPU                1300MHz stepping 01
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 1351.9529 MHz.
..... host bus clock speed is 103.9963 MHz.
cpu: 0, clocks: 1039963, slice: 519981
CPU0<T0:1039952,T1:519968,D:3,S:519981,C:1039963>
mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: Intel
PCI: PCI BIOS revision 2.10 entry at 0xf0e30, last bus=2
PCI: Using configuration type 1
PCI: Probing PCI hardware
PCI: Using IRQ router PIIX [8086/2440] at 00:1f.0
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
apm: BIOS version 1.2 Flags 0x03 (Driver version 1.16)
Starting kswapd
Journalled Block Device driver loaded
ACPI: APM is already active, exiting
parport0: PC-style at 0x378 (0x778) [PCSPP(,...)]
parport0: irq 7 detected
fb: Voodoo3 memory = 16384K
fb: MTRR's turned on
tdfxfb: reserving 1024 bytes for the hwcursor at e17ff000
Console: switching to colour frame buffer device 80x30
fb0: 3Dfx Voodoo3 frame buffer device
pty: 256 Unix98 ptys configured
Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ
SERIAL_PCI enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
ttyS01 at 0x02f8 (irq = 3) is a 16550A
lp0: using parport0 (polling).
block: 992 slots per queue, batch=248
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
PIIX4: IDE controller on PCI bus 00 dev f9
PIIX4: chipset revision 5
PIIX4: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0x9800-0x9807, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0x9808-0x980f, BIOS settings: hdc:DMA, hdd:DMA
hda: ST330630A, ATA DISK drive
hdb: ST38641A, ATA DISK drive
hdc: CD-W512EB, ATAPI CD/DVD-ROM drive
hdd: CD-532E-B, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: 59777640 sectors (30606 MB) w/2048KiB Cache, CHS=3720/255/63, UDMA(66)
hdb: 16809660 sectors (8607 MB) w/128KiB Cache, CHS=1046/255/63, UDMA(33)
hdd: ATAPI 32X CD-ROM drive, 128kB Cache, DMA
Uniform CD-ROM driver Revision: 3.12
Partition check:
 hda: hda1 hda2 hda3
 hdb: hdb1
ne2k-pci.c:v1.02 10/19/2000 D. Becker/P. Gortmaker
  http://www.scyld.com/network/ne2k-pci.html
PCI: Found IRQ 9 for device 02:0a.0
eth0: RealTek RTL-8029 found at 0xb800, IRQ 9, 52:54:05:DE:C1:29.
PPP generic driver version 2.4.2
PPP Deflate Compression module registered
PPP BSD Compression module registered
8139too Fast Ethernet driver 0.9.24
PCI: Found IRQ 9 for device 02:0b.0
PCI: Sharing IRQ 9 with 00:1f.4
eth1: RealTek RTL8139 Fast Ethernet at 0xe2802000, 00:00:e8:7b:81:f5, IRQ 9
eth1:  Identified 8139 chip type 'RTL-8139A'
Linux agpgart interface v0.99 (c) Jeff Hartmann
agpgart: Maximum main memory to use for agp memory: 439M
agpgart: Detected Intel i815 chipset
agpgart: AGP aperture is 64M @ 0xf8000000
[drm] Initialized tdfx 1.0.0 20010216 on minor 0
Creative EMU10K1 PCI Audio Driver, version 0.18, 02:01:03 Apr 17 2002
PCI: Found IRQ 9 for device 02:0d.0
emu10k1: EMU10K1 rev 5 model 0x20 found, IO at 0xb000-0xb01f, IRQ 9
ac97_codec: AC97  codec, id: 0x5452:0x4123 (TriTech TR A5)
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 4096 buckets, 32Kbytes
TCP: Hash tables configured (established 32768 bind 32768)
ip_conntrack (4095 buckets, 32760 max)
ip_tables: (C) 2000-2002 Netfilter core team
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 268k freed
Adding Swap: 393584k swap-space (priority -1)
EXT3 FS 2.4-0.9.17, 10 Jan 2002 on ide0(3,1), internal journal
SCSI subsystem driver Revision: 1.00
scsi0 : SCSI host adapter emulation for IDE ATAPI devices
  Vendor: TEAC      Model: CD-W512EB         Rev: 2.0B
  Type:   CD-ROM                             ANSI SCSI revision: 02
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.17, 10 Jan 2002 on ide0(3,3), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.17, 10 Jan 2002 on ide0(3,65), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
eth1: Setting half-duplex based on auto-negotiated partner ability 0000.
mtrr: 0xf6000000,0x2000000 overlaps existing 0xf6000000,0x1000000
mtrr: base(0xf6000000) is not aligned on a size(0x2096000) boundary
VFS: Disk change detected on device ide1(22,64)
i2c-core.o: i2c core module
i2c-algo-bit.o: i2c bit algorithm module
Linux video capture interface: v1.00
bttv: driver version 0.7.91 loaded
bttv: using 2 buffers with 2080k (4160k total) for capture
bttv: Host bridge is Intel Corp. 82815 815 Chipset Host Bridge and Memory
Controller Hub
bttv: Bt8xx card found (0).
PCI: Found IRQ 12 for device 02:0e.0
bttv0: Bt848 (rev 17) at 02:0e.0, irq: 12, latency: 32, memory: 0xf5000000
bttv0: using: BT848(Hauppauge (bt848)) [card=2,insmod option]
bttv0: Hauppauge/Voodoo msp34xx: reset line init [5]
i2c-core.o: adapter bt848 #0 registered as adapter 0.
bttv0: Hauppauge eeprom: model=56104, tuner=Temic 4002FH5 (0), radio=no
bttv0: i2c: checking for MSP34xx @ 0x80... not found
bttv0: i2c: checking for TDA9875 @ 0xb0... not found
bttv0: i2c: checking for TDA7432 @ 0x8a... not found
tvaudio: TV audio decoder + audio/video mux driver
tvaudio: known chips:
tda9840,tda9873h,tda9874h/a,tda9850,tda9855,tea6300,tea6420,tda8425,pic16c54 (PV951)
i2c-core.o: driver generic i2c audio driver registered.
i2c-core.o: driver i2c TV tuner driver registered.
tuner: probing bt848 #0 i2c adapter [id=0x10005]
tuner: chip found @ 0xc2
bttv0: i2c attach [client=Temic PAL (4002 FH5),ok]
i2c-core.o: client [Temic PAL (4002 FH5)] registered to adapter [bt848
#0](pos. 0).
bttv0: registered device video0
bttv0: registered device vbi0
netwatch uses obsolete (PF_INET,SOCK_PACKET)
VFS: Disk change detected on device ide1(22,64)
VFS: Disk change detected on device ide1(22,64)
scsi : aborting command due to timeout : pid 45643, scsi0, channel 0, id 0,
lun 0 0x35 00 00 00 00 00 00 00 00 00 
hdc: irq timeout: status=0xd0 { Busy }
hdc: DMA disabled
hdc: ATAPI reset complete
hdc: irq timeout: status=0x80 { Busy }
hdc: ATAPI reset complete
hdc: irq timeout: status=0xd0 { Busy }
VFS: Disk change detected on device ide1(22,64)
Attached scsi CD-ROM sr0 at scsi0, channel 0, id 0, lun 0
sr0: CDROM (ioctl) error, command: 0x1a 00 2a 00 80 00 
Deferred sr00:00: sns = 71  3
ASC= 2 ASCQ= 0
Raw sense data:0x71 0x00 0x03 0x00 0x00 0x00 0x00 0x0a 0x00 0x00 0x00 0x00
0x02 0x00 0x00 0x00 0x00 0x00 
sr0: scsi-1 drive
VFS: Disk change detected on device sr(11,0)
VFS: Disk change detected on device ide1(22,64)
scsi : aborting command due to timeout : pid 45693, scsi0, channel 0, id 0,
lun 0 0x2a 00 ff ff ff 6a 00 00 1b 00 
hdc: irq timeout: status=0xd0 { Busy }
hdc: ATAPI reset complete
hdc: irq timeout: status=0x80 { Busy }
hdc: ATAPI reset complete
hdc: irq timeout: status=0xd0 { Busy }
VFS: Disk change detected on device sr(11,0)
VFS: Disk change detected on device sr(11,0)
VFS: Disk change detected on device sr(11,0)
VFS: Disk change detected on device sr(11,0)
VFS: Disk change detected on device sr(11,0)
scsi : aborting command due to timeout : pid 45871, scsi0, channel 0, id 0,
lun 0 0x2a 00 00 00 00 00 00 00 1f 00 
hdc: irq timeout: status=0xd0 { Busy }
hdc: ATAPI reset complete
hdc: irq timeout: status=0x80 { Busy }
hdc: ATAPI reset complete
hdc: irq timeout: status=0xd0 { Busy }
VFS: Disk change detected on device ide1(22,64)


Hope you can help.
Answers to mime@gmx.li please cause I am not worthy subscribing to list yet.
Best regards,
michael

-- 
GMX - Die Kommunikationsplattform im Internet.
http://www.gmx.net

