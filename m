Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264933AbUBDXk6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Feb 2004 18:40:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264383AbUBDXk6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Feb 2004 18:40:58 -0500
Received: from ozone.tzone.org ([66.199.153.154]:9860 "EHLO OZoNE.TZoNE.ORG")
	by vger.kernel.org with ESMTP id S264933AbUBDX3s (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Feb 2004 18:29:48 -0500
From: Francis Provencher <darkfox@TZoNE.ORG>
Date: Wed, 4 Feb 2004 18:29:39 -0500
To: Jeremy Andrews <jandrews@kerneltrap.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Oops with 2.6.2-rc3
Message-ID: <20040204232939.GA26395@OZoNE.TZoNE.ORG>
References: <20040202201411.GA19268@home.kerneltrap.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="0F1p//8PRICkK4MW"
Content-Disposition: inline
In-Reply-To: <20040202201411.GA19268@home.kerneltrap.org>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--0F1p//8PRICkK4MW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Feb 02, 2004 at 03:14:11PM -0500, Jeremy Andrews wrote:
>   The computer seems to crash once or twice a day -- always a hard freeze requiring that I press the reset button to reboot.  I have not found a pattern -- during this crash I had the Gnome desktop up and I was balancing my checkbook with GnuCash.

Hum, I'm having a similar problem. My computer will hard freeze after some time (between 3 hours and 24 hours, with a curve closer to 3 hours). I had the same behavior with 2.6.0, 2.6.1, 2.6.2-rc(1,2,3), 2.6.2.

I don't have any message in the logs that could point to something. 

This is my main workstation and It's been rock stable with the 2.4 kernel serie... Someone proposed to remove the Preempt option. I'll try that.

Note: When my station would freeze, often my sound card would start emiting a stable (and annoying) sound. Thinking that maybe the problem could be related to alsa, I patched my kernel with the latest 1.0.2 patch from Jaroslav Kysela <perex@suse.cz> (ftp://ftp.alsa-project.org/pub/kernel-patches/alsa-bk-2004-01-27.patch.gz)

Attached are my .config and my lspci and dmesgs are attached. Tell me if you need something else.

Thx.

-Francis
-- 
Francis Provencher <darkfox@TZoNE.ORG>
"What if the bird will not sing?"

--0F1p//8PRICkK4MW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="config-2.6.2"

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
CONFIG_EXPERIMENTAL=y
CONFIG_CLEAN_COMPILE=y
CONFIG_STANDALONE=y
CONFIG_BROKEN_ON_SMP=y

#
# General setup
#
CONFIG_SWAP=y
CONFIG_SYSVIPC=y
# CONFIG_BSD_PROCESS_ACCT is not set
CONFIG_SYSCTL=y
CONFIG_LOG_BUF_SHIFT=14
CONFIG_IKCONFIG=y
CONFIG_IKCONFIG_PROC=y
# CONFIG_EMBEDDED is not set
CONFIG_KALLSYMS=y
CONFIG_FUTEX=y
CONFIG_EPOLL=y
CONFIG_IOSCHED_NOOP=y
CONFIG_IOSCHED_AS=y
CONFIG_IOSCHED_DEADLINE=y
# CONFIG_CC_OPTIMIZE_FOR_SIZE is not set

#
# Loadable module support
#
CONFIG_MODULES=y
CONFIG_MODULE_UNLOAD=y
CONFIG_MODULE_FORCE_UNLOAD=y
CONFIG_OBSOLETE_MODPARM=y
CONFIG_MODVERSIONS=y
CONFIG_KMOD=y

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
# CONFIG_X86_ES7000 is not set
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
CONFIG_HPET_TIMER=y
CONFIG_HPET_EMULATE_RTC=y
# CONFIG_SMP is not set
CONFIG_PREEMPT=y
CONFIG_X86_UP_APIC=y
CONFIG_X86_UP_IOAPIC=y
CONFIG_X86_LOCAL_APIC=y
CONFIG_X86_IO_APIC=y
CONFIG_X86_TSC=y
CONFIG_X86_MCE=y
# CONFIG_X86_MCE_NONFATAL is not set
CONFIG_X86_MCE_P4THERMAL=y
# CONFIG_TOSHIBA is not set
# CONFIG_I8K is not set
# CONFIG_MICROCODE is not set
# CONFIG_X86_MSR is not set
# CONFIG_X86_CPUID is not set
# CONFIG_EDD is not set
CONFIG_NOHIGHMEM=y
# CONFIG_HIGHMEM4G is not set
# CONFIG_HIGHMEM64G is not set
# CONFIG_MATH_EMULATION is not set
CONFIG_MTRR=y
# CONFIG_EFI is not set
CONFIG_HAVE_DEC_LOCK=y

#
# Power management options (ACPI, APM)
#
CONFIG_PM=y
# CONFIG_SOFTWARE_SUSPEND is not set
# CONFIG_PM_DISK is not set

#
# ACPI (Advanced Configuration and Power Interface) Support
#
CONFIG_ACPI=y
CONFIG_ACPI_BOOT=y
CONFIG_ACPI_INTERPRETER=y
CONFIG_ACPI_SLEEP=y
CONFIG_ACPI_SLEEP_PROC_FS=y
CONFIG_ACPI_AC=m
CONFIG_ACPI_BATTERY=m
CONFIG_ACPI_BUTTON=y
CONFIG_ACPI_FAN=y
CONFIG_ACPI_PROCESSOR=y
CONFIG_ACPI_THERMAL=y
# CONFIG_ACPI_ASUS is not set
# CONFIG_ACPI_TOSHIBA is not set
# CONFIG_ACPI_DEBUG is not set
CONFIG_ACPI_BUS=y
CONFIG_ACPI_EC=y
CONFIG_ACPI_POWER=y
CONFIG_ACPI_PCI=y
CONFIG_ACPI_SYSTEM=y
# CONFIG_ACPI_RELAXED_AML is not set

#
# APM (Advanced Power Management) BIOS Support
#
CONFIG_APM=y
# CONFIG_APM_IGNORE_USER_SUSPEND is not set
# CONFIG_APM_DO_ENABLE is not set
CONFIG_APM_CPU_IDLE=y
CONFIG_APM_DISPLAY_BLANK=y
CONFIG_APM_RTC_IS_GMT=y
# CONFIG_APM_ALLOW_INTS is not set
CONFIG_APM_REAL_MODE_POWER_OFF=y

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
# CONFIG_PCI_USE_VECTOR is not set
# CONFIG_PCI_LEGACY_PROC is not set
CONFIG_PCI_NAMES=y
CONFIG_ISA=y
# CONFIG_EISA is not set
# CONFIG_MCA is not set
# CONFIG_SCx200 is not set
CONFIG_HOTPLUG=y

#
# PCMCIA/CardBus support
#
# CONFIG_PCMCIA is not set
CONFIG_PCMCIA_PROBE=y

#
# PCI Hotplug Support
#
# CONFIG_HOTPLUG_PCI is not set

#
# Executable file formats
#
CONFIG_BINFMT_ELF=y
CONFIG_BINFMT_AOUT=y
CONFIG_BINFMT_MISC=y

#
# Device Drivers
#

#
# Generic Driver Options
#
CONFIG_FW_LOADER=m

#
# Memory Technology Devices (MTD)
#
# CONFIG_MTD is not set

#
# Parallel port support
#
CONFIG_PARPORT=y
CONFIG_PARPORT_PC=y
# CONFIG_PARPORT_PC_FIFO is not set
# CONFIG_PARPORT_PC_SUPERIO is not set
# CONFIG_PARPORT_OTHER is not set
CONFIG_PARPORT_1284=y

#
# Plug and Play support
#
CONFIG_PNP=y
# CONFIG_PNP_DEBUG is not set

#
# Protocols
#
CONFIG_ISAPNP=y
# CONFIG_PNPBIOS is not set

#
# Block devices
#
CONFIG_BLK_DEV_FD=y
# CONFIG_BLK_DEV_XD is not set
# CONFIG_PARIDE is not set
# CONFIG_BLK_CPQ_DA is not set
# CONFIG_BLK_CPQ_CISS_DA is not set
# CONFIG_BLK_DEV_DAC960 is not set
# CONFIG_BLK_DEV_UMEM is not set
CONFIG_BLK_DEV_LOOP=m
CONFIG_BLK_DEV_CRYPTOLOOP=m
CONFIG_BLK_DEV_NBD=m
CONFIG_BLK_DEV_RAM=m
CONFIG_BLK_DEV_RAM_SIZE=4096
# CONFIG_BLK_DEV_INITRD is not set
# CONFIG_LBD is not set

#
# ATA/ATAPI/MFM/RLL support
#
CONFIG_IDE=y
CONFIG_BLK_DEV_IDE=y

#
# Please see Documentation/ide.txt for help/info on IDE drives
#
# CONFIG_BLK_DEV_HD_IDE is not set
CONFIG_BLK_DEV_IDEDISK=y
CONFIG_IDEDISK_MULTI_MODE=y
# CONFIG_IDEDISK_STROKE is not set
CONFIG_BLK_DEV_IDECD=y
# CONFIG_BLK_DEV_IDETAPE is not set
# CONFIG_BLK_DEV_IDEFLOPPY is not set
# CONFIG_BLK_DEV_IDESCSI is not set
# CONFIG_IDE_TASK_IOCTL is not set
# CONFIG_IDE_TASKFILE_IO is not set

#
# IDE chipset support/bugfixes
#
CONFIG_IDE_GENERIC=y
CONFIG_BLK_DEV_CMD640=y
# CONFIG_BLK_DEV_CMD640_ENHANCED is not set
# CONFIG_BLK_DEV_IDEPNP is not set
CONFIG_BLK_DEV_IDEPCI=y
CONFIG_IDEPCI_SHARE_IRQ=y
# CONFIG_BLK_DEV_OFFBOARD is not set
# CONFIG_BLK_DEV_GENERIC is not set
# CONFIG_BLK_DEV_OPTI621 is not set
CONFIG_BLK_DEV_RZ1000=y
CONFIG_BLK_DEV_IDEDMA_PCI=y
# CONFIG_BLK_DEV_IDEDMA_FORCED is not set
CONFIG_IDEDMA_PCI_AUTO=y
# CONFIG_IDEDMA_ONLYDISK is not set
# CONFIG_IDEDMA_PCI_WIP is not set
CONFIG_BLK_DEV_ADMA=y
# CONFIG_BLK_DEV_AEC62XX is not set
# CONFIG_BLK_DEV_ALI15X3 is not set
# CONFIG_BLK_DEV_AMD74XX is not set
# CONFIG_BLK_DEV_CMD64X is not set
# CONFIG_BLK_DEV_TRIFLEX is not set
# CONFIG_BLK_DEV_CY82C693 is not set
# CONFIG_BLK_DEV_CS5520 is not set
# CONFIG_BLK_DEV_CS5530 is not set
# CONFIG_BLK_DEV_HPT34X is not set
# CONFIG_BLK_DEV_HPT366 is not set
# CONFIG_BLK_DEV_SC1200 is not set
CONFIG_BLK_DEV_PIIX=y
# CONFIG_BLK_DEV_NS87415 is not set
CONFIG_BLK_DEV_PDC202XX_OLD=m
CONFIG_BLK_DEV_PDC202XX_NEW=m
# CONFIG_BLK_DEV_SVWKS is not set
# CONFIG_BLK_DEV_SIIMAGE is not set
# CONFIG_BLK_DEV_SIS5513 is not set
# CONFIG_BLK_DEV_SLC90E66 is not set
# CONFIG_BLK_DEV_TRM290 is not set
# CONFIG_BLK_DEV_VIA82CXXX is not set
# CONFIG_IDE_CHIPSETS is not set
CONFIG_BLK_DEV_IDEDMA=y
# CONFIG_IDEDMA_IVB is not set
CONFIG_IDEDMA_AUTO=y
# CONFIG_DMA_NONPCI is not set
# CONFIG_BLK_DEV_HD is not set

#
# SCSI device support
#
CONFIG_SCSI=y
CONFIG_SCSI_PROC_FS=y

#
# SCSI support type (disk, tape, CD-ROM)
#
CONFIG_BLK_DEV_SD=y
# CONFIG_CHR_DEV_ST is not set
# CONFIG_CHR_DEV_OSST is not set
CONFIG_BLK_DEV_SR=m
# CONFIG_BLK_DEV_SR_VENDOR is not set
CONFIG_CHR_DEV_SG=y

#
# Some SCSI devices (e.g. CD jukebox) support multiple LUNs
#
CONFIG_SCSI_MULTI_LUN=y
CONFIG_SCSI_REPORT_LUNS=y
CONFIG_SCSI_CONSTANTS=y
# CONFIG_SCSI_LOGGING is not set

#
# SCSI low-level drivers
#
CONFIG_BLK_DEV_3W_XXXX_RAID=y
# CONFIG_SCSI_7000FASST is not set
# CONFIG_SCSI_ACARD is not set
# CONFIG_SCSI_AHA152X is not set
# CONFIG_SCSI_AHA1542 is not set
# CONFIG_SCSI_AACRAID is not set
# CONFIG_SCSI_AIC7XXX is not set
# CONFIG_SCSI_AIC7XXX_OLD is not set
# CONFIG_SCSI_AIC79XX is not set
# CONFIG_SCSI_ADVANSYS is not set
# CONFIG_SCSI_IN2000 is not set
# CONFIG_SCSI_MEGARAID is not set
# CONFIG_SCSI_SATA is not set
# CONFIG_SCSI_BUSLOGIC is not set
# CONFIG_SCSI_CPQFCTS is not set
# CONFIG_SCSI_DMX3191D is not set
# CONFIG_SCSI_DTC3280 is not set
# CONFIG_SCSI_EATA is not set
# CONFIG_SCSI_EATA_PIO is not set
# CONFIG_SCSI_FUTURE_DOMAIN is not set
# CONFIG_SCSI_GDTH is not set
# CONFIG_SCSI_GENERIC_NCR5380 is not set
# CONFIG_SCSI_GENERIC_NCR5380_MMIO is not set
# CONFIG_SCSI_IPS is not set
# CONFIG_SCSI_INIA100 is not set
# CONFIG_SCSI_PPA is not set
# CONFIG_SCSI_IMM is not set
# CONFIG_SCSI_NCR53C406A is not set
# CONFIG_SCSI_SYM53C8XX_2 is not set
# CONFIG_SCSI_PAS16 is not set
# CONFIG_SCSI_PSI240I is not set
# CONFIG_SCSI_QLOGIC_FAS is not set
# CONFIG_SCSI_QLOGIC_ISP is not set
# CONFIG_SCSI_QLOGIC_FC is not set
# CONFIG_SCSI_QLOGIC_1280 is not set
CONFIG_SCSI_QLA2XXX_CONFIG=y
# CONFIG_SCSI_QLA21XX is not set
# CONFIG_SCSI_QLA22XX is not set
# CONFIG_SCSI_QLA23XX is not set
# CONFIG_SCSI_SYM53C416 is not set
# CONFIG_SCSI_DC395x is not set
# CONFIG_SCSI_DC390T is not set
# CONFIG_SCSI_T128 is not set
# CONFIG_SCSI_U14_34F is not set
# CONFIG_SCSI_ULTRASTOR is not set
# CONFIG_SCSI_NSP32 is not set
# CONFIG_SCSI_DEBUG is not set

#
# Old CD-ROM drivers (not SCSI, not IDE)
#
# CONFIG_CD_NO_IDESCSI is not set

#
# Multi-device support (RAID and LVM)
#
# CONFIG_MD is not set

#
# Fusion MPT device support
#
# CONFIG_FUSION is not set

#
# IEEE 1394 (FireWire) support (EXPERIMENTAL)
#
# CONFIG_IEEE1394 is not set

#
# I2O device support
#
# CONFIG_I2O is not set

#
# Networking support
#
CONFIG_NET=y

#
# Networking options
#
CONFIG_PACKET=y
CONFIG_PACKET_MMAP=y
# CONFIG_NETLINK_DEV is not set
CONFIG_UNIX=y
# CONFIG_NET_KEY is not set
CONFIG_INET=y
CONFIG_IP_MULTICAST=y
# CONFIG_IP_ADVANCED_ROUTER is not set
# CONFIG_IP_PNP is not set
CONFIG_NET_IPIP=m
CONFIG_NET_IPGRE=m
# CONFIG_NET_IPGRE_BROADCAST is not set
# CONFIG_IP_MROUTE is not set
# CONFIG_ARPD is not set
# CONFIG_INET_ECN is not set
# CONFIG_SYN_COOKIES is not set
# CONFIG_INET_AH is not set
# CONFIG_INET_ESP is not set
# CONFIG_INET_IPCOMP is not set
CONFIG_IPV6=m
# CONFIG_IPV6_PRIVACY is not set
# CONFIG_INET6_AH is not set
# CONFIG_INET6_ESP is not set
# CONFIG_INET6_IPCOMP is not set
# CONFIG_IPV6_TUNNEL is not set
# CONFIG_DECNET is not set
# CONFIG_BRIDGE is not set
# CONFIG_NETFILTER is not set
CONFIG_XFRM=y
# CONFIG_XFRM_USER is not set

#
# SCTP Configuration (EXPERIMENTAL)
#
CONFIG_IPV6_SCTP__=m
# CONFIG_IP_SCTP is not set
# CONFIG_ATM is not set
# CONFIG_VLAN_8021Q is not set
# CONFIG_LLC2 is not set
# CONFIG_IPX is not set
# CONFIG_ATALK is not set
# CONFIG_X25 is not set
# CONFIG_LAPB is not set
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
# Network testing
#
# CONFIG_NET_PKTGEN is not set
CONFIG_NETDEVICES=y

#
# ARCnet devices
#
# CONFIG_ARCNET is not set
CONFIG_DUMMY=m
# CONFIG_BONDING is not set
# CONFIG_EQUALIZER is not set
CONFIG_TUN=m
# CONFIG_NET_SB1000 is not set

#
# Ethernet (10 or 100Mbit)
#
CONFIG_NET_ETHERNET=y
CONFIG_MII=m
# CONFIG_HAPPYMEAL is not set
# CONFIG_SUNGEM is not set
CONFIG_NET_VENDOR_3COM=y
# CONFIG_EL1 is not set
# CONFIG_EL2 is not set
# CONFIG_ELPLUS is not set
# CONFIG_EL16 is not set
# CONFIG_EL3 is not set
# CONFIG_3C515 is not set
CONFIG_VORTEX=y
CONFIG_TYPHOON=m
# CONFIG_LANCE is not set
# CONFIG_NET_VENDOR_SMC is not set
# CONFIG_NET_VENDOR_RACAL is not set

#
# Tulip family network device support
#
# CONFIG_NET_TULIP is not set
# CONFIG_AT1700 is not set
# CONFIG_DEPCA is not set
# CONFIG_HP100 is not set
# CONFIG_NET_ISA is not set
CONFIG_NET_PCI=y
# CONFIG_PCNET32 is not set
# CONFIG_AMD8111_ETH is not set
# CONFIG_ADAPTEC_STARFIRE is not set
# CONFIG_AC3200 is not set
# CONFIG_APRICOT is not set
# CONFIG_B44 is not set
# CONFIG_FORCEDETH is not set
# CONFIG_CS89x0 is not set
# CONFIG_DGRS is not set
CONFIG_EEPRO100=m
# CONFIG_EEPRO100_PIO is not set
# CONFIG_E100 is not set
# CONFIG_FEALNX is not set
# CONFIG_NATSEMI is not set
CONFIG_NE2K_PCI=m
# CONFIG_8139CP is not set
# CONFIG_8139TOO is not set
# CONFIG_SIS900 is not set
# CONFIG_EPIC100 is not set
# CONFIG_SUNDANCE is not set
# CONFIG_TLAN is not set
# CONFIG_VIA_RHINE is not set
# CONFIG_NET_POCKET is not set

#
# Ethernet (1000 Mbit)
#
# CONFIG_ACENIC is not set
# CONFIG_DL2K is not set
# CONFIG_E1000 is not set
# CONFIG_NS83820 is not set
# CONFIG_HAMACHI is not set
# CONFIG_YELLOWFIN is not set
# CONFIG_R8169 is not set
# CONFIG_SIS190 is not set
# CONFIG_SK98LIN is not set
# CONFIG_TIGON3 is not set

#
# Ethernet (10000 Mbit)
#
# CONFIG_IXGB is not set
# CONFIG_FDDI is not set
# CONFIG_HIPPI is not set
CONFIG_PLIP=m
CONFIG_PPP=m
# CONFIG_PPP_MULTILINK is not set
# CONFIG_PPP_FILTER is not set
CONFIG_PPP_ASYNC=m
CONFIG_PPP_SYNC_TTY=m
CONFIG_PPP_DEFLATE=m
CONFIG_PPP_BSDCOMP=m
CONFIG_PPPOE=m
CONFIG_SLIP=m
# CONFIG_SLIP_COMPRESSED is not set
# CONFIG_SLIP_SMART is not set
# CONFIG_SLIP_MODE_SLIP6 is not set

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
# Bluetooth support
#
# CONFIG_BT is not set

#
# ISDN subsystem
#
# CONFIG_ISDN_BOOL is not set

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
CONFIG_INPUT_MOUSEDEV=y
CONFIG_INPUT_MOUSEDEV_PSAUX=y
CONFIG_INPUT_MOUSEDEV_SCREEN_X=1280
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=1024
# CONFIG_INPUT_JOYDEV is not set
# CONFIG_INPUT_TSDEV is not set
CONFIG_INPUT_EVDEV=y
# CONFIG_INPUT_EVBUG is not set

#
# Input I/O drivers
#
# CONFIG_GAMEPORT is not set
CONFIG_SOUND_GAMEPORT=y
CONFIG_SERIO=y
CONFIG_SERIO_I8042=y
CONFIG_SERIO_SERPORT=y
# CONFIG_SERIO_CT82C710 is not set
# CONFIG_SERIO_PARKBD is not set
# CONFIG_SERIO_PCIPS2 is not set

#
# Input Device Drivers
#
CONFIG_INPUT_KEYBOARD=y
CONFIG_KEYBOARD_ATKBD=y
# CONFIG_KEYBOARD_SUNKBD is not set
# CONFIG_KEYBOARD_XTKBD is not set
# CONFIG_KEYBOARD_NEWTON is not set
CONFIG_INPUT_MOUSE=y
CONFIG_MOUSE_PS2=y
# CONFIG_MOUSE_SERIAL is not set
# CONFIG_MOUSE_INPORT is not set
# CONFIG_MOUSE_LOGIBM is not set
# CONFIG_MOUSE_PC110PAD is not set
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
# CONFIG_SERIAL_8250 is not set

#
# Non-8250 serial port support
#
CONFIG_UNIX98_PTYS=y
CONFIG_UNIX98_PTY_COUNT=256
# CONFIG_PRINTER is not set
# CONFIG_PPDEV is not set
# CONFIG_TIPAR is not set

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
CONFIG_RTC=y
# CONFIG_DTLK is not set
# CONFIG_R3964 is not set
# CONFIG_APPLICOM is not set
# CONFIG_SONYPI is not set

#
# Ftape, the floppy tape device driver
#
# CONFIG_FTAPE is not set
CONFIG_AGP=y
# CONFIG_AGP_ALI is not set
# CONFIG_AGP_ATI is not set
# CONFIG_AGP_AMD is not set
# CONFIG_AGP_AMD64 is not set
CONFIG_AGP_INTEL=y
# CONFIG_AGP_NVIDIA is not set
# CONFIG_AGP_SIS is not set
# CONFIG_AGP_SWORKS is not set
CONFIG_AGP_VIA=y
CONFIG_DRM=y
# CONFIG_DRM_TDFX is not set
# CONFIG_DRM_GAMMA is not set
# CONFIG_DRM_R128 is not set
# CONFIG_DRM_RADEON is not set
# CONFIG_DRM_I810 is not set
# CONFIG_DRM_I830 is not set
CONFIG_DRM_MGA=y
# CONFIG_DRM_SIS is not set
# CONFIG_MWAVE is not set
# CONFIG_RAW_DRIVER is not set
CONFIG_HANGCHECK_TIMER=y

#
# I2C support
#
# CONFIG_I2C is not set

#
# Multimedia devices
#
CONFIG_VIDEO_DEV=m

#
# Video For Linux
#

#
# Video Adapters
#
# CONFIG_VIDEO_PMS is not set
# CONFIG_VIDEO_BWQCAM is not set
# CONFIG_VIDEO_CQCAM is not set
# CONFIG_VIDEO_W9966 is not set
# CONFIG_VIDEO_CPIA is not set
# CONFIG_VIDEO_STRADIS is not set
# CONFIG_VIDEO_MXB is not set
# CONFIG_VIDEO_DPC is not set
# CONFIG_VIDEO_HEXIUM_ORION is not set
# CONFIG_VIDEO_HEXIUM_GEMINI is not set

#
# Radio Adapters
#
# CONFIG_RADIO_CADET is not set
# CONFIG_RADIO_RTRACK is not set
# CONFIG_RADIO_RTRACK2 is not set
# CONFIG_RADIO_AZTECH is not set
# CONFIG_RADIO_GEMTEK is not set
# CONFIG_RADIO_GEMTEK_PCI is not set
# CONFIG_RADIO_MAXIRADIO is not set
# CONFIG_RADIO_MAESTRO is not set
# CONFIG_RADIO_SF16FMI is not set
# CONFIG_RADIO_TERRATEC is not set
# CONFIG_RADIO_TRUST is not set
# CONFIG_RADIO_TYPHOON is not set
# CONFIG_RADIO_ZOLTRIX is not set

#
# Digital Video Broadcasting Devices
#
# CONFIG_DVB is not set

#
# Graphics support
#
CONFIG_FB=y
# CONFIG_FB_CYBER2000 is not set
# CONFIG_FB_IMSTT is not set
# CONFIG_FB_VGA16 is not set
# CONFIG_FB_VESA is not set
CONFIG_VIDEO_SELECT=y
# CONFIG_FB_HGA is not set
# CONFIG_FB_RIVA is not set
# CONFIG_FB_I810 is not set
CONFIG_FB_MATROX=m
# CONFIG_FB_MATROX_MILLENIUM is not set
# CONFIG_FB_MATROX_MYSTIQUE is not set
CONFIG_FB_MATROX_G450=y
CONFIG_FB_MATROX_G100=y
# CONFIG_FB_MATROX_MULTIHEAD is not set
# CONFIG_FB_RADEON is not set
# CONFIG_FB_ATY128 is not set
# CONFIG_FB_ATY is not set
# CONFIG_FB_SIS is not set
# CONFIG_FB_NEOMAGIC is not set
# CONFIG_FB_KYRO is not set
# CONFIG_FB_3DFX is not set
# CONFIG_FB_VOODOO1 is not set
# CONFIG_FB_TRIDENT is not set
# CONFIG_FB_VIRTUAL is not set

#
# Console display driver support
#
CONFIG_VGA_CONSOLE=y
# CONFIG_MDA_CONSOLE is not set
CONFIG_DUMMY_CONSOLE=y
# CONFIG_FRAMEBUFFER_CONSOLE is not set

#
# Logo configuration
#
CONFIG_LOGO=y
# CONFIG_LOGO_LINUX_MONO is not set
# CONFIG_LOGO_LINUX_VGA16 is not set
CONFIG_LOGO_LINUX_CLUT224=y

#
# Sound
#
CONFIG_SOUND=y

#
# Advanced Linux Sound Architecture
#
CONFIG_SND=y
CONFIG_SND_SEQUENCER=y
# CONFIG_SND_SEQ_DUMMY is not set
CONFIG_SND_OSSEMUL=y
CONFIG_SND_MIXER_OSS=y
CONFIG_SND_PCM_OSS=y
CONFIG_SND_SEQUENCER_OSS=y
CONFIG_SND_RTCTIMER=y
# CONFIG_SND_VERBOSE_PRINTK is not set
# CONFIG_SND_DEBUG is not set

#
# Generic devices
#
# CONFIG_SND_DUMMY is not set
# CONFIG_SND_VIRMIDI is not set
# CONFIG_SND_MTPAV is not set
# CONFIG_SND_SERIAL_U16550 is not set
# CONFIG_SND_MPU401 is not set

#
# ISA devices
#
# CONFIG_SND_AD1816A is not set
# CONFIG_SND_AD1848 is not set
# CONFIG_SND_CS4231 is not set
# CONFIG_SND_CS4232 is not set
# CONFIG_SND_CS4236 is not set
# CONFIG_SND_ES968 is not set
# CONFIG_SND_ES1688 is not set
# CONFIG_SND_ES18XX is not set
# CONFIG_SND_GUSCLASSIC is not set
# CONFIG_SND_GUSEXTREME is not set
# CONFIG_SND_GUSMAX is not set
# CONFIG_SND_INTERWAVE is not set
# CONFIG_SND_INTERWAVE_STB is not set
# CONFIG_SND_OPTI92X_AD1848 is not set
# CONFIG_SND_OPTI92X_CS4231 is not set
# CONFIG_SND_OPTI93X is not set
# CONFIG_SND_SB8 is not set
# CONFIG_SND_SB16 is not set
# CONFIG_SND_SBAWE is not set
# CONFIG_SND_WAVEFRONT is not set
# CONFIG_SND_ALS100 is not set
# CONFIG_SND_AZT2320 is not set
# CONFIG_SND_CMI8330 is not set
# CONFIG_SND_DT019X is not set
# CONFIG_SND_OPL3SA2 is not set
# CONFIG_SND_SGALAXY is not set
# CONFIG_SND_SSCAPE is not set

#
# PCI devices
#
# CONFIG_SND_ALI5451 is not set
# CONFIG_SND_AZT3328 is not set
# CONFIG_SND_CS46XX is not set
# CONFIG_SND_CS4281 is not set
CONFIG_SND_EMU10K1=y
# CONFIG_SND_KORG1212 is not set
# CONFIG_SND_NM256 is not set
# CONFIG_SND_RME32 is not set
# CONFIG_SND_RME96 is not set
# CONFIG_SND_RME9652 is not set
# CONFIG_SND_HDSP is not set
# CONFIG_SND_TRIDENT is not set
# CONFIG_SND_YMFPCI is not set
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
# CONFIG_SND_VX222 is not set

#
# ALSA USB devices
#
CONFIG_SND_USB_AUDIO=y

#
# Open Sound System
#
# CONFIG_SOUND_PRIME is not set

#
# USB support
#
CONFIG_USB=y
# CONFIG_USB_DEBUG is not set

#
# Miscellaneous USB options
#
CONFIG_USB_DEVICEFS=y
# CONFIG_USB_BANDWIDTH is not set
# CONFIG_USB_DYNAMIC_MINORS is not set

#
# USB Host Controller Drivers
#
CONFIG_USB_EHCI_HCD=y
CONFIG_USB_OHCI_HCD=y
CONFIG_USB_UHCI_HCD=y

#
# USB Device Class drivers
#
CONFIG_USB_AUDIO=m
# CONFIG_USB_BLUETOOTH_TTY is not set
# CONFIG_USB_MIDI is not set
# CONFIG_USB_ACM is not set
# CONFIG_USB_PRINTER is not set
CONFIG_USB_STORAGE=y
# CONFIG_USB_STORAGE_DEBUG is not set
CONFIG_USB_STORAGE_DATAFAB=y
CONFIG_USB_STORAGE_FREECOM=y
CONFIG_USB_STORAGE_ISD200=y
CONFIG_USB_STORAGE_DPCM=y
CONFIG_USB_STORAGE_HP8200e=y
CONFIG_USB_STORAGE_SDDR09=y
CONFIG_USB_STORAGE_SDDR55=y
CONFIG_USB_STORAGE_JUMPSHOT=y

#
# USB Human Interface Devices (HID)
#
CONFIG_USB_HID=y
CONFIG_USB_HIDINPUT=y
# CONFIG_HID_FF is not set
# CONFIG_USB_HIDDEV is not set
# CONFIG_USB_AIPTEK is not set
# CONFIG_USB_WACOM is not set
# CONFIG_USB_KBTAB is not set
# CONFIG_USB_POWERMATE is not set
# CONFIG_USB_XPAD is not set

#
# USB Imaging devices
#
# CONFIG_USB_MDC800 is not set
# CONFIG_USB_SCANNER is not set
# CONFIG_USB_MICROTEK is not set
# CONFIG_USB_HPUSBSCSI is not set

#
# USB Multimedia devices
#
# CONFIG_USB_DABUSB is not set
# CONFIG_USB_VICAM is not set
# CONFIG_USB_DSBR is not set
# CONFIG_USB_IBMCAM is not set
# CONFIG_USB_KONICAWC is not set
# CONFIG_USB_OV511 is not set
# CONFIG_USB_PWC is not set
# CONFIG_USB_SE401 is not set
# CONFIG_USB_STV680 is not set

#
# USB Network adaptors
#
# CONFIG_USB_CATC is not set
# CONFIG_USB_KAWETH is not set
# CONFIG_USB_PEGASUS is not set
# CONFIG_USB_RTL8150 is not set
# CONFIG_USB_USBNET is not set

#
# USB port drivers
#
# CONFIG_USB_USS720 is not set

#
# USB Serial Converter support
#
CONFIG_USB_SERIAL=m
# CONFIG_USB_SERIAL_GENERIC is not set
# CONFIG_USB_SERIAL_BELKIN is not set
# CONFIG_USB_SERIAL_WHITEHEAT is not set
# CONFIG_USB_SERIAL_DIGI_ACCELEPORT is not set
# CONFIG_USB_SERIAL_EMPEG is not set
# CONFIG_USB_SERIAL_FTDI_SIO is not set
CONFIG_USB_SERIAL_VISOR=m
# CONFIG_USB_SERIAL_IPAQ is not set
# CONFIG_USB_SERIAL_IR is not set
# CONFIG_USB_SERIAL_EDGEPORT is not set
# CONFIG_USB_SERIAL_EDGEPORT_TI is not set
# CONFIG_USB_SERIAL_KEYSPAN_PDA is not set
# CONFIG_USB_SERIAL_KEYSPAN is not set
# CONFIG_USB_SERIAL_KLSI is not set
# CONFIG_USB_SERIAL_KOBIL_SCT is not set
# CONFIG_USB_SERIAL_MCT_U232 is not set
# CONFIG_USB_SERIAL_PL2303 is not set
# CONFIG_USB_SERIAL_SAFE is not set
# CONFIG_USB_SERIAL_CYBERJACK is not set
# CONFIG_USB_SERIAL_XIRCOM is not set
# CONFIG_USB_SERIAL_OMNINET is not set

#
# USB Miscellaneous drivers
#
CONFIG_USB_EMI62=m
CONFIG_USB_EMI26=m
# CONFIG_USB_TIGL is not set
# CONFIG_USB_AUERSWALD is not set
# CONFIG_USB_RIO500 is not set
# CONFIG_USB_LEGOTOWER is not set
# CONFIG_USB_BRLVGER is not set
# CONFIG_USB_LCD is not set
CONFIG_USB_LED=m
# CONFIG_USB_TEST is not set

#
# USB Gadget Support
#
# CONFIG_USB_GADGET is not set

#
# File systems
#
CONFIG_EXT2_FS=y
# CONFIG_EXT2_FS_XATTR is not set
CONFIG_EXT3_FS=y
CONFIG_EXT3_FS_XATTR=y
# CONFIG_EXT3_FS_POSIX_ACL is not set
# CONFIG_EXT3_FS_SECURITY is not set
CONFIG_JBD=y
# CONFIG_JBD_DEBUG is not set
CONFIG_FS_MBCACHE=y
CONFIG_REISERFS_FS=m
# CONFIG_REISERFS_CHECK is not set
# CONFIG_REISERFS_PROC_INFO is not set
# CONFIG_JFS_FS is not set
# CONFIG_XFS_FS is not set
# CONFIG_MINIX_FS is not set
# CONFIG_ROMFS_FS is not set
# CONFIG_QUOTA is not set
# CONFIG_AUTOFS_FS is not set
CONFIG_AUTOFS4_FS=y

#
# CD-ROM/DVD Filesystems
#
CONFIG_ISO9660_FS=y
CONFIG_JOLIET=y
CONFIG_ZISOFS=y
CONFIG_ZISOFS_FS=y
# CONFIG_UDF_FS is not set

#
# DOS/FAT/NT Filesystems
#
CONFIG_FAT_FS=m
CONFIG_MSDOS_FS=m
CONFIG_VFAT_FS=m
CONFIG_NTFS_FS=m
# CONFIG_NTFS_DEBUG is not set
CONFIG_NTFS_RW=y

#
# Pseudo filesystems
#
CONFIG_PROC_FS=y
CONFIG_PROC_KCORE=y
CONFIG_DEVFS_FS=y
CONFIG_DEVFS_MOUNT=y
# CONFIG_DEVFS_DEBUG is not set
CONFIG_DEVPTS_FS=y
# CONFIG_DEVPTS_FS_XATTR is not set
CONFIG_TMPFS=y
# CONFIG_HUGETLBFS is not set
# CONFIG_HUGETLB_PAGE is not set
CONFIG_RAMFS=y

#
# Miscellaneous filesystems
#
# CONFIG_ADFS_FS is not set
# CONFIG_AFFS_FS is not set
CONFIG_HFS_FS=m
# CONFIG_BEFS_FS is not set
# CONFIG_BFS_FS is not set
CONFIG_EFS_FS=m
# CONFIG_CRAMFS is not set
# CONFIG_VXFS_FS is not set
# CONFIG_HPFS_FS is not set
# CONFIG_QNX4FS_FS is not set
# CONFIG_SYSV_FS is not set
# CONFIG_UFS_FS is not set

#
# Network File Systems
#
CONFIG_NFS_FS=y
CONFIG_NFS_V3=y
# CONFIG_NFS_V4 is not set
# CONFIG_NFS_DIRECTIO is not set
CONFIG_NFSD=y
CONFIG_NFSD_V3=y
# CONFIG_NFSD_V4 is not set
# CONFIG_NFSD_TCP is not set
CONFIG_LOCKD=y
CONFIG_LOCKD_V4=y
CONFIG_EXPORTFS=y
CONFIG_SUNRPC=y
# CONFIG_SUNRPC_GSS is not set
CONFIG_SMB_FS=m
# CONFIG_SMB_NLS_DEFAULT is not set
CONFIG_CIFS=m
# CONFIG_NCP_FS is not set
# CONFIG_CODA_FS is not set
# CONFIG_INTERMEZZO_FS is not set
# CONFIG_AFS_FS is not set

#
# Partition Types
#
# CONFIG_PARTITION_ADVANCED is not set
CONFIG_MSDOS_PARTITION=y

#
# Native Language Support
#
CONFIG_NLS=y
CONFIG_NLS_DEFAULT="iso8859-1"
CONFIG_NLS_CODEPAGE_437=y
CONFIG_NLS_CODEPAGE_737=m
CONFIG_NLS_CODEPAGE_775=m
CONFIG_NLS_CODEPAGE_850=m
CONFIG_NLS_CODEPAGE_852=m
CONFIG_NLS_CODEPAGE_855=m
CONFIG_NLS_CODEPAGE_857=m
CONFIG_NLS_CODEPAGE_860=m
CONFIG_NLS_CODEPAGE_861=m
CONFIG_NLS_CODEPAGE_862=m
CONFIG_NLS_CODEPAGE_863=y
CONFIG_NLS_CODEPAGE_864=m
CONFIG_NLS_CODEPAGE_865=m
CONFIG_NLS_CODEPAGE_866=m
CONFIG_NLS_CODEPAGE_869=m
CONFIG_NLS_CODEPAGE_936=m
CONFIG_NLS_CODEPAGE_950=m
CONFIG_NLS_CODEPAGE_932=y
CONFIG_NLS_CODEPAGE_949=m
CONFIG_NLS_CODEPAGE_874=m
CONFIG_NLS_ISO8859_8=m
CONFIG_NLS_CODEPAGE_1250=m
CONFIG_NLS_CODEPAGE_1251=m
CONFIG_NLS_ISO8859_1=y
CONFIG_NLS_ISO8859_2=m
CONFIG_NLS_ISO8859_3=m
CONFIG_NLS_ISO8859_4=m
CONFIG_NLS_ISO8859_5=m
CONFIG_NLS_ISO8859_6=m
CONFIG_NLS_ISO8859_7=m
CONFIG_NLS_ISO8859_9=m
CONFIG_NLS_ISO8859_13=m
CONFIG_NLS_ISO8859_14=m
CONFIG_NLS_ISO8859_15=m
CONFIG_NLS_KOI8_R=m
CONFIG_NLS_KOI8_U=m
CONFIG_NLS_UTF8=y

#
# Profiling support
#
# CONFIG_PROFILING is not set

#
# Kernel hacking
#
# CONFIG_DEBUG_KERNEL is not set
# CONFIG_DEBUG_SPINLOCK_SLEEP is not set
# CONFIG_FRAME_POINTER is not set
CONFIG_X86_FIND_SMP_CONFIG=y
CONFIG_X86_MPPARSE=y

#
# Security options
#
# CONFIG_SECURITY is not set

#
# Cryptographic options
#
CONFIG_CRYPTO=y
CONFIG_CRYPTO_HMAC=y
CONFIG_CRYPTO_NULL=m
CONFIG_CRYPTO_MD4=m
CONFIG_CRYPTO_MD5=m
CONFIG_CRYPTO_SHA1=m
CONFIG_CRYPTO_SHA256=m
CONFIG_CRYPTO_SHA512=m
CONFIG_CRYPTO_DES=m
CONFIG_CRYPTO_BLOWFISH=m
CONFIG_CRYPTO_TWOFISH=m
CONFIG_CRYPTO_SERPENT=m
CONFIG_CRYPTO_AES=m
CONFIG_CRYPTO_CAST5=m
CONFIG_CRYPTO_CAST6=m
CONFIG_CRYPTO_DEFLATE=m
CONFIG_CRYPTO_TEST=m

#
# Library routines
#
CONFIG_CRC32=m
CONFIG_ZLIB_INFLATE=y
CONFIG_ZLIB_DEFLATE=m
CONFIG_X86_BIOS_REBOOT=y
CONFIG_PC=y

--0F1p//8PRICkK4MW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="dmesg.2423"

Linux version 2.4.23 (root@mikazuki) (gcc version 2.95.4 20011002 (Debian prerelease)) #1 Fri Jan 2 14:18:50 EST 2004
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 0000000017fec000 (usable)
 BIOS-e820: 0000000017fec000 - 0000000017fef000 (ACPI data)
 BIOS-e820: 0000000017fef000 - 0000000017fff000 (reserved)
 BIOS-e820: 0000000017fff000 - 0000000018000000 (ACPI NVS)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
383MB LOWMEM available.
ACPI: have wakeup address 0xc0001000
On node 0 totalpages: 98284
zone(0): 4096 pages.
zone(1): 94188 pages.
zone(2): 0 pages.
ACPI: RSDP (v000 ASUS                                      ) @ 0x000f7290
ACPI: RSDT (v001 ASUS   CUV4X_E  0x30303031 MSFT 0x31313031) @ 0x17fec000
ACPI: FADT (v001 ASUS   CUV4X_E  0x30303031 MSFT 0x31313031) @ 0x17fec080
ACPI: BOOT (v001 ASUS   CUV4X_E  0x30303031 MSFT 0x31313031) @ 0x17fec040
ACPI: DSDT (v001   ASUS CUV4X_E  0x00001000 MSFT 0x0100000b) @ 0x00000000
Kernel command line: BOOT_IMAGE=Linux2423New ro root=1601
Local APIC disabled by BIOS -- reenabling.
Found and enabled local APIC!
Initializing CPU#0
Detected 866.444 MHz processor.
Console: colour VGA+ 80x30
Calibrating delay loop... 1723.59 BogoMIPS
Memory: 385612k/393136k available (1668k kernel code, 7136k reserved, 825k data, 136k init, 0k highmem)
Dentry cache hash table entries: 65536 (order: 7, 524288 bytes)
Inode cache hash table entries: 32768 (order: 6, 262144 bytes)
Mount cache hash table entries: 512 (order: 0, 4096 bytes)
Buffer cache hash table entries: 32768 (order: 5, 131072 bytes)
Page-cache hash table entries: 131072 (order: 7, 524288 bytes)
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 256K
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU:     After generic, caps: 0383fbff 00000000 00000000 00000000
CPU:             Common caps: 0383fbff 00000000 00000000 00000000
CPU: Intel Pentium III (Coppermine) stepping 06
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 866.4547 MHz.
..... host bus clock speed is 133.3006 MHz.
cpu: 0, clocks: 1333006, slice: 666503
CPU0<T0:1332992,T1:666480,D:9,S:666503,C:1333006>
mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: Intel
ACPI: Subsystem revision 20031002
PCI: PCI BIOS revision 2.10 entry at 0xf0cd0, last bus=1
PCI: Using configuration type 1
ACPI: IRQ9 SCI: Edge set to Level Trigger.
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: System [ACPI] (supports S0 S1 S4 S5)
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 *4 5 6 7 9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 9 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 9 *10 11 12 14 15)
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCI1._PRT]
PCI: Probing PCI hardware
ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 11
ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 10
ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 4
PCI: Using ACPI for IRQ routing
PCI: if you experience problems, try using option 'pci=noacpi' or even 'acpi=off'
PCI: Disabling Via external APIC routing
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
Starting kswapd
Journalled Block Device driver loaded
devfs: v1.12c (20020818) Richard Gooch (rgooch@atnf.csiro.au)
devfs: boot_options: 0x1
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
ACPI: Power Button (FF) [PWRF]
ACPI: Processor [CPU0] (supports C1 C2, 16 throttling states)
parport0: PC-style at 0x3bc (0x7bc) [PCSPP,TRISTATE]
parport_pc: Via 686A parallel port: io=0x3BC
pty: 256 Unix98 ptys configured
Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ SERIAL_PCI ISAPNP enabled
Real Time Clock Driver v1.10e
Floppy drive(s): fd0 is 1.44M
keyboard: Timeout - AT keyboard not present?(ed)
keyboard: Timeout - AT keyboard not present?(f4)
FDC 0 is a post-1991 82077
3c59x: Donald Becker and others. www.scyld.com/network/vortex.html
See Documentation/networking/vortex.txt
00:09.0: 3Com PCI 3c905 Boomerang 100baseTx at 0xb800. Vers LK1.1.18-ac
 00:60:97:93:5a:79, IRQ 10
  product code 4848 rev 00.0 date 02-09-97
  Internal config register is 16302d8, transceivers 0xe040.
  8K word-wide RAM 3:5 Rx:Tx split, autoselect/MII interface.
  MII transceiver found at address 24, status 786f.
  Enabling bus-master transmits and whole-frame receives.
