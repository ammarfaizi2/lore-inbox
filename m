Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284444AbRLRSQb>; Tue, 18 Dec 2001 13:16:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284451AbRLRSQN>; Tue, 18 Dec 2001 13:16:13 -0500
Received: from mout1.freenet.de ([194.97.50.132]:36257 "EHLO mout1.freenet.de")
	by vger.kernel.org with ESMTP id <S284445AbRLRSP7>;
	Tue, 18 Dec 2001 13:15:59 -0500
Message-ID: <3C1F8825.2080802@athlon.maya.org>
Date: Tue, 18 Dec 2001 19:17:09 +0100
From: Andreas Hartmann <andihartmann@freenet.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.6) Gecko/20011120
X-Accept-Language: en-us
MIME-Version: 1.0
To: Kernel-Mailingliste <linux-kernel@vger.kernel.org>
Subject: [2.4.17rc1] fatal problem: system time suddenly changes
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,

I'm running kernel 2.4.17rc1 and I detected suddenly changes of
systemtime. I saw it in KDE and tested it afterwards in a konsole. I
repeated as fast as possible the date program as following:

andreas@athlon:~ > date
Tue Dec 18 08:12:29 CET 2001
andreas@athlon:~ > date
Tue Dec 18 08:12:30 CET 2001
andreas@athlon:~ > date
Tue Dec 18 08:12:30 CET 2001
andreas@athlon:~ > date
Tue Dec 18 08:12:30 CET 2001
andreas@athlon:~ > date
Tue Dec 18 08:12:31 CET 2001
andreas@athlon:~ > date
Tue Dec 18 08:12:31 CET 2001
andreas@athlon:~ > date
Tue Dec 18 08:12:31 CET 2001
andreas@athlon:~ > date
Tue Dec 18 08:12:32 CET 2001
andreas@athlon:~ > date
Tue Dec 18 08:12:32 CET 2001
andreas@athlon:~ > date
Tue Dec 18 08:12:32 CET 2001
andreas@athlon:~ > date
Tue Dec 18 08:12:33 CET 2001
andreas@athlon:~ > date
Tue Dec 18 08:12:33 CET 2001
andreas@athlon:~ > date
Tue Dec 18 08:12:33 CET 2001
andreas@athlon:~ > date
Tue Dec 18 08:12:33 CET 2001
andreas@athlon:~ > date
Tue Dec 18 08:12:34 CET 2001
andreas@athlon:~ > date
Tue Dec 18 08:12:34 CET 2001
andreas@athlon:~ > date
Tue Dec 18 08:12:34 CET 2001
andreas@athlon:~ > date
Tue Dec 18 08:12:35 CET 2001
andreas@athlon:~ > date
Tue Dec 18 08:12:35 CET 2001
andreas@athlon:~ > date
Tue Dec 18 08:12:35 CET 2001
andreas@athlon:~ > date
Tue Dec 18 08:12:35 CET 2001
andreas@athlon:~ > date
Tue Dec 18 08:12:36 CET 2001
andreas@athlon:~ > date
Tue Dec 18 08:12:36 CET 2001
andreas@athlon:~ > date
Tue Dec 18 08:12:36 CET 2001
andreas@athlon:~ > date
Tue Dec 18 09:24:11 CET 2001
^^^^^^^^^^^^^^^^^^^^^^^^^^^^
andreas@athlon:~ > date
Tue Dec 18 08:12:37 CET 2001
andreas@athlon:~ > date
Tue Dec 18 08:12:38 CET 2001
andreas@athlon:~ > date
Tue Dec 18 08:12:38 CET 2001
andreas@athlon:~ > date
Tue Dec 18 08:12:38 CET 2001
andreas@athlon:~ > date
Tue Dec 18 08:12:38 CET 2001
andreas@athlon:~ > date
Tue Dec 18 08:12:39 CET 2001
andreas@athlon:~ > date
Tue Dec 18 08:12:39 CET 2001
andreas@athlon:~ > date
Tue Dec 18 08:12:39 CET 2001
andreas@athlon:~ > date
Tue Dec 18 08:12:40 CET 2001
andreas@athlon:~ > date
Tue Dec 18 08:12:40 CET 2001
andreas@athlon:~ > date
Tue Dec 18 08:12:40 CET 2001
andreas@athlon:~ > date
Tue Dec 18 09:24:15 CET 2001
^^^^^^^^^^^^^^^^^^^^^^^^^^^^
andreas@athlon:~ > date
Tue Dec 18 08:12:41 CET 2001
andreas@athlon:~ > date
Tue Dec 18 08:12:41 CET 2001
andreas@athlon:~ > date
Tue Dec 18 08:12:41 CET 2001
andreas@athlon:~ > date
Tue Dec 18 08:12:42 CET 2001
andreas@athlon:~ > date
Tue Dec 18 08:12:42 CET 2001
andreas@athlon:~ > date
Tue Dec 18 08:12:42 CET 2001


