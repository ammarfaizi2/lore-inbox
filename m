Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261331AbVB0CWT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261331AbVB0CWT (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Feb 2005 21:22:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261333AbVB0CWT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Feb 2005 21:22:19 -0500
Received: from smtp4.wlink.com.np ([202.79.32.87]:7785 "HELO
	smtp4.wlink.com.np") by vger.kernel.org with SMTP id S261331AbVB0CVL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Feb 2005 21:21:11 -0500
Reply-To: <bhamal@wlink.com.np>
From: "bj" <bhamal@wlink.com.np>
To: <linux-kernel@vger.kernel.org>
Subject: System stops because /var/log not found after moving to  new partition 
Date: Sat, 26 Feb 2005 21:21:51 +0545
Message-ID: <001401c51c18$fecc6c90$0db3fea9@kath.state.gov>
MIME-Version: 1.0
Content-Type: multipart/mixed;	boundary="----=_NextPart_000_0015_01C51C49.30F5C290"
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook CWS, Build 9.0.2416 (9.0.2910.0)
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
X-Spam-Check-By: smtp3.wlink.com.np
Spam: No ; -4.2 / 5.0
X-Spam-Status-WL: No, hits=-4.2 required=5.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

------=_NextPart_000_0015_01C51C49.30F5C290
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit

Hi !

I have a Red Hat 8.0 on a intel 2.4 machine with 512 MB .

I have kernel 2.4.20-30.8-legacy & 2.4.20-30.8-legacy bigmem.

I used to have all my directories /var , /tmp , /usr , /home under one
partition / .

Thanks to everybody , now I was able to re-partition my drive into extended
drives (drives < 4) and move my /var , /tmp into hda5 & ,my /usr , /home
into /hda6 .


Bu I am facing one problem.

When I boot my system logger does not see the /var/log which has been moved
to the new location  .

The system just hangs .

When I boot in single mode by passing an argument to my kernel that does
show in the dmesg in the new location .

In addtion when I run a command like 'clear ' it shows that it could not
find the library to run it .


I have mounted hda5 & hda6 in my fstab .

I did create soft link for my new var  , new tmp & new usr to the the /var ,
/tmp , /usr as ffs :-

ln -s /mnt/hda5/var  /var
ln -s /mnt/hda5/tmp /tmp

ln -s /mnt/hda6/usr /usr

I moved the old files using the ff commands:-

cd source directory

cp -ax * /mnt/usr5/var

or

cd /src/dir ; tar cf - . | (cd /dest/dir && tar xvf - )




But still it does not work .

Please find attached the dmesg & library error and fstab.

Please advice.

Thank you for your help in advance.

bj





------=_NextPart_000_0015_01C51C49.30F5C290
Content-Type: text/plain;
	name="dmesg.txt"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="dmesg.txt"

Linux version 2.4.20-30.8.legacy (legacy@yoda.loki.me) (gcc version 3.2 =
20020903 (Red Hat Linux 8.0 3.2-7)) #1 Fri Feb 20 17:47:48 PST 2004=0A=
BIOS-provided physical RAM map:=0A=
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)=0A=
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)=0A=
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)=0A=
 BIOS-e820: 0000000000100000 - 000000001fff0000 (usable)=0A=
 BIOS-e820: 000000001fff0000 - 000000001fff3000 (ACPI NVS)=0A=
 BIOS-e820: 000000001fff3000 - 0000000020000000 (ACPI data)=0A=
 BIOS-e820: 00000000fec00000 - 0000000100000000 (reserved)=0A=