00:09.0: scatter/gather enabled. h/w checksums disabled
eth0: Dropping NETIF_F_SG since no checksum feature.
Linux agpgart interface v0.99 (c) Jeff Hartmann
agpgart: Maximum main memory to use for agp memory: 321M
agpgart: Unsupported Via chipset (device id: 0605), you might want to boot with agp=try_unsupported
agpgart: no supported devices found.
[drm:drm_init] *ERROR* Cannot initialize the agpgart module.
Uniform Multi-Platform E-IDE driver Revision: 7.00beta4-2.4
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
hda: WDC WD400BB-32AUA1, ATA DISK drive
hdb: ASUS CD-S500/A, ATAPI CD/DVD-ROM drive
hdc: Maxtor 2F030J0, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: attached ide-disk driver.
hda: host protected area => 1
hda: 78165360 sectors (40021 MB) w/2048KiB Cache, CHS=4865/255/63
hdc: attached ide-disk driver.
hdc: host protected area => 1
hdc: 60058656 sectors (30750 MB) w/2048KiB Cache, CHS=59582/16/63
hdb: attached ide-cdrom driver.
hdb: ATAPI 50X CD-ROM drive, 128kB Cache
Uniform CD-ROM driver Revision: 3.12
Partition check:
 /dev/ide/host0/bus0/target0/lun0: p1 p2 < p5 >
 /dev/ide/host1/bus0/target0/lun0: p1 p2
