Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131796AbRCXUHi>; Sat, 24 Mar 2001 15:07:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131798AbRCXUHb>; Sat, 24 Mar 2001 15:07:31 -0500
Received: from toscano.org ([64.50.191.142]:44004 "HELO bubba.toscano.org")
	by vger.kernel.org with SMTP id <S131796AbRCXUHL>;
	Sat, 24 Mar 2001 15:07:11 -0500
Date: Sat, 24 Mar 2001 15:06:23 -0500
From: Pete Toscano <pete.lkml@toscano.org>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Constant Crash in scsi_eh_0
Message-ID: <20010324150623.A27902@bubba.toscano.org>
Mail-Followup-To: Pete Toscano <pete.lkml@toscano.org>,
	linux-kernel <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="XOIedfhf+7KOe/yw"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
X-Unexpected: The Spanish Inquisition
X-Uptime: 2:43pm  up 10 min,  2 users,  load average: 0.31, 1.09, 0.68
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--XOIedfhf+7KOe/yw
Content-Type: multipart/mixed; boundary="huq684BweRXVnRxX"
Content-Disposition: inline


--huq684BweRXVnRxX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

I'm currently running 2.4.3-pre4.  (I tried 2.4.3-pre6, but it wouldn't
boot.  I'm about to try -pre7.)  This seemed worse with 2.4.2, but it's
still a problem.

My system's about as stable as Crispin Glover after a week-long meth
binge.  =3D8] =20