This problem appears not directly after reboot but some time after
reboot. The time when it appears after reboot is different. I can't say
it's after 3 hours or 10 hours. It suddenly appears and doesn't
disappear. I have to reboot the system to get rid of the problem.

One effect of this problem is: The X-server begins to blink (the screen
[not the monitor itself!] is going off and on again).

Do you remember? I wrote the same problem ("blinking screen") some time
ago - now, I probably found the reason.
I couldn't reproduce this problem with none of the ac-patches!



My system:

512 MB RAM
AMD Athlon 800
no overclocking


lspci -v
00:00.0 Host bridge: VIA Technologies, Inc. VT8371 [KX133] (rev 02)
          Flags: bus master, medium devsel, latency 0
          Memory at d6000000 (32-bit, prefetchable) [size=32M]
          Capabilities: [a0] AGP version 2.0

00:01.0 PCI bridge: VIA Technologies, Inc. VT8371 [PCI-PCI Bridge]
(prog-if 00 [Normal decode])
          Flags: bus master, 66Mhz, medium devsel, latency 0
          Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
          I/O behind bridge: 0000c000-0000cfff
          Memory behind bridge: d4000000-d5ffffff
          Prefetchable memory behind bridge: d0000000-d3ffffff
          Capabilities: [80] Power Management version 2

00:07.0 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super] (rev 22)
          Subsystem: VIA Technologies, Inc. VT82C686/A PCI to ISA Bridge
          Flags: bus master, stepping, medium devsel, latency 0

00:07.1 IDE interface: VIA Technologies, Inc. VT82C586 IDE [Apollo] (rev
10) (prog-if 8a [Master SecP PriP])
          Flags: bus master, medium devsel, latency 32
          I/O ports at d000 [size=16]
          Capabilities: [c0] Power Management version 2

00:07.2 USB Controller: VIA Technologies, Inc. VT82C586B USB (rev 10)
(prog-if 00 [UHCI])
          Subsystem: Unknown device 0925:1234
          Flags: bus master, medium devsel, latency 32, IRQ 9
          I/O ports at d400 [size=32]
          Capabilities: [80] Power Management version 2

00:07.4 Host bridge: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI]
(rev 30)
          Flags: medium devsel, IRQ 9
          Capabilities: [68] Power Management version 2

00:07.5 Multimedia audio controller: VIA Technologies, Inc. VT82C686
[Apollo Super AC97/Audio] (rev 20)
          Subsystem: VIA Technologies, Inc.: Unknown device 4511
          Flags: medium devsel, IRQ 7
          I/O ports at dc00 [size=256]
          I/O ports at e000 [size=4]
          I/O ports at e400 [size=4]
          Capabilities: [c0] Power Management version 2

00:08.0 Ethernet controller: Silicon Integrated Systems [SiS] SiS900
10/100 Ethernet (rev 02)
          Subsystem: Silicon Integrated Systems [SiS] SiS900 10/100
Ethernet Adapter
          Flags: bus master, medium devsel, latency 32, IRQ 10
          I/O ports at e800 [size=256]
          Memory at d9000000 (32-bit, non-prefetchable) [size=4K]
          Expansion ROM at <unassigned> [disabled] [size=128K]
          Capabilities: [40] Power Management version 1

00:09.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139
(rev 10)
          Subsystem: Realtek Semiconductor Co., Ltd. RT8139
          Flags: bus master, medium devsel, latency 32, IRQ 11
          I/O ports at ec00 [size=256]
          Memory at d9001000 (32-bit, non-prefetchable) [size=256]
          Expansion ROM at <unassigned> [disabled] [size=64K]

01:00.0 VGA compatible controller: ATI Technologies Inc Rage 128 PF
(prog-if 00 [VGA])
          Subsystem: ATI Technologies Inc: Unknown device 0008
          Flags: bus master, stepping, 66Mhz, medium devsel, latency 32,
IRQ 10
          Memory at d0000000 (32-bit, prefetchable) [size=64M]
          I/O ports at c000 [size=256]
          Memory at d5000000 (32-bit, non-prefetchable) [size=16K]
          Expansion ROM at <unassigned> [disabled] [size=128K]
          Capabilities: [50] AGP version 2.0
          Capabilities: [5c] Power Management version 2


