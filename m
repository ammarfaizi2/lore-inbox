Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261871AbTJIEGi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Oct 2003 00:06:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261881AbTJIEGi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Oct 2003 00:06:38 -0400
Received: from ool-4352eb9e.dyn.optonline.net ([67.82.235.158]:27520 "EHLO
	nikolas.hn.org") by vger.kernel.org with ESMTP id S261871AbTJIEFW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Oct 2003 00:05:22 -0400
Date: Thu, 9 Oct 2003 00:05:08 -0400
From: Nick Orlov <bugfixer@list.ru>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: 2-6.0-test6-mm4: badness in get_io_context
Message-ID: <20031009040508.GA917@nikolas.hn.org>
Mail-Followup-To: akpm@osdl.org, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="3MwIy2ne0vdjdPXF"
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--3MwIy2ne0vdjdPXF
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline

Andrew,

Please find attached snippet from kernel log file. Basically, assert
was raised when machine was shutting down as a part of the reboot.

If it matters: I have nVidia kernel module loaded. 

Most likely I wouldn't be able to reproduce it because it happened only 
once out of about 10 reboots.

Kernel version is 2.6.0-test6-mm4 and all packages are updated on daily
basis from Debian/unstable. Kernel config file is also attached
to this letter.

Please feel free to contact me with any questions you might have.

-- 
Best wishes,
	Nick Orlov.


--3MwIy2ne0vdjdPXF
Content-Type: text/plain; charset=koi8-r
Content-Disposition: attachment; filename="kern.log"

Oct  7 23:16:32 nikolas kernel: Badness in get_io_context at drivers/block/ll_rw_blk.c:2677
Oct  7 23:16:32 nikolas kernel: Call Trace:
Oct  7 23:16:32 nikolas kernel:  [get_io_context+200/208] get_io_context+0xc8/0xd0
Oct  7 23:16:32 nikolas kernel:  [get_request+39/576] get_request+0x27/0x240
Oct  7 23:16:32 nikolas kernel:  [__make_request+233/1360] __make_request+0xe9/0x550
Oct  7 23:16:32 nikolas kernel:  [generic_make_request+262/384] generic_make_request+0x106/0x180
Oct  7 23:16:32 nikolas kernel:  [buffered_rmqueue+180/320] buffered_rmqueue+0xb4/0x140
Oct  7 23:16:32 nikolas kernel:  [submit_bio+61/112] submit_bio+0x3d/0x70
Oct  7 23:16:32 nikolas kernel:  [mpage_bio_submit+35/64] mpage_bio_submit+0x23/0x40
Oct  7 23:16:32 nikolas kernel:  [mpage_readpage+75/96] mpage_readpage+0x4b/0x60
Oct  7 23:16:32 nikolas kernel:  [ext2_get_block+0/64] ext2_get_block+0x0/0x40
Oct  7 23:16:32 nikolas kernel:  [do_generic_mapping_read+629/1184] do_generic_mapping_read+0x275/0x4a0
Oct  7 23:16:32 nikolas kernel:  [ext2_get_block+0/64] ext2_get_block+0x0/0x40
Oct  7 23:16:32 nikolas kernel:  [file_read_actor+0/240] file_read_actor+0x0/0xf0
Oct  7 23:16:32 nikolas kernel:  [__generic_file_aio_read+430/480] __generic_file_aio_read+0x1ae/0x1e0
Oct  7 23:16:32 nikolas kernel:  [file_read_actor+0/240] file_read_actor+0x0/0xf0
Oct  7 23:16:32 nikolas kernel:  [generic_file_read+178/208] generic_file_read+0xb2/0xd0
Oct  7 23:16:32 nikolas kernel:  [autoremove_wake_function+0/80] autoremove_wake_function+0x0/0x50
Oct  7 23:16:32 nikolas kernel:  [mm_init+151/224] mm_init+0x97/0xe0
Oct  7 23:16:32 nikolas kernel:  [vfs_read+184/304] vfs_read+0xb8/0x130
Oct  7 23:16:32 nikolas kernel:  [kernel_read+80/96] kernel_read+0x50/0x60
Oct  7 23:16:32 nikolas kernel:  [prepare_binprm+187/208] prepare_binprm+0xbb/0xd0
Oct  7 23:16:32 nikolas kernel:  [do_execve+357/592] do_execve+0x165/0x250
Oct  7 23:16:32 nikolas kernel:  [buffered_rmqueue+180/320] buffered_rmqueue+0xb4/0x140
Oct  7 23:16:32 nikolas kernel:  [sys_execve+66/128] sys_execve+0x42/0x80
Oct  7 23:16:32 nikolas kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Oct  7 23:16:32 nikolas kernel: 
Oct  7 23:16:32 nikolas kernel: Badness in get_io_context at drivers/block/ll_rw_blk.c:2677
Oct  7 23:16:32 nikolas kernel: Call Trace:
Oct  7 23:16:32 nikolas kernel:  [get_io_context+200/208] get_io_context+0xc8/0xd0
Oct  7 23:16:32 nikolas kernel:  [get_request+39/576] get_request+0x27/0x240
Oct  7 23:16:32 nikolas kernel:  [__make_request+233/1360] __make_request+0xe9/0x550
Oct  7 23:16:32 nikolas kernel:  [mempool_alloc+111/288] mempool_alloc+0x6f/0x120
Oct  7 23:16:32 nikolas kernel:  [autoremove_wake_function+0/80] autoremove_wake_function+0x0/0x50
Oct  7 23:16:32 nikolas kernel:  [generic_make_request+262/384] generic_make_request+0x106/0x180
Oct  7 23:16:32 nikolas kernel:  [autoremove_wake_function+0/80] autoremove_wake_function+0x0/0x50
Oct  7 23:16:32 nikolas kernel:  [submit_bio+61/112] submit_bio+0x3d/0x70
Oct  7 23:16:32 nikolas kernel:  [mpage_bio_submit+35/64] mpage_bio_submit+0x23/0x40
Oct  7 23:16:32 nikolas kernel:  [do_mpage_readpage+467/880] do_mpage_readpage+0x1d3/0x370
Oct  7 23:16:32 nikolas kernel:  [buffered_rmqueue+180/320] buffered_rmqueue+0xb4/0x140
Oct  7 23:16:32 nikolas kernel:  [add_to_page_cache+102/208] add_to_page_cache+0x66/0xd0
Oct  7 23:16:32 nikolas kernel:  [mpage_readpage+55/96] mpage_readpage+0x37/0x60
Oct  7 23:16:32 nikolas kernel:  [ext2_get_block+0/64] ext2_get_block+0x0/0x40
Oct  7 23:16:32 nikolas kernel:  [do_generic_mapping_read+629/1184] do_generic_mapping_read+0x275/0x4a0
Oct  7 23:16:32 nikolas kernel:  [ext2_get_block+0/64] ext2_get_block+0x0/0x40
Oct  7 23:16:32 nikolas kernel:  [file_read_actor+0/240] file_read_actor+0x0/0xf0
Oct  7 23:16:32 nikolas kernel:  [__generic_file_aio_read+430/480] __generic_file_aio_read+0x1ae/0x1e0
Oct  7 23:16:32 nikolas kernel:  [file_read_actor+0/240] file_read_actor+0x0/0xf0
Oct  7 23:16:32 nikolas kernel:  [generic_file_read+178/208] generic_file_read+0xb2/0xd0
Oct  7 23:16:32 nikolas kernel:  [do_lookup+48/176] do_lookup+0x30/0xb0
Oct  7 23:16:32 nikolas kernel:  [autoremove_wake_function+0/80] autoremove_wake_function+0x0/0x50
Oct  7 23:16:32 nikolas kernel:  [mm_init+151/224] mm_init+0x97/0xe0
Oct  7 23:16:32 nikolas kernel:  [vfs_read+184/304] vfs_read+0xb8/0x130
Oct  7 23:16:32 nikolas kernel:  [kernel_read+80/96] kernel_read+0x50/0x60
Oct  7 23:16:32 nikolas kernel:  [prepare_binprm+187/208] prepare_binprm+0xbb/0xd0
Oct  7 23:16:32 nikolas kernel:  [do_execve+357/592] do_execve+0x165/0x250
Oct  7 23:16:32 nikolas kernel:  [buffered_rmqueue+180/320] buffered_rmqueue+0xb4/0x140
Oct  7 23:16:32 nikolas kernel:  [sys_execve+66/128] sys_execve+0x42/0x80
Oct  7 23:16:32 nikolas kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Oct  7 23:16:32 nikolas kernel: 
Oct  7 23:16:32 nikolas kernel: Badness in alloc_as_io_context at drivers/block/as-iosched.c:202
Oct  7 23:16:32 nikolas kernel: Call Trace:
Oct  7 23:16:32 nikolas kernel:  [alloc_as_io_context+196/208] alloc_as_io_context+0xc4/0xd0
Oct  7 23:16:32 nikolas kernel:  [as_get_io_context+47/80] as_get_io_context+0x2f/0x50
Oct  7 23:16:32 nikolas kernel:  [as_add_request+62/512] as_add_request+0x3e/0x200
Oct  7 23:16:32 nikolas kernel:  [get_request+414/576] get_request+0x19e/0x240
Oct  7 23:16:32 nikolas kernel:  [__elv_add_request+41/64] __elv_add_request+0x29/0x40
Oct  7 23:16:32 nikolas kernel:  [__make_request+684/1360] __make_request+0x2ac/0x550
Oct  7 23:16:32 nikolas kernel:  [generic_make_request+262/384] generic_make_request+0x106/0x180
Oct  7 23:16:32 nikolas kernel:  [autoremove_wake_function+0/80] autoremove_wake_function+0x0/0x50
Oct  7 23:16:32 nikolas kernel:  [submit_bio+61/112] submit_bio+0x3d/0x70
Oct  7 23:16:32 nikolas kernel:  [mpage_bio_submit+35/64] mpage_bio_submit+0x23/0x40
Oct  7 23:16:32 nikolas kernel:  [do_mpage_readpage+467/880] do_mpage_readpage+0x1d3/0x370
Oct  7 23:16:32 nikolas kernel:  [buffered_rmqueue+180/320] buffered_rmqueue+0xb4/0x140
Oct  7 23:16:32 nikolas kernel:  [add_to_page_cache+102/208] add_to_page_cache+0x66/0xd0
Oct  7 23:16:32 nikolas kernel:  [mpage_readpage+55/96] mpage_readpage+0x37/0x60
Oct  7 23:16:32 nikolas kernel:  [ext2_get_block+0/64] ext2_get_block+0x0/0x40
Oct  7 23:16:32 nikolas kernel:  [do_generic_mapping_read+629/1184] do_generic_mapping_read+0x275/0x4a0
Oct  7 23:16:32 nikolas kernel:  [ext2_get_block+0/64] ext2_get_block+0x0/0x40
Oct  7 23:16:32 nikolas kernel:  [file_read_actor+0/240] file_read_actor+0x0/0xf0
Oct  7 23:16:32 nikolas kernel:  [__generic_file_aio_read+430/480] __generic_file_aio_read+0x1ae/0x1e0
Oct  7 23:16:32 nikolas kernel:  [file_read_actor+0/240] file_read_actor+0x0/0xf0
Oct  7 23:16:32 nikolas kernel:  [generic_file_read+178/208] generic_file_read+0xb2/0xd0
Oct  7 23:16:32 nikolas kernel:  [do_lookup+48/176] do_lookup+0x30/0xb0
Oct  7 23:16:32 nikolas kernel:  [autoremove_wake_function+0/80] autoremove_wake_function+0x0/0x50
Oct  7 23:16:32 nikolas kernel:  [mm_init+151/224] mm_init+0x97/0xe0
Oct  7 23:16:32 nikolas kernel:  [vfs_read+184/304] vfs_read+0xb8/0x130
Oct  7 23:16:32 nikolas kernel:  [kernel_read+80/96] kernel_read+0x50/0x60
Oct  7 23:16:32 nikolas kernel:  [prepare_binprm+187/208] prepare_binprm+0xbb/0xd0
Oct  7 23:16:32 nikolas kernel:  [do_execve+357/592] do_execve+0x165/0x250
Oct  7 23:16:32 nikolas kernel:  [buffered_rmqueue+180/320] buffered_rmqueue+0xb4/0x140
Oct  7 23:16:32 nikolas kernel:  [sys_execve+66/128] sys_execve+0x42/0x80
Oct  7 23:16:32 nikolas kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Oct  7 23:16:32 nikolas kernel: 
Oct  7 23:16:32 nikolas kernel: Kernel logging (proc) stopped.
Oct  7 23:16:32 nikolas kernel: Kernel log daemon terminating.

--3MwIy2ne0vdjdPXF
Content-Type: text/plain; charset=koi8-r
Content-Disposition: attachment; filename="config-2.6.0-test6-mm4-1"

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
# CONFIG_IKCONFIG is not set
# CONFIG_EMBEDDED is not set
CONFIG_KALLSYMS=y
CONFIG_FUTEX=y
CONFIG_EPOLL=y
CONFIG_IOSCHED_NOOP=y
CONFIG_IOSCHED_AS=y
CONFIG_IOSCHED_DEADLINE=y
CONFIG_IOSCHED_CFQ=y

#
# Loadable module support
#
CONFIG_MODULES=y
CONFIG_MODULE_UNLOAD=y
# CONFIG_MODULE_FORCE_UNLOAD is not set
CONFIG_OBSOLETE_MODPARM=y
# CONFIG_MODVERSIONS is not set
# CONFIG_KMOD is not set

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
# CONFIG_MPENTIUMIII is not set
# CONFIG_MPENTIUM4 is not set
# CONFIG_MK6 is not set
CONFIG_MK7=y
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
CONFIG_X86_L1_CACHE_SHIFT=6
CONFIG_RWSEM_XCHGADD_ALGORITHM=y
CONFIG_X86_WP_WORKS_OK=y
CONFIG_X86_INVLPG=y
CONFIG_X86_BSWAP=y
CONFIG_X86_POPAD_OK=y
CONFIG_X86_GOOD_APIC=y
CONFIG_X86_INTEL_USERCOPY=y
CONFIG_X86_USE_PPRO_CHECKSUM=y
CONFIG_X86_USE_3DNOW=y
# CONFIG_X86_4G is not set
# CONFIG_X86_SWITCH_PAGETABLES is not set
# CONFIG_X86_4G_VM_LAYOUT is not set
# CONFIG_X86_UACCESS_INDIRECT is not set
# CONFIG_X86_HIGH_ENTRY is not set
# CONFIG_HPET_TIMER is not set
# CONFIG_HPET_EMULATE_RTC is not set
# CONFIG_SMP is not set
# CONFIG_PREEMPT is not set
# CONFIG_X86_UP_APIC is not set
CONFIG_X86_TSC=y
CONFIG_X86_MCE=y
CONFIG_X86_MCE_NONFATAL=y
# CONFIG_TOSHIBA is not set
# CONFIG_I8K is not set
# CONFIG_MICROCODE is not set
CONFIG_X86_MSR=y
CONFIG_X86_CPUID=y
# CONFIG_EDD is not set
CONFIG_NOHIGHMEM=y
# CONFIG_HIGHMEM4G is not set
# CONFIG_HIGHMEM64G is not set
# CONFIG_MATH_EMULATION is not set
CONFIG_MTRR=y
CONFIG_BOOT_IOREMAP=y

#
# Power management options (ACPI, APM)
#
CONFIG_PM=y
# CONFIG_SOFTWARE_SUSPEND is not set
# CONFIG_PM_DISK is not set

#
# ACPI (Advanced Configuration and Power Interface) Support
#
# CONFIG_ACPI is not set

#
# APM (Advanced Power Management) BIOS Support
#
CONFIG_APM=y
# CONFIG_APM_IGNORE_USER_SUSPEND is not set
CONFIG_APM_DO_ENABLE=y
CONFIG_APM_CPU_IDLE=y
CONFIG_APM_DISPLAY_BLANK=y
CONFIG_APM_RTC_IS_GMT=y
# CONFIG_APM_ALLOW_INTS is not set
# CONFIG_APM_REAL_MODE_POWER_OFF is not set

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
# CONFIG_PCI_LEGACY_PROC is not set
CONFIG_PCI_NAMES=y
# CONFIG_ISA is not set
# CONFIG_MCA is not set
# CONFIG_SCx200 is not set
# CONFIG_HOTPLUG is not set

#
# Executable file formats
#
CONFIG_BINFMT_ELF=y
CONFIG_BINFMT_AOUT=y
CONFIG_BINFMT_MISC=y

#
# Generic Driver Options
#

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
# CONFIG_PNP is not set

#
# Block devices
#
# CONFIG_BLK_CPQ_DA is not set
# CONFIG_BLK_CPQ_CISS_DA is not set
# CONFIG_BLK_DEV_DAC960 is not set
# CONFIG_BLK_DEV_UMEM is not set
CONFIG_BLK_DEV_LOOP=y
# CONFIG_BLK_DEV_CRYPTOLOOP is not set
# CONFIG_BLK_DEV_NBD is not set
# CONFIG_BLK_DEV_RAM is not set
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
CONFIG_BLK_DEV_IDECD=y
# CONFIG_BLK_DEV_IDETAPE is not set
# CONFIG_BLK_DEV_IDEFLOPPY is not set
# CONFIG_IDE_TASK_IOCTL is not set
CONFIG_IDE_TASKFILE_IO=y

#
# IDE chipset support/bugfixes
#
# CONFIG_BLK_DEV_CMD640 is not set
CONFIG_BLK_DEV_IDEPCI=y
CONFIG_IDEPCI_SHARE_IRQ=y
# CONFIG_BLK_DEV_OFFBOARD is not set
CONFIG_BLK_DEV_GENERIC=y
# CONFIG_BLK_DEV_OPTI621 is not set
# CONFIG_BLK_DEV_RZ1000 is not set
CONFIG_BLK_DEV_IDEDMA_PCI=y
# CONFIG_BLK_DEV_IDE_TCQ is not set
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
# CONFIG_BLK_DEV_PIIX is not set
# CONFIG_BLK_DEV_NS87415 is not set
CONFIG_BLK_DEV_PDC202XX_OLD=y
# CONFIG_PDC202XX_BURST is not set
# CONFIG_BLK_DEV_PDC202XX_NEW is not set
# CONFIG_BLK_DEV_SVWKS is not set
# CONFIG_BLK_DEV_SGIIOC4 is not set
# CONFIG_BLK_DEV_SIIMAGE is not set
# CONFIG_BLK_DEV_SIS5513 is not set
# CONFIG_BLK_DEV_SLC90E66 is not set
# CONFIG_BLK_DEV_TRM290 is not set
CONFIG_BLK_DEV_VIA82CXXX=y
CONFIG_BLK_DEV_IDEDMA=y
# CONFIG_IDEDMA_IVB is not set
CONFIG_IDEDMA_AUTO=y
# CONFIG_DMA_NONPCI is not set
# CONFIG_BLK_DEV_HD is not set

#
# SCSI device support
#
# CONFIG_SCSI is not set

#
# Multi-device support (RAID and LVM)
#
# CONFIG_MD is not set

#
# Fusion MPT device support
#

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
# CONFIG_NET_IPIP is not set
# CONFIG_NET_IPGRE is not set
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
CONFIG_IP_NF_TFTP=m
CONFIG_IP_NF_AMANDA=m
CONFIG_IP_NF_QUEUE=m
CONFIG_IP_NF_IPTABLES=m
CONFIG_IP_NF_MATCH_LIMIT=m
CONFIG_IP_NF_MATCH_IPRANGE=m
CONFIG_IP_NF_MATCH_MAC=m
CONFIG_IP_NF_MATCH_PKTTYPE=m
CONFIG_IP_NF_MATCH_MARK=m
CONFIG_IP_NF_MATCH_MULTIPORT=m
CONFIG_IP_NF_MATCH_TOS=m
CONFIG_IP_NF_MATCH_RECENT=m
CONFIG_IP_NF_MATCH_ECN=m
CONFIG_IP_NF_MATCH_DSCP=m
CONFIG_IP_NF_MATCH_AH_ESP=m
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
CONFIG_IP_NF_TARGET_SAME=m
CONFIG_IP_NF_NAT_LOCAL=y
# CONFIG_IP_NF_NAT_SNMP_BASIC is not set
CONFIG_IP_NF_NAT_IRC=m
CONFIG_IP_NF_NAT_FTP=m
CONFIG_IP_NF_NAT_TFTP=m
CONFIG_IP_NF_NAT_AMANDA=m
CONFIG_IP_NF_MANGLE=m
CONFIG_IP_NF_TARGET_TOS=m
CONFIG_IP_NF_TARGET_ECN=m
CONFIG_IP_NF_TARGET_DSCP=m
CONFIG_IP_NF_TARGET_MARK=m
CONFIG_IP_NF_TARGET_CLASSIFY=m
CONFIG_IP_NF_TARGET_LOG=m
CONFIG_IP_NF_TARGET_ULOG=m
CONFIG_IP_NF_TARGET_TCPMSS=m
CONFIG_IP_NF_ARPTABLES=m
CONFIG_IP_NF_ARPFILTER=m
CONFIG_IP_NF_ARP_MANGLE=m
# CONFIG_IP_NF_COMPAT_IPCHAINS is not set
# CONFIG_IP_NF_COMPAT_IPFWADM is not set

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
CONFIG_DUMMY=m
# CONFIG_BONDING is not set
# CONFIG_EQUALIZER is not set
# CONFIG_TUN is not set

#
# Ethernet (10 or 100Mbit)
#
CONFIG_NET_ETHERNET=y
# CONFIG_MII is not set
# CONFIG_HAPPYMEAL is not set
# CONFIG_SUNGEM is not set
CONFIG_NET_VENDOR_3COM=y
CONFIG_VORTEX=m
# CONFIG_TYPHOON is not set

#
# Tulip family network device support
#
# CONFIG_NET_TULIP is not set
# CONFIG_HP100 is not set
# CONFIG_NET_PCI is not set

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
# CONFIG_NET_RADIO is not set

#
# Token Ring devices
#
# CONFIG_TR is not set
# CONFIG_RCPCI is not set
# CONFIG_SHAPER is not set
# CONFIG_NET_POLL_CONTROLLER is not set

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
CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
# CONFIG_INPUT_JOYDEV is not set
# CONFIG_INPUT_TSDEV is not set
# CONFIG_INPUT_EVDEV is not set
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
CONFIG_MOUSE_PS2=y
# CONFIG_MOUSE_PS2_SYNAPTICS is not set
# CONFIG_MOUSE_SERIAL is not set
# CONFIG_INPUT_JOYSTICK is not set
# CONFIG_INPUT_TOUCHSCREEN is not set
CONFIG_INPUT_MISC=y
CONFIG_INPUT_PCSPKR=y
# CONFIG_INPUT_UINPUT is not set

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
# CONFIG_SERIAL_8250_EXTENDED is not set

#
# Non-8250 serial port support
#
CONFIG_SERIAL_CORE=m
CONFIG_UNIX98_PTYS=y
CONFIG_UNIX98_PTY_COUNT=256

#
# I2C support
#
# CONFIG_I2C is not set

#
# I2C Algorithms
#

#
# I2C Hardware Bus support
#

#
# I2C Hardware Sensors Chip support
#
# CONFIG_I2C_SENSOR is not set

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
# CONFIG_AGP is not set
# CONFIG_DRM is not set
# CONFIG_MWAVE is not set
# CONFIG_RAW_DRIVER is not set
# CONFIG_HANGCHECK_TIMER is not set

#
# Multimedia devices
#
# CONFIG_VIDEO_DEV is not set

#
# Digital Video Broadcasting Devices
#
# CONFIG_DVB is not set

#
# File systems
#
CONFIG_EXT2_FS=y
# CONFIG_EXT2_FS_XATTR is not set
# CONFIG_EXT3_FS is not set
# CONFIG_JBD is not set
CONFIG_REISERFS_FS=y
# CONFIG_REISERFS_CHECK is not set
# CONFIG_REISERFS_PROC_INFO is not set
# CONFIG_JFS_FS is not set
# CONFIG_XFS_FS is not set
# CONFIG_MINIX_FS is not set
# CONFIG_ROMFS_FS is not set
CONFIG_QUOTA=y
# CONFIG_QFMT_V1 is not set
# CONFIG_QFMT_V2 is not set
CONFIG_QUOTACTL=y
CONFIG_AUTOFS_FS=y
CONFIG_AUTOFS4_FS=y

#
# CD-ROM/DVD Filesystems
#
CONFIG_ISO9660_FS=y
CONFIG_JOLIET=y
# CONFIG_ZISOFS is not set
CONFIG_UDF_FS=m

#
# DOS/FAT/NT Filesystems
#
CONFIG_FAT_FS=m
CONFIG_MSDOS_FS=m
CONFIG_VFAT_FS=m
# CONFIG_NTFS_FS is not set

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
# CONFIG_HFS_FS is not set
# CONFIG_BEFS_FS is not set
# CONFIG_BFS_FS is not set
# CONFIG_EFS_FS is not set
# CONFIG_CRAMFS is not set
# CONFIG_VXFS_FS is not set
# CONFIG_HPFS_FS is not set
# CONFIG_QNX4FS_FS is not set
# CONFIG_SYSV_FS is not set
# CONFIG_UFS_FS is not set

#
# Network File Systems
#
# CONFIG_NFS_FS is not set
# CONFIG_NFSD is not set
# CONFIG_EXPORTFS is not set
# CONFIG_SMB_FS is not set
# CONFIG_CIFS is not set
# CONFIG_NCP_FS is not set
# CONFIG_CODA_FS is not set
# CONFIG_INTERMEZZO_FS is not set
# CONFIG_AFS_FS is not set

#
# Partition Types
#
# CONFIG_PARTITION_ADVANCED is not set
CONFIG_MSDOS_PARTITION=y
CONFIG_NLS=y

#
# Native Language Support
#
CONFIG_NLS_DEFAULT="cp437"
CONFIG_NLS_CODEPAGE_437=m
# CONFIG_NLS_CODEPAGE_737 is not set
# CONFIG_NLS_CODEPAGE_775 is not set
# CONFIG_NLS_CODEPAGE_850 is not set
# CONFIG_NLS_CODEPAGE_852 is not set
CONFIG_NLS_CODEPAGE_855=m
# CONFIG_NLS_CODEPAGE_857 is not set
# CONFIG_NLS_CODEPAGE_860 is not set
# CONFIG_NLS_CODEPAGE_861 is not set
# CONFIG_NLS_CODEPAGE_862 is not set
# CONFIG_NLS_CODEPAGE_863 is not set
# CONFIG_NLS_CODEPAGE_864 is not set
# CONFIG_NLS_CODEPAGE_865 is not set
CONFIG_NLS_CODEPAGE_866=m
# CONFIG_NLS_CODEPAGE_869 is not set
# CONFIG_NLS_CODEPAGE_936 is not set
# CONFIG_NLS_CODEPAGE_950 is not set
# CONFIG_NLS_CODEPAGE_932 is not set
# CONFIG_NLS_CODEPAGE_949 is not set
# CONFIG_NLS_CODEPAGE_874 is not set
# CONFIG_NLS_ISO8859_8 is not set
# CONFIG_NLS_CODEPAGE_1250 is not set
# CONFIG_NLS_CODEPAGE_1251 is not set
CONFIG_NLS_ISO8859_1=m
# CONFIG_NLS_ISO8859_2 is not set
# CONFIG_NLS_ISO8859_3 is not set
# CONFIG_NLS_ISO8859_4 is not set
CONFIG_NLS_ISO8859_5=m
# CONFIG_NLS_ISO8859_6 is not set
# CONFIG_NLS_ISO8859_7 is not set
# CONFIG_NLS_ISO8859_9 is not set
# CONFIG_NLS_ISO8859_13 is not set
# CONFIG_NLS_ISO8859_14 is not set
# CONFIG_NLS_ISO8859_15 is not set
CONFIG_NLS_KOI8_R=m
# CONFIG_NLS_KOI8_U is not set
CONFIG_NLS_UTF8=m

#
# Graphics support
#
# CONFIG_FB is not set
# CONFIG_VIDEO_SELECT is not set

#
# Console display driver support
#
CONFIG_VGA_CONSOLE=y
# CONFIG_MDA_CONSOLE is not set
CONFIG_DUMMY_CONSOLE=y

#
# Sound
#
CONFIG_SOUND=m

#
# Advanced Linux Sound Architecture
#
CONFIG_SND=m
# CONFIG_SND_SEQUENCER is not set
CONFIG_SND_OSSEMUL=y
CONFIG_SND_MIXER_OSS=m
CONFIG_SND_PCM_OSS=m
CONFIG_SND_RTCTIMER=m
# CONFIG_SND_VERBOSE_PRINTK is not set
# CONFIG_SND_DEBUG is not set

#
# Generic devices
#
# CONFIG_SND_DUMMY is not set
# CONFIG_SND_MTPAV is not set
# CONFIG_SND_SERIAL_U16550 is not set
# CONFIG_SND_MPU401 is not set

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
CONFIG_SND_CMIPCI=m
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
# Open Sound System
#
# CONFIG_SOUND_PRIME is not set

#
# USB support
#
# CONFIG_USB is not set
# CONFIG_USB_GADGET is not set

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
CONFIG_X86_BIOS_REBOOT=y
CONFIG_PC=y

--3MwIy2ne0vdjdPXF--
