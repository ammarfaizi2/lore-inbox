Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261310AbVDUA56@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261310AbVDUA56 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Apr 2005 20:57:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261227AbVDUA56
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Apr 2005 20:57:58 -0400
Received: from fire.osdl.org ([65.172.181.4]:33420 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261869AbVDUA5X (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Apr 2005 20:57:23 -0400
Date: Wed, 20 Apr 2005 17:59:19 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Linux 2.6.12-rc3
Message-ID: <Pine.LNX.4.58.0504201728110.2344@ppc970.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Ok,
 you know what the subject line means by now, but this release is a bit 
different from the usual ones, for obvious reasons. It's the first in a 
_long_ time that I've done without using BK, and it's the first one ever 
that has been built up completely with "git".

It's available both as a patch (against 2.6.11) and as a tar-ball, and 
for non-BK users the biggest difference is probably that the ChangeLog 
format has changed a bit. And it will probably continue to evolve, since I 
don't have my "release-script" tools set up for the new setup, so this 
release was done largely manually with some ad-hoc scripting to get the 
ChangeLog information etc out of git.

For BK users, I hope we can get a BK tree that tracks this set up soon, 
and it should hopefully not be too disruptive either.

And for the crazy people, the git archive on kernel.org is up and running 
under /pub/scm/linux/kernel/git/torvalds/linux-2.6.git. For the 
adventurous of you, the name of the 2.6.12-rc3 release is a very nice and 
readable:

	a2755a80f40e5794ddc20e00f781af9d6320fafb

and eventually I'll try to make sure that I actually accompany all 
releases with the SHA1 git name of the release signed with a digital 
signature. 

One of the tools I don't have set up yet is the old "shortlog" script, so 
I did this really hacky conversion. You don't want to know, but let's say 
that I'm re-aquainting myself with 'sed' after a long time ;). But if some 
lines look like they got hacked up in the middle, rest assured that that's 
exactly what happened, and the long log should have the rest ...

			Linus

----
Changes since 2.6.12-rc2:

Adrian Bunk:
    [PATCH] MAINTAINERS: remove obsolete ACP/MWAVE MODEM entry
    [PATCH] let SOUND_AD1889 depend on PCI

Alan Stern:
    [PATCH] USB: USB API documentation modification

Alexander Nyberg:
    [PATCH] swsusp: SMP fix

Andi Kleen:
    [PATCH] x86-64/i386: Revert cpuinfo siblings behaviour back to 2.6.10
    [PATCH] x86-64: Fix BUG()
    [PATCH] x86_64: Add acpi_skip_timer_override option
    [PATCH] x86_64: Always use CPUID 80000008 to figure out MTRR address space size
    [PATCH] x86_64: Call do_notify_resume unconditionally in entry.S
    [PATCH] x86_64: Correct wrong comment in local.h
    [PATCH] x86_64: Don't assume future AMD CPUs have K8 compatible performance counters
    [PATCH] x86_64: Dump stack and prevent recursion on early fault
    [PATCH] x86_64: Final support for AMD dual core
    [PATCH] x86_64: Fix a small missing schedule race
    [PATCH] x86_64: Fix interaction of single stepping with debuggers
    [PATCH] x86_64: Handle programs that set TF in user space using popf while single stepping
    [PATCH] x86_64: Keep only a single debug notifier chain
    [PATCH] x86_64: Make IRDA devices are not really ISA devices not depend on CONFIG_ISA
    [PATCH] x86_64: Make kernel math errors a die() now
    [PATCH] x86_64: Minor microoptimization in syscall entry slow path
    [PATCH] x86_64: Port over e820 gap detection from i386
    [PATCH] x86_64: Regularize exception stack handling
    [PATCH] x86_64: Remove duplicated syscall entry.
    [PATCH] x86_64: Remove excessive stack allocation in MCE code with large NR_CPUS
    [PATCH] x86_64: Remove unused macro in preempt support
    [PATCH] x86_64: Rename the extended cpuid level field
    [PATCH] x86_64: Rewrite exception stack backtracing
    [PATCH] x86_64: Some fixes for single step handling
    [PATCH] x86_64: Support constantly ticking TSCs
    [PATCH] x86_64: Switch SMP bootup over to new CPU hotplug state machine
    [PATCH] x86_64: Use a VMA for the 32bit vsyscall
    [PATCH] x86_64: Use a common function to find code segment bases
    [PATCH] x86_64: Use the e820 hole to map the IOMMU/AGP aperture
    [PATCH] x86_64: Use the extended RIP MSR for machine check reporting if available.
    [PATCH] x86_64: add support for Intel dual-core detection and displaying
    [PATCH] x86_64: clean up ptrace single-stepping
    [PATCH] x86_64: disable interrupts during SMP bogomips checking

Andrea Arcangeli:
    [PATCH] oom-killer disable for iscsi/lvm2/multipath userland critical sections

Andrew Morton:
    [PATCH] Fix acl Oops
    [PATCH] USB: usb_cdc build fix
    [PATCH] USB: usbnet printk warning fix
    [PATCH] arm: add comment about dma_supported()
    [PATCH] arm: add comment about max_low_pfn/max_pfn
    [PATCH] arm: fix SIGBUS handling
    [PATCH] arm: fix help text for ixdp465
    [PATCH] end_buffer_write_sync() avoid pointless assignments
    [PATCH] fix Bug 4395: modprobe bttv freezes the computer
    [PATCH] jbd dirty buffer leak fix
    [PATCH] vmscan: pageout(): remove unneeded test
    [PATCH] x86_64 show_stack(): call touch_nmi_watchdog

Anton Blanchard:
    [PATCH] ppc64: remove -fno-omit-frame-pointer

Arnaldo Carvalho de Melo:
    [PATCH] net: don't call kmem_cache_create with a spinlock held
    [SOCK]: on failure free the sock from the right place

Artem B. Bityuckiy:
    [PATCH] crypto: call zlib end functions on deflate exit path

Benjamin Herrenschmidt:
    [PATCH] fbdev MAINTAINERS update
    [PATCH] pmac: Improve sleep code of tumbler driver
    [PATCH] pmac: sound support for latest laptops
    [PATCH] ppc32: Fix AGP and sleep again
    [PATCH] ppc32: Fix cpufreq problems
    [PATCH] ppc32: MV643XX ethernet is an option for Pegasos
    [PATCH] ppc64: Detect altivec via firmware on unknown CPUs
    [PATCH] ppc64: Fix semantics of __ioremap
    [PATCH] ppc64: Improve mapping of vDSO
    [PATCH] ppc64: remove bogus f50 hack in prom.c
    [PATCH] ppc64: very basic desktop g5 sound support

Benoit Boissinot:
    [PATCH] cpuset: remove function attribute const
    [PATCH] ppc32: fix compilation error in arch/ppc/kernel/time.c
    [PATCH] ppc32: fix compilation error in arch/ppc/syslib/open_pic_defs.h
    [PATCH] ppc32: fix compilation error in include/asm-m68k/setup.h
    [PATCH] ppc32: fix compilation error in include/asm/prom.h

Bernard Blackham:
    [PATCH] ext2 corruption - regression between 2.6.9 and 2.6.10

Bert Wesarg:
    [PATCH] fix module_param_string() calls
    [PATCH] kernel/param.c: don't use .max when .num is NULL in param_array_set()

Bharath Ramesh:
    [PATCH] AYSNC IO using singals other than SIGIO

Chris Wedgwood:
    [PATCH] x86: fix acpi compile without CONFIG_ACPI_BUS

Christoph Hellwig:
    [PATCH] fix up newly added jsm driver
    [PATCH] kill #ifndef HAVE_ARCH_GET_SIGNAL_TO_DELIVER in signal.c
    [PATCH] officially deprecate register_ioctl32_conversion

Christoph Lameter:
    [PATCH] mmtimer build fix

Christopher Li:
    [PATCH] USB: bug fix in usbdevfs

Colin Leroy:
    [PATCH] CREDITS update

Coywolf Qi Hunt:
    [PATCH] reparent_to_init cleanup

Daniel McNeil:
    [PATCH] Direct IO async short read fix

Dave Airlie:
    [PATCH] r128_state.c: break missing in switch statement

Dave Hansen:
    [PATCH] undo do_readv_writev() behavior change

David Brownell:
    [PATCH] USB: OHCI on Compaq Aramada 7400
    [PATCH] USB: hcd suspend uses pm_message_t
    [PATCH] USB: revert "fix" to usb_set_interface()
    [PATCH] USB: usbnet and zaurus zl-5600
    [PATCH] revert fs/char_dev.c CONFIG_BASE_FULL change
    [PATCH] usb gadget: ethernet/rndis updates
    [PATCH] usb resume fixes
    [PATCH] usb suspend updates (interface suspend)

David Howells:
    [PATCH] Add 32-bit compatibility for NFSv4 mount

David S. Miller:
    [PATCH] Fix get_compat_sigevent()
    [PATCH] Fix linux/atalk.h header
    [PATCH] sparc64: Do not flush dcache for ZERO_PAGE.
    [PATCH] sparc64: Fix stat
    [PATCH] sparc64: Reduce ptrace cache flushing
    [PATCH] sparc64: use message queue compat syscalls
    [PATCH] sparc: Fix PTRACE_CONT bogosity
    [RTNETLINK]: Add comma to final entry in link_rtnetlink_table

Eugene Surovegin:
    [PATCH] ppc32: ppc4xx_pic - add acknowledge when enabling level-sensitive IRQ

Flavio Leitner:
    [PATCH] pl2303 - status line
    [PATCH] pl2303 - unplug device.

Geert Uytterhoeven:
    [PATCH] M68k: Update defconfigs for 2.6.11
    [PATCH] M68k: Update defconfigs for 2.6.12-rc2

Giovambattista Pulcini:
    [PATCH] ppc32: Fix a problem with NTP on !(chrp||gemini)

Greg KH:
    [PATCH] USB: fix up some sparse warnings about static functions that aren't static.

Hal Rosenstock:
    [PATCH] IB: Remove incorrect comments
    [PATCH] IB: remove unneeded includes
    [PATCH] IPoIB: set skb->mac.raw on receive

Herbert Xu:
    [ATALK]: Add missing dev_hold() to atrtr_create().
    [IPSEC]: COW skb header in UDP decap
    [IPV6]: IPV6_CHECKSUM socket option can corrupt kernel memory
    [IPV6]: Replace bogus instances of inet->recverr
    [NET]: Shave sizeof(ptr) bytes off dst_entry
    [PATCH] Fix dst_destroy() race

Horms:
    [PATCH] Maintainers list update: linux-net -> netdev

Hugh Dickins:
    [PATCH] freepgt: arch FIRST_USER_ADDRESS 0
    [PATCH] freepgt: arm FIRST_USER_ADDRESS PAGE_SIZE
    [PATCH] freepgt: arm26 FIRST_USER_ADDRESS PAGE_SIZE
    [PATCH] freepgt: free_pgtables from FIRST_USER_ADDRESS
    [PATCH] freepgt: free_pgtables use vma list
    [PATCH] freepgt: hugetlb area is clean
    [PATCH] freepgt: hugetlb_free_pgd_range
    [PATCH] freepgt: mpnt to vma cleanup
    [PATCH] freepgt: remove FIRST_USER_ADDRESS hack
    [PATCH] freepgt: remove MM_VM_SIZE(mm)
    [PATCH] freepgt: remove arch pgd_addr_end
    [PATCH] freepgt: sys_mincore ignore FIRST_USER_PGD_NR

Ingo Molnar:
    [PATCH] sched: fix signed comparisons of long long

James Bottomley:
    [PATCH] add Big Endian variants of ioread/iowrite
    [PATCH] re-export cancel_rearming_delayed_workqueue
    fully merge up to scsi-misc-2.6
    merge by hand (scsi_device.h)

James Morris:
    [PATCH] SELinux: add support for NETLINK_KOBJECT_UEVENT
    [PATCH] SELinux: fix bug in Netlink message type detection

Jan Kara:
    [PATCH] quota: fix possible oops on quotaoff

Jason Davis:
    [PATCH] x86_64 genapic update

Jason Gaston:
    [PATCH] ahci: AHCI mode SATA patch for Intel ESB2
    [PATCH] ata_piix: IDE mode SATA patch for Intel ESB2
    [PATCH] i2c-i801: I2C patch for Intel ESB2
    [PATCH] intel8x0: AC'97 audio patch for Intel ESB2
    [PATCH] irq and pci_ids: patch for Intel ESB2
    [PATCH] piix: IDE PATA patch for Intel ESB2

Jean Delvare:
    [PATCH] I2C: Fix incorrect sysfs file permissions in it87 and via686a drivers
    [PATCH] I2C: via686a cleanups

Jean Tourrilhes:
    [PATCH] irda_device() oops fix

Jeff Moyer:
    [PATCH] filemap_getpage can block when MAP_NONBLOCK specified

Jens Axboe:
    [PATCH] fix NMI lockup with CFQ scheduler
    [PATCH] possible use-after-free of bio

Jesper Juhl:
    [PATCH] USB: kfree cleanup for drivers/usb/* - no need to check for NULL
    [PATCH] usb: kfree() cleanups in drivers/usb/core/devio.c

Jurij Smakov:
    [PATCH] sparc64: Fix copy_sigingo_to_user32()

Kay Sievers:
    [PATCH] sysfs: add sysfs_chmod_file()

Ken Chen:
    [PATCH] use cheaper elv_queue_empty when unplug a device

Kumar Gala:
    [PATCH] ppc32: Allow adjust of pfn offset in pte
    [PATCH] ppc32: Fix pte_update for 64-bit PTEs
    [PATCH] ppc32: Support 36-bit physical addressing on e500
    [PATCH] ppc32: make usage of CONFIG_PTE_64BIT & CONFIG_PHYS_64BIT consistent

Larry Battraw:
    [PATCH] USB: visor Tapwave Zodiac support patch

Leigh Brown:
    [PATCH] ppc32: Make the Powerstack II Pro4000 boot again

Lennert Buytenhek:
    [PATCH] pci enumeration on ixp2000: overflow in kernel/resource.c

Libor Michalek:
    [PATCH] IB: Trivial FMR printk cleanup

Linus Torvalds:
    Fix up some file mode differences due to the new git world order.
    Linux v2.6.12-rc3
    Linux-2.6.12-rc2
    Merge SCSI tree from James Bottomley.
    Merge master.kernel.org:/pub/scm/linux/kernel/git/gregkh/i2c-2.6.git/
    Merge with Greg's USB tree at kernel.org:/pub/scm/linux/kernel/git/gregkh/usb-2.6.git/
    Merge with kernel.org:/pub/scm/linux/kernel/git/gregkh/aoe-2.6.git/
    Merge with kernel.org:/pub/scm/linux/kernel/git/gregkh/driver-2.6.git/
    Merge with master.kernel.org:/home/rmk/linux-2.6-rmk.git
    Merge with master.kernel.org:/home/rmk/linux-2.6-rmk.git - ARM changes

Magnus Damm:
    [PATCH] opl3sa2: MODULE_PARM_DESC

Martin Hicks:
    [PATCH] meminfo: add Cached underflow check

Matt Mackall:
    [PATCH] update maintainer for /dev/random

Michael S. Tsirkin:
    [PATCH] IB/mthca: add SYNC_TPT firmware command
    [PATCH] IB/mthca: add fast memory region implementation
    [PATCH] IB/mthca: add mthca_table_find() function
    [PATCH] IB/mthca: add mthca_write64_raw() for writing to MTT table directly
    [PATCH] IB/mthca: allow unaligned memory regions
    [PATCH] IB/mthca: encapsulate MTT buddy allocator
    [PATCH] IB/mthca: fill in opcode field for send completions
    [PATCH] IB/mthca: fix MR allocation error path
    [PATCH] IB/mthca: split MR key munging routines

Michal Ostrowski:
    [PATCH] debugfs: fix !debugfs prototypes

Neil Brown:
    [PATCH] Avoid deadlock in sync_page_io by using GFP_NOIO
    [PATCH] md: close a small race in md thread deregistration
    [PATCH] md: remove a number of misleading calls to MD_BUG
    [PATCH] nfsd4: callback create rpc client returns
    [PATCH] nfsd4: fix struct file leak
    [PATCH] nfsd: clear signals before exiting the nfsd() thread

Nishanth Aravamudan:
    [PATCH] USB: usb/digi_acceleport: correct wait-queue state

Niu YaWei:
    [PATCH] quota: possible bug in quota format v2 support

Olof Johansson:
    [PATCH] ppc64: no prefetch for NULL pointers

Paolo 'Blaisorblade' Giarrusso:
    [PATCH] uml: fix compilation for __CHOOSE_MODE addition

Paul E. McKenney:
    [PATCH] Fix comment in list.h that refers to nonexistent API

Paul Mackerras:
    [PATCH] ppc32: fix bogosity in process-freezing code
    [PATCH] ppc32: fix single-stepping of emulated instructions
    [PATCH] ppc32: improve timebase sync for SMP
    [PATCH] ppc32: oops on kernel altivec assist exceptions
    [PATCH] ppc64: fix export of wrong symbol

Pavel Machek:
    [PATCH] Fix u32 vs. pm_message_t in drivers/char
    [PATCH] Fix u32 vs. pm_message_t in x86-64
    [PATCH] USB: fix up remaining pm_message_t usages
    [PATCH] fix few remaining u32 vs. pm_message_t problems
    [PATCH] fix pm_message_t vs. u32 in alsa
    [PATCH] fix u32 vs. pm_message_t in PCI, PCIE
    [PATCH] fix u32 vs. pm_message_t in driver/video
    [PATCH] fix u32 vs. pm_message_t in drivers/
    [PATCH] fix u32 vs. pm_message_t in drivers/macintosh
    [PATCH] fix u32 vs. pm_message_t in drivers/media
    [PATCH] fix u32 vs. pm_message_t in drivers/message
    [PATCH] fix u32 vs. pm_message_t in drivers/mmc,mtd,scsi
    [PATCH] fix u32 vs. pm_message_t in pcmcia
    [PATCH] fix u32 vs. pm_message_t in rest of the tree
    [PATCH] pm_message_t: more fixes in common and i386
    [PATCH] power/video.txt: update documentation with more systems
    [PATCH] u32 vs. pm_message_t fixes for drivers/net
    [PATCH] u32 vs. pm_message_t in ppc and radeon

Peter Favrholdt:
    [PATCH] USB: pl2303 new vendor/model ids

Phil Dibowitz:
    [PATCH] Fix GO_SLOW delay

Randy.Dunlap:
    [PATCH] Add dontdiff file

Robert Schwebel:
    [PATCH] export platform_add_devices

Roland Dreier:
    [PATCH] IB/mthca: add support for new MT25204 HCA
    [PATCH] IB/mthca: allocate correct number of doorbell pages
    [PATCH] IB/mthca: allow address handle creation in interrupt context
    [PATCH] IB/mthca: clean up mthca_dereg_mr()
    [PATCH] IB/mthca: encapsulate mem-free check into mthca_is_memfree()
    [PATCH] IB/mthca: fill in more device query fields
    [PATCH] IB/mthca: fix MTT allocation in mem-free mode
    [PATCH] IB/mthca: fix calculation of RDB shift
    [PATCH] IB/mthca: fix format of CQ number for CQ events
    [PATCH] IB/mthca: fix posting sends with immediate data
    [PATCH] IB/mthca: implement RDMA/atomic operations for mem-free mode
    [PATCH] IB/mthca: map MPT/MTT context in mem-free mode
    [PATCH] IB/mthca: map context for RDMA responder in mem-free mode
    [PATCH] IB/mthca: only free doorbell records in mem-free mode
    [PATCH] IB/mthca: print assigned IRQ when interrupt test fails
    [PATCH] IB/mthca: release mutex on doorbell alloc error path
    [PATCH] IB/mthca: tweaks to mthca_cmd.c
    [PATCH] IB/mthca: update receive queue initialization for new HCAs
    [PATCH] IB: Fix FMR pool crash
    [PATCH] IB: Fix user MAD registrations with class 0
    [PATCH] IPoIB: convert to debugfs
    [PATCH] IPoIB: document conversion to debugfs
    [PATCH] IPoIB: fix static rate calculation
    [PATCH] debugfs: Reduce <linux/debugfs.h> dependencies
    [PATCH] drivers/infiniband/hw/mthca/mthca_main.c: remove an unused label

Roland McGrath:
    [PATCH] i386 vDSO: add PT_NOTE segment
    [PATCH] i386: Use loaddebug macro consistently
    [PATCH] x86-64: i386 vDSO: add PT_NOTE segment

Russell King:
    [PATCH] ARM: Add missing new file for bitops patch
    [PATCH] ARM: bitops
    [PATCH] ARM: fix debug macros
    [PATCH] ARM: footbridge rtc init
    [PATCH] ARM: h3600_irda_set_speed arguments
    [PATCH] ARM: showregs
    [PATCH] arm: fix floppy disk dependencies
    [PATCH] serial: fix comments in 8250.c

Sean Hefty:
    [PATCH] IB: Keep MAD work completion valid

Siddha, Suresh B:
    [PATCH] x86, x86_64: dual core proc-cpuinfo and sibling-map fix
    [PATCH] x86_64-always-use-cpuid-80000008-to-figure-out-mtrr fix

Stas Sergeev:
    [PATCH] fix crash in entry.S restore_all

Stephen Hemminger:
    [NET]: skbuff: remove old NET_CALLER macro

Stephen Smalley:
    [PATCH] SELinux: fix deadlock on dcache lock

Steven Cole:
    [PATCH] 2.6.12-rc1-mm3 Fix ver_linux script for no udev utils.

Thomas Graf:
    [RTNETLINK]: Protocol family wildcard dumping for routing rules

Thomas Winischhofer:
    [PATCH] USB: new SIS device id

Tom Rini:
    [PATCH] ppc32: Fix building 32bit kernel for 64bit machines
    [PATCH] ppc32: Fix mpc8xx watchdog

Viktor A. Danilov:
    [PATCH] USB: fix AIPTEK input doesn`t register `device` & `driver` section in sysfs (/sys/class/input/event#)

YOSHIFUJI Hideaki:
    [IPV6]: Fix a branch prediction

Yoichi Yuasa:
    [PATCH] mips: remove #include <linux/audit.h> two times
    [PATCH] mips: remove obsolete VR41xx RTC function from vr41xx.h
    [PATCH] mips: update VR41xx CPU-PCI bridge support

Yoshinori Sato:
    [PATCH] h8300 header update

aherrman@de.ibm.com:
    [PATCH] zfcp: convert to compat_ioctl

andrew.vasquez@qlogic.com:
    [PATCH] qla2xxx: add remote port codes...
    [PATCH] qla2xxx: cleanup DMA mappings...
    [PATCH] qla2xxx: remove /proc interface
    [PATCH] qla2xxx: remove internal queuing...
    [PATCH] qla2xxx: remove lun discovery codes...
    [PATCH] qla2xxx: remove sale revision notes file
    [PATCH] qla2xxx: update version to 8.00.02b5-k

bunk@stusta.de:
    [PATCH] drivers/scsi/gdth.c: cleanups

dougg@torque.net:
    [PATCH] sg.c: update

ecashin@coraid.com:
    [PATCH] aoe 1/12: remove too-low cap on minor number
    [PATCH] aoe 11/12: add support for disk statistics
    [PATCH] aoe 12/12: send outgoing packets in order
    [PATCH] aoe 2/12: allow multiple aoe devices with same MAC
    [PATCH] aoe 3/12: update driver version to 6
    [PATCH] aoe 4/12: handle distros that have a udev rules
    [PATCH] aoe 5/12: don't try to free null bufpool
    [PATCH] aoe 6/12: Alexey Dobriyan sparse cleanup
    [PATCH] aoe 8/12: document env var for specifying number
    [PATCH] aoe 9/12: add note about the need for deadlock-free sk_buff allocation

felix@derklecks.de:
    [PATCH] USB Storage unusual_dev.h 07c4:a10b Datafab Systems, Inc.

gregkh@suse.de:
    [PATCH] USB: add new visor id for Treo 650
    [PATCH] kref: add link to original documentation to the kref documentation.

hch@lst.de:
    [PATCH] consolidate timeout defintions in scsi.h
    [PATCH] consolidate timeout defintions in scsi.h
    [PATCH] kill old EH constants
    [PATCH] kill old EH constants
    [PATCH] remove old scsi data direction macros
    [PATCH] remove outdated print_* functions
    [PATCH] remove outdated print_* functions

htejun@gmail.com:
    [PATCH] scsi: remove meaningless scsi_cmnd->serial_number_at_timeout field
    [PATCH] scsi: remove meaningless scsi_cmnd->serial_number_at_timeout field
    [PATCH] scsi: remove unused scsi_cmnd->internal_timeout field
    [PATCH] scsi: remove unused scsi_cmnd->internal_timeout field
    [PATCH] scsi: remove volatile from scsi data
    [PATCH] scsi: scsi_send_eh_cmnd() cleanup

jejb@titanic.il.steeleye.com:
    [PATCH] finally fix 53c700 to use the generic iomem infrastructure
    [PATCH] Convert i2o to compat_ioctl
    [PATCH] Convert i2o to compat_ioctl
    aic7xxx: add support for the SPI transport class
    aic7xxx: convert to SPI transport class Domain Validation
    lpfc: add Emulex FC driver version 8.0.28
    qla2xxx: fix compiler warning in qla_attr.c
    scsi: add DID_REQUEUE to the error handling
    scsi: add DID_REQUEUE to the error handling
    updates for CFQ oops fix
    zfcp: add point-2-point support
    zfcp: add point-2-point support

johnpol@2ka.mipt.ru:
    [PATCH] w1: real fix for big endian machines.
    [PATCH] w1_smem: w1 ID is only 8 bytes long.

kay.sievers@vrfy.org:
    [PATCH] add TIMEOUT to firmware_class hotplug event
    [PATCH] kobject/hotplug split - block core
    [PATCH] kobject/hotplug split - class core
    [PATCH] kobject/hotplug split - devices core
    [PATCH] kobject/hotplug split - kobject add/remove
    [PATCH] kobject/hotplug split - net bridge
    [PATCH] kobject/hotplug split - usb cris

maximilian attems:
    [PATCH] efi: eliminate bad section references
    [PATCH] hd: eliminate bad section references
    [PATCH] pnpbios: eliminate bad section references

minyard@acm.org:
    [PATCH] kref: add documentation
