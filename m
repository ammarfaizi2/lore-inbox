Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263279AbTDCFll>; Thu, 3 Apr 2003 00:41:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263280AbTDCFll>; Thu, 3 Apr 2003 00:41:41 -0500
Received: from ns.conceptual.net.au ([203.190.192.15]:17825 "EHLO
	conceptual.net.au") by vger.kernel.org with ESMTP
	id <S263279AbTDCFl1>; Thu, 3 Apr 2003 00:41:27 -0500
Message-ID: <3E8BCB4F.5080900@seme.com.au>
Date: Thu, 03 Apr 2003 13:49:03 +0800
From: Brad Campbell <brad@seme.com.au>
User-Agent: Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.1)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Synaptics Touchpad loses sync 2.5.66
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-SFilter: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

G'day all,
This is the show stopper for me using 2.5.x
I have seen this since the first 2.5.x kernel I tried which was around 
2.5.42.
Under X 4.2.0 (Happened under 4.1.x also) the Touchpad loses sync quite 
frequently causing the mouse to go haywire, jumping all over the screen 
and sending button presses that I have not made.
The exact same configuration works perfectly under 2.4.x


I tried compiling drivers/input/mouse/psmouse.c with DEBUG defined but 
turned up no extra info than what is below.
This does not seem to happen with gpm, but happens all the time under X.

Full dmesg including the mouse errors at the end, .config, lspci -v and 
/proc/interrupts included below. I can do any testing required to help 
debug this one.

Linux version 2.5.66 (brad@bklaptop) (gcc version 2.95.4 20011002 
(Debian prerelease)) #1 Thu Apr 3 13:26:31 WST 2003
Video mode to be used for restore is 1
BIOS-provided physical RAM map:
  BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
  BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
  BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
  BIOS-e820: 0000000000100000 - 000000001fff0000 (usable)
  BIOS-e820: 000000001fff0000 - 000000001fff8000 (ACPI data)
  BIOS-e820: 000000001fff8000 - 0000000020000000 (ACPI NVS)
  BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
511MB LOWMEM available.
On node 0 totalpages: 131056
   DMA zone: 4096 pages, LIFO batch:1
   Normal zone: 126960 pages, LIFO batch:16
   HighMem zone: 0 pages, LIFO batch:1
ACPI: RSDP (v000 Acer                       ) @ 0x000fe030
ACPI: RSDT (v001 Acer   TM740    00000.00001) @ 0x1fff0000
ACPI: FADT (v001 Acer   TM740    00000.00001) @ 0x1fff0054
ACPI: BOOT (v001 Acer   TM740    00000.00001) @ 0x1fff002c
ACPI: DSDT (v001   Acer   AN740  00000.04096) @ 0x00000000
ACPI: BIOS passes blacklist
ACPI: MADT not present
Building zonelist for node : 0
Kernel command line: BOOT_IMAGE=25test root=301 resume=/dev/hda3 hdc=scsi
ide_setup: hdc=scsi -- BAD OPTION
Local APIC disabled by BIOS -- reenabling.
Found and enabled local APIC!
Initializing CPU#0
PID hash table entries: 2048 (order 11: 16384 bytes)
Detected 999.778 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 1978.36 BogoMIPS
Memory: 514924k/524224k available (2038k kernel code, 8552k reserved, 
962k data, 116k init, 0k highmem)
Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
-> /dev
-> /dev/console
-> /root
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 512K
CPU:     After generic, caps: 0383fbff 00000000 00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU: Intel(R) Pentium(R) III Mobile CPU      1000MHz stepping 01
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 999.0710 MHz.
..... host bus clock speed is 133.0294 MHz.
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
mtrr: v2.0 (20020519)
PCI: PCI BIOS revision 2.10 entry at 0xf0200, last bus=2
PCI: Using configuration type 1
BIO: pool of 256 setup, 14Kb (56 bytes/bio)
biovec pool[0]:   1 bvecs: 256 entries (12 bytes)
biovec pool[1]:   4 bvecs: 256 entries (48 bytes)
biovec pool[2]:  16 bvecs: 256 entries (192 bytes)
biovec pool[3]:  64 bvecs: 256 entries (768 bytes)
biovec pool[4]: 128 bvecs: 256 entries (1536 bytes)
biovec pool[5]: 256 bvecs: 256 entries (3072 bytes)
ACPI: Subsystem revision 20030228
  tbxface-0117 [03] acpi_load_tables      : ACPI Tables successfully 