lsmod
Module                  Size  Used by    Not tainted
via82cxxx_audio        18080   0  (autoclean)
r128                   90264   0  (autoclean)
ac97_codec              9696   0  (autoclean) [via82cxxx_audio]
8139too                12896   1  (autoclean)
sis900                 11492   1  (autoclean)
serial                 44064   1  (autoclean)
unix                   14020  91  (autoclean)


grep -v "not set" .config
#
# Automatically generated by make menuconfig: don't edit
#
CONFIG_X86=y
CONFIG_ISA=y
CONFIG_UID16=y

#
# Code maturity level options
#
CONFIG_EXPERIMENTAL=y

#
# Loadable module support
#
CONFIG_MODULES=y
CONFIG_MODVERSIONS=y
CONFIG_KMOD=y

#
# Processor type and features
#
CONFIG_MK7=y
CONFIG_X86_WP_WORKS_OK=y
CONFIG_X86_INVLPG=y
CONFIG_X86_CMPXCHG=y
CONFIG_X86_XADD=y
CONFIG_X86_BSWAP=y
CONFIG_X86_POPAD_OK=y
CONFIG_RWSEM_XCHGADD_ALGORITHM=y
CONFIG_X86_L1_CACHE_SHIFT=6
CONFIG_X86_TSC=y
CONFIG_X86_GOOD_APIC=y
CONFIG_X86_USE_3DNOW=y
CONFIG_X86_PGE=y
CONFIG_X86_USE_PPRO_CHECKSUM=y
CONFIG_NOHIGHMEM=y
CONFIG_MTRR=y
CONFIG_X86_UP_APIC=y
CONFIG_X86_UP_IOAPIC=y
CONFIG_X86_LOCAL_APIC=y
CONFIG_X86_IO_APIC=y

#
# General setup
#
CONFIG_NET=y
CONFIG_PCI=y
CONFIG_PCI_GOANY=y
CONFIG_PCI_BIOS=y
CONFIG_PCI_DIRECT=y
CONFIG_PCI_NAMES=y
CONFIG_SYSVIPC=y
CONFIG_SYSCTL=y
CONFIG_KCORE_ELF=y
CONFIG_BINFMT_ELF=y
CONFIG_PM=y
CONFIG_APM=m
CONFIG_APM_DO_ENABLE=y
CONFIG_APM_DISPLAY_BLANK=y
CONFIG_APM_RTC_IS_GMT=y

#
# Memory Technology Devices (MTD)
#

#
# Parallel port support
#
CONFIG_PARPORT=m
CONFIG_PARPORT_PC=m
CONFIG_PARPORT_PC_CML1=m
CONFIG_PARPORT_PC_FIFO=y
CONFIG_PARPORT_1284=y

#
# Plug and Play configuration
#

#
# Block devices
#
CONFIG_BLK_DEV_FD=m
CONFIG_BLK_DEV_LOOP=m

#
# Multi-device support (RAID and LVM)
#

#
# Networking options
#
CONFIG_PACKET=m
CONFIG_UNIX=m
CONFIG_INET=y
CONFIG_IP_MULTICAST=y

#
# QoS and/or fair queueing
#

#
# Telephony Support
#

#
# ATA/IDE/MFM/RLL support
#
CONFIG_IDE=y

#
# IDE, ATA and ATAPI Block devices
#
CONFIG_BLK_DEV_IDE=y
CONFIG_BLK_DEV_IDEDISK=y
CONFIG_IDEDISK_MULTI_MODE=y
CONFIG_BLK_DEV_IDESCSI=m
CONFIG_BLK_DEV_IDEPCI=y
CONFIG_IDEPCI_SHARE_IRQ=y
CONFIG_BLK_DEV_IDEDMA_PCI=y
CONFIG_BLK_DEV_ADMA=y
CONFIG_IDEDMA_PCI_AUTO=y
CONFIG_BLK_DEV_IDEDMA=y
CONFIG_BLK_DEV_VIA82CXXX=y
CONFIG_IDEDMA_AUTO=y
CONFIG_BLK_DEV_IDE_MODES=y

#
# SCSI support
#
CONFIG_SCSI=m
CONFIG_BLK_DEV_SR=m
CONFIG_SR_EXTRA_DEVS=2
CONFIG_CHR_DEV_SG=m
CONFIG_SCSI_DEBUG_QUEUES=y
CONFIG_SCSI_MULTI_LUN=y
CONFIG_SCSI_CONSTANTS=y

#
# SCSI low-level drivers
#

#
# Fusion MPT device support
#

#
# IEEE 1394 (FireWire) support (EXPERIMENTAL)
#

#
# I2O device support
#

#
# Network device support
#
CONFIG_NETDEVICES=y