0MB HIGHMEM available.=0A=
511MB LOWMEM available.=0A=
On node 0 totalpages: 131056=0A=
zone(0): 4096 pages.=0A=
zone(1): 126960 pages.=0A=
zone(2): 0 pages.=0A=
Kernel command line: ro root=3DLABEL=3D/ hdb=3Dide-scsi=0A=
ide_setup: hdb=3Dide-scsi=0A=
Initializing CPU#0=0A=
Detected 2393.991 MHz processor.=0A=
Console: colour VGA+ 80x25=0A=
Calibrating delay loop... 4771.02 BogoMIPS=0A=
Memory: 511512k/524224k available (1340k kernel code, 10148k reserved, =
999k data, 128k init, 0k highmem)=0A=
Dentry cache hash table entries: 65536 (order: 7, 524288 bytes)=0A=
Inode cache hash table entries: 32768 (order: 6, 262144 bytes)=0A=
Mount cache hash table entries: 512 (order: 0, 4096 bytes)=0A=
Buffer-cache hash table entries: 32768 (order: 5, 131072 bytes)=0A=
Page-cache hash table entries: 131072 (order: 7, 524288 bytes)=0A=
CPU: Trace cache: 12K uops, L1 D cache: 8K=0A=
CPU: L2 cache: 512K=0A=
Intel machine check architecture supported.=0A=
Intel machine check reporting enabled on CPU#0.=0A=
CPU:     After generic, caps: bfebfbff 00000000 00000000 00000000=0A=
CPU:             Common caps: bfebfbff 00000000 00000000 00000000=0A=
CPU: Intel(R) Pentium(R) 4 CPU 2.40GHz stepping 07=0A=
Enabling fast FPU save and restore... done.=0A=
Enabling unmasked SIMD FPU exception support... done.=0A=
Checking 'hlt' instruction... OK.=0A=
POSIX conformance testing by UNIFIX=0A=
mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)=0A=
mtrr: detected mtrr type: Intel=0A=
PCI: PCI BIOS revision 2.10 entry at 0xfb270, last bus=3D1=0A=
PCI: Using configuration type 1=0A=
PCI: Probing PCI hardware=0A=
PCI: Using IRQ router VIA [1106/3177] at 00:11.0=0A=
isapnp: Scanning for PnP cards...=0A=
isapnp: No Plug & Play device found=0A=
Linux NET4.0 for Linux 2.4=0A=
Based upon Swansea University Computer Society NET3.039=0A=
Initializing RT netlink socket=0A=
apm: BIOS version 1.2 Flags 0x07 (Driver version 1.16)=0A=
Starting kswapd=0A=
VFS: Disk quotas vdquot_6.5.1=0A=
pty: 2048 Unix98 ptys configured=0A=
Serial driver version 5.05c (2001-07-08) with MANY_PORTS MULTIPORT =
SHARE_IRQ SERIAL_PCI ISAPNP enabled=0A=
ttyS0 at 0x03f8 (irq =3D 4) is a 16550A=0A=
ttyS1 at 0x02f8 (irq =3D 3) is a 16550A=0A=
Real Time Clock Driver v1.10e=0A=
Floppy drive(s): fd0 is 1.44M=0A=
FDC 0 is a post-1991 82077=0A=
NET4: Frame Diverter 0.46=0A=
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize=0A=
Uniform Multi-Platform E-IDE driver Revision: 7.00beta3-.2.4=0A=
ide: Assuming 33MHz system bus speed for PIO modes; override with =
idebus=3Dxx=0A=
VP_IDE: IDE controller at PCI slot 00:11.1=0A=
VP_IDE: chipset revision 6=0A=
VP_IDE: not 100% native mode: will probe irqs later=0A=
VP_IDE: VIA vt8235 (rev 00) IDE UDMA133 controller on pci00:11.1=0A=
    ide0: BM-DMA at 0xdc00-0xdc07, BIOS settings: hda:DMA, hdb:DMA=0A=
    ide1: BM-DMA at 0xdc08-0xdc0f, BIOS settings: hdc:pio, hdd:DMA=0A=
hda: ST360020A, ATA DISK drive=0A=
hdb: SONY CD-RW CRX1611, ATAPI CD/DVD-ROM drive=0A=
blk: queue c03a6260, I/O limit 4095Mb (mask 0xffffffff)=0A=
hdd: ST380011A, ATA DISK drive=0A=
blk: queue c03a6808, I/O limit 4095Mb (mask 0xffffffff)=0A=
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14=0A=
ide1 at 0x170-0x177,0x376 on irq 15=0A=
hda: attached ide-disk driver.=0A=
hda: host protected area =3D> 1=0A=
hda: 117231408 sectors (60022 MB) w/2048KiB Cache, CHS=3D7297/255/63, =
UDMA(100)=0A=
hdd: attached ide-disk driver.=0A=
hdd: host protected area =3D> 1=0A=
hdd: 156301488 sectors (80026 MB) w/2048KiB Cache, CHS=3D9729/255/63, =
UDMA(100)=0A=
ide-floppy driver 0.99.newide=0A=
Partition check:=0A=
 hda:hda: dma_intr: status=3D0x51 { DriveReady SeekComplete Error }=0A=
hda: dma_intr: error=3D0x84 { DriveStatusError BadCRC }=0A=
hda: dma_intr: status=3D0x51 { DriveReady SeekComplete Error }=0A=
hda: dma_intr: error=3D0x84 { DriveStatusError BadCRC }=0A=
hda: dma_intr: status=3D0x51 { DriveReady SeekComplete Error }=0A=
hda: dma_intr: error=3D0x84 { DriveStatusError BadCRC }=0A=
hda: dma_intr: status=3D0x51 { DriveReady SeekComplete Error }=0A=
hda: dma_intr: error=3D0x84 { DriveStatusError BadCRC }=0A=
blk: queue c03a6260, I/O limit 4095Mb (mask 0xffffffff)=0A=
hdb: DMA disabled=0A=
ide0: reset: success=0A=
 hda1 hda2 hda3 hda4 < hda5 hda6 >=0A=
 hdd: hdd1 hdd2 < hdd5 >=0A=
