Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129203AbQKFJaV>; Mon, 6 Nov 2000 04:30:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129290AbQKFJaL>; Mon, 6 Nov 2000 04:30:11 -0500
Received: from fs1.dekanat.physik.uni-tuebingen.de ([134.2.216.20]:40966 "EHLO
	fs1.dekanat.physik.uni-tuebingen.de") by vger.kernel.org with ESMTP
	id <S129203AbQKFJ36>; Mon, 6 Nov 2000 04:29:58 -0500
Date: Mon, 6 Nov 2000 10:29:51 +0100 (CET)
From: Richard Guenther <richard.guenther@student.uni-tuebingen.de>
To: James Simmons <jsimmons@suse.com>
cc: Richard Guenther <richard.guenther@student.uni-tuebingen.de>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: Broken colors on console with 2.4.0-textXX
In-Reply-To: <Pine.LNX.4.21.0011031717130.17614-100000@euclid.oak.suse.com>
Message-ID: <Pine.LNX.4.21.0011061025210.17375-100000@fs1.dekanat.physik.uni-tuebingen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 3 Nov 2000, James Simmons wrote:

> 
> > > How recent of a test kernel. Yes their was a problem with the console
> > > palette but it is now fixed in the most recent test kernels.
> > 
> > 2.4.0-test10-pre5
> 
> Please upgrade to a newer kernel. This problem has been fixed :-)
> 

Unfortunately I cannot confirm this. Checked 2.4.0-test10 and the problem
is still there. I digged further and it seems to be a race condition(?)
triggered by swapped out stuff - because just starting X and switching
back to the console works fine, but as I start some memory-consuming stuff
(I have only 32Megs of ram) and then switch back to the console its
completely garbagled the first time and black the second time and later.

For your information, my config, etc. is attached below.

Richard.

--
Richard Guenther <richard.guenther@student.uni-tuebingen.de>
WWW: http://www.anatom.uni-tuebingen.de/~richi/
The GLAME Project: http://www.glame.de/

