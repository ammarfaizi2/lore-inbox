Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267433AbTBNUuK>; Fri, 14 Feb 2003 15:50:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267436AbTBNUuK>; Fri, 14 Feb 2003 15:50:10 -0500
Received: from msp-24-163-212-250.mn.rr.com ([24.163.212.250]:15746 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id <S267433AbTBNUti>; Fri, 14 Feb 2003 15:49:38 -0500
Subject: Re: compile fail: 2.5.60-mm2
From: Core <core@enodev.com>
To: Andrew Morton <akpm@digeo.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
In-Reply-To: <20030214013144.2d94a9c5.akpm@digeo.com>
References: <20030214013144.2d94a9c5.akpm@digeo.com>
Content-Type: multipart/mixed; boundary="=-mHMhmgk/80DTI6Ti5dZm"
Organization: 
Message-Id: <1045256371.16964.18.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 
Date: 14 Feb 2003 14:59:33 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-mHMhmgk/80DTI6Ti5dZm
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Compile fail.

config and make log attached.



On Fri, 2003-02-14 at 03:31, Andrew Morton wrote:
> http://www.kernel.org/pub/linux/kernel/people/akpm/patches/2.5/2.5.60/2.5.60-mm2/
> 
> . Robert has fixed up Ingo's scheduler update, so that's back in.
> 
> . Considerable poking at the NFS MAP_SHARED OOM lockup.  It is limping
>   along now, but writeout bandwidth is poor and it is still struggling. 
>   Needs work.
> 
> . There's a one-liner which removes an O(n^2) search in the NFS writeback
>   path.  It increases writeout bandwidth by 4x and decreases CPU load from
>   100% to 3%.  Needs work.
> 
> . A patch to permit direct-io reads of the partial block at EOF.  Seems to
>   work, but needs more testing.
> 
> . There is another anticipatory scheduler patch over in experimental/.
> 
>   The main obective of the anticipatory scheduler is not really to improve
>   interactivity.  It is to increase throughput.  Nick is showing some
>   impressive benchmark results with this now.  Some benchmarking of the
>   non-contest variety would be appreciated.
> 
> . Added Matthew Jacob's Qlogic ISP driver for a bit of testing.  It locks
>   up mysteriously with my ISP12160 controller.  Testing results for other
>   controllers would be appreciated.
> 
> 
> 
> Changes since 2.5.60-mm1:
> 
> 
>  linus.patch
> 
>  Latest bk from Linus
> 
> -genhd-warnings.patch
> -vmscan-warning.patch
> -nfsd-warnings.patch
> -partitions-warnings.patch
> -nfs-warning-fix.patch
> -reiserfs-hashes-warning-fix.patch
> -st-warning-fix.patch
> -adaptec-compile-fix.patch
> -adaptec-debug-fix.patch
> -oprofile-p4.patch
> -oprofile_cpu-as-string.patch
> -oprofile-braino.patch
> -disassociate_tty-fix.patch
> -epoll-update-2.5.60.patch
> -misc.patch
> -dcache_rcu-nfs-server-fix.patch
> -cyclone-fixes.patch
> -enable-timer_cyclone.patch
> -hugetlbfs-i_size-fix.patch
> 
> +jfs-build-fix.patch
> 
>  JFS compile fix for gcc-2.95.3.
> 
> -mandlock-oops-fix.patch
> +mandlock-fix.patch
> 
>  Updated flocking fix
> 
> +fault_in_pages-move.patch
> 
>  Move fault_in_pages_readable/writeable to a header file so reiserfs can
>  reuse it.
> 
>  reiserfs_file_write.patch
> 
>  Updated
> 
> +ext3-eio-fix.patch
> 
>  Fix a BUG with fsx-linux
> 
> +smctr-fix.patch
> 
>  compile fix.
> 
> +sched-f3.patch
> +rml-scheduler-bits.patch
> 
>  Updated scheduler update.
> 
> +nfs-speedup.patch
> +nfs-more-oom-fix.patch
> 
>  NFS OOM work.
> 
> +nfs-sendfile.patch
> 
>  "fix" an O(n^2) problem in the NFS client.
> 
> +put_page-speedup.patch
> 
>  Speed up put_page() for CONFIG_HUGETLB_PAGE=y
> 
> +kernel_lock_bug2.patch
> +ext2_ext3_listxattr-bug.patch
> +xattr-flags.patch
> +xattr-flags-policy.patch
> +xattr-trusted.patch
> 
>  Extended attribute feature work.
> 
> +generic_write_checks.patch
> 
>  Break out the bounds checking from generic_file_write() so other
>  filesystems can use them.
> 
> +balance_dirty_pages-lockup-fix.patch
> 
>  Fix a weird lockup in the writeback code.
> 
> +cciss-1.patch
> +cciss-2.patch
> +cciss-3.patch
> +cciss-5.patch
> +cciss-6.patch
> +cciss-7.patch
> +cciss-8.patch
> +cciss-9.patch
> +cciss-10.patch
> +cciss-11.patch
> 
>  cciss array controller driver update
> 
> +direct-io-retval-fix.patch
> 
>  Return the correct thing on -EIO
> 
> +dio-eof-read.patch
> 
>  Allow direct-io reads of the non-aligned end of file.
> 
> +linux-isp.patch
> 
>  Latest qlogic driver from www.feral.com bitkeeper
> 
> +linux-isp-update.patch
> 
>  Port it to 2.5
> 
> 
> In the experimental/ directory:
> 
> +handle-async-write-errors.patch
> 
>  Framework for recording and reporting data loss during the async writeout
>  code.
> 
> +anticipatory_io_scheduling.patch
> +ant-sched-9feb.patch
> +ant-sched-12feb.patch
> 
>  Anticipatory scheduler updates.
> 
> 
> 
> All 66 patches
> 
> linus.patch
> 
> kgdb.patch
> 
> ppc64-reloc_hide.patch
> 
> ppc64-time-warning.patch
>   kill ppc64 unused var warning
> 
> xfs-warning-fixes.patch
> 
> xfs-cli-fix.patch
>   xfs interrupt flags fix
> 
> ppc64-smp_prepare_cpus-warning.patch
>   ppc64: fix warning
> 
> report-lost-ticks.patch
>   make lost-tick detection more informative
> 
> devfs-fix.patch
> 
> ptrace-flush.patch
>   Subject: [PATCH] ptrace on 2.5.44
> 
> buffer-debug.patch
>   buffer.c debugging
> 
> warn-null-wakeup.patch
> 
> jfs-build-fix.patch
>   JFS build fix with gcc-2.95.3
> 
> ext3-truncate-ordered-pages.patch
>   ext3: explicitly free truncated pages
> 
> mandlock-fix.patch
>   Subject: [PATCH] Fix mandatory locking
> 
> fault_in_pages-move.patch
>   move fault_in_pages_readable/writeable to header
> 
> reiserfs_file_write.patch
>   Subject: reiserfs file_write patch
> 
> ext3-eio-fix.patch
>   fix ext3 BUG due to race with truncate
> 
> deadline-np-42.patch
>   (undescribed patch)
> 
> deadline-np-43.patch
>   (undescribed patch)
> 
> batch-tuning.patch
>   I/O scheduler tuning
> 
> starvation-by-read-fix.patch
>   fix starvation-by-readers in the IO scheduler
> 
> crc32-speedup.patch
>   crc32 improvements for 2.5
> 
> smctr-fix.patch
>   smctr.c build fixes
> 
> scheduler-tunables.patch
>   scheduler tunables
> 
> sched-f3.patch
>   scheduler F3-updated
> 
> rml-scheduler-bits.patch
>   scheduler bits
> 
> lockd-lockup-fix.patch
>   Subject: Re: Fw: Re: 2.4.20 NFS server lock-up (SMP)
> 
> rcu-stats.patch
>   RCU statistics reporting
> 
> dcache_rcu-fast_walk-revert.patch
>   dcache_rcu: revert fast_walk code
> 
> dcache_rcu-main.patch
>   dcache_rcu
> 
> smalldevfs.patch
>   smalldevfs
> 
> ext3-journalled-data-assertion-fix.patch
>   Remove incorrect assertion from ext3
> 
> deadline-hash-fix.patch
> 
> nfs-speedup.patch
> 
> nfs-oom-fix.patch
>   nfs oom fix
> 
> sk-allocation.patch
>   Subject: Re: nfs oom
> 
> nfs-more-oom-fix.patch
> 
> nfs-sendfile.patch
>   Implement sendfile() for NFS
> 
> rpciod-atomic-allocations.patch
>   Make rcpiod use atomic allocations
> 
> put_page-speedup.patch
>   hugetlb put_page speedup
> 
> kernel_lock_bug2.patch
> 
> ext2_ext3_listxattr-bug.patch
>   xattr: listxattr fix
> 
> xattr-flags.patch
>   xattr: infrastructure for permission overrides
> 
> xattr-flags-policy.patch
>   xattr: allow kernel code to override EA permissions
> 
> xattr-trusted.patch
>   xattr: trusted extended attributes
> 
> generic_write_checks.patch
>   separate checks from generic_file_aio_write
> 
> balance_dirty_pages-lockup-fix.patch
>   blk_congestion_wait tuning and lockup fix
> 
> cciss-1.patch
>   make cciss driver compile
> 
> cciss-2.patch
>   make cciss driver compile (2)
> 
> cciss-3.patch
>   make cciss driver compile [3]
> 
> cciss-5.patch
>   make cciss driver compile [5]
> 
> cciss-6.patch
>   make cciss driver compile [6]
> 
> cciss-7.patch
>   make cciss driver compile [7]
> 
> cciss-8.patch
>   make cciss driver compile
> 
> cciss-9.patch
>   make cciss driver compile
> 
> cciss-10.patch
>   make cciss driver compile
> 
> cciss-11.patch
>   make cciss driver compile
> 
> direct-io-retval-fix.patch
>   direct-io return value fix
> 
> dio-eof-read.patch
> 
> linux-isp.patch
> 
> linux-isp-update.patch
> 
> handle-async-write-errors.patch
>   Propagate async write errors to userspace
> 
> anticipatory_io_scheduling.patch
>   Subject: [PATCH] 2.5.59-mm3 antic io sched
> 
> ant-sched-9feb.patch
>   anticipatory scheduler fix
> 
> ant-sched-12feb.patch
>   Anticipatory scheduler tuning
> 
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
-- 
Core <core@enodev.com>

--=-mHMhmgk/80DTI6Ti5dZm
Content-Description: 
Content-Disposition: attachment; filename=2.5.60-mm2.config
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=ISO-8859-1

#
# Automatically generated make config: don't edit
#
CONFIG_X86=3Dy
CONFIG_MMU=3Dy
CONFIG_SWAP=3Dy
CONFIG_UID16=3Dy
CONFIG_GENERIC_ISA_DMA=3Dy

#
# Code maturity level options
#
CONFIG_EXPERIMENTAL=3Dy

#
# General setup
#
CONFIG_SYSVIPC=3Dy
CONFIG_BSD_PROCESS_ACCT=3Dy
CONFIG_SYSCTL=3Dy
CONFIG_LOG_BUF_SHIFT=3D15

#
# Loadable module support
#
CONFIG_MODULES=3Dy
CONFIG_MODULE_UNLOAD=3Dy
CONFIG_MODULE_FORCE_UNLOAD=3Dy
CONFIG_OBSOLETE_MODPARM=3Dy
CONFIG_MODVERSIONS=3Dy
CONFIG_KMOD=3Dy

#
# Processor type and features
#
CONFIG_X86_PC=3Dy
# CONFIG_X86_VOYAGER is not set
# CONFIG_X86_NUMAQ is not set
# CONFIG_X86_SUMMIT is not set
# CONFIG_X86_BIGSMP is not set
# CONFIG_M386 is not set
# CONFIG_M486 is not set
# CONFIG_M586 is not set
# CONFIG_M586TSC is not set
# CONFIG_M586MMX is not set
# CONFIG_M686 is not set
# CONFIG_MPENTIUMII is not set
# CONFIG_MPENTIUMIII is not set
# CONFIG_MPENTIUM4 is not set
# CONFIG_MK6 is not set
CONFIG_MK7=3Dy
# CONFIG_MK8 is not set
# CONFIG_MELAN is not set
# CONFIG_MCRUSOE is not set
# CONFIG_MWINCHIPC6 is not set
# CONFIG_MWINCHIP2 is not set
# CONFIG_MWINCHIP3D is not set
# CONFIG_MCYRIXIII is not set
# CONFIG_MVIAC3_2 is not set
CONFIG_X86_CMPXCHG=3Dy
CONFIG_X86_XADD=3Dy
CONFIG_X86_L1_CACHE_SHIFT=3D6
CONFIG_RWSEM_XCHGADD_ALGORITHM=3Dy
CONFIG_X86_WP_WORKS_OK=3Dy
CONFIG_X86_INVLPG=3Dy
CONFIG_X86_BSWAP=3Dy
CONFIG_X86_POPAD_OK=3Dy
CONFIG_X86_TSC=3Dy
CONFIG_X86_GOOD_APIC=3Dy
CONFIG_X86_USE_PPRO_CHECKSUM=3Dy
CONFIG_X86_USE_3DNOW=3Dy
# CONFIG_HUGETLB_PAGE is not set
# CONFIG_SMP is not set
CONFIG_PREEMPT=3Dy
CONFIG_X86_UP_APIC=3Dy
CONFIG_X86_UP_IOAPIC=3Dy
CONFIG_X86_LOCAL_APIC=3Dy
CONFIG_X86_IO_APIC=3Dy
CONFIG_X86_MCE=3Dy
CONFIG_X86_MCE_NONFATAL=3Dy
# CONFIG_X86_MCE_P4THERMAL is not set
# CONFIG_TOSHIBA is not set
# CONFIG_I8K is not set
# CONFIG_MICROCODE is not set
CONFIG_X86_MSR=3Dm
CONFIG_X86_CPUID=3Dm
CONFIG_EDD=3Dy
# CONFIG_NOHIGHMEM is not set
CONFIG_HIGHMEM4G=3Dy
# CONFIG_HIGHMEM64G is not set
CONFIG_HIGHMEM=3Dy
CONFIG_HIGHPTE=3Dy
# CONFIG_MATH_EMULATION is not set
CONFIG_MTRR=3Dy
CONFIG_HAVE_DEC_LOCK=3Dy

#
# Power management options (ACPI, APM)
#
CONFIG_PM=3Dy
# CONFIG_SOFTWARE_SUSPEND is not set

#
# ACPI Support
#
CONFIG_ACPI=3Dy
# CONFIG_ACPI_HT_ONLY is not set
CONFIG_ACPI_BOOT=3Dy
CONFIG_ACPI_AC=3Dy
CONFIG_ACPI_BATTERY=3Dy
CONFIG_ACPI_BUTTON=3Dy
CONFIG_ACPI_FAN=3Dy
CONFIG_ACPI_PROCESSOR=3Dy
CONFIG_ACPI_THERMAL=3Dy
CONFIG_ACPI_TOSHIBA=3Dy
CONFIG_ACPI_DEBUG=3Dy
CONFIG_ACPI_BUS=3Dy
CONFIG_ACPI_INTERPRETER=3Dy
CONFIG_ACPI_EC=3Dy
CONFIG_ACPI_POWER=3Dy
CONFIG_ACPI_PCI=3Dy
CONFIG_ACPI_SYSTEM=3Dy
# CONFIG_APM is not set
# CONFIG_CPU_FREQ is not set

#
# Bus options (PCI, PCMCIA, EISA, MCA, ISA)
#
CONFIG_PCI=3Dy
# CONFIG_PCI_GOBIOS is not set
# CONFIG_PCI_GODIRECT is not set
CONFIG_PCI_GOANY=3Dy
CONFIG_PCI_BIOS=3Dy
CONFIG_PCI_DIRECT=3Dy
# CONFIG_SCx200 is not set
# CONFIG_PCI_LEGACY_PROC is not set
CONFIG_PCI_NAMES=3Dy
# CONFIG_ISA is not set
# CONFIG_MCA is not set
# CONFIG_HOTPLUG is not set

#
# Executable file formats
#
CONFIG_KCORE_ELF=3Dy
# CONFIG_KCORE_AOUT is not set
CONFIG_BINFMT_AOUT=3Dm
CONFIG_BINFMT_ELF=3Dy
CONFIG_BINFMT_MISC=3Dm

#
# Memory Technology Devices (MTD)
#
# CONFIG_MTD is not set

#
# Parallel port support
#
CONFIG_PARPORT=3Dm
CONFIG_PARPORT_PC=3Dm
CONFIG_PARPORT_PC_CML1=3Dm
# CONFIG_PARPORT_SERIAL is not set
# CONFIG_PARPORT_PC_FIFO is not set
# CONFIG_PARPORT_PC_SUPERIO is not set
# CONFIG_PARPORT_OTHER is not set
CONFIG_PARPORT_1284=3Dy

#
# Plug and Play support
#
CONFIG_PNP=3Dy
CONFIG_PNP_NAMES=3Dy
CONFIG_PNP_CARD=3Dy
CONFIG_PNP_DEBUG=3Dy

#
# Protocols
#
CONFIG_ISAPNP=3Dy
CONFIG_PNPBIOS=3Dy

#
# Block devices
#
# CONFIG_BLK_DEV_FD is not set
# CONFIG_PARIDE is not set
# CONFIG_BLK_CPQ_DA is not set
# CONFIG_BLK_CPQ_CISS_DA is not set
# CONFIG_BLK_DEV_DAC960 is not set
# CONFIG_BLK_DEV_UMEM is not set
CONFIG_BLK_DEV_LOOP=3Dm
# CONFIG_BLK_DEV_NBD is not set
CONFIG_BLK_DEV_RAM=3Dy
CONFIG_BLK_DEV_RAM_SIZE=3D4096
CONFIG_BLK_DEV_INITRD=3Dy
# CONFIG_LBD is not set

#
# ATA/ATAPI/MFM/RLL device support
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
CONFIG_IDEDISK_MULTI_MODE=3Dy
# CONFIG_IDEDISK_STROKE is not set
CONFIG_BLK_DEV_IDECD=3Dm
CONFIG_BLK_DEV_IDEFLOPPY=3Dm
CONFIG_IDE_TASK_IOCTL=3Dy

#
# IDE chipset support/bugfixes
#
CONFIG_BLK_DEV_CMD640=3Dy
CONFIG_BLK_DEV_CMD640_ENHANCED=3Dy
# CONFIG_BLK_DEV_ISAPNP is not set
CONFIG_BLK_DEV_IDEPCI=3Dy
CONFIG_BLK_DEV_GENERIC=3Dy
CONFIG_IDEPCI_SHARE_IRQ=3Dy
CONFIG_BLK_DEV_IDEDMA_PCI=3Dy
CONFIG_BLK_DEV_IDE_TCQ=3Dy
CONFIG_BLK_DEV_IDE_TCQ_DEFAULT=3Dy
CONFIG_BLK_DEV_IDE_TCQ_DEPTH=3D8
CONFIG_BLK_DEV_OFFBOARD=3Dy
# CONFIG_BLK_DEV_IDEDMA_FORCED is not set
CONFIG_IDEDMA_PCI_AUTO=3Dy
# CONFIG_IDEDMA_ONLYDISK is not set
CONFIG_BLK_DEV_IDEDMA=3Dy
# CONFIG_IDEDMA_PCI_WIP is not set
CONFIG_BLK_DEV_ADMA=3Dy
# CONFIG_BLK_DEV_AEC62XX is not set
# CONFIG_BLK_DEV_ALI15X3 is not set
# CONFIG_BLK_DEV_AMD74XX is not set
CONFIG_BLK_DEV_CMD64X=3Dy
# CONFIG_BLK_DEV_TRIFLEX is not set
# CONFIG_BLK_DEV_CY82C693 is not set
# CONFIG_BLK_DEV_CS5520 is not set
# CONFIG_BLK_DEV_HPT34X is not set
# CONFIG_BLK_DEV_HPT366 is not set
# CONFIG_BLK_DEV_SC1200 is not set
# CONFIG_BLK_DEV_PIIX is not set
# CONFIG_BLK_DEV_NS87415 is not set
# CONFIG_BLK_DEV_OPTI621 is not set
# CONFIG_BLK_DEV_PDC202XX_OLD is not set
# CONFIG_BLK_DEV_PDC202XX_NEW is not set
# CONFIG_BLK_DEV_RZ1000 is not set
# CONFIG_BLK_DEV_SVWKS is not set
# CONFIG_BLK_DEV_SIIMAGE is not set
# CONFIG_BLK_DEV_SIS5513 is not set
# CONFIG_BLK_DEV_SLC90E66 is not set
# CONFIG_BLK_DEV_TRM290 is not set
CONFIG_BLK_DEV_VIA82CXXX=3Dy
CONFIG_IDEDMA_AUTO=3Dy
# CONFIG_IDEDMA_IVB is not set
CONFIG_BLK_DEV_IDE_MODES=3Dy

#
# SCSI device support
#
# CONFIG_SCSI is not set

#
# Multi-device support (RAID and LVM)
#
CONFIG_MD=3Dy
CONFIG_BLK_DEV_MD=3Dm
CONFIG_MD_LINEAR=3Dm
CONFIG_MD_RAID0=3Dm
CONFIG_MD_RAID1=3Dm
CONFIG_MD_RAID5=3Dm
CONFIG_MD_MULTIPATH=3Dm
CONFIG_BLK_DEV_DM=3Dm

#
# Fusion MPT device support
#

#
# IEEE 1394 (FireWire) support (EXPERIMENTAL)
#
CONFIG_IEEE1394=3Dm

#
# Subsystem Options
#
# CONFIG_IEEE1394_VERBOSEDEBUG is not set
CONFIG_IEEE1394_OUI_DB=3Dy

#
# Device Drivers
#
# CONFIG_IEEE1394_PCILYNX is not set
CONFIG_IEEE1394_OHCI1394=3Dm

#
# Protocol Drivers
#
CONFIG_IEEE1394_VIDEO1394=3Dm
CONFIG_IEEE1394_ETH1394=3Dm
CONFIG_IEEE1394_DV1394=3Dm
CONFIG_IEEE1394_RAWIO=3Dm
CONFIG_IEEE1394_CMP=3Dm
CONFIG_IEEE1394_AMDTP=3Dm

#
# I2O device support
#
CONFIG_I2O=3Dm
CONFIG_I2O_PCI=3Dm
CONFIG_I2O_BLOCK=3Dm
# CONFIG_I2O_LAN is not set
CONFIG_I2O_PROC=3Dm

#
# Networking support
#
CONFIG_NET=3Dy

#
# Networking options
#
CONFIG_PACKET=3Dm
CONFIG_PACKET_MMAP=3Dy
# CONFIG_NETLINK_DEV is not set
CONFIG_NETFILTER=3Dy
# CONFIG_NETFILTER_DEBUG is not set
CONFIG_FILTER=3Dy
CONFIG_UNIX=3Dy
CONFIG_NET_KEY=3Dy
CONFIG_INET=3Dy
CONFIG_IP_MULTICAST=3Dy
CONFIG_IP_ADVANCED_ROUTER=3Dy
CONFIG_IP_MULTIPLE_TABLES=3Dy
CONFIG_IP_ROUTE_FWMARK=3Dy
CONFIG_IP_ROUTE_NAT=3Dy
CONFIG_IP_ROUTE_MULTIPATH=3Dy
CONFIG_IP_ROUTE_TOS=3Dy
CONFIG_IP_ROUTE_VERBOSE=3Dy
CONFIG_IP_ROUTE_LARGE_TABLES=3Dy
# CONFIG_IP_PNP is not set
CONFIG_NET_IPIP=3Dm
# CONFIG_NET_IPGRE is not set
CONFIG_IP_MROUTE=3Dy
CONFIG_IP_PIMSM_V1=3Dy
CONFIG_IP_PIMSM_V2=3Dy
# CONFIG_ARPD is not set
CONFIG_INET_ECN=3Dy
# CONFIG_SYN_COOKIES is not set
# CONFIG_INET_AH is not set
# CONFIG_INET_ESP is not set
CONFIG_XFRM_USER=3Dm

#
# IP: Netfilter Configuration
#
CONFIG_IP_NF_CONNTRACK=3Dm
CONFIG_IP_NF_FTP=3Dm
CONFIG_IP_NF_IRC=3Dm
CONFIG_IP_NF_QUEUE=3Dm
CONFIG_IP_NF_IPTABLES=3Dm
CONFIG_IP_NF_MATCH_LIMIT=3Dm
CONFIG_IP_NF_MATCH_MAC=3Dm
CONFIG_IP_NF_MATCH_PKTTYPE=3Dm
CONFIG_IP_NF_MATCH_MARK=3Dm
CONFIG_IP_NF_MATCH_MULTIPORT=3Dm
CONFIG_IP_NF_MATCH_TOS=3Dm
CONFIG_IP_NF_MATCH_ECN=3Dm
CONFIG_IP_NF_MATCH_DSCP=3Dm
CONFIG_IP_NF_MATCH_AH_ESP=3Dm
CONFIG_IP_NF_MATCH_LENGTH=3Dm
CONFIG_IP_NF_MATCH_TTL=3Dm
CONFIG_IP_NF_MATCH_TCPMSS=3Dm
CONFIG_IP_NF_MATCH_HELPER=3Dm
CONFIG_IP_NF_MATCH_STATE=3Dm
CONFIG_IP_NF_MATCH_CONNTRACK=3Dm
CONFIG_IP_NF_MATCH_UNCLEAN=3Dm
CONFIG_IP_NF_MATCH_OWNER=3Dm
CONFIG_IP_NF_FILTER=3Dm
CONFIG_IP_NF_TARGET_REJECT=3Dm
CONFIG_IP_NF_TARGET_MIRROR=3Dm
CONFIG_IP_NF_NAT=3Dm
CONFIG_IP_NF_NAT_NEEDED=3Dy
CONFIG_IP_NF_TARGET_MASQUERADE=3Dm
CONFIG_IP_NF_TARGET_REDIRECT=3Dm
# CONFIG_IP_NF_NAT_LOCAL is not set
CONFIG_IP_NF_NAT_SNMP_BASIC=3Dm
CONFIG_IP_NF_NAT_IRC=3Dm
CONFIG_IP_NF_NAT_FTP=3Dm
CONFIG_IP_NF_MANGLE=3Dm
CONFIG_IP_NF_TARGET_TOS=3Dm
CONFIG_IP_NF_TARGET_ECN=3Dm
CONFIG_IP_NF_TARGET_DSCP=3Dm
CONFIG_IP_NF_TARGET_MARK=3Dm
CONFIG_IP_NF_TARGET_LOG=3Dm
CONFIG_IP_NF_TARGET_ULOG=3Dm
CONFIG_IP_NF_TARGET_TCPMSS=3Dm
CONFIG_IP_NF_ARPTABLES=3Dm
CONFIG_IP_NF_ARPFILTER=3Dm
CONFIG_IP_NF_COMPAT_IPCHAINS=3Dm
CONFIG_IP_NF_COMPAT_IPFWADM=3Dm
# CONFIG_IPV6 is not set

#
# SCTP Configuration (EXPERIMENTAL)
#
CONFIG_IPV6_SCTP__=3Dy
# CONFIG_IP_SCTP is not set
# CONFIG_ATM is not set
CONFIG_VLAN_8021Q=3Dm
CONFIG_LLC=3Dm
CONFIG_LLC_UI=3Dy
CONFIG_IPX=3Dm
CONFIG_IPX_INTERN=3Dy
CONFIG_ATALK=3Dm
CONFIG_DEV_APPLETALK=3Dy
CONFIG_IPDDP=3Dm
CONFIG_IPDDP_ENCAP=3Dy
CONFIG_IPDDP_DECAP=3Dy
# CONFIG_DECNET is not set
# CONFIG_BRIDGE is not set
# CONFIG_X25 is not set
CONFIG_LAPB=3Dm
# CONFIG_NET_DIVERT is not set
# CONFIG_ECONET is not set
# CONFIG_WAN_ROUTER is not set
# CONFIG_NET_FASTROUTE is not set
CONFIG_NET_HW_FLOWCONTROL=3Dy

#
# QoS and/or fair queueing
#
CONFIG_NET_SCHED=3Dy
CONFIG_NET_SCH_CBQ=3Dm
CONFIG_NET_SCH_HTB=3Dm
CONFIG_NET_SCH_CSZ=3Dm
CONFIG_NET_SCH_PRIO=3Dm
CONFIG_NET_SCH_RED=3Dm
CONFIG_NET_SCH_SFQ=3Dm
CONFIG_NET_SCH_TEQL=3Dm
CONFIG_NET_SCH_TBF=3Dm
CONFIG_NET_SCH_GRED=3Dm
CONFIG_NET_SCH_DSMARK=3Dm
CONFIG_NET_SCH_INGRESS=3Dm
CONFIG_NET_QOS=3Dy
CONFIG_NET_ESTIMATOR=3Dy
CONFIG_NET_CLS=3Dy
CONFIG_NET_CLS_TCINDEX=3Dm
CONFIG_NET_CLS_ROUTE4=3Dm
CONFIG_NET_CLS_ROUTE=3Dy
CONFIG_NET_CLS_FW=3Dm
CONFIG_NET_CLS_U32=3Dm
CONFIG_NET_CLS_RSVP=3Dm
CONFIG_NET_CLS_RSVP6=3Dm
# CONFIG_NET_CLS_POLICE is not set

#
# Network testing
#
# CONFIG_NET_PKTGEN is not set
CONFIG_NETDEVICES=3Dy

#
# ARCnet devices
#
# CONFIG_ARCNET is not set
CONFIG_DUMMY=3Dm
# CONFIG_BONDING is not set
CONFIG_EQUALIZER=3Dm
CONFIG_TUN=3Dm
# CONFIG_ETHERTAP is not set
# CONFIG_NET_SB1000 is not set

#
# Ethernet (10 or 100Mbit)
#
CONFIG_NET_ETHERNET=3Dy
# CONFIG_MII is not set
# CONFIG_HAPPYMEAL is not set
# CONFIG_SUNGEM is not set
CONFIG_NET_VENDOR_3COM=3Dy
CONFIG_VORTEX=3Dm

#
# Tulip family network device support
#
# CONFIG_NET_TULIP is not set
# CONFIG_HP100 is not set
CONFIG_NET_PCI=3Dy
# CONFIG_PCNET32 is not set
# CONFIG_AMD8111_ETH is not set
# CONFIG_ADAPTEC_STARFIRE is not set
# CONFIG_B44 is not set
# CONFIG_DGRS is not set
# CONFIG_EEPRO100 is not set
# CONFIG_E100 is not set
# CONFIG_FEALNX is not set
# CONFIG_NATSEMI is not set
# CONFIG_NE2K_PCI is not set
CONFIG_8139CP=3Dm
CONFIG_8139TOO=3Dm
# CONFIG_8139TOO_PIO is not set
CONFIG_8139TOO_TUNE_TWISTER=3Dy
CONFIG_8139TOO_8129=3Dy
# CONFIG_8139_OLD_RX_RESET is not set
# CONFIG_SIS900 is not set
# CONFIG_EPIC100 is not set
# CONFIG_SUNDANCE is not set
# CONFIG_TLAN is not set
CONFIG_VIA_RHINE=3Dm
# CONFIG_VIA_RHINE_MMIO is not set

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
# CONFIG_SK98LIN is not set
# CONFIG_TIGON3 is not set
# CONFIG_FDDI is not set
# CONFIG_HIPPI is not set
CONFIG_PLIP=3Dm
CONFIG_PPP=3Dm
CONFIG_PPP_MULTILINK=3Dy
CONFIG_PPP_FILTER=3Dy
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
# Token Ring devices (depends on LLC=3Dy)
#
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
# CONFIG_ISDN_BOOL is not set

#
# Telephony Support
#
# CONFIG_PHONE is not set

#
# Input device support
#
CONFIG_INPUT=3Dy

#
# Userland interfaces
#
CONFIG_INPUT_MOUSEDEV=3Dy
CONFIG_INPUT_MOUSEDEV_PSAUX=3Dy
CONFIG_INPUT_MOUSEDEV_SCREEN_X=3D1024
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=3D768
CONFIG_INPUT_JOYDEV=3Dm
CONFIG_INPUT_TSDEV=3Dm
CONFIG_INPUT_TSDEV_SCREEN_X=3D240
CONFIG_INPUT_TSDEV_SCREEN_Y=3D320
CONFIG_INPUT_EVDEV=3Dy
# CONFIG_INPUT_EVBUG is not set

#
# Input I/O drivers
#
# CONFIG_GAMEPORT is not set
CONFIG_SOUND_GAMEPORT=3Dy
CONFIG_SERIO=3Dy
CONFIG_SERIO_I8042=3Dy
CONFIG_SERIO_SERPORT=3Dy
CONFIG_SERIO_CT82C710=3Dy
CONFIG_SERIO_PARKBD=3Dm

#
# Input Device Drivers
#
CONFIG_INPUT_KEYBOARD=3Dy
CONFIG_KEYBOARD_ATKBD=3Dy
# CONFIG_KEYBOARD_SUNKBD is not set
# CONFIG_KEYBOARD_XTKBD is not set
# CONFIG_KEYBOARD_NEWTON is not set
CONFIG_INPUT_MOUSE=3Dy
CONFIG_MOUSE_PS2=3Dy
# CONFIG_MOUSE_SERIAL is not set
# CONFIG_INPUT_JOYSTICK is not set
# CONFIG_INPUT_TOUCHSCREEN is not set
CONFIG_INPUT_MISC=3Dy
CONFIG_INPUT_PCSPKR=3Dm
CONFIG_INPUT_UINPUT=3Dm

#
# Character devices
#
CONFIG_VT=3Dy
CONFIG_VT_CONSOLE=3Dy
CONFIG_HW_CONSOLE=3Dy
# CONFIG_SERIAL_NONSTANDARD is not set

#
# Serial drivers
#
CONFIG_SERIAL_8250=3Dy
# CONFIG_SERIAL_8250_CONSOLE is not set
# CONFIG_SERIAL_8250_EXTENDED is not set

#
# Non-8250 serial port support
#
CONFIG_SERIAL_CORE=3Dy
CONFIG_UNIX98_PTYS=3Dy
CONFIG_UNIX98_PTY_COUNT=3D256
CONFIG_PRINTER=3Dm
# CONFIG_LP_CONSOLE is not set
# CONFIG_PPDEV is not set
# CONFIG_TIPAR is not set

#
# I2C support
#
CONFIG_I2C=3Dm
CONFIG_I2C_ALGOBIT=3Dm
CONFIG_I2C_PHILIPSPAR=3Dm
CONFIG_I2C_ELV=3Dm
CONFIG_I2C_VELLEMAN=3Dm
CONFIG_SCx200_ACB=3Dm
CONFIG_I2C_ALGOPCF=3Dm
CONFIG_I2C_ELEKTOR=3Dm
CONFIG_I2C_CHARDEV=3Dm
CONFIG_I2C_PROC=3Dm

#
# I2C Hardware Sensors Mainboard support
#
CONFIG_I2C_AMD756=3Dm
CONFIG_I2C_AMD8111=3Dm

#
# I2C Hardware Sensors Chip support
#
CONFIG_SENSORS_ADM1021=3Dm
CONFIG_SENSORS_LM75=3Dm

#
# Mice
#
CONFIG_BUSMOUSE=3Dm
# CONFIG_QIC02_TAPE is not set

#
# IPMI
#
CONFIG_IPMI_HANDLER=3Dm
# CONFIG_IPMI_PANIC_EVENT is not set
CONFIG_IPMI_DEVICE_INTERFACE=3Dm
CONFIG_IPMI_KCS=3Dm
CONFIG_IPMI_WATCHDOG=3Dm

#
# Watchdog Cards
#
CONFIG_WATCHDOG=3Dy
# CONFIG_WATCHDOG_NOWAYOUT is not set
CONFIG_SOFT_WATCHDOG=3Dm
CONFIG_WDT=3Dm
CONFIG_WDTPCI=3Dm
# CONFIG_WDT_501 is not set
# CONFIG_PCWATCHDOG is not set
# CONFIG_ACQUIRE_WDT is not set
# CONFIG_ADVANTECH_WDT is not set
# CONFIG_EUROTECH_WDT is not set
# CONFIG_IB700_WDT is not set
# CONFIG_I810_TCO is not set
# CONFIG_MIXCOMWD is not set
# CONFIG_SCx200_WDT is not set
# CONFIG_60XX_WDT is not set
# CONFIG_W83877F_WDT is not set
# CONFIG_MACHZ_WDT is not set
# CONFIG_SC520_WDT is not set
# CONFIG_ALIM7101_WDT is not set
# CONFIG_SC1200_WDT is not set
# CONFIG_WAFER_WDT is not set
# CONFIG_CPU5_WDT is not set
CONFIG_INTEL_RNG=3Dm
CONFIG_AMD_RNG=3Dm
CONFIG_NVRAM=3Dm
CONFIG_RTC=3Dy
# CONFIG_DTLK is not set
# CONFIG_R3964 is not set
# CONFIG_APPLICOM is not set
# CONFIG_SONYPI is not set

#
# Ftape, the floppy tape device driver
#
# CONFIG_FTAPE is not set
CONFIG_AGP=3Dm
CONFIG_AGP3=3Dy
CONFIG_AGP_INTEL=3Dm
CONFIG_AGP_VIA=3Dm
CONFIG_AGP_AMD=3Dm
CONFIG_AGP_SIS=3Dm
CONFIG_AGP_ALI=3Dm
CONFIG_AGP_SWORKS=3Dm
CONFIG_AGP_AMD_8151=3Dm
CONFIG_AGP_I7505=3Dm
CONFIG_DRM=3Dy
CONFIG_DRM_TDFX=3Dm
CONFIG_DRM_R128=3Dm
CONFIG_DRM_RADEON=3Dm
CONFIG_DRM_I810=3Dm
CONFIG_DRM_I830=3Dm
CONFIG_DRM_MGA=3Dm
# CONFIG_MWAVE is not set
CONFIG_RAW_DRIVER=3Dy
CONFIG_HANGCHECK_TIMER=3Dy

#
# Multimedia devices
#
# CONFIG_VIDEO_DEV is not set

#
# File systems
#
CONFIG_QUOTA=3Dy
CONFIG_QFMT_V1=3Dm
CONFIG_QFMT_V2=3Dm
CONFIG_QUOTACTL=3Dy
CONFIG_AUTOFS_FS=3Dm
CONFIG_AUTOFS4_FS=3Dm
CONFIG_REISERFS_FS=3Dy
# CONFIG_REISERFS_CHECK is not set
CONFIG_REISERFS_PROC_INFO=3Dy
# CONFIG_ADFS_FS is not set
# CONFIG_AFFS_FS is not set
# CONFIG_HFS_FS is not set
# CONFIG_BEFS_FS is not set
# CONFIG_BFS_FS is not set
CONFIG_EXT3_FS=3Dm
CONFIG_EXT3_FS_XATTR=3Dy
CONFIG_EXT3_FS_POSIX_ACL=3Dy
CONFIG_JBD=3Dy
CONFIG_JBD_DEBUG=3Dy
CONFIG_FAT_FS=3Dm
CONFIG_MSDOS_FS=3Dm
CONFIG_VFAT_FS=3Dm
# CONFIG_EFS_FS is not set
# CONFIG_CRAMFS is not set
CONFIG_TMPFS=3Dy
CONFIG_RAMFS=3Dy
CONFIG_ISO9660_FS=3Dm
CONFIG_JOLIET=3Dy
CONFIG_ZISOFS=3Dy
CONFIG_JFS_FS=3Dm
CONFIG_JFS_POSIX_ACL=3Dy
# CONFIG_JFS_DEBUG is not set
CONFIG_JFS_STATISTICS=3Dy
CONFIG_MINIX_FS=3Dm
# CONFIG_VXFS_FS is not set
CONFIG_NTFS_FS=3Dm
# CONFIG_NTFS_DEBUG is not set
# CONFIG_NTFS_RW is not set
# CONFIG_HPFS_FS is not set
CONFIG_PROC_FS=3Dy
CONFIG_DEVFS_FS=3Dy
CONFIG_DEVFS_MOUNT=3Dy
# CONFIG_DEVFS_DEBUG is not set
CONFIG_DEVPTS_FS=3Dy
# CONFIG_QNX4FS_FS is not set
CONFIG_ROMFS_FS=3Dm
CONFIG_EXT2_FS=3Dy
CONFIG_EXT2_FS_XATTR=3Dy
CONFIG_EXT2_FS_POSIX_ACL=3Dy
# CONFIG_SYSV_FS is not set
CONFIG_UDF_FS=3Dm
# CONFIG_UFS_FS is not set
# CONFIG_XFS_FS is not set

#
# Network File Systems
#
CONFIG_CODA_FS=3Dm
# CONFIG_INTERMEZZO_FS is not set
CONFIG_NFS_FS=3Dm
CONFIG_NFS_V3=3Dy
CONFIG_NFS_V4=3Dy
CONFIG_NFSD=3Dm
CONFIG_NFSD_V3=3Dy
CONFIG_NFSD_V4=3Dy
CONFIG_NFSD_TCP=3Dy
CONFIG_SUNRPC=3Dm
CONFIG_SUNRPC_GSS=3Dm
CONFIG_LOCKD=3Dm
CONFIG_LOCKD_V4=3Dy
CONFIG_EXPORTFS=3Dm
CONFIG_CIFS=3Dm
CONFIG_SMB_FS=3Dm
CONFIG_SMB_NLS_DEFAULT=3Dy
CONFIG_SMB_NLS_REMOTE=3D"cp437"
# CONFIG_NCP_FS is not set
# CONFIG_AFS_FS is not set
CONFIG_ZISOFS_FS=3Dm
CONFIG_FS_MBCACHE=3Dy
CONFIG_FS_POSIX_ACL=3Dy

#
# Partition Types
#
CONFIG_PARTITION_ADVANCED=3Dy
CONFIG_ACORN_PARTITION=3Dy
CONFIG_ACORN_PARTITION_ICS=3Dy
CONFIG_ACORN_PARTITION_ADFS=3Dy
CONFIG_ACORN_PARTITION_POWERTEC=3Dy
CONFIG_ACORN_PARTITION_RISCIX=3Dy
CONFIG_OSF_PARTITION=3Dy
CONFIG_AMIGA_PARTITION=3Dy
CONFIG_ATARI_PARTITION=3Dy
CONFIG_MAC_PARTITION=3Dy
CONFIG_MSDOS_PARTITION=3Dy
CONFIG_BSD_DISKLABEL=3Dy
CONFIG_MINIX_SUBPARTITION=3Dy
CONFIG_SOLARIS_X86_PARTITION=3Dy
CONFIG_UNIXWARE_DISKLABEL=3Dy
CONFIG_LDM_PARTITION=3Dy
CONFIG_LDM_DEBUG=3Dy
CONFIG_SGI_PARTITION=3Dy
CONFIG_ULTRIX_PARTITION=3Dy
CONFIG_SUN_PARTITION=3Dy
CONFIG_EFI_PARTITION=3Dy
CONFIG_SMB_NLS=3Dy
CONFIG_NLS=3Dy

#
# Native Language Support
#
CONFIG_NLS_DEFAULT=3D"iso8859-1"
CONFIG_NLS_CODEPAGE_437=3Dy
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
# CONFIG_NLS_CODEPAGE_936 is not set
# CONFIG_NLS_CODEPAGE_950 is not set
# CONFIG_NLS_CODEPAGE_932 is not set
# CONFIG_NLS_CODEPAGE_949 is not set
# CONFIG_NLS_CODEPAGE_874 is not set
# CONFIG_NLS_ISO8859_8 is not set
# CONFIG_NLS_CODEPAGE_1250 is not set
# CONFIG_NLS_CODEPAGE_1251 is not set
CONFIG_NLS_ISO8859_1=3Dy
# CONFIG_NLS_ISO8859_2 is not set
# CONFIG_NLS_ISO8859_3 is not set
# CONFIG_NLS_ISO8859_4 is not set
# CONFIG_NLS_ISO8859_5 is not set
# CONFIG_NLS_ISO8859_6 is not set
# CONFIG_NLS_ISO8859_7 is not set
# CONFIG_NLS_ISO8859_9 is not set
# CONFIG_NLS_ISO8859_13 is not set
# CONFIG_NLS_ISO8859_14 is not set
# CONFIG_NLS_ISO8859_15 is not set
# CONFIG_NLS_KOI8_R is not set
# CONFIG_NLS_KOI8_U is not set
# CONFIG_NLS_UTF8 is not set

#
# Graphics support
#
CONFIG_FB=3Dy
# CONFIG_FB_CLGEN is not set
# CONFIG_FB_PM2 is not set
# CONFIG_FB_CYBER2000 is not set
# CONFIG_FB_IMSTT is not set
# CONFIG_FB_VGA16 is not set
CONFIG_FB_VESA=3Dy
CONFIG_VIDEO_SELECT=3Dy
# CONFIG_FB_HGA is not set
# CONFIG_FB_RIVA is not set
# CONFIG_FB_I810 is not set
# CONFIG_FB_MATROX is not set
# CONFIG_FB_RADEON is not set
# CONFIG_FB_ATY128 is not set
# CONFIG_FB_ATY is not set
# CONFIG_FB_SIS is not set
# CONFIG_FB_NEOMAGIC is not set
# CONFIG_FB_3DFX is not set
# CONFIG_FB_VOODOO1 is not set
# CONFIG_FB_TRIDENT is not set
# CONFIG_FB_PM3 is not set
# CONFIG_FB_VIRTUAL is not set

#
# Console display driver support
#
CONFIG_VGA_CONSOLE=3Dy
# CONFIG_MDA_CONSOLE is not set
CONFIG_DUMMY_CONSOLE=3Dy
CONFIG_FRAMEBUFFER_CONSOLE=3Dy
CONFIG_PCI_CONSOLE=3Dy
CONFIG_FBCON_ADVANCED=3Dy
CONFIG_FONT_SUN8x16=3Dy
# CONFIG_FONT_SUN12x22 is not set
CONFIG_FONTS=3Dy
# CONFIG_FONT_8x8 is not set
# CONFIG_FONT_8x16 is not set
# CONFIG_FONT_6x11 is not set
# CONFIG_FONT_PEARL_8x8 is not set
# CONFIG_FONT_ACORN_8x8 is not set
# CONFIG_FONT_MINI_4x6 is not set

#
# Sound
#
CONFIG_SOUND=3Dy

#
# Advanced Linux Sound Architecture
#
CONFIG_SND=3Dm
CONFIG_SND_SEQUENCER=3Dm
# CONFIG_SND_SEQ_DUMMY is not set
CONFIG_SND_OSSEMUL=3Dy
CONFIG_SND_MIXER_OSS=3Dm
CONFIG_SND_PCM_OSS=3Dm
CONFIG_SND_SEQUENCER_OSS=3Dy
CONFIG_SND_RTCTIMER=3Dm
CONFIG_SND_VERBOSE_PRINTK=3Dy
# CONFIG_SND_DEBUG is not set

#
# Generic devices
#
CONFIG_SND_DUMMY=3Dm
CONFIG_SND_VIRMIDI=3Dm
CONFIG_SND_MTPAV=3Dm
CONFIG_SND_SERIAL_U16550=3Dm
CONFIG_SND_MPU401=3Dm

#
# PCI devices
#
# CONFIG_SND_ALI5451 is not set
# CONFIG_SND_CS46XX is not set
# CONFIG_SND_CS4281 is not set
CONFIG_SND_EMU10K1=3Dm
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
# CONFIG_SND_INTEL8X0 is not set
# CONFIG_SND_SONICVIBES is not set
CONFIG_SND_VIA82XX=3Dm

#
# ALSA USB devices
#
# CONFIG_SND_USB_AUDIO is not set

#
# Open Sound System
#
# CONFIG_SOUND_PRIME is not set

#
# USB support
#
CONFIG_USB=3Dy
CONFIG_USB_DEBUG=3Dy

#
# Miscellaneous USB options
#
CONFIG_USB_DEVICEFS=3Dy
CONFIG_USB_BANDWIDTH=3Dy
CONFIG_USB_DYNAMIC_MINORS=3Dy

#
# USB Host Controller Drivers
#
CONFIG_USB_EHCI_HCD=3Dm
CONFIG_USB_OHCI_HCD=3Dm
CONFIG_USB_UHCI_HCD=3Dm

#
# USB Device Class drivers
#
CONFIG_USB_AUDIO=3Dm
CONFIG_USB_BLUETOOTH_TTY=3Dm
CONFIG_USB_MIDI=3Dm
CONFIG_USB_ACM=3Dm
CONFIG_USB_PRINTER=3Dm

#
# SCSI support is needed for USB Storage
#

#
# USB Human Interface Devices (HID)
#
CONFIG_USB_HID=3Dm
CONFIG_USB_HIDINPUT=3Dy
# CONFIG_HID_FF is not set
CONFIG_USB_HIDDEV=3Dy

#
# USB HID Boot Protocol drivers
#
CONFIG_USB_KBD=3Dm
CONFIG_USB_MOUSE=3Dm
# CONFIG_USB_AIPTEK is not set
# CONFIG_USB_WACOM is not set
# CONFIG_USB_POWERMATE is not set
# CONFIG_USB_XPAD is not set

#
# USB Imaging devices
#
CONFIG_USB_MDC800=3Dm
CONFIG_USB_SCANNER=3Dm

#
# USB Multimedia devices
#
CONFIG_USB_DABUSB=3Dm

#
# Video4Linux support is needed for USB Multimedia device support
#

#
# USB Network adaptors
#
CONFIG_USB_CATC=3Dm
CONFIG_USB_CDCETHER=3Dm
CONFIG_USB_KAWETH=3Dm
CONFIG_USB_PEGASUS=3Dm
CONFIG_USB_RTL8150=3Dm
CONFIG_USB_USBNET=3Dm

#
# USB port drivers
#
CONFIG_USB_USS720=3Dm

#
# USB Serial Converter support
#
# CONFIG_USB_SERIAL is not set

#
# USB Miscellaneous drivers
#
CONFIG_USB_EMI26=3Dm
CONFIG_USB_TIGL=3Dm
CONFIG_USB_AUERSWALD=3Dm
CONFIG_USB_RIO500=3Dm
CONFIG_USB_BRLVGER=3Dm
CONFIG_USB_LCD=3Dm
CONFIG_USB_TEST=3Dm

#
# Bluetooth support
#
# CONFIG_BT is not set

#
# Profiling support
#
# CONFIG_PROFILING is not set

#
# Kernel hacking
#
CONFIG_DEBUG_KERNEL=3Dy
# CONFIG_DEBUG_STACKOVERFLOW is not set
# CONFIG_DEBUG_SLAB is not set
# CONFIG_X86_REMOTE_DEBUG is not set
# CONFIG_DEBUG_IOVIRT is not set
CONFIG_MAGIC_SYSRQ=3Dy
# CONFIG_DEBUG_SPINLOCK is not set
# CONFIG_DEBUG_HIGHMEM is not set
CONFIG_KALLSYMS=3Dy
# CONFIG_DEBUG_SPINLOCK_SLEEP is not set
# CONFIG_FRAME_POINTER is not set
CONFIG_X86_EXTRA_IRQS=3Dy
CONFIG_X86_FIND_SMP_CONFIG=3Dy
CONFIG_X86_MPPARSE=3Dy

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
CONFIG_ZLIB_INFLATE=3Dm
CONFIG_ZLIB_DEFLATE=3Dm
CONFIG_X86_BIOS_REBOOT=3Dy

--=-mHMhmgk/80DTI6Ti5dZm
Content-Description: 
Content-Disposition: inline; filename=2.5.60-mm2.out
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=ISO-8859-1

  Generating include/linux/version.h (updated)
  Making asm->asm-i386 symlink
make -f scripts/Makefile.build obj=3Dscripts
  SPLIT  include/linux/autoconf.h -> include/config/*
make -f scripts/Makefile.build obj=3Dinit init/vermagic.o
  gcc296 -Wp,-MD,init/.vermagic.o.d -D__KERNEL__ -Iinclude -Wall -Wstrict-p=
rototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -pipe -mprefe=
rred-stack-boundary=3D2 -march=3Dathlon -Iinclude/asm-i386/mach-default -fo=
mit-frame-pointer -nostdinc -iwithprefix include    -DKBUILD_BASENAME=3Dver=
magic -DKBUILD_MODNAME=3Dvermagic -c -o init/.tmp_vermagic.o init/vermagic.=
c
  Starting the build. KBUILD_BUILTIN=3D1 KBUILD_MODULES=3D
make -f scripts/Makefile.build obj=3Dinit
  gcc296 -Wp,-MD,init/.main.o.d -D__KERNEL__ -Iinclude -Wall -Wstrict-proto=
types -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -pipe -mpreferred=
-stack-boundary=3D2 -march=3Dathlon -Iinclude/asm-i386/mach-default -fomit-=
frame-pointer -nostdinc -iwithprefix include    -DKBUILD_BASENAME=3Dmain -D=
KBUILD_MODNAME=3Dmain -c -o init/.tmp_main.o init/main.c
  Generating include/linux/compile.h (updated)
  gcc296 -Wp,-MD,init/.version.o.d -D__KERNEL__ -Iinclude -Wall -Wstrict-pr=
ototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -pipe -mprefer=
red-stack-boundary=3D2 -march=3Dathlon -Iinclude/asm-i386/mach-default -fom=
it-frame-pointer -nostdinc -iwithprefix include    -DKBUILD_BASENAME=3Dvers=
ion -DKBUILD_MODNAME=3Dversion -c -o init/.tmp_version.o init/version.c
  gcc296 -Wp,-MD,init/.do_mounts.o.d -D__KERNEL__ -Iinclude -Wall -Wstrict-=
prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -pipe -mpref=
erred-stack-boundary=3D2 -march=3Dathlon -Iinclude/asm-i386/mach-default -f=
omit-frame-pointer -nostdinc -iwithprefix include    -DKBUILD_BASENAME=3Ddo=
_mounts -DKBUILD_MODNAME=3Ddo_mounts -c -o init/.tmp_do_mounts.o init/do_mo=
unts.c
  gcc296 -Wp,-MD,init/.initramfs.o.d -D__KERNEL__ -Iinclude -Wall -Wstrict-=
prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -pipe -mpref=
erred-stack-boundary=3D2 -march=3Dathlon -Iinclude/asm-i386/mach-default -f=
omit-frame-pointer -nostdinc -iwithprefix include    -DKBUILD_BASENAME=3Din=
itramfs -DKBUILD_MODNAME=3Dinitramfs -c -o init/.tmp_initramfs.o init/initr=
amfs.c
   ld -m elf_i386  -r -o init/built-in.o init/main.o init/version.o init/do=
_mounts.o init/initramfs.o init/vermagic.o
make -f scripts/Makefile.build obj=3Dusr
  gcc296 -Wp,-MD,usr/.gen_init_cpio.d -Wall -Wstrict-prototypes -O2 -fomit-=
frame-pointer    -o usr/gen_init_cpio usr/gen_init_cpio.c
./usr/gen_init_cpio | gzip -9c > usr/initramfs_data.cpio.gz
  ld -m elf_i386  --format binary --oformat elf32-i386 -r -T usr/initramfs_=
data.scr usr/initramfs_data.cpio.gz -o usr/initramfs_data.o=20
   ld -m elf_i386  -r -o usr/built-in.o usr/initramfs_data.o
make -f scripts/Makefile.build obj=3Darch/i386/kernel
  gcc296 -Wp,-MD,arch/i386/kernel/.process.o.d -D__KERNEL__ -Iinclude -Wall=
 -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -p=
ipe -mpreferred-stack-boundary=3D2 -march=3Dathlon -Iinclude/asm-i386/mach-=
default -fomit-frame-pointer -nostdinc -iwithprefix include    -DKBUILD_BAS=
ENAME=3Dprocess -DKBUILD_MODNAME=3Dprocess -c -o arch/i386/kernel/.tmp_proc=
ess.o arch/i386/kernel/process.c
  gcc296 -Wp,-MD,arch/i386/kernel/.semaphore.o.d -D__KERNEL__ -Iinclude -Wa=
ll -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common =
-pipe -mpreferred-stack-boundary=3D2 -march=3Dathlon -Iinclude/asm-i386/mac=
h-default -fomit-frame-pointer -nostdinc -iwithprefix include    -DKBUILD_B=
ASENAME=3Dsemaphore -DKBUILD_MODNAME=3Dsemaphore -c -o arch/i386/kernel/.tm=
p_semaphore.o arch/i386/kernel/semaphore.c
  gcc296 -Wp,-MD,arch/i386/kernel/.signal.o.d -D__KERNEL__ -Iinclude -Wall =
-Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -pi=
pe -mpreferred-stack-boundary=3D2 -march=3Dathlon -Iinclude/asm-i386/mach-d=
efault -fomit-frame-pointer -nostdinc -iwithprefix include    -DKBUILD_BASE=
NAME=3Dsignal -DKBUILD_MODNAME=3Dsignal -c -o arch/i386/kernel/.tmp_signal.=
o arch/i386/kernel/signal.c
  gcc296 -Wp,-MD,arch/i386/kernel/.entry.o.d -D__ASSEMBLY__ -D__KERNEL__ -I=
include -Iinclude/asm-i386/mach-default -nostdinc -iwithprefix include  -tr=
aditional  -c -o arch/i386/kernel/entry.o arch/i386/kernel/entry.S
  gcc296 -Wp,-MD,arch/i386/kernel/.traps.o.d -D__KERNEL__ -Iinclude -Wall -=
Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -pip=
e -mpreferred-stack-boundary=3D2 -march=3Dathlon -Iinclude/asm-i386/mach-de=
fault -fomit-frame-pointer -nostdinc -iwithprefix include    -DKBUILD_BASEN=
AME=3Dtraps -DKBUILD_MODNAME=3Dtraps -c -o arch/i386/kernel/.tmp_traps.o ar=
ch/i386/kernel/traps.c
  gcc296 -Wp,-MD,arch/i386/kernel/.irq.o.d -D__KERNEL__ -Iinclude -Wall -Ws=
trict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -pipe =
-mpreferred-stack-boundary=3D2 -march=3Dathlon -Iinclude/asm-i386/mach-defa=
ult -fomit-frame-pointer -nostdinc -iwithprefix include    -DKBUILD_BASENAM=
E=3Dirq -DKBUILD_MODNAME=3Dirq -c -o arch/i386/kernel/.tmp_irq.o arch/i386/=
kernel/irq.c
  gcc296 -Wp,-MD,arch/i386/kernel/.vm86.o.d -D__KERNEL__ -Iinclude -Wall -W=
strict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -pipe=
 -mpreferred-stack-boundary=3D2 -march=3Dathlon -Iinclude/asm-i386/mach-def=
ault -fomit-frame-pointer -nostdinc -iwithprefix include    -DKBUILD_BASENA=
ME=3Dvm86 -DKBUILD_MODNAME=3Dvm86 -c -o arch/i386/kernel/.tmp_vm86.o arch/i=
386/kernel/vm86.c
  gcc296 -Wp,-MD,arch/i386/kernel/.ptrace.o.d -D__KERNEL__ -Iinclude -Wall =
-Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -pi=
pe -mpreferred-stack-boundary=3D2 -march=3Dathlon -Iinclude/asm-i386/mach-d=
efault -fomit-frame-pointer -nostdinc -iwithprefix include    -DKBUILD_BASE=
NAME=3Dptrace -DKBUILD_MODNAME=3Dptrace -c -o arch/i386/kernel/.tmp_ptrace.=
o arch/i386/kernel/ptrace.c
  gcc296 -Wp,-MD,arch/i386/kernel/.i8259.o.d -D__KERNEL__ -Iinclude -Wall -=
Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -pip=
e -mpreferred-stack-boundary=3D2 -march=3Dathlon -Iinclude/asm-i386/mach-de=
fault -fomit-frame-pointer -nostdinc -iwithprefix include    -DKBUILD_BASEN=
AME=3Di8259 -DKBUILD_MODNAME=3Di8259 -c -o arch/i386/kernel/.tmp_i8259.o ar=
ch/i386/kernel/i8259.c
  gcc296 -Wp,-MD,arch/i386/kernel/.ioport.o.d -D__KERNEL__ -Iinclude -Wall =
-Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -pi=
pe -mpreferred-stack-boundary=3D2 -march=3Dathlon -Iinclude/asm-i386/mach-d=
efault -fomit-frame-pointer -nostdinc -iwithprefix include    -DKBUILD_BASE=
NAME=3Dioport -DKBUILD_MODNAME=3Dioport -c -o arch/i386/kernel/.tmp_ioport.=
o arch/i386/kernel/ioport.c
  gcc296 -Wp,-MD,arch/i386/kernel/.ldt.o.d -D__KERNEL__ -Iinclude -Wall -Ws=
trict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -pipe =
-mpreferred-stack-boundary=3D2 -march=3Dathlon -Iinclude/asm-i386/mach-defa=
ult -fomit-frame-pointer -nostdinc -iwithprefix include    -DKBUILD_BASENAM=
E=3Dldt -DKBUILD_MODNAME=3Dldt -c -o arch/i386/kernel/.tmp_ldt.o arch/i386/=
kernel/ldt.c
  gcc296 -Wp,-MD,arch/i386/kernel/.setup.o.d -D__KERNEL__ -Iinclude -Wall -=
Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -pip=
e -mpreferred-stack-boundary=3D2 -march=3Dathlon -Iinclude/asm-i386/mach-de=
fault -fomit-frame-pointer -nostdinc -iwithprefix include    -DKBUILD_BASEN=
AME=3Dsetup -DKBUILD_MODNAME=3Dsetup -c -o arch/i386/kernel/.tmp_setup.o ar=
ch/i386/kernel/setup.c
  gcc296 -Wp,-MD,arch/i386/kernel/.time.o.d -D__KERNEL__ -Iinclude -Wall -W=
strict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -pipe=
 -mpreferred-stack-boundary=3D2 -march=3Dathlon -Iinclude/asm-i386/mach-def=
ault -fomit-frame-pointer -nostdinc -iwithprefix include    -DKBUILD_BASENA=
ME=3Dtime -DKBUILD_MODNAME=3Dtime -c -o arch/i386/kernel/.tmp_time.o arch/i=
386/kernel/time.c
  gcc296 -Wp,-MD,arch/i386/kernel/.sys_i386.o.d -D__KERNEL__ -Iinclude -Wal=
l -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -=
pipe -mpreferred-stack-boundary=3D2 -march=3Dathlon -Iinclude/asm-i386/mach=
-default -fomit-frame-pointer -nostdinc -iwithprefix include    -DKBUILD_BA=
SENAME=3Dsys_i386 -DKBUILD_MODNAME=3Dsys_i386 -c -o arch/i386/kernel/.tmp_s=
ys_i386.o arch/i386/kernel/sys_i386.c
  gcc296 -Wp,-MD,arch/i386/kernel/.pci-dma.o.d -D__KERNEL__ -Iinclude -Wall=
 -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -p=
ipe -mpreferred-stack-boundary=3D2 -march=3Dathlon -Iinclude/asm-i386/mach-=
default -fomit-frame-pointer -nostdinc -iwithprefix include    -DKBUILD_BAS=
ENAME=3Dpci_dma -DKBUILD_MODNAME=3Dpci_dma -c -o arch/i386/kernel/.tmp_pci-=
dma.o arch/i386/kernel/pci-dma.c
  gcc296 -Wp,-MD,arch/i386/kernel/.i386_ksyms.o.d -D__KERNEL__ -Iinclude -W=
all -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common=
 -pipe -mpreferred-stack-boundary=3D2 -march=3Dathlon -Iinclude/asm-i386/ma=
ch-default -fomit-frame-pointer -nostdinc -iwithprefix include    -DKBUILD_=
BASENAME=3Di386_ksyms -DKBUILD_MODNAME=3Di386_ksyms -c -o arch/i386/kernel/=
.tmp_i386_ksyms.o arch/i386/kernel/i386_ksyms.c
  gcc296 -Wp,-MD,arch/i386/kernel/.i387.o.d -D__KERNEL__ -Iinclude -Wall -W=
strict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -pipe=
 -mpreferred-stack-boundary=3D2 -march=3Dathlon -Iinclude/asm-i386/mach-def=
ault -fomit-frame-pointer -nostdinc -iwithprefix include    -DKBUILD_BASENA=
ME=3Di387 -DKBUILD_MODNAME=3Di387 -c -o arch/i386/kernel/.tmp_i387.o arch/i=
386/kernel/i387.c
  gcc296 -Wp,-MD,arch/i386/kernel/.dmi_scan.o.d -D__KERNEL__ -Iinclude -Wal=
l -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -=
pipe -mpreferred-stack-boundary=3D2 -march=3Dathlon -Iinclude/asm-i386/mach=
-default -fomit-frame-pointer -nostdinc -iwithprefix include    -DKBUILD_BA=
SENAME=3Ddmi_scan -DKBUILD_MODNAME=3Ddmi_scan -c -o arch/i386/kernel/.tmp_d=
mi_scan.o arch/i386/kernel/dmi_scan.c
  gcc296 -Wp,-MD,arch/i386/kernel/.bootflag.o.d -D__KERNEL__ -Iinclude -Wal=
l -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -=
pipe -mpreferred-stack-boundary=3D2 -march=3Dathlon -Iinclude/asm-i386/mach=
-default -fomit-frame-pointer -nostdinc -iwithprefix include    -DKBUILD_BA=
SENAME=3Dbootflag -DKBUILD_MODNAME=3Dbootflag -c -o arch/i386/kernel/.tmp_b=
ootflag.o arch/i386/kernel/bootflag.c
make -f scripts/Makefile.build obj=3Darch/i386/kernel/acpi
  gcc296 -Wp,-MD,arch/i386/kernel/acpi/.boot.o.d -D__KERNEL__ -Iinclude -Wa=
ll -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common =
-pipe -mpreferred-stack-boundary=3D2 -march=3Dathlon -Iinclude/asm-i386/mac=
h-default -fomit-frame-pointer -nostdinc -iwithprefix include    -DKBUILD_B=
ASENAME=3Dboot -DKBUILD_MODNAME=3Dboot -c -o arch/i386/kernel/acpi/.tmp_boo=
t.o arch/i386/kernel/acpi/boot.c
In file included from arch/i386/kernel/acpi/boot.c:30:
include/asm-i386/mach-default/mach_apic.h: In function `apic_id_registered'=
:
include/asm-i386/mach-default/mach_apic.h:24: warning: implicit declaration=
 of function `apic_read'
include/asm-i386/mach-default/mach_apic.h:24: `phys_cpu_present_map' undecl=
ared (first use in this function)
include/asm-i386/mach-default/mach_apic.h:24: (Each undeclared identifier i=
s reported only once
include/asm-i386/mach-default/mach_apic.h:24: for each function it appears =
in.)
include/asm-i386/mach-default/mach_apic.h: In function `init_apic_ldr':
include/asm-i386/mach-default/mach_apic.h:39: warning: implicit declaration=
 of function `apic_write_around'
include/asm-i386/mach-default/mach_apic.h: In function `clustered_apic_chec=
k':
include/asm-i386/mach-default/mach_apic.h:53: `nr_ioapics' undeclared (firs=
t use in this function)
include/asm-i386/mach-default/mach_apic.h: At top level:
include/asm-i386/mach-default/mach_apic.h:82: warning: `struct mpc_config_p=
rocessor' declared inside parameter list
include/asm-i386/mach-default/mach_apic.h:82: warning: its scope is only th=
is definition or declaration, which is probably not what you want.
include/asm-i386/mach-default/mach_apic.h: In function `mpc_apic_id':
include/asm-i386/mach-default/mach_apic.h:85: dereferencing pointer to inco=
mplete type
include/asm-i386/mach-default/mach_apic.h:86: dereferencing pointer to inco=
mplete type
include/asm-i386/mach-default/mach_apic.h:86: `CPU_FAMILY_MASK' undeclared =
(first use in this function)
include/asm-i386/mach-default/mach_apic.h:87: dereferencing pointer to inco=
mplete type
include/asm-i386/mach-default/mach_apic.h:87: `CPU_MODEL_MASK' undeclared (=
first use in this function)
include/asm-i386/mach-default/mach_apic.h:88: dereferencing pointer to inco=
mplete type
include/asm-i386/mach-default/mach_apic.h:89: dereferencing pointer to inco=
mplete type
include/asm-i386/mach-default/mach_apic.h:90: warning: control reaches end =
of non-void function
include/asm-i386/mach-default/mach_apic.h: In function `check_phys_apicid_p=
resent':
include/asm-i386/mach-default/mach_apic.h:98: `phys_cpu_present_map' undecl=
ared (first use in this function)
In file included from arch/i386/kernel/acpi/boot.c:31:
include/asm-i386/mach-default/mach_mpparse.h: At top level:
include/asm-i386/mach-default/mach_mpparse.h:5: warning: `struct mpc_config=
_translation' declared inside parameter list
include/asm-i386/mach-default/mach_mpparse.h:5: warning: `struct mpc_config=
_bus' declared inside parameter list
include/asm-i386/mach-default/mach_mpparse.h: In function `mpc_oem_bus_info=
':
include/asm-i386/mach-default/mach_mpparse.h:7: warning: implicit declarati=
on of function `Dprintk'
include/asm-i386/mach-default/mach_mpparse.h:7: dereferencing pointer to in=
complete type
include/asm-i386/mach-default/mach_mpparse.h: At top level:
include/asm-i386/mach-default/mach_mpparse.h:11: warning: `struct mpc_confi=
g_translation' declared inside parameter list
include/asm-i386/mach-default/mach_mpparse.h:11: warning: `struct mpc_confi=
g_bus' declared inside parameter list
include/asm-i386/mach-default/mach_mpparse.h:16: warning: `struct mp_config=
_table' declared inside parameter list
arch/i386/kernel/acpi/boot.c: In function `acpi_parse_lapic':
arch/i386/kernel/acpi/boot.c:131: warning: implicit declaration of function=
 `mp_register_lapic'
arch/i386/kernel/acpi/boot.c: In function `acpi_parse_ioapic':
arch/i386/kernel/acpi/boot.c:196: warning: implicit declaration of function=
 `mp_register_ioapic'
arch/i386/kernel/acpi/boot.c: In function `acpi_parse_int_src_ovr':
arch/i386/kernel/acpi/boot.c:217: warning: implicit declaration of function=
 `mp_override_legacy_irq'
arch/i386/kernel/acpi/boot.c: In function `acpi_boot_init':
arch/i386/kernel/acpi/boot.c:348: warning: implicit declaration of function=
 `mp_register_lapic_address'
arch/i386/kernel/acpi/boot.c:394: warning: implicit declaration of function=
 `mp_config_acpi_legacy_irqs'
arch/i386/kernel/acpi/boot.c:419: `smp_found_config' undeclared (first use =
in this function)
make[2]: *** [arch/i386/kernel/acpi/boot.o] Error 1
make[1]: *** [arch/i386/kernel/acpi] Error 2
make: *** [arch/i386/kernel] Error 2

--=-mHMhmgk/80DTI6Ti5dZm--
