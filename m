Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261438AbTEQMjK (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 May 2003 08:39:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261444AbTEQMjK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 May 2003 08:39:10 -0400
Received: from 205-158-62-136.outblaze.com ([205.158.62.136]:28338 "HELO
	fs5-4.us4.outblaze.com") by vger.kernel.org with SMTP
	id S261438AbTEQMiy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 May 2003 08:38:54 -0400
Subject: Re: 2.5.69-mm6: pccard oops while booting: round 3
From: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
To: Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2003@gmx.net>,
       Andrew Morton <akpm@digeo.com>
Cc: rmk@arm.linux.org.uk, LKML <linux-kernel@vger.kernel.org>, davej@suse.de
In-Reply-To: <3EC61B63.9020906@gmx.net>
References: <1052964213.586.3.camel@teapot.felipe-alfaro.com>
	 <20030514191735.6fe0998c.akpm@digeo.com>
	 <1052998601.726.1.camel@teapot.felipe-alfaro.com>
	 <20030515130019.B30619@flint.arm.linux.org.uk>
	 <1053004615.586.2.camel@teapot.felipe-alfaro.com>
	 <20030515144439.A31491@flint.arm.linux.org.uk>
	 <1053037915.569.2.camel@teapot.felipe-alfaro.com>
	 <20030515160015.5dfea63f.akpm@digeo.com>
	 <1053090184.653.0.camel@teapot.felipe-alfaro.com>
	 <1053110098.648.1.camel@teapot.felipe-alfaro.com>
	 <20030516132908.62e54266.akpm@digeo.com>
	 <1053121346.569.1.camel@teapot.felipe-alfaro.com>
	 <3EC56173.1000306@gmx.net>
	 <1053166275.586.9.camel@teapot.felipe-alfaro.com>
	 <20030517031840.486683fc.akpm@digeo.com>
	 <1053169552.613.1.camel@teapot.felipe-alfaro.com>
	 <3EC61B63.9020906@gmx.net>
Content-Type: multipart/mixed; boundary="=-eXkeL1r6t/8oHvE7cwUp"
Message-Id: <1053175886.660.4.camel@teapot.felipe-alfaro.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.3.3 (Preview Release)
Date: 17 May 2003 14:51:26 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-eXkeL1r6t/8oHvE7cwUp
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Sat, 2003-05-17 at 13:22, Carl-Daniel Hailfinger wrote:

> Could you please enable modules again and load ymfpci as module? This is
> supposed to give the best results with ymfpci2.patch. For ymfpci built
> in, the patch unfortunately does not help much.

OK, We're getting closer, I think :-)

Attached to the message are: (a) "dmesg" with the oops caused by
modprobing snd-ymfpci, (b) the new "config" file used to build the
kernel, (c) "ymfpci2.patch" and (d) "sysfs.patch" with Andrew's latest
patch to sysfs_create_link function.

As always, from a pristine 2.5.69-mm6 kernel, apply "ymfpci2.patch",
then "sysfs.patch" and then use the supplied "config" to build. Boot
this test kernel into runlevel 1 and then "modprobe snd-ymfpci" causes
the oops described in the "dmesg" file.

Man, this is hard-chasing. Thank you guys for all your hard work!
Thanks^2!

--=-eXkeL1r6t/8oHvE7cwUp
Content-Disposition: attachment; filename=config
Content-Type: text/plain; name=config; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit

#
# Automatically generated make config: don't edit
#
CONFIG_X86=y
CONFIG_MMU=y
CONFIG_UID16=y
CONFIG_GENERIC_ISA_DMA=y

#
# Code maturity level options
#
# CONFIG_EXPERIMENTAL is not set

#
# General setup
#
# CONFIG_SWAP is not set
CONFIG_SYSVIPC=y
# CONFIG_BSD_PROCESS_ACCT is not set
CONFIG_SYSCTL=y
CONFIG_LOG_BUF_SHIFT=14

#
# Loadable module support
#
CONFIG_MODULES=y
# CONFIG_MODULE_UNLOAD is not set
CONFIG_OBSOLETE_MODPARM=y
# CONFIG_KMOD is not set
CONFIG_FUTEX=y
CONFIG_EPOLL=y

#
# Processor type and features
#
CONFIG_X86_PC=y
# CONFIG_X86_VOYAGER is not set
# CONFIG_X86_NUMAQ is not set
# CONFIG_X86_SUMMIT is not set
# CONFIG_X86_BIGSMP is not set
# CONFIG_X86_VISWS is not set
# CONFIG_X86_GENERICARCH is not set
# CONFIG_M386 is not set
# CONFIG_M486 is not set
# CONFIG_M586 is not set
# CONFIG_M586TSC is not set
# CONFIG_M586MMX is not set
# CONFIG_M686 is not set
# CONFIG_MPENTIUMII is not set
CONFIG_MPENTIUMIII=y
# CONFIG_MPENTIUM4 is not set
# CONFIG_MK6 is not set
# CONFIG_MK7 is not set
# CONFIG_MK8 is not set
# CONFIG_MELAN is not set
# CONFIG_MCRUSOE is not set
# CONFIG_MWINCHIPC6 is not set
# CONFIG_MWINCHIP2 is not set
# CONFIG_MWINCHIP3D is not set
# CONFIG_MCYRIXIII is not set
# CONFIG_MVIAC3_2 is not set
# CONFIG_X86_GENERIC is not set
CONFIG_X86_CMPXCHG=y
CONFIG_X86_XADD=y
CONFIG_X86_L1_CACHE_SHIFT=5
CONFIG_RWSEM_XCHGADD_ALGORITHM=y
CONFIG_X86_WP_WORKS_OK=y
CONFIG_X86_INVLPG=y
CONFIG_X86_BSWAP=y
CONFIG_X86_POPAD_OK=y
CONFIG_X86_GOOD_APIC=y
CONFIG_X86_INTEL_USERCOPY=y
CONFIG_X86_USE_PPRO_CHECKSUM=y
# CONFIG_HUGETLB_PAGE is not set
# CONFIG_SMP is not set
# CONFIG_PREEMPT is not set
# CONFIG_X86_UP_APIC is not set
CONFIG_X86_TSC=y
# CONFIG_X86_MCE is not set
# CONFIG_TOSHIBA is not set
# CONFIG_I8K is not set
# CONFIG_MICROCODE is not set
# CONFIG_X86_MSR is not set
# CONFIG_X86_CPUID is not set
CONFIG_NOHIGHMEM=y
# CONFIG_HIGHMEM4G is not set
# CONFIG_HIGHMEM64G is not set
# CONFIG_025GB is not set
# CONFIG_05GB is not set
CONFIG_1GB=y
# CONFIG_2GB is not set
# CONFIG_3GB is not set
# CONFIG_MATH_EMULATION is not set
# CONFIG_MTRR is not set

#
# Power management options (ACPI, APM)
#
# CONFIG_PM is not set

#
# ACPI Support
#
# CONFIG_ACPI is not set

#
# CPU Frequency scaling
#
# CONFIG_CPU_FREQ is not set

#
# Bus options (PCI, PCMCIA, EISA, MCA, ISA)
#
CONFIG_PCI=y
# CONFIG_PCI_GOBIOS is not set
# CONFIG_PCI_GODIRECT is not set
CONFIG_PCI_GOANY=y
CONFIG_PCI_BIOS=y
CONFIG_PCI_DIRECT=y
# CONFIG_PCI_LEGACY_PROC is not set
# CONFIG_PCI_NAMES is not set
# CONFIG_ISA is not set
# CONFIG_MCA is not set
# CONFIG_SCx200 is not set
# CONFIG_HOTPLUG is not set

#
# Executable file formats
#
CONFIG_KCORE_ELF=y
# CONFIG_KCORE_AOUT is not set
# CONFIG_BINFMT_AOUT is not set
CONFIG_BINFMT_ELF=y
# CONFIG_BINFMT_MISC is not set

#
# Memory Technology Devices (MTD)
#
# CONFIG_MTD is not set

#
# Parallel port support
#
# CONFIG_PARPORT is not set

#
# Plug and Play support
#
# CONFIG_PNP is not set

#
# Block devices
#
# CONFIG_BLK_DEV_FD is not set
# CONFIG_BLK_CPQ_DA is not set
# CONFIG_BLK_CPQ_CISS_DA is not set
# CONFIG_BLK_DEV_DAC960 is not set
# CONFIG_BLK_DEV_LOOP is not set
# CONFIG_BLK_DEV_RAM is not set
# CONFIG_BLK_DEV_INITRD is not set
# CONFIG_LBD is not set

#
# ATA/ATAPI/MFM/RLL device support
#
CONFIG_IDE=y

#
# IDE, ATA and ATAPI Block devices
#
CONFIG_BLK_DEV_IDE=y

#
# Please see Documentation/ide.txt for help/info on IDE drives
#
# CONFIG_BLK_DEV_HD_IDE is not set
# CONFIG_BLK_DEV_HD is not set
CONFIG_BLK_DEV_IDEDISK=y
CONFIG_IDEDISK_MULTI_MODE=y
# CONFIG_IDEDISK_STROKE is not set
# CONFIG_BLK_DEV_IDECD is not set
# CONFIG_BLK_DEV_IDEFLOPPY is not set
# CONFIG_IDE_TASK_IOCTL is not set

#
# IDE chipset support/bugfixes
#
# CONFIG_BLK_DEV_CMD640 is not set
CONFIG_BLK_DEV_IDEPCI=y
# CONFIG_BLK_DEV_GENERIC is not set
# CONFIG_IDEPCI_SHARE_IRQ is not set
CONFIG_BLK_DEV_IDEDMA_PCI=y
# CONFIG_BLK_DEV_OFFBOARD is not set
# CONFIG_BLK_DEV_IDEDMA_FORCED is not set
# CONFIG_IDEDMA_PCI_AUTO is not set
CONFIG_BLK_DEV_IDEDMA=y
CONFIG_BLK_DEV_ADMA=y
# CONFIG_BLK_DEV_AEC62XX is not set
# CONFIG_BLK_DEV_ALI15X3 is not set
# CONFIG_BLK_DEV_AMD74XX is not set
# CONFIG_BLK_DEV_CMD64X is not set
# CONFIG_BLK_DEV_TRIFLEX is not set
# CONFIG_BLK_DEV_CY82C693 is not set
# CONFIG_BLK_DEV_HPT34X is not set
# CONFIG_BLK_DEV_HPT366 is not set
# CONFIG_BLK_DEV_SC1200 is not set
CONFIG_BLK_DEV_PIIX=y
# CONFIG_BLK_DEV_NS87415 is not set
# CONFIG_BLK_DEV_PDC202XX_OLD is not set
# CONFIG_BLK_DEV_PDC202XX_NEW is not set
# CONFIG_BLK_DEV_RZ1000 is not set
# CONFIG_BLK_DEV_SVWKS is not set
# CONFIG_BLK_DEV_SIIMAGE is not set
# CONFIG_BLK_DEV_SIS5513 is not set
# CONFIG_BLK_DEV_SLC90E66 is not set
# CONFIG_BLK_DEV_TRM290 is not set
# CONFIG_BLK_DEV_VIA82CXXX is not set
# CONFIG_IDEDMA_IVB is not set
CONFIG_BLK_DEV_IDE_MODES=y

#
# SCSI device support
#
# CONFIG_SCSI is not set

#
# Multi-device support (RAID and LVM)
#
# CONFIG_MD is not set

#
# Fusion MPT device support
#

#
# I2O device support
#
# CONFIG_I2O is not set

#
# Networking support
#
# CONFIG_NET is not set

#
# Amateur Radio support
#
# CONFIG_HAMRADIO is not set

#
# ISDN subsystem
#

#
# Telephony Support
#
# CONFIG_PHONE is not set

#
# Input device support
#
CONFIG_INPUT=y

#
# Userland interfaces
#
# CONFIG_INPUT_MOUSEDEV is not set
# CONFIG_INPUT_JOYDEV is not set
# CONFIG_INPUT_TSDEV is not set
# CONFIG_INPUT_EVDEV is not set
# CONFIG_INPUT_EVBUG is not set

#
# Input I/O drivers
#
# CONFIG_GAMEPORT is not set
CONFIG_SOUND_GAMEPORT=y
CONFIG_SERIO=y
CONFIG_SERIO_I8042=y
# CONFIG_SERIO_SERPORT is not set
# CONFIG_SERIO_CT82C710 is not set

#
# Input Device Drivers
#
CONFIG_INPUT_KEYBOARD=y
CONFIG_KEYBOARD_ATKBD=y
# CONFIG_KEYBOARD_SUNKBD is not set
# CONFIG_KEYBOARD_XTKBD is not set
# CONFIG_KEYBOARD_NEWTON is not set
# CONFIG_INPUT_MOUSE is not set
# CONFIG_INPUT_JOYSTICK is not set
# CONFIG_INPUT_TOUCHSCREEN is not set
# CONFIG_INPUT_MISC is not set

#
# Character devices
#
CONFIG_VT=y
CONFIG_VT_CONSOLE=y
CONFIG_HW_CONSOLE=y
# CONFIG_SERIAL_NONSTANDARD is not set

#
# Serial drivers
#

#
# Non-8250 serial port support
#
CONFIG_UNIX98_PTYS=y
CONFIG_UNIX98_PTY_COUNT=256

#
# I2C support
#
# CONFIG_I2C is not set

#
# I2C Hardware Sensors Mainboard support
#

#
# I2C Hardware Sensors Chip support
#
# CONFIG_I2C_SENSOR is not set

#
# Mice
#
# CONFIG_BUSMOUSE is not set
# CONFIG_QIC02_TAPE is not set

#
# IPMI
#
# CONFIG_IPMI_HANDLER is not set

#
# Watchdog Cards
#
# CONFIG_WATCHDOG is not set
# CONFIG_HW_RANDOM is not set
# CONFIG_NVRAM is not set
# CONFIG_RTC is not set
# CONFIG_GEN_RTC is not set
# CONFIG_DTLK is not set
# CONFIG_R3964 is not set
# CONFIG_APPLICOM is not set

#
# Ftape, the floppy tape device driver
#
# CONFIG_FTAPE is not set
# CONFIG_AGP is not set
# CONFIG_DRM is not set
# CONFIG_MWAVE is not set
# CONFIG_RAW_DRIVER is not set
# CONFIG_HANGCHECK_TIMER is not set

#
# Multimedia devices
#
# CONFIG_VIDEO_DEV is not set

#
# File systems
#
CONFIG_EXT2_FS=y
# CONFIG_EXT2_FS_XATTR is not set
# CONFIG_EXT3_FS is not set
# CONFIG_JBD is not set
# CONFIG_REISERFS_FS is not set
# CONFIG_JFS_FS is not set
# CONFIG_XFS_FS is not set
# CONFIG_MINIX_FS is not set
# CONFIG_ROMFS_FS is not set
# CONFIG_QUOTA is not set
# CONFIG_AUTOFS_FS is not set
# CONFIG_AUTOFS4_FS is not set

#
# CD-ROM/DVD Filesystems
#
# CONFIG_ISO9660_FS is not set
# CONFIG_UDF_FS is not set

#
# DOS/FAT/NT Filesystems
#
# CONFIG_FAT_FS is not set
# CONFIG_NTFS_FS is not set

#
# Pseudo filesystems
#
CONFIG_PROC_FS=y
CONFIG_DEVPTS_FS=y
# CONFIG_DEVPTS_FS_XATTR is not set
CONFIG_TMPFS=y
CONFIG_RAMFS=y

#
# Miscellaneous filesystems
#
# CONFIG_CRAMFS is not set
# CONFIG_VXFS_FS is not set
# CONFIG_HPFS_FS is not set
# CONFIG_QNX4FS_FS is not set
# CONFIG_SYSV_FS is not set
# CONFIG_UFS_FS is not set

#
# Partition Types
#
# CONFIG_PARTITION_ADVANCED is not set
CONFIG_MSDOS_PARTITION=y

#
# Graphics support
#
# CONFIG_FB is not set
CONFIG_VIDEO_SELECT=y

#
# Console display driver support
#
CONFIG_VGA_CONSOLE=y
# CONFIG_MDA_CONSOLE is not set
CONFIG_DUMMY_CONSOLE=y

#
# Sound
#
CONFIG_SOUND=y

#
# Advanced Linux Sound Architecture
#
CONFIG_SND=y
# CONFIG_SND_SEQUENCER is not set
# CONFIG_SND_OSSEMUL is not set
# CONFIG_SND_VERBOSE_PRINTK is not set
# CONFIG_SND_DEBUG is not set

#
# Generic devices
#
# CONFIG_SND_DUMMY is not set
# CONFIG_SND_MTPAV is not set
# CONFIG_SND_SERIAL_U16550 is not set
# CONFIG_SND_MPU401 is not set

#
# PCI devices
#
# CONFIG_SND_ALI5451 is not set
# CONFIG_SND_CS46XX is not set
# CONFIG_SND_CS4281 is not set
# CONFIG_SND_EMU10K1 is not set
# CONFIG_SND_KORG1212 is not set
# CONFIG_SND_NM256 is not set
# CONFIG_SND_RME32 is not set
# CONFIG_SND_RME96 is not set
# CONFIG_SND_RME9652 is not set
# CONFIG_SND_HDSP is not set
# CONFIG_SND_TRIDENT is not set
CONFIG_SND_YMFPCI=m
# CONFIG_SND_ALS4000 is not set
# CONFIG_SND_CMIPCI is not set
# CONFIG_SND_ENS1370 is not set
# CONFIG_SND_ENS1371 is not set
# CONFIG_SND_ES1938 is not set
# CONFIG_SND_ES1968 is not set
# CONFIG_SND_MAESTRO3 is not set
# CONFIG_SND_FM801 is not set
# CONFIG_SND_ICE1712 is not set
# CONFIG_SND_ICE1724 is not set
# CONFIG_SND_INTEL8X0 is not set
# CONFIG_SND_SONICVIBES is not set
# CONFIG_SND_VIA82XX is not set

#
# Open Sound System
#
# CONFIG_SOUND_PRIME is not set

#
# USB support
#
# CONFIG_USB is not set

#
# Kernel hacking
#
# CONFIG_DEBUG_KERNEL is not set
CONFIG_KALLSYMS=y
# CONFIG_DEBUG_SPINLOCK_SLEEP is not set
CONFIG_DEBUG_INFO=y
CONFIG_FRAME_POINTER=y

#
# Security options
#
# CONFIG_SECURITY is not set

#
# Cryptographic options
#
# CONFIG_CRYPTO is not set

#
# Library routines
#
# CONFIG_CRC32 is not set
CONFIG_X86_BIOS_REBOOT=y

--=-eXkeL1r6t/8oHvE7cwUp
Content-Disposition: attachment; filename=dmesg
Content-Type: text/plain; name=dmesg; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit

Linux version 2.5.69-mm6-test (root@glass.felipe-alfaro.com) (gcc version 3.2.3 20030422 (Red Hat Linux 3.2.3-4)) #11 Sat May 17 14:40:15 CEST 2003
Video mode to be used for restore is f00
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000e0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000000fff0000 (usable)
 BIOS-e820: 000000000fff0000 - 000000000fff8000 (ACPI data)
 BIOS-e820: 000000000fff8000 - 0000000010000000 (ACPI NVS)
 BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
 BIOS-e820: 00000000fff80000 - 0000000100000000 (reserved)
255MB LOWMEM available.
On node 0 totalpages: 65520
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 61424 pages, LIFO batch:14
  HighMem zone: 0 pages, LIFO batch:1
Building zonelist for node : 0
Kernel command line: ro root=/dev/hda3 1
Initializing CPU#0
PID hash table entries: 1024 (order 10: 8192 bytes)
Detected 697.151 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 1376.25 BogoMIPS
Memory: 257504k/262080k available (767k kernel code, 3848k reserved, 246k data, 96k init, 0k highmem)
Dentry cache hash table entries: 32768 (order: 5, 131072 bytes)
Inode-cache hash table entries: 16384 (order: 4, 65536 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
-> /dev
-> /dev/console
-> /root
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 256K
CPU:     After generic, caps: 0383f9ff 00000000 00000000 00000040
CPU: Intel Pentium III (Coppermine) stepping 06
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
Linux NoNET1.0 for Linux 2.6
PCI: PCI BIOS revision 2.10 entry at 0xfdb81, last bus=1
PCI: Using configuration type 1
BIO: pool of 256 setup, 14Kb (56 bytes/bio)
biovec pool[0]:   1 bvecs: 256 entries (12 bytes)
biovec pool[1]:   4 bvecs: 256 entries (48 bytes)
biovec pool[2]:  16 bvecs: 256 entries (192 bytes)
biovec pool[3]:  64 bvecs: 256 entries (768 bytes)
biovec pool[4]: 128 bvecs: 256 entries (1536 bytes)
biovec pool[5]: 256 bvecs: 256 entries (3072 bytes)
block request queues:
 4/128 requests per read queue
 4/128 requests per write queue
 enter congestion at 15
 exit congestion at 17
PCI: Probing PCI hardware
PCI: Probing PCI hardware (bus 00)
PCI: Using IRQ router PIIX [8086/7110] at 00:07.0
PCI: IRQ 0 for device 00:0c.0 doesn't match PIRQ mask - try pci=usepirqmask
PCI: Found IRQ 10 for device 00:0c.0
PCI: IRQ 0 for device 00:0c.1 doesn't match PIRQ mask - try pci=usepirqmask
PCI: Found IRQ 5 for device 00:0c.1
PCI: Sharing IRQ 5 with 00:09.0
SBF: Simple Boot Flag extension found and enabled.
SBF: Setting boot flags 0x1
Enabling SEP on CPU 0
Limiting direct PCI/PCI transfers.
pty: 256 Unix98 ptys configured
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
PIIX4: IDE controller at PCI slot 00:07.1
PIIX4: chipset revision 1
PIIX4: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xffa0-0xffa7, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xffa8-0xffaf, BIOS settings: hdc:DMA, hdd:pio
hda: HITACHI_DK23BA-20, ATA DISK drive
anticipatory scheduling elevator
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hdc: MATSHITADVD-ROM SR-8185, ATAPI CD/DVD-ROM drive
anticipatory scheduling elevator
ide1 at 0x170-0x177,0x376 on irq 15
hda: max request size: 128KiB
hda: host protected area => 1
hda: 39070080 sectors (20004 MB) w/2048KiB Cache, CHS=38760/16/63
 hda: hda1 hda2 hda3 hda4
serio: i8042 AUX port at 0x60,0x64 irq 12
input: AT Set 2 keyboard on isa0060/serio0
serio: i8042 KBD port at 0x60,0x64 irq 1
Advanced Linux Sound Architecture Driver Version 0.9.2 (Thu Mar 20 13:31:57 2003 UTC).
ALSA device list:
  No soundcards found.
VFS: Mounted root (ext2 filesystem) readonly.
Freeing unused kernel memory: 96k freed
PCI: Found IRQ 5 for device 00:09.0
PCI: Sharing IRQ 5 with 00:0c.1
Unable to handle kernel paging request at virtual address b46c20d7
 printing eip:
c016b62f
*pde = 00000000
Oops: 0000 [#1]
CPU:    0
EIP:    0060:[<c016b62f>]    Not tainted VLI
EFLAGS: 00010246
EIP is at sysfs_create_link+0xcf/0x130
eax: cf643f60   ebx: ffffffff   ecx: ffffffff   edx: b46c20cf
esi: c01c99bb   edi: cff5e470   ebp: cf765ef0   esp: cf765ec4
ds: 007b   es: 007b   ss: 0068
Process modprobe (pid: 150, threadinfo=cf764000 task=cfc8f8c0)
Stack: cff5e470 cf643f60 00000023 d0825d60 cfb73000 cf643f60 00000023 b46c20cf 
       d0825d90 cff5e44c 00000000 cf765f08 c0195cc2 d0825d60 cff5e470 cff5e470 
       d0825d48 cf765f24 c0195d4a cff5e44c d0825d48 cff5e454 c01e25a0 d0825d48 
Call Trace:
 [<d0825d60>] driver+0x40/0xa0 [snd_ymfpci]
 [<d0825d90>] driver+0x70/0xa0 [snd_ymfpci]
 [<c0195cc2>] device_bind_driver+0x42/0x50
 [<d0825d60>] driver+0x40/0xa0 [snd_ymfpci]
 [<d0825d48>] driver+0x28/0xa0 [snd_ymfpci]
 [<c0195d4a>] bus_match+0x7a/0x80
 [<d0825d48>] driver+0x28/0xa0 [snd_ymfpci]
 [<d0825d48>] driver+0x28/0xa0 [snd_ymfpci]
 [<c0195e3d>] driver_attach+0x5d/0x70
 [<d0825d48>] driver+0x28/0xa0 [snd_ymfpci]
 [<d0825d48>] driver+0x28/0xa0 [snd_ymfpci]
 [<c01960e6>] bus_add_driver+0xa6/0xc0
 [<d0825d48>] driver+0x28/0xa0 [snd_ymfpci]
 [<d082c080>] +0x0/0xa0 [snd_ymfpci]
 [<c0196541>] driver_register+0x31/0x40
 [<d0825d48>] driver+0x28/0xa0 [snd_ymfpci]
 [<c017e145>] pci_register_driver+0x45/0x60
 [<d0825d48>] driver+0x28/0xa0 [snd_ymfpci]
 [<d080c7a8>] alsa_card_ymfpci_init+0x18/0x60 [snd_ymfpci]
 [<d0825d20>] driver+0x0/0xa0 [snd_ymfpci]
 [<c0128d32>] sys_init_module+0x102/0x1b0
 [<d082c080>] +0x0/0xa0 [snd_ymfpci]
 [<c010932d>] sysenter_past_esp+0x52/0x71

Code: ac aa 84 c0 75 fa 4b 83 c1 03 83 fb ff 75 ed 8b 45 ec 8b 55 e8 8b 7d 0c 89 44 24 08 89 54 24 04 89 3c 24 e8 d4 fe ff ff 8b 55 f0 <8b> 42 08 8d 48 6c ff 48 6c 78 68 8b 45 10 89 14 24 89 44 24 04 
 

--=-eXkeL1r6t/8oHvE7cwUp
Content-Disposition: attachment; filename=sysfs.patch
Content-Type: text/plain; name=sysfs.patch; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit

--- 25/fs/sysfs/symlink.c~sysfs_create_link-fix	2003-05-17 04:34:50.000000000 -0700
+++ 25-akpm/fs/sysfs/symlink.c	2003-05-17 04:34:56.000000000 -0700
@@ -80,7 +80,7 @@ int sysfs_create_link(struct kobject * k
 	char * s;
 
 	depth = object_depth(kobj);
-	size = object_path_length(target) + depth * 3 - 1;
+	size = object_path_length(target) + depth * 3 + 1;
 	if (size > PATH_MAX)
 		return -ENAMETOOLONG;
 	pr_debug("%s: depth = %d, size = %d\n",__FUNCTION__,depth,size);

--=-eXkeL1r6t/8oHvE7cwUp
Content-Disposition: attachment; filename=ymfpci2.patch
Content-Type: text/x-patch; name=ymfpci2.patch; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit

diff -puN ./sound/pci/ymfpci/ymfpci_main.c~a ./sound/pci/ymfpci/ymfpci_main.c
--- 25/./sound/pci/ymfpci/ymfpci_main.c~a	2003-05-16 13:26:26.000000000 -0700
+++ 25-akpm/./sound/pci/ymfpci/ymfpci_main.c	2003-05-16 13:27:27.000000000 -0700
@@ -1093,7 +1093,7 @@ int __devinit snd_ymfpci_pcm(ymfpci_t *c
 
 	if (rpcm)
 		*rpcm = NULL;
-	if ((err = snd_pcm_new(chip->card, "YMFPCI", device, 32, 1, &pcm)) < 0)
+	if ((err = snd_pcm_new(chip->card, "1MFPCI", device, 32, 1, &pcm)) < 0)
 		return err;
 	pcm->private_data = chip;
 	pcm->private_free = snd_ymfpci_pcm_free;
@@ -1103,7 +1103,7 @@ int __devinit snd_ymfpci_pcm(ymfpci_t *c
 
 	/* global setup */
 	pcm->info_flags = 0;
-	strcpy(pcm->name, "YMFPCI");
+	strcpy(pcm->name, "2MFPCI");
 	chip->pcm = pcm;
 
 	snd_pcm_lib_preallocate_pci_pages_for_all(chip->pci, pcm, 64*1024, 256*1024);
@@ -1138,7 +1138,7 @@ int __devinit snd_ymfpci_pcm2(ymfpci_t *
 
 	if (rpcm)
 		*rpcm = NULL;
-	if ((err = snd_pcm_new(chip->card, "YMFPCI - AC'97", device, 0, 1, &pcm)) < 0)
+	if ((err = snd_pcm_new(chip->card, "3MFPCI - AC'97", device, 0, 1, &pcm)) < 0)
 		return err;
 	pcm->private_data = chip;
 	pcm->private_free = snd_ymfpci_pcm2_free;
@@ -1147,7 +1147,7 @@ int __devinit snd_ymfpci_pcm2(ymfpci_t *
 
 	/* global setup */
 	pcm->info_flags = 0;
-	strcpy(pcm->name, "YMFPCI - AC'97");
+	strcpy(pcm->name, "4MFPCI - AC'97");
 	chip->pcm2 = pcm;
 
 	snd_pcm_lib_preallocate_pci_pages_for_all(chip->pci, pcm, 64*1024, 256*1024);
@@ -1182,7 +1182,7 @@ int __devinit snd_ymfpci_pcm_spdif(ymfpc
 
 	if (rpcm)
 		*rpcm = NULL;
-	if ((err = snd_pcm_new(chip->card, "YMFPCI - IEC958", device, 1, 0, &pcm)) < 0)
+	if ((err = snd_pcm_new(chip->card, "5MFPCI - IEC958", device, 1, 0, &pcm)) < 0)
 		return err;
 	pcm->private_data = chip;
 	pcm->private_free = snd_ymfpci_pcm_spdif_free;
@@ -1191,7 +1191,7 @@ int __devinit snd_ymfpci_pcm_spdif(ymfpc
 
 	/* global setup */
 	pcm->info_flags = 0;
-	strcpy(pcm->name, "YMFPCI - IEC958");
+	strcpy(pcm->name, "6MFPCI - IEC958");
 	chip->pcm_spdif = pcm;
 
 	snd_pcm_lib_preallocate_pci_pages_for_all(chip->pci, pcm, 64*1024, 256*1024);
@@ -1226,7 +1226,7 @@ int __devinit snd_ymfpci_pcm_4ch(ymfpci_
 
 	if (rpcm)
 		*rpcm = NULL;
-	if ((err = snd_pcm_new(chip->card, "YMFPCI - Rear", device, 1, 0, &pcm)) < 0)
+	if ((err = snd_pcm_new(chip->card, "7MFPCI - Rear", device, 1, 0, &pcm)) < 0)
 		return err;
 	pcm->private_data = chip;
 	pcm->private_free = snd_ymfpci_pcm_4ch_free;
@@ -1235,7 +1235,7 @@ int __devinit snd_ymfpci_pcm_4ch(ymfpci_
 
 	/* global setup */
 	pcm->info_flags = 0;
-	strcpy(pcm->name, "YMFPCI - Rear PCM");
+	strcpy(pcm->name, "8MFPCI - Rear PCM");
 	chip->pcm_4ch = pcm;
 
 	snd_pcm_lib_preallocate_pci_pages_for_all(chip->pci, pcm, 64*1024, 256*1024);
@@ -1831,7 +1831,7 @@ static void snd_ymfpci_proc_read(snd_inf
 {
 	// ymfpci_t *chip = snd_magic_cast(ymfpci_t, private_data, return);
 	
-	snd_iprintf(buffer, "YMFPCI\n\n");
+	snd_iprintf(buffer, "9MFPCI\n\n");
 }
 
 static int __devinit snd_ymfpci_proc_init(snd_card_t * card, ymfpci_t *chip)
@@ -2226,12 +2226,12 @@ int __devinit snd_ymfpci_create(snd_card
 	chip->reg_area_virt = (unsigned long)ioremap_nocache(chip->reg_area_phys, 0x8000);
 	pci_set_master(pci);
 
-	if ((chip->res_reg_area = request_mem_region(chip->reg_area_phys, 0x8000, "YMFPCI")) == NULL) {
+	if ((chip->res_reg_area = request_mem_region(chip->reg_area_phys, 0x8000, "AMFPCI")) == NULL) {
 		snd_ymfpci_free(chip);
 		snd_printk("unable to grab memory region 0x%lx-0x%lx\n", chip->reg_area_phys, chip->reg_area_phys + 0x8000 - 1);
 		return -EBUSY;
 	}
-	if (request_irq(pci->irq, snd_ymfpci_interrupt, SA_INTERRUPT|SA_SHIRQ, "YMFPCI", (void *) chip)) {
+	if (request_irq(pci->irq, snd_ymfpci_interrupt, SA_INTERRUPT|SA_SHIRQ, "BMFPCI", (void *) chip)) {
 		snd_ymfpci_free(chip);
 		snd_printk("unable to grab IRQ %d\n", pci->irq);
 		return -EBUSY;
diff -puN ./sound/pci/ymfpci/ymfpci.c~a ./sound/pci/ymfpci/ymfpci.c
--- 25/./sound/pci/ymfpci/ymfpci.c~a	2003-05-16 13:26:26.000000000 -0700
+++ 25-akpm/./sound/pci/ymfpci/ymfpci.c	2003-05-16 13:27:49.000000000 -0700
@@ -122,7 +122,7 @@ static int __devinit snd_card_ymfpci_pro
 			fm_port[dev] = addr;
 		}
 		if (fm_port[dev] >= 0 &&
-		    (chip->fm_res = request_region(fm_port[dev], 4, "YMFPCI OPL3")) != NULL) {
+		    (chip->fm_res = request_region(fm_port[dev], 4, "CMFPCI OPL3")) != NULL) {
 			legacy_ctrl |= YMFPCI_LEGACY_FMEN;
 			pci_write_config_word(pci, PCIR_DSXG_FMBASE, fm_port[dev]);
 		}
@@ -133,7 +133,7 @@ static int __devinit snd_card_ymfpci_pro
 			mpu_port[dev] = addr;
 		}
 		if (mpu_port[dev] >= 0 &&
-		    (chip->mpu_res = request_region(mpu_port[dev], 2, "YMFPCI MPU401")) != NULL) {
+		    (chip->mpu_res = request_region(mpu_port[dev], 2, "DMFPCI MPU401")) != NULL) {
 			legacy_ctrl |= YMFPCI_LEGACY_MEN;
 			pci_write_config_word(pci, PCIR_DSXG_MPU401BASE, mpu_port[dev]);
 		}
@@ -146,7 +146,7 @@ static int __devinit snd_card_ymfpci_pro
 		default: fm_port[dev] = -1; break;
 		}
 		if (fm_port[dev] > 0 &&
-		    (chip->fm_res = request_region(fm_port[dev], 4, "YMFPCI OPL3")) != NULL) {
+		    (chip->fm_res = request_region(fm_port[dev], 4, "EMFPCI OPL3")) != NULL) {
 			legacy_ctrl |= YMFPCI_LEGACY_FMEN;
 		} else {
 			legacy_ctrl2 &= ~YMFPCI_LEGACY2_FMIO;
@@ -160,7 +160,7 @@ static int __devinit snd_card_ymfpci_pro
 		default: mpu_port[dev] = -1; break;
 		}
 		if (mpu_port[dev] > 0 &&
-		    (chip->mpu_res = request_region(mpu_port[dev], 2, "YMFPCI MPU401")) != NULL) {
+		    (chip->mpu_res = request_region(mpu_port[dev], 2, "FMFPCI MPU401")) != NULL) {
 			legacy_ctrl |= YMFPCI_LEGACY_MEN;
 		} else {
 			legacy_ctrl2 &= ~YMFPCI_LEGACY2_MPUIO;


--=-eXkeL1r6t/8oHvE7cwUp--

