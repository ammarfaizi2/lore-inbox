Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261845AbULaK7q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261845AbULaK7q (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Dec 2004 05:59:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261848AbULaK7q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Dec 2004 05:59:46 -0500
Received: from wproxy.gmail.com ([64.233.184.203]:48986 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261845AbULaK53 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Dec 2004 05:57:29 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=nNL5EoqGVviQE8205bS33vfbN2xUgdMDI0/0OOkLlzgpNu0SxVEok6oP0OhOxx5FxCjRpSSSbL8XOs78U/07wNgUMwn3dO2UBQaZnSYMFHaJdFSpauhZRHVZBSXVeHDrvnSrSjf46kCqR7Wl3Hl+ZBeGWnhw4m1kd9QqXPEe6So=
Message-ID: <297f4e0104123102571bb1759f@mail.gmail.com>
Date: Fri, 31 Dec 2004 11:57:28 +0100
From: Ikke <ikke.lkml@gmail.com>
Reply-To: Ikke <ikke.lkml@gmail.com>
To: Michael Berger <mikeb1@t-online.de>
Subject: Re: Compile error in kernel 2.6.10-bk3 in file slhc.c
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <41D5009E.4090100@t-online.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <3hbOM-43L-21@gated-at.bofh.it> <41D5009E.4090100@t-online.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I had the same issue yesterday (posted on this list), one in CIFS,
other one in some socket definition, then I gave up ;-)

Could you point me to the patch please?

Thanks, Ikke


On Fri, 31 Dec 2004 08:32:46 +0100, Michael Berger <mikeb1@t-online.de> wrote:
> Michael Berger wrote:
> > Dear LKML
> >
> > I get following compile error in file slhc.c with kernel 2.6.10-bk3 and
> > attached my .config file:
> >
> > gcc -Wp,-MD,drivers/net/.slhc.o.d -nostdinc -iwithprefix include
> > -D__KERNEL__ -Iinclude  -Wall -Wstrict-prototypes -Wno-trigraphs
> > -fno-strict-aliasing -fno-common -O2     -fomit-frame-pointer -pipe
> > -msoft-float -mpreferred-stack-boundary=2 -fno-unit-at-a-time
> > -march=i686 -mtune=pentium3 -mregparm=3 -Iinclude/asm-i386/mach-default
> > -Wdeclaration-after-statement   -DMODULE -DKBUILD_BASENAME=slhc
> > -DKBUILD_MODNAME=slhc -c -o drivers/net/slhc.o drivers/net/slhc.c
> > In file included from include/net/dsfield.h:11,
> >                 from include/net/inet_ecn.h:5,
> >                 from include/net/tcp_ecn.h:4,
> >                 from include/net/tcp.h:1163,
> >                 from drivers/net/slhc.c:74:
> > include/linux/ipv6.h: In function `inet6_sk':
> > include/linux/ipv6.h:278: error: structure has no member named `pinet6'
> > make[2]: *** [drivers/net/slhc.o] Error 1
> > make[1]: *** [drivers/net] Error 2
> > make: *** [drivers] Error 2
> >
> > Compiled with GCC 3.4.3.
> >
> > --Michael
> >
> > 
> > ------------------------------------------------------------------------
> >
> > #
> > # Automatically generated make config: don't edit
> > # Linux kernel version: 2.6.10-bk3
> > # Thu Dec 30 17:35:05 2004
> > #
> > CONFIG_X86=y
> > CONFIG_MMU=y
> > CONFIG_UID16=y
> > CONFIG_GENERIC_ISA_DMA=y
> > CONFIG_GENERIC_IOMAP=y
> >
> > #
> > # Code maturity level options
> > #
> > CONFIG_EXPERIMENTAL=y
> > CONFIG_CLEAN_COMPILE=y
> > CONFIG_BROKEN_ON_SMP=y
> >
> > #
> > # General setup
> > #
> > CONFIG_LOCALVERSION=""
> > CONFIG_SWAP=y
> > CONFIG_SYSVIPC=y
> > CONFIG_POSIX_MQUEUE=y
> > CONFIG_BSD_PROCESS_ACCT=y
> > # CONFIG_BSD_PROCESS_ACCT_V3 is not set
> > CONFIG_SYSCTL=y
> > # CONFIG_AUDIT is not set
> > CONFIG_LOG_BUF_SHIFT=14
> > CONFIG_HOTPLUG=y
> > CONFIG_KOBJECT_UEVENT=y
> > # CONFIG_IKCONFIG is not set
> > CONFIG_EMBEDDED=y
> > CONFIG_KALLSYMS=y
> > # CONFIG_KALLSYMS_EXTRA_PASS is not set
> > CONFIG_FUTEX=y
> > CONFIG_EPOLL=y
> > # CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
> > CONFIG_SHMEM=y
> > CONFIG_CC_ALIGN_FUNCTIONS=0
> > CONFIG_CC_ALIGN_LABELS=0
> > CONFIG_CC_ALIGN_LOOPS=0
> > CONFIG_CC_ALIGN_JUMPS=0
> > # CONFIG_TINY_SHMEM is not set
> >
> > #
> > # Loadable module support
> > #
> > CONFIG_MODULES=y
> > CONFIG_MODULE_UNLOAD=y
> > CONFIG_MODULE_FORCE_UNLOAD=y
> > CONFIG_OBSOLETE_MODPARM=y
> > # CONFIG_MODVERSIONS is not set
> > # CONFIG_MODULE_SRCVERSION_ALL is not set
> > CONFIG_KMOD=y
> >
> > #
> > # Processor type and features
> > #
> > CONFIG_X86_PC=y
> > # CONFIG_X86_ELAN is not set
> > # CONFIG_X86_VOYAGER is not set
> > # CONFIG_X86_NUMAQ is not set
> > # CONFIG_X86_SUMMIT is not set
> > # CONFIG_X86_BIGSMP is not set
> > # CONFIG_X86_VISWS is not set
> > # CONFIG_X86_GENERICARCH is not set
> > # CONFIG_X86_ES7000 is not set
> > # CONFIG_M386 is not set
> > # CONFIG_M486 is not set
> > # CONFIG_M586 is not set
> > # CONFIG_M586TSC is not set
> > # CONFIG_M586MMX is not set
> > # CONFIG_M686 is not set
> > # CONFIG_MPENTIUMII is not set
> > CONFIG_MPENTIUMIII=y
> > # CONFIG_MPENTIUMM is not set
> > # CONFIG_MPENTIUM4 is not set
> > # CONFIG_MK6 is not set
> > # CONFIG_MK7 is not set
> > # CONFIG_MK8 is not set
> > # CONFIG_MCRUSOE is not set
> > # CONFIG_MEFFICEON is not set
> > # CONFIG_MWINCHIPC6 is not set
> > # CONFIG_MWINCHIP2 is not set
> > # CONFIG_MWINCHIP3D is not set
> > # CONFIG_MCYRIXIII is not set
> > # CONFIG_MVIAC3_2 is not set
> > # CONFIG_X86_GENERIC is not set
> > CONFIG_X86_CMPXCHG=y
> > CONFIG_X86_XADD=y
> > CONFIG_X86_L1_CACHE_SHIFT=5
> > CONFIG_RWSEM_XCHGADD_ALGORITHM=y
> > CONFIG_X86_WP_WORKS_OK=y
> > CONFIG_X86_INVLPG=y
> > CONFIG_X86_BSWAP=y
> > CONFIG_X86_POPAD_OK=y
> > CONFIG_X86_GOOD_APIC=y
> > CONFIG_X86_INTEL_USERCOPY=y
> > CONFIG_X86_USE_PPRO_CHECKSUM=y
> > CONFIG_HPET_TIMER=y
> > CONFIG_HPET_EMULATE_RTC=y
> > # CONFIG_SMP is not set
> > # CONFIG_PREEMPT is not set
> > CONFIG_X86_UP_APIC=y
> > CONFIG_X86_UP_IOAPIC=y
> > CONFIG_X86_LOCAL_APIC=y
> > CONFIG_X86_IO_APIC=y
> > CONFIG_X86_TSC=y
> > CONFIG_X86_MCE=y
> > # CONFIG_X86_MCE_NONFATAL is not set
> > # CONFIG_X86_MCE_P4THERMAL is not set
> > # CONFIG_TOSHIBA is not set
> > # CONFIG_I8K is not set
> > # CONFIG_MICROCODE is not set
> > CONFIG_X86_MSR=m
> > CONFIG_X86_CPUID=m
> >
> > #
> > # Firmware Drivers
> > #
> > # CONFIG_EDD is not set
> > CONFIG_NOHIGHMEM=y
> > # CONFIG_HIGHMEM4G is not set
> > # CONFIG_HIGHMEM64G is not set
> > # CONFIG_MATH_EMULATION is not set
> > CONFIG_MTRR=y
> > # CONFIG_EFI is not set
> > CONFIG_REGPARM=y
> >
> > #
> > # Power management options (ACPI, APM)
> > #
> > # CONFIG_PM is not set
> >
> > #
> > # ACPI (Advanced Configuration and Power Interface) Support
> > #
> > CONFIG_ACPI=y
> > CONFIG_ACPI_BOOT=y
> > CONFIG_ACPI_INTERPRETER=y
> > # CONFIG_ACPI_AC is not set
> > # CONFIG_ACPI_BATTERY is not set
> > CONFIG_ACPI_BUTTON=m
> > CONFIG_ACPI_VIDEO=m
> > CONFIG_ACPI_FAN=m
> > CONFIG_ACPI_PROCESSOR=m
> > CONFIG_ACPI_THERMAL=m
> > # CONFIG_ACPI_ASUS is not set
> > # CONFIG_ACPI_IBM is not set
> > # CONFIG_ACPI_TOSHIBA is not set
> > CONFIG_ACPI_BLACKLIST_YEAR=0
> > # CONFIG_ACPI_DEBUG is not set
> > CONFIG_ACPI_BUS=y
> > CONFIG_ACPI_EC=y
> > CONFIG_ACPI_POWER=y
> > CONFIG_ACPI_PCI=y
> > CONFIG_ACPI_SYSTEM=y
> > # CONFIG_X86_PM_TIMER is not set
> > # CONFIG_ACPI_CONTAINER is not set
> >
> > #
> > # CPU Frequency scaling
> > #
> > # CONFIG_CPU_FREQ is not set
> >
> > #
> > # Bus options (PCI, PCMCIA, EISA, MCA, ISA)
> > #
> > CONFIG_PCI=y
> > # CONFIG_PCI_GOBIOS is not set
> > # CONFIG_PCI_GOMMCONFIG is not set
> > # CONFIG_PCI_GODIRECT is not set
> > CONFIG_PCI_GOANY=y
> > CONFIG_PCI_BIOS=y
> > CONFIG_PCI_DIRECT=y
> > CONFIG_PCI_MMCONFIG=y
> > # CONFIG_PCI_MSI is not set
> > # CONFIG_PCI_LEGACY_PROC is not set
> > CONFIG_PCI_NAMES=y
> > # CONFIG_ISA is not set
> > # CONFIG_MCA is not set
> > # CONFIG_SCx200 is not set
> >
> > #
> > # PCCARD (PCMCIA/CardBus) support
> > #
> > # CONFIG_PCCARD is not set
> >
> > #
> > # PC-card bridges
> > #
> >
> > #
> > # PCI Hotplug Support
> > #
> > # CONFIG_HOTPLUG_PCI is not set
> >
> > #
> > # Executable file formats
> > #
> > CONFIG_BINFMT_ELF=y
> > CONFIG_BINFMT_AOUT=m
> > CONFIG_BINFMT_MISC=m
> >
> > #
> > # Device Drivers
> > #
> >
> > #
> > # Generic Driver Options
> > #
> > CONFIG_STANDALONE=y
> > # CONFIG_PREVENT_FIRMWARE_BUILD is not set
> > # CONFIG_FW_LOADER is not set
> >
> > #
> > # Memory Technology Devices (MTD)
> > #
> > # CONFIG_MTD is not set
> >
> > #
> > # Parallel port support
> > #
> > CONFIG_PARPORT=m
> > CONFIG_PARPORT_PC=m
> > CONFIG_PARPORT_PC_CML1=m
> > # CONFIG_PARPORT_SERIAL is not set
> > # CONFIG_PARPORT_PC_FIFO is not set
> > # CONFIG_PARPORT_PC_SUPERIO is not set
> > # CONFIG_PARPORT_OTHER is not set
> > CONFIG_PARPORT_1284=y
> >
> > #
> > # Plug and Play support
> > #
> > CONFIG_PNP=y
> > # CONFIG_PNP_DEBUG is not set
> >
> > #
> > # Protocols
> > #
> > CONFIG_PNPACPI=y
> >
> > #
> > # Block devices
> > #
> > CONFIG_BLK_DEV_FD=y
> > # CONFIG_PARIDE is not set
> > # CONFIG_BLK_CPQ_DA is not set
> > # CONFIG_BLK_CPQ_CISS_DA is not set
> > # CONFIG_BLK_DEV_DAC960 is not set
> > # CONFIG_BLK_DEV_UMEM is not set
> > CONFIG_BLK_DEV_LOOP=y
> > # CONFIG_BLK_DEV_CRYPTOLOOP is not set
> > # CONFIG_BLK_DEV_NBD is not set
> > # CONFIG_BLK_DEV_SX8 is not set
> > # CONFIG_BLK_DEV_UB is not set
> > # CONFIG_BLK_DEV_RAM is not set
> > CONFIG_BLK_DEV_RAM_COUNT=16
> > CONFIG_INITRAMFS_SOURCE=""
> > # CONFIG_LBD is not set
> > # CONFIG_CDROM_PKTCDVD is not set
> >
> > #
> > # IO Schedulers
> > #
> > CONFIG_IOSCHED_NOOP=y
> > # CONFIG_IOSCHED_AS is not set
> > # CONFIG_IOSCHED_DEADLINE is not set
> > CONFIG_IOSCHED_CFQ=y
> >
> > #
> > # ATA/ATAPI/MFM/RLL support
> > #
> > CONFIG_IDE=y
> > CONFIG_BLK_DEV_IDE=y
> >
> > #
> > # Please see Documentation/ide.txt for help/info on IDE drives
> > #
> > # CONFIG_BLK_DEV_IDE_SATA is not set
> > # CONFIG_BLK_DEV_HD_IDE is not set
> > CONFIG_BLK_DEV_IDEDISK=y
> > CONFIG_IDEDISK_MULTI_MODE=y
> > CONFIG_BLK_DEV_IDECD=m
> > # CONFIG_BLK_DEV_IDETAPE is not set
> > # CONFIG_BLK_DEV_IDEFLOPPY is not set
> > # CONFIG_BLK_DEV_IDESCSI is not set
> > # CONFIG_IDE_TASK_IOCTL is not set
> >
> > #
> > # IDE chipset support/bugfixes
> > #
> > # CONFIG_IDE_GENERIC is not set
> > # CONFIG_BLK_DEV_CMD640 is not set
> > # CONFIG_BLK_DEV_IDEPNP is not set
> > CONFIG_BLK_DEV_IDEPCI=y
> > CONFIG_IDEPCI_SHARE_IRQ=y
> > # CONFIG_BLK_DEV_OFFBOARD is not set
> > # CONFIG_BLK_DEV_GENERIC is not set
> > # CONFIG_BLK_DEV_OPTI621 is not set
> > # CONFIG_BLK_DEV_RZ1000 is not set
> > CONFIG_BLK_DEV_IDEDMA_PCI=y
> > # CONFIG_BLK_DEV_IDEDMA_FORCED is not set
> > CONFIG_IDEDMA_PCI_AUTO=y
> > # CONFIG_IDEDMA_ONLYDISK is not set
> > # CONFIG_BLK_DEV_AEC62XX is not set
> > # CONFIG_BLK_DEV_ALI15X3 is not set
> > # CONFIG_BLK_DEV_AMD74XX is not set
> > # CONFIG_BLK_DEV_ATIIXP is not set
> > # CONFIG_BLK_DEV_CMD64X is not set
> > # CONFIG_BLK_DEV_TRIFLEX is not set
> > # CONFIG_BLK_DEV_CY82C693 is not set
> > # CONFIG_BLK_DEV_CS5520 is not set
> > # CONFIG_BLK_DEV_CS5530 is not set
> > # CONFIG_BLK_DEV_HPT34X is not set
> > # CONFIG_BLK_DEV_HPT366 is not set
> > # CONFIG_BLK_DEV_SC1200 is not set
> > CONFIG_BLK_DEV_PIIX=y
> > # CONFIG_BLK_DEV_NS87415 is not set
> > # CONFIG_BLK_DEV_PDC202XX_OLD is not set
> > # CONFIG_BLK_DEV_PDC202XX_NEW is not set
> > # CONFIG_BLK_DEV_SVWKS is not set
> > # CONFIG_BLK_DEV_SIIMAGE is not set
> > # CONFIG_BLK_DEV_SIS5513 is not set
> > # CONFIG_BLK_DEV_SLC90E66 is not set
> > # CONFIG_BLK_DEV_TRM290 is not set
> > # CONFIG_BLK_DEV_VIA82CXXX is not set
> > # CONFIG_IDE_ARM is not set
> > CONFIG_BLK_DEV_IDEDMA=y
> > # CONFIG_IDEDMA_IVB is not set
> > CONFIG_IDEDMA_AUTO=y
> > # CONFIG_BLK_DEV_HD is not set
> >
> > #
> > # SCSI device support
> > #
> > CONFIG_SCSI=m
> > CONFIG_SCSI_PROC_FS=y
> >
> > #
> > # SCSI support type (disk, tape, CD-ROM)
> > #
> > CONFIG_BLK_DEV_SD=m
> > # CONFIG_CHR_DEV_ST is not set
> > # CONFIG_CHR_DEV_OSST is not set
> > # CONFIG_BLK_DEV_SR is not set
> > # CONFIG_CHR_DEV_SG is not set
> >
> > #
> > # Some SCSI devices (e.g. CD jukebox) support multiple LUNs
> > #
> > # CONFIG_SCSI_MULTI_LUN is not set
> > # CONFIG_SCSI_CONSTANTS is not set
> > # CONFIG_SCSI_LOGGING is not set
> >
> > #
> > # SCSI Transport Attributes
> > #
> > # CONFIG_SCSI_SPI_ATTRS is not set
> > # CONFIG_SCSI_FC_ATTRS is not set
> > # CONFIG_SCSI_ISCSI_ATTRS is not set
> >
> > #
> > # SCSI low-level drivers
> > #
> > # CONFIG_BLK_DEV_3W_XXXX_RAID is not set
> > # CONFIG_SCSI_3W_9XXX is not set
> > # CONFIG_SCSI_ACARD is not set
> > # CONFIG_SCSI_AACRAID is not set
> > # CONFIG_SCSI_AIC7XXX is not set
> > # CONFIG_SCSI_AIC7XXX_OLD is not set
> > # CONFIG_SCSI_AIC79XX is not set
> > # CONFIG_SCSI_DPT_I2O is not set
> > # CONFIG_MEGARAID_NEWGEN is not set
> > # CONFIG_MEGARAID_LEGACY is not set
> > # CONFIG_SCSI_SATA is not set
> > # CONFIG_SCSI_BUSLOGIC is not set
> > # CONFIG_SCSI_DMX3191D is not set
> > # CONFIG_SCSI_EATA is not set
> > # CONFIG_SCSI_EATA_PIO is not set
> > # CONFIG_SCSI_FUTURE_DOMAIN is not set
> > # CONFIG_SCSI_GDTH is not set
> > # CONFIG_SCSI_IPS is not set
> > # CONFIG_SCSI_INITIO is not set
> > # CONFIG_SCSI_INIA100 is not set
> > # CONFIG_SCSI_PPA is not set
> > # CONFIG_SCSI_IMM is not set
> > # CONFIG_SCSI_SYM53C8XX_2 is not set
> > # CONFIG_SCSI_IPR is not set
> > # CONFIG_SCSI_QLOGIC_ISP is not set
> > # CONFIG_SCSI_QLOGIC_FC is not set
> > # CONFIG_SCSI_QLOGIC_1280 is not set
> > CONFIG_SCSI_QLA2XXX=m
> > # CONFIG_SCSI_QLA21XX is not set
> > # CONFIG_SCSI_QLA22XX is not set
> > # CONFIG_SCSI_QLA2300 is not set
> > # CONFIG_SCSI_QLA2322 is not set
> > # CONFIG_SCSI_QLA6312 is not set
> > # CONFIG_SCSI_DC395x is not set
> > # CONFIG_SCSI_DC390T is not set
> > # CONFIG_SCSI_NSP32 is not set
> > # CONFIG_SCSI_DEBUG is not set
> >
> > #
> > # Multi-device support (RAID and LVM)
> > #
> > # CONFIG_MD is not set
> >
> > #
> > # Fusion MPT device support
> > #
> > # CONFIG_FUSION is not set
> >
> > #
> > # IEEE 1394 (FireWire) support
> > #
> > # CONFIG_IEEE1394 is not set
> >
> > #
> > # I2O device support
> > #
> > # CONFIG_I2O is not set
> >
> > #
> > # Networking support
> > #
> > CONFIG_NET=y
> >
> > #
> > # Networking options
> > #
> > CONFIG_PACKET=y
> > CONFIG_PACKET_MMAP=y
> > CONFIG_NETLINK_DEV=m
> > CONFIG_UNIX=y
> > # CONFIG_NET_KEY is not set
> > CONFIG_INET=y
> > CONFIG_IP_MULTICAST=y
> > # CONFIG_IP_ADVANCED_ROUTER is not set
> > # CONFIG_IP_PNP is not set
> > CONFIG_NET_IPIP=m
> > CONFIG_NET_IPGRE=m
> > # CONFIG_NET_IPGRE_BROADCAST is not set
> > # CONFIG_IP_MROUTE is not set
> > # CONFIG_ARPD is not set
> > CONFIG_SYN_COOKIES=y
> > # CONFIG_INET_AH is not set
> > # CONFIG_INET_ESP is not set
> > # CONFIG_INET_IPCOMP is not set
> > CONFIG_INET_TUNNEL=m
> > CONFIG_IP_TCPDIAG=y
> > # CONFIG_IP_TCPDIAG_IPV6 is not set
> >
> > #
> > # IP: Virtual Server Configuration
> > #
> > # CONFIG_IP_VS is not set
> > # CONFIG_IPV6 is not set
> > CONFIG_NETFILTER=y
> > # CONFIG_NETFILTER_DEBUG is not set
> >
> > #
> > # IP: Netfilter Configuration
> > #
> > CONFIG_IP_NF_CONNTRACK=m
> > # CONFIG_IP_NF_CT_ACCT is not set
> > # CONFIG_IP_NF_CONNTRACK_MARK is not set
> > # CONFIG_IP_NF_CT_PROTO_SCTP is not set
> > CONFIG_IP_NF_FTP=m
> > CONFIG_IP_NF_IRC=m
> > # CONFIG_IP_NF_TFTP is not set
> > # CONFIG_IP_NF_AMANDA is not set
> > # CONFIG_IP_NF_QUEUE is not set
> > CONFIG_IP_NF_IPTABLES=m
> > CONFIG_IP_NF_MATCH_LIMIT=m
> > CONFIG_IP_NF_MATCH_IPRANGE=m
> > CONFIG_IP_NF_MATCH_MAC=m
> > CONFIG_IP_NF_MATCH_PKTTYPE=m
> > CONFIG_IP_NF_MATCH_MARK=m
> > CONFIG_IP_NF_MATCH_MULTIPORT=m
> > CONFIG_IP_NF_MATCH_TOS=m
> > CONFIG_IP_NF_MATCH_RECENT=m
> > CONFIG_IP_NF_MATCH_ECN=m
> > CONFIG_IP_NF_MATCH_DSCP=m
> > CONFIG_IP_NF_MATCH_AH_ESP=m
> > CONFIG_IP_NF_MATCH_LENGTH=m
> > CONFIG_IP_NF_MATCH_TTL=m
> > CONFIG_IP_NF_MATCH_TCPMSS=m
> > # CONFIG_IP_NF_MATCH_HELPER is not set
> > CONFIG_IP_NF_MATCH_STATE=m
> > # CONFIG_IP_NF_MATCH_CONNTRACK is not set
> > CONFIG_IP_NF_MATCH_OWNER=m
> > CONFIG_IP_NF_MATCH_ADDRTYPE=m
> > CONFIG_IP_NF_MATCH_REALM=m
> > # CONFIG_IP_NF_MATCH_SCTP is not set
> > # CONFIG_IP_NF_MATCH_COMMENT is not set
> > # CONFIG_IP_NF_MATCH_HASHLIMIT is not set
> > CONFIG_IP_NF_FILTER=m
> > CONFIG_IP_NF_TARGET_REJECT=m
> > CONFIG_IP_NF_TARGET_LOG=m
> > # CONFIG_IP_NF_TARGET_ULOG is not set
> > # CONFIG_IP_NF_TARGET_TCPMSS is not set
> > # CONFIG_IP_NF_NAT is not set
> > CONFIG_IP_NF_MANGLE=m
> > CONFIG_IP_NF_TARGET_TOS=m
> > CONFIG_IP_NF_TARGET_ECN=m
> > CONFIG_IP_NF_TARGET_DSCP=m
> > CONFIG_IP_NF_TARGET_MARK=m
> > CONFIG_IP_NF_TARGET_CLASSIFY=m
> > CONFIG_IP_NF_RAW=m
> > # CONFIG_IP_NF_TARGET_NOTRACK is not set
> > # CONFIG_IP_NF_ARPTABLES is not set
> > # CONFIG_IP_NF_COMPAT_IPCHAINS is not set
> > # CONFIG_IP_NF_COMPAT_IPFWADM is not set
> > CONFIG_XFRM=y
> > # CONFIG_XFRM_USER is not set
> >
> > #
> > # SCTP Configuration (EXPERIMENTAL)
> > #
> > # CONFIG_IP_SCTP is not set
> > # CONFIG_ATM is not set
> > # CONFIG_BRIDGE is not set
> > # CONFIG_VLAN_8021Q is not set
> > # CONFIG_DECNET is not set
> > # CONFIG_LLC2 is not set
> > # CONFIG_IPX is not set
> > # CONFIG_ATALK is not set
> > # CONFIG_X25 is not set
> > # CONFIG_LAPB is not set
> > # CONFIG_NET_DIVERT is not set
> > # CONFIG_ECONET is not set
> > # CONFIG_WAN_ROUTER is not set
> >
> > #
> > # QoS and/or fair queueing
> > #
> > # CONFIG_NET_SCHED is not set
> > CONFIG_NET_CLS_ROUTE=y
> >
> > #
> > # Network testing
> > #
> > # CONFIG_NET_PKTGEN is not set
> > # CONFIG_NETPOLL is not set
> > # CONFIG_NET_POLL_CONTROLLER is not set
> > # CONFIG_HAMRADIO is not set
> > # CONFIG_IRDA is not set
> > # CONFIG_BT is not set
> > CONFIG_NETDEVICES=y
> > CONFIG_DUMMY=m
> > # CONFIG_BONDING is not set
> > # CONFIG_EQUALIZER is not set
> > # CONFIG_TUN is not set
> > # CONFIG_ETHERTAP is not set
> > # CONFIG_NET_SB1000 is not set
> >
> > #
> > # ARCnet devices
> > #
> > # CONFIG_ARCNET is not set
> >
> > #
> > # Ethernet (10 or 100Mbit)
> > #
> > CONFIG_NET_ETHERNET=y
> > CONFIG_MII=y
> > # CONFIG_HAPPYMEAL is not set
> > # CONFIG_SUNGEM is not set
> > # CONFIG_NET_VENDOR_3COM is not set
> >
> > #
> > # Tulip family network device support
> > #
> > # CONFIG_NET_TULIP is not set
> > # CONFIG_HP100 is not set
> > CONFIG_NET_PCI=y
> > # CONFIG_PCNET32 is not set
> > # CONFIG_AMD8111_ETH is not set
> > # CONFIG_ADAPTEC_STARFIRE is not set
> > # CONFIG_B44 is not set
> > # CONFIG_FORCEDETH is not set
> > # CONFIG_DGRS is not set
> > # CONFIG_EEPRO100 is not set
> > # CONFIG_E100 is not set
> > # CONFIG_FEALNX is not set
> > CONFIG_NATSEMI=y
> > # CONFIG_NE2K_PCI is not set
> > # CONFIG_8139CP is not set
> > # CONFIG_8139TOO is not set
> > # CONFIG_SIS900 is not set
> > # CONFIG_EPIC100 is not set
> > # CONFIG_SUNDANCE is not set
> > # CONFIG_TLAN is not set
> > # CONFIG_VIA_RHINE is not set
> >
> > #
> > # Ethernet (1000 Mbit)
> > #
> > # CONFIG_ACENIC is not set
> > # CONFIG_DL2K is not set
> > # CONFIG_E1000 is not set
> > # CONFIG_NS83820 is not set
> > # CONFIG_HAMACHI is not set
> > # CONFIG_YELLOWFIN is not set
> > # CONFIG_R8169 is not set
> > # CONFIG_SK98LIN is not set
> > # CONFIG_VIA_VELOCITY is not set
> > # CONFIG_TIGON3 is not set
> >
> > #
> > # Ethernet (10000 Mbit)
> > #
> > # CONFIG_IXGB is not set
> > # CONFIG_S2IO is not set
> >
> > #
> > # Token Ring devices
> > #
> > # CONFIG_TR is not set
> >
> > #
> > # Wireless LAN (non-hamradio)
> > #
> > # CONFIG_NET_RADIO is not set
> >
> > #
> > # Wan interfaces
> > #
> > # CONFIG_WAN is not set
> > # CONFIG_FDDI is not set
> > # CONFIG_HIPPI is not set
> > # CONFIG_PLIP is not set
> > CONFIG_PPP=m
> > # CONFIG_PPP_MULTILINK is not set
> > # CONFIG_PPP_FILTER is not set
> > CONFIG_PPP_ASYNC=m
> > CONFIG_PPP_SYNC_TTY=m
> > CONFIG_PPP_DEFLATE=m
> > CONFIG_PPP_BSDCOMP=m
> > CONFIG_PPPOE=m
> > # CONFIG_SLIP is not set
> > # CONFIG_NET_FC is not set
> > # CONFIG_SHAPER is not set
> > # CONFIG_NETCONSOLE is not set
> >
> > #
> > # ISDN subsystem
> > #
> > # CONFIG_ISDN is not set
> >
> > #
> > # Telephony Support
> > #
> > # CONFIG_PHONE is not set
> >
> > #
> > # Input device support
> > #
> > CONFIG_INPUT=y
> >
> > #
> > # Userland interfaces
> > #
> > CONFIG_INPUT_MOUSEDEV=y
> > CONFIG_INPUT_MOUSEDEV_PSAUX=y
> > CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
> > CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
> > # CONFIG_INPUT_JOYDEV is not set
> > # CONFIG_INPUT_TSDEV is not set
> > # CONFIG_INPUT_EVDEV is not set
> > # CONFIG_INPUT_EVBUG is not set
> >
> > #
> > # Input I/O drivers
> > #
> > # CONFIG_GAMEPORT is not set
> > CONFIG_SOUND_GAMEPORT=y
> > CONFIG_SERIO=y
> > CONFIG_SERIO_I8042=y
> > # CONFIG_SERIO_SERPORT is not set
> > # CONFIG_SERIO_CT82C710 is not set
> > # CONFIG_SERIO_PARKBD is not set
> > # CONFIG_SERIO_PCIPS2 is not set
> > # CONFIG_SERIO_RAW is not set
> >
> > #
> > # Input Device Drivers
> > #
> > CONFIG_INPUT_KEYBOARD=y
> > CONFIG_KEYBOARD_ATKBD=y
> > # CONFIG_KEYBOARD_SUNKBD is not set
> > # CONFIG_KEYBOARD_LKKBD is not set
> > # CONFIG_KEYBOARD_XTKBD is not set
> > # CONFIG_KEYBOARD_NEWTON is not set
> > CONFIG_INPUT_MOUSE=y
> > CONFIG_MOUSE_PS2=y
> > # CONFIG_MOUSE_SERIAL is not set
> > # CONFIG_MOUSE_VSXXXAA is not set
> > # CONFIG_INPUT_JOYSTICK is not set
> > # CONFIG_INPUT_TOUCHSCREEN is not set
> > # CONFIG_INPUT_MISC is not set
> >
> > #
> > # Character devices
> > #
> > CONFIG_VT=y
> > CONFIG_VT_CONSOLE=y
> > CONFIG_HW_CONSOLE=y
> > # CONFIG_SERIAL_NONSTANDARD is not set
> >
> > #
> > # Serial drivers
> > #
> > CONFIG_SERIAL_8250=y
> > # CONFIG_SERIAL_8250_CONSOLE is not set
> > # CONFIG_SERIAL_8250_ACPI is not set
> > CONFIG_SERIAL_8250_NR_UARTS=4
> > # CONFIG_SERIAL_8250_EXTENDED is not set
> >
> > #
> > # Non-8250 serial port support
> > #
> > CONFIG_SERIAL_CORE=y
> > CONFIG_UNIX98_PTYS=y
> > # CONFIG_LEGACY_PTYS is not set
> > CONFIG_PRINTER=m
> > # CONFIG_LP_CONSOLE is not set
> > # CONFIG_PPDEV is not set
> > # CONFIG_TIPAR is not set
> >
> > #
> > # IPMI
> > #
> > # CONFIG_IPMI_HANDLER is not set
> >
> > #
> > # Watchdog Cards
> > #
> > # CONFIG_WATCHDOG is not set
> > # CONFIG_HW_RANDOM is not set
> > # CONFIG_NVRAM is not set
> > CONFIG_RTC=y
> > # CONFIG_DTLK is not set
> > # CONFIG_R3964 is not set
> > # CONFIG_APPLICOM is not set
> > # CONFIG_SONYPI is not set
> >
> > #
> > # Ftape, the floppy tape device driver
> > #
> > # CONFIG_FTAPE is not set
> > CONFIG_AGP=m
> > # CONFIG_AGP_ALI is not set
> > # CONFIG_AGP_ATI is not set
> > # CONFIG_AGP_AMD is not set
> > # CONFIG_AGP_AMD64 is not set
> > CONFIG_AGP_INTEL=m
> > # CONFIG_AGP_INTEL_MCH is not set
> > # CONFIG_AGP_NVIDIA is not set
> > # CONFIG_AGP_SIS is not set
> > # CONFIG_AGP_SWORKS is not set
> > # CONFIG_AGP_VIA is not set
> > # CONFIG_AGP_EFFICEON is not set
> > CONFIG_DRM=y
> > # CONFIG_DRM_TDFX is not set
> > # CONFIG_DRM_R128 is not set
> > CONFIG_DRM_RADEON=m
> > # CONFIG_DRM_I810 is not set
> > # CONFIG_DRM_I830 is not set
> > # CONFIG_DRM_I915 is not set
> > # CONFIG_DRM_MGA is not set
> > # CONFIG_DRM_SIS is not set
> > # CONFIG_MWAVE is not set
> > # CONFIG_RAW_DRIVER is not set
> > # CONFIG_HPET is not set
> > # CONFIG_HANGCHECK_TIMER is not set
> >
> > #
> > # I2C support
> > #
> > # CONFIG_I2C is not set
> >
> > #
> > # Dallas's 1-wire bus
> > #
> > # CONFIG_W1 is not set
> >
> > #
> > # Misc devices
> > #
> > # CONFIG_IBM_ASM is not set
> >
> > #
> > # Multimedia devices
> > #
> > # CONFIG_VIDEO_DEV is not set
> >
> > #
> > # Digital Video Broadcasting Devices
> > #
> > # CONFIG_DVB is not set
> >
> > #
> > # Graphics support
> > #
> > # CONFIG_FB is not set
> > # CONFIG_VIDEO_SELECT is not set
> >
> > #
> > # Console display driver support
> > #
> > CONFIG_VGA_CONSOLE=y
> > CONFIG_DUMMY_CONSOLE=y
> >
> > #
> > # Sound
> > #
> > CONFIG_SOUND=m
> >
> > #
> > # Advanced Linux Sound Architecture
> > #
> > CONFIG_SND=m
> > CONFIG_SND_TIMER=m
> > CONFIG_SND_PCM=m
> > CONFIG_SND_HWDEP=m
> > CONFIG_SND_RAWMIDI=m
> > CONFIG_SND_SEQUENCER=m
> > CONFIG_SND_SEQ_DUMMY=m
> > CONFIG_SND_OSSEMUL=y
> > CONFIG_SND_MIXER_OSS=m
> > CONFIG_SND_PCM_OSS=m
> > CONFIG_SND_SEQUENCER_OSS=y
> > CONFIG_SND_RTCTIMER=m
> > # CONFIG_SND_VERBOSE_PRINTK is not set
> > # CONFIG_SND_DEBUG is not set
> >
> > #
> > # Generic devices
> > #
> > CONFIG_SND_MPU401_UART=m
> > CONFIG_SND_DUMMY=m
> > CONFIG_SND_VIRMIDI=m
> > CONFIG_SND_MTPAV=m
> > CONFIG_SND_SERIAL_U16550=m
> > CONFIG_SND_MPU401=m
> >
> > #
> > # PCI devices
> > #
> > CONFIG_SND_AC97_CODEC=m
> > # CONFIG_SND_ALI5451 is not set
> > # CONFIG_SND_ATIIXP is not set
> > # CONFIG_SND_ATIIXP_MODEM is not set
> > # CONFIG_SND_AU8810 is not set
> > # CONFIG_SND_AU8820 is not set
> > # CONFIG_SND_AU8830 is not set
> > # CONFIG_SND_AZT3328 is not set
> > # CONFIG_SND_BT87X is not set
> > # CONFIG_SND_CS46XX is not set
> > # CONFIG_SND_CS4281 is not set
> > CONFIG_SND_EMU10K1=m
> > # CONFIG_SND_KORG1212 is not set
> > # CONFIG_SND_MIXART is not set
> > # CONFIG_SND_NM256 is not set
> > # CONFIG_SND_RME32 is not set
> > # CONFIG_SND_RME96 is not set
> > # CONFIG_SND_RME9652 is not set
> > # CONFIG_SND_HDSP is not set
> > # CONFIG_SND_TRIDENT is not set
> > # CONFIG_SND_YMFPCI is not set
> > # CONFIG_SND_ALS4000 is not set
> > # CONFIG_SND_CMIPCI is not set
> > # CONFIG_SND_ENS1370 is not set
> > CONFIG_SND_ENS1371=m
> > # CONFIG_SND_ES1938 is not set
> > # CONFIG_SND_ES1968 is not set
> > # CONFIG_SND_MAESTRO3 is not set
> > # CONFIG_SND_FM801 is not set
> > # CONFIG_SND_ICE1712 is not set
> > # CONFIG_SND_ICE1724 is not set
> > # CONFIG_SND_INTEL8X0 is not set
> > # CONFIG_SND_INTEL8X0M is not set
> > # CONFIG_SND_SONICVIBES is not set
> > # CONFIG_SND_VIA82XX is not set
> > # CONFIG_SND_VX222 is not set
> >
> > #
> > # USB devices
> > #
> > # CONFIG_SND_USB_AUDIO is not set
> > # CONFIG_SND_USB_USX2Y is not set
> >
> > #
> > # Open Sound System
> > #
> > # CONFIG_SOUND_PRIME is not set
> >
> > #
> > # USB support
> > #
> > CONFIG_USB=m
> > # CONFIG_USB_DEBUG is not set
> >
> > #
> > # Miscellaneous USB options
> > #
> > CONFIG_USB_DEVICEFS=y
> > # CONFIG_USB_BANDWIDTH is not set
> > # CONFIG_USB_DYNAMIC_MINORS is not set
> > # CONFIG_USB_OTG is not set
> > CONFIG_USB_ARCH_HAS_HCD=y
> > CONFIG_USB_ARCH_HAS_OHCI=y
> >
> > #
> > # USB Host Controller Drivers
> > #
> > CONFIG_USB_EHCI_HCD=m
> > # CONFIG_USB_EHCI_SPLIT_ISO is not set
> > # CONFIG_USB_EHCI_ROOT_HUB_TT is not set
> > # CONFIG_USB_OHCI_HCD is not set
> > CONFIG_USB_UHCI_HCD=m
> > # CONFIG_USB_SL811_HCD is not set
> >
> > #
> > # USB Device Class drivers
> > #
> > # CONFIG_USB_AUDIO is not set
> > # CONFIG_USB_BLUETOOTH_TTY is not set
> > # CONFIG_USB_MIDI is not set
> > CONFIG_USB_ACM=m
> > CONFIG_USB_PRINTER=m
> >
> > #
> > # NOTE: USB_STORAGE enables SCSI, and 'SCSI disk support' may also be needed; see USB_STORAGE Help for more information
> > #
> > CONFIG_USB_STORAGE=m
> > # CONFIG_USB_STORAGE_DEBUG is not set
> > # CONFIG_USB_STORAGE_RW_DETECT is not set
> > # CONFIG_USB_STORAGE_DATAFAB is not set
> > # CONFIG_USB_STORAGE_FREECOM is not set
> > # CONFIG_USB_STORAGE_ISD200 is not set
> > # CONFIG_USB_STORAGE_DPCM is not set
> > # CONFIG_USB_STORAGE_HP8200e is not set
> > # CONFIG_USB_STORAGE_SDDR09 is not set
> > # CONFIG_USB_STORAGE_SDDR55 is not set
> > # CONFIG_USB_STORAGE_JUMPSHOT is not set
> >
> > #
> > # USB Input Devices
> > #
> > CONFIG_USB_HID=m
> > CONFIG_USB_HIDINPUT=y
> > # CONFIG_HID_FF is not set
> > # CONFIG_USB_HIDDEV is not set
> >
> > #
> > # USB HID Boot Protocol drivers
> > #
> > # CONFIG_USB_KBD is not set
> > # CONFIG_USB_MOUSE is not set
> > # CONFIG_USB_AIPTEK is not set
> > # CONFIG_USB_WACOM is not set
> > # CONFIG_USB_KBTAB is not set
> > # CONFIG_USB_POWERMATE is not set
> > # CONFIG_USB_MTOUCH is not set
> > # CONFIG_USB_EGALAX is not set
> > # CONFIG_USB_XPAD is not set
> > # CONFIG_USB_ATI_REMOTE is not set
> >
> > #
> > # USB Imaging devices
> > #
> > # CONFIG_USB_MDC800 is not set
> > # CONFIG_USB_MICROTEK is not set
> > # CONFIG_USB_HPUSBSCSI is not set
> >
> > #
> > # USB Multimedia devices
> > #
> > # CONFIG_USB_DABUSB is not set
> >
> > #
> > # Video4Linux support is needed for USB Multimedia device support
> > #
> >
> > #
> > # USB Network Adapters
> > #
> > # CONFIG_USB_CATC is not set
> > # CONFIG_USB_KAWETH is not set
> > # CONFIG_USB_PEGASUS is not set
> > # CONFIG_USB_RTL8150 is not set
> > # CONFIG_USB_USBNET is not set
> >
> > #
> > # USB port drivers
> > #
> > # CONFIG_USB_USS720 is not set
> >
> > #
> > # USB Serial Converter support
> > #
> > # CONFIG_USB_SERIAL is not set
> >
> > #
> > # USB Miscellaneous drivers
> > #
> > # CONFIG_USB_EMI62 is not set
> > # CONFIG_USB_EMI26 is not set
> > # CONFIG_USB_TIGL is not set
> > # CONFIG_USB_AUERSWALD is not set
> > # CONFIG_USB_RIO500 is not set
> > # CONFIG_USB_LEGOTOWER is not set
> > # CONFIG_USB_LCD is not set
> > # CONFIG_USB_LED is not set
> > # CONFIG_USB_CYTHERM is not set
> > # CONFIG_USB_PHIDGETKIT is not set
> > # CONFIG_USB_PHIDGETSERVO is not set
> > # CONFIG_USB_TEST is not set
> >
> > #
> > # USB ATM/DSL drivers
> > #
> >
> > #
> > # USB Gadget Support
> > #
> > # CONFIG_USB_GADGET is not set
> >
> > #
> > # MMC/SD Card support
> > #
> > # CONFIG_MMC is not set
> >
> > #
> > # InfiniBand support
> > #
> > # CONFIG_INFINIBAND is not set
> >
> > #
> > # File systems
> > #
> > CONFIG_EXT2_FS=m
> > CONFIG_EXT2_FS_XATTR=y
> > CONFIG_EXT2_FS_POSIX_ACL=y
> > CONFIG_EXT2_FS_SECURITY=y
> > CONFIG_EXT3_FS=y
> > CONFIG_EXT3_FS_XATTR=y
> > CONFIG_EXT3_FS_POSIX_ACL=y
> > CONFIG_EXT3_FS_SECURITY=y
> > CONFIG_JBD=y
> > # CONFIG_JBD_DEBUG is not set
> > CONFIG_FS_MBCACHE=y
> > # CONFIG_REISERFS_FS is not set
> > # CONFIG_JFS_FS is not set
> > CONFIG_FS_POSIX_ACL=y
> > # CONFIG_XFS_FS is not set
> > # CONFIG_MINIX_FS is not set
> > # CONFIG_ROMFS_FS is not set
> > # CONFIG_QUOTA is not set
> > CONFIG_DNOTIFY=y
> > # CONFIG_AUTOFS_FS is not set
> > # CONFIG_AUTOFS4_FS is not set
> >
> > #
> > # CD-ROM/DVD Filesystems
> > #
> > CONFIG_ISO9660_FS=m
> > CONFIG_JOLIET=y
> > # CONFIG_ZISOFS is not set
> > CONFIG_UDF_FS=m
> > CONFIG_UDF_NLS=y
> >
> > #
> > # DOS/FAT/NT Filesystems
> > #
> > CONFIG_FAT_FS=m
> > CONFIG_MSDOS_FS=m
> > CONFIG_VFAT_FS=m
> > CONFIG_FAT_DEFAULT_CODEPAGE=437
> > CONFIG_FAT_DEFAULT_IOCHARSET="iso8859-1"
> > # CONFIG_NTFS_FS is not set
> >
> > #
> > # Pseudo filesystems
> > #
> > CONFIG_PROC_FS=y
> > CONFIG_PROC_KCORE=y
> > CONFIG_SYSFS=y
> > # CONFIG_DEVFS_FS is not set
> > CONFIG_DEVPTS_FS_XATTR=y
> > CONFIG_DEVPTS_FS_SECURITY=y
> > CONFIG_TMPFS=y
> > # CONFIG_TMPFS_XATTR is not set
> > # CONFIG_HUGETLBFS is not set
> > # CONFIG_HUGETLB_PAGE is not set
> > CONFIG_RAMFS=y
> >
> > #
> > # Miscellaneous filesystems
> > #
> > # CONFIG_ADFS_FS is not set
> > # CONFIG_AFFS_FS is not set
> > # CONFIG_HFS_FS is not set
> > # CONFIG_HFSPLUS_FS is not set
> > # CONFIG_BEFS_FS is not set
> > # CONFIG_BFS_FS is not set
> > # CONFIG_EFS_FS is not set
> > # CONFIG_CRAMFS is not set
> > # CONFIG_VXFS_FS is not set
> > # CONFIG_HPFS_FS is not set
> > # CONFIG_QNX4FS_FS is not set
> > # CONFIG_SYSV_FS is not set
> > # CONFIG_UFS_FS is not set
> >
> > #
> > # Network File Systems
> > #
> > # CONFIG_NFS_FS is not set
> > # CONFIG_NFSD is not set
> > # CONFIG_EXPORTFS is not set
> > # CONFIG_SMB_FS is not set
> > # CONFIG_CIFS is not set
> > # CONFIG_NCP_FS is not set
> > # CONFIG_CODA_FS is not set
> > # CONFIG_AFS_FS is not set
> >
> > #
> > # Partition Types
> > #
> > # CONFIG_PARTITION_ADVANCED is not set
> > CONFIG_MSDOS_PARTITION=y
> >
> > #
> > # Native Language Support
> > #
> > CONFIG_NLS=y
> > CONFIG_NLS_DEFAULT="iso8859-1"
> > CONFIG_NLS_CODEPAGE_437=m
> > # CONFIG_NLS_CODEPAGE_737 is not set
> > # CONFIG_NLS_CODEPAGE_775 is not set
> > CONFIG_NLS_CODEPAGE_850=m
> > CONFIG_NLS_CODEPAGE_852=m
> > # CONFIG_NLS_CODEPAGE_855 is not set
> > # CONFIG_NLS_CODEPAGE_857 is not set
> > # CONFIG_NLS_CODEPAGE_860 is not set
> > # CONFIG_NLS_CODEPAGE_861 is not set
> > # CONFIG_NLS_CODEPAGE_862 is not set
> > # CONFIG_NLS_CODEPAGE_863 is not set
> > # CONFIG_NLS_CODEPAGE_864 is not set
> > # CONFIG_NLS_CODEPAGE_865 is not set
> > # CONFIG_NLS_CODEPAGE_866 is not set
> > # CONFIG_NLS_CODEPAGE_869 is not set
> > # CONFIG_NLS_CODEPAGE_936 is not set
> > # CONFIG_NLS_CODEPAGE_950 is not set
> > # CONFIG_NLS_CODEPAGE_932 is not set
> > # CONFIG_NLS_CODEPAGE_949 is not set
> > # CONFIG_NLS_CODEPAGE_874 is not set
> > # CONFIG_NLS_ISO8859_8 is not set
> > CONFIG_NLS_CODEPAGE_1250=m
> > # CONFIG_NLS_CODEPAGE_1251 is not set
> > CONFIG_NLS_ASCII=m
> > CONFIG_NLS_ISO8859_1=m
> > # CONFIG_NLS_ISO8859_2 is not set
> > # CONFIG_NLS_ISO8859_3 is not set
> > # CONFIG_NLS_ISO8859_4 is not set
> > # CONFIG_NLS_ISO8859_5 is not set
> > # CONFIG_NLS_ISO8859_6 is not set
> > # CONFIG_NLS_ISO8859_7 is not set
> > # CONFIG_NLS_ISO8859_9 is not set
> > # CONFIG_NLS_ISO8859_13 is not set
> > # CONFIG_NLS_ISO8859_14 is not set
> > CONFIG_NLS_ISO8859_15=m
> > # CONFIG_NLS_KOI8_R is not set
> > # CONFIG_NLS_KOI8_U is not set
> > CONFIG_NLS_UTF8=m
> >
> > #
> > # Profiling support
> > #
> > # CONFIG_PROFILING is not set
> >
> > #
> > # Kernel hacking
> > #
> > # CONFIG_DEBUG_KERNEL is not set
> > # CONFIG_FRAME_POINTER is not set
> > CONFIG_EARLY_PRINTK=y
> > CONFIG_4KSTACKS=y
> > CONFIG_X86_FIND_SMP_CONFIG=y
> > CONFIG_X86_MPPARSE=y
> >
> > #
> > # Security options
> > #
> > # CONFIG_KEYS is not set
> > # CONFIG_SECURITY is not set
> >
> > #
> > # Cryptographic options
> > #
> > # CONFIG_CRYPTO is not set
> >
> > #
> > # Hardware crypto devices
> > #
> >
> > #
> > # Library routines
> > #
> > CONFIG_CRC_CCITT=m
> > CONFIG_CRC32=y
> > CONFIG_LIBCRC32C=m
> > CONFIG_ZLIB_INFLATE=m
> > CONFIG_ZLIB_DEFLATE=m
> > CONFIG_GENERIC_HARDIRQS=y
> > CONFIG_GENERIC_IRQ_PROBE=y
> > CONFIG_X86_BIOS_REBOOT=y
> 
> Received a patch by email and also found it myself.
> 
> Thank you
> --Michael
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