acquired
Parsing all Control 
Methods:.........................................................................................................................................................................
Table [DSDT] - 542 Objects with 53 Devices 169 Methods 36 Regions
ACPI Namespace successfully loaded at root c04213fc
evxfevnt-0092 [04] acpi_enable           : Transition to ACPI mode 
successful
    evgpe-0416 [06] ev_create_gpe_block   : GPE Block: 2 registers at 
000000000000F128
    evgpe-0421 [06] ev_create_gpe_block   : GPE Block defined as GPE0 to 
GPE15
    evgpe-0138 [08] ev_save_method_info   : GPE number associated with 
method _L18 is not valid
    evgpe-0416 [06] ev_create_gpe_block   : GPE Block: 2 registers at 
000000000000F12C
    evgpe-0421 [06] ev_create_gpe_block   : GPE Block defined as GPE16 
to GPE31
    evgpe-0138 [08] ev_save_method_info   : GPE number associated with 
method _L00 is not valid
    evgpe-0138 [08] ev_save_method_info   : GPE number associated with 
method _L03 is not valid
    evgpe-0138 [08] ev_save_method_info   : GPE number associated with 
method _L04 is not valid
    evgpe-0138 [08] ev_save_method_info   : GPE number associated with 
method _L0A is not valid
    evgpe-0138 [08] ev_save_method_info   : GPE number associated with 
method _L0B is not valid
    evgpe-0138 [08] ev_save_method_info   : GPE number associated with 
method _L18 is not valid
Executing all Device _STA and_INI 
methods:.....................................................
53 Devices found containing: 53 _STA, 0 _INI methods
Completing Region/Field/Buffer/Package 
initialization:.............................................................................
Initialized 28/36 Regions 5/5 Fields 21/21 Buffers 23/23 Packages (542 
nodes)
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
Transparent bridge - Intel Corp. 82801BAM/CAM PCI Bri
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.AGP0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCI1._PRT]
ACPI: PCI Interrupt Link [PILA] (IRQs 6 10 *11 12 14 15)
ACPI: PCI Interrupt Link [PILB] (IRQs 6 *10 12 14 15)
ACPI: PCI Interrupt Link [PILC] (IRQs 6 10 *11 12 14 15)
ACPI: PCI Interrupt Link [PILD] (IRQs 6 10 *11 12 14 15)
ACPI: PCI Interrupt Link [PILE] (IRQs 6 *10 12 14 15)
ACPI: PCI Interrupt Link [PILF] (IRQs 6 10 11 12 14 15, disabled)
ACPI: PCI Interrupt Link [PILG] (IRQs 6 10 12 14 15, disabled)
ACPI: PCI Interrupt Link [PILH] (IRQs 6 10 12 14 15, disabled)
ACPI: Embedded Controller [EC0] (gpe 29)
block request queues:
  128 requests per read queue
  128 requests per write queue
  8 requests per batch
  enter congestion at 15
  exit congestion at 17
Linux Kernel Card Services 3.1.22
   options:  [pci] [cardbus] [pm]
ACPI: PCI Interrupt Link [PILF] enabled at IRQ 10
ACPI: PCI Interrupt Link [PILG] enabled at IRQ 10
ACPI: PCI Interrupt Link [PILH] enabled at IRQ 10
  pci_irq-0295 [24] acpi_pci_irq_derive   : Unable to derive IRQ for 
