Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262340AbTD3TET (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Apr 2003 15:04:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262341AbTD3TET
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Apr 2003 15:04:19 -0400
Received: from dns.toxicfilms.tv ([150.254.37.24]:41367 "EHLO
	dns.toxicfilms.tv") by vger.kernel.org with ESMTP id S262340AbTD3TDr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Apr 2003 15:03:47 -0400
Date: Wed, 30 Apr 2003 21:16:01 +0200 (CEST)
From: Maciej Soltysiak <solt@dns.toxicfilms.tv>
To: linux-kernel@vger.kernel.org
Subject: 2.5.68-bk8 oops after exiting X
Message-ID: <Pine.LNX.4.51.0304302109590.23607@dns.toxicfilms.tv>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

here's the printout + .config.

Regards,
Maciej

Apr 30 21:03:43 pysiak kernel: Unable to handle kernel paging request at virtual address c9bfd000
Apr 30 21:03:43 pysiak kernel:  printing eip:
Apr 30 21:03:43 pysiak kernel: c0138157
Apr 30 21:03:43 pysiak kernel: *pde = 098001e3
Apr 30 21:03:43 pysiak kernel: *pte = 72747372
Apr 30 21:03:43 pysiak kernel: Oops: 0002 [#1]
Apr 30 21:03:43 pysiak kernel: CPU:    0
Apr 30 21:03:43 pysiak kernel: EIP:    0060:[do_wp_page+327/797]    Tainted: P
Apr 30 21:03:43 pysiak kernel: EFLAGS: 00010287
Apr 30 21:03:43 pysiak kernel: EIP is at do_wp_page+0x147/0x31d
Apr 30 21:03:43 pysiak kernel: eax: c033df2c   ebx: c1185f88   ecx: 00000400   edx: c03e7148
Apr 30 21:03:43 pysiak kernel: esi: c441a000   edi: c9bfd000   ebp: c10aa410   esp: c1ca5eb8
Apr 30 21:03:43 pysiak kernel: ds: 007b   es: 007b   ss: 0068
Apr 30 21:03:43 pysiak kernel: Process K01xdm (pid: 13787, threadinfo=c1ca4000 task=cb427300)
Apr 30 21:03:43 pysiak kernel: Stack: 000000d0 c4a98080 c1160008 c1185f88 c6b31e80 c3ed9080 080eb180 c4a98080
Apr 30 21:03:43 pysiak kernel:        00000001 c0138f11 c4a98080 c9e1d7c0 080eb180 c62323ac c3ed9080 0441a065
Apr 30 21:03:43 pysiak kernel:        c01210cc c4a98080 c4a980a0 cb427300 080eb180 c0116309 c4a98080 c9e1d7c0
Apr 30 21:03:43 pysiak kernel: Call Trace:
Apr 30 21:03:43 pysiak kernel:  [handle_mm_fault+330/345] handle_mm_fault+0x14a/0x159
Apr 30 21:03:43 pysiak kernel:  [update_process_times+70/82] update_process_times+0x46/0x52
Apr 30 21:03:43 pysiak kernel:  [do_page_fault+293/1089] do_page_fault+0x125/0x441
Apr 30 21:03:43 pysiak kernel:  [do_sigaction+347/459] do_sigaction+0x15b/0x1cb
Apr 30 21:03:43 pysiak kernel:  [sys_rt_sigaction+229/269] sys_rt_sigaction+0xe5/0x10d
Apr 30 21:03:43 pysiak kernel:  [sys_rt_sigprocmask+142/300] sys_rt_sigprocmask+0x8e/0x12c
Apr 30 21:03:43 pysiak kernel:  [do_page_fault+0/1089] do_page_fault+0x0/0x441
Apr 30 21:03:43 pysiak kernel:  [error_code+45/56] error_code+0x2d/0x38
Apr 30 21:03:43 pysiak kernel:
Apr 30 21:03:43 pysiak kernel: Code: f3 a5 8b 44 24 38 8b 10 c1 ea 0c 6b d2 28 03 15 f8 79 3e c0
Apr 30 21:03:43 pysiak kernel:  <1>Unable to handle kernel paging request at virtual address c8ec4000
Apr 30 21:03:43 pysiak kernel:  printing eip:
Apr 30 21:03:43 pysiak kernel: c01204d6
Apr 30 21:03:43 pysiak kernel: *pde = 08c001e3
Apr 30 21:03:43 pysiak kernel: *pte = fffffe00
Apr 30 21:03:43 pysiak kernel: Oops: 0002 [#2]
Apr 30 21:03:43 pysiak kernel: CPU:    0
Apr 30 21:03:43 pysiak kernel: EIP:    0060:[access_process_vm+263/406]    Tainted: P
Apr 30 21:03:43 pysiak kernel: EFLAGS: 00010202
Apr 30 21:03:43 pysiak kernel: EIP is at access_process_vm+0x107/0x196
Apr 30 21:03:43 pysiak kernel: eax: c6a10000   ebx: 00000011   ecx: 00000004   edx: c033df2c
Apr 30 21:03:43 pysiak kernel: esi: c6a10f2d   edi: c8ec4000   ebp: c8ec4000   esp: c91a9ed8
Apr 30 21:03:43 pysiak kernel: ds: 007b   es: 007b   ss: 0068
Apr 30 21:03:43 pysiak kernel: Process cat (pid: 13791, threadinfo=c91a8000 task=cb427300)
Apr 30 21:03:43 pysiak kernel: Stack: cb427300 ccaf6b00 bfffff2d 00000000 00000000 00000001 c91a9f08 c91a9f0c
Apr 30 21:03:43 pysiak kernel:        c91a8000 ccaf6b20 ccaf6b00 c8ec4000 c1109280 c89ad880 ccaf6b00 00000000
Apr 30 21:03:43 pysiak kernel:        c8ec4000 cc212700 c016a7a8 cc212700 bfffff2d c8ec4000 00000011 00000000
Apr 30 21:03:43 pysiak kernel: Call Trace:
Apr 30 21:03:43 pysiak kernel:  [proc_pid_cmdline+95/265] proc_pid_cmdline+0x5f/0x109
Apr 30 21:03:43 pysiak kernel:  [proc_info_read+116/328] proc_info_read+0x74/0x148
Apr 30 21:03:43 pysiak kernel:  [vfs_read+188/295] vfs_read+0xbc/0x127
Apr 30 21:03:43 pysiak kernel:  [sys_read+62/85] sys_read+0x3e/0x55
Apr 30 21:03:43 pysiak kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Apr 30 21:03:43 pysiak kernel:
Apr 30 21:03:43 pysiak kernel: Code: f3 a5 f6 c3 02 74 02 66 a5 f6 c3 01 74 01 a4 8b 54 24 30 8b
Apr 30 21:03:43 pysiak kernel:  <1>Unable to handle kernel paging request at virtual address c303ae00
Apr 30 21:03:43 pysiak kernel:  printing eip:
Apr 30 21:03:43 pysiak kernel: c013ca87
Apr 30 21:03:43 pysiak kernel: *pde = 030001e3
Apr 30 21:03:43 pysiak kernel: *pte = 18b60f00
Apr 30 21:03:43 pysiak kernel: Oops: 0000 [#3]
Apr 30 21:03:43 pysiak kernel: CPU:    0
Apr 30 21:03:43 pysiak kernel: EIP:    0060:[page_remove_rmap+144/257]    Tainted: P
Apr 30 21:03:43 pysiak kernel: EFLAGS: 00010286
Apr 30 21:03:43 pysiak kernel: EIP is at page_remove_rmap+0x90/0x101
Apr 30 21:03:43 pysiak kernel: eax: 0102006c   ebx: c1131780   ecx: c03e12dc   edx: c303ae00
Apr 30 21:03:43 pysiak kernel: esi: c303ae00   edi: ffffffff   ebp: c1131780   esp: c8333a90
Apr 30 21:03:43 pysiak kernel: ds: 007b   es: 007b   ss: 0068
Apr 30 21:03:43 pysiak kernel: Process rc (pid: 13795, threadinfo=c8332000 task=c8bc1880)
Apr 30 21:03:43 pysiak kernel: Stack: ca440980 c303ae00 cee5c22c cee5c22c 00043000 00089000 c1131780 c0137656
Apr 30 21:03:43 pysiak kernel:        c125cc68 c012e5f8 c8333af4 c8333ac8 07a30005 c87a7084 08448000 080d1000
Apr 30 21:03:43 pysiak kernel:        c03e12dc c01376f6 c03e12dc c87a7080 08048000 00089000 08048000 c87a7084
Apr 30 21:03:43 pysiak kernel: Call Trace:
Apr 30 21:03:43 pysiak kernel:  [zap_pte_range+330/419] zap_pte_range+0x14a/0x1a3
Apr 30 21:03:43 pysiak kernel:  [generic_file_aio_read+90/116] generic_file_aio_read+0x5a/0x74
Apr 30 21:03:43 pysiak kernel:  [zap_pmd_range+71/99] zap_pmd_range+0x47/0x63
Apr 30 21:03:43 pysiak kernel:  [unmap_page_range+67/105] unmap_page_range+0x43/0x69
Apr 30 21:03:43 pysiak kernel:  [unmap_vmas+204/528] unmap_vmas+0xcc/0x210
Apr 30 21:03:43 pysiak kernel:  [exit_mmap+112/365] exit_mmap+0x70/0x16d
Apr 30 21:03:43 pysiak kernel:  [mmput+62/128] mmput+0x3e/0x80
Apr 30 21:03:43 pysiak kernel:  [exec_mmap+140/239] exec_mmap+0x8c/0xef
Apr 30 21:03:43 pysiak kernel:  [flush_old_exec+25/1761] flush_old_exec+0x19/0x6e1
Apr 30 21:03:43 pysiak kernel:  [kernel_read+80/95] kernel_read+0x50/0x5f
Apr 30 21:03:43 pysiak kernel:  [load_elf_binary+726/2892] load_elf_binary+0x2d6/0xb4c
Apr 30 21:03:43 pysiak kernel:  [generic_file_aio_read+90/116] generic_file_aio_read+0x5a/0x74
Apr 30 21:03:43 pysiak kernel:  [vfs_follow_link+51/355] vfs_follow_link+0x33/0x163
Apr 30 21:03:43 pysiak kernel:  [dentry_open+423/452] dentry_open+0x1a7/0x1c4
Apr 30 21:03:43 pysiak kernel:  [search_binary_handler+245/409] search_binary_handler+0xf5/0x199
Apr 30 21:03:43 pysiak kernel:  [prepare_binprm+210/228] prepare_binprm+0xd2/0xe4
Apr 30 21:03:43 pysiak kernel:  [load_script+507/560] load_script+0x1fb/0x230
Apr 30 21:03:43 pysiak kernel:  [buffered_rmqueue+146/251] buffered_rmqueue+0x92/0xfb
Apr 30 21:03:43 pysiak kernel:  [__alloc_pages+146/748] __alloc_pages+0x92/0x2ec
Apr 30 21:03:43 pysiak kernel:  [copy_strings+504/584] copy_strings+0x1f8/0x248
Apr 30 21:03:43 pysiak kernel:  [search_binary_handler+245/409] search_binary_handler+0xf5/0x199
Apr 30 21:03:43 pysiak kernel:  [do_execve+529/600] do_execve+0x211/0x258
Apr 30 21:03:43 pysiak kernel:  [sys_execve+80/127] sys_execve+0x50/0x7f
Apr 30 21:03:43 pysiak kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Apr 30 21:03:43 pysiak kernel:
Apr 30 21:03:43 pysiak kernel: Code: 8b 02 89 c5 83 e5 e0 74 04 0f 18 45 00 89 c1 83 e1 1f 83 f9
Apr 30 21:03:43 pysiak kernel:  <1>Unable to handle kernel paging request at virtual address c3381300
Apr 30 21:03:43 pysiak kernel:  printing eip:
Apr 30 21:03:43 pysiak kernel: c013ca87
Apr 30 21:03:43 pysiak kernel: *pde = 030001e3
Apr 30 21:03:43 pysiak kernel: *pte = 6a575a58
Apr 30 21:03:43 pysiak kernel: Oops: 0000 [#4]
Apr 30 21:03:43 pysiak kernel: CPU:    0
Apr 30 21:03:43 pysiak kernel: EIP:    0060:[page_remove_rmap+144/257]    Tainted: P
Apr 30 21:03:43 pysiak kernel: EFLAGS: 00010286
Apr 30 21:03:43 pysiak kernel: EIP is at page_remove_rmap+0x90/0x101
Apr 30 21:03:43 pysiak kernel: eax: 01000070   ebx: c11c6600   ecx: c03e12dc   edx: c3381300
Apr 30 21:03:43 pysiak kernel: esi: c3381300   edi: ffffffff   ebp: c11c6600   esp: c80e1b7c
Apr 30 21:03:43 pysiak kernel: ds: 007b   es: 007b   ss: 0068
Apr 30 21:03:43 pysiak kernel: Process K11cron (pid: 13797, threadinfo=c80e0000 task=cad0a080)
Apr 30 21:03:43 pysiak kernel: Stack: cccc2880 c3381300 c5f60180 c5f60180 00005000 00009000 c11c6600 c0137656
Apr 30 21:03:43 pysiak kernel:        c11c6600 c012e5f8 c80e1be0 c80e1bb4 0b5c0045 c6d91404 4045b000 40064000
Apr 30 21:03:43 pysiak kernel:        c03e12dc c01376f6 c03e12dc c6d91400 4005b000 00009000 4005b000 c6d91404
Apr 30 21:03:43 pysiak kernel: Call Trace:
Apr 30 21:03:43 pysiak kernel:  [zap_pte_range+330/419] zap_pte_range+0x14a/0x1a3
Apr 30 21:03:43 pysiak kernel:  [generic_file_aio_read+90/116] generic_file_aio_read+0x5a/0x74
Apr 30 21:03:43 pysiak kernel:  [zap_pmd_range+71/99] zap_pmd_range+0x47/0x63
Apr 30 21:03:43 pysiak kernel:  [unmap_page_range+67/105] unmap_page_range+0x43/0x69
Apr 30 21:03:43 pysiak kernel:  [unmap_vmas+204/528] unmap_vmas+0xcc/0x210
Apr 30 21:03:43 pysiak kernel:  [exit_mmap+112/365] exit_mmap+0x70/0x16d
Apr 30 21:03:43 pysiak kernel:  [mmput+62/128] mmput+0x3e/0x80
Apr 30 21:03:43 pysiak kernel:  [exec_mmap+140/239] exec_mmap+0x8c/0xef
Apr 30 21:03:43 pysiak kernel:  [flush_old_exec+25/1761] flush_old_exec+0x19/0x6e1
Apr 30 21:03:43 pysiak kernel:  [kernel_read+80/95] kernel_read+0x50/0x5f
Apr 30 21:03:43 pysiak kernel:  [load_elf_binary+726/2892] load_elf_binary+0x2d6/0xb4c
Apr 30 21:03:43 pysiak kernel:  [generic_file_aio_read+90/116] generic_file_aio_read+0x5a/0x74
Apr 30 21:03:43 pysiak kernel:  [__alloc_pages+146/748] __alloc_pages+0x92/0x2ec
Apr 30 21:03:43 pysiak kernel:  [copy_strings+504/584] copy_strings+0x1f8/0x248
Apr 30 21:03:43 pysiak kernel:  [search_binary_handler+245/409] search_binary_handler+0xf5/0x199
Apr 30 21:03:43 pysiak kernel:  [do_execve+529/600] do_execve+0x211/0x258
Apr 30 21:03:43 pysiak kernel:  [sys_execve+80/127] sys_execve+0x50/0x7f
Apr 30 21:03:43 pysiak kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Apr 30 21:03:43 pysiak kernel:
Apr 30 21:03:43 pysiak kernel: Code: 8b 02 89 c5 83 e5 e0 74 04 0f 18 45 00 89 c1 83 e1 1f 83 f9



Here's the config:
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

#
# General setup
#
CONFIG_SWAP=y
CONFIG_SYSVIPC=y
CONFIG_BSD_PROCESS_ACCT=y
CONFIG_SYSCTL=y
CONFIG_LOG_BUF_SHIFT=14

#
# Loadable module support
#
CONFIG_MODULES=y
CONFIG_MODULE_UNLOAD=y
CONFIG_MODULE_FORCE_UNLOAD=y
CONFIG_OBSOLETE_MODPARM=y
# CONFIG_MODVERSIONS is not set
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
# CONFIG_M386 is not set
# CONFIG_M486 is not set
# CONFIG_M586 is not set
# CONFIG_M586TSC is not set
# CONFIG_M586MMX is not set
# CONFIG_M686 is not set
# CONFIG_MPENTIUMII is not set
# CONFIG_MPENTIUMIII is not set
CONFIG_MPENTIUM4=y
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
CONFIG_X86_CMPXCHG=y
CONFIG_X86_XADD=y
CONFIG_X86_L1_CACHE_SHIFT=7
CONFIG_RWSEM_XCHGADD_ALGORITHM=y
CONFIG_X86_WP_WORKS_OK=y
CONFIG_X86_INVLPG=y
CONFIG_X86_BSWAP=y
CONFIG_X86_POPAD_OK=y
CONFIG_X86_GOOD_APIC=y
CONFIG_X86_INTEL_USERCOPY=y
CONFIG_X86_USE_PPRO_CHECKSUM=y
CONFIG_X86_PREFETCH=y
CONFIG_X86_SSE2=y
# CONFIG_HUGETLB_PAGE is not set
# CONFIG_SMP is not set
# CONFIG_PREEMPT is not set
CONFIG_X86_UP_APIC=y
CONFIG_X86_UP_IOAPIC=y
CONFIG_X86_LOCAL_APIC=y
CONFIG_X86_IO_APIC=y
CONFIG_X86_TSC=y
CONFIG_X86_MCE=y
# CONFIG_X86_MCE_NONFATAL is not set
# CONFIG_X86_MCE_P4THERMAL is not set
# CONFIG_TOSHIBA is not set
# CONFIG_I8K is not set
# CONFIG_MICROCODE is not set
# CONFIG_X86_MSR is not set
CONFIG_X86_CPUID=y
CONFIG_EDD=y
CONFIG_NOHIGHMEM=y
# CONFIG_HIGHMEM4G is not set
# CONFIG_HIGHMEM64G is not set
# CONFIG_MATH_EMULATION is not set
CONFIG_MTRR=y

#
# Power management options (ACPI, APM)
#
# CONFIG_PM is not set

#
# ACPI Support
#
# CONFIG_ACPI is not set

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
# CONFIG_SCx200 is not set
# CONFIG_PCI_LEGACY_PROC is not set
CONFIG_PCI_NAMES=y
# CONFIG_ISA is not set
# CONFIG_MCA is not set
# CONFIG_HOTPLUG is not set

#
# Executable file formats
#
CONFIG_KCORE_ELF=y
# CONFIG_KCORE_AOUT is not set
CONFIG_BINFMT_AOUT=y
CONFIG_BINFMT_ELF=y
CONFIG_BINFMT_MISC=y

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
CONFIG_PNP_NAMES=y
# CONFIG_PNP_DEBUG is not set

#
# Protocols
#
# CONFIG_ISAPNP is not set
CONFIG_PNPBIOS=y

#
# Block devices
#
CONFIG_BLK_DEV_FD=y
# CONFIG_BLK_CPQ_DA is not set
# CONFIG_BLK_CPQ_CISS_DA is not set
# CONFIG_BLK_DEV_DAC960 is not set
# CONFIG_BLK_DEV_UMEM is not set
# CONFIG_BLK_DEV_LOOP is not set
# CONFIG_BLK_DEV_NBD is not set
# CONFIG_BLK_DEV_RAM is not set
# CONFIG_BLK_DEV_INITRD is not set
# CONFIG_LBD is not set

#
# ATA/ATAPI/MFM/RLL device support
#
CONFIG_IDE=y

#
# IDE, ATA and ATAPI Block devices
#
CONFIG_BLK_DEV_IDE=y

#
# Please see Documentation/ide.txt for help/info on IDE drives
#
# CONFIG_BLK_DEV_HD_IDE is not set
# CONFIG_BLK_DEV_HD is not set
CONFIG_BLK_DEV_IDEDISK=y
CONFIG_IDEDISK_MULTI_MODE=y
# CONFIG_IDEDISK_STROKE is not set
CONFIG_BLK_DEV_IDECD=y
# CONFIG_BLK_DEV_IDEFLOPPY is not set
# CONFIG_IDE_TASK_IOCTL is not set

#
# IDE chipset support/bugfixes
#
CONFIG_BLK_DEV_CMD640=y
# CONFIG_BLK_DEV_CMD640_ENHANCED is not set
# CONFIG_BLK_DEV_IDEPNP is not set
CONFIG_BLK_DEV_IDEPCI=y
# CONFIG_BLK_DEV_GENERIC is not set
CONFIG_IDEPCI_SHARE_IRQ=y
CONFIG_BLK_DEV_IDEDMA_PCI=y
# CONFIG_BLK_DEV_IDE_TCQ is not set
# CONFIG_BLK_DEV_OFFBOARD is not set
# CONFIG_BLK_DEV_IDEDMA_FORCED is not set
CONFIG_IDEDMA_PCI_AUTO=y
# CONFIG_IDEDMA_ONLYDISK is not set
CONFIG_BLK_DEV_IDEDMA=y
# CONFIG_IDEDMA_PCI_WIP is not set
CONFIG_BLK_DEV_ADMA=y
# CONFIG_BLK_DEV_AEC62XX is not set
# CONFIG_BLK_DEV_ALI15X3 is not set
# CONFIG_BLK_DEV_AMD74XX is not set
# CONFIG_BLK_DEV_CMD64X is not set
# CONFIG_BLK_DEV_TRIFLEX is not set
# CONFIG_BLK_DEV_CY82C693 is not set
# CONFIG_BLK_DEV_CS5520 is not set
# CONFIG_BLK_DEV_HPT34X is not set
# CONFIG_BLK_DEV_HPT366 is not set
# CONFIG_BLK_DEV_SC1200 is not set
CONFIG_BLK_DEV_PIIX=y
# CONFIG_BLK_DEV_NS87415 is not set
# CONFIG_BLK_DEV_OPTI621 is not set
# CONFIG_BLK_DEV_PDC202XX_OLD is not set
# CONFIG_BLK_DEV_PDC202XX_NEW is not set
CONFIG_BLK_DEV_RZ1000=y
# CONFIG_BLK_DEV_SVWKS is not set
# CONFIG_BLK_DEV_SIIMAGE is not set
# CONFIG_BLK_DEV_SIS5513 is not set
# CONFIG_BLK_DEV_SLC90E66 is not set
# CONFIG_BLK_DEV_TRM290 is not set
# CONFIG_BLK_DEV_VIA82CXXX is not set
CONFIG_IDEDMA_AUTO=y
# CONFIG_IDEDMA_IVB is not set
CONFIG_BLK_DEV_IDE_MODES=y

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
CONFIG_NETFILTER=y
# CONFIG_NETFILTER_DEBUG is not set
CONFIG_UNIX=y
CONFIG_NET_KEY=y
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
CONFIG_INET_AH=y
CONFIG_INET_ESP=y
CONFIG_INET_IPCOMP=y

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
CONFIG_IP_NF_MATCH_MAC=m
CONFIG_IP_NF_MATCH_PKTTYPE=m
CONFIG_IP_NF_MATCH_MARK=m
CONFIG_IP_NF_MATCH_MULTIPORT=m
CONFIG_IP_NF_MATCH_TOS=m
CONFIG_IP_NF_MATCH_ECN=m
CONFIG_IP_NF_MATCH_DSCP=m
CONFIG_IP_NF_MATCH_AH_ESP=m
CONFIG_IP_NF_MATCH_LENGTH=m
CONFIG_IP_NF_MATCH_TTL=m
CONFIG_IP_NF_MATCH_TCPMSS=m
CONFIG_IP_NF_MATCH_HELPER=m
CONFIG_IP_NF_MATCH_STATE=m
CONFIG_IP_NF_MATCH_CONNTRACK=m
CONFIG_IP_NF_MATCH_UNCLEAN=m
CONFIG_IP_NF_MATCH_OWNER=m
CONFIG_IP_NF_FILTER=m
CONFIG_IP_NF_TARGET_REJECT=m
CONFIG_IP_NF_TARGET_MIRROR=m
CONFIG_IP_NF_NAT=m
CONFIG_IP_NF_NAT_NEEDED=y
CONFIG_IP_NF_TARGET_MASQUERADE=m
CONFIG_IP_NF_TARGET_REDIRECT=m
CONFIG_IP_NF_NAT_LOCAL=y
CONFIG_IP_NF_NAT_SNMP_BASIC=m
CONFIG_IP_NF_NAT_IRC=m
CONFIG_IP_NF_NAT_FTP=m
CONFIG_IP_NF_NAT_TFTP=m
CONFIG_IP_NF_NAT_AMANDA=m
CONFIG_IP_NF_MANGLE=m
CONFIG_IP_NF_TARGET_TOS=m
CONFIG_IP_NF_TARGET_ECN=m
CONFIG_IP_NF_TARGET_DSCP=m
CONFIG_IP_NF_TARGET_MARK=m
CONFIG_IP_NF_TARGET_LOG=m
CONFIG_IP_NF_TARGET_ULOG=m
CONFIG_IP_NF_TARGET_TCPMSS=m
CONFIG_IP_NF_ARPTABLES=m
CONFIG_IP_NF_ARPFILTER=m
# CONFIG_IP_NF_COMPAT_IPCHAINS is not set
# CONFIG_IP_NF_COMPAT_IPFWADM is not set
CONFIG_IPV6=y
CONFIG_IPV6_PRIVACY=y
CONFIG_INET6_AH=y
CONFIG_INET6_ESP=y

#
# IPv6: Netfilter Configuration
#
CONFIG_IP6_NF_QUEUE=m
CONFIG_IP6_NF_IPTABLES=m
CONFIG_IP6_NF_MATCH_LIMIT=m
CONFIG_IP6_NF_MATCH_MAC=m
CONFIG_IP6_NF_MATCH_RT=m
CONFIG_IP6_NF_MATCH_OPTS=m
CONFIG_IP6_NF_MATCH_FRAG=m
CONFIG_IP6_NF_MATCH_HL=m
CONFIG_IP6_NF_MATCH_MULTIPORT=m
CONFIG_IP6_NF_MATCH_OWNER=m
CONFIG_IP6_NF_MATCH_MARK=m
CONFIG_IP6_NF_MATCH_IPV6HEADER=m
CONFIG_IP6_NF_MATCH_AHESP=m
CONFIG_IP6_NF_MATCH_LENGTH=m
CONFIG_IP6_NF_MATCH_EUI64=m
CONFIG_IP6_NF_FILTER=m
CONFIG_IP6_NF_TARGET_LOG=m
CONFIG_IP6_NF_MANGLE=m
CONFIG_IP6_NF_TARGET_MARK=m
CONFIG_XFRM_USER=y

#
# SCTP Configuration (EXPERIMENTAL)
#
CONFIG_IPV6_SCTP__=y
# CONFIG_IP_SCTP is not set
# CONFIG_ATM is not set
# CONFIG_VLAN_8021Q is not set
CONFIG_LLC=y
# CONFIG_LLC_UI is not set
CONFIG_IPX=y
# CONFIG_IPX_INTERN is not set
# CONFIG_ATALK is not set
# CONFIG_DECNET is not set
# CONFIG_BRIDGE is not set
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
CONFIG_NET_PKTGEN=m
CONFIG_NETDEVICES=y

#
# ARCnet devices
#
# CONFIG_ARCNET is not set
CONFIG_DUMMY=m
# CONFIG_BONDING is not set
# CONFIG_EQUALIZER is not set
# CONFIG_TUN is not set
# CONFIG_ETHERTAP is not set

#
# Ethernet (10 or 100Mbit)
#
CONFIG_NET_ETHERNET=y
# CONFIG_MII is not set
# CONFIG_HAPPYMEAL is not set
# CONFIG_SUNGEM is not set
CONFIG_NET_VENDOR_3COM=y
CONFIG_VORTEX=y
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
# Token Ring devices (depends on LLC=y)
#
# CONFIG_TR is not set
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
# CONFIG_SERIO_SERPORT is not set
# CONFIG_SERIO_CT82C710 is not set

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
# CONFIG_SERIAL_8250 is not set

#
# Non-8250 serial port support
#
CONFIG_UNIX98_PTYS=y
CONFIG_UNIX98_PTY_COUNT=256

#
# I2C support
#
# CONFIG_I2C is not set

#
# I2C Hardware Sensors Mainboard support
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
CONFIG_NVRAM=y
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
CONFIG_AGP_INTEL=y
# CONFIG_AGP_VIA is not set
# CONFIG_AGP_AMD is not set
# CONFIG_AGP_SIS is not set
# CONFIG_AGP_ALI is not set
# CONFIG_AGP_SWORKS is not set
# CONFIG_AGP_AMD_8151 is not set
CONFIG_DRM=y
# CONFIG_DRM_TDFX is not set
# CONFIG_DRM_R128 is not set
# CONFIG_DRM_RADEON is not set
# CONFIG_DRM_I810 is not set
# CONFIG_DRM_I830 is not set
# CONFIG_DRM_MGA is not set
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
CONFIG_EXT3_FS=y
CONFIG_EXT3_FS_XATTR=y
CONFIG_EXT3_FS_POSIX_ACL=y
CONFIG_JBD=y
# CONFIG_JBD_DEBUG is not set
CONFIG_FS_MBCACHE=y
CONFIG_REISERFS_FS=m
# CONFIG_REISERFS_CHECK is not set
# CONFIG_REISERFS_PROC_INFO is not set
# CONFIG_JFS_FS is not set
CONFIG_FS_POSIX_ACL=y
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
# CONFIG_ZISOFS is not set
CONFIG_UDF_FS=m

#
# DOS/FAT/NT Filesystems
#
CONFIG_FAT_FS=m
CONFIG_MSDOS_FS=m
CONFIG_VFAT_FS=m
CONFIG_NTFS_FS=m
CONFIG_NTFS_DEBUG=y
CONFIG_NTFS_RW=y

#
# Pseudo filesystems
#
CONFIG_PROC_FS=y
# CONFIG_DEVFS_FS is not set
CONFIG_DEVPTS_FS=y
CONFIG_TMPFS=y
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
CONFIG_NFS_FS=m
CONFIG_NFS_V3=y
CONFIG_NFS_V4=y
CONFIG_NFSD=m
CONFIG_NFSD_V3=y
CONFIG_NFSD_V4=y
CONFIG_NFSD_TCP=y
CONFIG_LOCKD=m
CONFIG_LOCKD_V4=y
CONFIG_EXPORTFS=m
CONFIG_SUNRPC=m
CONFIG_SUNRPC_GSS=m
CONFIG_RPCSEC_GSS_KRB5=m
CONFIG_SMB_FS=y
# CONFIG_SMB_NLS_DEFAULT is not set
CONFIG_CIFS=y
CONFIG_NCP_FS=y
CONFIG_NCPFS_PACKET_SIGNING=y
# CONFIG_NCPFS_IOCTL_LOCKING is not set
CONFIG_NCPFS_STRONG=y
CONFIG_NCPFS_NFS_NS=y
CONFIG_NCPFS_OS2_NS=y
# CONFIG_NCPFS_SMALLDOS is not set
CONFIG_NCPFS_NLS=y
CONFIG_NCPFS_EXTRAS=y
# CONFIG_CODA_FS is not set
# CONFIG_INTERMEZZO_FS is not set
CONFIG_AFS_FS=m
CONFIG_RXRPC=m

#
# Partition Types
#
# CONFIG_PARTITION_ADVANCED is not set
CONFIG_MSDOS_PARTITION=y
CONFIG_SMB_NLS=y
CONFIG_NLS=y

#
# Native Language Support
#
CONFIG_NLS_DEFAULT="iso8859-2"
CONFIG_NLS_CODEPAGE_437=y
# CONFIG_NLS_CODEPAGE_737 is not set
# CONFIG_NLS_CODEPAGE_775 is not set
# CONFIG_NLS_CODEPAGE_850 is not set
CONFIG_NLS_CODEPAGE_852=y
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
CONFIG_NLS_CODEPAGE_1250=y
# CONFIG_NLS_CODEPAGE_1251 is not set
CONFIG_NLS_ISO8859_1=y
CONFIG_NLS_ISO8859_2=y
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
CONFIG_SND_VIRMIDI=y
# CONFIG_SND_MTPAV is not set
# CONFIG_SND_SERIAL_U16550 is not set
# CONFIG_SND_MPU401 is not set

#
# PCI devices
#
# CONFIG_SND_ALI5451 is not set
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
CONFIG_SND_INTEL8X0=y
# CONFIG_SND_SONICVIBES is not set
# CONFIG_SND_VIA82XX is not set

#
# Open Sound System
#
# CONFIG_SOUND_PRIME is not set

#
# USB support
#
# CONFIG_USB is not set

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
CONFIG_DEBUG_KERNEL=y
# CONFIG_DEBUG_STACKOVERFLOW is not set
# CONFIG_DEBUG_SLAB is not set
# CONFIG_DEBUG_IOVIRT is not set
CONFIG_MAGIC_SYSRQ=y
# CONFIG_DEBUG_SPINLOCK is not set
CONFIG_KALLSYMS=y
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
CONFIG_CRYPTO=y
CONFIG_CRYPTO_HMAC=y
# CONFIG_CRYPTO_NULL is not set
# CONFIG_CRYPTO_MD4 is not set
CONFIG_CRYPTO_MD5=y
CONFIG_CRYPTO_SHA1=y
# CONFIG_CRYPTO_SHA256 is not set
# CONFIG_CRYPTO_SHA512 is not set
CONFIG_CRYPTO_DES=y
# CONFIG_CRYPTO_BLOWFISH is not set
# CONFIG_CRYPTO_TWOFISH is not set
# CONFIG_CRYPTO_SERPENT is not set
# CONFIG_CRYPTO_AES is not set
# CONFIG_CRYPTO_DEFLATE is not set
# CONFIG_CRYPTO_TEST is not set

#
# Library routines
#
CONFIG_CRC32=m
CONFIG_X86_BIOS_REBOOT=y
