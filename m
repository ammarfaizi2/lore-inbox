Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264186AbTHQKoZ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Aug 2003 06:44:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265069AbTHQKoZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Aug 2003 06:44:25 -0400
Received: from mailout09.sul.t-online.com ([194.25.134.84]:59109 "EHLO
	mailout09.sul.t-online.com") by vger.kernel.org with ESMTP
	id S264186AbTHQKoM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Aug 2003 06:44:12 -0400
Message-ID: <3F3F5E1D.3080600@t-online.de>
Date: Sun, 17 Aug 2003 12:51:09 +0200
From: Dominik.Strasser@t-online.de (Dominik Strasser)
User-Agent: Mozilla/5.0 (X11; U; Linux i586; en-US; rv:1.4) Gecko/20030624
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.6.0-test3 oddities
Content-Type: multipart/mixed;
 boundary="------------090800040402000006040503"
X-Seen: false
X-ID: VTiV9BZbQeblW7A8mWCtjVUMMW3vVJl5uxYGLR+a97xiyFzg-Ve6kl
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------090800040402000006040503
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hi,
which the latest 2.6 kernel, I have the following problems:

1. My network card is not detected. It is a 3Com 3C509B EtherLink III, 
which is correctly dtetcted by isapnp, but the card driver doesn't 
recognize it. I don't have any network device. This seems to have 
something to do with the ressources on my MB which is a Gigabyte 5-AA 
which is an AT sized ATX MB. USB is disabled in the BIOS, but if I 
enable USB in the kernel, a ressource conflict between the network card 
and USB is reported. I am attaching my .config + the bootlog output.

2. My /proc/devices looks strange. All sd devices are listed, despite I 
have only one SCSI disk. I'll attach the output.

3. catting /proc/bus/pnp/esdi (not esdi_info) results in an endless 
OOPS. As the OOPSing doesn't stop, and I can't scroll lock, I can't give 
very much info on where the OOPS occurs.

4. My wheel mouse is correctly detected (see the bootlog), however wheel 
scrolling doesn't work.

My system is rock solid under 2.4 with the identical config.

Regards

Dominik

--------------090800040402000006040503
Content-Type: text/plain;
 name="config"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="config"

CONFIG_X86=y
CONFIG_MMU=y
CONFIG_UID16=y
CONFIG_GENERIC_ISA_DMA=y
CONFIG_EXPERIMENTAL=y
CONFIG_SWAP=y
CONFIG_SYSVIPC=y
CONFIG_SYSCTL=y
CONFIG_LOG_BUF_SHIFT=14
CONFIG_KALLSYMS=y
CONFIG_FUTEX=y
CONFIG_EPOLL=y
CONFIG_IOSCHED_AS=y
CONFIG_IOSCHED_DEADLINE=y
CONFIG_MODULES=y
CONFIG_MODULE_UNLOAD=y
CONFIG_MODULE_FORCE_UNLOAD=y
CONFIG_OBSOLETE_MODPARM=y
CONFIG_KMOD=y
CONFIG_X86_PC=y
CONFIG_MK6=y
CONFIG_X86_CMPXCHG=y
CONFIG_X86_XADD=y
CONFIG_X86_L1_CACHE_SHIFT=5
CONFIG_RWSEM_XCHGADD_ALGORITHM=y
CONFIG_X86_WP_WORKS_OK=y
CONFIG_X86_INVLPG=y
CONFIG_X86_BSWAP=y
CONFIG_X86_POPAD_OK=y
CONFIG_X86_ALIGNMENT_16=y
CONFIG_X86_USE_PPRO_CHECKSUM=y
CONFIG_PREEMPT=y
CONFIG_X86_TSC=y
CONFIG_X86_MSR=y
CONFIG_X86_CPUID=y
CONFIG_NOHIGHMEM=y
CONFIG_MTRR=y
CONFIG_HAVE_DEC_LOCK=y
CONFIG_PM=y
CONFIG_APM=y
CONFIG_APM_DO_ENABLE=y
CONFIG_APM_DISPLAY_BLANK=y
CONFIG_PCI=y
CONFIG_PCI_GOBIOS=y
CONFIG_PCI_BIOS=y
CONFIG_PCI_NAMES=y
CONFIG_ISA=y
CONFIG_HOTPLUG=y
CONFIG_PCMCIA_PROBE=y
CONFIG_KCORE_ELF=y
CONFIG_BINFMT_ELF=y
CONFIG_BINFMT_MISC=y
CONFIG_PARPORT=y
CONFIG_PARPORT_PC=y
CONFIG_PARPORT_PC_CML1=y
CONFIG_PARPORT_1284=y
CONFIG_PNP=y
CONFIG_PNP_DEBUG=y
CONFIG_ISAPNP=y
CONFIG_PNPBIOS=y
CONFIG_BLK_DEV_FD=y
CONFIG_BLK_DEV_LOOP=y
CONFIG_IDE=y
CONFIG_BLK_DEV_IDE=y
CONFIG_BLK_DEV_IDEDISK=y
CONFIG_IDEDISK_MULTI_MODE=y
CONFIG_BLK_DEV_IDECD=y
CONFIG_BLK_DEV_IDESCSI=y
CONFIG_IDE_TASK_IOCTL=y
CONFIG_BLK_DEV_IDEPCI=y
CONFIG_IDEPCI_SHARE_IRQ=y
CONFIG_BLK_DEV_GENERIC=y
CONFIG_BLK_DEV_IDEDMA_PCI=y
CONFIG_IDEDMA_PCI_AUTO=y
CONFIG_BLK_DEV_ADMA=y
CONFIG_BLK_DEV_ALI15X3=y
CONFIG_BLK_DEV_IDEDMA=y
CONFIG_IDEDMA_AUTO=y
CONFIG_SCSI=y
CONFIG_BLK_DEV_SD=y
CONFIG_CHR_DEV_SG=y
CONFIG_SCSI_AIC7XXX=y
CONFIG_AIC7XXX_CMDS_PER_DEVICE=32
CONFIG_AIC7XXX_RESET_DELAY_MS=3000
CONFIG_AIC7XXX_DEBUG_MASK=0
CONFIG_AIC7XXX_REG_PRETTY_PRINT=y
CONFIG_NET=y
CONFIG_PACKET=y
CONFIG_UNIX=y
CONFIG_INET=y
CONFIG_IP_MULTICAST=y
CONFIG_IPV6_SCTP__=y
CONFIG_NETDEVICES=y
CONFIG_DUMMY=y
CONFIG_NET_ETHERNET=y
CONFIG_NET_VENDOR_3COM=y
CONFIG_EL3=m
CONFIG_PPP=y
CONFIG_PPPOE=y
CONFIG_IRDA=m
CONFIG_IRCOMM=m
CONFIG_IRTTY_SIR=m
CONFIG_DONGLE=y
CONFIG_ACTISYS_DONGLE=m
CONFIG_IRPORT_SIR=m
CONFIG_INPUT=y
CONFIG_INPUT_MOUSEDEV=y
CONFIG_INPUT_MOUSEDEV_PSAUX=y
CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
CONFIG_INPUT_JOYDEV=y
CONFIG_GAMEPORT=y
CONFIG_SOUND_GAMEPORT=y
CONFIG_GAMEPORT_EMU10K1=y
CONFIG_SERIO=y
CONFIG_SERIO_I8042=y
CONFIG_INPUT_KEYBOARD=y
CONFIG_KEYBOARD_ATKBD=y
CONFIG_INPUT_MOUSE=y
CONFIG_MOUSE_PS2=y
CONFIG_INPUT_JOYSTICK=y
CONFIG_JOYSTICK_ANALOG=m
CONFIG_VT=y
CONFIG_VT_CONSOLE=y
CONFIG_HW_CONSOLE=y
CONFIG_SERIAL_8250=y
CONFIG_SERIAL_CORE=y
CONFIG_UNIX98_PTYS=y
CONFIG_UNIX98_PTY_COUNT=256
CONFIG_PRINTER=y
CONFIG_I2C=y
CONFIG_I2C_ALGOBIT=y
CONFIG_I2C_PHILIPSPAR=y
CONFIG_I2C_ELV=y
CONFIG_I2C_VELLEMAN=y
CONFIG_I2C_CHARDEV=y
CONFIG_I2C_ALI15X3=y
CONFIG_BUSMOUSE=y
CONFIG_NVRAM=y
CONFIG_RTC=y
CONFIG_AGP=y
CONFIG_AGP_ALI=y
CONFIG_DRM=y
CONFIG_DRM_R128=y
CONFIG_VIDEO_DEV=y
CONFIG_VIDEO_PROC_FS=y
CONFIG_DVB=y
CONFIG_DVB_CORE=m
CONFIG_DVB_VES1820=m
CONFIG_DVB_AV7110=m
CONFIG_DVB_AV7110_OSD=y
CONFIG_VIDEO_SAA7146=m
CONFIG_VIDEO_VIDEOBUF=m
CONFIG_VIDEO_BUF=m
CONFIG_EXT2_FS=y
CONFIG_EXT3_FS=y
CONFIG_JBD=y
CONFIG_ISO9660_FS=y
CONFIG_JOLIET=y
CONFIG_UDF_FS=y
CONFIG_FAT_FS=y
CONFIG_MSDOS_FS=y
CONFIG_VFAT_FS=y
CONFIG_PROC_FS=y
CONFIG_DEVPTS_FS=y
CONFIG_TMPFS=y
CONFIG_RAMFS=y
CONFIG_MSDOS_PARTITION=y
CONFIG_NLS=y
CONFIG_NLS_DEFAULT="iso8859-15"
CONFIG_NLS_CODEPAGE_437=y
CONFIG_NLS_CODEPAGE_850=y
CONFIG_NLS_ISO8859_1=y
CONFIG_NLS_ISO8859_15=y
CONFIG_FB=y
CONFIG_VIDEO_SELECT=y
CONFIG_FB_ATY128=y
CONFIG_VGA_CONSOLE=y
CONFIG_DUMMY_CONSOLE=y
CONFIG_FRAMEBUFFER_CONSOLE=y
CONFIG_PCI_CONSOLE=y
CONFIG_FONTS=y
CONFIG_FONT_8x8=y
CONFIG_FONT_8x16=y
CONFIG_LOGO=y
CONFIG_LOGO_LINUX_CLUT224=y
CONFIG_SOUND=y
CONFIG_SND=y
CONFIG_SND_OSSEMUL=y
CONFIG_SND_MIXER_OSS=y
CONFIG_SND_EMU10K1=y
CONFIG_DEBUG_KERNEL=y
CONFIG_DEBUG_SLAB=y
CONFIG_MAGIC_SYSRQ=y
CONFIG_DEBUG_SPINLOCK=y
CONFIG_X86_BIOS_REBOOT=y

--------------090800040402000006040503
Content-Type: text/plain;
 name="dmesg"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="dmesg"

Linux version 2.6.0-test3 (root@domml) (gcc version 3.2) #3 Tue Aug 12 12:49:55 CEST 2003
Video mode to be used for restore is 0
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000e0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000000bff0000 (usable)
 BIOS-e820: 000000000bff0000 - 000000000bff8000 (ACPI data)
 BIOS-e820: 000000000bff8000 - 000000000c000000 (ACPI NVS)
 BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
 BIOS-e820: 00000000fffe0000 - 0000000100000000 (reserved)
191MB LOWMEM available.
On node 0 totalpages: 49136
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 45040 pages, LIFO batch:10
  HighMem zone: 0 pages, LIFO batch:1
Building zonelist for node : 0
Kernel command line: auto BOOT_IMAGE=Linux26 ro root=306 pci=biosirq video=aty128fb:1280x1024@75
Initializing CPU#0
PID hash table entries: 1024 (order 10: 8192 bytes)
Detected 500.978 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 991.23 BogoMIPS
Memory: 190236k/196544k available (2556k kernel code, 5680k reserved, 835k data, 152k init, 0k highmem)
Dentry cache hash table entries: 32768 (order: 5, 131072 bytes)
Inode-cache hash table entries: 16384 (order: 4, 65536 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
-> /dev
-> /dev/console
-> /root
CPU:     After generic identify, caps: 008021bf 808029bf 00000000 00000000
CPU:     After vendor identify, caps: 008021bf 808029bf 00000000 00000000
CPU: L1 I Cache: 32K (32 bytes/line), D cache 32K (32 bytes/line)
CPU:     After all inits, caps: 008021bf 808029bf 00000000 00000002
CPU: AMD-K6(tm) 3D processor stepping 0c
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
Initializing RT netlink socket
PCI: PCI BIOS revision 2.10 entry at 0xfdb41, last bus=1
mtrr: v2.0 (20020519)
BIO: pool of 256 setup, 14Kb (56 bytes/bio)
biovec pool[0]:   1 bvecs: 256 entries (12 bytes)
biovec pool[1]:   4 bvecs: 256 entries (48 bytes)
biovec pool[2]:  16 bvecs: 256 entries (192 bytes)
biovec pool[3]:  64 bvecs: 256 entries (768 bytes)
biovec pool[4]: 128 bvecs: 256 entries (1536 bytes)
biovec pool[5]: 256 bvecs: 256 entries (3072 bytes)
Linux Plug and Play Support v0.97 (c) Adam Belay
pnp: the driver 'system' has been registered
PnPBIOS: Scanning system for PnP BIOS support...
PnPBIOS: Found PnP BIOS installation structure at 0xc00f73f0
PnPBIOS: PnP BIOS version 1.0, entry 0xf0000:0x6cc6, dseg 0xf0000
pnp: match found with the PnP device '00:00' and the driver 'system'
PnPBIOS: 14 nodes reported by PnP BIOS; 14 recorded by driver
SCSI subsystem initialized
PCI: Probing PCI hardware
PCI: Probing PCI hardware (bus 00)
PCI: Using IRQ router ALI [10b9/1533] at 0000:00:07.0
aty128fb: Rage128 BIOS located at cfec0000
aty128fb: Rage128 Pro PF (AGP) [chip rev 0x1] 32M 128-bit SDR SGRAM (1:1)
fb0: ATY Rage128 frame buffer device on Rage128 Pro PF (AGP)
aty128fb: Rage128 MTRR set to ON
Console: switching to colour frame buffer device 160x64
pty: 256 Unix98 ptys configured
apm: BIOS version 1.2 Flags 0x03 (Driver version 1.16ac)
Journalled Block Device driver loaded
udf: registering filesystem
isapnp: Scanning for PnP cards...
isapnp: Card '3Com 3C509B EtherLink III'
isapnp: 1 Plug & Play card detected total
request_module: failed /sbin/modprobe -- parport_lowlevel. error = -16
lp: driver loaded but no devices found
Real Time Clock Driver v1.11
Non-volatile memory driver v1.2
Linux agpgart interface v0.100 (c) Dave Jones
agpgart: Detected ALi M1541 chipset
agpgart: Maximum main memory to use for agp memory: 149M
agpgart: AGP aperture is 64M @ 0xe0000000
mtrr: no more MTRRs available
[drm] Initialized r128 2.5.0 20030725 on minor 0
Serial: 8250/16550 driver $Revision: 1.90 $ IRQ sharing disabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
pnp: the driver 'serial' has been registered
pnp: match found with the PnP device '00:09' and the driver 'serial'
pnp: match found with the PnP device '00:0a' and the driver 'serial'
pnp: the driver 'parport_pc' has been registered
pnp: match found with the PnP device '00:0b' and the driver 'parport_pc'
parport0: PC-style at 0x378 [PCSPP,EPP]
parport0: cpp_daisy: aa5500ff(38)
parport0: assign_addrs: aa5500ff(38)
parport0: cpp_daisy: aa5500ff(38)
parport0: assign_addrs: aa5500ff(38)
lp0: using parport0 (polling).
Using anticipatory scheduling elevator
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
loop: loaded (max 8 devices)
PPP generic driver version 2.4.2
Linux video capture interface: v1.00
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ALI15X3: IDE controller at PCI slot 0000:00:0f.0
ALI15X3: chipset revision 193
ALI15X3: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xffa0-0xffa7, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xffa8-0xffaf, BIOS settings: hdc:DMA, hdd:DMA
hda: IBM-DJNA-351520, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hdc: JLMS XJ-HD165H, ATAPI CD/DVD-ROM drive
hdd: LITE-ON LTR-48246S, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
hda: max request size: 128KiB
hda: 30033360 sectors (15377 MB) w/430KiB Cache, CHS=29795/16/63, UDMA(33)
 hda: hda1 hda2 < hda5 hda6 hda7 hda8 > hda3
hdc: ATAPI 48X DVD-ROM drive, 512kB Cache, (U)DMA
Uniform CD-ROM driver Revision: 3.12
end_request: I/O error, dev hdd, sector 0
hdd: ATAPI 48X CD-ROM CD-R/RW drive, 2048kB Cache, (U)DMA
PCI: Found IRQ 11 for device 0000:00:08.0
scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.35
        <Adaptec 2940 SCSI adapter>
        aic7870: Single Channel A, SCSI Id=7, 16/253 SCBs

(scsi0:A:0): 10.000MB/s transfers (10.000MHz, offset 15)
  Vendor: SEAGATE   Model: ST373405LW        Rev: 0003
  Type:   Direct-Access                      ANSI SCSI revision: 03
scsi0:A:0:0: Tagged Queuing enabled.  Depth 32
SCSI device sda: 143374741 512-byte hdwr sectors (73408 MB)
SCSI device sda: drive cache: write back
 sda: sda1 sda2
Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
Attached scsi generic sg0 at scsi0, channel 0, id 0, lun 0,  type 0
Console: switching to colour frame buffer device 160x64
mice: PS/2 mouse device common for all mice
gameport:  at pci0000:00:0a.1 speed 1242 kHz
input: PS2++ Logitech Wheel Mouse on isa0060/serio1
serio: i8042 AUX port at 0x60,0x64 irq 12
input: AT Set 2 keyboard on isa0060/serio0
serio: i8042 KBD port at 0x60,0x64 irq 1
i2c /dev entries driver module version 2.7.0 (20021208)
i2c-philips-par.o: i2c Philips parallel port adapter module version 2.7.0 (20021208)
i2c-philips-par.o: attaching to parport0
parport0: cannot grant exclusive access for device i2c-philips-par
i2c-philips-par: Unable to register with parport.
i2c-elv.o: i2c ELV parallel port adapter module version 2.7.0 (20021208)
i2c-velleman.o: i2c Velleman K8000 adapter module version 2.7.0 (20021208)
i2c-ali15x3.o version 2.7.0 (20021208)
Advanced Linux Sound Architecture Driver Version 0.9.6 (Mon Jul 28 11:08:42 2003 UTC).
PCI: Found IRQ 9 for device 0000:00:0a.0
ALSA device list:
  #0: Sound Blaster Live! (rev.5) at 0xdf80, irq 9
NET4: Linux TCP/IP 1.0 for NET4.0
IP: routing cache hash table of 256 buckets, 8Kbytes
TCP: Hash tables configured (established 16384 bind 4681)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
VFS: Mounted root (ext2 filesystem) readonly.
Freeing unused kernel memory: 152k freed
Adding 136512k swap on /dev/hda7.  Priority:-1 extents:1
spurious 8259A interrupt: IRQ7.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hda8, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hda3, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on sda2, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
end_request: I/O error, dev hdd, sector 0
(scsi0:A:0:0): CDB: 0x12 0x1 0x80 0x0 0xff 0x0
(scsi0:A:0:0): Saw underflow (744 of 768 bytes). Treated as error
(scsi0:A:0:0): CDB: 0x12 0x1 0x80 0x0 0xff 0x0
(scsi0:A:0:0): Saw underflow (744 of 768 bytes). Treated as error
(scsi0:A:0:0): CDB: 0x12 0x1 0x80 0x0 0xff 0x0
(scsi0:A:0:0): Saw underflow (744 of 768 bytes). Treated as error
(scsi0:A:0:0): CDB: 0x12 0x1 0x80 0x0 0xff 0x0
(scsi0:A:0:0): Saw underflow (744 of 768 bytes). Treated as error
(scsi0:A:0:0): CDB: 0x12 0x1 0x80 0x0 0xff 0x0
(scsi0:A:0:0): Saw underflow (744 of 768 bytes). Treated as error
cdrom: open failed.
cdrom: open failed.
cdrom: open failed.
cdrom: open failed.
end_request: I/O error, dev hdd, sector 0
(scsi0:A:0:0): CDB: 0x12 0x1 0x80 0x0 0xff 0x0
(scsi0:A:0:0): Saw underflow (744 of 768 bytes). Treated as error
(scsi0:A:0:0): CDB: 0x12 0x1 0x80 0x0 0xff 0x0
(scsi0:A:0:0): Saw underflow (744 of 768 bytes). Treated as error
(scsi0:A:0:0): CDB: 0x12 0x1 0x80 0x0 0xff 0x0
(scsi0:A:0:0): Saw underflow (744 of 768 bytes). Treated as error
(scsi0:A:0:0): CDB: 0x12 0x1 0x80 0x0 0xff 0x0
(scsi0:A:0:0): Saw underflow (744 of 768 bytes). Treated as error
(scsi0:A:0:0): CDB: 0x12 0x1 0x80 0x0 0xff 0x0
(scsi0:A:0:0): Saw underflow (744 of 768 bytes). Treated as error

--------------090800040402000006040503
Content-Type: text/plain;
 name="dev"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="dev"

Character devices:
  1 mem
  2 pty
  3 ttyp
  4 /dev/vc/0
  4 tty
  4 ttyS
  5 /dev/tty
  5 /dev/console
  5 /dev/ptmx
  6 lp
  7 vcs
 10 misc
 13 input
 14 sound
 21 sg
 29 fb
 81 video4linux
 89 i2c
108 ppp
116 alsa
128 ptm
136 pts
202 cpu/msr
203 cpu/cpuid
226 drm

Block devices:
  2 fd
  3 ide0
  7 loop
  8 sd
 22 ide1
 65 sd
 66 sd
 67 sd
 68 sd
 69 sd
 70 sd
 71 sd
128 sd
129 sd
130 sd
131 sd
132 sd
133 sd
134 sd
135 sd

--------------090800040402000006040503--