#
# ARCnet devices
#
CONFIG_DUMMY=m

#
# Ethernet (10 or 100Mbit)
#
CONFIG_NET_ETHERNET=y
CONFIG_NET_PCI=y
CONFIG_EEPRO100=y
CONFIG_8139TOO=m
CONFIG_SIS900=m

#
# Ethernet (1000 Mbit)
#

#
# Wireless LAN (non-hamradio)
#

#
# Token Ring devices
#

#
# Wan interfaces
#

#
# Amateur Radio support
#

#
# IrDA (infrared) support
#

#
# ISDN subsystem
#

#
# Old CD-ROM drivers (not SCSI, not IDE)
#

#
# Input core support
#

#
# Character devices
#
CONFIG_VT=y
CONFIG_VT_CONSOLE=y
CONFIG_SERIAL=m
CONFIG_UNIX98_PTYS=y
CONFIG_UNIX98_PTY_COUNT=256
CONFIG_PRINTER=m

#
# I2C support
#
CONFIG_I2C=m
CONFIG_I2C_ALGOBIT=m
CONFIG_I2C_PHILIPSPAR=m
CONFIG_I2C_ELV=m
CONFIG_I2C_VELLEMAN=m
CONFIG_I2C_ALGOPCF=m
CONFIG_I2C_CHARDEV=m

#
# Mice
#

#
# Joysticks
#

#
# Watchdog Cards
#

#
# Ftape, the floppy tape device driver
#
CONFIG_AGP=m
CONFIG_AGP_VIA=y
CONFIG_DRM=y
CONFIG_DRM_R128=m

#
# Multimedia devices
#

#
# File systems
#
CONFIG_REISERFS_FS=y
CONFIG_FAT_FS=m
CONFIG_MSDOS_FS=m
CONFIG_UMSDOS_FS=m
CONFIG_VFAT_FS=m
CONFIG_TMPFS=y
CONFIG_ISO9660_FS=m
CONFIG_JOLIET=y
CONFIG_PROC_FS=y
CONFIG_DEVPTS_FS=y
CONFIG_EXT2_FS=m
CONFIG_UDF_FS=m
CONFIG_UDF_RW=y

#
# Network File Systems
#
CONFIG_NFS_FS=m
CONFIG_NFS_V3=y
CONFIG_SUNRPC=m
CONFIG_LOCKD=m
CONFIG_LOCKD_V4=y
CONFIG_SMB_FS=m

#
# Partition Types
#
CONFIG_MSDOS_PARTITION=y
CONFIG_SMB_NLS=y
CONFIG_NLS=y

#
# Native Language Support
#
CONFIG_NLS_DEFAULT="iso8859-1"
CONFIG_NLS_CODEPAGE_437=m
CONFIG_NLS_CODEPAGE_737=m
CONFIG_NLS_CODEPAGE_775=m
CONFIG_NLS_CODEPAGE_850=m
CONFIG_NLS_CODEPAGE_852=m
CONFIG_NLS_CODEPAGE_855=m
CONFIG_NLS_CODEPAGE_857=m
CONFIG_NLS_CODEPAGE_860=m
CONFIG_NLS_CODEPAGE_861=m
CONFIG_NLS_CODEPAGE_865=m
CONFIG_NLS_CODEPAGE_869=m
CONFIG_NLS_ISO8859_1=m
CONFIG_NLS_ISO8859_2=m
CONFIG_NLS_ISO8859_3=m
CONFIG_NLS_ISO8859_4=m
CONFIG_NLS_ISO8859_15=m

#
# Console drivers
#
CONFIG_VGA_CONSOLE=y
CONFIG_VIDEO_SELECT=y

#
# Frame-buffer support
#

#
# Sound
#
CONFIG_SOUND=y
CONFIG_SOUND_VIA82CXXX=m

#
# USB support
#

#
# USB Serial Converter support
#

#
# Bluetooth support
#

#
# Kernel hacking
#


ver_linux
Linux athlon 2.4.17-rc1 #2 Sam Dez 15 13:37:12 CET 2001 i686 unknown

Gnu C                  2.95.3
Gnu make               3.76.1
util-linux             2.11l
mount                  2.11l
modutils               2.4.12
e2fsprogs              1.19
reiserfsprogs          3.x.0j
PPP                    2.4.0b1
Linux C Library        2.2.4
Dynamic linker (ldd)   2.2.4
Procps                 2.0.2
Net-tools              1.56
Kbd                    0.96
Sh-utils               2.0g
Modules Loaded         via82cxxx_audio r128 ac97_codec 8139too sis900
serial unix


Regards,
Andreas Hartmann