device 00:1f.1
ACPI: No IRQ known for interrupt pin A of device 00:1f.1 - using IRQ 255
PCI: Using ACPI for IRQ routing
PCI: if you experience problems, try using option 'pci=noacpi' or even 
'acpi=off'
SBF: Simple Boot Flag extension found and enabled.
SBF: Setting boot flags 0x80
Enabling SEP on CPU 0
Journalled Block Device driver loaded
udf: registering filesystem
ACPI: AC Adapter [AC] (on-line)
ACPI: Battery Slot [BAT0] (battery present)
ACPI: Power Button (FF) [PWRF]
ACPI: Sleep Button (CM) [SLPB]
ACPI: Lid Switch [LID]
ACPI: Processor [CPU0] (supports C1 C2 C3)
ACPI: Thermal Zone [THR1] (53 C)
ACPI: Thermal Zone [THR2] (50 C)
pty: 256 Unix98 ptys configured
request_module: failed /sbin/modprobe -- parport_lowlevel. error = -16
lp: driver loaded but no devices found
Real Time Clock Driver v1.11
hw_random: RNG not detected
Linux agpgart interface v0.100 (c) Dave Jones
agpgart: Detected Intel 830M chipset
agpgart: Maximum main memory to use for agp memory: 439M
agpgart: AGP aperture is 256M @ 0xe0000000
[drm] Initialized radeon 1.7.0 20020828 on minor 0
Hangcheck: starting hangcheck timer 0.5.0 (tick is 180 seconds, margin 
is 60 seconds).
Serial: 8250/16550 driver $Revision: 1.90 $ IRQ sharing enabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
parport0: PC-style at 0x378 [PCSPP,TRISTATE,EPP]
parport0: cpp_daisy: aa5500ff(38)
parport0: assign_addrs: aa5500ff(38)
parport0: cpp_daisy: aa5500ff(38)
parport0: assign_addrs: aa5500ff(38)
lp0: using parport0 (polling).
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ICH3M: IDE controller at PCI slot 00:1f.1
  pci_irq-0295 [23] acpi_pci_irq_derive   : Unable to derive IRQ for 
device 00:1f.1
ACPI: No IRQ known for interrupt pin A of device 00:1f.1 - using IRQ 255
ICH3M: chipset revision 1
ICH3M: not 100% native mode: will probe irqs later
     ide0: BM-DMA at 0xc090-0xc097, BIOS settings: hda:DMA, hdb:pio
     ide1: BM-DMA at 0xc098-0xc09f, BIOS settings: hdc:DMA, hdd:pio
hda: IC25N030ATDA04-0, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hdc: MATSHITADVD-ROM SR-8176, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
hda: host protected area => 1
hda: 58605120 sectors (30006 MB) w/1806KiB Cache, CHS=58140/16/63, UDMA(100)
  hda: hda1 hda2 hda3 hda4
hdc: ATAPI 24X DVD-ROM drive, 256kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.12
end_request: I/O error, dev hdc, sector 0
Yenta IRQ list 00b8, PCI irq10
Socket status: 30000006
Yenta IRQ list 00b8, PCI irq10
Socket status: 30000006
mice: PS/2 mouse device common for all mice
i8042.c: Detected active multiplexing controller, rev 1.1.
serio: i8042 AUX0 port at 0x60,0x64 irq 12
serio: i8042 AUX1 port at 0x60,0x64 irq 12
serio: i8042 AUX2 port at 0x60,0x64 irq 12
input: PS/2 Synaptics TouchPad on isa0060/serio4
serio: i8042 AUX3 port at 0x60,0x64 irq 12
input: AT Set 2 keyboard on isa0060/serio0
serio: i8042 KBD port at 0x60,0x64 irq 1
Advanced Linux Sound Architecture Driver Version 0.9.2 (Thu Mar 20 
13:31:57 2003 UTC).
request_module: failed /sbin/modprobe -- snd-card-0. error = -16
PCI: Setting latency timer of device 00:1f.5 to 64
intel8x0: clocking to 48000
ALSA device list:
   #0: Intel 82801CA-ICH3 at 0xb000, irq 10