SCSI subsystem driver Revision: 1.00
kmod: failed to exec /sbin/modprobe -s -k scsi_hostadapter, errno = 2
kmod: failed to exec /sbin/modprobe -s -k scsi_hostadapter, errno = 2
usb.c: registered new driver hub
usb.c: registered new driver hid
hid-core.c: v1.8.1 Andreas Gal, Vojtech Pavlik <vojtech@suse.cz>
hid-core.c: USB HID support drivers
Initializing USB Mass Storage driver...
usb.c: registered new driver usb-storage
USB Mass Storage support registered.
mice: PS/2 mouse device common for all mice
Initializing Cryptographic API
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 4096 buckets, 32Kbytes
TCP: Hash tables configured (established 32768 bind 32768)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
EXT3-fs: INFO: recovery required on readonly filesystem.
EXT3-fs: write access will be enabled during recovery.
kjournald starting.  Commit interval 5 seconds
EXT3-fs: ide1(22,1): orphan cleanup on readonly fs
ext3_orphan_cleanup: deleting unreferenced inode 1093525
ext3_orphan_cleanup: deleting unreferenced inode 1093524
ext3_orphan_cleanup: deleting unreferenced inode 1093523
ext3_orphan_cleanup: deleting unreferenced inode 97932
EXT3-fs: ide1(22,1): 4 orphan inodes deleted
EXT3-fs: recovery complete.
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Mounted devfs on /dev
Freeing unused kernel memory: 136k freed
Adding Swap: 999928k swap-space (priority -1)
EXT3 FS 2.4-0.9.19, 19 August 2002 on ide1(22,1), internal journal
NTFS driver v1.1.22 [Flags: R/W MODULE]
usb-uhci.c: $Revision: 1.275 $ time 14:26:08 Jan  2 2004
usb-uhci.c: High bandwidth mode enabled
usb-uhci.c: USB UHCI at I/O 0xd400, IRQ 11
usb-uhci.c: Detected 2 ports
usb.c: new USB bus registered, assigned bus number 1
hub.c: USB hub found
hub.c: 2 ports detected
usb-uhci.c: USB UHCI at I/O 0xd000, IRQ 11
usb-uhci.c: Detected 2 ports
usb.c: new USB bus registered, assigned bus number 2
hub.c: USB hub found
hub.c: 2 ports detected
usb-uhci.c: v1.275:USB Universal Host Controller Interface driver
hub.c: new USB device 00:04.2-1, assigned address 2
hub.c: USB hub found
hub.c: 3 ports detected
hub.c: new USB device 00:04.2-2, assigned address 3
input: USB HID v1.10 Mouse [B16_b_02 USB-PS/2 Optical Mouse] on usb1:3.0
hub.c: new USB device 00:04.2-1.3, assigned address 4
input: USB HID v1.00 Keyboard [  Keyboard Hub] on usb1:4.0
input: USB HID v1.00 Device [  Keyboard Hub] on usb1:4.1
apm: BIOS version 1.2 Flags 0x03 (Driver version 1.16)
apm: overridden by ACPI.
cdrom: This disc doesn't have any tracks I recognize!
smbfs: Unrecognized mount option noexec
smb_trans2_request: result=-104, setting invalid
smb_retry: successful, new pid=1426, generation=2

