Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130415AbRCEUb1>; Mon, 5 Mar 2001 15:31:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130416AbRCEUbR>; Mon, 5 Mar 2001 15:31:17 -0500
Received: from petem.xs4all.nl ([194.109.247.92]:4359 "EHLO q.petem.xs4all.nl")
	by vger.kernel.org with ESMTP id <S130415AbRCEUbF>;
	Mon, 5 Mar 2001 15:31:05 -0500
Date: Mon, 5 Mar 2001 21:30:56 +0100 (CET)
From: Peter Mottram <petem@xs4all.nl>
X-X-Sender: <apm@r6.petem.xs4all.nl>
To: <linux-kernel@vger.kernel.org>
Subject: 2.4.x total system crash - no oops (SCSI problems?)
Message-ID: <Pine.LNX.4.33.0103052113180.1237-100000@r6.petem.xs4all.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

kernel versions not affected:

all 2.2.x (as far as I know up to & including 2.2.19pre16)

kernel versions affected:

all 2.4.[012] + 2.4.2-ac9

Problem:

Using SCSI scanner on AHA152x causes system to completely lock up with no
oops  :-(

Filesystems on disks attached to aic7xxx (2740) need serious fsck on next
reboot.

Sorry no oops - not even on serial console.  :-(

This happens when using SANE.

system type:
SMP - dual Celeron 533 (Abit BP6 - 440bx)

Please CC me on any response (not a real list follower I'm afraid).

I am happy to blow up my system in any way to try to help get this fixed.

Cheers
PeteM

system/kernel detail follows.......

== start /proc/version ==
Linux version 2.2.19pre16 (root@r6) (gcc version 2.7.2.3) #1 SMP Sat Mar 3
16:30:29 CET 2001
== end /proc/version ==

== start /proc/cpu ==
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 6
model           : 6
model name      : Celeron (Mendocino)
stepping        : 5
cpu MHz         : 534.552
cache size      : 128 KB
fdiv_bug        : no
hlt_bug         : no
sep_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca
cmov
pat pse36 mmx fxsr
bogomips        : 1064.96

processor       : 1
vendor_id       : GenuineIntel
cpu family      : 6
model           : 6
model name      : Celeron (Mendocino)
stepping        : 5
cpu MHz         : 534.552
cache size      : 128 KB
fdiv_bug        : no
hlt_bug         : no
sep_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca
cmov
pat pse36 mmx fxsr
bogomips        : 1068.23
== end /proc/cpu ==

== start /proc/scsi/scsi ==
Attached devices:
Host: scsi0 Channel: 00 Id: 06 Lun: 00
  Vendor:          Model: Scanner 600A4    Rev: 2.21
  Type:   Scanner                          ANSI SCSI revision: 02
Host: scsi1 Channel: 00 Id: 00 Lun: 00
  Vendor: QUANTUM  Model: ATLAS 10K 18WLS  Rev: UCP0
  Type:   Direct-Access                    ANSI SCSI revision: 03
Host: scsi1 Channel: 00 Id: 01 Lun: 00
  Vendor: PLEXTOR  Model: CD-ROM PX-40TS   Rev: 1.10
  Type:   CD-ROM                           ANSI SCSI revision: 02
Host: scsi1 Channel: 00 Id: 03 Lun: 00
  Vendor: HP       Model: C1537A           Rev: L708
  Type:   Sequential-Access                ANSI SCSI revision: 02
Host: scsi1 Channel: 00 Id: 04 Lun: 00
  Vendor: PLEXTOR  Model: CD-R   PX-W124TS Rev: 1.04
  Type:   CD-ROM                           ANSI SCSI revision: 02
== end /proc/scsi/scsi ==

== start .config (2.4.2-ac9) ==
CONFIG_X86=y
CONFIG_ISA=y
CONFIG_UID16=y
CONFIG_EXPERIMENTAL=y
CONFIG_MODULES=y
CONFIG_MODVERSIONS=y
CONFIG_KMOD=y
CONFIG_M686=y
CONFIG_X86_WP_WORKS_OK=y
CONFIG_X86_INVLPG=y
CONFIG_X86_CMPXCHG=y
CONFIG_X86_BSWAP=y
CONFIG_X86_POPAD_OK=y
CONFIG_X86_L1_CACHE_SHIFT=5
CONFIG_X86_TSC=y
CONFIG_X86_GOOD_APIC=y
CONFIG_X86_PGE=y
CONFIG_X86_USE_PPRO_CHECKSUM=y
CONFIG_MICROCODE=y
CONFIG_X86_MSR=y
CONFIG_X86_CPUID=y
CONFIG_NOHIGHMEM=y
CONFIG_MTRR=y
CONFIG_SMP=y
CONFIG_HAVE_DEC_LOCK=y
CONFIG_NET=y
CONFIG_X86_IO_APIC=y
CONFIG_X86_LOCAL_APIC=y
CONFIG_PCI=y
CONFIG_PCI_GOANY=y
CONFIG_PCI_BIOS=y
CONFIG_PCI_DIRECT=y
CONFIG_PCI_NAMES=y
CONFIG_SYSVIPC=y
CONFIG_BSD_PROCESS_ACCT=y
CONFIG_SYSCTL=y
CONFIG_KCORE_ELF=y
CONFIG_BINFMT_AOUT=y
CONFIG_BINFMT_ELF=y
CONFIG_BINFMT_MISC=y
CONFIG_PARPORT=m
CONFIG_PARPORT_PC=m
CONFIG_PARPORT_PC_FIFO=y
CONFIG_PARPORT_1284=y
CONFIG_PNP=y
CONFIG_ISAPNP=y
CONFIG_BLK_DEV_FD=y
CONFIG_BLK_DEV_LOOP=y
CONFIG_MD=y
CONFIG_BLK_DEV_MD=m
CONFIG_MD_LINEAR=m
CONFIG_MD_RAID0=m
CONFIG_MD_RAID1=m
CONFIG_MD_RAID5=m
CONFIG_BLK_DEV_LVM=m
CONFIG_PACKET=y
CONFIG_FILTER=y
CONFIG_UNIX=y
CONFIG_INET=y
CONFIG_NET_IPIP=m
CONFIG_NET_IPGRE=m
CONFIG_IPV6=m
CONFIG_IPV6_EUI64=y
CONFIG_IPV6_NO_PB=y
CONFIG_IDE=y
CONFIG_BLK_DEV_IDE=y
CONFIG_BLK_DEV_IDEDISK=y
CONFIG_BLK_DEV_IDEPCI=y
CONFIG_IDEPCI_SHARE_IRQ=y
CONFIG_BLK_DEV_IDEDMA_PCI=y
CONFIG_IDEDMA_PCI_AUTO=y
CONFIG_BLK_DEV_IDEDMA=y
CONFIG_BLK_DEV_HPT366=y
CONFIG_BLK_DEV_PIIX=y
CONFIG_PIIX_TUNING=y
CONFIG_IDEDMA_AUTO=y
CONFIG_BLK_DEV_IDE_MODES=y
CONFIG_SCSI=y
CONFIG_BLK_DEV_SD=y
CONFIG_SD_EXTRA_DEVS=40
CONFIG_CHR_DEV_ST=y
CONFIG_BLK_DEV_SR=y
CONFIG_SR_EXTRA_DEVS=2
CONFIG_CHR_DEV_SG=y
CONFIG_SCSI_AHA152X=y
CONFIG_SCSI_AIC7XXX=y
CONFIG_AIC7XXX_CMDS_PER_DEVICE=8
CONFIG_NETDEVICES=y
CONFIG_DUMMY=m
CONFIG_NET_ETHERNET=y
CONFIG_NET_VENDOR_3COM=y
CONFIG_EL3=m
CONFIG_VORTEX=y
CONFIG_VT=y
CONFIG_VT_CONSOLE=y
CONFIG_SERIAL=y
CONFIG_UNIX98_PTYS=y
CONFIG_UNIX98_PTY_COUNT=256
CONFIG_PRINTER=m
CONFIG_I2C=m
CONFIG_I2C_ALGOBIT=m
CONFIG_I2C_PHILIPSPAR=m
CONFIG_I2C_ELV=m
CONFIG_I2C_VELLEMAN=m
CONFIG_I2C_ALGOPCF=m
CONFIG_I2C_ELEKTOR=m
CONFIG_I2C_CHARDEV=m
CONFIG_MOUSE=y
CONFIG_PSMOUSE=y
CONFIG_RTC=y
CONFIG_AGP=y
CONFIG_AGP_INTEL=y
CONFIG_DRM=y
CONFIG_DRM_MGA=y
CONFIG_VIDEO_DEV=m
CONFIG_VIDEO_PROC_FS=y
CONFIG_I2C_PARPORT=m
CONFIG_VIDEO_BT848=m
CONFIG_VIDEO_PMS=m
CONFIG_VIDEO_BWQCAM=m
CONFIG_VIDEO_CQCAM=m
CONFIG_VIDEO_CPIA=m
CONFIG_VIDEO_CPIA_PP=m
CONFIG_VIDEO_SAA5249=m
CONFIG_TUNER_3036=m
CONFIG_VIDEO_STRADIS=m
CONFIG_VIDEO_ZORAN=m
CONFIG_VIDEO_BUZ=m
CONFIG_VIDEO_ZR36120=m
CONFIG_RADIO_CADET=m
CONFIG_RADIO_RTRACK=m
CONFIG_RADIO_RTRACK2=m
CONFIG_RADIO_AZTECH=m
CONFIG_RADIO_GEMTEK=m
CONFIG_RADIO_MAXIRADIO=m
CONFIG_RADIO_MAESTRO=m
CONFIG_RADIO_MIROPCM20=m
CONFIG_RADIO_SF16FMI=m
CONFIG_RADIO_TERRATEC=m
CONFIG_RADIO_TRUST=m
CONFIG_RADIO_TYPHOON=m
CONFIG_RADIO_TYPHOON_PROC_FS=y
CONFIG_RADIO_ZOLTRIX=m
CONFIG_QUOTA=y
CONFIG_FAT_FS=y
CONFIG_MSDOS_FS=y
CONFIG_VFAT_FS=y
CONFIG_TMPFS=y
CONFIG_ISO9660_FS=y
CONFIG_JOLIET=y
CONFIG_PROC_FS=y
CONFIG_DEVPTS_FS=y
CONFIG_EXT2_FS=y
CONFIG_NFS_FS=m
CONFIG_NFS_V3=y
CONFIG_NFSD=y
CONFIG_NFSD_V3=y
CONFIG_SUNRPC=y
CONFIG_LOCKD=y
CONFIG_LOCKD_V4=y
CONFIG_MSDOS_PARTITION=y
CONFIG_NLS=y
CONFIG_NLS_DEFAULT="cp437"
CONFIG_NLS_CODEPAGE_437=m
CONFIG_NLS_CODEPAGE_850=m
CONFIG_NLS_ISO8859_1=m
CONFIG_NLS_ISO8859_15=m
CONFIG_VGA_CONSOLE=y
CONFIG_SOUND=y
CONFIG_SOUND_ES1371=y
CONFIG_SOUND_OSS=m
CONFIG_SOUND_TVMIXER=m
== end .config ==

== start /proc/pci ==
PCI devices found:
  Bus  0, device   0, function  0:
    Host bridge: Intel 440BX - 82443BX Host (rev 3).
      Medium devsel.  Master Capable.  Latency=32.
      Prefetchable 32 bit memory at 0xd0000000 [0xd0000008].
  Bus  0, device   1, function  0:
    PCI bridge: Intel 440BX - 82443BX AGP (rev 3).
      Medium devsel.  Master Capable.  Latency=64.  Min Gnt=136.
  Bus  0, device   7, function  0:
    ISA bridge: Intel 82371AB PIIX4 ISA (rev 2).
      Medium devsel.  Fast back-to-back capable.  Master Capable.  No bursts.
  Bus  0, device   7, function  1:
    IDE interface: Intel 82371AB PIIX4 IDE (rev 1).
      Medium devsel.  Fast back-to-back capable.  Master Capable.  Latency=32.
      I/O at 0xf000 [0xf001].
  Bus  0, device   7, function  2:
    USB Controller: Intel 82371AB PIIX4 USB (rev 1).
      Medium devsel.  Fast back-to-back capable.  Master Capable.  Latency=32.
      I/O at 0xc000 [0xc001].
  Bus  0, device   7, function  3:
    Bridge: Intel 82371AB PIIX4 ACPI (rev 2).
      Medium devsel.  Fast back-to-back capable.
  Bus  0, device   9, function  0:
    Ethernet controller: 3Com 3C905B 100bTX (rev 48).
      Medium devsel.  IRQ 9.  Master Capable.  Latency=32.  Min Gnt=10.Max Lat=10.
      I/O at 0xc400 [0xc401].
      Non-prefetchable 32 bit memory at 0xdb000000 [0xdb000000].
  Bus  0, device  13, function  0:
    SCSI storage controller: Adaptec AIC-7881U (rev 0).
      Medium devsel.  Fast back-to-back capable.  IRQ 9.  Master Capable.  Latency=32.  Min Gnt=8.Max Lat=8.
      I/O at 0xc800 [0xc801].
      Non-prefetchable 32 bit memory at 0xdb001000 [0xdb001000].
  Bus  0, device  15, function  0:
    Multimedia audio controller: Ensoniq ES1371 (rev 8).
      Slow devsel.  IRQ 14.  Master Capable.  Latency=32.  Min Gnt=12.Max Lat=128.
      I/O at 0xcc00 [0xcc01].
  Bus  0, device  19, function  0:
    Unknown mass storage controller: Triones Technologies, Inc. Unknown device (rev 1).
      Vendor id=1103. Device id=4.
      Medium devsel.  IRQ 15.  Master Capable.  Latency=248.  Min Gnt=8.Max Lat=8.
      I/O at 0xd000 [0xd001].
      I/O at 0xd400 [0xd401].
      I/O at 0xd800 [0xd801].
  Bus  0, device  19, function  1:
    Unknown mass storage controller: Triones Technologies, Inc. Unknown device (rev 1).
      Vendor id=1103. Device id=4.
      Medium devsel.  IRQ 15.  Master Capable.  Latency=248.  Min Gnt=8.Max Lat=8.
      I/O at 0xdc00 [0xdc01].
      I/O at 0xe000 [0xe001].
      I/O at 0xe400 [0xe401].
  Bus  1, device   0, function  0:
    VGA compatible controller: Matrox Unknown device (rev 4).
      Vendor id=102b. Device id=525.
      Medium devsel.  Fast back-to-back capable.  IRQ 14.  Master Capable.  Latency=32.  Min Gnt=16.Max Lat=32.
      Prefetchable 32 bit memory at 0xd8000000 [0xd8000008].
      Non-prefetchable 32 bit memory at 0xd4000000 [0xd4000000].
      Non-prefetchable 32 bit memory at 0xd5000000 [0xd5000000].
== end /proc/pci ==


