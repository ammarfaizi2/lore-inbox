Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267173AbSK2XAp>; Fri, 29 Nov 2002 18:00:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267174AbSK2XAp>; Fri, 29 Nov 2002 18:00:45 -0500
Received: from 12-235-215-48.client.attbi.com ([12.235.215.48]:50048 "EHLO
	locateinc.com") by vger.kernel.org with ESMTP id <S267173AbSK2XAk> convert rfc822-to-8bit;
	Fri, 29 Nov 2002 18:00:40 -0500
Subject: [2.4.20] Trouble with  i845G/HPT372/WD1000JB
Date: Fri, 29 Nov 2002 15:07:59 -0800
MIME-Version: 1.0
Thread-Topic: [2.4.20] Trouble with  i845G/HPT372/WD1000JB
Importance: normal
X-Priority: 3
Sensitivity: Normal
Thread-Index: AcKX+9Hm4uhTqen3TkmAiWcmW/8XFAAABi5w
From: "David Watson" <david@locateinc.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
X-Mailer: CommuniGate Pro Connector 1.0.32
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Message-ID: <auto-000000750011@locateinc.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


In 2.4.20 (I tried several rc's, as well as pure 2.4.20), I receive the following errors when booting, associated with the Western Digital WD1000JB drive attached as hde, a standalone non-RAID non-boot drive, on the Highpoint IDE port on my Epox 4G4A+ (i845).  Flashing to the latest Epox BIOS didn't help; neither does toggling APIC on or off in the BIOS.  The drive appears to be unusable under 2.4.20.

However, it has always worked fine and fast in UDMA(100) mode in 2.4.19-ac4 with the Diskcert-11 patch and an equivalent .config.

Attached: `grep '^C' .config`, followed by slightly edited dmesg content.


 -David.


CONFIG_X86=y
CONFIG_UID16=y
CONFIG_EXPERIMENTAL=y
CONFIG_MODULES=y
CONFIG_MODVERSIONS=y
CONFIG_KMOD=y
CONFIG_MPENTIUM4=y
CONFIG_X86_WP_WORKS_OK=y
CONFIG_X86_INVLPG=y
CONFIG_X86_CMPXCHG=y
CONFIG_X86_XADD=y
CONFIG_X86_BSWAP=y
CONFIG_X86_POPAD_OK=y
CONFIG_RWSEM_XCHGADD_ALGORITHM=y
CONFIG_X86_L1_CACHE_SHIFT=7
CONFIG_X86_HAS_TSC=y
CONFIG_X86_GOOD_APIC=y
CONFIG_X86_PGE=y
CONFIG_X86_USE_PPRO_CHECKSUM=y
CONFIG_X86_F00F_WORKS_OK=y
CONFIG_X86_MSR=m
CONFIG_NOHIGHMEM=y
CONFIG_X86_TSC=y
CONFIG_NET=y
CONFIG_PCI=y
CONFIG_PCI_GOANY=y
CONFIG_PCI_BIOS=y
CONFIG_PCI_DIRECT=y
CONFIG_ISA=y
CONFIG_PCI_NAMES=y
CONFIG_HOTPLUG=y
CONFIG_SYSVIPC=y
CONFIG_SYSCTL=y
CONFIG_KCORE_ELF=y
CONFIG_BINFMT_AOUT=m
CONFIG_BINFMT_ELF=y
CONFIG_BINFMT_MISC=m
CONFIG_PARPORT=m
CONFIG_PARPORT_PC=m
CONFIG_PARPORT_PC_CML1=m
CONFIG_PARPORT_SERIAL=m
CONFIG_PARPORT_1284=y
CONFIG_PNP=m
CONFIG_ISAPNP=m
CONFIG_BLK_DEV_FD=y
CONFIG_BLK_DEV_LOOP=y
CONFIG_BLK_DEV_RAM=y
CONFIG_BLK_DEV_RAM_SIZE=4096
CONFIG_BLK_DEV_INITRD=y
CONFIG_PACKET=y
CONFIG_FILTER=y
CONFIG_UNIX=y
CONFIG_INET=y
CONFIG_IP_MULTICAST=y
CONFIG_IP_ADVANCED_ROUTER=y
CONFIG_IDE=y
CONFIG_BLK_DEV_IDE=y
CONFIG_BLK_DEV_IDEDISK=y
CONFIG_BLK_DEV_IDECD=y
CONFIG_BLK_DEV_CMD640=y
CONFIG_BLK_DEV_RZ1000=y
CONFIG_BLK_DEV_IDEPCI=y
CONFIG_IDEPCI_SHARE_IRQ=y
CONFIG_BLK_DEV_IDEDMA_PCI=y
CONFIG_IDEDMA_PCI_AUTO=y
CONFIG_BLK_DEV_IDEDMA=y
CONFIG_BLK_DEV_ADMA=y
CONFIG_BLK_DEV_HPT366=y
CONFIG_BLK_DEV_PIIX=y
CONFIG_PIIX_TUNING=y
CONFIG_BLK_DEV_PDC202XX=y
CONFIG_PDC202XX_BURST=y
CONFIG_PDC202XX_FORCE=y
CONFIG_IDEDMA_AUTO=y
CONFIG_BLK_DEV_IDE_MODES=y
CONFIG_NETDEVICES=y
CONFIG_DUMMY=m
CONFIG_NET_ETHERNET=y
CONFIG_NET_VENDOR_3COM=y
CONFIG_VORTEX=m
CONFIG_NET_PCI=y
CONFIG_EEPRO100=m
CONFIG_8139CP=m
CONFIG_8139TOO=m
CONFIG_8139TOO_8129=y
CONFIG_PPP=m
CONFIG_PPP_ASYNC=m
CONFIG_PPP_SYNC_TTY=m
CONFIG_PPP_DEFLATE=m
CONFIG_PPP_BSDCOMP=m
CONFIG_VT=y
CONFIG_VT_CONSOLE=y
CONFIG_SERIAL=m
CONFIG_UNIX98_PTYS=y
CONFIG_UNIX98_PTY_COUNT=256
CONFIG_PRINTER=m
CONFIG_MOUSE=y
CONFIG_PSMOUSE=y
CONFIG_NVRAM=m
CONFIG_RTC=m
CONFIG_AGP=m
CONFIG_AGP_INTEL=y
CONFIG_AGP_I810=y
CONFIG_AGP_VIA=y
CONFIG_AGP_AMD=y
CONFIG_AGP_SIS=y
CONFIG_AGP_ALI=y
CONFIG_DRM=y
CONFIG_DRM_NEW=y
CONFIG_DRM_TDFX=m
CONFIG_DRM_R128=m
CONFIG_DRM_RADEON=m
CONFIG_DRM_I810=m
CONFIG_AUTOFS4_FS=m
CONFIG_EXT3_FS=y
CONFIG_JBD=y
CONFIG_FAT_FS=m
CONFIG_MSDOS_FS=m
CONFIG_VFAT_FS=m
CONFIG_TMPFS=y
CONFIG_RAMFS=y
CONFIG_ISO9660_FS=m
CONFIG_JOLIET=y
CONFIG_JFS_FS=m
CONFIG_PROC_FS=y
CONFIG_DEVFS_FS=y
CONFIG_DEVFS_MOUNT=y
CONFIG_DEVPTS_FS=y
CONFIG_EXT2_FS=y
CONFIG_UDF_FS=m
CONFIG_NFS_FS=m
CONFIG_NFS_V3=y
CONFIG_NFSD=m
CONFIG_NFSD_V3=y
CONFIG_SUNRPC=m
CONFIG_LOCKD=m
CONFIG_LOCKD_V4=y
CONFIG_SMB_FS=m
CONFIG_NCP_FS=m
CONFIG_MSDOS_PARTITION=y
CONFIG_SMB_NLS=y
CONFIG_NLS=y
CONFIG_NLS_DEFAULT="iso8859-1"
CONFIG_NLS_CODEPAGE_437=m
CONFIG_NLS_ISO8859_1=m
CONFIG_VGA_CONSOLE=y
CONFIG_VIDEO_SELECT=y
CONFIG_FB=y
CONFIG_DUMMY_CONSOLE=y
CONFIG_FB_VESA=y
CONFIG_FB_VGA16=m
CONFIG_VIDEO_SELECT=y
CONFIG_FB_ATY128=m
CONFIG_FB_3DFX=m
CONFIG_FBCON_CFB8=y
CONFIG_FBCON_CFB16=y
CONFIG_FBCON_CFB24=y
CONFIG_FBCON_CFB32=y
CONFIG_FBCON_VGA_PLANES=m
CONFIG_FONT_8x8=y
CONFIG_FONT_8x16=y
CONFIG_SOUND=m
CONFIG_SOUND_ES1371=m
CONFIG_SOUND_ICH=m
CONFIG_USB=m
CONFIG_USB_UHCI=m
CONFIG_USB_UHCI_ALT=m
CONFIG_USB_PRINTER=m
CONFIG_USB_SCANNER=m
CONFIG_USB_USS720=m
CONFIG_ZLIB_INFLATE=m
CONFIG_ZLIB_DEFLATE=m


Linux version 2.4.20 (root@stone.locateinc.com) (gcc version 3.2 (Mandrake Linux 9.0 3.2-1mdk)) #2 Thu Nov 28 22:16:11 PST 2002
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000001f7f0000 (usable)
 BIOS-e820: 000000001f7f0000 - 000000001f7f3000 (ACPI NVS)
 BIOS-e820: 000000001f7f3000 - 000000001f800000 (ACPI data)
 BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
 BIOS-e820: 00000000ffb00000 - 0000000100000000 (reserved)
503MB LOWMEM available.
On node 0 totalpages: 129008
zone(0): 4096 pages.
zone(1): 124912 pages.
zone(2): 0 pages.
Kernel command line: auto BOOT_IMAGE=2.4.20 ro root=301
Initializing CPU#0
Detected 1514.993 MHz processor.
Console: colour dummy device 80x25
Calibrating delay loop... 3021.20 BogoMIPS
Memory: 508204k/516032k available (1092k kernel code, 7440k reserved, 404k data, 100k init, 0k highmem)
Dentry cache hash table entries: 65536 (order: 7, 524288 bytes)
Inode cache hash table entries: 32768 (order: 6, 262144 bytes)
Mount-cache hash table entries: 8192 (order: 4, 65536 bytes)
Buffer-cache hash table entries: 32768 (order: 5, 131072 bytes)
Page-cache hash table entries: 131072 (order: 7, 524288 bytes)
CPU: L1 I cache: 0K, L1 D cache: 8K
CPU: L2 cache: 256K
CPU:     After generic, caps: 3febfbff 00000000 00000000 00000000
CPU:             Common caps: 3febfbff 00000000 00000000 00000000
CPU: Intel(R) Pentium(R) 4 CPU 1.50GHz stepping 02
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
PCI: PCI BIOS revision 2.10 entry at 0xfae70, last bus=1
PCI: Using configuration type 1
PCI: Probing PCI hardware
Transparent bridge - Intel Corp. 82801BA/CA/DB PCI Bridge
PCI: Using IRQ router PIIX [8086/24c0] at 00:1f.0
PCI: Found IRQ 5 for device 00:1f.1
PCI: Sharing IRQ 5 with 00:02.0
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
Starting kswapd
Journalled Block Device driver loaded
devfs: v1.12c (20020818) Richard Gooch (rgooch@atnf.csiro.au)
devfs: boot_options: 0x1
vesafb: framebuffer at 0xe0000000, mapped to 0xe0000000, size 8000k
vesafb: mode is 800x600x16, linelength=1600, pages=7
vesafb: protected mode interface info at a5f3:1f5f
vesafb: scrolling: redraw
vesafb: directcolor: size=0:5:6:5, shift=0:11:5:0
Console: switching to colour frame buffer device 100x37
fb0: VESA VGA frame buffer device
pty: 256 Unix98 ptys configured
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ICH4: IDE controller on PCI bus 00 dev f9
PCI: Device 00:1f.1 not available because of resource collisions
PCI: Found IRQ 5 for device 00:1f.1
PCI: Sharing IRQ 5 with 00:02.0
ICH4: BIOS setup was incomplete.
ICH4: chipset revision 1
ICH4: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xf000-0xf007, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xf008-0xf00f, BIOS settings: hdc:DMA, hdd:pio
HPT372: IDE controller on PCI bus 01 dev 18
PCI: Found IRQ 11 for device 01:03.0
HPT372: chipset revision 5
HPT372: not 100% native mode: will probe irqs later
HPT370: using 33MHz PCI clock
    ide2: BM-DMA at 0xa000-0xa007, BIOS settings: hde:DMA, hdf:pio
    ide3: BM-DMA at 0xa008-0xa00f, BIOS settings: hdg:pio, hdh:pio
hda: MAXTOR 6L080L4, ATA DISK drive
hdc: DVD-ROM DDU220E, ATAPI CD/DVD-ROM drive
hde: WDC WD1000JB-32CWE0, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
ide2 at 0x9000-0x9007,0x9402 on irq 11
blk: queue c02b7444, I/O limit 4095Mb (mask 0xffffffff)
hda: 156355584 sectors (80054 MB) w/1819KiB Cache, CHS=9732/255/63, UDMA(100)
blk: queue c02b7acc, I/O limit 4095Mb (mask 0xffffffff)
hde: 195371568 sectors (100030 MB) w/8192KiB Cache, CHS=193821/16/63, UDMA(100)
hdc: ATAPI DVD-ROM drive, 512kB Cache, DMA
Uniform CD-ROM driver Revision: 3.12
Partition check:
 /dev/ide/host0/bus0/target0/lun0: p1 p2 < p5 p6 p7 p8 >
 /dev/ide/host2/bus0/target0/lun0: p1
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
loop: loaded (max 8 devices)
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 4096 buckets, 32Kbytes
TCP: Hash tables configured (established 32768 bind 65536)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
RAMDISK: Compressed image found at block 0
Freeing initrd memory: 50k freed
VFS: Mounted root (ext2 filesystem).
Mounted devfs on /dev
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
Mounted devfs on /dev
Freeing unused kernel memory: 100k freed
Real Time Clock Driver v1.10e
usb.c: registered new driver hub
usb-uhci.c: $Revision: 1.275 $ time 22:11:47 Nov 28 2002
usb-uhci.c: High bandwidth mode enabled
PCI: Setting latency timer of device 00:1d.0 to 64
usb-uhci.c: USB UHCI at I/O 0xb800, IRQ 5
usb-uhci.c: Detected 2 ports
usb.c: new USB bus registered, assigned bus number 1
hub.c: USB hub found
hub.c: 2 ports detected
PCI: Setting latency timer of device 00:1d.1 to 64
usb-uhci.c: USB UHCI at I/O 0xb000, IRQ 10
usb-uhci.c: Detected 2 ports
usb.c: new USB bus registered, assigned bus number 2
hub.c: USB hub found
hub.c: 2 ports detected
PCI: Setting latency timer of device 00:1d.2 to 64
usb-uhci.c: USB UHCI at I/O 0xb400, IRQ 11
usb-uhci.c: Detected 2 ports
usb.c: new USB bus registered, assigned bus number 3
hub.c: USB hub found
hub.c: 2 ports detected
usb-uhci.c: v1.275:USB Universal Host Controller Interface driver
EXT3 FS 2.4-0.9.19, 19 August 2002 on ide0(3,1), internal journal
Adding Swap: 2097136k swap-space (priority -1)
hub.c: new USB device 00:1d.0-2, assigned address 2
usb.c: USB device 2 (vend/prod 0x4b8/0x5) is not claimed by any active driver.
hde: dma_intr: status=0xff { Busy }
hde: DMA disabled
usb.c: registered new driver usblp
printer.c: usblp0: USB Bidirectional printer dev 2 if 0 alt 0 proto 2 vid 0x04B8 pid 0x0005
printer.c: v0.11: USB Printer Device Class driver
ide2: reset timed-out, status=0xff
hde: status timeout: status=0xff { Busy }
hde: drive not ready for command
ide2: reset timed-out, status=0xff
end_request: I/O error, dev 21:01 (hde), sector 626904
end_request: I/O error, dev 21:01 (hde), sector 626906
end_request: I/O error, dev 21:01 (hde), sector 626908
end_request: I/O error, dev 21:01 (hde), sector 626910
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.19, 19 August 2002 on ide0(3,6), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.19, 19 August 2002 on ide0(3,7), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.19, 19 August 2002 on ide0(3,8), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
end_request: I/O error, dev 21:01 (hde), sector 2
EXT3-fs: unable to read superblock
8139too Fast Ethernet driver 0.9.26
PCI: Found IRQ 10 for device 01:04.0
eth0: RealTek RTL8139 Fast Ethernet at 0xe07f4000, 00:04:61:00:75:7d, IRQ 10
eth0:  Identified 8139 chip type 'RTL-8139C'
eth0: Setting 100mbps full-duplex based on auto-negotiated partner ability 45e1.
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
end_request: I/O error, dev 21:01 (hde), sector 2
EXT3-fs: unable to read superblock
Linux agpgart interface v0.99 (c) Jeff Hartmann
agpgart: Maximum main memory to use for agp memory: 431M
agpgart: Detected an Intel 845G Chipset.
agpgart: detected 8060K stolen memory.
agpgart: AGP aperture is 128M @ 0xe0000000
memory : dee00b00
parport0: PC-style at 0x378 (0x778) [PCSPP,TRISTATE,EPP]
parport0: irq 7 detected
parport0: Printer, Hewlett-Packard HP LaserJet 5P
lp0: using parport0 (polling).
end_request: I/O error, dev 21:00 (hde), sector 0
end_request: I/O error, dev 21:00 (hde), sector 2
end_request: I/O error, dev 21:00 (hde), sector 4
end_request: I/O error, dev 21:00 (hde), sector 6
end_request: I/O error, dev 21:00 (hde), sector 241928
end_request: I/O error, dev 21:00 (hde), sector 241930
end_request: I/O error, dev 21:00 (hde), sector 241932
end_request: I/O error, dev 21:00 (hde), sector 241934
end_request: I/O error, dev 21:00 (hde), sector 241936
end_request: I/O error, dev 21:00 (hde), sector 241938
end_request: I/O error, dev 21:00 (hde), sector 241940
 .
 .
 .
 .

invalidate: busy buffer
invalidate: busy buffer
invalidate: busy buffer
invalidate: busy buffer
invalidate: busy buffer
invalidate: busy buffer
invalidate: busy buffer
invalidate: busy buffer
invalidate: busy buffer
invalidate: busy buffer
invalidate: busy buffer
 .
 .
 .
 .