--0F1p//8PRICkK4MW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="kern262.log"

Feb  4 13:35:31 mikazuki kernel: Linux version 2.6.2 (root@mikazuki) (gcc version 2.95.4 20011002 (Debian prerelease)) #1 Wed Feb 4 12:18:45 EST 2004
Feb  4 13:35:31 mikazuki kernel: BIOS-provided physical RAM map:
Feb  4 13:35:31 mikazuki kernel:  BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
Feb  4 13:35:31 mikazuki kernel:  BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
Feb  4 13:35:31 mikazuki kernel:  BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
Feb  4 13:35:31 mikazuki kernel:  BIOS-e820: 0000000000100000 - 0000000017fec000 (usable)
Feb  4 13:35:31 mikazuki kernel:  BIOS-e820: 0000000017fec000 - 0000000017fef000 (ACPI data)
Feb  4 13:35:31 mikazuki kernel:  BIOS-e820: 0000000017fef000 - 0000000017fff000 (reserved)
Feb  4 13:35:31 mikazuki kernel:  BIOS-e820: 0000000017fff000 - 0000000018000000 (ACPI NVS)
Feb  4 13:35:31 mikazuki kernel:  BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
Feb  4 13:35:31 mikazuki kernel: 383MB LOWMEM available.
Feb  4 13:35:31 mikazuki kernel: On node 0 totalpages: 98284
Feb  4 13:35:31 mikazuki kernel:   DMA zone: 4096 pages, LIFO batch:1
Feb  4 13:35:31 mikazuki kernel:   Normal zone: 94188 pages, LIFO batch:16
Feb  4 13:35:31 mikazuki kernel:   HighMem zone: 0 pages, LIFO batch:1
Feb  4 13:35:31 mikazuki kernel: DMI 2.3 present.
Feb  4 13:35:31 mikazuki kernel: ACPI: RSDP (v000 ASUS                                      ) @ 0x000f7290
Feb  4 13:35:31 mikazuki kernel: ACPI: RSDT (v001 ASUS   CUV4X_E  0x30303031 MSFT 0x31313031) @ 0x17fec000
Feb  4 13:35:31 mikazuki kernel: ACPI: FADT (v001 ASUS   CUV4X_E  0x30303031 MSFT 0x31313031) @ 0x17fec080
Feb  4 13:35:31 mikazuki kernel: ACPI: BOOT (v001 ASUS   CUV4X_E  0x30303031 MSFT 0x31313031) @ 0x17fec040
Feb  4 13:35:31 mikazuki kernel: ACPI: DSDT (v001   ASUS CUV4X_E  0x00001000 MSFT 0x0100000b) @ 0x00000000
Feb  4 13:35:31 mikazuki kernel: Building zonelist for node : 0
Feb  4 13:35:31 mikazuki kernel: Kernel command line: BOOT_IMAGE=Linux262 ro root=1601
Feb  4 13:35:31 mikazuki kernel: Local APIC disabled by BIOS -- reenabling.
Feb  4 13:35:31 mikazuki kernel: Found and enabled local APIC!
Feb  4 13:35:31 mikazuki kernel: Initializing CPU#0
Feb  4 13:35:31 mikazuki kernel: PID hash table entries: 2048 (order 11: 16384 bytes)
Feb  4 13:35:31 mikazuki kernel: Detected 867.094 MHz processor.
Feb  4 13:35:31 mikazuki kernel: Using tsc for high-res timesource
Feb  4 13:35:31 mikazuki kernel: Console: colour VGA+ 80x30
Feb  4 13:35:31 mikazuki kernel: Memory: 384544k/393136k available (2314k kernel code, 7852k reserved, 1264k data, 160k init, 0k highmem)
Feb  4 13:35:31 mikazuki kernel: Checking if this processor honours the WP bit even in supervisor mode... Ok.
Feb  4 13:35:31 mikazuki kernel: Calibrating delay loop... 1695.74 BogoMIPS
Feb  4 13:35:31 mikazuki kernel: Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
Feb  4 13:35:31 mikazuki kernel: Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
Feb  4 13:35:31 mikazuki kernel: Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
Feb  4 13:35:31 mikazuki kernel: CPU:     After generic identify, caps: 0383fbff 00000000 00000000 00000000
Feb  4 13:35:31 mikazuki kernel: CPU:     After vendor identify, caps: 0383fbff 00000000 00000000 00000000
Feb  4 13:35:31 mikazuki kernel: CPU: L1 I cache: 16K, L1 D cache: 16K
Feb  4 13:35:31 mikazuki kernel: CPU: L2 cache: 256K
Feb  4 13:35:31 mikazuki kernel: CPU:     After all inits, caps: 0383fbff 00000000 00000000 00000040
Feb  4 13:35:31 mikazuki kernel: Intel machine check architecture supported.
Feb  4 13:35:31 mikazuki kernel: Intel machine check reporting enabled on CPU#0.
Feb  4 13:35:31 mikazuki kernel: CPU: Intel Pentium III (Coppermine) stepping 06
Feb  4 13:35:31 mikazuki kernel: Enabling fast FPU save and restore... done.
Feb  4 13:35:31 mikazuki kernel: Enabling unmasked SIMD FPU exception support... done.
Feb  4 13:35:31 mikazuki kernel: Checking 'hlt' instruction... OK.
Feb  4 13:35:31 mikazuki kernel: POSIX conformance testing by UNIFIX
Feb  4 13:35:31 mikazuki kernel: enabled ExtINT on CPU#0
Feb  4 13:35:31 mikazuki kernel: ESR value before enabling vector: 00000000
Feb  4 13:35:31 mikazuki kernel: ESR value after enabling vector: 00000000
Feb  4 13:35:31 mikazuki kernel: Using local APIC timer interrupts.
Feb  4 13:35:31 mikazuki kernel: calibrating APIC timer ...
Feb  4 13:35:31 mikazuki kernel: ..... CPU clock speed is 866.0211 MHz.
Feb  4 13:35:31 mikazuki kernel: ..... host bus clock speed is 133.0263 MHz.
Feb  4 13:35:31 mikazuki kernel: NET: Registered protocol family 16
Feb  4 13:35:31 mikazuki kernel: PCI: PCI BIOS revision 2.10 entry at 0xf0cd0, last bus=1
Feb  4 13:35:31 mikazuki kernel: PCI: Using configuration type 1
Feb  4 13:35:31 mikazuki kernel: mtrr: v2.0 (20020519)
Feb  4 13:35:31 mikazuki kernel: ACPI: Subsystem revision 20040116
Feb  4 13:35:31 mikazuki kernel: ACPI: IRQ9 SCI: Edge set to Level Trigger.
Feb  4 13:35:31 mikazuki kernel: ACPI: Interpreter enabled
Feb  4 13:35:31 mikazuki kernel: ACPI: Using PIC for interrupt routing
Feb  4 13:35:31 mikazuki kernel: ACPI: PCI Interrupt Link [LNKA] (IRQs 3 *4 5 6 7 9 10 11 12 14 15)
Feb  4 13:35:31 mikazuki kernel: ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 9 10 11 12 14 15)
Feb  4 13:35:31 mikazuki kernel: ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 9 10 *11 12 14 15)
Feb  4 13:35:31 mikazuki kernel: ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 9 *10 11 12 14 15)
Feb  4 13:35:31 mikazuki kernel: ACPI: PCI Root Bridge [PCI0] (00:00)
Feb  4 13:35:31 mikazuki kernel: PCI: Probing PCI hardware (bus 00)
Feb  4 13:35:31 mikazuki kernel: ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
Feb  4 13:35:31 mikazuki kernel: ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCI1._PRT]
Feb  4 13:35:31 mikazuki kernel: Linux Plug and Play Support v0.97 (c) Adam Belay
Feb  4 13:35:31 mikazuki kernel: SCSI subsystem initialized
Feb  4 13:35:31 mikazuki kernel: drivers/usb/core/usb.c: registered new driver usbfs
Feb  4 13:35:31 mikazuki kernel: drivers/usb/core/usb.c: registered new driver hub
Feb  4 13:35:31 mikazuki kernel: ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 11
Feb  4 13:35:31 mikazuki kernel: ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 10
Feb  4 13:35:31 mikazuki kernel: ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 4
Feb  4 13:35:31 mikazuki kernel: PCI: Using ACPI for IRQ routing
Feb  4 13:35:31 mikazuki kernel: PCI: if you experience problems, try using option 'pci=noacpi' or even 'acpi=off'
Feb  4 13:35:31 mikazuki kernel: SBF: Simple Boot Flag extension found and enabled.
Feb  4 13:35:31 mikazuki kernel: SBF: Setting boot flags 0x1
Feb  4 13:35:31 mikazuki kernel: apm: BIOS version 1.2 Flags 0x03 (Driver version 1.16ac)
Feb  4 13:35:31 mikazuki kernel: apm: overridden by ACPI.
Feb  4 13:35:31 mikazuki kernel: ikconfig 0.7 with /proc/config*
Feb  4 13:35:31 mikazuki kernel: devfs: v1.22 (20021013) Richard Gooch (rgooch@atnf.csiro.au)
Feb  4 13:35:31 mikazuki kernel: devfs: boot_options: 0x1
Feb  4 13:35:31 mikazuki kernel: Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
Feb  4 13:35:31 mikazuki kernel: Initializing Cryptographic API
Feb  4 13:35:31 mikazuki kernel: PCI: Disabling Via external APIC routing
Feb  4 13:35:31 mikazuki kernel: ACPI: Power Button (FF) [PWRF]
Feb  4 13:35:31 mikazuki kernel: ACPI: Processor [CPU0] (supports C1 C2, 16 throttling states)
Feb  4 13:35:31 mikazuki kernel: isapnp: Scanning for PnP cards...
Feb  4 13:35:31 mikazuki kernel: isapnp: No Plug & Play device found
Feb  4 13:35:31 mikazuki kernel: pty: 256 Unix98 ptys configured
Feb  4 13:35:31 mikazuki kernel: Real Time Clock Driver v1.12
Feb  4 13:35:31 mikazuki kernel: Linux agpgart interface v0.100 (c) Dave Jones
Feb  4 13:35:31 mikazuki kernel: agpgart: Detected VIA ProSavage PM133/PL133/PN133 chipset
Feb  4 13:35:31 mikazuki kernel: agpgart: Maximum main memory to use for agp memory: 321M
Feb  4 13:35:31 mikazuki kernel: agpgart: AGP aperture is 32M @ 0xfc000000
Feb  4 13:35:31 mikazuki kernel: [drm] Initialized mga 3.1.0 20021029 on minor 0
Feb  4 13:35:31 mikazuki kernel: Hangcheck: starting hangcheck timer 0.5.0 (tick is 180 seconds, margin is 60 seconds).
Feb  4 13:35:31 mikazuki kernel: parport0: PC-style at 0x3bc (0x7bc) [PCSPP,TRISTATE]
Feb  4 13:35:31 mikazuki kernel: parport0: cpp_daisy: aa5500ff(38)
Feb  4 13:35:31 mikazuki kernel: parport0: assign_addrs: aa5500ff(38)
Feb  4 13:35:31 mikazuki kernel: parport0: cpp_daisy: aa5500ff(38)
Feb  4 13:35:31 mikazuki kernel: parport0: assign_addrs: aa5500ff(38)
Feb  4 13:35:31 mikazuki kernel: parport_pc: Via 686A parallel port: io=0x3BC
Feb  4 13:35:31 mikazuki kernel: Using anticipatory io scheduler
Feb  4 13:35:31 mikazuki kernel: Floppy drive(s): fd0 is 1.44M
Feb  4 13:35:31 mikazuki kernel: FDC 0 is a post-1991 82077
Feb  4 13:35:31 mikazuki kernel: 3c59x: Donald Becker and others. www.scyld.com/network/vortex.html
Feb  4 13:35:31 mikazuki kernel: 0000:00:09.0: 3Com PCI 3c905 Boomerang 100baseTx at 0xb800. Vers LK1.1.19
Feb  4 13:35:31 mikazuki kernel: eth0: Dropping NETIF_F_SG since no checksum feature.
Feb  4 13:35:31 mikazuki kernel: Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
Feb  4 13:35:31 mikazuki kernel: ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
Feb  4 13:35:31 mikazuki kernel: hda: WDC WD400BB-32AUA1, ATA DISK drive
Feb  4 13:35:31 mikazuki kernel: hdb: ASUS CD-S500/A, ATAPI CD/DVD-ROM drive
Feb  4 13:35:31 mikazuki kernel: hdc: Maxtor 2F030J0, ATA DISK drive
Feb  4 13:35:31 mikazuki kernel: ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Feb  4 13:35:31 mikazuki kernel: ide1 at 0x170-0x177,0x376 on irq 15
Feb  4 13:35:31 mikazuki kernel: hda: max request size: 128KiB
Feb  4 13:35:31 mikazuki kernel: hda: 78165360 sectors (40020 MB) w/2048KiB Cache, CHS=65535/16/63
Feb  4 13:35:31 mikazuki kernel:  /dev/ide/host0/bus0/target0/lun0: p1 p2 < p5 >
Feb  4 13:35:31 mikazuki kernel: hdc: max request size: 128KiB
Feb  4 13:35:31 mikazuki kernel: hdc: 60058656 sectors (30750 MB) w/2048KiB Cache, CHS=59582/16/63
Feb  4 13:35:31 mikazuki kernel:  /dev/ide/host1/bus0/target0/lun0: p1 p2
Feb  4 13:35:31 mikazuki kernel: hdb: ATAPI 50X CD-ROM drive, 128kB Cache
Feb  4 13:35:31 mikazuki kernel: Uniform CD-ROM driver Revision: 3.20
Feb  4 13:35:31 mikazuki kernel: 3ware Storage Controller device driver for Linux v1.02.00.037.
Feb  4 13:35:31 mikazuki kernel: 3w-xxxx: No cards found.
Feb  4 13:35:31 mikazuki kernel: ohci_hcd: 2003 Oct 13 USB 1.1 'Open' Host Controller (OHCI) Driver (PCI)
Feb  4 13:35:31 mikazuki kernel: ohci_hcd: block sizes: ed 64 td 64
Feb  4 13:35:31 mikazuki kernel: drivers/usb/host/uhci-hcd.c: USB Universal Host Controller Interface driver v2.1
Feb  4 13:35:31 mikazuki kernel: uhci_hcd 0000:00:04.2: UHCI Host Controller
Feb  4 13:35:31 mikazuki kernel: uhci_hcd 0000:00:04.2: irq 11, io base 0000d400
Feb  4 13:35:31 mikazuki kernel: uhci_hcd 0000:00:04.2: new USB bus registered, assigned bus number 1
Feb  4 13:35:31 mikazuki kernel: hub 1-0:1.0: USB hub found
Feb  4 13:35:31 mikazuki kernel: hub 1-0:1.0: 2 ports detected
Feb  4 13:35:31 mikazuki kernel: uhci_hcd 0000:00:04.3: UHCI Host Controller
Feb  4 13:35:31 mikazuki kernel: uhci_hcd 0000:00:04.3: irq 11, io base 0000d000
Feb  4 13:35:31 mikazuki kernel: uhci_hcd 0000:00:04.3: new USB bus registered, assigned bus number 2
Feb  4 13:35:31 mikazuki kernel: hub 2-0:1.0: USB hub found
Feb  4 13:35:31 mikazuki kernel: hub 2-0:1.0: 2 ports detected
Feb  4 13:35:31 mikazuki kernel: Initializing USB Mass Storage driver...
Feb  4 13:35:31 mikazuki kernel: drivers/usb/core/usb.c: registered new driver usb-storage
Feb  4 13:35:31 mikazuki kernel: USB Mass Storage support registered.
Feb  4 13:35:31 mikazuki kernel: drivers/usb/core/usb.c: registered new driver hid
Feb  4 13:35:31 mikazuki kernel: drivers/usb/input/hid-core.c: v2.0:USB HID core driver
Feb  4 13:35:31 mikazuki kernel: mice: PS/2 mouse device common for all mice
Feb  4 13:35:31 mikazuki kernel: serio: i8042 AUX port at 0x60,0x64 irq 12
Feb  4 13:35:31 mikazuki kernel: serio: i8042 KBD port at 0x60,0x64 irq 1
Feb  4 13:35:31 mikazuki kernel: Advanced Linux Sound Architecture Driver Version 0.9.7 (Thu Sep 25 19:16:36 2003 UTC).
Feb  4 13:35:31 mikazuki kernel: request_module: failed /sbin/modprobe -- snd-card-0. error = -16
Feb  4 13:35:31 mikazuki kernel: drivers/usb/core/usb.c: registered new driver snd-usb-audio
Feb  4 13:35:31 mikazuki kernel: ALSA device list:
Feb  4 13:35:31 mikazuki kernel:   #0: Sound Blaster Live! (rev.4) at 0xb400, irq 11
Feb  4 13:35:31 mikazuki kernel: NET: Registered protocol family 2
Feb  4 13:35:31 mikazuki kernel: IP: routing cache hash table of 4096 buckets, 32Kbytes
Feb  4 13:35:31 mikazuki kernel: TCP: Hash tables configured (established 32768 bind 32768)
Feb  4 13:35:31 mikazuki kernel: NET: Registered protocol family 1
Feb  4 13:35:31 mikazuki kernel: NET: Registered protocol family 17
Feb  4 13:35:31 mikazuki kernel: ACPI: (supports S0 S1 S4 S5)
Feb  4 13:35:31 mikazuki kernel: kjournald starting.  Commit interval 5 seconds
Feb  4 13:35:31 mikazuki kernel: EXT3-fs: mounted filesystem with ordered data mode.
Feb  4 13:35:31 mikazuki kernel: VFS: Mounted root (ext3 filesystem) readonly.
Feb  4 13:35:31 mikazuki kernel: Mounted devfs on /dev
Feb  4 13:35:31 mikazuki kernel: Freeing unused kernel memory: 160k freed
Feb  4 13:35:31 mikazuki kernel: hub 1-0:1.0: new USB device on port 1, assigned address 2
Feb  4 13:35:31 mikazuki kernel: hub 1-1:1.0: USB hub found
Feb  4 13:35:31 mikazuki kernel: hub 1-1:1.0: 3 ports detected
Feb  4 13:35:31 mikazuki kernel: hub 1-0:1.0: new USB device on port 2, assigned address 3
Feb  4 13:35:31 mikazuki kernel: input: USB HID v1.10 Mouse [B16_b_02 USB-PS/2 Optical Mouse] on usb-0000:00:04.2-2
Feb  4 13:35:31 mikazuki kernel: hub 1-1:1.0: new USB device on port 3, assigned address 4
Feb  4 13:35:31 mikazuki kernel: input: USB HID v1.00 Keyboard [  Keyboard Hub] on usb-0000:00:04.2-1.3
Feb  4 13:35:31 mikazuki kernel: input: USB HID v1.00 Device [  Keyboard Hub] on usb-0000:00:04.2-1.3
Feb  4 13:35:31 mikazuki kernel: Adding 999928k swap on /dev/hdc2.  Priority:-1 extents:1
Feb  4 13:35:31 mikazuki kernel: EXT3 FS on hdc1, internal journal
Feb  4 13:35:31 mikazuki kernel: NTFS driver 2.1.6 [Flags: R/W MODULE].
Feb  4 13:35:47 mikazuki kernel: nfs warning: mount version older than kernel
Feb  4 13:35:47 mikazuki kernel: nfs warning: mount version older than kernel
Feb  4 13:36:06 mikazuki kernel: agpgart: Found an AGP 2.0 compliant device at 0000:00:00.0.
Feb  4 13:36:06 mikazuki kernel: agpgart: Putting AGP V2 device at 0000:00:00.0 into 1x mode
Feb  4 13:36:06 mikazuki kernel: agpgart: Putting AGP V2 device at 0000:01:00.0 into 1x mode
Feb  4 13:38:02 mikazuki kernel: NET: Registered protocol family 10
Feb  4 13:38:02 mikazuki kernel: IPv6 over IPv4 tunneling driver
Feb  4 13:38:12 mikazuki kernel: eth0: no IPv6 routers present
Feb  4 13:38:24 mikazuki kernel: cdrom: This disc doesn't have any tracks I recognize!
Feb  4 13:45:39 mikazuki kernel: nfs warning: mount version older than kernel
Feb  4 13:45:39 mikazuki kernel: nfs warning: mount version older than kernel
Feb  4 13:45:49 mikazuki kernel: spurious 8259A interrupt: IRQ7.
Feb  4 14:07:40 mikazuki kernel: nfs warning: mount version older than kernel
Feb  4 14:19:03 mikazuki kernel: nfs warning: mount version older than kernel
Feb  4 14:22:14 mikazuki kernel: smbfs: Unrecognized mount option noexec
Feb  4 14:29:48 mikazuki kernel: SMB connection re-established (-5)
Feb  4 14:29:48 mikazuki kernel: smb_errno: class ERRSRV, code 91 from command 0x32
Feb  4 14:29:48 mikazuki kernel: smb_file_write: en/.md_transition.asp.swp validation failed, error=4294967291
Feb  4 14:31:40 mikazuki kernel: nfs warning: mount version older than kernel
Feb  4 15:32:39 mikazuki kernel: cdrom: This disc doesn't have any tracks I recognize!
Feb  4 15:32:47 mikazuki kernel: nfs warning: mount version older than kernel
Feb  4 15:40:44 mikazuki kernel: SMB connection re-established (-5)
Feb  4 15:40:44 mikazuki kernel: smb_errno: class ERRSRV, code 91 from command 0x32
Feb  4 15:40:44 mikazuki kernel: smb_file_write: en/.md_transition.asp.swp validation failed, error=4294967291

--0F1p//8PRICkK4MW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=lspci

00:00.0 Host bridge: VIA Technologies, Inc. VT8605 [ProSavage PM133] (rev c4)
00:01.0 PCI bridge: VIA Technologies, Inc. VT82C598/694x [Apollo MVP3/Pro133x AGP]
00:04.0 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super South] (rev 40)
00:04.1 IDE interface: VIA Technologies, Inc. Bus Master IDE (rev 06)
00:04.2 USB Controller: VIA Technologies, Inc. UHCI USB (rev 16)
00:04.3 USB Controller: VIA Technologies, Inc. UHCI USB (rev 16)
00:04.4 Host bridge: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI] (rev 40)
00:09.0 Ethernet controller: 3Com Corporation 3c905 100BaseTX [Boomerang]
00:0a.0 Multimedia audio controller: Creative Labs SB Live! EMU10k1 (rev 04)
00:0a.1 Input device controller: Creative Labs SB Live! (rev 01)
01:00.0 VGA compatible controller: Matrox Graphics, Inc. MGA G400 AGP (rev 04)

--0F1p//8PRICkK4MW--
