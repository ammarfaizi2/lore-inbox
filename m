Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262437AbTE0B4b (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 May 2003 21:56:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262431AbTE0B4b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 May 2003 21:56:31 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:59146 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id S262437AbTE0B4B convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 May 2003 21:56:01 -0400
Date: Mon, 26 May 2003 19:08:45 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Linux 2.5.70
Message-ID: <Pine.LNX.4.44.0305261903330.2164-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
X-MIME-Autoconverted: from 8bit to quoted-printable by deepthought.transmeta.com id h4R28jB04027
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Ok, 
 there's been too much delay between 69 and 70, but I was hoping to make 
70 the last "Linus only" release before getting together with Andrew and 
figuring out how to start the "pre-2.6" series and more of a code slush. 

Whatever. Th eend result is a pretty big patch, although a lot of it is
due to fairly minor patches. But it's a _lot_ of fairly minor patches, as
can be seen from the changelog (also, the acorn drivers got moved around,
which always makes for big patches).

		Linus


Summary of changes from v2.5.69 to v2.5.70
============================================

<lkml001:vrfy.org>:
  o USB: usb-skeleton compile fix

<olof:austin.ibm.com>:
  o [TCP]: tcp_twkill leaves death row list in inconsistent state over
    tcp_timewait_kill

<philipp:void.at>:
  o USB: unusual_devs.h patch

<willschm:us.ibm.com>:
  o add #ifdef CONFIG_XMON around a XMON variable reference
  o ppc64: add spinlock to chrp_progress
  o ppc64: restore hex progress code

Adrian Bunk:
  o USB: kill the last occurances of usb_serial_get_by_minor
  o [NET]: wireless.c needs module.h

Alan Stern:
  o USB: uhci Interrupt Latency fix
  o USB: Addition to previous patch needed for PM UHCI

Alex Williamson:
  o ia64: fix GENERIC build
  o ia64: small ACPI fix
  o ia64: fix timer interrupts getting lost
  o ia64: interrupt fixes/cleanup

Alexander Viro:
  o seq_path(), /proc/mounts and /proc/swaps
  o seq_path() for /proc/pid/maps
  o O_DIRECT open() fix
  o TIOCCONS fix
  o cpqarray fixes
  o pg.c macroectomy
  o pg.c Lindent
  o pg.c macroectomy - part 2
  o pt.c macroectomy
  o pt.c Lindent
  o switch blk_register_area() to kobject
  o register_chrdev_region() cleanup
  o kobj_map
  o cdev-cidr, part 1
  o i_cdev/i_cindex

Alexey Kuznetsov:
  o [ACENIC]: Comment out netif_wake_queue from acenic watchdog

Andi Kleen:
  o [NET]: Clean up socket filter compat handling
  o x86-64 merge
  o Make ACPI compile again on 64bit/gcc 3.3

Andrew Morton:
  o [NET]: Remove duplicated alloc_skb debug check
  o generic subarchitecture for ia32
  o Fix .altinstructions linking failures
  o cpia driver __exit fix
  o fix OSS opl3sa2 compilation
  o misc fixes
  o mwave build fix
  o drm timer initialisation fix
  o slab: initialisation cleanup and oops fix
  o sysrq-S, sysrq-U cleanups
  o s/UPDATE_ATIME/update_atime/ cleanup
  o irqreturn_t for drivers/net/pcmcia
  o keyboard.c Fix CONFIG_MAGIC_SYSRQ+PrintScreen
  o Don't use devfs names in disk_name()
  o devfs: API changes
  o remove partition_name()
  o switch most remaining drivers over to devfs_mk_bdev
  o dvbdev fixes
  o access_ok() race fix for 80386
  o hold i_sem on swapfiles
  o remove unnecessary PAE pgd set
  o account for slab reclaim in try_to_free_pages()
  o slab: additional debug checks
  o reduced overheads in fget/fput
  o allow i8042 interrupt sharing
  o select() speedup
  o Move security_d_instantiate hook calls
  o ext3 xattr handler for security modules
  o ext2 xattr handler for security modules
  o Change LSM hooks in setxattr
  o Work around include/linux/sunrpc/svc.h compilation
  o [netdrvr] remaining irqreturn_t changes
  o enable slab debugging for larger objects
  o Remove __verify_write leftovers
  o hrtimers: fix timer_create(2) && SIGEV_NONE
  o implement module_arch_cleanup() in all architectures
  o remove devfs_register
  o fix pnp_test_handler return
  o fat cluster search speedup
  o Fix for vma merging refcounting bug
  o Commented out printk causes change in program flow in
  o small cleanup for __rmqueue
  o export cpufreq_driver to fix oops in proc interface
  o Quota write transaction size fix
  o dquot_transfer() fix
  o Bump module ref during init
  o exit_mmap() TASK_SIZE fix
  o semop race fix
  o visws: fix penguin with sgi logo
  o fix for clusterd io_apics
  o provide user feedback for emergency sync and remount
  o copy_process return value fix
  o de_thread memory corruption fix
  o vmalloc race fix
  o Reserve the ext2/ext3 EAs for the Lustre filesystem
  o Fix arch/i386/oprofile/init.c build error
  o Fix ext3 htree / NFS compatibility problems
  o htree nfs fix
  o ext3: htree memory leak fix
  o [NET]: netif_receive_skb() warning fix
  o [ATM]: Fix macro pasting in HE driver
  o USB: net2280 writel fix
  o [NET]: Fix sb1000.c build
  o ipmi warning fixes
  o sound/core comparison fix
  o pass the stack protection flags into put_dirty_page()
  o fix hugetlbpage scoping
  o DAC960 typedef cleanup patch
  o loop.c warning removal
  o mtrr warning fix
  o SMI clearing fix
  o Make debugging variant of spinlocks a bit more robust
  o fix lots of error-path memory leaks
  o miropcm20-rds.c build fix
  o synclink_cs update
  o remove some cruft from smp.h
  o >llseek returns loff_t, even for /dev/mem
  o visws: fix for generic-subarch
  o fix bug in drivers/net/cs89x0.c:set_mac_address()
  o Allow architecture to overwrite stack flags
  o [CRYPTO]: Fix memcpy/memset args
  o sysfs_create_link() fix
  o ia32 subarch circular dependency fix
  o genarch cpu_mask_to_apicid fix
  o [patch 4/29 voyager cpu_callout_map fix
  o ppp warning fix
  o misc fixes
  o large-dma_addr_t-PAE-only.patch
  o 3c59x irqreturn fix
  o reiserfs: allow multiple block insertion into the tree
  o reiserfs: reiserfs_file_write implementation
  o fix CONFIG_APM=m
  o Fix for latent bug in vmtruncate()
  o v4l: #1 - video-buf update
  o v4l: #2 - v4l1-compat update
  o v4l: #4 - bttv docmentation update
  o v4l: #5 - i2c module updates
  o v4l: #6 - tuner module update
  o v4l: #7 - saa7134 driver update
  o fix tuner.c and tda9887.c
  o radeonfb.c 64-bit fixes
  o use %p to print pointers in cs4281
  o memcpy/memset fixes
  o BUG() -> BUG_ON() conversions
  o 3c59x: add support for 3c905B-T4, 3C920B-EMB-WNM
  o CONFIG_ACPI_SLEEP compile fix
  o fix handling of spares physical APIC ids
  o put_page_testzero() fix
  o DAC960 oops fix
  o apply_alternatives() fix
  o sound/core/memalloc.c needs mm.h
  o revert sysfs non-fix
  o ppc64 update for do_fork() change
  o shrink_all_memory() fix
  o ppc64: 32/64bit emulation for aio
  o ppc64: Fix some PPC64 compile warnings
  o ppc64: PPC64 irq return fix
  o ppc64: Squash warning in ppc64 addnote tool
  o ppc64: Squash implicit declaration warning in ppc64
  o ppc64: do_signal32 warning fix
  o ppc64: Squash warning in ppc64 xics.c
  o ppc64: Unused variables in ppc64 prom.c
  o ppc64: build fix
  o ppc64: ioctl32 warning fix
  o ppc64: nail warnings in arch/ppc64/kernel/setup.c
  o ppc64: arch/ppc64/kernel/traps.c warning fixes
  o ppc64: more warning fixes
  o tty_io warning fix
  o siocdevprivate_ioctl warning fix
  o arch/i386/kernel/mpparse.c warning fixes
  o Fix dcache_lock/tasklist_lock ranking bug
  o APM does unsafe conditional set_cpus_allowed
  o reiserfs: inode attributes support
  o xirc2ps_cs irq return fix
  o Fix readdir error return value
  o Don't remove inode from hash until filesystem has
  o slab: account for reclaimable caches
  o mark shrinkable slabs as being reclaimable
  o Process Attribute API for Security Modules
  o Process Attribute API for Security Modules (fixlet)
  o /proc/pid inode security labels
  o CONFIG_FUTEX
  o CONFIG_EPOLL
  o devpts xattr handler for security labels
  o overcommit root margin
  o net/sunrpc/sunrpc_syms.c typo fix
  o add notify_count for de_thread
  o extend-check_valid_hugepage_range.patch
  o misc fixes
  o Documentation for disk iostats
  o Remove floating point use in cpia.c
  o rd.c: separate queue per disk
  o Better fix for ia32 subarch circular dependencies
  o fix drivers/net/ewrk.c memory leak
  o fix init/do_mounts_rd.c memory leak
  o two PNP memory leaks
  o Change mmu_gathers into per-cpu data
  o arch/i386/kernel/srat.c cast warning fix
  o ACPI constant overflow fixes
  o tulip warning fix
  o use update_mmu_cache() in install_page

Andries E. Brouwer:
  o namespace fix
  o NCR5380.c fix
  o fix oops in namespace.c
  o [NET]: Use ARRAY_SIZE where appropriate
  o namespace.c fix
  o change get_sb prototype
  o kill lvm from parisc
  o kill lvm from x86_64
  o some typos
  o kill ide-geometry
  o kill lvm from compat_ioctl.h

Andy Grover:
  o ACPI: Update to 20030424
  o ACPI: kobject fix (Greg KH) Here's a small patch that fixes the
    logic of the kobject creation and registration in the acpi code
    (since we use kobject_init(), we need to use kobject_add(), not
    kobject_register() to add the kobject to the kernel systems).
  o ACPI: Allow ":" in OS override string (Ducrot Bruno)
  o ACPI: Interpreter update to 20030509 Changed the subsystem
    initialization sequence to hold off installation of address space
    handlers until the hardware has been initialized and the system has
    entered ACPI mode.  This is because the installation of space
    handlers can cause _REG methods to be run.  Previously, the _REG
    methods could potentially be run before ACPI mode was enabled.
  o ACPI: Return only proper values (0 or 1) from our interrupt handler
    (Andrew Morton)
  o ACPI: Update Toshiba driver to 0.15 (John Belmonte)
  o ACPI: Do not reinit ACPI irq entry in ioapic (thanks to Stian
    Jordet)
  o ACPI: update to 20030522
  o ACPI: Allow multiple compatible IDs for PnP purposes

Anton Blanchard:
  o ppc64: add autofs ioctl and clean up a prototype
  o ppc64: xics cleanup
  o ppc64: clean up some cpu feature checks
  o ppc64: fix NR_syscalls slip up
  o ppc64: fix for recent module changes
  o ppc64: return ENOSYS for unknown IPC call
  o ppc64: Fix for outside of range sensor states, from John Rose
  o ppc64: segment misses from userspace must pass through
    do_page_fault
  o ppc64: use panic_on_oops sysctl
  o ppc64: use dma-window from deepest device tree node, from Dave
    Engebretsen
  o ppc64: chrp_progress() updates from Olof Johansson
  o ppc64: ethtool -e support, from Olof Johansson
  o ppc64: update ppc64 to new IRQ API from Andrew Morton
  o ppc64: fix some compile warnings, from Andrew Morton
  o ppc64: Fix some things that got backed out in the systemcfg merge
  o ppc64: Add loop_get_status64/loop_set_status64
  o ppc64: Andrew Morton is picking on me
  o ppc64: remove numa_node_exists, from Martin Bligh
  o ppc64: clear up the cpu<-> node mappings, and cache them, from Matt
    Dobson
  o ppc64: remove iomem_resource.end hack
  o Re: Make sym2 driver use pci_enable_device
  o ppc64: ioctl32 updates
  o ppc64: rework fast SLB miss handler castout code
  o ppc64: firmware flash fix from Olof Johansson
  o USB: gadget compile error on ppc64

Arnaldo Carvalho de Melo:
  o ipx headers: Coding Style code reformatting
  o list.h: implement list_for_each_entry_safe
  o ipx: convert ipx_interface handling to use list_head
  o ipx: convert ipx_route to use list_head
  o ipx: ipx_interfaces outlives struct sock/socket
  o wanrouter: add missing include module.h
  o [IPV4/IPV6]: Consolidate saddr resetting into inet_reset_saddr()
  o ipv4/ipv6: use ipv6_addr_copy where appropriate
  o ipv4/ipv6: call tcp_timewait_kill in tcp_tw_deschedule
  o af_netlink: netlink_proto_init has to be core_initcall
  o wanrouter: don't use typedefs for wan_device, just struct
    wan_device
  o wanrouter: kill netdevice_t, do as all the rest of the tree, use
    struct net_device
  o wan/cycx: typedef cleanup
  o wan/cycx: fix module refcounting, removing
    MOD_{INC,DEC}_USE_COUNT
  o wan/cycx: further cleanups
  o wan/cycx: remove more typedefs
  o wan/cycx: remove the last typedefs, some kernel doc comments
  o wan/cycx: use min_t and remove one more private MIN()
    implementation
  o ipx: remove debug message for successfull bind
  o ipx: move route functions to net/ipx/ipx_route.c
  o ipv6/route: fix .dst.metrics struct init for ip6_null_entry
  o ipv6/route: use C99 style init for struct init
  o ipv6/addrconf: use C99 struct init style for
    inet6_rtnetlink_table
  o ipv6/exthdrs: use C99 struct init style
  o ipv6/icmp: use C99 struct style init for tab_unreach
  o ipv6/ip6_fib: use C99 struct style init and move rt_sernum to
    .bss
  o wanrouter/wanproc: code cleanups
  o drivers/net/wan/sdla*: use SET_MODULE_OWNER at net_device setup
  o sock.h: kernel-doc style comment for struct sock
  o wan/cycx: remove unneeded ioctl stub and fix namespace
  o wanrouter/wanmain: fix namespace, fixing the current problem with
    device_shutdown
  o icmp: cleanups, use C99 array init style, etc

Arun Sharma:
  o ia64: make x86 shared programs work again
  o ia64: fix ia32 emulation of rlimit et al
  o ia64: fix sys32_select()

Bart De Schuymer:
  o [BRIDGE]: Change pkt_type to PACKET_HOST earlier
  o [BRIDGE]: Deal with non-linear SKBs in ebtables

Bartlomiej Zolnierkiewicz:
  o fix lost IDE interrupt problem
  o Fix incorrect enablebits for all AMD and nVidia IDE chipsets
  o Add IDE support for VIA vt8237 southbridge
  o Intel ICH5 basic SATA support
  o misc AMD IDE driver fixes
  o add hwif->hold flag
  o SiS IDE driver fixes
  o ServerWorks IDE driver update
  o add hwif->rw_disk callout
  o _IDE_C cleanup
  o IDE: fix "biostimings" and legacy chipsets' boot parameters
    interaction
  o Probe legacy IDE chipsets in ide_init() instead of in ide_setup()

Ben Collins:
  o USB: Happ UGCI added as BADPAD for workaround
  o Update IEEE1394 (r931)
  o A few more strlcpy's for drivers/base/
  o sound/* strncpy conversion
  o fs/* conversions for strlcpy
  o do_mounts.c strlcpy
  o Fix snd_seq_queue_find_name()
  o kernel/* strlcpy conversion
  o [NET]: strncpy -> strlcpy conversions
  o arch/* strlcpy conversion
  o drivers/* strlcpy conversions

Benjamin Herrenschmidt:
  o [SUNGEM]: Updates from PowerPC people
  o drivers/ide/ppc/pmac.c compile fix

Bjorn Helgaas:
  o ia64: sba_iommu workaround removal
  o ia64: sba_iommu vendor/function for unknown IOCs
  o ia64: sba_iommu trivial cleanup
  o ia64: multi-ioport space support
  o ia64: multi-ioport space support (part 2 of 4)
  o ia64: multi-ioport space support (part 3 of 4)
  o ia64: multi-ioport space support (part 3 of 4)
  o ia64: new IOC recognition
  o ia64: vendor-specific ACPI resource cleanup

Brian Gerst:
  o Fix ioperm bitmap
  o remove fake_sep_struct

Charles Fumuso:
  o [XFS] Merge over an irix fix

Chas Williams:
  o [ATM]: Fix excessive stack usage in iphase driver
  o [ATM]: svcs possible race with sigd
  o [ATM]: Fix foul up in lec driver
  o [ATM]: Add Forerunner HE support
  o [ATM]: Forward port br2864 to 2.5.x
  o [ATM]: Clip locking and more atmvcc cleanup
  o [ATM]: assorted atm patches
  o [ATM] remove iovcnt from atm_skb skbs has (and has had for a while)
    scatter/gather support making the scatter gather in atm redundant. 
    the current iovcnt schme really isnt being used anyway typically.  
    the atm layer will need a little more work in the future to take
    advantage of the skb scatter/gather support.  this patch removes
    the iovcnt dependencies and gets the check for non linear skbs
    right.
  o [ATM]: Kill stray ATM_PDU_OVHD reference in lec.c
  o [ATM]: Make he driver code more palatable
  o [ATM]: HE and IPHASE driver fixes
  o [ATM]: Make clip modular
  o [ATM]: Fix module handling in USB speedtouch driver
  o [ATM]: Add refcounting to atmdev
  o [ATM]: Allow ATM to be loaded as a module
  o [ATM]: Fix modular CLIP
  o [ATM]: Need to use try_module_get not __module_get

Chris Wright:
  o [RXRPC]: Put file_operations THIS_OWNER in correct place

Christoph Hellwig:
  o split private and public scsi headers
  o kill scsi_dump_status
  o kill pcmcia driver bind_info horror
  o use scsi_report_bus_reset() in scsi_erroc.c
  o fix scsi_debug compile warning
  o remove dead struct scsi_device members
  o remove dead scsi_cmnd members
  o scsi_requeuest_fn
  o move max_sectors intitalization fully to scsi_register
  o Re: unchecked_isa_dma on sparcv9
  o nuke some superflous externs
  o update NCR_D700 for new-style probing
  o remove scsi_device proc printing from drivers
  o move all host templates into .c files
  o remove scsi_slave_attach/scsi_slave_detach
  o first batch of shost sysfs fixes
  o rationalize scsi_queue_next & friends
  o [SLIP]: Move over to initcalls
  o [NET]: Switch x25_asy over to initcalls
  o some warning fixes
  o fix the aacraid merge a bit more
  o scsi_report_device_reset
  o consolidate devlist handling in a single file
  o switch sb1000 to new style net init & pnp
  o two more templates in headers
  o [XFS] merge Steve's sync changes over to 2.5
  o [XFS] avoid sleep_on in the sync code
  o [XFS] Fix compile warning on my iBook
  o [XFS] simplify memory allocation code big time
  o [XFS] Use __GFP_NORETRY in pagebuf readahead code
  o [NET]: Fix dev_load for !CONFIG_KMOD
  o [NET]: Switch comx over to initcalls
  o do_fork updates for ppc
  o [NET]: Clean up the divert ifdef mess
  o [NET]: Make dv_init an initcall
  o [NET]: Switch arcnet over to initcalls
  o [NET]: Convert madgemc to initcalls
  o make vt_ioctl ix86isms explicit
  o wireless pcmcia updates

Chuck Lever:
  o the recently-applied patch to fix the rpc_show_tasks() Oops is
    incomplete

Corey Minyard:
  o IPMI update

Daniel McNeil:
  o [IPV6]: Missing kmem_cache_destroy calls

Dave Jones:
  o [CPUFREQ] Fix powernow-k7 hang
  o [AGPGART] Hammer GART can use generic enable routines now
  o [AGPGART] intel agp init cleanups
  o [AGPGART] Remove unneeded enums from intel gart driver
  o [AGPGART] Remove unused ALi enums
  o [AGPGART] Remove stale comment
  o [AGPGART] Fix typo in via-agp. s/PM400/P4M400/
  o [AGPGART] Remove useless enums from serverworks gart driver
  o [AGPGART] Remove unneeded enums from AMD k7 gart driver
  o [AGPGART] More setup routine -> static struct conversions
  o [AGPGART] Replace enum users with own methods
  o [AGPGART] Merge NVIDIA nForce / nForce2 AGP driver
  o [AGPGART] Makefile cleanups
  o [AGPGART] Remove unneeded settings of bridge->type
  o [AGPGART] Add symbolic constants for AGP mode setting
  o [AGPGART] Add more defines to kill off hardcoded values
  o [AGPGART] Don't configure agp bridges more than once if there is >1
    of them
  o [AGPGART] use symbols instead of hardcoded values in generic-3.0
    Lots more work to do here.
  o [AGPGART] Convert several functions to return void
  o [AGPGART] Fall back to non-isochronous xfers if setting up
    isochronous xfers fails
  o [AGPGART] Fix typo that stopped nvidia GART driver being built
  o [AGPGART] EXPORT_SYMBOL cleanups. Also move the global_cache_flush
    routine to generic.c
  o [AGPGART] Move function description comments from headers to the
    code they document
  o [AGPGART] kdoc'ify some of the function header comments
  o [AGPGART] Move function prototypes to headers
  o [AGPGART] Misc backend source tidy up
  o [AGPGART] Remove semaphore abstraction
  o [AGPGART] i855PM support from Bill Nottingham
  o [AGPGART] Fix kconfig dependancies
  o [AGPGART] fix macros that expect agp_bridge in global scope From
    Christoph Hellwig
  o [AGPGART] cleanup agp backend.c a bit More from Christoph.
  o [AGPGART] Nvidia GART cleanups
  o [AGPGART] Add back dummy module exit to keep things happy
  o [AGPGART] don't dereference agp_bridge in generic-3.0.c Yet more
    from Christoph..
  o [AGPGART] give all agpgart drivers a ->remove pci method
  o [AGPGART] proper agp_bridge_driver
  o [AGPGART] Fix Kconfig typo
  o [AGPGART] Shrink chipset_type enum (compile fix) Missing part of
    hch's last cset.
  o [AGPGART] Fix linking error
  o [CPUFREQ] Acer Aspire's have broken PST tables in one BIOS rev. DMI
    blacklist it
  o [AGPGART] Add some debugging printk's. Based on Linus' earlier
    patch
  o [CPUFREQ] Remove not needed ;'s from macro definitions
  o [AGPGART] Bulletproofing. NULL ptrs after freeing them
  o [AGPGART] Remove duplicate code in i810/i830 alloc_by_type
    functions
  o [AGPGART] Fix incorrect type warning
  o [AGPGART] Move debugging macros to header so they can be used in
    other parts of agpgart
  o [AGPGART] more kconfig cleanups
  o [AGPGART] Kill off some typedefs
  o [AGPGART] missing %p in debug printk
  o [AGPGART] Turn on debugging printks for a while
  o [AGPGART] Intel I875P support
  o [AGPGART] Disable debugging printk's again
  o [AGPGART] Skip devices with no AGP headers sooner
  o [AGPGART] Store agp revision in agp_bridge struct
  o [AGPGART] Work around AMD 8151 errata
  o [AGPGART] Only enable isochronous transfers on AGP3.5 chipsets
  o [AGPGART] Remove unneeded exports
  o [AGPGART] Remove duplicate copying of ->chipset in agp_copy_info()
  o [AGPGART] death of generic-3.0.c  = folded into generic.c
  o [AGPGART] Add proper AGP3 initialisation routine
  o [AGPGART] Make sure we don't poke reserved bits when enabling agp
    v3
  o [AGPGART] Add missing #defines from last checkin
  o [AGPGART] Use symbolic defines for isoch registers in isoch code
  o [AGPGART] CodingStyle nitpicks for isoch.c
  o [AGPGART] Make the agp 3.5 use the agp3 code for enabling, leaving
    just the isoch stuff in isoch.c
  o [AGPGART] add checks to agp_copy_info() before dereferencing
  o [DRM] Intel i8xx DRM modules are dependant on their AGP
    counterparts
  o [CPUFREQ] missing export compile fix for powernow-k7
  o [AGPGART] PPC Uninorth support
  o [AGPGART] Move AGP PM to individual drivers
  o [AGPGART] Add printk's to error paths of agp_add_bridge
  o [AGPGART] Remove duplicated masking routines, replace with
    agp_generic_mask_memory()
  o [AGPGART] Whitespace/CodingStyle cleanups
  o [NETROM]: Fix netdevice leak, from 2.4.x
  o Fix types on inflate.c constants
  o Preemption fixes for x86 MSR driver
  o Avoid ide-scsi from starting DMA too soon
  o i8253 locking
  o sx memleak
  o Fix ISDN return types
  o Fix standards compliance bugs in the tty layer
  o pcwatchdog firmware memory leak
  o iphase fix
  o ASUS P4B SMBus quirks
  o typo
  o Fix pnpbios switch
  o copy_to_user check for sgiserial
  o fix module-init-tools ver_linux problem
  o Shorten rcu_check_quiescent_state
  o byte counters for mkiss
  o shorten rclan debug output
  o i810 no codec fix
  o shrink zonelists
  o [AGPGART] pci_driver structures must remain valid while they are
    registered
  o [AGPGART] nForce driver needs its own insert/remove routines
  o [AGPGART] Fix oops in VIA initialisation
  o [AGPGART] Add support for VIA K8T400M GART
  o [AGPGART] Improve Kconfig
  o [AGPGART] agp_3_5_enable() doesn't need mode parameter
  o [AGPGART] Sanity check (and fix up broken) AGP modes when in AGP
    3.0 mode
  o [AGPGART] Log broken applications that pass crap flags so they can
    be fixed
  o [AGPGART] Skip nonisoch setup if isoch setup was successful
  o [AGPGART] Silly typo that put tried to put things into a impossible
    x16 mode
  o [AGPGART] PPC compile fix
  o [AGPGART] Remove duplicated fast writes test
  o [AGPGART] sanity check printk's
  o [AGPGART] Rid AGP/DRM of more typedefs
  o [AGPGART] Make alpha AGP work again
  o Nuke stale comment from bmac
  o Age old cs89x0 register define 'fixes' ?
  o fix tlan 64bit check
  o xircom init cleanups
  o 3c505 printk levels
  o hamachi PCI DMA fix from 2.4
  o au1000 init cleanups

David Brownell:
  o USB: ehci i/o watchdog
  o USB Gadget API (1/6)
  o Net2280 driver (2/6)
  o USB "Gadget Zero" driver (3/6)
  o USB Ethernet Gadget (4/6)
  o USB Gadget string utility (5/6)
  o kbuild/kbuild for USB Gadgets (6/6)
  o USB: gadget cleanup of #ifdefs
  o USB: gadget zero, loopback config fix
  o USB gadget: net2280: dmachain off, zlp pio ok
  o more kbuild tweaks]
  o Fix big-endian USB gadget build
  o USB: rm debug printks in ehci and ohci
  o USB: fix for multiple definition of `usb_gadget_get_string'
  o USB: net2280 minor updates
  o USB: net2280, PPC fixes
  o USB: usbtest, talk to user mode "firmware"
  o USB: Fix machine lockup when unloading HC driver
  o USB: Fix machine lockup when unloading HC driver (part 2)
  o USB: SMP ehci-q.c 1010 BUG()
  o USB: disable usb device endpoints in more places
  o USB: bugfix endpoint state
  o USB: net2280, control requests can be deferred

David Jeffery:
  o ips 2.5 driver update [1/4] irq return update
  o ips 2.5 driver update [2/4] missing kfree and static init s
  o ips 2.5 driver update [3/4]: misc cleanups
  o ips 2.5 driver update [4/4]: use dev_printk

David Mosberger:
  o ia64: Fix typos/whitespace related to serial code
  o ia64: Patch by Alex Williamson: forward port of the 2.4 sba_iommu
  o ia64: Merge Alex Williamson's sba_iommu patch
  o ia64: Make sba_iommu get detected early enough again
  o ia64: Update platform INIT handler to print a backtrace
  o ia64: Export hp_acpi_csr_space() for modules
  o ia64: Consolidate backtrace printing in a single routine
    (ia64_do_show_stack())
  o ia64: Fix _raw_read_lock() to not switch text sections.  Tidy it up
    with the help of ia64_fetchadd() macro.  Ditto for
    _raw_read_unlock().
  o ia64: Patch by Arun Sharma: In brl_emu.c, a 64 bit value was being
    assigned to an int.
  o ia64: Improve spinlock code to handle contention in shared routine
    called with a special convention.  Various minor fixes for
    gcc-pre3.4.
  o ia64: Manual merge of Steve's spelling fixes
  o ia64: Manual merge of Bjorn Helgaas' sba_iommu patch to make it use
    seq_file
  o mca.c
  o ia64: Patch from Asit K. Mallick: fix a few places where
    last_fph_cpu wasn't updated and one place in the sigreturn path
    where the fph-owner wasn't set.
  o ia64: Prepare for GCC v3.4.  Sync with 2.5.69
  o ia64: Patch by John Marvin: Add virtual mem-map support
  o Add ia64 relocation types to elf.h and clean up

David S. Miller:
  o [NET]: Use dump_stack in neigh_destroy
  o [NET]: Fix typo in previous neighbour.c change
  o [ATM]: mpc.c warning fixes
  o [NETFILTER IPV6]: Fix warnings
  o USB speedtouch fix
  o [IPSEC]: Fix SADB_EALG_{3,}DESCBC values
  o [ATM]: Fix some CPP pasting in ambassador driver
  o [NETFILTER]: ip_nat_proto_{icmp,udp}.c need ip_nat_core.h
  o [IPV6]: Kill spurious module_{get,put}()
  o [BLUETOOTH]: Fix hci_usb build
  o [SPARC64]: Only use power interrupt when button property exists
  o [IPV6]: Remove illogical bug check in fib6_del
  o [IPV4/IPV6]: Set owner field in family ops
  o [ATM]: Fix build of HE driver
  o [IPV4]: Use time_{before,after}() and proper jiffies types in
    route.c
  o [IPV4]: Two minor errors in jiffies changes
  o [PKT_SCHED]: Kill iovcnt reference from sch_atm.c
  o [IPV4]: Fix expiration test in rt_check_expire
  o [MPLS]: Add ethernet protocol numbers
  o [NETFILTER]: Fix icmp_reply_translation args
  o [MPLS]: Add MPLS support to PPP
  o [SKFDDI]: Use SET_MODULE_OWNER
  o [IPV6]: Pass route attributes all the way down
  o [NETFILTER]: Fix ip_nat_core.c:manip_pkt return value checks
  o [XFRM]: Fix typos in xfrm_state_put() changes
  o [TCP]: NULL out newsk->owner in tcp_create_openreq_child()
  o [VLAN]: vlanproc.c needs module.h
  o [IPV4/IPV6]; Missing schedule_net() in inet{,6}_del_protocol
  o [NETFILTER]: Fix stale skb data pointer usage in ipv4 NAT
  o [IPV6]: Missing sk->family check in UDPv6 multicast handling
  o [BRLOCK]: Kill stray brlock.h references in sparc/sparc64 headers
  o [IPV6]: Fix two bugs in ip6_append_data changes
  o [NETFILTER]: ip_ct_gather_frags no longer needs to linearize
  o [PKT_SCHED]: sch_ingress.c does not need to linearize SKBs
  o [NETFILTER]: Teach ip_fw_compat and modules to handle non-linear
    SKBs
  o [IPV6]: Check output fragmentation using dst_pmtu not dev->mtu
  o [AIC7XXX]: Only build in biosparam function if actually used
  o [IPV6]: Fix ipv6_addr_copy warning in ah6.c
  o [SPARC64]: Update defconfig
  o [AF_KEY]: Force km.state to XFRM_STATE_DEAD in pfkey_msg2xfrm_state
  o [RTNETLINK]: extern __inline__ --> static inline
  o [TCP]: extern __inline__ --> static inline where appropriate
  o [IPV6]: extern __inline__ --> static inline
  o [IPV4]: Fix ip_finish_output extern decl
  o [AX25]: extern inline --> static inline
  o [NET]: dev_load extern inline --> static inline
  o [APPLETALK]: extern inline --> static inline
  o [PKT_SCHED]: extern inline --> static inline
  o [AF_UNIX]: extern inline --> static inline
  o [SUNHME]: Use PCI config space if hm-rev property does not exist
  o [NET]: Split out policy flow cache to be a generic facility
  o [ATM]: common.c needs linux/init.h
  o [ATM]: atm{pvc,svc}_exit cannot be __exit
  o [NET]: Regenerate flow cache hash rnd more sanely
  o [NET]: Hoplimit is a metric not a route attribute
  o [IPV4]: Respect hoplimit route metric
  o [NETFILTER]: Move skb_ip_make_writable symbol export
  o [IPV4]: Flush routing cache on sysctl_ip_default_ttl changes
  o [SPARC{32,64}]: Adjust for changed do_fork return value
  o [NET]: Fix netdevice unregister races
  o [NET]: More device register/unregister fixing
  o [NET]: Fix sock_fprog setsockopt compat handling.  Based upon patch
    from Andi Kleen
  o [NET]: Comment typo in net/core/dev.c, thanks akpm
  o [IPV4]: Fix route copying during redirects
  o [NET]: Use irqreturn_t in acenic driver
  o [NET]: Fix build warning in ns83820 driver
  o [NET]: Fix typo in ns83820 sysfs changes
  o [ATM]: Fix build after netdev sysfs changes
  o [NETFILTER]: Use proper printf format for size_t in ipt_owner.c
  o [NETFILTER]: Update ipt_physdev.c for match arg changes
  o [IPV6]: DST entry leak found by stanford checker
  o [IPV6]: Memory leak found by stanford checker
  o [NET]: In dst_alloc, do not assume layout of atomic_t
  o [IPV6]: Dont store pointers to in6_addrs in struct flowi
  o [IPV4]: Fix fib_hash performance problems with huge route tables
  o [NET]: Zap non-netdevice usage of SET_MODULE_OWNER
  o [TCP]: Move TCP_TWKILL_foo macro definitions into tcp_minisocks.c
  o [NET]: Kill SMP_TIMER_* users
  o [TIMERS]: No more SMP_TIMER_* users, kill it
  o [SPARC64]: Offer isdn/irda/telephony config options
  o [IRDA]: Protect IDA dma stuff with CONFIG_ISA
  o [SPARC64]: Update defconfig
  o [NET]: Invoke netdev_unregister_sysfs() outside of RTNL semaphore
  o [IPV4]: Use get_order instead of reimplementation
  o [FUTEX]: Fix kernel/compat.c after requeueing futex changes
  o [FUTEX]: Fix kernel/futex.c warning on 64-bit

Dean Gaudet:
  o better ali1563 integrated ethernet support

Douglas Gilbert:
  o blk SCSI_IOCTL_SEND_COMMAND

Duncan Sands:
  o USB speedtouch: replace yield()
  o USB speedtouch: add defensive memory barriers
  o USB speedtouch: remove stale code
  o USB speedtouch: spin_lock_irqsave -> spin_lock_irq in process
    context
  o USB speedtouch: spin_lock_irqsave -> spin_lock_irq in tasklets
  o USB speedtouch: remove useless NULL pointer checks
  o USB speedtouch: receive path micro optimization
  o USB speedtouch: verbose debugging
  o USB speedtouch: trivial whitespace and name changes
  o USB speedtouch: replace yield()
  o USB speedtouch: add defensive memory barriers
  o USB speedtouch: spin_lock_irqsave -> spin_lock_irq in process
    context
  o USB speedtouch: spin_lock_irqsave -> spin_lock_irq in tasklets
  o USB speedtouch: verbose debugging
  o USB speedtouch: remove stale code
  o USB speedtouch: use optimally sized reconstruction buffers
  o USB speedtouch: send path micro optimizations
  o USB speedtouch: kfree_skb -> dev_kfree_skb
  o USB speedtouch: remove useless NULL pointer checks
  o USB speedtouch: receive path micro optimization
  o USB speedtouch: receive code rewrite
  o USB speedtouch: set owner fields

Ernie Petrides:
  o ia64: fixes for semtimedop() ia32-compat handling

François Romieu:
  o USB: patch to fix up coding style violations

Geert Uytterhoeven:
  o USB: Big endian RTL8150
  o M68k IRQ API updates [1-20]
  o Ataflop fix
  o Atari Atyfb fixes
  o times must be unsigned long
  o M68k kill ide_ioreg_t
  o M68k pte_file
  o hosts.c missing config.h
  o M68k sys_ipc ENOSYS
  o m68k ptrace
  o dmasound resurrection
  o M68k IDE
  o IDE iops clean ups
  o Amifb updates
  o M68k raw I/O updates
  o Q40/Q60 IDE
  o HAVE_ARCH_GET_SIGNAL_TO_DELIVER warning
  o M68k wd33c93_{abort,host_reset}()
  o Atafb bug in #if 0 code
  o Obsolete include/asm-ppc/linux_logo.h

Gerd Knorr:
  o i2c #1/3: listify i2c core
  o i2c #2/3: add i2c_clients_command
  o i2c #3/3: add class field to i2c_adapter

Greg Kroah-Hartman:
  o i2c: fix oops on startup of it87 driver
  o i2c: fix up the MAINTAINERS i2c entry
  o USB: replace kdev_t with int in usb_interface structure, as only
    drivers with the USB major use it
  o Cset exclude:
    linux-usb@gemeinhardt.info|ChangeSet|20030429230539|30870
  o USB: vicam: fix bugs in writing to proc files that were found by
    the CHECKER project
  o PCI Hotplug: fix up the compaq driver to work properly again
  o PCI Hotplug: fix up the ibm driver to work properly again
  o PCI Hotplug: fix compiler warning in ibm driver
  o PCI Hotplug: fix up the acpi driver to work properly again
  o PCI Hotplug: fix dependancies for CONFIG_HOTPLUG_PCI_ACPI
  o PCI Hotplug: export the acpi_resource_to_address64 function, as the
    acpi pci hotplug driver needs it
  o i2c: fix compile error due to previous patches
  o USB: add usb class support for usb drivers that use the USB major
  o USB: converted usblp over to new usb_register_dev() changes
  o USB: converted mdc800 over to new usb_register_dev() changes
  o USB: converted scanner over to new usb_register_dev() changes
  o USB: converted dabusb over to new usb_register_dev() changes
  o USB: converted auerswald over to new usb_register_dev() changes
  o USB: converted brlvger over to new usb_register_dev() changes
  o USB: converted rio500 over to new usb_register_dev() changes
  o USB: converted usblcd over to new usb_register_dev() changes
  o USB: converted usb-skeleton over to new usb_register_dev() changes
  o USB: remove #include <linux/devfs_fs_kernel.h> from some drivers
    that do not need it
  o USB: converted hiddev over to new usb_register_dev() changes
  o USB: update my copyrights in a few locations
  o TTY: add tty class support for all tty devices
  o TTY: changes based on tty_register_device() paramater change
  o TTY: remove usb-serial sysfs dev file as it is now redundant
  o TTY: fix up lost devfs_mk_cdev change
  o USB: change core to use devfs_mk_cdev() instead of devfs_register()
  o USB: fix up compile error in tiglusb driver due to devfs_mk_cdev()
    changes
  o TTY: add lock to tty_dev_list, and handle tty names with more than
    one '/'
  o i2c: add i2c_adapter class support
  o i2c: register the i2c_adapter_driver so things link up properly in
    sysfs
  o driver core: Add driver symlink to class devices in sysfs
  o driver core: remove unneeded line in class code
  o i2c: piix4 driver: turn common error message to a debug level and
    rename the sysfs driver name
  o USB: fix jiffies warning in uss720.c
  o USB: fix break control for pl2303 driver
  o i2c: fix up i2c-dev driver based on previous core changes
  o USB: speedtch merge fixups by hand
  o PCI: add pci_get_dev() and pci_put_dev()
  o PCI: remove pci_insert_device() as no one uses it anymore

Greg Ungerer:
  o return valid vma from get_user_pages for non-MMU systems
  o fix cache settings for m68knommu 5407 CLEOPATRA target
  o fix cache settings for m68knommu 5407 MOTOROLA target
  o fix ColdFire 5407 cache flushing
  o add dummy VMALLOC_ defines to m68knommu
  o update m68knommu link script with 5282 support
  o update m68knommu defconfig
  o lock xtime struct in m68knommu/ColdFire timers
  o calculate microsecond offsets for m68knommu/ColdFire timers
  o m68knommu check timer irq pending
  o m68knommu: add configuration options for ColdFire 5282 support
  o m68knommu: ColdFire 5282 support Makefile changes
  o m68knommu: add ColdFire 5282 support setup
  o moew ColdFire 5282 support
  o add m68knommu/5282 specific Makefile
  o add m68knommu/5282 config init code
  o add m68knommu/5282 start up code
  o create SIM header definitions for ColdFire 5282
  o include SIM header for ColdFire 5282
  o add support for the DMA of the ColdFire 5282
  o create header support for the ColdFire 5282 PIT timer
  o add pit timer for m68knommu/5282 CPU support
  o rework timer code used for different m68knommu/ColdFire CPU's
  o add support for 5282 ColdFire to the ColdFire serial header
  o ColdFire serial driver support for 5282 ColdFire
  o allow FEC driver config to be used with ColdFire 5282
  o FEC driver updates to support the ColdFire 5282 CPU (header)
  o remove crt0_fixed.S from m68knommu DragonEngine2 target
  o fix m68knommu DragonEngine2 target setup code
  o remove crt0_himem.S from m68knommu DragonEngine2 target
  o single start file for m68knommu DragonEngine2 target
  o remove crt0_rom.S from m68knommu DragonEngine2 target
  o configure boot params for m68knommu
  o make common m68knommu/68328 specific ints.c
  o don't call 68328 specific int setup
  o don't call 68328 specific int setup (in 68VZ328)

Hanna V. Linder:
  o patch: remove unnecessary proc stuff from controller struct
  o tc_zs tty_driver add .owner field remove MOD_INC/DEC_USE_COUNT
  o specialix tty_driver add .owner field remove MOD_INC/DEC_USE_COUNT
  o stallion tty_driver add .owner field remove MOD_INC/DEC_USE_COUNT
  o serial_tx3912  tty_driver add .owner field remove
    MOD_INC/DEC_USE_COUNT
  o sh-sci tty_driver add .owner field remove MOD_INC/DEC_USE_COUNT
  o ser_a2232 tty_driver add .owner field remove MOD_INC/DEC_USE_COUNT
  o serial167 tty_driver add .owner field remove MOD_INC/DEC_USE_COUNT
  o rocket tty_driver add .owner field remove MOD_INC/DEC_USE_COUNT
  o sgi/char/sgiserial tty_driver add .owner field remove
    MOD_INC/DEC_USE_COUNT
  o rio  tty_driver add .owner field remove MOD_INC/DEC_USE_COUNT
  o riscom8 tty_driver add .owner field remove MOD_INC/DEC_USE_COUNT
  o pcxx tty_driver add .owner field remove MOD_INC/DEC_USE_COUNT
  o mxser tty_driver add .owner field remove MOD_INC/DEC_USE_COUNT
  o istallion  tty_driver add .owner field remove MOD_INC/DEC_USE_COUNT
  o moxa tty_driver add .owner field remove MOD_INC/DEC_USE_COUNT
  o ip2main tty_driver add .owner field remove MOD_INC/DEC_USE_COUNT
  o isicom tty_driver add .owner field remove MOD_INC/DEC_USE_COUNT
  o esp  tty_driver add .owner field remove MOD_INC/DEC_USE_COUNT
  o hvc_console tty_driver add .owner field remove
    MOD_INC/DEC_USE_COUNT
  o dz tty_driver add .owner field remove MOD_INC/DEC_USE_COUNT
  o cyclades tty_driver add .owner field remove MOD_INC/DEC_USE_COUNT
  o amiserial tty_driver add .owner field remove MOD_INC/DEC_USE_COUNT
  o macintosh/macserial  tty_driver add .owner field remove
    MOD_INC/DEC_USE_COUNT
  o isdn/capi  tty_driver add .owner field remove MOD_INC/DEC_USE_COUNT
  o vme_scc tty_driver add .owner field remove MOD_INC/DEC_USE_COUNT

Heiko Carstens:
  o set data direction in sd_synchronize_cache in sd.c

Herbert Xu:
  o [AF_KEY]: Zero out sadb_prop_reserved
  o [XFRM_USER]: Add XFRM_MSG_UPDPOLICY, analogue of SADB_X_SPDUPDATE

Hideaki Yoshifuji:
  o [IPV6]: Fix offset in ICMPV6_HDR_FIELD messages
  o [IPV^]: Use correct icmp6 type in ip6_pkt_discard
  o [MAINTAINERS/CREDITS]: Add entries for USAGI hackers
  o [IPV6]: Convert /proc/net/raw6 to seq_file
  o [NET]: Set file_operations->owner as appropriate
  o [NET]: nonet.c needs module.h
  o [IPV6]: ARCnet support, driver side
  o [IPV6]: ARCnet support, protocol side
  o [IPV6]: Fix RFC number in ipcomp6.c
  o [NET]: Misplaced description in ip-sysctl.txt
  o [IPV6]: Move NIP6 macro into general header
  o [IPV6]: Update RFC references
  o [IPV6]: Remove obsolete declaration in transp_v6.h
  o [IPV4]: Use seq_release_private(), kill ip_seq_release() since no
    longer used
  o [IPV4]: Dont erroneously print UDP6 sockets in /proc/net/udp
  o [IPV6]: procfs clean-up
  o [IPV4/6]: Common UDP procfs infrastructure
  o [IPV6]: Convert /proc/net/udp6 to seq_file
  o [IPV4/6]: Common TCP procfs infrastructure
  o [IPV6]: Convert /proc/net/tcp6 to seq_file

Ingo Molnar:
  o signal latency fixes
  o scheduler cleanup
  o sync wakeup on UP
  o Fix lost scheduler rebalances
  o fix do_fork() return value
  o support "requeueing" futexes
  o signal latency improvement

James Bottomley:
  o Fix NCR_D700 driver
  o Add .release template method to scsi_debug.c
  o fix syntax error in ncr53c8xx from hch conversion
  o fix missed conversion of to_scsi_host -> dev_to_shost in sim710
  o add missing asm/io.h to scsi/dc395x.c
  o Update aacraid to last drop on 2.4 from Alan Cox
  o Update aacraid from 2.4->2.5 semantics
  o sd.c spinup code can go into a wild loop
  o Correct typo in linux/scsi/scsi.h and introduce new
  o Fix thinko introduced into include/scsi/scsi.h
  o Fix use after free in scsi_host_put
  o do_fork fixes for voyager x86 subarch

James Morris:
  o [IPSEC]: Use xfrm_state_put in pfkey_msg2xfrm_state
  o [XFRM]: Make use of xfrm_state_hold()
  o [XFRM]: Use xfrm_pol_hold()
  o [IPSEC]: Implement proper IPIP tunnel handling for IPcomp
  o [CRYPTO]: Fix config dependencies
  o [IPV4]: Fix RFC number in ipcomp.c

James Simmons:
  o Console font size fix
  o Remove EDID parsing
  o Riva Framebuffer update
  o Framebuffer console fix

Jean Tourrilhes:
  o irq fixes for wavelan_cs/netwave_cs
  o Wireless Extension 16
  o WE-16 for Wavelan ISA driver
  o WE-16 for Wavelan Pcmcia driver
  o IrDA skb leak fixes
  o IrNET crasher
  o IrLAP address fix
  o owner in irtty-sir
  o Various IrDA drivers
  o irport fixes
  o smsc-ircc2 driver

Jeb J. Cramer:
  o TSO fix
  o Added ethtool test ioctl
  o Removed strong branded device ids
  o Added support for 82546 Quad-port adapter
  o Fixed LED coloring on 82541/82547 controllers
  o Miscellaneous code cleanup
  o Whitespace cleanup

Jeff Garzik:
  o [SCTP]: Fix missing Kconfig dependency
  o [bk] add useful tip to bk kernel howto
  o [netdvr tulip] nuke stale defines
  o [netdrvr bonding] add 802.3ad support
  o [netdrvr bonding] minor merge/kbuild fixes
  o [netdrvr tulip] fix bogus merges

Jeff Muizelaar:
  o [NET]: post-sysfs netdev cleanup

Jens Axboe:
  o bio_endio() increments bio->bi_sector
  o make MO drive work with ide-floppy/ide-cd
  o shrink deadline hash size
  o dynamic request allocation
  o bio walking code
  o ide minimum 48-bit support
  o remove ide-cd chatty errors
  o Fix scsi_ioctl command direction bits
  o ide tcq fixes
  o Always allocate sense buffer for block commands
  o elevator core update
  o bio splitting

John Levon:
  o OProfile: flush work queue on shutdown
  o OProfile: minimize sample error
  o OProfile: timer usage override
  o OProfile: fix stale comment
  o OProfile: fix d_path() usage

Jon Grimm:
  o [SCTP] Optimize SACK generation
  o [SCTP] Use Crypto API
  o [SCTP] Add wrappers for sctp with no crypto support
  o [SCTP] Various code cleanup
  o [SCTP] Enable SctpChecksumErrors stat
  o [SCTP] Add a generic csum_copy for sctp
  o [SCTP] short-circuit reassembly & ordering for best case
  o [SCTP]  Allow private to global association
  o [SCTP] Use GFP_ATOMIC, while we holding the local_addr_lock
  o [SCTP] Fix ipv6 addressing bug
  o [SCTP]  More typedef removals
  o [SCTP]  Track partially acked message for SEND_FAILED
  o [SCTP] Fix sctp_sendmsg error path when associate fails
  o [SCTP] Add some macros to clean up code
  o [SCTP]  Add SCTP_MAXSEG sockopt
  o [SCTP]  Add SFR-CACC support.  (Ardelle.Fan)
  o [SCTP] Fix regression in mark_missing.  (Ardelle.Fan)
  o [SCTP] Control chunk bundling
  o [SCTP] Make fragmented messages know how to SEND_FAIL themselves
  o [SCTP] Free up data chunks that don't get accepted by
    primitive_SEND
  o [SCTP] Add sinfo_timetolive support
  o [SCTP] Use put_user() in get_peer_addr_params (reported by
    yjf@standford.edu)
  o [SCTP] Support SCTP ECN on ipv6

Jonathan Corbet:
  o cpufreq class fix

Justin T. Gibbs:
  o Change the callback argument for aic brace option parsing to u_long
    to avoid casting problems with different architectures.
  o Aic7xxx and Aic79xx driver Update

Kazunori Miyazawa:
  o [IPV4]: Introduce ip6_append_data

Kochi Takayoshi:
  o ia64: don't waste irq vectors

Krishna Kumar:
  o [TCP]: Handle NLM_F_ACK in tcp_diag.c
  o [XFRM_USER]: Wrong use of RTM_BASE

Linus Torvalds:
  o Whee. Fix ancient mailing address
  o Make lib/inflate.c look remotely like ANSI C, so that it can be
    properly checked with the rest of the kernel.
  o Avoid using undefined preprocessor symbols: check CONFIG_MK7 with
    "defined()" rather than using it as a value.
  o Use "__attribute__" consistently
  o Allow external checkers to overrid the "cond_syscall()" macro
  o Support a "checking" mode for kernel builds, that runs a
    user-supplied source checker on all C files before compiling them.
  o Use the right CFLAGS for source checking. Fix grammar
  o Make aic7xxx driver use ANSI prototypes. My checker tool refuses to
    touch K&R C.
  o Annotate LDT system calls with user pointer annotations
  o Annotate x86 system calls with user pointer annotations
  o Fix mismatch between i387 user copy function declaration and
    definition.
  o Annotate IPC system calls with user pointer annotations
  o Annotate vm86_info as a pointer to user space
  o Bartlomiej says: 'Please revert this patch, it is unfinished.'
    We'll do it *after* IDE taskfile IO is done Cset exclude:
    axboe@suse.de|ChangeSet|20030511184946|49736
  o Use '#ifdef' to test for CONFIG_xxx variables, instead of depending
  o Add user pointer annotations
  o Use '#ifdef' to test for CONFIG_xxx variables, instead of depending
    on undefined preprocessor symbols evaluating to zero.
  o Add user pointer annotations to core sysctl files
  o Add user pointer annotations to socket, file IO and signal
    handling.
  o Add user pointer annotations to mtrr driver
  o Fix do_utimes() user pointer annotations
  o Make sys_open() declaration match definition
  o Don't use undefined preprocessor symbols in expressions
  o Remove extraneous NO_MATCH
  o Fix broken aic7xxx preprocessor conditional (that's not how C
    preprocessor expressions work, guys!)
  o Don't make the intel-AGP driver require an AGP capabilities
    pointer. The integrated graphics AGP things don't have one.
  o Add user pointer annotations to core filesystem routines
  o Make x86 user-copy have user pointer annotations to match
    declarations.
  o Add a few initial user pointer annotations to sound driver
  o Fix up thinko in nasty "NMI while debug while systenter" codepath.
  o Make request_module() take a printf-like vararg argument instead of
    a string
  o Use proper ANSI stype function declarations in definitions
  o Merge gamma driver from DRI CVS, and fix it up for 2.5.x changes
  o DRI CVS update
  o More files to ignore: mtools.conf
  o Make KOBJ_NAME_LEN bigger, since at least the ieee1394 code has bus
    ID's that are longer than 16 bytes.
  o Add 'strlcpy()' implementation
  o Make driver model use 'strlcpy()' to make sure that all names are
    NUL-terminated
  o Fix compile warning from Al's chardev cleanups
  o Make cdev infrastructure initialize early
  o Do a strlcat() to go with the strlcpy()
  o [NETLINK]: Use module_init() in netlink_dev.c
  o We need <linux/highmem.h> for PKMAP_BASE

Maksim Krasnyanskiy:
  o [Bluetooth] Add required infrastructure for socket module
    refcounting
  o [Bluetooth] L2CAP config req/rsp fixes
  o [Bluetooth] Detect and log error condition when first L2CAP
    fragment is too long
  o [Bluetooth] RFCOMM must wait for MSC exchange to complete before
    sending data

Manfred Spraul:
  o credits update

Marc Zyngier:
  o depca update (was Re: [Patch] DMA mapping API for Alpha)

Marcel Holtmann:
  o [Bluetooth] Compile fix for URB_ZERO_PACKET
  o [Bluetooth] Send the correct values in RPN response
  o [Bluetooth] Handle priority bits in parameter negotiation

Mark Haverkamp:
  o New aacraid driver fixed

Mark Hoffman:
  o i2c: Add SiS96x I2C/SMBus driver

Mark W. McClelland:
  o I2C: add more classes

Martin Schwidefsky:
  o s390: arch fixes
  o s390: inline assemblies
  o s390: module alias support
  o s390: steal lock support
  o s390: module count
  o s390: 31 bit compat
  o s390: block device drivers
  o s390: console device drivers
  o s390: tape device driver
  o s390: network device drivers

Matt Domsch:
  o Device Driver Dynamic PCI Device IDs
  o Shrink dynids feature set
  o PCI dynids - documentation fixes, id_table NULL check
  o pci.h whitespace cleanups
  o dynids: call driver_attach() when new IDs are added

Matt Porter:
  o PPC32: Allow lowmem size to be set even if we don't have HIGHMEM

Matthew Dharm:
  o USB: storage: generate BBB reset after abort
  o USB: storage: remove inline function

Matthew Wilcox:
  o [DLCI]: Use module_init and fix ioctl handling

Mikael Pettersson:
  o restore sysenter MSRs at APM resume

Mike Anderson:
  o scsi host sysfs support [1-4]
  o scsi_host sysfs updates scsi-misc-2.5 [1-2]
  o scsi_host sysfs updates fix release behaviour

Mitsuru Kanda:
  o [IPSEC]: Fix ipcomp header handling in ipv4 IPCOMP
  o [IPV6]: Add IPCOMP support
  o [CRYPTO]: Update deflate dependencies
  o [IPSEC]: Fix ipv4 ipcomp threshold calculation

Nathan Scott:
  o [XFS] Fix up error handling on the initial superblock read
  o [XFS] Fix up a pagebuf spelling mistake and a couple of whitespace
    botches
  o [XFS] V1 log tweak - fix log record length used when checking for a
    partial log record write during log recovery head/tail
    calculations.
  o [XFS] Large sector changes - fixup definition of xfs_agfl_t, and
    numerous changes to make log recovery respect the log device sector
    size.
  o [XFS] Small buftarg cleanup - keep code which pokes inside a
    buftarg all in
  o [XFS] Second part buftarg cleanup, don't poke inside a buftarg here
    anymore
  o [XFS] Remove a void* from the xfs_mount structure, move the log
    stripe mask field from the xfs_mount structure to the log structure
    (saves a couple
  o [XFS] Rationalise xlog_in_core2 definition, remove some ifdef
    __KERNEL__ code which is unnecessary in log recovery, clarify some
    recovery debug code.
  o [XFS] Make log recovery code style consistent with a/ itself and b/
    much of the rest of XFS.  Fix numerous crimes against whitespace.
  o [XFS] Fix two remaining indentation inconsistencies
  o [XFS] Remove some dead code

Neil Brown:
  o kNFSd: TCP nfsd connection hangs when partial record header is
    received
  o kNFSd: SVC sockets don't disable Nagle
  o kNFSd: RPC server need to know that TCP and UDP have different
    wspace functions
  o kNFSd: Set SOCK_NOSPACE when RPC server decides there is
    insufficient
  o kNFSd: Make sure an RPC socket is closed immediately when a server
    write fails
  o kNFSd: Fix #error message when bits are badly defined
  o kNFSd: Minor rearrangements in NFSv4 server code to prepare for
    mroe state management
  o kNFSd: NFSv4 open share state patch
  o kNFSd: Allow request for nfsv4 pseudo root to perform an upcall

Nicolas Dupeux:
  o USB: UNUSUAL_DEV for aiptek pocketcam

Nicolas Pitre:
  o [ARM PATCH] 1533/1: fix count when no preload support in copy_page
  o [ARM PATCH] 1531/1: optimized ffs/ffz/fls for ARMv5

Patrick Mansfield:
  o Compile fix for scsi_syms.c

Patrick McHardy:
  o [XFRM]: Fix typo in __xfrm4_find_acq
  o [NET]: Fix two bogus kfree(skb)

Patrick Mochel:
  o Driver model: doc updates
  o kobject: Add better debugging for failed registrations
  o sysfs: Rewrite binary file handling
  o kobject: Update Documentation
  o driver model: Set device's kset before calling kobject_add()
  o driver model: Define BUS_ID_SIZE based on KOBJ_NAME_LEN
  o driver model: Remove device_sem
  o driver model: Add resources to struct platform_device
  o driver model: Modify resource representation in struct
    platform_device

Paul Fulghum:
  o synclink update
  o n_hdlc update

Paul Mackerras:
  o i2c: i2c-keywest.c irq handler type
  o Update mesh.c and mac53c94.c drivers
  o [PPP]: Rest of compression module changes, oops
  o Update mac ethernet drivers
  o PPC32: Need to call wake_up_forked_process in SMP idle task setup
  o PPC32: Makefile cleanups, patch from Sam Ravnborg
  o PPC32: Further makefile updates from Sam Ravnborg
  o PPC32: Minor whitespace and ifdef fixes
  o PPC32: Better allocation of DMA-consistent memory on incoherent
    machines
  o PPC32: Fix the declaration of openpic_ipi_action()
  o PPC32: Use might_sleep() in kmap()
  o PPC32: More fixes for PCI on non-cache-coherent platforms
  o PPC32: Define a suitable value for PAGE_KERNEL_NOCACHE
  o Fix preempt on PPC32 - have to set PREEMPT_ACTIVE when preempting
    kernel stuff
  o PPC32: Export a couple of symbols needed by direct rendering
    modules
  o Fix mac adbhid driver
  o module owner for ppp_synctty.c
  o module refcounts for airport driver

Per Winkvist:
  o USB: more unusual_devs.h changes

Pete Zaitcev:
  o [SPARC]: Fix shadowing of global max_pfn, kill BOOTMEM_DEBUG
  o [SPARC]: Allow esp to use highmem_io on sparc32
  o [SPARC]: New compact show_regs format
  o [SPARC]: Keiths SMP patch #1
  o [SPARC]: Add ->release to ESP driver
  o [SPARC]: Update defconfig
  o [SPARC]: Sanitize BUG()
  o [SPARC]: Fix ptracing of syscalls
  o [SPARC]: Switch bitops to unsigned long

Peter Bergner:
  o Forward port of 2.4 ppc64 signal changes
  o Forward port of 2.4 ppc64 /proc/ppc64/systemcfg changes
  o Catch illegal FP use within the kernel since it can cause data
    integrity errors in userland code

Petr Vandrovec:
  o Fix potential runqueue deadlock

Randy Dunlap:
  o [NET]: Spelling/typo fixes in rtnetlink.h
  o [IPV6]: Convert /proc/net/rt6_stats to seq_file
  o [IPV6]: Fix typos in ip6_fib.c
  o [IPV6]: Use time_after() etc. for comparing jiffies
  o [IPV6]: Remove incorrect comment in ip6_fib.c

Richard Henderson:
  o [ALPHA] Fix titan_intr_nop for 2.5 irq api changes
  o [ALPHA] Fix single-step breakpoints
  o [ALPHA] Update for do_fork changes

Roland McGrath:
  o core dump psinfo.pr_sname letter fix

Roman Zippel:
  o kconfig check fixes

Russell King:
  o [ARM] Miscellaneous minor fixes
  o [PCMCIA] Add per-socket thread to process socket events
  o [ARM] Update a variety of ARM drivers to use irqreturn_t
  o [ARM] Allow CONFIG_PM to be enabled on all ARM platforms
  o [ARM PATCH] 1530/1: PXA2xx IRQ handling updates
  o [ARM] Fix timer interrupts to use irqreturn_t
  o [ARM] Add prefetch support for ARMv5
  o [ARM] Fix test_bit to return 0 or 1
  o [ARM] Remove static mappings for Integrator PS/2 ports
  o [ARM] switch ptrace to use an undefined instruction
  o [ARM] Convert more structure initialisers to C99 syntax
  o [ARM] Fix SA1100_ir irqreturn_t
  o [ARM] Fix RiscPC i2c drivers for device model
  o [ARM] Update Acorn platform scsi drivers
  o [ARM] Relocate ARM SCSI and Net drivers
  o [ARM] Update cyber2000fb.c
  o [ARM] Fixup yet another missing irqreturn_t
  o [ARM] Update Acorn IDE drivers
  o [ARM] Remove .devclass initialiser from sa1111ps2
  o [ARM] Fix time_after() warnings in ether1.c
  o [ARM] Fix DMA handler race condition
  o [ARM] do_fork() now returns the PID

Rusty Lynch:
  o PCI Hotplug: kernel-api docbook fix for now non-existant PCI
    hotplug

Rusty Russell:
  o [NETFILTER]: Fix Module Usage in ipchains and ipfwadm
  o [NETFILTER]: Make NAT code handle non-linear skbs
  o [NETFILTER]: Fix skb_checksum args in ip_nat_core.c
  o [NETFILTER]: Move ip_fw declarations into header file
  o [NETFILTER]: Move skb_ip_make_writable to netfilter.c
  o [NETFILTER]: Non-linear iptables: core code
  o [NETFILTER]: Linearize iptables matches
  o [NETFILTER]: Linearize iptables targets
  o [NETFILTER]: Make nat helper modules use symbols to force conntrack
    modules
  o [irda] module refcounts in irlan
  o const char* to char* update in console.h
  o reorganize for unreachable code
  o better debug macro safety
  o DMA-API typo
  o update the short description for BLK_DEV_HPT366
  o unreachable code in fs_intermezzo_methods.c
  o add help texts for sound_oss_Kconfig
  o remove unneeded #define LinuxVersionCode from eata.c
  o MAINTAINERS update for SN support
  o Remove unused GFP_DMA from include_sound_trident.h
  o unreachable code in drivers_media_video_cpia_pp.c
  o NAPI_HOWTO.txt typo + interrupt fix
  o Self-promotion and minor docs updates
  o missing release_region in drivers_cdrom_cm206.c
  o Better docs for boot-up code
  o proper APIC suspension
  o Allow for architectures to override
  o kernel_suspend.c compile warning
  o Make videodev_proc_destory() __exit
  o Cleanup in fs_devpts_inode.c
  o fs_autofs4_root.c unused variable
  o Typo in isofs_inode.c
  o sx tty_driver add .owner field remove MOD_INC_DEC_USE_COUNT

Sam Ravnborg:
  o Remove 'strchr' warning from reiserfs
  o kbuild: Get more focus on warnings

Scott Feldman:
  o Remove "Freeing alive device" warning
  o move e100_asf_enable under CONFIG_PM to avoid warning
  o Add ethtool parameter support
  o Add ethtool cable diag test
  o Add MDI/MDI-X status to ethtool reg dump
  o cleanup Tx resources before running ethtool diags
  o fixed stalled stats collection
  o VLAN configuration was lost after ethtool diags run
  o misc
  o full stop/start on ethtool set speed/duplex/autoneg

Seth Rohit:
  o ia64: enable 1G hugepage size for Mckinley

Sridhar Samudrala:
  o [SCTP] getsockname()/getpeername() support for TCP-style sockets
  o [SCTP] shutdown() support for TCP-style sockets
  o [SCTP] Handle accept() of a CLOSED association
  o [SCTP] Return a readable event when polling on a TCP-style
    listening socket with a non-empty accept queue.
  o [SCTP] sctp_sendmsg() updates for TCP-style sockets
  o [SCTP] Initialize missing ipv4 fields of a AF_INET6 accept socket
  o [SCTP] SO_LINGER socket option for TCP-style sockets
  o [SCTP] Use prepare_to_wait()/finish_wait() interfaces
  o net/socket: fix bug in sys_accept

Stefan Brandl:
  o USB: another usb storage addition

Stephen Hemminger:
  o [IPV4]: Replace explicit dev->refcount bumps with dev_hold
  o [NET]: Kill more direct references to netdev->refcnt
  o [SYSKONNECT]: /proc module handling fixup
  o [PKTGEN]: Module and dev cleanup
  o [IPV4/IPV6]: inetsw using RCU
  o [BRIDGE]: Bridge timer performance enhancement
  o [NET]: Network packet type using RCU
  o [BRLOCK]: Kill big reader locks, no longer used
  o [IPV4/IPV6]: synchronize_kernel --> synchronize_net
  o [NET]: Use SET_MODULE_OWNER in ns83820 driver
  o [NET]: sysfs support of network devices
  o [NET]: Add sysfs support to several net devices

Stephen Lord:
  o [XFS] Move xfs_syncd code into xfs_super.c which is the only place
    which uses it
  o [XFS] remove the excess ; which crept into the syncd thread
    somewhere and basically turned it off.

Steve French:
  o Fix cifs_show_options to display mount options in a way that is
    more consistent with other filesystems
  o Fix readlink of dfs junctions
  o Fix oops caused by lack of spinlock protection on some lists. Fix
    display

Steven Cole:
  o ia64: spelling fixes
  o Use '#ifdef' to test for CONFIG_xxx variables
  o more potentially undefined preprocessor symbols

Steven Whitehouse:
  o [DECNET]: Add netfilter subdir for decnet and add the routing
    grabulator
  o [FS]: Add seq_release_private and proc_net_fops_create helpers
  o [DECNET]: seq file conversions and fixes
  o [DECNET]: Decnet not obeying netdev locking (from
    shemminger@osdl.org)

Stéphane Eranian:
  o ia64: perfmon update

Todd Inglett:
  o fix cpuid to physical id needed in 2.5
  o Need to turn on RI immediately after we get control from firmware
    as well as when secondary cpus are started.

Torben Mathiasen:
  o PCI Hotplug: cpqphp 66/100/133MHz PCI-X support

Trond Myklebust:
  o Decrement the nr_unstable page state after the COMMIT RPC call
    completes instead of before. This ensures that writeback 
    WB_SYNC_ALL does wait on completion.
  o Fix typos in close-to-open cache consistency checking
  o Fix a TCP race: check whether or not the socket has been
    disconnected before we allow an RPC request to wait on a reply.
  o Don't use an RPC child process when reconnecting to a TCP server
  o Ensure that if we need to reconnect the socket, we also resend the
    entire RPC message
  o Add the sk->callback_lock spinlocks to the RPC socket callbacks in
    order to protect the socket from being released by one CPU while
    the other is in a soft interrupt.
  o Ensure that Lockd and the NSM (statd) clients always use privileged
    ports. Remove the existing code to temporarily raise privileges in
    fs/lockd/host.c, and use the new code in net/sunrpc/xprt.c
  o UDP and TCP zero copy code for the NFS client. The main interest

Vojtech Pavlik:
  o USB: Fix Kconfig for usb printers
  o USB: Make Olympus cameras work with usb-storage

Walter Harms:
  o USB: fixes kernel_thread

Zephaniah Hull:
  o i2c: it87 patch
  o I2C: Another it87 patch
  o I2C: Yet another it87 patch
  o I2C: And another it87 patch
  o I2C: And yet another it87 patch