NET4: Linux TCP/IP 1.0 for NET4.0
IP: routing cache hash table of 4096 buckets, 32Kbytes
TCP: Hash tables configured (established 32768 bind 32768)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
BIOS EDD facility v0.09 2003-Jan-22, 1 devices found
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 116k freed
Adding 530136k swap on /dev/hda3.  Priority:-1 extents:1
EXT3 FS 2.4-0.9.16, 02 Dec 2001 on ide0(3,1), internal journal
Intel(R) PRO/100 Network Driver - version 2.2.21-k1
Copyright (c) 2003 Intel Corporation

e100: selftest OK.
Freeing alive device dfd2b000, eth%d
e100: eth0: Intel(R) PRO/100 Network Connection
   Hardware receive checksums enabled

kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.16, 02 Dec 2001 on ide0(3,4), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
warning: process `update' used the obsolete bdflush system call
Fix your initscripts?
e100: eth0 NIC Link is Up 100 Mbps Half duplex
process `named' is using obsolete setsockopt SO_BSDCOMPAT
process `named' is using obsolete setsockopt SO_BSDCOMPAT
process `named' is using obsolete setsockopt SO_BSDCOMPAT
Module irda cannot be unloaded due to unsafe usage in 
include/linux/module.h:432
agpgart: Putting AGP V2 device at 00:00.0 into 1x mode
agpgart: Putting AGP V2 device at 01:00.0 into 1x mode
psmouse.c: Lost synchronization, throwing 1 bytes away.
psmouse.c: Lost synchronization, throwing 1 bytes away.
spurious 8259A interrupt: IRQ7.
psmouse.c: Lost synchronization, throwing 1 bytes away.

