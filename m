Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263585AbTEDLYs (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 May 2003 07:24:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263584AbTEDLYs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 May 2003 07:24:48 -0400
Received: from axion.xs4all.nl ([213.84.8.90]:28200 "EHLO axion.demon.nl")
	by vger.kernel.org with ESMTP id S263585AbTEDLYW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 May 2003 07:24:22 -0400
Date: Sun, 4 May 2003 13:36:43 +0200
From: Monchi Abbad <kernel@axion.demon.nl>
To: linux-kernel@vger.kernel.org
Subject: ves1820 freeze problems was:Re: complete system freeze on boot on winchip c6
Message-ID: <20030504113643.GA14361@axion.demon.nl>
References: <20030502152615.GA1747@axion.demon.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030502152615.GA1747@axion.demon.nl>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This problems is not c6 related, the problem is dvb related, as soon as the ves1820 tuner driver is inited the system freezes. And when built as module i get the same message as when booting, even though it doesn't freeze the system.
Something else I have noticed is that the driver names have changed from:

/dev/dvb/adapterN/devnameN

to:
i
/dev/dvb/adapterNdevnameN

I hope somebody has some use for this info.

Monchi.
--
On Fri, May 02, 2003 at 05:26:15PM +0200, Monchi Abbad wrote:
> After compiling kernel 2.5.68(virgen and bk-8) I get a system freeze before finishing the boot. Although it seems as though it's a dvb problem, I get a freeze without these drivers as well.
> I have made a capture.
> 
> 
> Have a look at my config and log.
> 
> Monchi.
> --

> #
> # Automatically generated make config: don't edit
> #
> CONFIG_X86=y
> CONFIG_MMU=y
> CONFIG_UID16=y
> CONFIG_GENERIC_ISA_DMA=y
> 
> #
> # Code maturity level options
> #
> CONFIG_EXPERIMENTAL=y
> 
> #
> # General setup
> #
> CONFIG_SWAP=y
> CONFIG_SYSVIPC=y
> CONFIG_BSD_PROCESS_ACCT=y
> CONFIG_SYSCTL=y
> CONFIG_LOG_BUF_SHIFT=21
> 
> #
> # Loadable module support
> #
> CONFIG_MODULES=y
> CONFIG_MODULE_UNLOAD=y
> CONFIG_MODULE_FORCE_UNLOAD=y
> CONFIG_OBSOLETE_MODPARM=y
> # CONFIG_MODVERSIONS is not set
> CONFIG_KMOD=y
> 
> #
> # Processor type and features
> #
> CONFIG_X86_PC=y
> # CONFIG_X86_VOYAGER is not set
> # CONFIG_X86_NUMAQ is not set
> # CONFIG_X86_SUMMIT is not set
> # CONFIG_X86_BIGSMP is not set
> # CONFIG_X86_VISWS is not set
> # CONFIG_M386 is not set
> # CONFIG_M486 is not set
> # CONFIG_M586 is not set
> # CONFIG_M586TSC is not set
> # CONFIG_M586MMX is not set
> # CONFIG_M686 is not set
> # CONFIG_MPENTIUMII is not set
> # CONFIG_MPENTIUMIII is not set
> # CONFIG_MPENTIUM4 is not set
> # CONFIG_MK6 is not set
> # CONFIG_MK7 is not set
> # CONFIG_MK8 is not set
> # CONFIG_MELAN is not set
> # CONFIG_MCRUSOE is not set
> CONFIG_MWINCHIPC6=y
> # CONFIG_MWINCHIP2 is not set
> # CONFIG_MWINCHIP3D is not set
> # CONFIG_MCYRIXIII is not set
> # CONFIG_MVIAC3_2 is not set
> CONFIG_X86_CMPXCHG=y
> CONFIG_X86_XADD=y
> CONFIG_X86_L1_CACHE_SHIFT=5
> CONFIG_RWSEM_XCHGADD_ALGORITHM=y
> CONFIG_X86_WP_WORKS_OK=y
> CONFIG_X86_INVLPG=y
> CONFIG_X86_BSWAP=y
> CONFIG_X86_POPAD_OK=y
> CONFIG_X86_ALIGNMENT_16=y
> CONFIG_X86_USE_PPRO_CHECKSUM=y
> CONFIG_X86_OOSTORE=y
> CONFIG_HUGETLB_PAGE=y
> # CONFIG_SMP is not set
> CONFIG_PREEMPT=y
> CONFIG_X86_UP_APIC=y
> CONFIG_X86_UP_IOAPIC=y
> CONFIG_X86_LOCAL_APIC=y
> CONFIG_X86_IO_APIC=y
> CONFIG_X86_MCE=y
> # CONFIG_X86_MCE_NONFATAL is not set
> # CONFIG_X86_MCE_P4THERMAL is not set
> # CONFIG_TOSHIBA is not set
> # CONFIG_I8K is not set
> # CONFIG_MICROCODE is not set
> # CONFIG_X86_MSR is not set
> # CONFIG_X86_CPUID is not set
> CONFIG_EDD=y
> CONFIG_NOHIGHMEM=y
> # CONFIG_HIGHMEM4G is not set
> # CONFIG_HIGHMEM64G is not set
> # CONFIG_MATH_EMULATION is not set
> CONFIG_MTRR=y
> CONFIG_HAVE_DEC_LOCK=y
> 
> #
> # Power management options (ACPI, APM)
> #
> CONFIG_PM=y
> CONFIG_SOFTWARE_SUSPEND=y
> 
> #
> # ACPI Support
> #
> # CONFIG_ACPI is not set
> CONFIG_APM=y
> CONFIG_APM_IGNORE_USER_SUSPEND=y
> CONFIG_APM_DO_ENABLE=y
> CONFIG_APM_CPU_IDLE=y
> CONFIG_APM_DISPLAY_BLANK=y
> # CONFIG_APM_RTC_IS_GMT is not set
> CONFIG_APM_ALLOW_INTS=y
> CONFIG_APM_REAL_MODE_POWER_OFF=y
> 
> #
> # CPU Frequency scaling
> #
> # CONFIG_CPU_FREQ is not set
> 
> #
> # Bus options (PCI, PCMCIA, EISA, MCA, ISA)
> #
> CONFIG_PCI=y
> # CONFIG_PCI_GOBIOS is not set
> # CONFIG_PCI_GODIRECT is not set
> CONFIG_PCI_GOANY=y
> CONFIG_PCI_BIOS=y
> CONFIG_PCI_DIRECT=y
> # CONFIG_SCx200 is not set
> CONFIG_PCI_LEGACY_PROC=y
> CONFIG_PCI_NAMES=y
> CONFIG_ISA=y
> # CONFIG_EISA is not set
> # CONFIG_MCA is not set
> # CONFIG_HOTPLUG is not set
> 
> #
> # Executable file formats
> #
> CONFIG_KCORE_ELF=y
> # CONFIG_KCORE_AOUT is not set
> CONFIG_BINFMT_AOUT=y
> CONFIG_BINFMT_ELF=y
> CONFIG_BINFMT_MISC=m
> 
> #
> # Memory Technology Devices (MTD)
> #
> # CONFIG_MTD is not set
> 
> #
> # Parallel port support
> #
> CONFIG_PARPORT=m
> CONFIG_PARPORT_PC=m
> CONFIG_PARPORT_PC_CML1=m
> # CONFIG_PARPORT_SERIAL is not set
> CONFIG_PARPORT_PC_FIFO=y
> CONFIG_PARPORT_PC_SUPERIO=y
> # CONFIG_PARPORT_OTHER is not set
> CONFIG_PARPORT_1284=y
> 
> #
> # Plug and Play support
> #
> CONFIG_PNP=y
> CONFIG_PNP_NAMES=y
> # CONFIG_PNP_DEBUG is not set
> 
> #
> # Protocols
> #
> CONFIG_ISAPNP=y
> CONFIG_PNPBIOS=y
> 
> #
> # Block devices
> #
> CONFIG_BLK_DEV_FD=y
> # CONFIG_BLK_DEV_XD is not set
> # CONFIG_PARIDE is not set
> # CONFIG_BLK_CPQ_DA is not set
> # CONFIG_BLK_CPQ_CISS_DA is not set
> # CONFIG_BLK_DEV_DAC960 is not set
> # CONFIG_BLK_DEV_UMEM is not set
> CONFIG_BLK_DEV_LOOP=y
> CONFIG_BLK_DEV_NBD=y
> CONFIG_BLK_DEV_RAM=y
> CONFIG_BLK_DEV_RAM_SIZE=4096
> # CONFIG_BLK_DEV_INITRD is not set
> # CONFIG_LBD is not set
> 
> #
> # ATA/ATAPI/MFM/RLL device support
> #
> CONFIG_IDE=y
> 
> #
> # IDE, ATA and ATAPI Block devices
> #
> CONFIG_BLK_DEV_IDE=y
> 
> #
> # Please see Documentation/ide.txt for help/info on IDE drives
> #
> # CONFIG_BLK_DEV_HD_IDE is not set
> # CONFIG_BLK_DEV_HD is not set
> CONFIG_BLK_DEV_IDEDISK=y
> CONFIG_IDEDISK_MULTI_MODE=y
> CONFIG_IDEDISK_STROKE=y
> CONFIG_BLK_DEV_IDECD=m
> CONFIG_BLK_DEV_IDEFLOPPY=m
> CONFIG_BLK_DEV_IDESCSI=m
> CONFIG_IDE_TASK_IOCTL=y
> 
> #
> # IDE chipset support/bugfixes
> #
> # CONFIG_BLK_DEV_CMD640 is not set
> # CONFIG_BLK_DEV_IDEPNP is not set
> CONFIG_BLK_DEV_IDEPCI=y
> CONFIG_BLK_DEV_GENERIC=y
> CONFIG_IDEPCI_SHARE_IRQ=y
> CONFIG_BLK_DEV_IDEDMA_PCI=y
> # CONFIG_BLK_DEV_IDE_TCQ is not set
> # CONFIG_BLK_DEV_OFFBOARD is not set
> CONFIG_BLK_DEV_IDEDMA_FORCED=y
> CONFIG_IDEDMA_PCI_AUTO=y
> CONFIG_IDEDMA_ONLYDISK=y
> CONFIG_BLK_DEV_IDEDMA=y
> CONFIG_IDEDMA_PCI_WIP=y
> CONFIG_IDEDMA_NEW_DRIVE_LISTINGS=y
> CONFIG_BLK_DEV_ADMA=y
> # CONFIG_BLK_DEV_AEC62XX is not set
> # CONFIG_BLK_DEV_ALI15X3 is not set
> # CONFIG_BLK_DEV_AMD74XX is not set
> # CONFIG_BLK_DEV_CMD64X is not set
> # CONFIG_BLK_DEV_TRIFLEX is not set
> # CONFIG_BLK_DEV_CY82C693 is not set
> # CONFIG_BLK_DEV_CS5520 is not set
> # CONFIG_BLK_DEV_HPT34X is not set
> # CONFIG_BLK_DEV_HPT366 is not set
> # CONFIG_BLK_DEV_SC1200 is not set
> CONFIG_BLK_DEV_PIIX=y
> # CONFIG_BLK_DEV_NS87415 is not set
> # CONFIG_BLK_DEV_OPTI621 is not set
> # CONFIG_BLK_DEV_PDC202XX_OLD is not set
> # CONFIG_BLK_DEV_PDC202XX_NEW is not set
> # CONFIG_BLK_DEV_RZ1000 is not set
> # CONFIG_BLK_DEV_SVWKS is not set
> # CONFIG_BLK_DEV_SIIMAGE is not set
> # CONFIG_BLK_DEV_SIS5513 is not set
> # CONFIG_BLK_DEV_SLC90E66 is not set
> # CONFIG_BLK_DEV_TRM290 is not set
> # CONFIG_BLK_DEV_VIA82CXXX is not set
> # CONFIG_IDE_CHIPSETS is not set
> CONFIG_IDEDMA_AUTO=y
> # CONFIG_IDEDMA_IVB is not set
> CONFIG_BLK_DEV_IDE_MODES=y
> 
> #
> # SCSI device support
> #
> CONFIG_SCSI=m
> 
> #
> # SCSI support type (disk, tape, CD-ROM)
> #
> CONFIG_BLK_DEV_SD=m
> CONFIG_CHR_DEV_ST=m
> # CONFIG_CHR_DEV_OSST is not set
> CONFIG_BLK_DEV_SR=m
> CONFIG_BLK_DEV_SR_VENDOR=y
> CONFIG_CHR_DEV_SG=m
> 
> #
> # Some SCSI devices (e.g. CD jukebox) support multiple LUNs
> #
> CONFIG_SCSI_MULTI_LUN=y
> CONFIG_SCSI_REPORT_LUNS=y
> CONFIG_SCSI_CONSTANTS=y
> CONFIG_SCSI_LOGGING=y
> 
> #
> # SCSI low-level drivers
> #
> # CONFIG_BLK_DEV_3W_XXXX_RAID is not set
> # CONFIG_SCSI_7000FASST is not set
> # CONFIG_SCSI_ACARD is not set
> # CONFIG_SCSI_AHA152X is not set
> # CONFIG_SCSI_AHA1542 is not set
> # CONFIG_SCSI_AACRAID is not set
> # CONFIG_SCSI_AIC7XXX is not set
> # CONFIG_SCSI_AIC7XXX_OLD is not set
> # CONFIG_SCSI_AIC79XX is not set
> # CONFIG_SCSI_DPT_I2O is not set
> # CONFIG_SCSI_ADVANSYS is not set
> # CONFIG_SCSI_IN2000 is not set
> # CONFIG_SCSI_AM53C974 is not set
> # CONFIG_SCSI_MEGARAID is not set
> # CONFIG_SCSI_BUSLOGIC is not set
> # CONFIG_SCSI_CPQFCTS is not set
> # CONFIG_SCSI_DMX3191D is not set
> # CONFIG_SCSI_DTC3280 is not set
> # CONFIG_SCSI_EATA is not set
> # CONFIG_SCSI_EATA_PIO is not set
> # CONFIG_SCSI_FUTURE_DOMAIN is not set
> # CONFIG_SCSI_GDTH is not set
> # CONFIG_SCSI_GENERIC_NCR5380 is not set
> # CONFIG_SCSI_GENERIC_NCR5380_MMIO is not set
> # CONFIG_SCSI_IPS is not set
> # CONFIG_SCSI_INITIO is not set
> # CONFIG_SCSI_INIA100 is not set
> CONFIG_SCSI_PPA=m
> CONFIG_SCSI_IMM=m
> CONFIG_SCSI_IZIP_EPP16=y
> CONFIG_SCSI_IZIP_SLOW_CTR=y
> # CONFIG_SCSI_NCR53C406A is not set
> # CONFIG_SCSI_NCR53C7xx is not set
> CONFIG_SCSI_SYM53C8XX_2=m
> CONFIG_SCSI_SYM53C8XX_DMA_ADDRESSING_MODE=1
> CONFIG_SCSI_SYM53C8XX_DEFAULT_TAGS=16
> CONFIG_SCSI_SYM53C8XX_MAX_TAGS=64
> # CONFIG_SCSI_SYM53C8XX_IOMAPPED is not set
> # CONFIG_SCSI_NCR53C8XX is not set
> # CONFIG_SCSI_SYM53C8XX is not set
> # CONFIG_SCSI_PAS16 is not set
> # CONFIG_SCSI_PCI2000 is not set
> # CONFIG_SCSI_PCI2220I is not set
> # CONFIG_SCSI_PSI240I is not set
> # CONFIG_SCSI_QLOGIC_FAS is not set
> # CONFIG_SCSI_QLOGIC_ISP is not set
> # CONFIG_SCSI_QLOGIC_FC is not set
> # CONFIG_SCSI_QLOGIC_1280 is not set
> # CONFIG_SCSI_SEAGATE is not set
> # CONFIG_SCSI_SYM53C416 is not set
> # CONFIG_SCSI_DC395x is not set
> # CONFIG_SCSI_DC390T is not set
> # CONFIG_SCSI_T128 is not set
> # CONFIG_SCSI_U14_34F is not set
> # CONFIG_SCSI_ULTRASTOR is not set
> # CONFIG_SCSI_NSP32 is not set
> # CONFIG_SCSI_DEBUG is not set
> 
> #
> # Old CD-ROM drivers (not SCSI, not IDE)
> #
> # CONFIG_CD_NO_IDESCSI is not set
> 
> #
> # Multi-device support (RAID and LVM)
> #
> CONFIG_MD=y
> CONFIG_BLK_DEV_MD=m
> CONFIG_MD_LINEAR=m
> CONFIG_MD_RAID0=m
> CONFIG_MD_RAID1=m
> CONFIG_MD_RAID5=m
> CONFIG_MD_MULTIPATH=m
> CONFIG_BLK_DEV_DM=m
> 
> #
> # Fusion MPT device support
> #
> # CONFIG_FUSION is not set
> 
> #
> # IEEE 1394 (FireWire) support (EXPERIMENTAL)
> #
> # CONFIG_IEEE1394 is not set
> 
> #
> # I2O device support
> #
> CONFIG_I2O=m
> CONFIG_I2O_PCI=m
> CONFIG_I2O_BLOCK=m
> CONFIG_I2O_SCSI=m
> CONFIG_I2O_PROC=m
> 
> #
> # Networking support
> #
> CONFIG_NET=y
> 
> #
> # Networking options
> #
> CONFIG_PACKET=y
> CONFIG_PACKET_MMAP=y
> CONFIG_NETLINK_DEV=y
> CONFIG_NETFILTER=y
> # CONFIG_NETFILTER_DEBUG is not set
> CONFIG_UNIX=y
> CONFIG_NET_KEY=y
> CONFIG_INET=y
> CONFIG_IP_MULTICAST=y
> CONFIG_IP_ADVANCED_ROUTER=y
> CONFIG_IP_MULTIPLE_TABLES=y
> CONFIG_IP_ROUTE_FWMARK=y
> CONFIG_IP_ROUTE_NAT=y
> CONFIG_IP_ROUTE_MULTIPATH=y
> CONFIG_IP_ROUTE_TOS=y
> CONFIG_IP_ROUTE_VERBOSE=y
> CONFIG_IP_ROUTE_LARGE_TABLES=y
> # CONFIG_IP_PNP is not set
> CONFIG_NET_IPIP=m
> CONFIG_NET_IPGRE=m
> CONFIG_NET_IPGRE_BROADCAST=y
> # CONFIG_IP_MROUTE is not set
> # CONFIG_ARPD is not set
> # CONFIG_INET_ECN is not set
> # CONFIG_SYN_COOKIES is not set
> # CONFIG_INET_AH is not set
> # CONFIG_INET_ESP is not set
> # CONFIG_INET_IPCOMP is not set
> 
> #
> # IP: Netfilter Configuration
> #
> CONFIG_IP_NF_CONNTRACK=m
> CONFIG_IP_NF_FTP=m
> CONFIG_IP_NF_IRC=m
> # CONFIG_IP_NF_TFTP is not set
> # CONFIG_IP_NF_AMANDA is not set
> CONFIG_IP_NF_QUEUE=m
> CONFIG_IP_NF_IPTABLES=m
> CONFIG_IP_NF_MATCH_LIMIT=m
> CONFIG_IP_NF_MATCH_MAC=m
> CONFIG_IP_NF_MATCH_PKTTYPE=m
> CONFIG_IP_NF_MATCH_MARK=m
> CONFIG_IP_NF_MATCH_MULTIPORT=m
> CONFIG_IP_NF_MATCH_TOS=m
> CONFIG_IP_NF_MATCH_ECN=m
> CONFIG_IP_NF_MATCH_DSCP=m
> CONFIG_IP_NF_MATCH_AH_ESP=m
> CONFIG_IP_NF_MATCH_LENGTH=m
> CONFIG_IP_NF_MATCH_TTL=m
> CONFIG_IP_NF_MATCH_TCPMSS=m
> CONFIG_IP_NF_MATCH_HELPER=m
> CONFIG_IP_NF_MATCH_STATE=m
> CONFIG_IP_NF_MATCH_CONNTRACK=m
> CONFIG_IP_NF_MATCH_UNCLEAN=m
> CONFIG_IP_NF_MATCH_OWNER=m
> CONFIG_IP_NF_FILTER=m
> CONFIG_IP_NF_TARGET_REJECT=m
> CONFIG_IP_NF_TARGET_MIRROR=m
> CONFIG_IP_NF_NAT=m
> CONFIG_IP_NF_NAT_NEEDED=y
> CONFIG_IP_NF_TARGET_MASQUERADE=m
> CONFIG_IP_NF_TARGET_REDIRECT=m
> # CONFIG_IP_NF_NAT_LOCAL is not set
> CONFIG_IP_NF_NAT_SNMP_BASIC=m
> CONFIG_IP_NF_NAT_IRC=m
> CONFIG_IP_NF_NAT_FTP=m
> # CONFIG_IP_NF_MANGLE is not set
> CONFIG_IP_NF_TARGET_LOG=m
> CONFIG_IP_NF_TARGET_ULOG=m
> # CONFIG_IP_NF_TARGET_TCPMSS is not set
> # CONFIG_IP_NF_ARPTABLES is not set
> # CONFIG_IP_NF_COMPAT_IPCHAINS is not set
> # CONFIG_IP_NF_COMPAT_IPFWADM is not set
> # CONFIG_IPV6 is not set
> # CONFIG_XFRM_USER is not set
> 
> #
> # SCTP Configuration (EXPERIMENTAL)
> #
> CONFIG_IPV6_SCTP__=y
> CONFIG_IP_SCTP=m
> CONFIG_SCTP_ADLER32=y
> CONFIG_SCTP_DBG_MSG=y
> CONFIG_SCTP_DBG_OBJCNT=y
> CONFIG_ATM=y
> CONFIG_ATM_CLIP=y
> CONFIG_ATM_CLIP_NO_ICMP=y
> CONFIG_ATM_LANE=m
> CONFIG_ATM_MPOA=m
> CONFIG_VLAN_8021Q=m
> # CONFIG_LLC is not set
> # CONFIG_DECNET is not set
> # CONFIG_BRIDGE is not set
> CONFIG_X25=y
> CONFIG_LAPB=y
> # CONFIG_NET_DIVERT is not set
> CONFIG_ECONET=y
> CONFIG_ECONET_AUNUDP=y
> CONFIG_ECONET_NATIVE=y
> CONFIG_WAN_ROUTER=y
> # CONFIG_NET_FASTROUTE is not set
> # CONFIG_NET_HW_FLOWCONTROL is not set
> 
> #
> # QoS and/or fair queueing
> #
> # CONFIG_NET_SCHED is not set
> 
> #
> # Network testing
> #
> # CONFIG_NET_PKTGEN is not set
> CONFIG_NETDEVICES=y
> 
> #
> # ARCnet devices
> #
> # CONFIG_ARCNET is not set
> CONFIG_DUMMY=y
> CONFIG_BONDING=y
> CONFIG_EQUALIZER=y
> CONFIG_TUN=y
> CONFIG_ETHERTAP=y
> # CONFIG_NET_SB1000 is not set
> 
> #
> # Ethernet (10 or 100Mbit)
> #
> CONFIG_NET_ETHERNET=y
> # CONFIG_MII is not set
> # CONFIG_HAPPYMEAL is not set
> # CONFIG_SUNGEM is not set
> # CONFIG_NET_VENDOR_3COM is not set
> # CONFIG_LANCE is not set
> # CONFIG_NET_VENDOR_SMC is not set
> # CONFIG_NET_VENDOR_RACAL is not set
> 
> #
> # Tulip family network device support
> #
> # CONFIG_NET_TULIP is not set
> # CONFIG_AT1700 is not set
> # CONFIG_DEPCA is not set
> # CONFIG_HP100 is not set
> # CONFIG_NET_ISA is not set
> CONFIG_NET_PCI=y
> # CONFIG_PCNET32 is not set
> # CONFIG_AMD8111_ETH is not set
> # CONFIG_ADAPTEC_STARFIRE is not set
> # CONFIG_AC3200 is not set
> # CONFIG_APRICOT is not set
> # CONFIG_B44 is not set
> # CONFIG_CS89x0 is not set
> # CONFIG_DGRS is not set
> # CONFIG_EEPRO100 is not set
> CONFIG_E100=y
> # CONFIG_FEALNX is not set
> # CONFIG_NATSEMI is not set
> # CONFIG_NE2K_PCI is not set
> # CONFIG_8139CP is not set
> # CONFIG_8139TOO is not set
> # CONFIG_SIS900 is not set
> # CONFIG_EPIC100 is not set
> # CONFIG_SUNDANCE is not set
> # CONFIG_TLAN is not set
> # CONFIG_VIA_RHINE is not set
> # CONFIG_NET_POCKET is not set
> 
> #
> # Ethernet (1000 Mbit)
> #
> # CONFIG_ACENIC is not set
> # CONFIG_DL2K is not set
> # CONFIG_E1000 is not set
> # CONFIG_NS83820 is not set
> # CONFIG_HAMACHI is not set
> # CONFIG_YELLOWFIN is not set
> # CONFIG_R8169 is not set
> # CONFIG_SK98LIN is not set
> # CONFIG_TIGON3 is not set
> 
> #
> # Ethernet (10000 Mbit)
> #
> # CONFIG_IXGB is not set
> # CONFIG_FDDI is not set
> # CONFIG_HIPPI is not set
> CONFIG_PLIP=m
> CONFIG_PPP=m
> CONFIG_PPP_MULTILINK=y
> # CONFIG_PPP_FILTER is not set
> CONFIG_PPP_ASYNC=m
> CONFIG_PPP_SYNC_TTY=m
> CONFIG_PPP_DEFLATE=m
> CONFIG_PPP_BSDCOMP=m
> CONFIG_PPPOE=m
> CONFIG_PPPOATM=m
> CONFIG_SLIP=m
> CONFIG_SLIP_COMPRESSED=y
> CONFIG_SLIP_SMART=y
> CONFIG_SLIP_MODE_SLIP6=y
> 
> #
> # Wireless LAN (non-hamradio)
> #
> # CONFIG_NET_RADIO is not set
> 
> #
> # Token Ring devices (depends on LLC=y)
> #
> # CONFIG_NET_FC is not set
> # CONFIG_RCPCI is not set
> # CONFIG_SHAPER is not set
> 
> #
> # Wan interfaces
> #
> # CONFIG_WAN is not set
> 
> #
> # ATM drivers
> #
> # CONFIG_ATM_TCP is not set
> # CONFIG_ATM_LANAI is not set
> # CONFIG_ATM_ENI is not set
> # CONFIG_ATM_FIRESTREAM is not set
> # CONFIG_ATM_ZATM is not set
> # CONFIG_ATM_NICSTAR is not set
> # CONFIG_ATM_IDT77252 is not set
> # CONFIG_ATM_AMBASSADOR is not set
> # CONFIG_ATM_HORIZON is not set
> # CONFIG_ATM_IA is not set
> # CONFIG_ATM_FORE200E_MAYBE is not set
> 
> #
> # Amateur Radio support
> #
> # CONFIG_HAMRADIO is not set
> 
> #
> # IrDA (infrared) support
> #
> # CONFIG_IRDA is not set
> 
> #
> # ISDN subsystem
> #
> # CONFIG_ISDN_BOOL is not set
> 
> #
> # Telephony Support
> #
> # CONFIG_PHONE is not set
> 
> #
> # Input device support
> #
> CONFIG_INPUT=y
> 
> #
> # Userland interfaces
> #
> CONFIG_INPUT_MOUSEDEV=y
> CONFIG_INPUT_MOUSEDEV_PSAUX=y
> CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
> CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
> # CONFIG_INPUT_JOYDEV is not set
> # CONFIG_INPUT_TSDEV is not set
> # CONFIG_INPUT_EVDEV is not set
> # CONFIG_INPUT_EVBUG is not set
> 
> #
> # Input I/O drivers
> #
> # CONFIG_GAMEPORT is not set
> CONFIG_SOUND_GAMEPORT=y
> CONFIG_SERIO=y
> CONFIG_SERIO_I8042=y
> # CONFIG_SERIO_SERPORT is not set
> # CONFIG_SERIO_CT82C710 is not set
> # CONFIG_SERIO_PARKBD is not set
> 
> #
> # Input Device Drivers
> #
> CONFIG_INPUT_KEYBOARD=y
> CONFIG_KEYBOARD_ATKBD=y
> # CONFIG_KEYBOARD_SUNKBD is not set
> # CONFIG_KEYBOARD_XTKBD is not set
> # CONFIG_KEYBOARD_NEWTON is not set
> CONFIG_INPUT_MOUSE=y
> CONFIG_MOUSE_PS2=y
> # CONFIG_MOUSE_SERIAL is not set
> # CONFIG_MOUSE_INPORT is not set
> # CONFIG_MOUSE_LOGIBM is not set
> # CONFIG_MOUSE_PC110PAD is not set
> # CONFIG_INPUT_JOYSTICK is not set
> # CONFIG_INPUT_TOUCHSCREEN is not set
> CONFIG_INPUT_MISC=y
> CONFIG_INPUT_PCSPKR=y
> CONFIG_INPUT_UINPUT=m
> 
> #
> # Character devices
> #
> CONFIG_VT=y
> CONFIG_VT_CONSOLE=y
> # CONFIG_CONSOLE_KNOWS_9B is not set
> CONFIG_HW_CONSOLE=y
> # CONFIG_SERIAL_NONSTANDARD is not set
> 
> #
> # Serial drivers
> #
> CONFIG_SERIAL_8250=y
> CONFIG_SERIAL_8250_CONSOLE=y
> CONFIG_SERIAL_8250_EXTENDED=y
> # CONFIG_SERIAL_8250_MANY_PORTS is not set
> CONFIG_SERIAL_8250_SHARE_IRQ=y
> CONFIG_SERIAL_8250_DETECT_IRQ=y
> # CONFIG_SERIAL_8250_MULTIPORT is not set
> # CONFIG_SERIAL_8250_RSA is not set
> 
> #
> # Non-8250 serial port support
> #
> CONFIG_SERIAL_CORE=y
> CONFIG_SERIAL_CORE_CONSOLE=y
> CONFIG_UNIX98_PTYS=y
> CONFIG_UNIX98_PTY_COUNT=256
> CONFIG_PRINTER=m
> CONFIG_LP_CONSOLE=y
> CONFIG_PPDEV=m
> # CONFIG_TIPAR is not set
> 
> #
> # I2C support
> #
> CONFIG_I2C=y
> CONFIG_I2C_ALGOBIT=y
> # CONFIG_I2C_PHILIPSPAR is not set
> # CONFIG_I2C_ELV is not set
> # CONFIG_I2C_VELLEMAN is not set
> # CONFIG_SCx200_ACB is not set
> CONFIG_I2C_ALGOPCF=y
> # CONFIG_I2C_ELEKTOR is not set
> CONFIG_I2C_CHARDEV=y
> 
> #
> # I2C Hardware Sensors Mainboard support
> #
> # CONFIG_I2C_ALI15X3 is not set
> # CONFIG_I2C_AMD756 is not set
> # CONFIG_I2C_AMD8111 is not set
> # CONFIG_I2C_I801 is not set
> CONFIG_I2C_ISA=y
> CONFIG_I2C_PIIX4=y
> # CONFIG_I2C_VIAPRO is not set
> 
> #
> # I2C Hardware Sensors Chip support
> #
> CONFIG_SENSORS_ADM1021=m
> CONFIG_SENSORS_IT87=m
> CONFIG_SENSORS_LM75=m
> CONFIG_SENSORS_VIA686A=m
> CONFIG_SENSORS_W83781D=m
> CONFIG_I2C_SENSOR=m
> 
> #
> # Mice
> #
> # CONFIG_BUSMOUSE is not set
> # CONFIG_QIC02_TAPE is not set
> 
> #
> # IPMI
> #
> CONFIG_IPMI_HANDLER=m
> CONFIG_IPMI_PANIC_EVENT=y
> CONFIG_IPMI_DEVICE_INTERFACE=m
> CONFIG_IPMI_KCS=m
> CONFIG_IPMI_WATCHDOG=m
> 
> #
> # Watchdog Cards
> #
> # CONFIG_WATCHDOG is not set
> CONFIG_HW_RANDOM=y
> CONFIG_NVRAM=y
> CONFIG_RTC=y
> # CONFIG_DTLK is not set
> CONFIG_R3964=y
> # CONFIG_APPLICOM is not set
> # CONFIG_SONYPI is not set
> 
> #
> # Ftape, the floppy tape device driver
> #
> # CONFIG_FTAPE is not set
> CONFIG_AGP=m
> # CONFIG_AGP_INTEL is not set
> CONFIG_AGP_VIA=m
> # CONFIG_AGP_AMD is not set
> # CONFIG_AGP_SIS is not set
> # CONFIG_AGP_ALI is not set
> # CONFIG_AGP_SWORKS is not set
> # CONFIG_AGP_AMD_8151 is not set
> CONFIG_DRM=y
> # CONFIG_DRM_TDFX is not set
> # CONFIG_DRM_R128 is not set
> # CONFIG_DRM_RADEON is not set
> # CONFIG_DRM_I810 is not set
> # CONFIG_DRM_I830 is not set
> CONFIG_DRM_MGA=m
> # CONFIG_MWAVE is not set
> CONFIG_RAW_DRIVER=m
> CONFIG_HANGCHECK_TIMER=m
> 
> #
> # Multimedia devices
> #
> CONFIG_VIDEO_DEV=y
> 
> #
> # Video For Linux
> #
> CONFIG_VIDEO_PROC_FS=y
> 
> #
> # Video Adapters
> #
> # CONFIG_VIDEO_BT848 is not set
> # CONFIG_VIDEO_PMS is not set
> # CONFIG_VIDEO_BWQCAM is not set
> # CONFIG_VIDEO_CQCAM is not set
> # CONFIG_VIDEO_W9966 is not set
> # CONFIG_VIDEO_CPIA is not set
> # CONFIG_VIDEO_SAA5249 is not set
> # CONFIG_TUNER_3036 is not set
> # CONFIG_VIDEO_STRADIS is not set
> # CONFIG_VIDEO_ZORAN is not set
> # CONFIG_VIDEO_ZR36120 is not set
> # CONFIG_VIDEO_SAA7134 is not set
> CONFIG_VIDEO_MXB=m
> CONFIG_VIDEO_DPC=m
> 
> #
> # Radio Adapters
> #
> # CONFIG_RADIO_CADET is not set
> # CONFIG_RADIO_RTRACK is not set
> # CONFIG_RADIO_RTRACK2 is not set
> # CONFIG_RADIO_AZTECH is not set
> # CONFIG_RADIO_GEMTEK is not set
> # CONFIG_RADIO_GEMTEK_PCI is not set
> # CONFIG_RADIO_MAXIRADIO is not set
> # CONFIG_RADIO_MAESTRO is not set
> # CONFIG_RADIO_SF16FMI is not set
> # CONFIG_RADIO_TERRATEC is not set
> # CONFIG_RADIO_TRUST is not set
> # CONFIG_RADIO_TYPHOON is not set
> # CONFIG_RADIO_ZOLTRIX is not set
> 
> #
> # Digital Video Broadcasting Devices
> #
> CONFIG_DVB=y
> CONFIG_DVB_CORE=y
> 
> #
> # Supported Frontend Modules
> #
> # CONFIG_DVB_STV0299 is not set
> # CONFIG_DVB_ALPS_BSRV2 is not set
> # CONFIG_DVB_ALPS_TDLB7 is not set
> # CONFIG_DVB_ALPS_TDMB7 is not set
> # CONFIG_DVB_ATMEL_AT76C651 is not set
> # CONFIG_DVB_GRUNDIG_29504_491 is not set
> # CONFIG_DVB_GRUNDIG_29504_401 is not set
> CONFIG_DVB_VES1820=y
> 
> #
> # Supported SAA7146 based PCI Adapters
> #
> CONFIG_DVB_AV7110=y
> CONFIG_DVB_AV7110_OSD=y
> # CONFIG_DVB_BUDGET is not set
> CONFIG_VIDEO_SAA7146=y
> CONFIG_VIDEO_VIDEOBUF=y
> CONFIG_VIDEO_TUNER=m
> CONFIG_VIDEO_BUF=y
> # CONFIG_VIDEO_BTCX is not set
> 
> #
> # File systems
> #
> CONFIG_EXT2_FS=y
> CONFIG_EXT2_FS_XATTR=y
> CONFIG_EXT2_FS_POSIX_ACL=y
> CONFIG_EXT3_FS=y
> CONFIG_EXT3_FS_XATTR=y
> CONFIG_EXT3_FS_POSIX_ACL=y
> CONFIG_JBD=y
> # CONFIG_JBD_DEBUG is not set
> CONFIG_FS_MBCACHE=y
> CONFIG_REISERFS_FS=m
> # CONFIG_REISERFS_CHECK is not set
> CONFIG_REISERFS_PROC_INFO=y
> CONFIG_JFS_FS=m
> CONFIG_JFS_POSIX_ACL=y
> # CONFIG_JFS_DEBUG is not set
> CONFIG_JFS_STATISTICS=y
> CONFIG_FS_POSIX_ACL=y
> CONFIG_XFS_FS=m
> CONFIG_XFS_RT=y
> CONFIG_XFS_QUOTA=y
> CONFIG_XFS_POSIX_ACL=y
> CONFIG_MINIX_FS=y
> CONFIG_ROMFS_FS=m
> CONFIG_QUOTA=y
> CONFIG_QFMT_V1=m
> CONFIG_QFMT_V2=m
> CONFIG_QUOTACTL=y
> CONFIG_AUTOFS_FS=m
> CONFIG_AUTOFS4_FS=m
> 
> #
> # CD-ROM/DVD Filesystems
> #
> CONFIG_ISO9660_FS=m
> CONFIG_JOLIET=y
> CONFIG_ZISOFS=y
> CONFIG_ZISOFS_FS=m
> CONFIG_UDF_FS=m
> 
> #
> # DOS/FAT/NT Filesystems
> #
> CONFIG_FAT_FS=m
> CONFIG_MSDOS_FS=m
> CONFIG_VFAT_FS=m
> CONFIG_NTFS_FS=m
> # CONFIG_NTFS_DEBUG is not set
> CONFIG_NTFS_RW=y
> 
> #
> # Pseudo filesystems
> #
> CONFIG_PROC_FS=y
> CONFIG_DEVFS_FS=y
> # CONFIG_DEVFS_MOUNT is not set
> # CONFIG_DEVFS_DEBUG is not set
> CONFIG_DEVPTS_FS=y
> CONFIG_TMPFS=y
> CONFIG_HUGETLBFS=y
> CONFIG_RAMFS=y
> 
> #
> # Miscellaneous filesystems
> #
> CONFIG_ADFS_FS=m
> CONFIG_ADFS_FS_RW=y
> CONFIG_AFFS_FS=m
> CONFIG_HFS_FS=m
> CONFIG_BEFS_FS=m
> # CONFIG_BEFS_DEBUG is not set
> CONFIG_BFS_FS=m
> CONFIG_EFS_FS=m
> CONFIG_CRAMFS=m
> CONFIG_VXFS_FS=m
> CONFIG_HPFS_FS=m
> CONFIG_QNX4FS_FS=m
> CONFIG_QNX4FS_RW=y
> CONFIG_SYSV_FS=m
> CONFIG_UFS_FS=m
> CONFIG_UFS_FS_WRITE=y
> 
> #
> # Network File Systems
> #
> CONFIG_NFS_FS=m
> CONFIG_NFS_V3=y
> CONFIG_NFS_V4=y
> CONFIG_NFSD=m
> CONFIG_NFSD_V3=y
> CONFIG_NFSD_V4=y
> CONFIG_NFSD_TCP=y
> CONFIG_LOCKD=m
> CONFIG_LOCKD_V4=y
> CONFIG_EXPORTFS=m
> CONFIG_SUNRPC=m
> CONFIG_SUNRPC_GSS=m
> CONFIG_SMB_FS=y
> CONFIG_SMB_NLS_DEFAULT=y
> CONFIG_SMB_NLS_REMOTE="cp437"
> CONFIG_CIFS=m
> CONFIG_NCP_FS=m
> # CONFIG_NCPFS_PACKET_SIGNING is not set
> # CONFIG_NCPFS_IOCTL_LOCKING is not set
> # CONFIG_NCPFS_STRONG is not set
> # CONFIG_NCPFS_NFS_NS is not set
> # CONFIG_NCPFS_OS2_NS is not set
> # CONFIG_NCPFS_SMALLDOS is not set
> # CONFIG_NCPFS_NLS is not set
> # CONFIG_NCPFS_EXTRAS is not set
> CONFIG_CODA_FS=m
> CONFIG_INTERMEZZO_FS=m
> CONFIG_AFS_FS=m
> CONFIG_RXRPC=m
> 
> #
> # Partition Types
> #
> CONFIG_PARTITION_ADVANCED=y
> # CONFIG_ACORN_PARTITION is not set
> # CONFIG_OSF_PARTITION is not set
> # CONFIG_AMIGA_PARTITION is not set
> # CONFIG_ATARI_PARTITION is not set
> # CONFIG_MAC_PARTITION is not set
> CONFIG_MSDOS_PARTITION=y
> # CONFIG_BSD_DISKLABEL is not set
> # CONFIG_MINIX_SUBPARTITION is not set
> # CONFIG_SOLARIS_X86_PARTITION is not set
> # CONFIG_UNIXWARE_DISKLABEL is not set
> # CONFIG_LDM_PARTITION is not set
> # CONFIG_NEC98_PARTITION is not set
> # CONFIG_SGI_PARTITION is not set
> # CONFIG_ULTRIX_PARTITION is not set
> # CONFIG_SUN_PARTITION is not set
> # CONFIG_EFI_PARTITION is not set
> CONFIG_SMB_NLS=y
> CONFIG_NLS=y
> 
> #
> # Native Language Support
> #
> CONFIG_NLS_DEFAULT="iso8859-1"
> CONFIG_NLS_CODEPAGE_437=y
> CONFIG_NLS_CODEPAGE_737=m
> CONFIG_NLS_CODEPAGE_775=m
> CONFIG_NLS_CODEPAGE_850=y
> CONFIG_NLS_CODEPAGE_852=y
> CONFIG_NLS_CODEPAGE_855=m
> CONFIG_NLS_CODEPAGE_857=m
> CONFIG_NLS_CODEPAGE_860=m
> CONFIG_NLS_CODEPAGE_861=m
> CONFIG_NLS_CODEPAGE_862=m
> CONFIG_NLS_CODEPAGE_863=m
> CONFIG_NLS_CODEPAGE_864=m
> CONFIG_NLS_CODEPAGE_865=m
> CONFIG_NLS_CODEPAGE_866=m
> CONFIG_NLS_CODEPAGE_869=m
> CONFIG_NLS_CODEPAGE_936=m
> CONFIG_NLS_CODEPAGE_950=m
> CONFIG_NLS_CODEPAGE_932=m
> CONFIG_NLS_CODEPAGE_949=m
> CONFIG_NLS_CODEPAGE_874=m
> CONFIG_NLS_ISO8859_8=m
> CONFIG_NLS_CODEPAGE_1250=m
> CONFIG_NLS_CODEPAGE_1251=m
> CONFIG_NLS_ISO8859_1=y
> CONFIG_NLS_ISO8859_2=m
> CONFIG_NLS_ISO8859_3=m
> CONFIG_NLS_ISO8859_4=m
> CONFIG_NLS_ISO8859_5=m
> CONFIG_NLS_ISO8859_6=m
> CONFIG_NLS_ISO8859_7=m
> CONFIG_NLS_ISO8859_9=m
> CONFIG_NLS_ISO8859_13=m
> CONFIG_NLS_ISO8859_14=m
> CONFIG_NLS_ISO8859_15=m
> CONFIG_NLS_KOI8_R=m
> CONFIG_NLS_KOI8_U=m
> CONFIG_NLS_UTF8=m
> 
> #
> # Graphics support
> #
> CONFIG_FB=y
> # CONFIG_FB_CIRRUS is not set
> # CONFIG_FB_PM2 is not set
> # CONFIG_FB_CYBER2000 is not set
> # CONFIG_FB_IMSTT is not set
> # CONFIG_FB_VGA16 is not set
> CONFIG_FB_VESA=y
> CONFIG_VIDEO_SELECT=y
> # CONFIG_FB_HGA is not set
> # CONFIG_FB_RIVA is not set
> CONFIG_FB_MATROX=y
> # CONFIG_FB_MATROX_MILLENIUM is not set
> CONFIG_FB_MATROX_MYSTIQUE=y
> # CONFIG_FB_MATROX_G450 is not set
> # CONFIG_FB_MATROX_G100A is not set
> CONFIG_FB_MATROX_I2C=y
> CONFIG_FB_MATROX_PROC=y
> # CONFIG_FB_MATROX_MULTIHEAD is not set
> # CONFIG_FB_RADEON is not set
> # CONFIG_FB_ATY128 is not set
> # CONFIG_FB_ATY is not set
> # CONFIG_FB_SIS is not set
> # CONFIG_FB_NEOMAGIC is not set
> # CONFIG_FB_3DFX is not set
> # CONFIG_FB_VOODOO1 is not set
> # CONFIG_FB_TRIDENT is not set
> # CONFIG_FB_PM3 is not set
> # CONFIG_FB_VIRTUAL is not set
> 
> #
> # Console display driver support
> #
> CONFIG_VGA_CONSOLE=y
> # CONFIG_MDA_CONSOLE is not set
> CONFIG_DUMMY_CONSOLE=y
> CONFIG_FRAMEBUFFER_CONSOLE=y
> CONFIG_PCI_CONSOLE=y
> # CONFIG_FONTS is not set
> CONFIG_FONT_8x8=y
> CONFIG_FONT_8x16=y
> 
> #
> # Logo configuration
> #
> CONFIG_LOGO=y
> CONFIG_LOGO_LINUX_MONO=y
> CONFIG_LOGO_LINUX_VGA16=y
> CONFIG_LOGO_LINUX_CLUT224=y
> 
> #
> # Sound
> #
> CONFIG_SOUND=y
> 
> #
> # Advanced Linux Sound Architecture
> #
> CONFIG_SND=y
> CONFIG_SND_SEQUENCER=y
> # CONFIG_SND_SEQ_DUMMY is not set
> CONFIG_SND_OSSEMUL=y
> CONFIG_SND_MIXER_OSS=y
> CONFIG_SND_PCM_OSS=y
> CONFIG_SND_SEQUENCER_OSS=y
> CONFIG_SND_RTCTIMER=y
> # CONFIG_SND_VERBOSE_PRINTK is not set
> # CONFIG_SND_DEBUG is not set
> 
> #
> # Generic devices
> #
> # CONFIG_SND_DUMMY is not set
> # CONFIG_SND_VIRMIDI is not set
> # CONFIG_SND_MTPAV is not set
> # CONFIG_SND_SERIAL_U16550 is not set
> CONFIG_SND_MPU401=y
> 
> #
> # ISA devices
> #
> # CONFIG_SND_AD1816A is not set
> # CONFIG_SND_AD1848 is not set
> # CONFIG_SND_CS4231 is not set
> # CONFIG_SND_CS4232 is not set
> CONFIG_SND_CS4236=y
> # CONFIG_SND_ES968 is not set
> # CONFIG_SND_ES1688 is not set
> # CONFIG_SND_ES18XX is not set
> # CONFIG_SND_GUSCLASSIC is not set
> # CONFIG_SND_GUSEXTREME is not set
> # CONFIG_SND_GUSMAX is not set
> # CONFIG_SND_INTERWAVE is not set
> # CONFIG_SND_INTERWAVE_STB is not set
> # CONFIG_SND_OPTI92X_AD1848 is not set
> # CONFIG_SND_OPTI92X_CS4231 is not set
> # CONFIG_SND_OPTI93X is not set
> # CONFIG_SND_SB8 is not set
> # CONFIG_SND_SB16 is not set
> # CONFIG_SND_SBAWE is not set
> # CONFIG_SND_WAVEFRONT is not set
> # CONFIG_SND_ALS100 is not set
> # CONFIG_SND_AZT2320 is not set
> # CONFIG_SND_CMI8330 is not set
> # CONFIG_SND_DT019X is not set
> # CONFIG_SND_OPL3SA2 is not set
> # CONFIG_SND_SGALAXY is not set
> 
> #
> # PCI devices
> #
> # CONFIG_SND_ALI5451 is not set
> # CONFIG_SND_CS46XX is not set
> # CONFIG_SND_CS4281 is not set
> # CONFIG_SND_EMU10K1 is not set
> # CONFIG_SND_KORG1212 is not set
> # CONFIG_SND_NM256 is not set
> # CONFIG_SND_RME32 is not set
> # CONFIG_SND_RME96 is not set
> # CONFIG_SND_RME9652 is not set
> # CONFIG_SND_HDSP is not set
> # CONFIG_SND_TRIDENT is not set
> # CONFIG_SND_YMFPCI is not set
> # CONFIG_SND_ALS4000 is not set
> # CONFIG_SND_CMIPCI is not set
> # CONFIG_SND_ENS1370 is not set
> # CONFIG_SND_ENS1371 is not set
> # CONFIG_SND_ES1938 is not set
> # CONFIG_SND_ES1968 is not set
> # CONFIG_SND_MAESTRO3 is not set
> # CONFIG_SND_FM801 is not set
> # CONFIG_SND_ICE1712 is not set
> # CONFIG_SND_ICE1724 is not set
> # CONFIG_SND_INTEL8X0 is not set
> # CONFIG_SND_SONICVIBES is not set
> # CONFIG_SND_VIA82XX is not set
> 
> #
> # Open Sound System
> #
> CONFIG_SOUND_PRIME=m
> # CONFIG_SOUND_BT878 is not set
> # CONFIG_SOUND_CMPCI is not set
> # CONFIG_SOUND_EMU10K1 is not set
> # CONFIG_SOUND_FUSION is not set
> # CONFIG_SOUND_CS4281 is not set
> # CONFIG_SOUND_ES1370 is not set
> # CONFIG_SOUND_ES1371 is not set
> # CONFIG_SOUND_ESSSOLO1 is not set
> # CONFIG_SOUND_MAESTRO is not set
> # CONFIG_SOUND_MAESTRO3 is not set
> # CONFIG_SOUND_ICH is not set
> # CONFIG_SOUND_RME96XX is not set
> # CONFIG_SOUND_SONICVIBES is not set
> # CONFIG_SOUND_TRIDENT is not set
> # CONFIG_SOUND_MSNDCLAS is not set
> # CONFIG_SOUND_MSNDPIN is not set
> # CONFIG_SOUND_VIA82CXXX is not set
> CONFIG_SOUND_OSS=m
> # CONFIG_SOUND_TRACEINIT is not set
> # CONFIG_SOUND_DMAP is not set
> # CONFIG_SOUND_AD1816 is not set
> # CONFIG_SOUND_SGALAXY is not set
> # CONFIG_SOUND_ADLIB is not set
> # CONFIG_SOUND_ACI_MIXER is not set
> CONFIG_SOUND_CS4232=m
> # CONFIG_SOUND_SSCAPE is not set
> # CONFIG_SOUND_GUS is not set
> # CONFIG_SOUND_VMIDI is not set
> # CONFIG_SOUND_TRIX is not set
> # CONFIG_SOUND_MSS is not set
> # CONFIG_SOUND_MPU401 is not set
> # CONFIG_SOUND_NM256 is not set
> # CONFIG_SOUND_MAD16 is not set
> # CONFIG_SOUND_PAS is not set
> # CONFIG_SOUND_PSS is not set
> # CONFIG_SOUND_SB is not set
> # CONFIG_SOUND_AWE32_SYNTH is not set
> # CONFIG_SOUND_WAVEFRONT is not set
> # CONFIG_SOUND_MAUI is not set
> # CONFIG_SOUND_YM3812 is not set
> # CONFIG_SOUND_OPL3SA1 is not set
> # CONFIG_SOUND_OPL3SA2 is not set
> # CONFIG_SOUND_YMFPCI is not set
> # CONFIG_SOUND_UART6850 is not set
> # CONFIG_SOUND_AEDSP16 is not set
> # CONFIG_SOUND_TVMIXER is not set
> 
> #
> # USB support
> #
> # CONFIG_USB is not set
> 
> #
> # Bluetooth support
> #
> # CONFIG_BT is not set
> 
> #
> # Profiling support
> #
> # CONFIG_PROFILING is not set
> 
> #
> # Kernel hacking
> #
> CONFIG_DEBUG_KERNEL=y
> # CONFIG_DEBUG_STACKOVERFLOW is not set
> # CONFIG_DEBUG_SLAB is not set
> # CONFIG_DEBUG_IOVIRT is not set
> CONFIG_MAGIC_SYSRQ=y
> # CONFIG_DEBUG_SPINLOCK is not set
> # CONFIG_KALLSYMS is not set
> # CONFIG_DEBUG_SPINLOCK_SLEEP is not set
> # CONFIG_FRAME_POINTER is not set
> CONFIG_X86_EXTRA_IRQS=y
> CONFIG_X86_FIND_SMP_CONFIG=y
> CONFIG_X86_MPPARSE=y
> 
> #
> # Security options
> #
> # CONFIG_SECURITY is not set
> 
> #
> # Cryptographic options
> #
> # CONFIG_CRYPTO is not set
> 
> #
> # Library routines
> #
> CONFIG_CRC32=y
> CONFIG_ZLIB_INFLATE=m
> CONFIG_ZLIB_DEFLATE=m
> CONFIG_X86_BIOS_REBOOT=y

> Linux version 2.5.68-bk9 (root@axion) (gcc version 2.95.3 20010315 (release)) #16 Fri May 2 16:57:38 CEST 2003
> Video mode to be used for restore is f00
> BIOS-provided physical RAM map:
>  BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
>  BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
>  BIOS-e820: 00000000000f0400 - 0000000000100000 (reserved)
>  BIOS-e820: 0000000000100000 - 000000000a000000 (usable)
>  BIOS-e820: 00000000ffff0400 - 0000000100000000 (reserved)
> 160MB LOWMEM available.
> On node 0 totalpages: 40960
>   DMA zone: 4096 pages, LIFO batch:1
>   Normal zone: 36864 pages, LIFO batch:9
>   HighMem zone: 0 pages, LIFO batch:1
> Building zonelist for node : 0
> Kernel command line: BOOT_IMAGE=2.5 ro root=302 video=matroxfb:disable console=ttyS0
> No local APIC present or hardware disabled
> Initializing CPU#0
> PID hash table entries: 1024 (order 10: 8192 bytes)
> Detected 199.787 MHz processor.
> Console: colour VGA+ 80x25
> Calibrating delay loop... 393.21 BogoMIPS
> Memory: 156136k/163840k available (1900k kernel code, 7080k reserved, 568k data, 544k init, 0k highmem)
> Checking if this processor honours the WP bit even in supervisor mode... Ok.
> Dentry cache hash table entries: 32768 (order: 5, 131072 bytes)
> Inode-cache hash table entries: 16384 (order: 4, 65536 bytes)
> Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
> -> /dev
> -> /dev/console
> -> /root
> Disabling bugged TSC.
> Centaur FCR was 0x410200 now 0x410382
> Winchip machine check reporting enabled on CPU#0.
> CPU: Centaur WinChip C6 stepping 01
> Checking 'hlt' instruction... OK.
> POSIX conformance testing by UNIFIX
> Sangoma WANPIPE Router v1.1 (c) 1995-2000 Sangoma Technologies Inc.
> mtrr: v2.0 (20020519)
> PCI: PCI BIOS revision 2.10 entry at 0xfd9c4, last bus=0
> PCI: Using configuration type 1
> BIO: pool of 256 setup, 14Kb (56 bytes/bio)
> biovec pool[0]:   1 bvecs: 256 entries (12 bytes)
> biovec pool[1]:   4 bvecs: 256 entries (48 bytes)
> biovec pool[2]:  16 bvecs: 256 entries (192 bytes)
> biovec pool[3]:  64 bvecs: 256 entries (768 bytes)
> biovec pool[4]: 128 bvecs: 256 entries (1536 bytes)
> biovec pool[5]: 256 bvecs: 256 entries (3072 bytes)
> Linux Plug and Play Support v0.96 (c) Adam Belay
> PnPBIOS: Scanning system for PnP BIOS support...
> PnPBIOS: Found PnP BIOS installation structure at 0xc00f6e60
> PnPBIOS: PnP BIOS version 1.0, entry 0xf0000:0xa17d, dseg 0x400
> PnPBIOS: 16 nodes reported by PnP BIOS; 16 recorded by driver
> block request queues:
>  128 requests per read queue
>  128 requests per write queue
>  8 requests per batch
>  enter congestion at 15
>  exit congestion at 17
> PCI: Probing PCI hardware
> PCI: Probing PCI hardware (bus 00)
> PCI: Using IRQ router PIIX [8086/7110] at 00:07.0
> Initializing RT netlink socket
> apm: BIOS version 1.2 Flags 0x03 (Driver version 1.16ac)
> Total HugeTLB memory allocated, 0
> VFS: Disk quotas dquot_6.5.1
> Journalled Block Device driver loaded
> devfs: v1.22 (20021013) Richard Gooch (rgooch@atnf.csiro.au)
> devfs: boot_options: 0x0
> Limiting direct PCI/PCI transfers.
> isapnp: Scanning for PnP cards...
> irq 5: nobody cared!
> Call Trace: [<c010ca24>]  [<c010cc13>]  [<c010b658>]  [<c010d103>]  [<c01b7f74>]  [<c010cd18>]  [<c01b805e>]  [<c01b7f74>]  [<c01b8818>]  [<c01b8ca1>]  [<c01b8e4c>]  [<c01b8f1b>]  [<c01b9286>]  [<c01b6c4d>]  [<c01b6faf>]  [<c037cdaa>]  [<c037cf6a>]  [<c036c61e>]  [<c036c689>]  [<c010508f>]  [<c0105060>]  [<c0108a89>] 
> handlers:
> [<c01b7f74>]
> isapnp: Card 'Crystal CS4236B-104'
> isapnp: 1 Plug & Play card detected total
> PCI: Found IRQ 9 for device 00:08.0
> matroxfb: Matrox Mystique 220 (PCI) detected
> matroxfb: MTRR's turned on
> matroxfb: 640x480x8bpp (virtual: 640x3270)
> matroxfb: framebuffer at 0xFD800000, mapped to 0xca805000, size 2097152
> Console: switching to colour frame buffer device 80x30
> fb0: MATROX frame buffer device
> pty: 256 Unix98 ptys configured
> r3964: Philips r3964 Driver $Revision: 1.10 $
> Real Time Clock Driver v1.11
> Non-volatile memory driver v1.2
> Serial: 8250/16550 driver $Revision: 1.90 $ IRQ sharing enabled
> tts/0 at I/O 0x3f8 (irq = 4) is a 16550A
> tts/1 at I/O 0x2f8 (irq = 3) is a 16550A
> floppy0: no floppy controllers found
> RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
> loop: loaded (max 8 devices)
> Intel(R) PRO/100 Network Driver - version 2.2.21-k1
> Copyright (c) 2003 Intel Corporation
> 
> PCI: Found IRQ 10 for device 00:09.0
> PCI: Sharing IRQ 10 with 00:12.0
> Freeing alive device c9dfd000, eth%d
> e100: eth0: Intel(R) PRO/100 Network Connection
> 
> bonding.c:v2.5.65-20030320 (March 20, 2003)
> bonding_init(): either miimon or arp_interval and arp_ip_target module parameters must be specified, otherwise bonding will not detect link failures! see bonding.txt for details.
> bond0 registered without MII link monitoring, in load balancing (round-robin) mode.
> bond0 registered without ARP monitoring
> Equalizer2002: Simon Janes (simon@ncm.com) and David S. Miller (davem@redhat.com)
> Universal TUN/TAP device driver 1.5 (C)1999-2002 Maxim Krasnyansky
> Linux video capture interface: v1.00
> saa7146: register extension 'dvb'.
> PCI: Found IRQ 10 for device 00:12.0
> PCI: Sharing IRQ 10 with 00:09.0
> saa7146: found saa7146 @ mem 0xcb008c00 (revision 1, irq 10) (0x110a,0x0000).
> saa7146_vv: saa7146 (0): registered device video0 [v4l2]
> DVB: registering new adapter (Siemens cable card PCI rev1.5).
> drivers/media/dvb/frontends/ves1820.c: setup for tuner spXXXX
> DVB: registering frontend 0:0 (VES1820 based DVB-C frontend)...
> Unable to handle kernel NULL pointer dereference at virtual address 00000010
>  printing eip:
> c01ef979
> *pde = 00000000
> Oops: 0002 [#1]
> CPU:    0
> EIP:    0060:[<c01ef979>]    Not tainted
> EFLAGS: 00010206
> eax: 00000000   ebx: c9fc3e16   ecx: 00000000   edx: 08010000
> esi: c9e08024   edi: c9e08024   ebp: c0356720   esp: c9fc3de4
> ds: 007b   es: 007b   ss: 0068
> Process swapper (pid: 1, threadinfo=c9fc2000 task=c9fc0040)
> Stack: c9fc3e16 c9e08024 c030c0a0 c01f0057 c9e08024 00000001 00000000 c9fc3e16 
>        c9e08024 c9d259e0 c9e08204 c0356720 c01f0030 c9d25a00 c9e08024 c030c0a0 
>        c9e08000 00000003 c030c0e0 00000000 00000000 c0356880 00000000 09000000 
> Call Trace: [<c01f0057>]  [<c01f0030>]  [<c020197d>]  [<c020156c>]  [<c01ffbaa>]  [<c01ffd37>]  [<c01ffde0>]  [<c0209d6f>]  [<c0209bf0>]  [<c020c880>]  [<c020c963>]  [<c01b53f1>]  [<c01daa47>]  [<c01dab17>]  [<c01dada2>]  [<c01db145>]  [<c01b54ea>]  [<c020cc01>]  [<c038217a>]  [<c036c61e>]  [<c036c689>]  [<c010508f>]  [<c0105060>]  [<c0108a89>] 
> Code: 89 50 10 8b 47 58 66 8b 00 68 78 4f 01 00 e8 4c 3c fc ff 8b 
>  <0>Kernel panic: Fatal exception in interrupt
> In interrupt handler - not syncing
>  