ide-floppy driver 0.99.newide=0A=
md: md driver 0.90.0 MAX_MD_DEVS=3D256, MD_SB_DISKS=3D27=0A=
md: Autodetecting RAID arrays.=0A=
md: autorun ...=0A=
md: ... autorun DONE.=0A=
NET4: Linux TCP/IP 1.0 for NET4.0=0A=
IP Protocols: ICMP, UDP, TCP, IGMP=0A=
IP: routing cache hash table of 4096 buckets, 32Kbytes=0A=
TCP: Hash tables configured (established 32768 bind 65536)=0A=
Linux IP multicast router 0.06 plus PIM-SM=0A=
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.=0A=
RAMDISK: Compressed image found at block 0=0A=
Freeing initrd memory: 126k freed=0A=
VFS: Mounted root (ext2 filesystem).=0A=
Journalled Block Device driver loaded=0A=
kjournald starting.  Commit interval 5 seconds=0A=
EXT3-fs: mounted filesystem with ordered data mode.=0A=
Freeing unused kernel memory: 128k freed=0A=
usb.c: registered new driver usbdevfs=0A=
usb.c: registered new driver hub=0A=
PCI: Found IRQ 11 for device 00:10.3=0A=
PCI: Sharing IRQ 11 with 00:0c.0=0A=
ehci-hcd 00:10.3: VIA Technologies, Inc. USB 2.0=0A=
ehci-hcd 00:10.3: irq 11, pci mem e0849000=0A=
usb.c: new USB bus registered, assigned bus number 1=0A=
PCI: 00:10.3 PCI cache line size set incorrectly (32 bytes) by BIOS/FW.=0A=
PCI: 00:10.3 PCI cache line size corrected to 128.=0A=
ehci-hcd 00:10.3: USB 2.0 enabled, EHCI 1.00, driver 2003-Jan-22=0A=
hub.c: USB hub found=0A=
hub.c: 6 ports detected=0A=
usb.c: registered new driver hiddev=0A=
usb.c: registered new driver hid=0A=
hid-core.c: v1.8.1 Andreas Gal, Vojtech Pavlik <vojtech@suse.cz>=0A=
hid-core.c: USB HID support drivers=0A=
mice: PS/2 mouse device common for all mice=0A=
hub.c: new USB device 00:10.3-1, assigned address 2=0A=
usb.c: USB device 2 (vend/prod 0x8ec/0x12) is not claimed by any active =
driver.=0A=
EXT3 FS 2.4-0.9.19, 19 August 2002 on ide0(3,2), internal journal=0A=
Adding Swap: 1052248k swap-space (priority -1)=0A=
hda: dma_intr: status=3D0x51 { DriveReady SeekComplete Error }=0A=
hda: dma_intr: error=3D0x84 { DriveStatusError BadCRC }=0A=
hda: dma_intr: status=3D0x51 { DriveReady SeekComplete Error }=0A=
hda: dma_intr: error=3D0x84 { DriveStatusError BadCRC }=0A=
hda: dma_intr: status=3D0x51 { DriveReady SeekComplete Error }=0A=
hda: dma_intr: error=3D0x84 { DriveStatusError BadCRC }=0A=
hda: dma_intr: status=3D0x51 { DriveReady SeekComplete Error }=0A=
hda: dma_intr: error=3D0x84 { DriveStatusError BadCRC }=0A=
ide0: reset: success=0A=
SCSI subsystem driver Revision: 1.00=0A=
Initializing USB Mass Storage driver...=0A=
usb.c: registered new driver usb-storage=0A=
scsi0 : SCSI emulation for USB Mass Storage devices=0A=
  Vendor: Kingston  Model: DataTraveler2.0   Rev: 4.80=0A=
  Type:   Direct-Access                      ANSI SCSI revision: 02=0A=
WARNING: USB Mass Storage data integrity not assured=0A=
USB Mass Storage device found at 2=0A=
USB Mass Storage support registered.=0A=
hdb: attached ide-scsi driver.=0A=
scsi1 : SCSI host adapter emulation for IDE ATAPI devices=0A=
  Vendor: SONY      Model: CD-RW CRX1611     Rev: TYS3=0A=
  Type:   CD-ROM                             ANSI SCSI revision: 02=0A=

------=_NextPart_000_0015_01C51C49.30F5C290
Content-Type: text/plain;
	name="fstab.txt"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="fstab.txt"

LABEL=3D/                 /                       ext3    defaults       =
 1 1=0A=
none                    /dev/pts                devpts  =
gid=3D5,mode=3D620  0 0=0A=
none                    /proc                   proc    defaults        =
0 0=0A=
/dev/hda5		/mnt/hda5		ext3	defaults	1 2=0A=
/dev/hda6		/mnt/hda6		ext3	defaults	1 3	=0A=
none                    /dev/shm                tmpfs   defaults        =
0 0=0A=
/dev/hda3               swap                    swap    defaults        =
0 0=0A=
/dev/fd0                /mnt/floppy             auto    =
noauto,owner,kudzu 0 0=0A=
/dev/cdrom              /mnt/cdrom              iso9660 =
noauto,owner,kudzu,ro 0 0=0A=

------=_NextPart_000_0015_01C51C49.30F5C290
Content-Type: text/plain;
	name="liberror.txt"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="liberror.txt"

/mnt/hda6/usr/bin/clear: error while loading shared libraries: =
libncurses.so.5: cannot open shared object file: No such file or =
directory=0A=

------=_NextPart_000_0015_01C51C49.30F5C290--

