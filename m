Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267174AbSLEBSj>; Wed, 4 Dec 2002 20:18:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267173AbSLEBSj>; Wed, 4 Dec 2002 20:18:39 -0500
Received: from NODE1.HOSTING-NETWORK.COM ([66.186.193.1]:57618 "HELO
	unix113.hosting-network.com") by vger.kernel.org with SMTP
	id <S267175AbSLEBST>; Wed, 4 Dec 2002 20:18:19 -0500
X-Comments: BlackMail headers - Mail to abuse@featureprice.com to report spam.
X-Authenticated-Connect: 63.109.146.2
X-Authenticated-Timestamp: 20:28:31(EST) on December 04, 2002
X-HELO-From: [10.134.0.77]
X-Mail-From: <thoffman@arnor.net>
X-Sender-IP-Address: 63.109.146.2
Subject: Re: SiS framebuffer compile fail
From: Torrey Hoffman <thoffman@arnor.net>
To: Justin Pryzby <pryzbyj@clarkson.edu>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
       justinpryzby@users.sourceforge.net
In-Reply-To: <Pine.GSO.4.10.10211071728210.15392-200000@crux.clarkson.edu>
References: <Pine.GSO.4.10.10211071728210.15392-200000@crux.clarkson.edu>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 04 Dec 2002 17:28:15 -0800
Message-Id: <1039051697.9139.5.camel@rivendell.arnor.net>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I can confirm that the SIS framebuffer code still doesn't compile in
(vanilla) 2.5.50, my compile error looks the same as was reported below.

I have entered the problem into bugzilla.kernel.org...

Torrey Hoffman

On Thu, 2002-11-07 at 14:59, Justin Pryzby wrote:
> Vanilla 2.5.46 fails with:
> 
>  gcc -Wp,-MD,drivers/video/sis/.sis_main.o.d -D__KERNEL__ -Iinclude -Wall
> -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer
> -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2
> -march=athlon -Iarch/i386/mach-generic -nostdinc -iwithprefix include
> -DKBUILD_BASENAME=sis_main -DEXPORT_SYMTAB  -c -o
> drivers/video/sis/sis_main.o drivers/video/sis/sis_main.c
> In file included from drivers/video/sis/sis_main.c:57:
> drivers/video/sis/sis_main.h:299: parse error before "sisfbinfo"
> drivers/video/sis/sis_main.h:299: warning: type defaults to `int' in
> declaration of `sisfbinfo'
> drivers/video/sis/sis_main.h:299: warning: data definition has no type or
> storage class
> drivers/video/sis/sis_main.c: In function
> `sisfb_query_north_bridge_space':
> drivers/video/sis/sis_main.c:206: `SIS_650' undeclared (first use in this
> function)
> ...
> make[3]: *** [drivers/video/sis/sis_main.o] Error 1
> make[2]: *** [drivers/video/sis] Error 2
> make[1]: *** [drivers/video] Error 2
> make: *** [drivers] Error 2
> 
> I am running 'gcc version 3.2.1 20020924 (Debian prerelease)'.
> 
> Configuration file is attached.
> 
> I am not subscribed to the list, so please CC me on all responses.
> Send all responses to justinpryzby@users.sourceforge.net.
> 
> Also, I'm willing to try patches and can offer a test account if need be.
> 
> Justin Pryzby
> ----
> 

