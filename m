Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265678AbUATSej (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jan 2004 13:34:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265681AbUATSei
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jan 2004 13:34:38 -0500
Received: from dsl093-006-028.det1.dsl.speakeasy.net ([66.93.6.28]:12990 "EHLO
	nabmail01.northamericanbancard.com") by vger.kernel.org with ESMTP
	id S265678AbUATSc7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jan 2004 13:32:59 -0500
Message-ID: <400D7459.8000300@chartermi.net>
Date: Tue, 20 Jan 2004 13:32:57 -0500
From: Chris Scheib <schweeb@chartermi.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031221 Thunderbird/0.4
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Problem: 2.6.1-mm4/5 ACPI ut_allocate error on Dell Inspiron 8200
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    I recently noticed a problem with ACPI when I patched my kernel to 
-mm4 or -mm5.  Upon initialization of ACPI, I repeatedly get the error 
"-0091: *** Error: ut_allocate: Attempt to allocate zero bytes".  After 
the kernel is loaded, I am not able to retrieve any battery stats.  When 
I try to look at the battery stats, it repeats the ut_allocate error 
again.  After googling, I discovered that turning on Relaxed AML 
Checking might fix this.  After a recompile, I found out it didn't.  I 
have had no problems with ACPI up until -mm4 and -mm5, vanilla 2.6.1 and 
under work fine.

    Please include me in any replies, as I am not subscribed to LKML 
(although I do read the archives @MARC).  If you need more information 
about my hardware, or output from any commands, just ask.

Thanks,
Christopher J. Scheib
schweeb@chartermi.net

System Info:

    Dell Inspiron 8200
    1.7Ghz P4-M
    640Mb SO-DIMM DDR RAM
    NVIDIA GeForce4 440-Go 64Mb
    40Gb HDD
    Debian Sid


Here's dmesg output, with a few events surrounding what occurred:

    USB Mass Storage support registered.
    XFS mounting filesystem hda2
    Ending clean XFS mount for filesystem: hda2
    XFS mounting filesystem hda6
    Ending clean XFS mount for filesystem: hda6
    ACPI: AC Adapter [AC] (on-line)
    ACPI: Battery Slot [BAT0] (battery present)
            -0091: *** Error: ut_allocate: Attempt to allocate zero bytes
            -0091: *** Error: ut_allocate: Attempt to allocate zero bytes
            -0091: *** Error: ut_allocate: Attempt to allocate zero bytes
            -0091: *** Error: ut_allocate: Attempt to allocate zero bytes
    ACPI: Battery Slot [BAT1] (battery present)
    ACPI: Lid Switch [LID]
    ACPI: Power Button (CM) [PBTN]
    ACPI: Sleep Button (CM) [SBTN]
    ACPI: Processor [CPU0] (supports C1 C2, 8 throttling states)
    ACPI: Thermal Zone [THM] (25 C)
    PCI: Setting latency timer of device 0000:00:1f.5 to 64
    MC'97 1 converters and GPIO not ready (0xff00)

Here is my kernel .config:

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
    CONFIG_BSD_PROCESS_ACCT=y
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
    CONFIG_IOSCHED_CFQ=y
    # CONFIG_CC_OPTIMIZE_FOR_SIZE is not set

    #
    # Loadable module support
    #
    CONFIG_MODULES=y
    CONFIG_MODULE_UNLOAD=y
    # CONFIG_MODULE_FORCE_UNLOAD is not set
    CONFIG_OBSOLETE_MODPARM=y
    # CONFIG_MODVERSIONS is not set
    CONFIG_KMOD=y

    #
    # Processor type and features
    #
    CONFIG_X86_PC=y
    # CONFIG_X86_ELAN is not set
    # CONFIG_X86_VOYAGER is not set
    # CONFIG_X86_NUMAQ is not set
    # CONFIG_X86_SUMMIT is not set
    # CONFIG_X86_BIGSMP is not set
    # CONFIG_X86_VISWS is not set
    # CONFIG_X86_GENERICARCH is not set
    # CONFIG_X86_ES7000 is not set

    #
    # Processor support
    #

    #
    # Select all processors your kernel should support
    #
    # CONFIG_CPU_386 is not set
    # CONFIG_CPU_486 is not set
    # CONFIG_CPU_586 is not set
    # CONFIG_CPU_586TSC is not set
    # CONFIG_CPU_586MMX is not set
    # CONFIG_CPU_686 is not set
    # CONFIG_CPU_PENTIUMII is not set
    # CONFIG_CPU_PENTIUMIII is not set
    # CONFIG_CPU_PENTIUMM is not set
    CONFIG_CPU_PENTIUM4=y
    # CONFIG_CPU_K6 is not set
    # CONFIG_CPU_K7 is not set
    # CONFIG_CPU_K8 is not set
    # CONFIG_CPU_CRUSOE is not set
    # CONFIG_CPU_WINCHIPC6 is not set
    # CONFIG_CPU_WINCHIP2 is not set
    # CONFIG_CPU_WINCHIP3D is not set
    # CONFIG_CPU_CYRIXIII is not set
    # CONFIG_CPU_VIAC3_2 is not set
    CONFIG_CPU_INTEL=y
    CONFIG_X86_CMPXCHG=y
    CONFIG_X86_XADD=y
    CONFIG_X86_L1_CACHE_SHIFT=7
    CONFIG_RWSEM_XCHGADD_ALGORITHM=y
    CONFIG_X86_WP_WORKS_OK=y
    CONFIG_X86_INVLPG=y
    CONFIG_X86_BSWAP=y
    CONFIG_X86_POPAD_OK=y
    CONFIG_X86_INTEL_USERCOPY=y
    CONFIG_X86_USE_PPRO_CHECKSUM=y
    # CONFIG_X86_4G is not set
    # CONFIG_X86_SWITCH_PAGETABLES is not set
    # CONFIG_X86_4G_VM_LAYOUT is not set
    # CONFIG_X86_UACCESS_INDIRECT is not set
    # CONFIG_X86_HIGH_ENTRY is not set
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
    CONFIG_X86_MCE_NONFATAL=y
    CONFIG_X86_MCE_P4THERMAL=y
    # CONFIG_TOSHIBA is not set
    CONFIG_I8K=m
    CONFIG_MICROCODE=m
    # CONFIG_X86_MSR is not set
    CONFIG_X86_CPUID=m
    # CONFIG_EDD is not set
    CONFIG_NOHIGHMEM=y
    # CONFIG_HIGHMEM4G is not set
    # CONFIG_HIGHMEM64G is not set
    # CONFIG_MATH_EMULATION is not set
    CONFIG_MTRR=y
    # CONFIG_EFI is not set
    CONFIG_HAVE_DEC_LOCK=y
    # CONFIG_REGPARM is not set

    #
    # Power management options (ACPI, APM)
    #
    CONFIG_PM=y
    CONFIG_SOFTWARE_SUSPEND=y
    # CONFIG_PM_DISK is not set

    #
    # ACPI (Advanced Configuration and Power Interface) Support
    #
    CONFIG_ACPI=y
    CONFIG_ACPI_BOOT=y
    CONFIG_ACPI_INTERPRETER=y
    # CONFIG_ACPI_SLEEP is not set
    CONFIG_ACPI_AC=m
    CONFIG_ACPI_BATTERY=m
    CONFIG_ACPI_BUTTON=m
    CONFIG_ACPI_FAN=m
    CONFIG_ACPI_PROCESSOR=m
    CONFIG_ACPI_THERMAL=m
    # CONFIG_ACPI_ASUS is not set
    # CONFIG_ACPI_TOSHIBA is not set
    # CONFIG_ACPI_DEBUG is not set
    CONFIG_ACPI_BUS=y
    CONFIG_ACPI_EC=y
    CONFIG_ACPI_POWER=y
    CONFIG_ACPI_PCI=y
    CONFIG_ACPI_SYSTEM=y
    CONFIG_ACPI_RELAXED_AML=y
    CONFIG_X86_PM_TIMER=y

    #
    # APM (Advanced Power Management) BIOS Support
    #
    # CONFIG_APM is not set

    #
    # CPU Frequency scaling
    #
    CONFIG_CPU_FREQ=y
    CONFIG_CPU_FREQ_PROC_INTF=m
    CONFIG_CPU_FREQ_DEFAULT_GOV_PERFORMANCE=y
    # CONFIG_CPU_FREQ_DEFAULT_GOV_USERSPACE is not set
    CONFIG_CPU_FREQ_GOV_PERFORMANCE=y
    CONFIG_CPU_FREQ_GOV_POWERSAVE=y
    CONFIG_CPU_FREQ_GOV_USERSPACE=m
    CONFIG_CPU_FREQ_24_API=y
    CONFIG_CPU_FREQ_TABLE=y

    #
    # CPUFreq processor drivers
    #
    CONFIG_X86_ACPI_CPUFREQ=m
    # CONFIG_X86_ACPI_CPUFREQ_PROC_INTF is not set
    # CONFIG_X86_POWERNOW_K6 is not set
    # CONFIG_X86_POWERNOW_K7 is not set
    # CONFIG_X86_POWERNOW_K8 is not set
    # CONFIG_X86_GX_SUSPMOD is not set
    # CONFIG_X86_SPEEDSTEP_CENTRINO is not set
    CONFIG_X86_SPEEDSTEP_ICH=y
    # CONFIG_X86_SPEEDSTEP_SMI is not set
    # CONFIG_X86_P4_CLOCKMOD is not set
    CONFIG_X86_SPEEDSTEP_LIB=y
    # CONFIG_X86_LONGRUN is not set
    # CONFIG_X86_LONGHAUL is not set

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
    CONFIG_PCMCIA=m
    # CONFIG_PCMCIA_COMPAT is not set
    CONFIG_YENTA=m
    CONFIG_CARDBUS=y
    # CONFIG_I82092 is not set
    # CONFIG_I82365 is not set
    # CONFIG_TCIC is not set
    CONFIG_PCMCIA_PROBE=y

    #
    # PCI Hotplug Support
    #
    # CONFIG_HOTPLUG_PCI is not set

    #
    # Executable file formats
    #
    CONFIG_BINFMT_ELF=y
    CONFIG_BINFMT_AOUT=m
    CONFIG_BINFMT_MISC=m

    #
    # Device Drivers
    #

    #
    # Generic Driver Options
    #
    CONFIG_FW_LOADER=y

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
    CONFIG_PNP=y
    # CONFIG_PNP_DEBUG is not set

    #
    # Protocols
    #
    # CONFIG_ISAPNP is not set
    CONFIG_PNPBIOS=y
    # CONFIG_PNPBIOS_PROC_FS is not set

    #
    # Block devices
    #
    CONFIG_BLK_DEV_FD=m
    # CONFIG_BLK_DEV_XD is not set
    # CONFIG_BLK_CPQ_DA is not set
    # CONFIG_BLK_CPQ_CISS_DA is not set
    # CONFIG_BLK_DEV_DAC960 is not set
    # CONFIG_BLK_DEV_UMEM is not set
    CONFIG_BLK_DEV_LOOP=y
    # CONFIG_BLK_DEV_CRYPTOLOOP is not set
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
    # CONFIG_IDEDISK_MULTI_MODE is not set
    # CONFIG_IDEDISK_STROKE is not set
    # CONFIG_BLK_DEV_IDECS is not set
    CONFIG_BLK_DEV_IDECD=m
    # CONFIG_BLK_DEV_IDETAPE is not set
    # CONFIG_BLK_DEV_IDEFLOPPY is not set
    # CONFIG_BLK_DEV_IDESCSI is not set
    # CONFIG_IDE_TASK_IOCTL is not set
    # CONFIG_IDE_TASKFILE_IO is not set

    #
    # IDE chipset support/bugfixes
    #
    CONFIG_IDE_GENERIC=y
    # CONFIG_BLK_DEV_CMD640 is not set
    # CONFIG_BLK_DEV_IDEPNP is not set
    CONFIG_BLK_DEV_IDEPCI=y
    CONFIG_IDEPCI_SHARE_IRQ=y
    # CONFIG_BLK_DEV_OFFBOARD is not set
    # CONFIG_BLK_DEV_GENERIC is not set
    # CONFIG_BLK_DEV_OPTI621 is not set
    # CONFIG_BLK_DEV_RZ1000 is not set
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
    # CONFIG_BLK_DEV_PDC202XX_OLD is not set
    # CONFIG_BLK_DEV_PDC202XX_NEW is not set
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
    CONFIG_BLK_DEV_SD=m
    CONFIG_MAX_SD_DISKS=256
    # CONFIG_CHR_DEV_ST is not set
    # CONFIG_CHR_DEV_OSST is not set
    CONFIG_BLK_DEV_SR=m
    # CONFIG_BLK_DEV_SR_VENDOR is not set
    CONFIG_CHR_DEV_SG=m

    #
    # Some SCSI devices (e.g. CD jukebox) support multiple LUNs
    #
    # CONFIG_SCSI_MULTI_LUN is not set
    # CONFIG_SCSI_REPORT_LUNS is not set
    # CONFIG_SCSI_CONSTANTS is not set
    # CONFIG_SCSI_LOGGING is not set

    #
    # SCSI low-level drivers
    #
    # CONFIG_BLK_DEV_3W_XXXX_RAID is not set
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
    # PCMCIA SCSI adapter support
    #
    # CONFIG_PCMCIA_AHA152X is not set
    # CONFIG_PCMCIA_FDOMAIN is not set
    # CONFIG_PCMCIA_NINJA_SCSI is not set
    # CONFIG_PCMCIA_QLOGIC is not set

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
    CONFIG_IEEE1394=m

    #
    # Subsystem Options
    #
    # CONFIG_IEEE1394_VERBOSEDEBUG is not set
    # CONFIG_IEEE1394_OUI_DB is not set

    #
    # Device Drivers
    #

    #
    # Texas Instruments PCILynx requires I2C
    #
    CONFIG_IEEE1394_OHCI1394=m

    #
    # Protocol Drivers
    #
    CONFIG_IEEE1394_VIDEO1394=m
    CONFIG_IEEE1394_SBP2=m
    CONFIG_IEEE1394_SBP2_PHYS_DMA=y
    CONFIG_IEEE1394_ETH1394=m
    CONFIG_IEEE1394_DV1394=m
    CONFIG_IEEE1394_RAWIO=m
    CONFIG_IEEE1394_CMP=m
    CONFIG_IEEE1394_AMDTP=m

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
    # CONFIG_PACKET_MMAP is not set
    CONFIG_NETLINK_DEV=m
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
    CONFIG_SYN_COOKIES=y
    # CONFIG_INET_AH is not set
    # CONFIG_INET_ESP is not set
    # CONFIG_INET_IPCOMP is not set

    #
    # IP: Virtual Server Configuration
    #
    # CONFIG_IP_VS is not set
    # CONFIG_IPV6 is not set
    # CONFIG_DECNET is not set
    # CONFIG_BRIDGE is not set
    CONFIG_NETFILTER=y
    # CONFIG_NETFILTER_DEBUG is not set

    #
    # IP: Netfilter Configuration
    #
    CONFIG_IP_NF_CONNTRACK=m
    CONFIG_IP_NF_FTP=m
    CONFIG_IP_NF_IRC=m
    # CONFIG_IP_NF_TFTP is not set
    # CONFIG_IP_NF_AMANDA is not set
    CONFIG_IP_NF_QUEUE=m
    CONFIG_IP_NF_IPTABLES=m
    CONFIG_IP_NF_MATCH_LIMIT=m
    # CONFIG_IP_NF_MATCH_IPRANGE is not set
    CONFIG_IP_NF_MATCH_MAC=m
    CONFIG_IP_NF_MATCH_PKTTYPE=m
    CONFIG_IP_NF_MATCH_MARK=m
    CONFIG_IP_NF_MATCH_MULTIPORT=m
    CONFIG_IP_NF_MATCH_TOS=m
    # CONFIG_IP_NF_MATCH_RECENT is not set
    CONFIG_IP_NF_MATCH_ECN=m
    CONFIG_IP_NF_MATCH_DSCP=m
    # CONFIG_IP_NF_MATCH_AH_ESP is not set
    CONFIG_IP_NF_MATCH_LENGTH=m
    CONFIG_IP_NF_MATCH_TTL=m
    CONFIG_IP_NF_MATCH_TCPMSS=m
    CONFIG_IP_NF_MATCH_HELPER=m
    CONFIG_IP_NF_MATCH_STATE=m
    CONFIG_IP_NF_MATCH_CONNTRACK=m
    CONFIG_IP_NF_MATCH_OWNER=m
    CONFIG_IP_NF_FILTER=m
    CONFIG_IP_NF_TARGET_REJECT=m
    CONFIG_IP_NF_NAT=m
    CONFIG_IP_NF_NAT_NEEDED=y
    CONFIG_IP_NF_TARGET_MASQUERADE=m
    CONFIG_IP_NF_TARGET_REDIRECT=m
    CONFIG_IP_NF_TARGET_NETMAP=m
    # CONFIG_IP_NF_TARGET_SAME is not set
    # CONFIG_IP_NF_NAT_LOCAL is not set
    CONFIG_IP_NF_NAT_SNMP_BASIC=m
    CONFIG_IP_NF_NAT_IRC=m
    CONFIG_IP_NF_NAT_FTP=m
    CONFIG_IP_NF_MANGLE=m
    CONFIG_IP_NF_TARGET_TOS=m
    CONFIG_IP_NF_TARGET_ECN=m
    CONFIG_IP_NF_TARGET_DSCP=m
    CONFIG_IP_NF_TARGET_MARK=m
    CONFIG_IP_NF_TARGET_CLASSIFY=m
    CONFIG_IP_NF_TARGET_LOG=m
    # CONFIG_IP_NF_TARGET_ULOG is not set
    CONFIG_IP_NF_TARGET_TCPMSS=m
    CONFIG_IP_NF_ARPTABLES=m
    CONFIG_IP_NF_ARPFILTER=m
    # CONFIG_IP_NF_ARP_MANGLE is not set
    CONFIG_IP_NF_COMPAT_IPCHAINS=m
    CONFIG_IP_NF_COMPAT_IPFWADM=m
    CONFIG_XFRM=y
    # CONFIG_XFRM_USER is not set

    #
    # SCTP Configuration (EXPERIMENTAL)
    #
    CONFIG_IPV6_SCTP__=y
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
    # CONFIG_DUMMY is not set
    # CONFIG_BONDING is not set
    # CONFIG_EQUALIZER is not set
    CONFIG_TUN=m
    # CONFIG_ETHERTAP is not set
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
    CONFIG_VORTEX=m
    # CONFIG_TYPHOON is not set
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
    # CONFIG_NET_PCI is not set
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
    # CONFIG_PPP is not set
    # CONFIG_SLIP is not set

    #
    # Wireless LAN (non-hamradio)
    #
    CONFIG_NET_RADIO=y

    #
    # Obsolete Wireless cards support (pre-802.11)
    #
    # CONFIG_STRIP is not set
    # CONFIG_ARLAN is not set
    # CONFIG_WAVELAN is not set
    # CONFIG_PCMCIA_WAVELAN is not set
    # CONFIG_PCMCIA_NETWAVE is not set

    #
    # Wireless 802.11 Frequency Hopping cards support
    #
    # CONFIG_PCMCIA_RAYCS is not set

    #
    # Wireless 802.11b ISA/PCI cards support
    #
    # CONFIG_AIRO is not set
    CONFIG_HERMES=m
    # CONFIG_PLX_HERMES is not set
    # CONFIG_TMD_HERMES is not set
    # CONFIG_PCI_HERMES is not set

    #
    # Wireless 802.11b Pcmcia/Cardbus cards support
    #
    CONFIG_PCMCIA_HERMES=m
    # CONFIG_AIRO_CS is not set
    CONFIG_PCMCIA_ATMEL=m
    # CONFIG_PCMCIA_WL3501 is not set
    CONFIG_NET_WIRELESS=y

    #
    # Token Ring devices
    #
    # CONFIG_TR is not set
    # CONFIG_NET_FC is not set
    # CONFIG_RCPCI is not set
    # CONFIG_SHAPER is not set
    # CONFIG_NETCONSOLE is not set

    #
    # Wan interfaces
    #
    # CONFIG_WAN is not set

    #
    # PCMCIA network device support
    #
    # CONFIG_NET_PCMCIA is not set

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
    # CONFIG_KGDBOE is not set
    # CONFIG_NETPOLL is not set
    # CONFIG_NETPOLL_RX is not set
    # CONFIG_NETPOLL_TRAP is not set
    # CONFIG_NET_POLL_CONTROLLER is not set

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
    CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
    CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
    # CONFIG_INPUT_JOYDEV is not set
    # CONFIG_INPUT_TSDEV is not set
    CONFIG_INPUT_EVDEV=m
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
    CONFIG_MOUSE_PS2=m
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
    CONFIG_SERIAL_8250=m
    # CONFIG_SERIAL_8250_CS is not set
    # CONFIG_SERIAL_8250_ACPI is not set
    CONFIG_SERIAL_8250_NR_UARTS=4
    # CONFIG_SERIAL_8250_EXTENDED is not set

    #
    # Non-8250 serial port support
    #
    CONFIG_SERIAL_CORE=m
    CONFIG_UNIX98_PTYS=y
    CONFIG_UNIX98_PTY_COUNT=256

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
    CONFIG_NVRAM=m
    CONFIG_RTC=y
    # CONFIG_DTLK is not set
    # CONFIG_R3964 is not set
    # CONFIG_APPLICOM is not set
    # CONFIG_SONYPI is not set

    #
    # Ftape, the floppy tape device driver
    #
    # CONFIG_FTAPE is not set
    CONFIG_AGP=m
    # CONFIG_AGP_ALI is not set
    # CONFIG_AGP_ATI is not set
    # CONFIG_AGP_AMD is not set
    # CONFIG_AGP_AMD64 is not set
    # CONFIG_AGP_INTEL is not set
    # CONFIG_AGP_NVIDIA is not set
    # CONFIG_AGP_SIS is not set
    # CONFIG_AGP_SWORKS is not set
    # CONFIG_AGP_VIA is not set
    # CONFIG_DRM is not set

    #
    # PCMCIA character devices
    #
    # CONFIG_SYNCLINK_CS is not set
    # CONFIG_MWAVE is not set
    # CONFIG_RAW_DRIVER is not set
    # CONFIG_HANGCHECK_TIMER is not set

    #
    # I2C support
    #
    # CONFIG_I2C is not set

    #
    # Multimedia devices
    #
    # CONFIG_VIDEO_DEV is not set

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
    CONFIG_FB_VESA=y
    CONFIG_VIDEO_SELECT=y
    # CONFIG_FB_HGA is not set
    # CONFIG_FB_RIVA is not set
    # CONFIG_FB_MATROX is not set
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
    CONFIG_FRAMEBUFFER_CONSOLE=y
    CONFIG_PCI_CONSOLE=y
    # CONFIG_FONTS is not set
    CONFIG_FONT_8x8=y
    CONFIG_FONT_8x16=y

    #
    # Logo configuration
    #
    # CONFIG_LOGO is not set

    #
    # Sound
    #
    CONFIG_SOUND=m

    #
    # Advanced Linux Sound Architecture
    #
    CONFIG_SND=m
    CONFIG_SND_SEQUENCER=m
    CONFIG_SND_SEQ_DUMMY=m
    CONFIG_SND_OSSEMUL=y
    CONFIG_SND_MIXER_OSS=m
    CONFIG_SND_PCM_OSS=m
    CONFIG_SND_SEQUENCER_OSS=y
    CONFIG_SND_RTCTIMER=m
    # CONFIG_SND_VERBOSE_PRINTK is not set
    # CONFIG_SND_DEBUG is not set

    #
    # Generic devices
    #
    CONFIG_SND_DUMMY=m
    # CONFIG_SND_VIRMIDI is not set
    # CONFIG_SND_MTPAV is not set
    # CONFIG_SND_SERIAL_U16550 is not set
    # CONFIG_SND_MPU401 is not set

    #
    # ISA devices
    #
    # CONFIG_SND_AD1848 is not set
    # CONFIG_SND_CS4231 is not set
    # CONFIG_SND_CS4232 is not set
    # CONFIG_SND_CS4236 is not set
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
    # CONFIG_SND_CMI8330 is not set
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
    # CONFIG_SND_EMU10K1 is not set
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
    CONFIG_SND_INTEL8X0=m
    # CONFIG_SND_SONICVIBES is not set
    # CONFIG_SND_VIA82XX is not set
    # CONFIG_SND_VX222 is not set

    #
    # ALSA USB devices
    #
    # CONFIG_SND_USB_AUDIO is not set

    #
    # PCMCIA devices
    #
    # CONFIG_SND_VXPOCKET is not set
    # CONFIG_SND_VXP440 is not set

    #
    # Open Sound System
    #
    # CONFIG_SOUND_PRIME is not set

    #
    # USB support
    #
    CONFIG_USB=m
    # CONFIG_USB_DEBUG is not set

    #
    # Miscellaneous USB options
    #
    CONFIG_USB_DEVICEFS=y
    CONFIG_USB_BANDWIDTH=y
    # CONFIG_USB_DYNAMIC_MINORS is not set

    #
    # USB Host Controller Drivers
    #
    CONFIG_USB_EHCI_HCD=m
    # CONFIG_USB_OHCI_HCD is not set
    CONFIG_USB_UHCI_HCD=m

    #
    # USB Device Class drivers
    #
    CONFIG_USB_AUDIO=m
    # CONFIG_USB_BLUETOOTH_TTY is not set
    CONFIG_USB_MIDI=m
    # CONFIG_USB_ACM is not set
    CONFIG_USB_PRINTER=m
    CONFIG_USB_STORAGE=m
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
    CONFIG_USB_HID=m
    CONFIG_USB_HIDINPUT=y
    # CONFIG_HID_FF is not set
    CONFIG_USB_HIDDEV=y

    #
    # USB HID Boot Protocol drivers
    #
    CONFIG_USB_KBD=m
    CONFIG_USB_MOUSE=m
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

    #
    # Video4Linux support is needed for USB Multimedia device support
    #

    #
    # USB Network adaptors
    #
    # CONFIG_USB_CATC is not set
    # CONFIG_USB_KAWETH is not set
    # CONFIG_USB_PEGASUS is not set
    # CONFIG_USB_RTL8150 is not set
    CONFIG_USB_USBNET=m

    #
    # USB Host-to-Host Cables
    #
    CONFIG_USB_AN2720=y
    CONFIG_USB_BELKIN=y
    CONFIG_USB_GENESYS=y
    CONFIG_USB_NET1080=y
    CONFIG_USB_PL2301=y

    #
    # Intelligent USB Devices/Gadgets
    #
    CONFIG_USB_ARMLINUX=y
    CONFIG_USB_EPSON2888=y
    CONFIG_USB_ZAURUS=y
    CONFIG_USB_CDCETHER=y

    #
    # USB Network Adapters
    #
    # CONFIG_USB_AX8817X is not set

    #
    # USB port drivers
    #

    #
    # USB Serial Converter support
    #
    CONFIG_USB_SERIAL=m
    CONFIG_USB_SERIAL_GENERIC=y
    CONFIG_USB_SERIAL_BELKIN=m
    CONFIG_USB_SERIAL_WHITEHEAT=m
    CONFIG_USB_SERIAL_DIGI_ACCELEPORT=m
    CONFIG_USB_SERIAL_EMPEG=m
    CONFIG_USB_SERIAL_FTDI_SIO=m
    CONFIG_USB_SERIAL_VISOR=m
    CONFIG_USB_SERIAL_IPAQ=m
    CONFIG_USB_SERIAL_IR=m
    CONFIG_USB_SERIAL_EDGEPORT=m
    CONFIG_USB_SERIAL_EDGEPORT_TI=m
    CONFIG_USB_SERIAL_KEYSPAN_PDA=m
    CONFIG_USB_SERIAL_KEYSPAN=m
    # CONFIG_USB_SERIAL_KEYSPAN_MPR is not set
    # CONFIG_USB_SERIAL_KEYSPAN_USA28 is not set
    # CONFIG_USB_SERIAL_KEYSPAN_USA28X is not set
    # CONFIG_USB_SERIAL_KEYSPAN_USA28XA is not set
    # CONFIG_USB_SERIAL_KEYSPAN_USA28XB is not set
    # CONFIG_USB_SERIAL_KEYSPAN_USA19 is not set
    # CONFIG_USB_SERIAL_KEYSPAN_USA18X is not set
    # CONFIG_USB_SERIAL_KEYSPAN_USA19W is not set
    # CONFIG_USB_SERIAL_KEYSPAN_USA19QW is not set
    # CONFIG_USB_SERIAL_KEYSPAN_USA19QI is not set
    # CONFIG_USB_SERIAL_KEYSPAN_USA49W is not set
    # CONFIG_USB_SERIAL_KEYSPAN_USA49WLC is not set
    CONFIG_USB_SERIAL_KLSI=m
    # CONFIG_USB_SERIAL_KOBIL_SCT is not set
    CONFIG_USB_SERIAL_MCT_U232=m
    CONFIG_USB_SERIAL_PL2303=m
    # CONFIG_USB_SERIAL_SAFE is not set
    CONFIG_USB_SERIAL_CYBERJACK=m
    CONFIG_USB_SERIAL_XIRCOM=m
    CONFIG_USB_SERIAL_OMNINET=m
    CONFIG_USB_EZUSB=y

    #
    # USB Miscellaneous drivers
    #
    # CONFIG_USB_EMI26 is not set
    CONFIG_USB_TIGL=m
    # CONFIG_USB_AUERSWALD is not set
    # CONFIG_USB_RIO500 is not set
    # CONFIG_USB_LEGOTOWER is not set
    # CONFIG_USB_BRLVGER is not set
    # CONFIG_USB_LCD is not set
    # CONFIG_USB_TEST is not set
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
    # CONFIG_REISERFS_FS is not set
    # CONFIG_JFS_FS is not set
    CONFIG_XFS_FS=y
    # CONFIG_XFS_RT is not set
    # CONFIG_XFS_QUOTA is not set
    CONFIG_XFS_POSIX_ACL=y
    # CONFIG_MINIX_FS is not set
    CONFIG_ROMFS_FS=m
    # CONFIG_QUOTA is not set
    CONFIG_AUTOFS_FS=m
    CONFIG_AUTOFS4_FS=m

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
    CONFIG_FAT_FS=y
    CONFIG_MSDOS_FS=m
    CONFIG_VFAT_FS=y
    CONFIG_NTFS_FS=m
    # CONFIG_NTFS_DEBUG is not set
    # CONFIG_NTFS_RW is not set

    #
    # Pseudo filesystems
    #
    CONFIG_PROC_FS=y
    CONFIG_PROC_KCORE=y
    CONFIG_SYSFS=y
    # CONFIG_DEVFS_FS is not set
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
    # CONFIG_HFS_FS is not set
    # CONFIG_BEFS_FS is not set
    # CONFIG_BFS_FS is not set
    # CONFIG_EFS_FS is not set
    CONFIG_CRAMFS=m
    # CONFIG_VXFS_FS is not set
    # CONFIG_HPFS_FS is not set
    # CONFIG_QNX4FS_FS is not set
    # CONFIG_SYSV_FS is not set
    # CONFIG_UFS_FS is not set

    #
    # Network File Systems
    #
    CONFIG_NFS_FS=m
    CONFIG_NFS_V3=y
    CONFIG_NFS_V4=y
    # CONFIG_NFS_DIRECTIO is not set
    CONFIG_NFSD=m
    # CONFIG_NFSD_V3 is not set
    # CONFIG_NFSD_TCP is not set
    CONFIG_LOCKD=m
    CONFIG_LOCKD_V4=y
    CONFIG_EXPORTFS=m
    CONFIG_SUNRPC=m
    # CONFIG_SUNRPC_GSS is not set
    CONFIG_SMB_FS=m
    # CONFIG_SMB_NLS_DEFAULT is not set
    # CONFIG_CIFS is not set
    # CONFIG_NCP_FS is not set
    CONFIG_CODA_FS=m
    # CONFIG_CODA_FS_OLD_API is not set
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
    CONFIG_NLS_DEFAULT="cp437"
    CONFIG_NLS_CODEPAGE_437=m
    CONFIG_NLS_CODEPAGE_737=m
    CONFIG_NLS_CODEPAGE_775=m
    CONFIG_NLS_CODEPAGE_850=m
    CONFIG_NLS_CODEPAGE_852=m
    CONFIG_NLS_CODEPAGE_855=m
    CONFIG_NLS_CODEPAGE_857=m
    CONFIG_NLS_CODEPAGE_860=m
    CONFIG_NLS_CODEPAGE_861=m
    CONFIG_NLS_CODEPAGE_862=m
    CONFIG_NLS_CODEPAGE_863=m
    CONFIG_NLS_CODEPAGE_864=m
    CONFIG_NLS_CODEPAGE_865=m
    CONFIG_NLS_CODEPAGE_866=m
    CONFIG_NLS_CODEPAGE_869=m
    CONFIG_NLS_CODEPAGE_936=m
    CONFIG_NLS_CODEPAGE_950=m
    CONFIG_NLS_CODEPAGE_932=m
    CONFIG_NLS_CODEPAGE_949=m
    CONFIG_NLS_CODEPAGE_874=m
    CONFIG_NLS_ISO8859_8=m
    CONFIG_NLS_CODEPAGE_1250=m
    CONFIG_NLS_CODEPAGE_1251=m
    CONFIG_NLS_ISO8859_1=m
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
    CONFIG_NLS_UTF8=m

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
    CONFIG_X86_EXTRA_IRQS=y
    CONFIG_X86_FIND_SMP_CONFIG=y
    CONFIG_X86_MPPARSE=y

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
    CONFIG_CRC32=m
    CONFIG_ZLIB_INFLATE=y
    CONFIG_X86_BIOS_REBOOT=y
    CONFIG_PC=y

Here's what I get when I try to look at my battery stats:

    omgterrar:/proc/acpi/battery/BAT0# cat state
    present:                 yes
    capacity state:          ok
    charging state:          unknown
    present rate:            0 mA
    remaining capacity:      0 mAh
    present voltage:         0 mV

    omgterrar:/proc/acpi/battery/BAT0# cat info 
    present:                 yes
    design capacity:         0 mWh
    last full capacity:      0 mWh
    battery technology:      non-rechargeable
    design voltage:          0 mV
    design capacity warning: 0 mWh
    design capacity low:     0 mWh
    capacity granularity 1:  0 mWh
    capacity granularity 2:  0 mWh
    model number:           
    serial number:          
    battery type:           
    OEM info:               

Here's the output of the ver_linux script:

    Linux omgterrar 2.6.1-mm5 #1 Tue Jan 20 12:25:44 EST 2004 i686 GNU/Linux
     
    Gnu C                  3.3.3
    Gnu make               3.80
    util-linux             2.12
    mount                  2.12
    module-init-tools      3.0-pre5
    e2fsprogs              1.35-WIP
    xfsprogs               2.6.0
    pcmcia-cs              3.2.5
    PPP                    2.4.2
    Linux C Library        2.3.2
    Dynamic linker (ldd)   2.3.2
    Procps                 3.1.15
    Net-tools              1.60
    Console-tools          0.2.3
    Sh-utils               5.0.91
    Modules Loaded         nvidia ds yenta_socket pcmcia_core 8250
    serial_core snd_seq_oss snd_seq_midi_event snd_seq snd_pcm_oss
    snd_mixer_oss snd_intel8x0 snd_ac97_codec snd_pcm snd_timer
    snd_page_alloc snd_mpu401_uart snd_rawmidi snd_seq_device snd
    soundcore thermal processor fan button battery ac ehci_hcd sd_mod
    usb_storage evdev psmouse cpufreq_userspace ide_cd cdrom usbmouse
    i8k usblp cpuid microcode uhci_hcd usbcore 3c59x