CONFIG_X86=y
CONFIG_ISA=y
CONFIG_UID16=y
CONFIG_EXPERIMENTAL=y
CONFIG_MODULES=y
CONFIG_KMOD=y
CONFIG_M586TSC=y
CONFIG_X86_WP_WORKS_OK=y
CONFIG_X86_INVLPG=y
CONFIG_X86_CMPXCHG=y
CONFIG_X86_BSWAP=y
CONFIG_X86_POPAD_OK=y
CONFIG_X86_L1_CACHE_SHIFT=5
CONFIG_X86_USE_STRING_486=y
CONFIG_X86_ALIGNMENT_16=y
CONFIG_X86_TSC=y
CONFIG_NOHIGHMEM=y
CONFIG_NET=y
CONFIG_PCI=y
CONFIG_PCI_GOANY=y
CONFIG_PCI_BIOS=y
CONFIG_PCI_DIRECT=y
CONFIG_PCI_NAMES=y
CONFIG_SYSVIPC=y
CONFIG_BSD_PROCESS_ACCT=y
CONFIG_SYSCTL=y
CONFIG_KCORE_ELF=y
CONFIG_BINFMT_AOUT=m
CONFIG_BINFMT_ELF=y
CONFIG_BINFMT_MISC=m
CONFIG_PNP=y
CONFIG_BLK_DEV_FD=m
CONFIG_BLK_DEV_LOOP=m
CONFIG_BLK_DEV_RAM=m
CONFIG_BLK_DEV_RAM_SIZE=4096
CONFIG_PACKET=y
CONFIG_NETLINK=y
CONFIG_NETLINK_DEV=y
CONFIG_FILTER=y
CONFIG_UNIX=y
CONFIG_INET=y
CONFIG_IDE=y
CONFIG_BLK_DEV_IDE=y
CONFIG_BLK_DEV_IDEDISK=y
CONFIG_IDEDISK_MULTI_MODE=y
CONFIG_BLK_DEV_IDECD=m
CONFIG_BLK_DEV_IDEPCI=y
CONFIG_IDEPCI_SHARE_IRQ=y
CONFIG_BLK_DEV_IDEDMA_PCI=y
CONFIG_IDEDMA_PCI_AUTO=y
CONFIG_BLK_DEV_IDEDMA=y
CONFIG_BLK_DEV_PIIX=y
CONFIG_PIIX_TUNING=y
CONFIG_IDEDMA_AUTO=y
CONFIG_BLK_DEV_IDE_MODES=y
CONFIG_SCSI=y
CONFIG_BLK_DEV_SD=m
CONFIG_SD_EXTRA_DEVS=40
CONFIG_CHR_DEV_ST=m
CONFIG_BLK_DEV_SR=m
CONFIG_BLK_DEV_SR_VENDOR=y
CONFIG_SR_EXTRA_DEVS=2
CONFIG_CHR_DEV_SG=m
CONFIG_SCSI_DEBUG_QUEUES=y
CONFIG_SCSI_MULTI_LUN=y
CONFIG_SCSI_CONSTANTS=y
CONFIG_SCSI_SYM53C8XX=y
CONFIG_SCSI_NCR53C8XX_DEFAULT_TAGS=4
CONFIG_SCSI_NCR53C8XX_MAX_TAGS=32
CONFIG_SCSI_NCR53C8XX_SYNC=20
CONFIG_NETDEVICES=y
CONFIG_NET_ETHERNET=y
CONFIG_NET_VENDOR_SMC=y
CONFIG_NET_ISA=y
CONFIG_NE2000=m
CONFIG_NET_PCI=y
CONFIG_RTL8129=m
CONFIG_8139TOO=m
CONFIG_VT=y
CONFIG_VT_CONSOLE=y
CONFIG_SERIAL=y
CONFIG_UNIX98_PTYS=y
CONFIG_UNIX98_PTY_COUNT=256
CONFIG_I2C=m
CONFIG_I2C_ALGOBIT=m
CONFIG_I2C_CHARDEV=m
CONFIG_RTC=y
CONFIG_VIDEO_DEV=y
CONFIG_VIDEO_PROC_FS=y
CONFIG_VIDEO_BT848=m
CONFIG_AUTOFS4_FS=y
CONFIG_FAT_FS=m
CONFIG_MSDOS_FS=m
CONFIG_VFAT_FS=m
CONFIG_RAMFS=m
CONFIG_ISO9660_FS=m
CONFIG_JOLIET=y
CONFIG_MINIX_FS=m
CONFIG_PROC_FS=y
CONFIG_DEVPTS_FS=y
CONFIG_EXT2_FS=y
CONFIG_CODA_FS=m
CONFIG_NFS_FS=m
CONFIG_NFS_V3=y
CONFIG_SUNRPC=m
CONFIG_LOCKD=m
CONFIG_LOCKD_V4=y
CONFIG_PARTITION_ADVANCED=y
CONFIG_MSDOS_PARTITION=y
CONFIG_NLS=y
CONFIG_NLS_DEFAULT="iso8859-1"
CONFIG_NLS_CODEPAGE_437=m
CONFIG_NLS_CODEPAGE_850=m
CONFIG_NLS_CODEPAGE_852=m
CONFIG_NLS_ISO8859_1=m
CONFIG_NLS_ISO8859_2=m
CONFIG_NLS_ISO8859_15=m
CONFIG_NLS_UTF8=m
CONFIG_VGA_CONSOLE=y
CONFIG_VIDEO_SELECT=y
CONFIG_SOUND=y
CONFIG_SOUND_OSS=y
CONFIG_SOUND_TRACEINIT=y
CONFIG_SOUND_DMAP=y
CONFIG_SOUND_SB=y
CONFIG_SOUND_AWE32_SYNTH=m
CONFIG_SOUND_TVMIXER=m
CONFIG_MAGIC_SYSRQ=y

Linux version 2.4.0-test10 (root@mickey) (gcc version 2.95.2 20000220 (Debian GNU/Linux)) #19 Sam Nov 4 21:29:27 CET 2000
BIOS-provided physical RAM map:
 BIOS-e820: 00000000000a0000 @ 0000000000000000 (usable)
 BIOS-e820: 0000000000018000 @ 00000000000e8000 (reserved)
 BIOS-e820: 0000000001f00000 @ 0000000000100000 (usable)
 BIOS-e820: 0000000000020000 @ 00000000fffe0000 (reserved)
On node 0 totalpages: 8192
zone(0): 4096 pages.
zone(1): 4096 pages.
zone(2): 0 pages.
Kernel command line: BOOT_IMAGE=beta ro root=1601 BOOT_FILE=/lib/images/beta/zImage sb=0x220,5,1,5 uart401=0x330,-1
Initializing CPU#0
Detected 99.476 MHz processor.
Console: colour VGA+ 100x30
Calibrating delay loop... 198.25 BogoMIPS
Memory: 30304k/32768k available (1057k kernel code, 2080k reserved, 80k data, 188k init, 0k highmem)
Dentry-cache hash table entries: 4096 (order: 3, 32768 bytes)
Buffer-cache hash table entries: 1024 (order: 0, 4096 bytes)
Page-cache hash table entries: 8192 (order: 3, 32768 bytes)
Inode-cache hash table entries: 2048 (order: 2, 16384 bytes)
CPU: Intel Pentium 75 - 200 stepping 05
Checking 'hlt' instruction... OK.
Intel Pentium with F0 0F bug - workaround enabled.
POSIX conformance testing by UNIFIX
PCI: PCI BIOS revision 2.10 entry at 0xfbcd0, last bus=0
PCI: Using configuration type 1
PCI: Probing PCI hardware
Limiting direct PCI/PCI transfers.
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Starting kswapd v1.8
pty: 256 Unix98 ptys configured
Linux video capture interface: v1.00
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
PIIX: IDE controller on PCI bus 00 dev 38
PIIX: chipset revision 2
PIIX: not 100% native mode: will probe irqs later
PIIX: neither IDE port enabled (BIOS)
PIIX: IDE controller on PCI bus 00 dev 39
PIIX: chipset revision 2
PIIX: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xe800-0xe807, BIOS settings: hda:pio, hdb:pio
    ide1: BM-DMA at 0xe808-0xe80f, BIOS settings: hdc:pio, hdd:pio