CONFIG_X86=y
CONFIG_UID16=y
CONFIG_EXPERIMENTAL=y
CONFIG_MODULES=y
CONFIG_KMOD=y
CONFIG_MPENTIUMIII=y
CONFIG_X86_WP_WORKS_OK=y
CONFIG_X86_INVLPG=y
CONFIG_X86_CMPXCHG=y
CONFIG_X86_XADD=y
CONFIG_X86_BSWAP=y
CONFIG_X86_POPAD_OK=y
CONFIG_RWSEM_XCHGADD_ALGORITHM=y
CONFIG_X86_L1_CACHE_SHIFT=5
CONFIG_X86_HAS_TSC=y
CONFIG_X86_GOOD_APIC=y
CONFIG_X86_PGE=y
CONFIG_X86_USE_PPRO_CHECKSUM=y
CONFIG_X86_F00F_WORKS_OK=y
CONFIG_X86_MCE=y
CONFIG_NOHIGHMEM=y
CONFIG_MTRR=y
CONFIG_PREEMPT=y
CONFIG_X86_UP_APIC=y
CONFIG_X86_UP_IOAPIC=y
CONFIG_X86_LOCAL_APIC=y
CONFIG_X86_IO_APIC=y
CONFIG_X86_TSC=y
CONFIG_HAVE_DEC_LOCK=y
CONFIG_NET=y
CONFIG_PCI=y
CONFIG_PCI_GOANY=y
CONFIG_PCI_BIOS=y
CONFIG_PCI_DIRECT=y
CONFIG_ISA=y
CONFIG_PCI_NAMES=y
CONFIG_SYSVIPC=y
CONFIG_SYSCTL=y
CONFIG_KCORE_ELF=y
CONFIG_BINFMT_AOUT=m
CONFIG_BINFMT_ELF=y
CONFIG_BINFMT_MISC=m
CONFIG_PM=y
CONFIG_SOFTWARE_SUSPEND=y
CONFIG_ACPI=y
CONFIG_ACPI_BOOT=y
CONFIG_ACPI_BUS=y
CONFIG_ACPI_INTERPRETER=y
CONFIG_ACPI_EC=y
CONFIG_ACPI_POWER=y
CONFIG_ACPI_PCI=y
CONFIG_ACPI_SLEEP=y
CONFIG_ACPI_SYSTEM=y
CONFIG_ACPI_AC=y
CONFIG_ACPI_BATTERY=y
CONFIG_ACPI_BUTTON=y
CONFIG_ACPI_FAN=y
CONFIG_ACPI_PROCESSOR=y
CONFIG_ACPI_THERMAL=y
CONFIG_PARPORT=m
CONFIG_PARPORT_PC=m
CONFIG_PARPORT_PC_CML1=m
CONFIG_PARPORT_PC_FIFO=y
CONFIG_PARPORT_1284=y
CONFIG_BLK_DEV_FD=y
CONFIG_PARIDE=m
CONFIG_PARIDE_PARPORT=m
CONFIG_PARIDE_PD=m
CONFIG_PARIDE_PF=m
CONFIG_BLK_DEV_LOOP=m
CONFIG_BLK_DEV_RAM=m
CONFIG_BLK_DEV_RAM_SIZE=4096
CONFIG_PACKET=y
CONFIG_NETFILTER=y
CONFIG_UNIX=y
CONFIG_INET=y
CONFIG_IP_MULTICAST=y
CONFIG_IP_NF_CONNTRACK=m
CONFIG_IP_NF_FTP=m
CONFIG_IP_NF_IRC=m
CONFIG_IP_NF_QUEUE=m
CONFIG_IP_NF_IPTABLES=m
CONFIG_IP_NF_MATCH_LIMIT=m
CONFIG_IP_NF_MATCH_MAC=m
CONFIG_IP_NF_MATCH_PKTTYPE=m
CONFIG_IP_NF_MATCH_MARK=m
CONFIG_IP_NF_MATCH_MULTIPORT=m
CONFIG_IP_NF_MATCH_TOS=m
CONFIG_IP_NF_MATCH_ECN=m
CONFIG_IP_NF_MATCH_DSCP=m
CONFIG_IP_NF_MATCH_AH_ESP=m
CONFIG_IP_NF_MATCH_LENGTH=m
CONFIG_IP_NF_MATCH_TTL=m
CONFIG_IP_NF_MATCH_TCPMSS=m
CONFIG_IP_NF_MATCH_HELPER=m
CONFIG_IP_NF_MATCH_STATE=m
CONFIG_IP_NF_MATCH_CONNTRACK=m
CONFIG_IP_NF_MATCH_UNCLEAN=m
CONFIG_IP_NF_MATCH_OWNER=m
CONFIG_IP_NF_FILTER=m
CONFIG_IP_NF_TARGET_REJECT=m
CONFIG_IP_NF_TARGET_MIRROR=m
CONFIG_IP_NF_NAT=m
CONFIG_IP_NF_NAT_NEEDED=y
CONFIG_IP_NF_TARGET_MASQUERADE=m
CONFIG_IP_NF_TARGET_REDIRECT=m
CONFIG_IP_NF_NAT_SNMP_BASIC=m
CONFIG_IP_NF_NAT_IRC=m
CONFIG_IP_NF_NAT_FTP=m
CONFIG_IP_NF_MANGLE=m
CONFIG_IP_NF_TARGET_TOS=m
CONFIG_IP_NF_TARGET_ECN=m
CONFIG_IP_NF_TARGET_DSCP=m
CONFIG_IP_NF_TARGET_MARK=m
CONFIG_IP_NF_TARGET_LOG=m
CONFIG_IP_NF_TARGET_ULOG=m
CONFIG_IP_NF_TARGET_TCPMSS=m
CONFIG_IP_NF_ARPTABLES=m
CONFIG_IP_NF_ARPFILTER=m
CONFIG_IDE=y
CONFIG_BLK_DEV_IDE=y
CONFIG_BLK_DEV_IDEDISK=y
CONFIG_BLK_DEV_IDEFLOPPY=m
CONFIG_BLK_DEV_IDESCSI=y
CONFIG_BLK_DEV_IDEPCI=y
CONFIG_BLK_DEV_GENERIC=y
CONFIG_IDEPCI_SHARE_IRQ=y
CONFIG_BLK_DEV_IDEDMA_PCI=y
CONFIG_IDEDMA_PCI_AUTO=y
CONFIG_BLK_DEV_IDEDMA=y
CONFIG_BLK_DEV_ADMA=y
CONFIG_BLK_DEV_PIIX=y
CONFIG_IDEDMA_AUTO=y
CONFIG_BLK_DEV_IDE_MODES=y
CONFIG_SCSI=y
CONFIG_BLK_DEV_SD=m
CONFIG_SD_EXTRA_DEVS=40
CONFIG_BLK_DEV_SR=m
CONFIG_SR_EXTRA_DEVS=2
CONFIG_CHR_DEV_SG=y
CONFIG_SCSI_PPA=m
CONFIG_SCSI_IMM=m
CONFIG_SCSI_IZIP_EPP16=y
CONFIG_NETDEVICES=y
CONFIG_DUMMY=y
CONFIG_NET_ETHERNET=y
CONFIG_NET_PCI=y
CONFIG_E100=m
CONFIG_PLIP=m
CONFIG_PPP=m
CONFIG_PPP_MULTILINK=y
CONFIG_PPP_ASYNC=m
CONFIG_PPP_SYNC_TTY=m
CONFIG_PPP_DEFLATE=m
CONFIG_PPP_BSDCOMP=m
CONFIG_PPPOE=m
CONFIG_SLIP=m
CONFIG_SLIP_COMPRESSED=y
CONFIG_NET_RADIO=y
CONFIG_NET_WIRELESS=y
CONFIG_IRDA=m
CONFIG_IRLAN=m
CONFIG_IRNET=m
CONFIG_IRCOMM=m
CONFIG_IRDA_ULTRA=y
CONFIG_SMC_IRCC_FIR=m
CONFIG_VT=y
CONFIG_VT_CONSOLE=y
CONFIG_SERIAL=y
CONFIG_SERIAL_EXTENDED=y
CONFIG_SERIAL_MANY_PORTS=y
CONFIG_SERIAL_SHARE_IRQ=y
CONFIG_UNIX98_PTYS=y
CONFIG_UNIX98_PTY_COUNT=256
CONFIG_PRINTER=m
CONFIG_PPDEV=m
CONFIG_I2C=m
CONFIG_I2C_ALGOBIT=m
CONFIG_I2C_PHILIPSPAR=m
CONFIG_I2C_ELV=m
CONFIG_I2C_VELLEMAN=m
CONFIG_I2C_ALGOPCF=m
CONFIG_I2C_ELEKTOR=m
CONFIG_I2C_CHARDEV=m
CONFIG_I2C_PROC=m
CONFIG_MOUSE=y
CONFIG_PSMOUSE=y
CONFIG_AGP=m
CONFIG_AGP_INTEL=y
CONFIG_DRM=y
CONFIG_DRM_NEW=y
CONFIG_DRM_RADEON=m
CONFIG_HFS_FS=m
CONFIG_EXT3_FS=y
CONFIG_JBD=y
CONFIG_FAT_FS=m
CONFIG_VFAT_FS=m
CONFIG_TMPFS=y
CONFIG_RAMFS=y
CONFIG_ISO9660_FS=m
CONFIG_JOLIET=y
CONFIG_MINIX_FS=m
CONFIG_PROC_FS=y
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
CONFIG_MSDOS_PARTITION=y
CONFIG_SMB_NLS=y
CONFIG_NLS=y
CONFIG_NLS_DEFAULT="iso8859-1"
CONFIG_NLS_CODEPAGE_437=m
CONFIG_NLS_ISO8859_1=m
CONFIG_VGA_CONSOLE=y
CONFIG_VIDEO_SELECT=y
CONFIG_SOUND=y
CONFIG_SOUND_ICH=m
CONFIG_USB=m
CONFIG_USB_DEVICEFS=y
CONFIG_USB_UHCI=m
CONFIG_USB_AUDIO=m
CONFIG_USB_STORAGE=m
CONFIG_USB_PRINTER=m
CONFIG_USB_SCANNER=m
CONFIG_MKI=y
CONFIG_DEBUG_KERNEL=y
CONFIG_MAGIC_SYSRQ=y
CONFIG_ZLIB_INFLATE=m
CONFIG_ZLIB_DEFLATE=m

            CPU0
   0:     519112          XT-PIC  timer
   1:        952          XT-PIC  i8042
   2:          0          XT-PIC  cascade
   8:          3          XT-PIC  rtc
   9:          0          XT-PIC  acpi
  10:         75          XT-PIC  O2 Micro, Inc. OZ6933 Cardbus Contr, 
