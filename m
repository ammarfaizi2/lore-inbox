Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270530AbTHESQ3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Aug 2003 14:16:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270621AbTHESQ2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Aug 2003 14:16:28 -0400
Received: from mail2.ati.com ([209.50.91.166]:52456 "EHLO mail2.ati.com")
	by vger.kernel.org with ESMTP id S270530AbTHESP3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Aug 2003 14:15:29 -0400
Message-ID: <328A30E823B7D511A0BF00065B042A3B0172D70B@fgl00exh01.fgl.atitech.com>
From: Alexander Stohr <AlexanderS@ati.com>
To: Ruben Puettmann <ruben@puettmann.net>, linux-kernel@vger.kernel.org
Cc: dri-users@lists.sourceforge.net
Date: Tue, 5 Aug 2003 20:12:29 +0200 
Subject: RE: [Dri-users] Linux 2.4.22-pre10-ac1 DRI doesn't work with Rade
	on 7500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
X-Sybari-Trust: 50f7f052 51c993be 07755764 00000108
X-Mailer: Internet Mail Service (5.5.2653.19)
X-SEF-2C572D56-73FD-4999-BDBF-4582B84FCA7C: 1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

you better use the drm module 
that matches your X11 implementation.

other than that a gdb backtrace (call stack)
or the kernel oops message (if applicable)
would be most helpfull.

-Alex.