I'm running an SMP system (dual P3 600s) with 640M of RAM.  It's using a
Tyan Tiger 133 motherboard (VIA Apollo Pro 133a chipset).  It's got 2
ATA66 IDE drives, an IDE CD-ROM, and a SCSI CD burner (connected to an
Adaptec 2940 adaptor).  I also have a few USB devices: mouse, rio500,
and Sandisk SDDR-31 compact flash reader.  The burner and CF reader use
SCSI.  These are the only two SCSI-related devices on my system (that
I'm aware of, at least).

For every crash that I remember, I have not once been using either the
CF reader or the burner.  The usb-storage and scsi_mod devices were
loaded by the hotplug driver (version 2001_02_28).  None of these were
used.

I do have KDB compiled into the kernel, so I was able to get some
debugging info captured via a serial console.  Unfortunately, I don't
know what would be useful and what's not that useful.  Anyway, I've
attached the log.  If there's other information that'd be good to have,
please let me know and I'll try to get it *sigh* the next time my
machine crashes.  As far as I can tell, something bad happens in
scsi_eh_0 every time.

Also attached is my config file. =20

Please let me know if there's anything I can do to try to fix the
problem.  I'm not adverse to trying experimental patches.

pete

--huq684BweRXVnRxX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=".config"
Content-Transfer-Encoding: quoted-printable

#
# Automatically generated make config: don't edit
#
CONFIG_X86=3Dy
CONFIG_ISA=3Dy
# CONFIG_SBUS is not set
CONFIG_UID16=3Dy

#
# Code maturity level options
#
CONFIG_EXPERIMENTAL=3Dy

#
# Loadable module support
#
CONFIG_MODULES=3Dy
CONFIG_MODVERSIONS=3Dy
CONFIG_KMOD=3Dy

#
# Processor type and features
#
# CONFIG_M386 is not set
# CONFIG_M486 is not set
# CONFIG_M586 is not set
# CONFIG_M586TSC is not set
# CONFIG_M586MMX is not set
# CONFIG_M686 is not set
CONFIG_MPENTIUMIII=3Dy
# CONFIG_MPENTIUM4 is not set
# CONFIG_MK6 is not set
# CONFIG_MK7 is not set
# CONFIG_MCRUSOE is not set
# CONFIG_MWINCHIPC6 is not set
# CONFIG_MWINCHIP2 is not set
# CONFIG_MWINCHIP3D is not set
CONFIG_X86_WP_WORKS_OK=3Dy
CONFIG_X86_INVLPG=3Dy
CONFIG_X86_CMPXCHG=3Dy
CONFIG_X86_BSWAP=3Dy
CONFIG_X86_POPAD_OK=3Dy
CONFIG_X86_L1_CACHE_SHIFT=3D5
CONFIG_X86_TSC=3Dy
CONFIG_X86_GOOD_APIC=3Dy
CONFIG_X86_PGE=3Dy
CONFIG_X86_USE_PPRO_CHECKSUM=3Dy
# CONFIG_TOSHIBA is not set
CONFIG_MICROCODE=3Dm
CONFIG_X86_MSR=3Dm
CONFIG_X86_CPUID=3Dm
CONFIG_NOHIGHMEM=3Dy
# CONFIG_HIGHMEM4G is not set
# CONFIG_HIGHMEM64G is not set
# CONFIG_MATH_EMULATION is not set
CONFIG_MTRR=3Dy
CONFIG_SMP=3Dy
CONFIG_HAVE_DEC_LOCK=3Dy

#
# General setup
#
CONFIG_NET=3Dy
# CONFIG_VISWS is not set
CONFIG_X86_IO_APIC=3Dy
CONFIG_X86_LOCAL_APIC=3Dy
CONFIG_PCI=3Dy
# CONFIG_PCI_GOBIOS is not set
# CONFIG_PCI_GODIRECT is not set
CONFIG_PCI_GOANY=3Dy
CONFIG_PCI_BIOS=3Dy
CONFIG_PCI_DIRECT=3Dy
CONFIG_PCI_NAMES=3Dy
# CONFIG_EISA is not set
# CONFIG_MCA is not set
CONFIG_HOTPLUG=3Dy

#
# PCMCIA/CardBus support
#
# CONFIG_PCMCIA is not set
CONFIG_SYSVIPC=3Dy
CONFIG_BSD_PROCESS_ACCT=3Dy
CONFIG_SYSCTL=3Dy
CONFIG_KCORE_ELF=3Dy
# CONFIG_KCORE_AOUT is not set
CONFIG_BINFMT_AOUT=3Dm
CONFIG_BINFMT_ELF=3Dy
CONFIG_BINFMT_MISC=3Dm
CONFIG_PM=3Dy
# CONFIG_ACPI is not set
CONFIG_APM=3Dm
# CONFIG_APM_IGNORE_USER_SUSPEND is not set
# CONFIG_APM_DO_ENABLE is not set
CONFIG_APM_CPU_IDLE=3Dy
# CONFIG_APM_DISPLAY_BLANK is not set
CONFIG_APM_RTC_IS_GMT=3Dy
# CONFIG_APM_ALLOW_INTS is not set
CONFIG_APM_REAL_MODE_POWER_OFF=3Dy

#
# Memory Technology Devices (MTD)
#
# CONFIG_MTD is not set

#
# Parallel port support
#
CONFIG_PARPORT=3Dm
CONFIG_PARPORT_PC=3Dm
CONFIG_PARPORT_PC_FIFO=3Dy
CONFIG_PARPORT_PC_SUPERIO=3Dy
# CONFIG_PARPORT_AMIGA is not set
# CONFIG_PARPORT_MFC3 is not set
# CONFIG_PARPORT_ATARI is not set
# CONFIG_PARPORT_SUNBPP is not set
# CONFIG_PARPORT_OTHER is not set
CONFIG_PARPORT_1284=3Dy

#
# Plug and Play configuration
#
CONFIG_PNP=3Dm
CONFIG_ISAPNP=3Dm

#
# Block devices
#
CONFIG_BLK_DEV_FD=3Dm
# CONFIG_BLK_DEV_XD is not set
# CONFIG_PARIDE is not set
# CONFIG_BLK_CPQ_DA is not set
# CONFIG_BLK_CPQ_CISS_DA is not set
# CONFIG_BLK_DEV_DAC960 is not set
CONFIG_BLK_DEV_LOOP=3Dm
# CONFIG_BLK_DEV_NBD is not set
CONFIG_BLK_DEV_RAM=3Dm
CONFIG_BLK_DEV_RAM_SIZE=3D4096
# CONFIG_BLK_DEV_INITRD is not set

#
# Multi-device support (RAID and LVM)
#
# CONFIG_MD is not set
# CONFIG_BLK_DEV_MD is not set
# CONFIG_MD_LINEAR is not set
# CONFIG_MD_RAID0 is not set
# CONFIG_MD_RAID1 is not set
# CONFIG_MD_RAID5 is not set
# CONFIG_BLK_DEV_LVM is not set

#
# Networking options
#
CONFIG_PACKET=3Dm
CONFIG_PACKET_MMAP=3Dy
CONFIG_NETLINK=3Dy
CONFIG_RTNETLINK=3Dy
# CONFIG_NETLINK_DEV is not set
CONFIG_NETFILTER=3Dy
# CONFIG_NETFILTER_DEBUG is not set
CONFIG_FILTER=3Dy
CONFIG_UNIX=3Dy
CONFIG_INET=3Dy
CONFIG_IP_MULTICAST=3Dy
# CONFIG_IP_ADVANCED_ROUTER is not set
# CONFIG_IP_PNP is not set
CONFIG_NET_IPIP=3Dm
# CONFIG_NET_IPGRE is not set
# CONFIG_IP_MROUTE is not set
# CONFIG_ARPD is not set
CONFIG_INET_ECN=3Dy
CONFIG_SYN_COOKIES=3Dy

#
#   IP: Netfilter Configuration
#
CONFIG_IP_NF_CONNTRACK=3Dm
CONFIG_IP_NF_FTP=3Dm
CONFIG_IP_NF_QUEUE=3Dm
CONFIG_IP_NF_IPTABLES=3Dm
CONFIG_IP_NF_MATCH_LIMIT=3Dm
CONFIG_IP_NF_MATCH_MAC=3Dm
CONFIG_IP_NF_MATCH_MARK=3Dm
CONFIG_IP_NF_MATCH_MULTIPORT=3Dm
CONFIG_IP_NF_MATCH_TOS=3Dm
CONFIG_IP_NF_MATCH_TCPMSS=3Dm
CONFIG_IP_NF_MATCH_STATE=3Dm
CONFIG_IP_NF_MATCH_UNCLEAN=3Dm
CONFIG_IP_NF_MATCH_OWNER=3Dm
CONFIG_IP_NF_FILTER=3Dm
CONFIG_IP_NF_TARGET_REJECT=3Dm
CONFIG_IP_NF_TARGET_MIRROR=3Dm
# CONFIG_IP_NF_NAT is not set
CONFIG_IP_NF_MANGLE=3Dm
CONFIG_IP_NF_TARGET_TOS=3Dm
CONFIG_IP_NF_TARGET_MARK=3Dm
CONFIG_IP_NF_TARGET_LOG=3Dm
CONFIG_IP_NF_TARGET_TCPMSS=3Dm
CONFIG_IP_NF_COMPAT_IPCHAINS=3Dm
CONFIG_IP_NF_NAT_NEEDED=3Dy
# CONFIG_IP_NF_COMPAT_IPFWADM is not set
CONFIG_IPV6=3Dm
CONFIG_IPV6_EUI64=3Dy
CONFIG_IPV6_NO_PB=3Dy

#
#   IPv6: Netfilter Configuration
#
CONFIG_IP6_NF_IPTABLES=3Dm
CONFIG_IP6_NF_MATCH_LIMIT=3Dm
CONFIG_IP6_NF_MATCH_MARK=3Dm
CONFIG_IP6_NF_FILTER=3Dm
CONFIG_IP6_NF_MANGLE=3Dm
CONFIG_IP6_NF_TARGET_MARK=3Dm
# CONFIG_KHTTPD is not set
# CONFIG_ATM is not set

#
# =20
#
# CONFIG_IPX is not set
# CONFIG_ATALK is not set
# CONFIG_DECNET is not set
# CONFIG_BRIDGE is not set
# CONFIG_X25 is not set
# CONFIG_LAPB is not set
# CONFIG_LLC is not set
# CONFIG_NET_DIVERT is not set
# CONFIG_ECONET is not set
# CONFIG_WAN_ROUTER is not set
# CONFIG_NET_FASTROUTE is not set
# CONFIG_NET_HW_FLOWCONTROL is not set

#
# QoS and/or fair queueing
#
# CONFIG_NET_SCHED is not set

#
# Telephony Support
#
# CONFIG_PHONE is not set
# CONFIG_PHONE_IXJ is not set

#
# ATA/IDE/MFM/RLL support
#
CONFIG_IDE=3Dy

#
# IDE, ATA and ATAPI Block devices
#
CONFIG_BLK_DEV_IDE=3Dy

#
# Please see Documentation/ide.txt for help/info on IDE drives
#
# CONFIG_BLK_DEV_HD_IDE is not set
# CONFIG_BLK_DEV_HD is not set
CONFIG_BLK_DEV_IDEDISK=3Dy
# CONFIG_IDEDISK_MULTI_MODE is not set
# CONFIG_BLK_DEV_IDEDISK_VENDOR is not set
# CONFIG_BLK_DEV_IDEDISK_FUJITSU is not set
# CONFIG_BLK_DEV_IDEDISK_IBM is not set
# CONFIG_BLK_DEV_IDEDISK_MAXTOR is not set
# CONFIG_BLK_DEV_IDEDISK_QUANTUM is not set
# CONFIG_BLK_DEV_IDEDISK_SEAGATE is not set
# CONFIG_BLK_DEV_IDEDISK_WD is not set
# CONFIG_BLK_DEV_COMMERIAL is not set
# CONFIG_BLK_DEV_TIVO is not set
# CONFIG_BLK_DEV_IDECS is not set
CONFIG_BLK_DEV_IDECD=3Dm
# CONFIG_BLK_DEV_IDETAPE is not set
# CONFIG_BLK_DEV_IDEFLOPPY is not set
# CONFIG_BLK_DEV_IDESCSI is not set

#
# IDE chipset support/bugfixes
#
# CONFIG_BLK_DEV_CMD640 is not set
# CONFIG_BLK_DEV_CMD640_ENHANCED is not set
# CONFIG_BLK_DEV_ISAPNP is not set
# CONFIG_BLK_DEV_RZ1000 is not set
CONFIG_BLK_DEV_IDEPCI=3Dy
CONFIG_IDEPCI_SHARE_IRQ=3Dy
CONFIG_BLK_DEV_IDEDMA_PCI=3Dy
CONFIG_BLK_DEV_OFFBOARD=3Dy
CONFIG_IDEDMA_PCI_AUTO=3Dy
CONFIG_BLK_DEV_IDEDMA=3Dy
# CONFIG_IDEDMA_PCI_WIP is not set
# CONFIG_IDEDMA_NEW_DRIVE_LISTINGS is not set
# CONFIG_BLK_DEV_AEC62XX is not set
# CONFIG_AEC62XX_TUNING is not set
# CONFIG_BLK_DEV_ALI15X3 is not set
# CONFIG_WDC_ALI15X3 is not set
# CONFIG_BLK_DEV_AMD7409 is not set
# CONFIG_AMD7409_OVERRIDE is not set
# CONFIG_BLK_DEV_CMD64X is not set
# CONFIG_BLK_DEV_CY82C693 is not set
# CONFIG_BLK_DEV_CS5530 is not set
# CONFIG_BLK_DEV_HPT34X is not set
# CONFIG_HPT34X_AUTODMA is not set
# CONFIG_BLK_DEV_HPT366 is not set
# CONFIG_BLK_DEV_PIIX is not set
# CONFIG_PIIX_TUNING is not set
# CONFIG_BLK_DEV_NS87415 is not set
# CONFIG_BLK_DEV_OPTI621 is not set
CONFIG_BLK_DEV_PDC202XX=3Dy
CONFIG_PDC202XX_BURST=3Dy
# CONFIG_BLK_DEV_OSB4 is not set
# CONFIG_BLK_DEV_SIS5513 is not set
# CONFIG_BLK_DEV_SLC90E66 is not set
# CONFIG_BLK_DEV_TRM290 is not set
CONFIG_BLK_DEV_VIA82CXXX=3Dy
# CONFIG_IDE_CHIPSETS is not set
CONFIG_IDEDMA_AUTO=3Dy
CONFIG_IDEDMA_IVB=3Dy
# CONFIG_DMA_NONPCI is not set
CONFIG_BLK_DEV_IDE_MODES=3Dy

#
# SCSI support
#
CONFIG_SCSI=3Dm

#
# SCSI support type (disk, tape, CD-ROM)
#
CONFIG_BLK_DEV_SD=3Dm
CONFIG_SD_EXTRA_DEVS=3D40
# CONFIG_CHR_DEV_ST is not set
# CONFIG_CHR_DEV_OSST is not set
CONFIG_BLK_DEV_SR=3Dm
CONFIG_BLK_DEV_SR_VENDOR=3Dy
CONFIG_SR_EXTRA_DEVS=3D2
CONFIG_CHR_DEV_SG=3Dm

#
# Some SCSI devices (e.g. CD jukebox) support multiple LUNs
#
CONFIG_SCSI_DEBUG_QUEUES=3Dy
CONFIG_SCSI_MULTI_LUN=3Dy
CONFIG_SCSI_CONSTANTS=3Dy
# CONFIG_SCSI_LOGGING is not set

#
# SCSI low-level drivers
#
# CONFIG_BLK_DEV_3W_XXXX_RAID is not set
# CONFIG_SCSI_7000FASST is not set
# CONFIG_SCSI_ACARD is not set
# CONFIG_SCSI_AHA152X is not set
# CONFIG_SCSI_AHA1542 is not set
# CONFIG_SCSI_AHA1740 is not set
CONFIG_SCSI_AIC7XXX=3Dm
CONFIG_AIC7XXX_CMDS_PER_DEVICE=3D8
CONFIG_AIC7XXX_RESET_DELAY=3D5
# CONFIG_SCSI_AIC7XXX_OLD is not set
# CONFIG_SCSI_ADVANSYS is not set
# CONFIG_SCSI_IN2000 is not set
# CONFIG_SCSI_AM53C974 is not set
# CONFIG_SCSI_MEGARAID is not set
# CONFIG_SCSI_BUSLOGIC is not set
# CONFIG_SCSI_CPQFCTS is not set
# CONFIG_SCSI_DMX3191D is not set
# CONFIG_SCSI_DTC3280 is not set
# CONFIG_SCSI_EATA is not set
# CONFIG_SCSI_EATA_DMA is not set
# CONFIG_SCSI_EATA_PIO is not set
# CONFIG_SCSI_FUTURE_DOMAIN is not set
# CONFIG_SCSI_GDTH is not set
# CONFIG_SCSI_GENERIC_NCR5380 is not set
# CONFIG_SCSI_IPS is not set
# CONFIG_SCSI_INITIO is not set
# CONFIG_SCSI_INIA100 is not set
# CONFIG_SCSI_PPA is not set
# CONFIG_SCSI_IMM is not set
# CONFIG_SCSI_NCR53C406A is not set
# CONFIG_SCSI_NCR53C7xx is not set
# CONFIG_SCSI_NCR53C8XX is not set
# CONFIG_SCSI_SYM53C8XX is not set
# CONFIG_SCSI_PAS16 is not set
# CONFIG_SCSI_PCI2000 is not set
# CONFIG_SCSI_PCI2220I is not set
# CONFIG_SCSI_PSI240I is not set
# CONFIG_SCSI_QLOGIC_FAS is not set
# CONFIG_SCSI_QLOGIC_ISP is not set
# CONFIG_SCSI_QLOGIC_FC is not set
# CONFIG_SCSI_QLOGIC_1280 is not set
# CONFIG_SCSI_SEAGATE is not set
# CONFIG_SCSI_SIM710 is not set
# CONFIG_SCSI_SYM53C416 is not set
# CONFIG_SCSI_DC390T is not set
# CONFIG_SCSI_T128 is not set
# CONFIG_SCSI_U14_34F is not set
# CONFIG_SCSI_ULTRASTOR is not set
# CONFIG_SCSI_DEBUG is not set

#
# IEEE 1394 (FireWire) support
#
CONFIG_IEEE1394=3Dm
# CONFIG_IEEE1394_PCILYNX is not set
CONFIG_IEEE1394_OHCI1394=3Dm
CONFIG_IEEE1394_VIDEO1394=3Dm
CONFIG_IEEE1394_RAWIO=3Dm
# CONFIG_IEEE1394_VERBOSEDEBUG is not set

#
# I2O device support
#
# CONFIG_I2O is not set
# CONFIG_I2O_PCI is not set
# CONFIG_I2O_BLOCK is not set
# CONFIG_I2O_LAN is not set
# CONFIG_I2O_SCSI is not set
# CONFIG_I2O_PROC is not set

#
# Network device support
#
CONFIG_NETDEVICES=3Dy

#
# ARCnet devices
#
# CONFIG_ARCNET is not set
CONFIG_DUMMY=3Dm
# CONFIG_BONDING is not set
# CONFIG_EQUALIZER is not set
# CONFIG_TUN is not set
# CONFIG_ETHERTAP is not set
# CONFIG_NET_SB1000 is not set

#
# Ethernet (10 or 100Mbit)
#
CONFIG_NET_ETHERNET=3Dy
# CONFIG_NET_VENDOR_3COM is not set
# CONFIG_LANCE is not set
# CONFIG_NET_VENDOR_SMC is not set
# CONFIG_NET_VENDOR_RACAL is not set
# CONFIG_AT1700 is not set
# CONFIG_DEPCA is not set
# CONFIG_HP100 is not set
# CONFIG_NET_ISA is not set
CONFIG_NET_PCI=3Dy
# CONFIG_PCNET32 is not set
# CONFIG_ADAPTEC_STARFIRE is not set
# CONFIG_AC3200 is not set
# CONFIG_APRICOT is not set
# CONFIG_CS89x0 is not set
CONFIG_TULIP=3Dm
# CONFIG_DE4X5 is not set
# CONFIG_DGRS is not set
# CONFIG_DM9102 is not set
# CONFIG_EEPRO100 is not set
# CONFIG_EEPRO100_PM is not set
# CONFIG_LNE390 is not set
# CONFIG_NATSEMI is not set
# CONFIG_NE2K_PCI is not set
# CONFIG_NE3210 is not set
# CONFIG_ES3210 is not set
# CONFIG_8139TOO is not set
# CONFIG_SIS900 is not set
# CONFIG_EPIC100 is not set
# CONFIG_SUNDANCE is not set
# CONFIG_TLAN is not set
# CONFIG_VIA_RHINE is not set
# CONFIG_WINBOND_840 is not set
# CONFIG_HAPPYMEAL is not set
# CONFIG_NET_POCKET is not set

#
# Ethernet (1000 Mbit)
#
# CONFIG_ACENIC is not set
# CONFIG_HAMACHI is not set
# CONFIG_YELLOWFIN is not set
# CONFIG_SK98LIN is not set
# CONFIG_FDDI is not set
# CONFIG_HIPPI is not set
# CONFIG_PLIP is not set
CONFIG_PPP=3Dm
CONFIG_PPP_MULTILINK=3Dy
CONFIG_PPP_ASYNC=3Dm
CONFIG_PPP_SYNC_TTY=3Dm
CONFIG_PPP_DEFLATE=3Dm
CONFIG_PPP_BSDCOMP=3Dm
CONFIG_PPPOE=3Dm
# CONFIG_SLIP is not set

#
# Wireless LAN (non-hamradio)
#
# CONFIG_NET_RADIO is not set

#
# Token Ring devices
#
# CONFIG_TR is not set
# CONFIG_NET_FC is not set
# CONFIG_RCPCI is not set
# CONFIG_SHAPER is not set

#
# Wan interfaces
#
# CONFIG_WAN is not set

#
# Amateur Radio support
#
# CONFIG_HAMRADIO is not set

#
# IrDA (infrared) support
#
# CONFIG_IRDA is not set

#
# ISDN subsystem
#
# CONFIG_ISDN is not set

#
# Old CD-ROM drivers (not SCSI, not IDE)
#
# CONFIG_CD_NO_IDESCSI is not set

#
# Input core support
#
CONFIG_INPUT=3Dm
CONFIG_INPUT_KEYBDEV=3Dm
CONFIG_INPUT_MOUSEDEV=3Dm
CONFIG_INPUT_MOUSEDEV_SCREEN_X=3D1600
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=3D1200
# CONFIG_INPUT_JOYDEV is not set
CONFIG_INPUT_EVDEV=3Dm

#
# Character devices
#
CONFIG_VT=3Dy
CONFIG_VT_CONSOLE=3Dy
CONFIG_SERIAL=3Dy
CONFIG_SERIAL_CONSOLE=3Dy
# CONFIG_SERIAL_EXTENDED is not set
# CONFIG_SERIAL_NONSTANDARD is not set
CONFIG_UNIX98_PTYS=3Dy
CONFIG_UNIX98_PTY_COUNT=3D256
CONFIG_PRINTER=3Dm
CONFIG_LP_CONSOLE=3Dy
# CONFIG_PPDEV is not set

#
# I2C support
#
CONFIG_I2C=3Dm
CONFIG_I2C_ALGOBIT=3Dm
CONFIG_I2C_PHILIPSPAR=3Dm
CONFIG_I2C_ELV=3Dm
CONFIG_I2C_VELLEMAN=3Dm
CONFIG_I2C_ALGOPCF=3Dm
# CONFIG_I2C_ELEKTOR is not set
CONFIG_I2C_CHARDEV=3Dm

#
# Mice
#
# CONFIG_BUSMOUSE is not set
CONFIG_MOUSE=3Dm
CONFIG_PSMOUSE=3Dy
# CONFIG_82C710_MOUSE is not set
# CONFIG_PC110_PAD is not set

#
# Joysticks
#
# CONFIG_JOYSTICK is not set

#
# Input core support is needed for joysticks
#
# CONFIG_QIC02_TAPE is not set

#
# Watchdog Cards
#
# CONFIG_WATCHDOG is not set
# CONFIG_INTEL_RNG is not set
# CONFIG_NVRAM is not set
CONFIG_RTC=3Dy
# CONFIG_DTLK is not set
# CONFIG_R3964 is not set
# CONFIG_APPLICOM is not set

#
# Ftape, the floppy tape device driver
#
# CONFIG_FTAPE is not set
CONFIG_AGP=3Dm
# CONFIG_AGP_INTEL is not set
# CONFIG_AGP_I810 is not set
CONFIG_AGP_VIA=3Dy
# CONFIG_AGP_AMD is not set
# CONFIG_AGP_SIS is not set
# CONFIG_AGP_ALI is not set
CONFIG_DRM=3Dy
# CONFIG_DRM_TDFX is not set
# CONFIG_DRM_GAMMA is not set
# CONFIG_DRM_R128 is not set
# CONFIG_DRM_RADEON is not set
# CONFIG_DRM_I810 is not set
CONFIG_DRM_MGA=3Dm

#
# Multimedia devices
#
# CONFIG_VIDEO_DEV is not set

#
# File systems
#
# CONFIG_QUOTA is not set
# CONFIG_AUTOFS_FS is not set
CONFIG_AUTOFS4_FS=3Dm
CONFIG_REISERFS_FS=3Dm
# CONFIG_REISERFS_CHECK is not set
# CONFIG_ADFS_FS is not set
# CONFIG_ADFS_FS_RW is not set
# CONFIG_AFFS_FS is not set
# CONFIG_HFS_FS is not set
# CONFIG_BFS_FS is not set
CONFIG_FAT_FS=3Dm
# CONFIG_MSDOS_FS is not set
# CONFIG_UMSDOS_FS is not set
CONFIG_VFAT_FS=3Dm
# CONFIG_EFS_FS is not set
# CONFIG_JFFS_FS is not set
# CONFIG_CRAMFS is not set
# CONFIG_RAMFS is not set
CONFIG_ISO9660_FS=3Dm
CONFIG_JOLIET=3Dy
# CONFIG_MINIX_FS is not set
# CONFIG_NTFS_FS is not set
# CONFIG_NTFS_RW is not set
# CONFIG_HPFS_FS is not set
CONFIG_PROC_FS=3Dy
# CONFIG_DEVFS_FS is not set
# CONFIG_DEVFS_MOUNT is not set
# CONFIG_DEVFS_DEBUG is not set
CONFIG_DEVPTS_FS=3Dy
# CONFIG_QNX4FS_FS is not set
# CONFIG_QNX4FS_RW is not set
# CONFIG_ROMFS_FS is not set
CONFIG_EXT2_FS=3Dy
# CONFIG_SYSV_FS is not set
# CONFIG_SYSV_FS_WRITE is not set
# CONFIG_UDF_FS is not set
# CONFIG_UDF_RW is not set
CONFIG_UFS_FS=3Dm
CONFIG_UFS_FS_WRITE=3Dy

#
# Network File Systems
#
CONFIG_CODA_FS=3Dm
CONFIG_NFS_FS=3Dm
CONFIG_NFS_V3=3Dy
# CONFIG_ROOT_NFS is not set
CONFIG_NFSD=3Dm
CONFIG_NFSD_V3=3Dy
CONFIG_SUNRPC=3Dm
CONFIG_LOCKD=3Dm
CONFIG_LOCKD_V4=3Dy
CONFIG_SMB_FS=3Dm
CONFIG_SMB_NLS_DEFAULT=3Dy
CONFIG_SMB_NLS_REMOTE=3D"iso8859-1"
# CONFIG_NCP_FS is not set
# CONFIG_NCPFS_PACKET_SIGNING is not set
# CONFIG_NCPFS_IOCTL_LOCKING is not set
# CONFIG_NCPFS_STRONG is not set
# CONFIG_NCPFS_NFS_NS is not set
# CONFIG_NCPFS_OS2_NS is not set
# CONFIG_NCPFS_SMALLDOS is not set
# CONFIG_NCPFS_NLS is not set
# CONFIG_NCPFS_EXTRAS is not set

#
# Partition Types
#
CONFIG_PARTITION_ADVANCED=3Dy
# CONFIG_ACORN_PARTITION is not set
# CONFIG_OSF_PARTITION is not set
# CONFIG_AMIGA_PARTITION is not set
# CONFIG_ATARI_PARTITION is not set
# CONFIG_MAC_PARTITION is not set
CONFIG_MSDOS_PARTITION=3Dy
CONFIG_BSD_DISKLABEL=3Dy
# CONFIG_MINIX_SUBPARTITION is not set
CONFIG_SOLARIS_X86_PARTITION=3Dy
# CONFIG_UNIXWARE_DISKLABEL is not set
# CONFIG_SGI_PARTITION is not set
# CONFIG_ULTRIX_PARTITION is not set
# CONFIG_SUN_PARTITION is not set
CONFIG_SMB_NLS=3Dy
CONFIG_NLS=3Dy

#
# Native Language Support
#
CONFIG_NLS_DEFAULT=3D"iso8859-1"
CONFIG_NLS_CODEPAGE_437=3Dm
# CONFIG_NLS_CODEPAGE_737 is not set
# CONFIG_NLS_CODEPAGE_775 is not set
# CONFIG_NLS_CODEPAGE_850 is not set
# CONFIG_NLS_CODEPAGE_852 is not set
# CONFIG_NLS_CODEPAGE_855 is not set
# CONFIG_NLS_CODEPAGE_857 is not set
# CONFIG_NLS_CODEPAGE_860 is not set
# CONFIG_NLS_CODEPAGE_861 is not set
# CONFIG_NLS_CODEPAGE_862 is not set
# CONFIG_NLS_CODEPAGE_863 is not set
# CONFIG_NLS_CODEPAGE_864 is not set
# CONFIG_NLS_CODEPAGE_865 is not set
# CONFIG_NLS_CODEPAGE_866 is not set
# CONFIG_NLS_CODEPAGE_869 is not set
# CONFIG_NLS_CODEPAGE_874 is not set
# CONFIG_NLS_CODEPAGE_932 is not set
# CONFIG_NLS_CODEPAGE_936 is not set
# CONFIG_NLS_CODEPAGE_949 is not set
# CONFIG_NLS_CODEPAGE_950 is not set
CONFIG_NLS_ISO8859_1=3Dm
# CONFIG_NLS_ISO8859_2 is not set
# CONFIG_NLS_ISO8859_3 is not set
# CONFIG_NLS_ISO8859_4 is not set
# CONFIG_NLS_ISO8859_5 is not set
# CONFIG_NLS_ISO8859_6 is not set
# CONFIG_NLS_ISO8859_7 is not set
# CONFIG_NLS_ISO8859_8 is not set
# CONFIG_NLS_ISO8859_9 is not set
# CONFIG_NLS_ISO8859_14 is not set
CONFIG_NLS_ISO8859_15=3Dm
# CONFIG_NLS_KOI8_R is not set
# CONFIG_NLS_UTF8 is not set

#
# Console drivers
#
CONFIG_VGA_CONSOLE=3Dy
CONFIG_VIDEO_SELECT=3Dy
# CONFIG_MDA_CONSOLE is not set

#
# Frame-buffer support
#
CONFIG_FB=3Dy
CONFIG_DUMMY_CONSOLE=3Dy
# CONFIG_FB_RIVA is not set
# CONFIG_FB_CLGEN is not set
# CONFIG_FB_PM2 is not set
# CONFIG_FB_CYBER2000 is not set
# CONFIG_FB_VESA is not set
# CONFIG_FB_VGA16 is not set
# CONFIG_FB_HGA is not set
CONFIG_VIDEO_SELECT=3Dy
CONFIG_FB_MATROX=3Dm
# CONFIG_FB_MATROX_MILLENIUM is not set
# CONFIG_FB_MATROX_MYSTIQUE is not set
CONFIG_FB_MATROX_G100=3Dy
CONFIG_FB_MATROX_I2C=3Dm
# CONFIG_FB_MATROX_MAVEN is not set
# CONFIG_FB_MATROX_G450 is not set
# CONFIG_FB_MATROX_MULTIHEAD is not set
# CONFIG_FB_ATY is not set
# CONFIG_FB_ATY128 is not set
# CONFIG_FB_3DFX is not set
# CONFIG_FB_SIS is not set
# CONFIG_FB_VIRTUAL is not set
CONFIG_FBCON_ADVANCED=3Dy
# CONFIG_FBCON_MFB is not set
# CONFIG_FBCON_CFB2 is not set
# CONFIG_FBCON_CFB4 is not set
CONFIG_FBCON_CFB8=3Dm
CONFIG_FBCON_CFB16=3Dm
CONFIG_FBCON_CFB24=3Dm
CONFIG_FBCON_CFB32=3Dm
# CONFIG_FBCON_AFB is not set
# CONFIG_FBCON_ILBM is not set
# CONFIG_FBCON_IPLAN2P2 is not set
# CONFIG_FBCON_IPLAN2P4 is not set
# CONFIG_FBCON_IPLAN2P8 is not set
# CONFIG_FBCON_MAC is not set
# CONFIG_FBCON_VGA_PLANES is not set
# CONFIG_FBCON_VGA is not set
# CONFIG_FBCON_HGA is not set
# CONFIG_FBCON_FONTWIDTH8_ONLY is not set
# CONFIG_FBCON_FONTS is not set
CONFIG_FONT_8x8=3Dy
CONFIG_FONT_8x16=3Dy

#
# Sound
#
CONFIG_SOUND=3Dm
# CONFIG_SOUND_CMPCI is not set
CONFIG_SOUND_EMU10K1=3Dm
# CONFIG_SOUND_FUSION is not set
# CONFIG_SOUND_CS4281 is not set
# CONFIG_SOUND_ES1370 is not set
# CONFIG_SOUND_ES1371 is not set
# CONFIG_SOUND_ESSSOLO1 is not set
# CONFIG_SOUND_MAESTRO is not set
# CONFIG_SOUND_MAESTRO3 is not set
# CONFIG_SOUND_ICH is not set
# CONFIG_SOUND_SONICVIBES is not set
# CONFIG_SOUND_TRIDENT is not set
# CONFIG_SOUND_MSNDCLAS is not set
# CONFIG_SOUND_MSNDPIN is not set
# CONFIG_SOUND_VIA82CXXX is not set
# CONFIG_SOUND_OSS is not set
# CONFIG_SOUND_TVMIXER is not set

#
# USB support
#
CONFIG_USB=3Dm
CONFIG_USB_DEBUG=3Dy

#
# Miscellaneous USB options
#
CONFIG_USB_DEVICEFS=3Dy
# CONFIG_USB_BANDWIDTH is not set

#
# USB Controllers
#
CONFIG_USB_UHCI=3Dm
# CONFIG_USB_UHCI_ALT is not set
# CONFIG_USB_OHCI is not set

#
# USB Device Class drivers
#
# CONFIG_USB_AUDIO is not set
# CONFIG_USB_BLUETOOTH is not set
CONFIG_USB_STORAGE=3Dm
# CONFIG_USB_STORAGE_DEBUG is not set
# CONFIG_USB_STORAGE_FREECOM is not set
# CONFIG_USB_ACM is not set
CONFIG_USB_PRINTER=3Dm

#
# USB Human Interface Devices (HID)
#
CONFIG_USB_HID=3Dm
# CONFIG_USB_KBD is not set
# CONFIG_USB_MOUSE is not set
# CONFIG_USB_WACOM is not set

#
# USB Imaging devices
#
# CONFIG_USB_DC2XX is not set
# CONFIG_USB_MDC800 is not set
# CONFIG_USB_SCANNER is not set
# CONFIG_USB_MICROTEK is not set

#
# USB Multimedia devices
#
# CONFIG_USB_IBMCAM is not set
# CONFIG_USB_OV511 is not set
# CONFIG_USB_DSBR is not set
# CONFIG_USB_DABUSB is not set

#
# USB Network adaptors
#
# CONFIG_USB_PLUSB is not set
# CONFIG_USB_PEGASUS is not set
# CONFIG_USB_NET1080 is not set

#
# USB port drivers
#
# CONFIG_USB_USS720 is not set

#
# USB Serial Converter support
#
# CONFIG_USB_SERIAL is not set

#
# USB misc drivers
#
CONFIG_USB_RIO500=3Dm

#
# Kernel hacking
#
CONFIG_MAGIC_SYSRQ=3Dy
CONFIG_KDB=3Dy
# CONFIG_KDB_OFF is not set

#
# Load all symbols for debugging is required for KDB
#
CONFIG_KALLSYMS=3Dy
CONFIG_FRAME_POINTER=3Dy

--huq684BweRXVnRxX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=oops12
Content-Transfer-Encoding: quoted-printable

ps
Task Addr  Pid      Parent   [*] cpu  State Thread     Command
0xe7fe4000 00000001 00000000  0  000  stop  0xe7fe4350 init
0xc1ab6000 00000002 00000001  0  001  stop  0xc1ab6350 keventd
0xe7fd8000 00000003 00000001  0  001  stop  0xe7fd8350 kswapd
0xe7fd6000 00000004 00000001  0  001  stop  0xe7fd6350 kreclaimd
0xe7fd2000 00000005 00000001  0  001  stop  0xe7fd2350 bdflush
0xe7fd0000 00000006 00000001  0  000  stop  0xe7fd0350 kupdated
0xe7752000 00000096 00000001  0  001  stop  0xe7752350 khubd
0xe5f94000 00000297 00000001  0  001  stop  0xe5f94350 kreiserfsd
0xe2bdc000 00000861 00000001  0  001  stop  0xe2bdc350 usb-storage-0
0xe2bda000 00000862 00000001  0  001  stop  0xe2bda350 scsi_eh_0
0xe2a52000 00001053 00000001  0  001  stop  0xe2a52350 syslogd
0xe29c0000 00001063 00000001  0  000  run   0xe29c0350 klogd
0xe2906000 00001078 00000001  0  001  stop  0xe2906350 portmap
0xe2816000 00001109 00000001  0  000  stop  0xe2816350 automount
0xe28a6000 00001111 00000001  0  001  stop  0xe28a6350 automount
0xe27d6000 00001172 00000001  0  000  stop  0xe27d6350 atd
0xe2764000 00001187 00000001  0  000  stop  0xe2764350 xinetd
0xe26f0000 00001202 00000001  0  001  stop  0xe26f0350 ntpd
0xe2532000 00001212 00000001  0  000  stop  0xe2532350 sshd
0xe262c000 00001253 00000001  0  000  stop  0xe262c350 gpm
0xe26a6000 00001268 00000001  0  000  stop  0xe26a6350 crond
[0]more> q
[0]kdb> btp 862
    EBP       EIP         Function(args)
0xe2bdbf6c 0xc011526a schedule+0x41e (0xe2ce0960, 0xe2bda000)
                               kernel .text 0xc0100000 0xc0114e4c 0xc0115480
0xe2bdbf9c 0xc0107bb8 __down_interruptible+0x94
                               kernel .text 0xc0100000 0xc0107b24 0xc0107c24
0xe2bdbfac 0xc0107c96 __down_failed_interruptible+0xa (0x100, 0xe2c9dd14, 0=
xe2c9dd6c, 0xe2bdbfd8, 0x0)
                               kernel .text 0xc0100000 0xc0107c8c 0xc0107c9c
           0xeaf94d7f [scsi_mod].text.lock+0x1fb
                               scsi_mod .text.lock 0xeaf94b84 0xeaf94b84 0x=
eaf94ea8
0xe2bdbfec 0xeaf90281 [scsi_mod]scsi_error_handler+0x101
                               scsi_mod .text 0xeaf8b060 0xeaf90180 0xeaf90=
2f0
           0xc0107547 kernel_thread+0x23
                               kernel .text 0xc0100000 0xc0107524 0xc010755c
[0]kdb> id 0xeaf94d57
0xeaf94d57 .text.lock+0x1d3repz nop=20
0xeaf94d59 .text.lock+0x1d5jle    0xeaf94d50 .text.lock+0x1cc
0xeaf94d5b .text.lock+0x1d7jmp    0xeaf8f9ca scsi_restart_operations+0x1e
0xeaf94d60 .text.lock+0x1dccmpb   $0x0,0xc027fd20
0xeaf94d67 .text.lock+0x1e3repz nop=20
0xeaf94d69 .text.lock+0x1e5jle    0xeaf94d60 .text.lock+0x1dc
0xeaf94d6b .text.lock+0x1e7jmp    0xeaf901ff scsi_error_handler+0x7f
0xeaf94d70 .text.lock+0x1eccall   0xc0107cac __up_wakeup
0xeaf94d75 .text.lock+0x1f1jmp    0xeaf90272 scsi_error_handler+0xf2
0xeaf94d7a .text.lock+0x1f6call   0xc0107c8c __down_failed_interruptible
0xeaf94d7f .text.lock+0x1fbjmp    0xeaf90281 scsi_error_handler+0x101
0xeaf94d84 .text.lock+0x200call   0xc0107cac __up_wakeup
0xeaf94d89 .text.lock+0x205jmp    0xeaf902e0 scsi_error_handler+0x160
0xeaf94d8e .text.lock+0x20acmpb   $0x0,0xc0285160
0xeaf94d95 .text.lock+0x211repz nop=20
0xeaf94d97 .text.lock+0x213jle    0xeaf94d8e .text.lock+0x20a
[0]kdb>=20
--huq684BweRXVnRxX--

--XOIedfhf+7KOe/yw
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.4 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE6vP4/sMikd2rK89sRAvq0AJ4sYuBwIDAZR77KZ9N6Vcmd+RskGACcCkp8
af8Xfwl205RjyHZ5BDbt3a8=
=3sBT
-----END PGP SIGNATURE-----

--XOIedfhf+7KOe/yw--