O2 Micro, Inc. OZ6933 Cardbus Contr (#2), Intel 82801CA-ICH3, eth0
  12:       4285          XT-PIC  i8042
  14:       2521          XT-PIC  ide0
  15:          8          XT-PIC  ide1
NMI:          0
LOC:     519056
ERR:          0
MIS:          0

00:00.0 Host bridge: Intel Corp.: Unknown device 3575 (rev 02)
	Subsystem: Acer Incorporated [ALI]: Unknown device 1017
	Flags: bus master, fast devsel, latency 0
	Memory at e0000000 (32-bit, prefetchable) [size=256M]
	Capabilities: <available only to root>

00:01.0 PCI bridge: Intel Corp.: Unknown device 3576 (rev 02) (prog-if 
00 [Normal decode])
	Flags: 66Mhz, fast devsel
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=64
	I/O behind bridge: 0000a000-0000afff
	Memory behind bridge: 80500000-805fffff
	Prefetchable memory behind bridge: 80600000-900fffff

00:1d.0 USB Controller: Intel Corp.: Unknown device 2482 (rev 01) 
(prog-if 00 [UHCI])
	Subsystem: Acer Incorporated [ALI]: Unknown device 1017
	Flags: bus master, medium devsel, latency 0, IRQ 11
	I/O ports at bca0 [size=32]

00:1d.1 USB Controller: Intel Corp.: Unknown device 2484 (rev 01) 
(prog-if 00 [UHCI])
	Subsystem: Acer Incorporated [ALI]: Unknown device 1017
	Flags: bus master, medium devsel, latency 0, IRQ 11
	I/O ports at bce0 [size=32]

00:1d.2 USB Controller: Intel Corp.: Unknown device 2487 (rev 01) 
(prog-if 00 [UHCI])
	Subsystem: Acer Incorporated [ALI]: Unknown device 1017
	Flags: medium devsel, IRQ 11
	I/O ports at c000 [size=32]

00:1e.0 PCI bridge: Intel Corp. 82820 820 (Camino 2) Chipset PCI (-M) 
(rev 41) (prog-if 00 [Normal decode])
	Flags: bus master, fast devsel, latency 0
	Bus: primary=00, secondary=02, subordinate=02, sec-latency=0
	I/O behind bridge: 00007000-00007fff
	Memory behind bridge: 80100000-801fffff

00:1f.0 ISA bridge: Intel Corp.: Unknown device 248c (rev 01)
	Flags: bus master, medium devsel, latency 0

00:1f.1 IDE interface: Intel Corp.: Unknown device 248a (rev 01) 
(prog-if 8a [Master SecP PriP])
	Subsystem: Acer Incorporated [ALI]: Unknown device 1017
	Flags: bus master, medium devsel, latency 0, IRQ 255
	I/O ports at <ignored>
	I/O ports at <ignored>
	I/O ports at <ignored>
	I/O ports at <ignored>
	I/O ports at c090 [size=16]
	Memory at 20002000 (32-bit, non-prefetchable) [size=1K]

00:1f.3 SMBus: Intel Corp.: Unknown device 2483 (rev 01)
	Subsystem: Acer Incorporated [ALI]: Unknown device 1017
	Flags: medium devsel, IRQ 10
	I/O ports at 8000 [size=32]

00:1f.5 Multimedia audio controller: Intel Corp. AC'97 Audio Controller 
(rev 01)
	Subsystem: Acer Incorporated [ALI]: Unknown device 1017
	Flags: bus master, medium devsel, latency 0, IRQ 10
	I/O ports at b000 [size=256]
	I/O ports at b400 [size=64]

00:1f.6 Modem: Intel Corp.: Unknown device 2486 (rev 01) (prog-if 00 
[Generic])
	Subsystem: Acer Incorporated [ALI]: Unknown device 1017
	Flags: medium devsel, IRQ 10
	I/O ports at b800 [size=256]
	I/O ports at bc00 [size=128]

01:00.0 VGA compatible controller: ATI Technologies Inc Radeon Mobility 
M6 LY (prog-if 00 [VGA])
	Subsystem: Acer Incorporated [ALI]: Unknown device 1017
	Flags: bus master, stepping, 66Mhz, medium devsel, latency 32, IRQ 11
	Memory at 88000000 (32-bit, prefetchable) [size=128M]
	I/O ports at a000 [size=256]
	Memory at 80500000 (32-bit, non-prefetchable) [size=64K]
	Expansion ROM at 80520000 [disabled] [size=128K]
	Capabilities: <available only to root>

02:08.0 Ethernet controller: Intel Corp. 82801CAM (ICH3) Chipset 
Ethernet Controller (rev 41)
	Subsystem: Acer Incorporated [ALI]: Unknown device 1017
	Flags: bus master, medium devsel, latency 66, IRQ 10
	Memory at 80100000 (32-bit, non-prefetchable) [size=4K]
	I/O ports at 7000 [size=64]
	Capabilities: <available only to root>

02:09.0 CardBus bridge: O2 Micro, Inc. OZ6933 Cardbus Controller (rev 01)
	Subsystem: Acer Incorporated [ALI]: Unknown device 1017
	Flags: bus master, stepping, slow devsel, latency 168, IRQ 10
	Memory at 20000000 (32-bit, non-prefetchable) [size=4K]
	Bus: primary=02, secondary=03, subordinate=06, sec-latency=176
	Memory window 0: 20400000-207ff000 (prefetchable)
	Memory window 1: 20800000-20bff000
	I/O window 0: 00001000-000010ff
	I/O window 1: 00001400-000014ff
	16-bit legacy interface ports at 0001

02:09.1 CardBus bridge: O2 Micro, Inc. OZ6933 Cardbus Controller (rev 01)
	Subsystem: Acer Incorporated [ALI]: Unknown device 1017
	Flags: bus master, stepping, slow devsel, latency 168, IRQ 10
	Memory at 20001000 (32-bit, non-prefetchable) [size=4K]
	Bus: primary=02, secondary=07, subordinate=0a, sec-latency=176
	Memory window 0: 20c00000-20fff000 (prefetchable)
	Memory window 1: 21000000-213ff000
	I/O window 0: 00001800-000018ff
	I/O window 1: 00001c00-00001cff
	16-bit legacy interface ports at 0001


-- 
Brad....
  /"\
  \ /     ASCII RIBBON CAMPAIGN
   X      AGAINST HTML MAIL
  / \