> -----Original Message-----
> From: Ruben Puettmann [mailto:ruben@puettmann.net]
> Sent: Tuesday, August 05, 2003 18:49
> To: linux-kernel@vger.kernel.org
> Cc: dri-users@lists.sourceforge.net
> Subject: [Dri-users] Linux 2.4.22-pre10-ac1 DRI doesn't work 
> with Radeon
> 7500
> 
> 
>         
> 
>         hy,
> 
> 
> DRI doesn't work with Radeon 7500 on IBM Thinkpad R40 (2722).
> 
> 01:00.0 VGA compatible controller: ATI Technologies Inc 
> Radeon Mobility
> M7 LW [Radeon Mobility 7500] (prog-if 00 [VGA])
>         Subsystem: IBM: Unknown device 0527
>         Flags: bus master, stepping, fast Back2Back, 66Mhz, medium
>         devsel, latency 66, IRQ 9
>         Memory at e0000000 (32-bit, prefetchable) [size=128M]
>         I/O ports at 3000 [size=256]
>         Memory at c0100000 (32-bit, non-prefetchable) [size=64K]
>         Expansion ROM at <unassigned> [disabled] [size=128K]
>         Capabilities: [58] AGP version 2.0
>         Capabilities: [50] Power Management version 2
> 
> 
> XFree86 : 4.2.1
> 
> 
> Both glxgears and tuxracer crashes with the Illegal instruction error
> message. the strace output of glxgears is:
> 
> ...
> 
> brk(0)                                  = 0x80a7000
> brk(0x80ac000)                          = 0x80ac000
> brk(0)                                  = 0x80ac000
> brk(0x80ad000)                          = 0x80ad000
> brk(0)                                  = 0x80ad000
> brk(0x80b2000)                          = 0x80b2000
> brk(0)                                  = 0x80b2000
> brk(0x80bb000)                          = 0x80bb000
> brk(0)                                  = 0x80bb000
> brk(0x80c1000)                          = 0x80c1000
> ioctl(3, FIONREAD, [0])                 = 0
> ioctl(5, 0x40186448, 0xbffffb30)        = 0
> --- SIGILL (Illegal instruction) @ 0 (0) ---
> +++ killed by SIGILL +++
> 
> 
> If I doesn't load the DRI module into X, both glxgears and tuxracer
> works, but of course without HW-redering. 
> 
> No entry's in the logfiles
> 
> Kernel Config: 
> 
> 
> #
> # Automatically generated make config: don't edit
> #
> CONFIG_X86=y
> # CONFIG_SBUS is not set
> CONFIG_UID16=y
> 
> #
> # Code maturity level options
> #
> CONFIG_EXPERIMENTAL=y
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
> CONFIG_MPENTIUMIII=y
> # CONFIG_MPENTIUM4 is not set
> # CONFIG_MK6 is not set
> # CONFIG_MK7 is not set
> # CONFIG_MK8 is not set
> # CONFIG_MELAN is not set
> # CONFIG_MCRUSOE is not set
> # CONFIG_MWINCHIPC6 is not set
> # CONFIG_MWINCHIP2 is not set
> # CONFIG_MWINCHIP3D is not set
> # CONFIG_MCYRIXIII is not set
> # CONFIG_MVIAC3_2 is not set
> CONFIG_X86_WP_WORKS_OK=y
> CONFIG_X86_INVLPG=y
> CONFIG_X86_CMPXCHG=y
> CONFIG_X86_XADD=y
> CONFIG_X86_BSWAP=y
> CONFIG_X86_POPAD_OK=y
> # CONFIG_RWSEM_GENERIC_SPINLOCK is not set
> CONFIG_RWSEM_XCHGADD_ALGORITHM=y
> CONFIG_X86_L1_CACHE_SHIFT=5
> CONFIG_X86_HAS_TSC=y
> CONFIG_X86_GOOD_APIC=y
> CONFIG_X86_PGE=y
> CONFIG_X86_USE_PPRO_CHECKSUM=y
> CONFIG_X86_F00F_WORKS_OK=y
> CONFIG_X86_MCE=y
> 
> #
> # CPU Frequency scaling
> #
> CONFIG_CPU_FREQ=y
> CONFIG_CPU_FREQ_TABLE=y
> CONFIG_CPU_FREQ_PROC_INTF=y
> 
> #
> # CPUFreq governors
> #
> CONFIG_CPU_FREQ_GOV_USERSPACE=y
> CONFIG_CPU_FREQ_24_API=y
> 
> #
> # CPUFreq processor drivers
> #
> # CONFIG_X86_POWERNOW_K6 is not set
> # CONFIG_X86_POWERNOW_K7 is not set
> # CONFIG_X86_LONGHAUL is not set
> CONFIG_X86_SPEEDSTEP_ICH=y
> # CONFIG_X86_SPEEDSTEP_CENTRINO is not set
> # CONFIG_X86_P4_CLOCKMOD is not set
> # CONFIG_X86_LONGRUN is not set
> # CONFIG_X86_GX_SUSPMOD is not set
> # CONFIG_TOSHIBA is not set
> # CONFIG_I8K is not set
> CONFIG_MICROCODE=y
> CONFIG_X86_MSR=y
> CONFIG_X86_CPUID=y
> # CONFIG_EDD is not set
> CONFIG_NOHIGHMEM=y
> # CONFIG_HIGHMEM4G is not set
> # CONFIG_HIGHMEM64G is not set
> # CONFIG_HIGHMEM is not set
> # CONFIG_MATH_EMULATION is not set
> CONFIG_MTRR=y
> # CONFIG_SMP is not set
> CONFIG_X86_UP_APIC=y
> CONFIG_X86_UP_IOAPIC=y
> CONFIG_X86_LOCAL_APIC=y
> CONFIG_X86_IO_APIC=y
> # CONFIG_X86_TSC_DISABLE is not set
> CONFIG_X86_TSC=y
> 
> #
> # General setup
> #
> CONFIG_NET=y
> CONFIG_PCI=y
> # CONFIG_PCI_GOBIOS is not set
> # CONFIG_PCI_GODIRECT is not set
> CONFIG_PCI_GOANY=y
> CONFIG_PCI_BIOS=y
> CONFIG_PCI_DIRECT=y
> CONFIG_ISA=y
> # CONFIG_SCx200 is not set
> CONFIG_PCI_NAMES=y
> # CONFIG_EISA is not set
> # CONFIG_MCA is not set
> CONFIG_HOTPLUG=y
> 
> #
> # PCMCIA/CardBus support
> #
> CONFIG_PCMCIA=m
> CONFIG_CARDBUS=y
> CONFIG_TCIC=y
> CONFIG_I82092=y
> CONFIG_I82365=y
> 
> #
> # PCI Hotplug Support
> #
> # CONFIG_HOTPLUG_PCI is not set
> # CONFIG_HOTPLUG_PCI_ACPI is not set
> # CONFIG_HOTPLUG_PCI_COMPAQ is not set
> # CONFIG_HOTPLUG_PCI_COMPAQ_NVRAM is not set
> # CONFIG_HOTPLUG_PCI_IBM is not set
> # CONFIG_HOTPLUG_PCI_H2999 is not set
> CONFIG_SYSVIPC=y
> CONFIG_BSD_PROCESS_ACCT=y
> CONFIG_SYSCTL=y
> CONFIG_KCORE_ELF=y
> # CONFIG_KCORE_AOUT is not set
> CONFIG_BINFMT_AOUT=y
> CONFIG_BINFMT_ELF=y
> CONFIG_BINFMT_MISC=y
> # CONFIG_IKCONFIG is not set
> CONFIG_PM=y
> CONFIG_APM=y
> # CONFIG_APM_IGNORE_USER_SUSPEND is not set
> CONFIG_APM_DO_ENABLE=y
> CONFIG_APM_CPU_IDLE=y
> # CONFIG_APM_DISPLAY_BLANK is not set
> # CONFIG_APM_RTC_IS_GMT is not set
> CONFIG_APM_ALLOW_INTS=y
> # CONFIG_APM_REAL_MODE_POWER_OFF is not set
> 
> #
> # ACPI Support
> #
> # CONFIG_ACPI is not set
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
> CONFIG_PARPORT_PC=m
> CONFIG_PARPORT_PC_CML1=m
> CONFIG_PARPORT_SERIAL=m
> CONFIG_PARPORT_PC_FIFO=y
> CONFIG_PARPORT_PC_SUPERIO=y
> CONFIG_PARPORT_PC_PCMCIA=m
> # CONFIG_PARPORT_AMIGA is not set
> # CONFIG_PARPORT_MFC3 is not set
> # CONFIG_PARPORT_ATARI is not set
> # CONFIG_PARPORT_GSC is not set
> # CONFIG_PARPORT_SUNBPP is not set
> CONFIG_PARPORT_OTHER=y
> CONFIG_PARPORT_1284=y
> 
> #
> # Plug and Play configuration
> #
> CONFIG_PNP=y
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
> # CONFIG_CISS_SCSI_TAPE is not set
> # CONFIG_BLK_DEV_DAC960 is not set
> # CONFIG_BLK_DEV_UMEM is not set
> CONFIG_BLK_DEV_LOOP=y
> # CONFIG_BLK_DEV_NBD is not set
> CONFIG_BLK_DEV_RAM=m
> CONFIG_BLK_DEV_RAM_SIZE=4096
> # CONFIG_BLK_DEV_INITRD is not set
> CONFIG_BLK_STATS=y
> 
> #
> # Multi-device support (RAID and LVM)
> #
> # CONFIG_MD is not set
> # CONFIG_BLK_DEV_MD is not set
> # CONFIG_MD_LINEAR is not set
> # CONFIG_MD_RAID0 is not set
> # CONFIG_MD_RAID1 is not set
> # CONFIG_MD_RAID5 is not set
> # CONFIG_MD_MULTIPATH is not set
> # CONFIG_BLK_DEV_LVM is not set
> # CONFIG_BLK_DEV_DM is not set
> 
> #
> # Networking options
> #
> CONFIG_PACKET=y
> CONFIG_PACKET_MMAP=y
> CONFIG_NETLINK_DEV=m
> CONFIG_NETFILTER=y
> CONFIG_NETFILTER_DEBUG=y
> CONFIG_FILTER=y
> CONFIG_UNIX=y
> CONFIG_INET=y
> CONFIG_IP_MULTICAST=y
> CONFIG_IP_ADVANCED_ROUTER=y
> CONFIG_IP_MULTIPLE_TABLES=y
> CONFIG_IP_ROUTE_FWMARK=y
> CONFIG_IP_ROUTE_NAT=y
> CONFIG_IP_ROUTE_MULTIPATH=y
> CONFIG_IP_ROUTE_TOS=y
> CONFIG_IP_ROUTE_VERBOSE=y
> # CONFIG_IP_PNP is not set
> CONFIG_NET_IPIP=m
> CONFIG_NET_IPGRE=m
> CONFIG_NET_IPGRE_BROADCAST=y
> CONFIG_IP_MROUTE=y
> CONFIG_IP_PIMSM_V1=y
> CONFIG_IP_PIMSM_V2=y
> CONFIG_ARPD=y
> # CONFIG_INET_ECN is not set
> CONFIG_SYN_COOKIES=y
> 
> #
> #   IP: Netfilter Configuration
> #
> CONFIG_IP_NF_CONNTRACK=m
> CONFIG_IP_NF_FTP=m
> CONFIG_IP_NF_AMANDA=m
> CONFIG_IP_NF_TFTP=m
> CONFIG_IP_NF_IRC=m
> CONFIG_IP_NF_QUEUE=m
> CONFIG_IP_NF_IPTABLES=m
> CONFIG_IP_NF_MATCH_LIMIT=m
> CONFIG_IP_NF_MATCH_MAC=m
> CONFIG_IP_NF_MATCH_PKTTYPE=m
> CONFIG_IP_NF_MATCH_MARK=m
> CONFIG_IP_NF_MATCH_MULTIPORT=m
> CONFIG_IP_NF_MATCH_TOS=m
> CONFIG_IP_NF_MATCH_RECENT=m
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
> CONFIG_IP_NF_NAT_AMANDA=m
> CONFIG_IP_NF_NAT_LOCAL=y
> CONFIG_IP_NF_NAT_SNMP_BASIC=m
> CONFIG_IP_NF_NAT_IRC=m
> CONFIG_IP_NF_NAT_FTP=m
> CONFIG_IP_NF_NAT_TFTP=m
> CONFIG_IP_NF_MANGLE=m
> CONFIG_IP_NF_TARGET_TOS=m
> CONFIG_IP_NF_TARGET_ECN=m
> CONFIG_IP_NF_TARGET_DSCP=m
> CONFIG_IP_NF_TARGET_MARK=m
> CONFIG_IP_NF_TARGET_LOG=m
> CONFIG_IP_NF_TARGET_ULOG=m
> CONFIG_IP_NF_TARGET_TCPMSS=m
> CONFIG_IP_NF_ARPTABLES=m
> CONFIG_IP_NF_ARPFILTER=m
> CONFIG_IP_NF_ARP_MANGLE=m
> # CONFIG_IP_NF_COMPAT_IPCHAINS is not set
> # CONFIG_IP_NF_COMPAT_IPFWADM is not set
> CONFIG_IPV6=m
> 
> #
> #   IPv6: Netfilter Configuration
> #
> CONFIG_IP6_NF_QUEUE=m
> CONFIG_IP6_NF_IPTABLES=m
> CONFIG_IP6_NF_MATCH_LIMIT=m
> CONFIG_IP6_NF_MATCH_MAC=m
> CONFIG_IP6_NF_MATCH_RT=m
> CONFIG_IP6_NF_MATCH_OPTS=m
> CONFIG_IP6_NF_MATCH_FRAG=m
> CONFIG_IP6_NF_MATCH_HL=m
> CONFIG_IP6_NF_MATCH_MULTIPORT=m
> CONFIG_IP6_NF_MATCH_OWNER=m
> CONFIG_IP6_NF_MATCH_MARK=m
> CONFIG_IP6_NF_MATCH_IPV6HEADER=m
> CONFIG_IP6_NF_MATCH_AHESP=m
> CONFIG_IP6_NF_MATCH_LENGTH=m
> CONFIG_IP6_NF_MATCH_EUI64=m
> CONFIG_IP6_NF_FILTER=m
> CONFIG_IP6_NF_TARGET_LOG=m
> CONFIG_IP6_NF_MANGLE=m
> CONFIG_IP6_NF_TARGET_MARK=m
> # CONFIG_KHTTPD is not set
> # CONFIG_ATM is not set
> CONFIG_VLAN_8021Q=y
> 
> #
> #  
> #
> # CONFIG_IPX is not set
> # CONFIG_ATALK is not set
> 
> #
> # Appletalk devices
> #
> # CONFIG_DEV_APPLETALK is not set
> # CONFIG_DECNET is not set
> CONFIG_BRIDGE=y
> # CONFIG_X25 is not set
> # CONFIG_EDP2 is not set
> # CONFIG_LAPB is not set
> # CONFIG_LLC is not set
> # CONFIG_NET_DIVERT is not set
> # CONFIG_ECONET is not set
> # CONFIG_WAN_ROUTER is not set
> # CONFIG_NET_FASTROUTE is not set
> # CONFIG_NET_HW_FLOWCONTROL is not set
> 
> #
> # QoS and/or fair queueing
> #
> CONFIG_NET_SCHED=y
> CONFIG_NET_SCH_CBQ=m
> CONFIG_NET_SCH_HTB=m
> CONFIG_NET_SCH_CSZ=m
> CONFIG_NET_SCH_PRIO=m
> CONFIG_NET_SCH_RED=m
> CONFIG_NET_SCH_SFQ=m
> CONFIG_NET_SCH_TEQL=m
> CONFIG_NET_SCH_TBF=m
> CONFIG_NET_SCH_GRED=m
> CONFIG_NET_SCH_DSMARK=m
> CONFIG_NET_SCH_INGRESS=m
> CONFIG_NET_QOS=y
> CONFIG_NET_ESTIMATOR=y
> CONFIG_NET_CLS=y
> CONFIG_NET_CLS_TCINDEX=m
> CONFIG_NET_CLS_ROUTE4=m
> CONFIG_NET_CLS_ROUTE=y
> CONFIG_NET_CLS_FW=m
> CONFIG_NET_CLS_U32=m
> CONFIG_NET_CLS_RSVP=m
> CONFIG_NET_CLS_RSVP6=m
> CONFIG_NET_CLS_POLICE=y
> 
> #
> # Network testing
> #
> # CONFIG_NET_PKTGEN is not set
> 
> #
> # Telephony Support
> #
> # CONFIG_PHONE is not set
> # CONFIG_PHONE_IXJ is not set
> # CONFIG_PHONE_IXJ_PCMCIA is not set
> 
> #
> # ATA/IDE/MFM/RLL support
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
> # CONFIG_BLK_DEV_IDECS is not set
> CONFIG_BLK_DEV_IDECD=y
> CONFIG_BLK_DEV_IDETAPE=y
> CONFIG_BLK_DEV_IDEFLOPPY=y
> CONFIG_BLK_DEV_IDESCSI=y
> # CONFIG_IDE_TASK_IOCTL is not set
> 
> #
> # IDE chipset support/bugfixes
> #
> # CONFIG_BLK_DEV_CMD640 is not set
> # CONFIG_BLK_DEV_CMD640_ENHANCED is not set
> # CONFIG_BLK_DEV_ISAPNP is not set
> CONFIG_BLK_DEV_IDEPCI=y
> # CONFIG_BLK_DEV_GENERIC is not set
> CONFIG_IDEPCI_SHARE_IRQ=y
> CONFIG_BLK_DEV_IDEDMA_PCI=y
> # CONFIG_BLK_DEV_OFFBOARD is not set
> # CONFIG_BLK_DEV_IDEDMA_FORCED is not set
> CONFIG_IDEDMA_PCI_AUTO=y
> # CONFIG_IDEDMA_ONLYDISK is not set
> CONFIG_BLK_DEV_IDEDMA=y
> # CONFIG_IDEDMA_PCI_WIP is not set
> # CONFIG_BLK_DEV_ADMA100 is not set
> # CONFIG_BLK_DEV_AEC62XX is not set
> # CONFIG_BLK_DEV_ALI15X3 is not set
> # CONFIG_WDC_ALI15X3 is not set
> # CONFIG_BLK_DEV_AMD74XX is not set
> # CONFIG_AMD74XX_OVERRIDE is not set
> # CONFIG_BLK_DEV_CMD64X is not set
> # CONFIG_BLK_DEV_TRIFLEX is not set
> # CONFIG_BLK_DEV_CY82C693 is not set
> # CONFIG_BLK_DEV_CS5530 is not set
> # CONFIG_BLK_DEV_HPT34X is not set
> # CONFIG_HPT34X_AUTODMA is not set
> # CONFIG_BLK_DEV_HPT366 is not set
> CONFIG_BLK_DEV_PIIX=y
> # CONFIG_BLK_DEV_NS87415 is not set
> # CONFIG_BLK_DEV_OPTI621 is not set
> # CONFIG_BLK_DEV_PDC202XX_OLD is not set
> # CONFIG_PDC202XX_BURST is not set
> # CONFIG_BLK_DEV_PDC202XX_NEW is not set
> # CONFIG_BLK_DEV_RZ1000 is not set
> # CONFIG_BLK_DEV_SC1200 is not set
> # CONFIG_BLK_DEV_SVWKS is not set
> # CONFIG_BLK_DEV_SIIMAGE is not set
> # CONFIG_BLK_DEV_SIS5513 is not set
> # CONFIG_BLK_DEV_SLC90E66 is not set
> # CONFIG_BLK_DEV_TRM290 is not set
> # CONFIG_BLK_DEV_VIA82CXXX is not set
> # CONFIG_IDE_CHIPSETS is not set
> CONFIG_IDEDMA_AUTO=y
> # CONFIG_IDEDMA_IVB is not set
> # CONFIG_DMA_NONPCI is not set
> CONFIG_BLK_DEV_IDE_MODES=y
> # CONFIG_BLK_DEV_ATARAID is not set
> # CONFIG_BLK_DEV_ATARAID_PDC is not set
> # CONFIG_BLK_DEV_ATARAID_HPT is not set
> # CONFIG_BLK_DEV_ATARAID_SII is not set
> 
> #
> # SCSI support
> #
> CONFIG_SCSI=y
> 
> #
> # SCSI support type (disk, tape, CD-ROM)
> #
> CONFIG_BLK_DEV_SD=y
> CONFIG_SD_EXTRA_DEVS=40
> CONFIG_CHR_DEV_ST=y
> CONFIG_CHR_DEV_OSST=y
> CONFIG_BLK_DEV_SR=y
> CONFIG_BLK_DEV_SR_VENDOR=y
> CONFIG_SR_EXTRA_DEVS=2
> CONFIG_CHR_DEV_SG=y
> 
> #
> # Some SCSI devices (e.g. CD jukebox) support multiple LUNs
> #
> CONFIG_SCSI_DEBUG_QUEUES=y
> CONFIG_SCSI_MULTI_LUN=y
> # CONFIG_SCSI_CONSTANTS is not set
> # CONFIG_SCSI_LOGGING is not set
> 
> #
> # SCSI low-level drivers
> #
> # CONFIG_BLK_DEV_3W_XXXX_RAID is not set
> # CONFIG_SCSI_7000FASST is not set
> # CONFIG_SCSI_ACARD is not set
> # CONFIG_SCSI_AHA152X is not set
> # CONFIG_SCSI_AHA1542 is not set
> # CONFIG_SCSI_AHA1740 is not set
> # CONFIG_SCSI_AACRAID is not set
> # CONFIG_SCSI_AIC7XXX is not set
> # CONFIG_SCSI_AIC79XX is not set
> # CONFIG_SCSI_AIC7XXX_OLD is not set
> # CONFIG_SCSI_DPT_I2O is not set
> # CONFIG_SCSI_ADVANSYS is not set
> # CONFIG_SCSI_IN2000 is not set
> # CONFIG_SCSI_AM53C974 is not set
> # CONFIG_SCSI_MEGARAID is not set
> # CONFIG_SCSI_MEGARAID2 is not set
> # CONFIG_SCSI_ATA is not set
> # CONFIG_SCSI_ATA_PIIX is not set
> # CONFIG_SCSI_BUSLOGIC is not set
> # CONFIG_SCSI_CPQFCTS is not set
> # CONFIG_SCSI_DMX3191D is not set
> # CONFIG_SCSI_DTC3280 is not set
> # CONFIG_SCSI_EATA is not set
> # CONFIG_SCSI_EATA_DMA is not set
> # CONFIG_SCSI_EATA_PIO is not set
> # CONFIG_SCSI_FUTURE_DOMAIN is not set
> # CONFIG_SCSI_GDTH is not set
> # CONFIG_SCSI_GENERIC_NCR5380 is not set
> # CONFIG_SCSI_IPS is not set
> # CONFIG_SCSI_INITIO is not set
> # CONFIG_SCSI_INIA100 is not set
> # CONFIG_SCSI_PPA is not set
> # CONFIG_SCSI_IMM is not set
> # CONFIG_SCSI_NCR53C406A is not set
> # CONFIG_SCSI_NCR53C7xx is not set
> # CONFIG_SCSI_SYM53C8XX_2 is not set
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
> # CONFIG_SCSI_SIM710 is not set
> # CONFIG_SCSI_SYM53C416 is not set
> # CONFIG_SCSI_DC390T is not set
> # CONFIG_SCSI_T128 is not set
> # CONFIG_SCSI_U14_34F is not set
> # CONFIG_SCSI_ULTRASTOR is not set
> # CONFIG_SCSI_NSP32 is not set
> # CONFIG_SCSI_DEBUG is not set
> 
> #
> # PCMCIA SCSI adapter support
> #
> # CONFIG_SCSI_PCMCIA is not set
> 
> #
> # Fusion MPT device support
> #
> # CONFIG_FUSION is not set
> # CONFIG_FUSION_BOOT is not set
> # CONFIG_FUSION_ISENSE is not set
> # CONFIG_FUSION_CTL is not set
> # CONFIG_FUSION_LAN is not set
> 
> #
> # IEEE 1394 (FireWire) support (EXPERIMENTAL)
> #
> CONFIG_IEEE1394=y
> 
> #
> # Device Drivers
> #
> 
> #
> #   Texas Instruments PCILynx requires I2C bit-banging
> #
> CONFIG_IEEE1394_OHCI1394=y
> 
> #
> # Protocol Drivers
> #
> CONFIG_IEEE1394_VIDEO1394=m
> CONFIG_IEEE1394_SBP2=m
> CONFIG_IEEE1394_SBP2_PHYS_DMA=y
> CONFIG_IEEE1394_ETH1394=m
> CONFIG_IEEE1394_DV1394=m
> CONFIG_IEEE1394_RAWIO=m
> CONFIG_IEEE1394_CMP=m
> CONFIG_IEEE1394_AMDTP=m
> CONFIG_IEEE1394_VERBOSEDEBUG=y
> CONFIG_IEEE1394_OUI_DB=y
> 
> #
> # I2O device support
> #
> CONFIG_I2O=y
> CONFIG_I2O_PCI=y
> CONFIG_I2O_BLOCK=y
> CONFIG_I2O_LAN=y
> CONFIG_I2O_SCSI=y
> CONFIG_I2O_PROC=y
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
> CONFIG_DUMMY=m
> # CONFIG_BONDING is not set
> # CONFIG_EQUALIZER is not set
> CONFIG_TUN=y
> # CONFIG_ETHERTAP is not set
> # CONFIG_NET_SB1000 is not set
> 
> #
> # Ethernet (10 or 100Mbit)
> #
> CONFIG_NET_ETHERNET=y
> # CONFIG_SUNLANCE is not set
> # CONFIG_HAPPYMEAL is not set
> # CONFIG_SUNBMAC is not set
> # CONFIG_SUNQE is not set
> # CONFIG_SUNGEM is not set
> # CONFIG_NET_VENDOR_3COM is not set
> # CONFIG_LANCE is not set
> # CONFIG_NET_VENDOR_SMC is not set
> # CONFIG_NET_VENDOR_RACAL is not set
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
> # CONFIG_TULIP is not set
> # CONFIG_DE4X5 is not set
> # CONFIG_DGRS is not set
> # CONFIG_DM9102 is not set
> # CONFIG_EEPRO100 is not set
> # CONFIG_EEPRO100_PIO is not set
> CONFIG_E100=y
> # CONFIG_LNE390 is not set
> # CONFIG_FEALNX is not set
> # CONFIG_NATSEMI is not set
> # CONFIG_NE2K_PCI is not set
> # CONFIG_NE3210 is not set
> # CONFIG_ES3210 is not set
> # CONFIG_8139CP is not set
> # CONFIG_8139TOO is not set
> # CONFIG_8139TOO_PIO is not set
> # CONFIG_8139TOO_TUNE_TWISTER is not set
> # CONFIG_8139TOO_8129 is not set
> # CONFIG_8139_OLD_RX_RESET is not set
> # CONFIG_SIS900 is not set
> # CONFIG_EPIC100 is not set
> # CONFIG_SUNDANCE is not set
> # CONFIG_SUNDANCE_MMIO is not set
> # CONFIG_TLAN is not set
> # CONFIG_TC35815 is not set
> # CONFIG_VIA_RHINE is not set
> # CONFIG_VIA_RHINE_MMIO is not set
> # CONFIG_WINBOND_840 is not set
> # CONFIG_NET_POCKET is not set
> 
> #
> # Ethernet (1000 Mbit)
> #
> # CONFIG_ACENIC is not set
> # CONFIG_DL2K is not set
> # CONFIG_E1000 is not set
> # CONFIG_MYRI_SBUS is not set
> # CONFIG_NS83820 is not set
> # CONFIG_HAMACHI is not set
> # CONFIG_YELLOWFIN is not set
> # CONFIG_R8169 is not set
> # CONFIG_SK98LIN is not set
> # CONFIG_TIGON3 is not set
> # CONFIG_FDDI is not set
> # CONFIG_HIPPI is not set
> # CONFIG_PLIP is not set
> CONFIG_PPP=m
> CONFIG_PPP_MULTILINK=y
> CONFIG_PPP_FILTER=y
> CONFIG_PPP_ASYNC=m
> CONFIG_PPP_SYNC_TTY=m
> CONFIG_PPP_DEFLATE=m
> CONFIG_PPP_BSDCOMP=m
> CONFIG_PPPOE=m
> # CONFIG_SLIP is not set
> 
> #
> # Wireless LAN (non-hamradio)
> #
> CONFIG_NET_RADIO=y
> # CONFIG_STRIP is not set
> # CONFIG_WAVELAN is not set
> # CONFIG_ARLAN is not set
> # CONFIG_AIRONET4500 is not set
> # CONFIG_AIRONET4500_NONCS is not set
> # CONFIG_AIRONET4500_PROC is not set
> # CONFIG_AIRO is not set
> # CONFIG_HERMES is not set
> # CONFIG_PLX_HERMES is not set
> # CONFIG_PCI_HERMES is not set
> 
> #
> # Wireless Pcmcia cards support
> #
> # CONFIG_PCMCIA_HERMES is not set
> # CONFIG_AIRO_CS is not set
> CONFIG_NET_WIRELESS=y
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
> # PCMCIA network device support
> #
> # CONFIG_NET_PCMCIA is not set
> 
> #
> # Amateur Radio support
> #
> # CONFIG_HAMRADIO is not set
> 
> #
> # IrDA (infrared) support
> #
> CONFIG_IRDA=m
> 
> #
> # IrDA protocols
> #
> CONFIG_IRLAN=m
> CONFIG_IRNET=m
> CONFIG_IRCOMM=m
> CONFIG_IRDA_ULTRA=y
> 
> #
> # IrDA options
> #
> CONFIG_IRDA_CACHE_LAST_LSAP=y
> CONFIG_IRDA_FAST_RR=y
> CONFIG_IRDA_DEBUG=y
> 
> #
> # Infrared-port device drivers
> #
> 
> #
> # SIR device drivers
> #
> CONFIG_IRTTY_SIR=m
> CONFIG_IRPORT_SIR=m
> 
> #
> # Dongle support
> #
> CONFIG_DONGLE=y
> CONFIG_ESI_DONGLE=m
> CONFIG_ACTISYS_DONGLE=m
> CONFIG_TEKRAM_DONGLE=m
> CONFIG_GIRBIL_DONGLE=m
> CONFIG_LITELINK_DONGLE=m
> CONFIG_MCP2120_DONGLE=m
> CONFIG_OLD_BELKIN_DONGLE=m
> CONFIG_ACT200L_DONGLE=m
> CONFIG_MA600_DONGLE=m
> 
> #
> # FIR device drivers
> #
> CONFIG_USB_IRDA=m
> CONFIG_NSC_FIR=m
> CONFIG_WINBOND_FIR=m
> CONFIG_TOSHIBA_OLD=m
> CONFIG_TOSHIBA_FIR=m
> CONFIG_SMC_IRCC_FIR=m
> CONFIG_ALI_FIR=m
> CONFIG_VLSI_FIR=m
> 
> #
> # ISDN subsystem
> #
> # CONFIG_ISDN is not set
> 
> #
> # Old CD-ROM drivers (not SCSI, not IDE)
> #
> # CONFIG_CD_NO_IDESCSI is not set
> 
> #
> # Input core support
> #
> CONFIG_INPUT=m
> CONFIG_INPUT_KEYBDEV=m
> CONFIG_INPUT_MOUSEDEV=m
> CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
> CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
> CONFIG_INPUT_JOYDEV=m
> CONFIG_INPUT_EVDEV=m
> 
> #
> # Character devices
> #
> CONFIG_VT=y
> CONFIG_VT_CONSOLE=y
> CONFIG_SERIAL=y
> # CONFIG_SERIAL_CONSOLE is not set
> # CONFIG_SERIAL_EXTENDED is not set
> # CONFIG_SERIAL_NONSTANDARD is not set
> CONFIG_UNIX98_PTYS=y
> CONFIG_UNIX98_PTY_COUNT=256
> CONFIG_PRINTER=y
> # CONFIG_LP_CONSOLE is not set
> # CONFIG_PPDEV is not set
> # CONFIG_TIPAR is not set
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
> CONFIG_MOUSE=y
> CONFIG_PSMOUSE=y
> # CONFIG_82C710_MOUSE is not set
> # CONFIG_PC110_PAD is not set
> # CONFIG_MK712_MOUSE is not set
> 
> #
> # Joysticks
> #
> # CONFIG_INPUT_GAMEPORT is not set
> # CONFIG_INPUT_NS558 is not set
> # CONFIG_INPUT_LIGHTNING is not set
> # CONFIG_INPUT_PCIGAME is not set
> # CONFIG_INPUT_CS461X is not set
> # CONFIG_INPUT_EMU10K1 is not set
> # CONFIG_INPUT_SERIO is not set
> # CONFIG_INPUT_SERPORT is not set
> 
> #
> # Joysticks
> #
> # CONFIG_INPUT_ANALOG is not set
> # CONFIG_INPUT_A3D is not set
> # CONFIG_INPUT_ADI is not set
> # CONFIG_INPUT_COBRA is not set
> # CONFIG_INPUT_GF2K is not set
> # CONFIG_INPUT_GRIP is not set
> # CONFIG_INPUT_INTERACT is not set
> # CONFIG_INPUT_TMDC is not set
> # CONFIG_INPUT_SIDEWINDER is not set
> # CONFIG_INPUT_IFORCE_USB is not set
> # CONFIG_INPUT_IFORCE_232 is not set
> # CONFIG_INPUT_WARRIOR is not set
> # CONFIG_INPUT_MAGELLAN is not set
> # CONFIG_INPUT_SPACEORB is not set
> # CONFIG_INPUT_SPACEBALL is not set
> # CONFIG_INPUT_STINGER is not set
> # CONFIG_INPUT_DB9 is not set
> # CONFIG_INPUT_GAMECON is not set
> # CONFIG_INPUT_TURBOGRAFX is not set
> # CONFIG_QIC02_TAPE is not set
> # CONFIG_IPMI_HANDLER is not set
> # CONFIG_IPMI_PANIC_EVENT is not set
> # CONFIG_IPMI_DEVICE_INTERFACE is not set
> # CONFIG_IPMI_KCS is not set
> # CONFIG_IPMI_WATCHDOG is not set
> 
> #
> # Watchdog Cards
> #
> # CONFIG_WATCHDOG is not set
> # CONFIG_SCx200_GPIO is not set
> # CONFIG_AMD_RNG is not set
> CONFIG_INTEL_RNG=y
> # CONFIG_AMD_PM768 is not set
> CONFIG_NVRAM=y
> CONFIG_RTC=y
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
> CONFIG_AGP_INTEL=y
> CONFIG_AGP_I810=y
> # CONFIG_AGP_VIA is not set
> # CONFIG_AGP_AMD is not set
> # CONFIG_AGP_AMD_8151 is not set
> # CONFIG_AGP_SIS is not set
> # CONFIG_AGP_ALI is not set
> # CONFIG_AGP_SWORKS is not set
> # CONFIG_AGP_NVIDIA is not set
> # CONFIG_AGP_ATI is not set
> CONFIG_DRM=y
> # CONFIG_DRM_OLD is not set
> 
> #
> # DRM 4.1 drivers
> #
> CONFIG_DRM_NEW=y
> # CONFIG_DRM_TDFX is not set
> # CONFIG_DRM_GAMMA is not set
> # CONFIG_DRM_R128 is not set
> CONFIG_DRM_RADEON=y
> # CONFIG_DRM_I810 is not set
> # CONFIG_DRM_I810_XFREE_41 is not set
> # CONFIG_DRM_I830 is not set
> # CONFIG_DRM_MGA is not set
> # CONFIG_DRM_S3 is not set
> # CONFIG_DRM_SIS is not set
> # CONFIG_DRM_VIA is not set
> 
> #
> # PCMCIA character devices
> #
> # CONFIG_PCMCIA_SERIAL_CS is not set
> # CONFIG_SYNCLINK_CS is not set
> # CONFIG_MWAVE is not set
> 
> #
> # Multimedia devices
> #
> # CONFIG_VIDEO_DEV is not set
> 
> #
> # File systems
> #
> # CONFIG_QUOTA is not set
> # CONFIG_QFMT_V2 is not set
> # CONFIG_AUTOFS_FS is not set
> CONFIG_AUTOFS4_FS=y
> # CONFIG_REISERFS_FS is not set
> # CONFIG_REISERFS_CHECK is not set
> # CONFIG_REISERFS_PROC_INFO is not set
> # CONFIG_ADFS_FS is not set
> # CONFIG_ADFS_FS_RW is not set
> # CONFIG_AFFS_FS is not set
> # CONFIG_HFS_FS is not set
> # CONFIG_HFSPLUS_FS is not set
> # CONFIG_BEFS_FS is not set
> # CONFIG_BEFS_DEBUG is not set
> # CONFIG_BFS_FS is not set
> CONFIG_EXT3_FS=y
> CONFIG_JBD=y
> CONFIG_JBD_DEBUG=y
> CONFIG_FAT_FS=y
> CONFIG_MSDOS_FS=y
> CONFIG_UMSDOS_FS=y
> CONFIG_VFAT_FS=y
> # CONFIG_EFS_FS is not set
> # CONFIG_JFFS_FS is not set
> # CONFIG_JFFS2_FS is not set
> # CONFIG_CRAMFS is not set
> CONFIG_TMPFS=y
> CONFIG_RAMFS=y
> CONFIG_ISO9660_FS=y
> CONFIG_JOLIET=y
> CONFIG_ZISOFS=y
> # CONFIG_JFS_FS is not set
> # CONFIG_JFS_DEBUG is not set
> # CONFIG_JFS_STATISTICS is not set
> # CONFIG_MINIX_FS is not set
> # CONFIG_VXFS_FS is not set
> # CONFIG_NTFS_FS is not set
> # CONFIG_NTFS_RW is not set
> # CONFIG_HPFS_FS is not set
> CONFIG_PROC_FS=y
> # CONFIG_DEVFS_FS is not set
> # CONFIG_DEVFS_MOUNT is not set
> # CONFIG_DEVFS_DEBUG is not set
> CONFIG_DEVPTS_FS=y
> # CONFIG_QNX4FS_FS is not set
> # CONFIG_QNX4FS_RW is not set
> # CONFIG_ROMFS_FS is not set
> CONFIG_EXT2_FS=y
> # CONFIG_SYSV_FS is not set
> CONFIG_UDF_FS=y
> CONFIG_UDF_RW=y
> CONFIG_UFS_FS=y
> CONFIG_UFS_FS_WRITE=y
> # CONFIG_XFS_FS is not set
> # CONFIG_XFS_RT is not set
> # CONFIG_XFS_QUOTA is not set
> 
> #
> # Network File Systems
> #
> # CONFIG_CODA_FS is not set
> # CONFIG_INTERMEZZO_FS is not set
> CONFIG_NFS_FS=y
> CONFIG_NFS_V3=y
> # CONFIG_NFS_DIRECTIO is not set
> # CONFIG_ROOT_NFS is not set
> CONFIG_NFSD=y
> CONFIG_NFSD_V3=y
> # CONFIG_NFSD_TCP is not set
> CONFIG_SUNRPC=y
> CONFIG_LOCKD=y
> CONFIG_LOCKD_V4=y
> CONFIG_SMB_FS=y
> CONFIG_SMB_NLS_DEFAULT=y
> CONFIG_SMB_NLS_REMOTE="cp850"
> # CONFIG_NCP_FS is not set
> # CONFIG_NCPFS_PACKET_SIGNING is not set
> # CONFIG_NCPFS_IOCTL_LOCKING is not set
> # CONFIG_NCPFS_STRONG is not set
> # CONFIG_NCPFS_NFS_NS is not set
> # CONFIG_NCPFS_OS2_NS is not set
> # CONFIG_NCPFS_SMALLDOS is not set
> # CONFIG_NCPFS_NLS is not set
> # CONFIG_NCPFS_EXTRAS is not set
> CONFIG_ZISOFS_FS=y
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
> CONFIG_BSD_DISKLABEL=y
> # CONFIG_MINIX_SUBPARTITION is not set
> # CONFIG_SOLARIS_X86_PARTITION is not set
> # CONFIG_UNIXWARE_DISKLABEL is not set
> CONFIG_LDM_PARTITION=y
> # CONFIG_LDM_DEBUG is not set
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
> CONFIG_NLS_DEFAULT="iso8859-15"
> CONFIG_NLS_CODEPAGE_437=y
> # CONFIG_NLS_CODEPAGE_737 is not set
> # CONFIG_NLS_CODEPAGE_775 is not set
> CONFIG_NLS_CODEPAGE_850=y
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
> CONFIG_NLS_CODEPAGE_1250=y
> CONFIG_NLS_CODEPAGE_1251=y
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
> CONFIG_NLS_ISO8859_15=y
> # CONFIG_NLS_KOI8_R is not set
> # CONFIG_NLS_KOI8_U is not set
> CONFIG_NLS_UTF8=y
> 
> #
> # Console drivers
> #
> CONFIG_VGA_CONSOLE=y
> CONFIG_VIDEO_SELECT=y
> # CONFIG_MDA_CONSOLE is not set
> 
> #
> # Frame-buffer support
> #
> CONFIG_FB=y
> CONFIG_DUMMY_CONSOLE=y
> # CONFIG_FB_RIVA is not set
> # CONFIG_FB_CLGEN is not set
> # CONFIG_FB_PM2 is not set
> # CONFIG_FB_PM3 is not set
> # CONFIG_FB_CYBER2000 is not set
> CONFIG_FB_VESA=y
> # CONFIG_FB_VGA16 is not set
> # CONFIG_FB_HGA is not set
> CONFIG_VIDEO_SELECT=y
> # CONFIG_FB_MATROX is not set
> # CONFIG_FB_ATY is not set
> CONFIG_FB_RADEON=m
> # CONFIG_FB_ATY128 is not set
> # CONFIG_FB_INTEL is not set
> # CONFIG_FB_SIS is not set
> # CONFIG_FB_NEOMAGIC is not set
> # CONFIG_FB_3DFX is not set
> # CONFIG_FB_VOODOO1 is not set
> # CONFIG_FB_TRIDENT is not set
> # CONFIG_FB_VIRTUAL is not set
> # CONFIG_FBCON_ADVANCED is not set
> CONFIG_FBCON_CFB8=y
> CONFIG_FBCON_CFB16=y
> CONFIG_FBCON_CFB24=y
> CONFIG_FBCON_CFB32=y
> # CONFIG_FBCON_FONTWIDTH8_ONLY is not set
> # CONFIG_FBCON_FONTS is not set
> CONFIG_FONT_8x8=y
> CONFIG_FONT_8x16=y
> 
> #
> # Sound
> #
> CONFIG_SOUND=y
> # CONFIG_SOUND_ALI5455 is not set
> # CONFIG_SOUND_BT878 is not set
> # CONFIG_SOUND_CMPCI is not set
> # CONFIG_SOUND_EMU10K1 is not set
> # CONFIG_MIDI_EMU10K1 is not set
> # CONFIG_SOUND_FUSION is not set
> # CONFIG_SOUND_CS4281 is not set
> # CONFIG_SOUND_ES1370 is not set
> # CONFIG_SOUND_ES1371 is not set
> # CONFIG_SOUND_ESSSOLO1 is not set
> # CONFIG_SOUND_MAESTRO is not set
> # CONFIG_SOUND_MAESTRO3 is not set
> # CONFIG_SOUND_FORTE is not set
> CONFIG_SOUND_ICH=y
> # CONFIG_SOUND_RME96XX is not set
> # CONFIG_SOUND_SONICVIBES is not set
> # CONFIG_SOUND_TRIDENT is not set
> # CONFIG_SOUND_MSNDCLAS is not set
> # CONFIG_SOUND_MSNDPIN is not set
> # CONFIG_SOUND_VIA82CXXX is not set
> # CONFIG_MIDI_VIA82CXXX is not set
> # CONFIG_SOUND_OSS is not set
> # CONFIG_SOUND_TVMIXER is not set
> # CONFIG_SOUND_AD1980 is not set
> # CONFIG_SOUND_WM97XX is not set
> 
> #
> # USB support
> #
> CONFIG_USB=y
> # CONFIG_USB_DEBUG is not set
> 
> #
> # Miscellaneous USB options
> #
> CONFIG_USB_DEVICEFS=y
> CONFIG_USB_BANDWIDTH=y
> 
> #
> # USB Host Controller Drivers
> #
> CONFIG_USB_EHCI_HCD=y
> CONFIG_USB_UHCI_ALT=y
> CONFIG_USB_OHCI=m
> 
> #
> # USB Device Class drivers
> #
> CONFIG_USB_AUDIO=m
> CONFIG_USB_EMI26=m
> CONFIG_USB_BLUETOOTH=m
> CONFIG_USB_MIDI=m
> CONFIG_USB_STORAGE=y
> CONFIG_USB_STORAGE_DEBUG=y
> CONFIG_USB_STORAGE_DATAFAB=y
> CONFIG_USB_STORAGE_FREECOM=y
> CONFIG_USB_STORAGE_ISD200=y
> CONFIG_USB_STORAGE_DPCM=y
> CONFIG_USB_STORAGE_HP8200e=y
> CONFIG_USB_STORAGE_SDDR09=y
> CONFIG_USB_STORAGE_SDDR55=y
> CONFIG_USB_STORAGE_JUMPSHOT=y
> CONFIG_USB_ACM=m
> CONFIG_USB_PRINTER=m
> 
> #
> # USB Human Interface Devices (HID)
> #
> CONFIG_USB_HID=m
> CONFIG_USB_HIDINPUT=y
> CONFIG_USB_HIDDEV=y
> CONFIG_USB_KBD=m
> CONFIG_USB_MOUSE=m
> CONFIG_USB_AIPTEK=m
> CONFIG_USB_WACOM=m
> CONFIG_USB_KBTAB=m
> CONFIG_USB_POWERMATE=m
> 
> #
> # USB Imaging devices
> #
> CONFIG_USB_DC2XX=m
> CONFIG_USB_MDC800=m
> CONFIG_USB_SCANNER=m
> CONFIG_USB_MICROTEK=m
> CONFIG_USB_HPUSBSCSI=m
> 
> #
> # USB Multimedia devices
> #
> 
> #
> #   Video4Linux support is needed for USB Multimedia device support
> #
> 
> #
> # USB Network adaptors
> #
> CONFIG_USB_PEGASUS=m
> CONFIG_USB_RTL8150=m
> CONFIG_USB_KAWETH=m
> CONFIG_USB_CATC=m
> CONFIG_USB_AX8817X=m
> CONFIG_USB_CDCETHER=m
> CONFIG_USB_USBNET=m
> 
> #
> # USB port drivers
> #
> CONFIG_USB_USS720=m
> 
> #
> # USB Serial Converter support
> #
> CONFIG_USB_SERIAL=m
> # CONFIG_USB_SERIAL_DEBUG is not set
> CONFIG_USB_SERIAL_GENERIC=y
> CONFIG_USB_SERIAL_BELKIN=m
> CONFIG_USB_SERIAL_WHITEHEAT=m
> CONFIG_USB_SERIAL_DIGI_ACCELEPORT=m
> CONFIG_USB_SERIAL_EMPEG=m
> CONFIG_USB_SERIAL_FTDI_SIO=m
> CONFIG_USB_SERIAL_VISOR=m
> CONFIG_USB_SERIAL_IPAQ=m
> CONFIG_USB_SERIAL_IR=m
> CONFIG_USB_SERIAL_EDGEPORT=m
> CONFIG_USB_SERIAL_EDGEPORT_TI=m
> CONFIG_USB_SERIAL_KEYSPAN_PDA=m
> CONFIG_USB_SERIAL_KEYSPAN=m
> CONFIG_USB_SERIAL_KEYSPAN_USA28=y
> CONFIG_USB_SERIAL_KEYSPAN_USA28X=y
> CONFIG_USB_SERIAL_KEYSPAN_USA28XA=y
> CONFIG_USB_SERIAL_KEYSPAN_USA28XB=y
> CONFIG_USB_SERIAL_KEYSPAN_USA19=y
> CONFIG_USB_SERIAL_KEYSPAN_USA18X=y
> CONFIG_USB_SERIAL_KEYSPAN_USA19W=y
> CONFIG_USB_SERIAL_KEYSPAN_USA19QW=y
> CONFIG_USB_SERIAL_KEYSPAN_USA19QI=y
> CONFIG_USB_SERIAL_KEYSPAN_MPR=y
> CONFIG_USB_SERIAL_KEYSPAN_USA49W=y
> CONFIG_USB_SERIAL_KEYSPAN_USA49WLC=y
> CONFIG_USB_SERIAL_MCT_U232=m
> CONFIG_USB_SERIAL_KLSI=m
> CONFIG_USB_SERIAL_KOBIL_SCT=m
> CONFIG_USB_SERIAL_PL2303=m
> CONFIG_USB_SERIAL_CYBERJACK=m
> CONFIG_USB_SERIAL_XIRCOM=m
> CONFIG_USB_SERIAL_OMNINET=m
> 
> #
> # USB Miscellaneous drivers
> #
> CONFIG_USB_RIO500=m
> CONFIG_USB_AUERSWALD=m
> CONFIG_USB_TIGL=m
> CONFIG_USB_BRLVGER=m
> CONFIG_USB_LCD=m
> 
> #
> # Bluetooth support
> #
> # CONFIG_BLUEZ is not set
> 
> #
> # Kernel hacking
> #
> CONFIG_DEBUG_KERNEL=y
> CONFIG_DEBUG_STACKOVERFLOW=y
> # CONFIG_FRAME_POINTER is not set
> # CONFIG_DEBUG_HIGHMEM is not set
> # CONFIG_DEBUG_SLAB is not set
> # CONFIG_DEBUG_IOVIRT is not set
> CONFIG_MAGIC_SYSRQ=y
> # CONFIG_PANIC_MORSE is not set
> # CONFIG_DEBUG_SPINLOCK is not set
> 
> #
> # Cryptographic options
> #
> CONFIG_CRYPTO=y
> CONFIG_CRYPTO_HMAC=y
> CONFIG_CRYPTO_NULL=m
> CONFIG_CRYPTO_MD4=m
> CONFIG_CRYPTO_MD5=m
> CONFIG_CRYPTO_SHA1=m
> CONFIG_CRYPTO_SHA256=m
> CONFIG_CRYPTO_SHA512=m
> CONFIG_CRYPTO_DES=m
> CONFIG_CRYPTO_BLOWFISH=m
> CONFIG_CRYPTO_TWOFISH=m
> CONFIG_CRYPTO_SERPENT=m
> CONFIG_CRYPTO_AES=m
> CONFIG_CRYPTO_DEFLATE=m
> CONFIG_CRYPTO_TEST=m
> 
> #
> # Library routines
> #
> CONFIG_CRC32=y
> CONFIG_ZLIB_INFLATE=y
> CONFIG_ZLIB_DEFLATE=m
> # CONFIG_FW_LOADER is not set
> 
> 
> -- 
> Ruben Puettmann
> ruben@puettmann.net
> http://www.puettmann.net
> 
> 
> -------------------------------------------------------
> This SF.Net email sponsored by: Free pre-built ASP.NET sites including
> Data Reports, E-commerce, Portals, and Forums are available now.
> Download today and enter to win an XBOX or Visual Studio .NET.
> http://aspnet.click-url.com/go/psa00100003ave/direct;at.aspnet
_072303_01/01
_______________________________________________
Dri-users mailing list
Dri-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/dri-users