hda: QUANTUM FIREBALL_TM2110A, ATA DISK drive
hdc: IBM-DHEA-38451, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: 4124736 sectors (2112 MB) w/76KiB Cache, CHS=4092/16/63, DMA
hdc: 16514064 sectors (8455 MB) w/472KiB Cache, CHS=16383/16/63, (U)DMA
Partition check:
 hda: hda1 hda2 hda3 hda4
 hdc: hdc1 hdc2 < hdc5 hdc6 hdc7 hdc8 >
Serial driver version 5.02 (2000-08-09) with MANY_PORTS SHARE_IRQ SERIAL_PCI enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
ttyS01 at 0x02f8 (irq = 3) is a 16550A
Real Time Clock Driver v1.10d
SCSI subsystem driver Revision: 1.00
sym53c8xx: at PCI bus 0, device 9, function 0
sym53c8xx: setting PCI_COMMAND_PARITY...(fix-up)
sym53c8xx: 53c810a detected 
sym53c810a-0: rev 0x23 on pci bus 0 device 9 function 0 irq 12
sym53c810a-0: ID 7, Fast-10, Parity Checking
sym53c810a-0: restart (scsi reset).
scsi0 : sym53c8xx - version 1.6b
  Vendor: TEAC      Model: CD-ROM CD-532S    Rev: 1.0A
  Type:   CD-ROM                             ANSI SCSI revision: 02
Soundblaster audio driver Copyright (C) by Hannu Savolainen 1993-1996
<Sound Blaster 16 (4.13)> at 0x220 irq 5 dma 1,5
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP
IP: routing cache hash table of 512 buckets, 4Kbytes
TCP: Hash tables configured (established 2048 bind 2048)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
VFS: Mounted root (ext2 filesystem) readonly.
Freeing unused kernel memory: 188k freed
Adding Swap: 98780k swap-space (priority -1)
i2c-core.o: i2c core module
i2c-algo-bit.o: i2c bit algorithm module
i2c-core.o: driver i2c TV tuner driver registered.
bttv: driver version 0.7.38 loaded
bttv: using 2 buffers with 2080k (4160k total) for capture
bttv: Host bridge 82437FX Triton PIIX
bttv: Bt8xx card found (0).
bttv0: Brooktree Bt848 (rev 17) bus: 0, devfn: 88, irq: 10, memory: 0xfaff0000.
tuner: chip found @ 0x61
bttv0: i2c attach [Philips PAL]
i2c-core.o: client [Philips PAL] registered to adapter [bt848 #0](pos. 0).
i2c-core.o: adapter bt848 #0 registered as adapter 0.
bttv0: i2c: checking for eeprom @ 0xa0... found
bttv0: model: BT848(Hauppauge old) [autodetected]
bttv0: Hauppauge eeprom: tuner=Philips FI1216 MK2 (5)
bttv0: Hauppauge msp34xx: reset line init
bttv0: i2c: checking for MSP34xx @ 0x80... not found
bttv0: i2c detach [Philips PAL]
i2c-core.o: client [Philips PAL] unregistered.
i2c-core.o: adapter unregistered: bt848 #0
tuner: chip found @ 0x61
bttv0: i2c attach [Philips PAL]
i2c-core.o: client [Philips PAL] registered to adapter [bt848 #0](pos. 0).
i2c-core.o: adapter bt848 #0 registered as adapter 0.
bttv0: i2c: checking for MSP34xx @ 0x80... not found
bttv0: i2c: checking for TDA8425 @ 0x82... not found
bttv0: i2c: checking for TDA985x @ 0xb6... not found
bttv0: i2c: checking for TDA9875 @ 0xb0... not found


-- Versions installed: (if some fields are empty or look
-- unusual then possibly you have very old versions)
Linux mickey 2.4.0-test10 #19 Sam Nov 4 21:29:27 CET 2000 i586 unknown
Kernel modules         2.3.17
Gnu C                  2.95.2
Gnu Make               3.78.1
Binutils               2.9.5.0.37
Linux C Library        2.1.3
Dynamic linker         ldd: version 1.9.11
Procps                 2.0.6
Mount                  2.10f
Net-tools              2.05
Kbd                    0.99
Sh-utils               2.0
Modules Loaded         bttv tuner i2c-algo-bit i2c-core

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