> #
> # Automatically generated make config: don't edit
> #
> CONFIG_X86=y
> CONFIG_MMU=y
> CONFIG_SWAP=y
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
> CONFIG_NET=y
> CONFIG_SYSVIPC=y
> CONFIG_BSD_PROCESS_ACCT=y
> CONFIG_SYSCTL=y
> 
> #
> # Loadable module support
> #
> CONFIG_MODULES=y
> CONFIG_MODVERSIONS=y
> CONFIG_KMOD=y
> 
> #
> # Processor type and features
> #
> # CONFIG_M386 is not set
> # CONFIG_M486 is not set
> # CONFIG_M586 is not set
> # CONFIG_M586TSC is not set
> # CONFIG_M586MMX is not set
> # CONFIG_M686 is not set
> # CONFIG_MPENTIUMIII is not set
> # CONFIG_MPENTIUM4 is not set
> # CONFIG_MK6 is not set
> CONFIG_MK7=y
> # CONFIG_MELAN is not set
> # CONFIG_MCRUSOE is not set
> # CONFIG_MWINCHIPC6 is not set
> # CONFIG_MWINCHIP2 is not set
> # CONFIG_MWINCHIP3D is not set
> # CONFIG_MCYRIXIII is not set
> CONFIG_X86_CMPXCHG=y
> CONFIG_X86_XADD=y
> CONFIG_X86_L1_CACHE_SHIFT=6
> CONFIG_RWSEM_XCHGADD_ALGORITHM=y
> CONFIG_X86_WP_WORKS_OK=y
> CONFIG_X86_INVLPG=y
> CONFIG_X86_BSWAP=y
> CONFIG_X86_POPAD_OK=y
> CONFIG_X86_TSC=y
> CONFIG_X86_GOOD_APIC=y
> CONFIG_X86_USE_PPRO_CHECKSUM=y
> CONFIG_X86_USE_3DNOW=y
> CONFIG_HUGETLB_PAGE=y
> # CONFIG_SMP is not set
> CONFIG_PREEMPT=y
> CONFIG_X86_UP_APIC=y
> CONFIG_X86_UP_IOAPIC=y
> CONFIG_X86_LOCAL_APIC=y
> CONFIG_X86_IO_APIC=y
> CONFIG_X86_MCE=y
> CONFIG_X86_MCE_NONFATAL=y
> # CONFIG_X86_MCE_P4THERMAL is not set
> # CONFIG_CPU_FREQ is not set
> # CONFIG_TOSHIBA is not set
> # CONFIG_I8K is not set
> CONFIG_MICROCODE=y
> CONFIG_X86_MSR=y
> CONFIG_X86_CPUID=y
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
> 
> #
> # ACPI Support
> #
> CONFIG_ACPI=y
> # CONFIG_ACPI_HT_ONLY is not set
> CONFIG_ACPI_BOOT=y
> CONFIG_ACPI_SLEEP=y
> CONFIG_ACPI_AC=y
> CONFIG_ACPI_BATTERY=y
> CONFIG_ACPI_BUTTON=y
> CONFIG_ACPI_FAN=y
> CONFIG_ACPI_PROCESSOR=y
> CONFIG_ACPI_THERMAL=y
> # CONFIG_ACPI_TOSHIBA is not set
> # CONFIG_ACPI_DEBUG is not set
> CONFIG_ACPI_BUS=y
> CONFIG_ACPI_INTERPRETER=y
> CONFIG_ACPI_EC=y
> CONFIG_ACPI_POWER=y
> CONFIG_ACPI_PCI=y
> CONFIG_ACPI_SYSTEM=y
> CONFIG_PM=y
> CONFIG_APM=y
> # CONFIG_APM_IGNORE_USER_SUSPEND is not set
> # CONFIG_APM_DO_ENABLE is not set
> CONFIG_APM_CPU_IDLE=y
> CONFIG_APM_DISPLAY_BLANK=y
> CONFIG_APM_RTC_IS_GMT=y
> # CONFIG_APM_ALLOW_INTS is not set
> # CONFIG_APM_REAL_MODE_POWER_OFF is not set
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
> CONFIG_PCI_NAMES=y
> # CONFIG_ISA is not set
> # CONFIG_MCA is not set
> CONFIG_HOTPLUG=y
> 
> #
> # PCMCIA/CardBus support
> #
> # CONFIG_PCMCIA is not set
> 
> #
> # PCI Hotplug Support
> #
> # CONFIG_HOTPLUG_PCI is not set
> 
> #
> # Executable file formats
> #
> CONFIG_KCORE_ELF=y
> # CONFIG_KCORE_AOUT is not set
> # CONFIG_BINFMT_AOUT is not set
> CONFIG_BINFMT_ELF=y
> # CONFIG_BINFMT_MISC is not set
> 
> #
> # Memory Technology Devices (MTD)
> #
> # CONFIG_MTD is not set
> 
> #
> # Parallel port support
> #
> CONFIG_PARPORT=y
> CONFIG_PARPORT_PC=y
> CONFIG_PARPORT_PC_CML1=y
> # CONFIG_PARPORT_SERIAL is not set
> CONFIG_PARPORT_PC_FIFO=y
> CONFIG_PARPORT_PC_SUPERIO=y
> # CONFIG_PARPORT_OTHER is not set
> CONFIG_PARPORT_1284=y
> 
> #
> # Plug and Play configuration
> #
> # CONFIG_PNP is not set
> 
> #
> # Block devices
> #
> CONFIG_BLK_DEV_FD=y
> # CONFIG_PARIDE is not set
> # CONFIG_BLK_CPQ_DA is not set
> # CONFIG_BLK_CPQ_CISS_DA is not set
> # CONFIG_BLK_DEV_DAC960 is not set
> # CONFIG_BLK_DEV_UMEM is not set
> CONFIG_BLK_DEV_LOOP=y
> CONFIG_BLK_DEV_NBD=y
> # CONFIG_BLK_DEV_RAM is not set
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
> # CONFIG_IDEDISK_MULTI_MODE is not set
> # CONFIG_IDEDISK_STROKE is not set
> CONFIG_BLK_DEV_IDECD=y
> # CONFIG_BLK_DEV_IDEFLOPPY is not set
> # CONFIG_IDE_TASK_IOCTL is not set
> 
> #
> # IDE chipset support/bugfixes
> #
> # CONFIG_BLK_DEV_CMD640 is not set
> CONFIG_BLK_DEV_IDEPCI=y
> CONFIG_BLK_DEV_GENERIC=y
> CONFIG_IDEPCI_SHARE_IRQ=y
> CONFIG_BLK_DEV_IDEDMA_PCI=y
> CONFIG_BLK_DEV_IDE_TCQ=y
> CONFIG_BLK_DEV_IDE_TCQ_DEFAULT=y
> CONFIG_BLK_DEV_IDE_TCQ_DEPTH=8
> # CONFIG_BLK_DEV_OFFBOARD is not set
> # CONFIG_BLK_DEV_IDEDMA_FORCED is not set
> CONFIG_IDEDMA_PCI_AUTO=y
> # CONFIG_IDEDMA_ONLYDISK is not set
> CONFIG_BLK_DEV_IDEDMA=y
> # CONFIG_IDEDMA_PCI_WIP is not set
> CONFIG_BLK_DEV_ADMA=y
> # CONFIG_BLK_DEV_AEC62XX is not set
> # CONFIG_BLK_DEV_ALI15X3 is not set
> # CONFIG_BLK_DEV_AMD74XX is not set
> # CONFIG_BLK_DEV_CMD64X is not set
> # CONFIG_BLK_DEV_CY82C693 is not set
> # CONFIG_BLK_DEV_CS5530 is not set
> # CONFIG_BLK_DEV_HPT34X is not set
> # CONFIG_BLK_DEV_HPT366 is not set
> CONFIG_BLK_DEV_PIIX=y
> # CONFIG_BLK_DEV_NFORCE is not set
> # CONFIG_BLK_DEV_NS87415 is not set
> # CONFIG_BLK_DEV_OPTI621 is not set
> # CONFIG_BLK_DEV_PDC202XX_OLD is not set
> # CONFIG_BLK_DEV_PDC202XX_NEW is not set
> # CONFIG_BLK_DEV_RZ1000 is not set
> # CONFIG_BLK_DEV_SVWKS is not set
> # CONFIG_BLK_DEV_SIIMAGE is not set
> CONFIG_BLK_DEV_SIS5513=y
> # CONFIG_BLK_DEV_SLC90E66 is not set
> # CONFIG_BLK_DEV_TRM290 is not set
> # CONFIG_BLK_DEV_VIA82CXXX is not set
> CONFIG_IDEDMA_AUTO=y
> # CONFIG_IDEDMA_IVB is not set
> CONFIG_BLK_DEV_IDE_MODES=y
> 
> #
> # SCSI device support
> #
> # CONFIG_SCSI is not set
> 
> #
> # Multi-device support (RAID and LVM)
> #
> # CONFIG_MD is not set
> 
> #
> # Fusion MPT device support
> #
> 
> #
> # IEEE 1394 (FireWire) support (EXPERIMENTAL)
> #
> # CONFIG_IEEE1394 is not set
> 
> #
> # I2O device support
> #
> # CONFIG_I2O is not set
> 
> #
> # Networking options
> #
> CONFIG_PACKET=y
> CONFIG_PACKET_MMAP=y
> CONFIG_NETLINK_DEV=y
> CONFIG_NETFILTER=y
> # CONFIG_NETFILTER_DEBUG is not set
> # CONFIG_FILTER is not set
> CONFIG_UNIX=y
> CONFIG_INET=y
> CONFIG_IP_MULTICAST=y
> # CONFIG_IP_ADVANCED_ROUTER is not set
> # CONFIG_IP_PNP is not set
> # CONFIG_NET_IPIP is not set
> # CONFIG_NET_IPGRE is not set
> # CONFIG_IP_MROUTE is not set
> # CONFIG_ARPD is not set
> CONFIG_INET_ECN=y
> CONFIG_SYN_COOKIES=y
> 
> #
> # IP: Netfilter Configuration
> #
> CONFIG_IP_NF_CONNTRACK=y
> CONFIG_IP_NF_FTP=y
> CONFIG_IP_NF_IRC=y
> # CONFIG_IP_NF_QUEUE is not set
> CONFIG_IP_NF_IPTABLES=y
> CONFIG_IP_NF_MATCH_LIMIT=y
> CONFIG_IP_NF_MATCH_MAC=y
> CONFIG_IP_NF_MATCH_PKTTYPE=y
> CONFIG_IP_NF_MATCH_MARK=y
> CONFIG_IP_NF_MATCH_MULTIPORT=y
> CONFIG_IP_NF_MATCH_TOS=y
> CONFIG_IP_NF_MATCH_ECN=y
> CONFIG_IP_NF_MATCH_DSCP=y
> CONFIG_IP_NF_MATCH_AH_ESP=y
> CONFIG_IP_NF_MATCH_LENGTH=y
> CONFIG_IP_NF_MATCH_TTL=y
> CONFIG_IP_NF_MATCH_TCPMSS=y
> CONFIG_IP_NF_MATCH_HELPER=y
> CONFIG_IP_NF_MATCH_STATE=y
> CONFIG_IP_NF_MATCH_CONNTRACK=y
> CONFIG_IP_NF_MATCH_UNCLEAN=y
> CONFIG_IP_NF_MATCH_OWNER=y
> CONFIG_IP_NF_FILTER=y
> CONFIG_IP_NF_TARGET_REJECT=y
> CONFIG_IP_NF_TARGET_MIRROR=y
> CONFIG_IP_NF_NAT=y
> CONFIG_IP_NF_NAT_NEEDED=y
> CONFIG_IP_NF_TARGET_MASQUERADE=y
> CONFIG_IP_NF_TARGET_REDIRECT=y
> CONFIG_IP_NF_NAT_LOCAL=y
> CONFIG_IP_NF_NAT_SNMP_BASIC=y
> CONFIG_IP_NF_NAT_IRC=y
> CONFIG_IP_NF_NAT_FTP=y
> CONFIG_IP_NF_MANGLE=y
> CONFIG_IP_NF_TARGET_TOS=y
> CONFIG_IP_NF_TARGET_ECN=y
> CONFIG_IP_NF_TARGET_DSCP=y
> CONFIG_IP_NF_TARGET_MARK=y
> CONFIG_IP_NF_TARGET_LOG=y
> CONFIG_IP_NF_TARGET_ULOG=y
> # CONFIG_IP_NF_TARGET_TCPMSS is not set
> # CONFIG_IP_NF_ARPTABLES is not set
> # CONFIG_IPV6 is not set
> 
> #
> # SCTP Configuration (EXPERIMENTAL)
> #
> CONFIG_IPV6_SCTP__=y
> # CONFIG_IP_SCTP is not set
> # CONFIG_ATM is not set
> # CONFIG_VLAN_8021Q is not set
> # CONFIG_LLC is not set
> # CONFIG_DECNET is not set
> # CONFIG_BRIDGE is not set
> # CONFIG_X25 is not set
> # CONFIG_LAPB is not set
> # CONFIG_NET_DIVERT is not set
> # CONFIG_ECONET is not set
> # CONFIG_WAN_ROUTER is not set
> # CONFIG_NET_FASTROUTE is not set
> # CONFIG_NET_HW_FLOWCONTROL is not set
> 
> #
> # QoS and/or fair queueing
> #
> # CONFIG_NET_SCHED is not set
> 
> #
> # Network device support
> #
> CONFIG_NETDEVICES=y
> 
> #
> # ARCnet devices
> #
> # CONFIG_ARCNET is not set
> # CONFIG_DUMMY is not set
> # CONFIG_BONDING is not set
> # CONFIG_EQUALIZER is not set
> # CONFIG_TUN is not set
> # CONFIG_ETHERTAP is not set
> 
> #
> # Ethernet (10 or 100Mbit)
> #
> CONFIG_NET_ETHERNET=y
> # CONFIG_HAPPYMEAL is not set
> # CONFIG_SUNGEM is not set
> CONFIG_NET_VENDOR_3COM=y
> CONFIG_VORTEX=y
> # CONFIG_NET_VENDOR_SMC is not set
> # CONFIG_NET_VENDOR_RACAL is not set
> 
> #
> # Tulip family network device support
> #
> # CONFIG_NET_TULIP is not set
> # CONFIG_HP100 is not set
> CONFIG_NET_PCI=y
> # CONFIG_PCNET32 is not set
> # CONFIG_ADAPTEC_STARFIRE is not set
> # CONFIG_DGRS is not set
> # CONFIG_EEPRO100 is not set
> # CONFIG_E100 is not set
> # CONFIG_FEALNX is not set
> # CONFIG_NATSEMI is not set
> # CONFIG_NE2K_PCI is not set
> # CONFIG_8139CP is not set
> CONFIG_8139TOO=y
> # CONFIG_8139TOO_PIO is not set
> # CONFIG_8139TOO_TUNE_TWISTER is not set
> # CONFIG_8139TOO_8129 is not set
> # CONFIG_8139_OLD_RX_RESET is not set
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
> # CONFIG_SK98LIN is not set
> # CONFIG_TIGON3 is not set
> # CONFIG_FDDI is not set
> # CONFIG_HIPPI is not set
> # CONFIG_PLIP is not set
> # CONFIG_PPP is not set
> # CONFIG_SLIP is not set
> 
> #
> # Wireless LAN (non-hamradio)
> #
> # CONFIG_NET_RADIO is not set
> 
> #
> # Token Ring devices
> #
> # CONFIG_TR is not set
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
> CONFIG_INPUT_EVDEV=y
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
> # CONFIG_INPUT_JOYSTICK is not set
> # CONFIG_INPUT_TOUCHSCREEN is not set
> CONFIG_INPUT_MISC=y
> CONFIG_INPUT_PCSPKR=y
> CONFIG_INPUT_UINPUT=y
> 
> #
> # Character devices
> #
> CONFIG_VT=y
> CONFIG_VT_CONSOLE=y
> CONFIG_HW_CONSOLE=y
> # CONFIG_SERIAL_NONSTANDARD is not set
> 
> #
> # Serial drivers
> #
> CONFIG_SERIAL_8250=y
> # CONFIG_SERIAL_8250_CONSOLE is not set
> CONFIG_SERIAL_8250_EXTENDED=y
> # CONFIG_SERIAL_8250_MANY_PORTS is not set
> CONFIG_SERIAL_8250_SHARE_IRQ=y
> # CONFIG_SERIAL_8250_DETECT_IRQ is not set
> # CONFIG_SERIAL_8250_MULTIPORT is not set
> # CONFIG_SERIAL_8250_RSA is not set
> 
> #
> # Non-8250 serial port support
> #
> CONFIG_SERIAL_CORE=y
> CONFIG_UNIX98_PTYS=y
> CONFIG_UNIX98_PTY_COUNT=256
> CONFIG_PRINTER=y
> # CONFIG_LP_CONSOLE is not set
> # CONFIG_PPDEV is not set
> CONFIG_TIPAR=y
> 
> #
> # I2C support
> #
> # CONFIG_I2C is not set
> 
> #
> # Mice
> #
> # CONFIG_BUSMOUSE is not set
> # CONFIG_QIC02_TAPE is not set
> 
> #
> # Watchdog Cards
> #
> # CONFIG_WATCHDOG is not set
> CONFIG_INTEL_RNG=y
> # CONFIG_AMD_RNG is not set
> CONFIG_NVRAM=y
> # CONFIG_RTC is not set
> CONFIG_GEN_RTC=y
> CONFIG_GEN_RTC_X=y
> # CONFIG_DTLK is not set
> # CONFIG_R3964 is not set
> # CONFIG_APPLICOM is not set
> # CONFIG_SONYPI is not set
> 
> #
> # Ftape, the floppy tape device driver
> #
> # CONFIG_FTAPE is not set
> CONFIG_AGP=y
> # CONFIG_AGP_INTEL is not set
> CONFIG_AGP_I810=y
> # CONFIG_AGP_VIA is not set
> # CONFIG_AGP_AMD is not set
> CONFIG_AGP_SIS=y
> # CONFIG_AGP_ALI is not set
> # CONFIG_AGP_SWORKS is not set
> # CONFIG_AGP_AMD_8151 is not set
> CONFIG_DRM=y
> # CONFIG_DRM_TDFX is not set
> # CONFIG_DRM_R128 is not set
> # CONFIG_DRM_RADEON is not set
> CONFIG_DRM_I810=y
> # CONFIG_DRM_I830 is not set
> # CONFIG_DRM_MGA is not set
> # CONFIG_MWAVE is not set
> # CONFIG_RAW_DRIVER is not set
> 
> #
> # Multimedia devices
> #
> # CONFIG_VIDEO_DEV is not set
> 
> #
> # File systems
> #
> CONFIG_QUOTA=y
> # CONFIG_QFMT_V1 is not set
> CONFIG_QFMT_V2=y
> CONFIG_QUOTACTL=y
> # CONFIG_AUTOFS_FS is not set
> # CONFIG_AUTOFS4_FS is not set
> # CONFIG_REISERFS_FS is not set
> # CONFIG_ADFS_FS is not set
> # CONFIG_AFFS_FS is not set
> # CONFIG_HFS_FS is not set
> # CONFIG_BEFS_FS is not set
> # CONFIG_BFS_FS is not set
> CONFIG_EXT3_FS=y
> CONFIG_EXT3_FS_XATTR=y
> CONFIG_EXT3_FS_POSIX_ACL=y
> CONFIG_JBD=y
> # CONFIG_JBD_DEBUG is not set
> CONFIG_FAT_FS=y
> CONFIG_MSDOS_FS=y
> CONFIG_VFAT_FS=y
> # CONFIG_EFS_FS is not set
> # CONFIG_CRAMFS is not set
> # CONFIG_TMPFS is not set
> CONFIG_RAMFS=y
> # CONFIG_HUGETLBFS is not set
> CONFIG_ISO9660_FS=y
> CONFIG_JOLIET=y
> CONFIG_ZISOFS=y
> # CONFIG_JFS_FS is not set
> # CONFIG_MINIX_FS is not set
> # CONFIG_VXFS_FS is not set
> CONFIG_NTFS_FS=y
> # CONFIG_NTFS_DEBUG is not set
> # CONFIG_NTFS_RW is not set
> # CONFIG_HPFS_FS is not set
> CONFIG_PROC_FS=y
> CONFIG_DEVFS_FS=y
> CONFIG_DEVFS_MOUNT=y
> # CONFIG_DEVFS_DEBUG is not set
> CONFIG_DEVPTS_FS=y
> # CONFIG_QNX4FS_FS is not set
> # CONFIG_ROMFS_FS is not set
> CONFIG_EXT2_FS=y
> CONFIG_EXT2_FS_XATTR=y
> CONFIG_EXT2_FS_POSIX_ACL=y
> # CONFIG_SYSV_FS is not set
> CONFIG_UDF_FS=y
> # CONFIG_UDF_RW is not set
> # CONFIG_UFS_FS is not set
> # CONFIG_XFS_FS is not set
> 
> #
> # Network File Systems
> #
> # CONFIG_CODA_FS is not set
> # CONFIG_INTERMEZZO_FS is not set
> CONFIG_NFS_FS=y
> CONFIG_NFS_V3=y
> CONFIG_NFS_V4=y
> CONFIG_NFSD=y
> CONFIG_NFSD_V3=y
> # CONFIG_NFSD_V4 is not set
> CONFIG_NFSD_TCP=y
> CONFIG_SUNRPC=y
> CONFIG_LOCKD=y
> CONFIG_LOCKD_V4=y
> CONFIG_EXPORTFS=y
> CONFIG_CIFS=y
> CONFIG_SMB_FS=y
> # CONFIG_SMB_NLS_DEFAULT is not set
> # CONFIG_NCP_FS is not set
> # CONFIG_AFS_FS is not set
> CONFIG_ZISOFS_FS=y
> CONFIG_FS_MBCACHE=y
> CONFIG_FS_POSIX_ACL=y
> 
> #
> # Partition Types
> #
> # CONFIG_PARTITION_ADVANCED is not set
> CONFIG_MSDOS_PARTITION=y
> CONFIG_SMB_NLS=y
> CONFIG_NLS=y
> 
> #
> # Native Language Support
> #
> CONFIG_NLS_DEFAULT="iso8859-1"
> CONFIG_NLS_CODEPAGE_437=y
> # CONFIG_NLS_CODEPAGE_737 is not set
> # CONFIG_NLS_CODEPAGE_775 is not set
> # CONFIG_NLS_CODEPAGE_850 is not set
> # CONFIG_NLS_CODEPAGE_852 is not set
> # CONFIG_NLS_CODEPAGE_855 is not set
> # CONFIG_NLS_CODEPAGE_857 is not set
> # CONFIG_NLS_CODEPAGE_860 is not set
> # CONFIG_NLS_CODEPAGE_861 is not set
> # CONFIG_NLS_CODEPAGE_862 is not set
> # CONFIG_NLS_CODEPAGE_863 is not set
> # CONFIG_NLS_CODEPAGE_864 is not set
> # CONFIG_NLS_CODEPAGE_865 is not set
> # CONFIG_NLS_CODEPAGE_866 is not set
> # CONFIG_NLS_CODEPAGE_869 is not set
> # CONFIG_NLS_CODEPAGE_936 is not set
> # CONFIG_NLS_CODEPAGE_950 is not set
> # CONFIG_NLS_CODEPAGE_932 is not set
> # CONFIG_NLS_CODEPAGE_949 is not set
> # CONFIG_NLS_CODEPAGE_874 is not set
> # CONFIG_NLS_ISO8859_8 is not set
> # CONFIG_NLS_CODEPAGE_1250 is not set
> # CONFIG_NLS_CODEPAGE_1251 is not set
> CONFIG_NLS_ISO8859_1=y
> # CONFIG_NLS_ISO8859_2 is not set
> # CONFIG_NLS_ISO8859_3 is not set
> # CONFIG_NLS_ISO8859_4 is not set
> # CONFIG_NLS_ISO8859_5 is not set
> # CONFIG_NLS_ISO8859_6 is not set
> # CONFIG_NLS_ISO8859_7 is not set
> # CONFIG_NLS_ISO8859_9 is not set
> # CONFIG_NLS_ISO8859_13 is not set
> # CONFIG_NLS_ISO8859_14 is not set
> # CONFIG_NLS_ISO8859_15 is not set
> # CONFIG_NLS_KOI8_R is not set
> # CONFIG_NLS_KOI8_U is not set
> CONFIG_NLS_UTF8=y
> 
> #
> # Console drivers
> #
> CONFIG_VGA_CONSOLE=y
> # CONFIG_VIDEO_SELECT is not set
> # CONFIG_MDA_CONSOLE is not set
> 
> #
> # Frame-buffer support
> #
> CONFIG_FB=y
> CONFIG_DUMMY_CONSOLE=y
> # CONFIG_FB_CLGEN is not set
> # CONFIG_FB_PM2 is not set
> # CONFIG_FB_CYBER2000 is not set
> # CONFIG_FB_ATY is not set
> # CONFIG_FB_VGA16 is not set
> CONFIG_FB_VESA=y
> # CONFIG_FB_HGA is not set
> # CONFIG_FB_RIVA is not set
> # CONFIG_FB_MATROX is not set
> # CONFIG_FB_RADEON is not set
> # CONFIG_FB_ATY128 is not set
> CONFIG_FB_SIS=y
> CONFIG_FB_SIS_300=y
> # CONFIG_FB_SIS_315 is not set
> # CONFIG_FB_NEOMAGIC is not set
> # CONFIG_FB_3DFX is not set
> # CONFIG_FB_VOODOO1 is not set
> # CONFIG_FB_TRIDENT is not set
> # CONFIG_FB_PM3 is not set
> # CONFIG_FB_VIRTUAL is not set
> # CONFIG_FBCON_ADVANCED is not set
> CONFIG_FBCON_CFB8=y
> CONFIG_FBCON_CFB16=y
> CONFIG_FBCON_CFB24=y
> CONFIG_FBCON_CFB32=y
> CONFIG_FBCON_ACCEL=y
> # CONFIG_FBCON_FONTWIDTH8_ONLY is not set
> # CONFIG_FBCON_FONTS is not set
> CONFIG_FONT_8x8=y
> CONFIG_FONT_8x16=y
> 
> #
> # Sound
> #
> CONFIG_SOUND=y
> 
> #
> # Open Sound System
> #
> CONFIG_SOUND_PRIME=y
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
> CONFIG_SOUND_TRIDENT=y
> # CONFIG_SOUND_MSNDCLAS is not set
> # CONFIG_SOUND_MSNDPIN is not set
> # CONFIG_SOUND_VIA82CXXX is not set
> # CONFIG_SOUND_OSS is not set
> 
> #
> # Advanced Linux Sound Architecture
> #
> # CONFIG_SND is not set
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
> CONFIG_PROFILING=y
> CONFIG_OPROFILE=y
> 
> #
> # Kernel hacking
> #
> CONFIG_SOFTWARE_SUSPEND=y
> CONFIG_DEBUG_KERNEL=y
> # CONFIG_DEBUG_STACKOVERFLOW is not set
> CONFIG_DEBUG_SLAB=y
> CONFIG_DEBUG_IOVIRT=y
> CONFIG_MAGIC_SYSRQ=y
> CONFIG_DEBUG_SPINLOCK=y
> CONFIG_KALLSYMS=y
> CONFIG_X86_EXTRA_IRQS=y
> CONFIG_X86_FIND_SMP_CONFIG=y
> CONFIG_X86_MPPARSE=y
> 
> #
> # Security options
> #
> CONFIG_SECURITY_CAPABILITIES=y
> 
> #
> # Cryptographic options
> #
> CONFIG_CRYPTO=y
> CONFIG_CRYPTO_MD4=y
> CONFIG_CRYPTO_MD5=y
> CONFIG_CRYPTO_SHA1=y
> CONFIG_CRYPTO_DES=y
> CONFIG_CRYPTO_TEST=y
> 
> #
> # Library routines
> #
> # CONFIG_CRC32 is not set
> CONFIG_ZLIB_INFLATE=y
> CONFIG_X86_BIOS_REBOOT=y


