Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261968AbTFOHCd (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Jun 2003 03:02:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261985AbTFOHCd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Jun 2003 03:02:33 -0400
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:44038
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id S261968AbTFOHB7 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Jun 2003 03:01:59 -0400
Date: Sun, 15 Jun 2003 00:15:20 -0700 (PDT)
From: Andre Hedrick <andre@linux-ide.org>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.5.71
In-Reply-To: <Pine.LNX.4.10.10306142353520.11210-100000@master.linux-ide.org>
Message-ID: <Pine.LNX.4.10.10306150014080.11210-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Erm, I missed the sticky turtle ... gad ... one day I will learn not to
reply to you so fast.

Andre Hedrick
LAD Storage Consulting Group

On Sat, 14 Jun 2003, Andre Hedrick wrote:

> 
> Well some of us older cranky meatballs out here like the old school of
> pre-BK!  Pretend it is sex and do it more often :-)
> 
> 
> Andre Hedrick
> LAD Storage Consulting Group
> 
> On Sat, 14 Jun 2003, Linus Torvalds wrote:
> 
> > 
> > I think I'll call this kernel the "sticky turtle", in honor of that 
> > historic "greased weasel" kernel, and as a comment on how sadly dependent 
> > I've become on the daily BK snapshots. It's been too long since 2.5.70.
> > 
> > I'll do better, I promise. While most developers happily use either the 
> > daily snapshots or the BK tree itself, not everybody does, and a lot of 
> > users want "real releases". 
> > 
> > There's nothing hugely interesting here, but Al Viro ha sbeen cleaning up 
> > the tty layer, and Stephen Hemminger has been fixing up some network 
> > device alloc/free issues with the help of various people.
> > 
> > And obviously there are the normal usb/pcmcia/sound/architecture updates. 
> > With driver models and networking thrown in as a bonus.
> > 
> > 		Linus
> > 
> > ---
> > 
> > Summary of changes from v2.5.70 to v2.5.71
> > ============================================
> > 
> > Adrian Bunk:
> >   o kbuild: [PATCH] document modules_install in "make help"
> >   o [wan lmc] remove 2.0.x-era code
> >   o SECURITY_ROOTPLUG must depend on USB
> > 
> > Alan Cox:
> >   o [netdrvr tlan] fix 64-bit issues
> > 
> > Alan Iwi:
> >   o Missing magic number
> > 
> > Alan Stern:
> >   o USB: fix address assignment after device reset
> >   o USB: Don't allocate transfer buffers on the stack in hub.c
> >   o USB: Rename static functions in hub.c and increase timeouts
> >   o USB: Make hub.c DMA-aware
> > 
> > Alexander Viro:
> >   o callout removal: ircomm_tty
> >   o tty_driver refcounting
> >   o Fix sound lockup - missing chardev init
> >   o procfs bug exposed by cdev changes
> >   o Fix disk partitioning with multiple IDE disks
> >   o >minor_shift removal
> >   o [NET]: Eliminate {init,register,unregister}_fcdev
> >   o [NET]: Eliminate init_hippi_dev and {un,}register_hipdev
> >   o [NET]: Convert most tokenring drivers away from
> >     {init,register,unregister}_trdev, only ibmtr remains
> >   o [NET]: Eliminate init_fddidev
> >   o [NET]: Move sk98lin driver away from init_etherdev()
> >   o [NET]: Move 3c509 driver away from init_etherdev()
> >   o [NET]: Move sunqe.c driver away from init_etherdev()
> >   o [NET]: Move bmac.c away from init_etherdev()
> >   o [NET]: Convert USB drivers away from init_etherdev()
> > 
> > Alexey Kuznetsov:
> >   o tcp_output.c, tcp.c, tcp.h
> > 
> > Andi Kleen:
> >   o Work around gcc 3.3 bug on amd64 in binfmt_elf.c
> >   o Make spinlock debugging compile on x86-64
> >   o x86-64 merge
> > 
> > Andreas Schultz:
> >   o I2C: fix unsafe usage of list_for_each in i2c-core
> > 
> > Andrew Morton:
> >   o truncate and timestamps
> >   o fix typo in coda
> >   o Fix suspend with pccardd running
> >   o fix oops on resume from apm bios initiated suspend
> >   o export mmu_cr4_features to modules
> >   o [VISWS] irqreturn_t conversion
> >   o Fix CONFIG_PROCFS=n
> >   o zoran user-pointer fix
> >   o irq balance logic fix
> >   o kill lock_kernel() in inode_setattr()
> >   o i2o memleak comment
> >   o write_one_page() fixlets
> >   o speed up the unlink speedup
> >   o Remove unneeded fcntl check
> >   o unregister_netdev cleanups
> >   o support 64 bit pci_alloc_consistent
> >   o svcsock use-after-free fix
> >   o Fix writev when a segment generates EFAULT
> >   o Fixes trivial error in
> >   o [NET]: Convert rtnl_lock/register_netdevice/rtnl_unlock to
> >     register_netdev
> >   o fix generic_file_write()
> >   o magazine layer for slab
> >   o Additional fields in slabinfo
> >   o initialise vma->vm_next in do_mmap_pgoff()
> >   o More irq balance fixes
> >   o dirty_writeback_centisecs fixes
> >   o Copy nanosecond stat values for i386
> >   o Some subarch warning fixes
> >   o MTD build fix
> >   o improved core support for time-interpolation
> >   o ext3: fix for blocksize < PAGE_CACHE_SIZE
> >   o /proc/kcore fixes
> >   o remove 16-bit pid assumption from ipc/sem.c
> >   o fix broken networking
> >   o [NET]: Fix broken cleanups in net/core/iovec.c
> >   o aio: small cleanups
> >   o clean up timer interpolation code
> >   o radio-cadet.c: remove unnecessary copy_to_user()
> >   o cmpci: fix improper access to userspace
> >   o zr36120: fix improper access to userspace
> >   o remove unsafe BUG_ON()
> >   o pnpbios dereferencing user pointer
> >   o fix bw-qcam.c bad copy_to_user
> >   o Graceful failure in devfs_remove()
> >   o Fix generic_file_write() again
> >   o reiserfs option parser fix and ability to pass
> >   o reiserfs support for blocksizes other than 4096 bytes
> >   o hugetlbfs: mount options and permissions
> >   o DEADLINE: hash removal fix
> >   o ext3: fix deadlock in journal_create()
> >   o kmalloc_percpu: interface change
> >   o per-cpu support inside modules (minimal)
> >   o IRQs: handle bad return values from handlers
> >   o IRQs: fix up irq_desc initialisation for non-ia32
> >   o force_successful_syscall_return()
> >   o fix wobbly /proc/stat:btime
> >   o Console blanking fix
> >   o Console privacy for braille users
> >   o Fix tty devfs mess
> >   o misc fixes
> >   o cs423x fixes
> >   o remove get_current_user()
> >   o remove triggerable BUG() from de_thread
> >   o Don't let processes be scheduled on CPU-less nodes (1-3)
> >   o DAC960 fix for fibre channel transfer rate
> >   o /proc/sys/vm/min_free_kbytes
> >   o loop: remove the balance_dirty_pages() call
> >   o Fix build for CONFIG_KALLSYMS=n
> >   o ppc64: fixup for family/sk_family rename
> >   o Fix the build with !CONFIG_PROC_FS
> >   o common 32-bit ioctl code
> >   o ioctl32 cleanup: sparc64
> >   o x86_64: use common ioctl code
> >   o remove_proc_entry() fix
> >   o JFFS_PROC_FS must depend on JFFS_FS
> >   o fix apic handling for NUMA-Q
> >   o cleanup conditionals in summit subarch
> >   o provide bus to node mapping for Summit
> >   o rocket.c: devfs fix
> >   o add bootmem failure warning
> >   o eventpoll: fix possible use-after-free
> >   o Remove DRM ioctls for common compat ioctl code
> >   o fix possible busywait in rtc_read()
> >   o fix discontig with 0-sized nodes
> >   o fix TARGET_CPUS inconsistency
> >   o update MAINTAINERS for Compaq drivers
> >   o optimize fixed-sized kmalloc calls
> >   o fix scheduler bug not passing idle
> >   o fix numa meminfo
> >   o fix oops in driver/serial/core.c
> >   o fix hangs with nfs to localhost
> >   o devfs_mk_dir() fix
> >   o cpqarray.c: fix stack usage
> >   o dirty bit clearing on s390
> >   o drivers/char/mem.c cleanup
> >   o irq_cpustat cleanup
> >   o MAINTAINERS: Compaq->HP
> >   o loop: file use highmem
> >   o loop: make bio_copy private to loop
> >   o loop: loop bio renaming
> >   o loop: copy bio not data
> >   o loop: remove an IV
> >   o loop: remove LO_FLAGS_BH_REMAP
> >   o loop: remove blk_queue_bounce
> >   o loop: copy_bio use highmem
> >   o loop: don't lose PF_MEMDIE
> >   o tmpfs: shmem_file_write EFAULT
> >   o tmpfs: swapoff-truncate race
> >   o tmpfs: misc fixes
> >   o cleanup seqfile usage in resource.c
> >   o x25 facilities parsing fix
> >   o eicon usercopy fix
> >   o intermezzo symlink fix
> >   o mdc800 usercopy fix
> >   o mpu401 usercopy fix
> >   o emu10k1 memleak fix
> >   o rio memleak fix
> >   o fix resource leak in i810 driver
> >   o tioclinux() numbers in <linux/tiocl.h>
> >   o fix writeback for dirty ramdisk blockdev inodes
> > 
> > Andries E. Brouwer:
> >   o isa_writeb args interchanged
> >   o scsi: ten -> use_10_for_rw / use_10_for_ms
> > 
> > Andy Grover:
> >   o ACPI: fix extra semicolon (Pavel Machek)
> >   o ACPI: Trivial name init patch (Bjorn Helgaas)
> >   o ACPI: Disable ACPI sleep on SMP systems (Pavel Machek)
> >   o ACPI: Add access checking (Andi Kleen)
> >   o ACPI: Add ACPI PCI Subdriver. This enables acpiphp to work again.
> >     (Matthew Wilcox)
> >   o ACPI: Implement PCI Domain support (Matthew Wilcox)
> > 
> > Anton Blanchard:
> >   o ppc64: comment fix from Milton Miller
> >   o ppc64: Fix problem creating zImage/zImage.initrd multiples times
> >     from Bryan Logan
> >   o ppc64: clean up SLB reload code and remove some unnecessary isyncs
> >   o ppc64: fix compile warnings
> >   o ppc64: fix misreporting of unhandled IRQs in xics IPI
> >   o ppc64: cleanup some hardcoded constants
> >   o ppc64: replace MAX_PACAS with NR_CPUS
> >   o ppc64: Fix a bad shift against PCI_BASE_CLASS_BRIDGE from Will
> >     Schmidt
> >   o ppc64: fix for boot cpu > 31
> >   o ppc64: Report cpus > 32 in proc/cpuinfo correctly
> >   o ppc64: merge conflicts
> >   o compat_wait4 fix
> >   o ppc64: Always pass non segment faults on the 0xc region up to
> >     do_page_fault
> >   o ppc64: Add some branch prediction
> >   o ppc64: remove ioperm
> >   o ppc64: threaded coredump support
> >   o ppc64: fix copy_from_user leak, from Milton Miller
> >   o ppc64: Add warning for unhandled irqs
> >   o ppc64: remove sys32.S
> >   o ppc64: ppc64 update
> >   o ppc64: copy_tofrom_user exception handling fix from Paul Mackerras
> >   o ppc64: kcore support
> >   o ppc64: Increase maximum allocation size to 16MB for largepage
> >     support
> >   o ppc64: FORCE_MAX_ZONEORDER is actually order + 1, from Dave Gibson
> >   o ppc64: fix compile error introduced in threaded coredump patch
> >   o fix matroxfb compile on ppc64]
> >   o ppc64: Call setup_kcore later in boot, we call kmalloc from it
> >   o ppc64: cputable support from Will Schmidt
> >   o ppc64: use an initcall to register ras irqs
> >   o update ppc64 MAINTAINERS entry
> >   o ppc64: forgot to add this in the cputable merge
> >   o ppc64: Fix overallocation of NUMA bootmem bitmap and fix for NUMA
> >     kernels on non NUMA boxes
> >   o ppc64: Fix for multiple zone 0 regions on many ppc64 NUMA boxes
> >   o ppc64: Fix ppc64 build
> >   o ppc64: Update BUG handling based on ppc32
> >   o ppc64: use common 32bit ioctl code
> >   o ppc64: K&R to ANSI style conversions from Steven Cole
> >   o ppc64: copy_tofrom_user fix from Paul Mackerras
> >   o ppc64: various fixes to sys32_sysinfo, from Will Schmidt
> >   o ppc64: Rework inline syscall macros, fix clobbers & gcc3.3 from
> >     Franz Sirl
> >   o ppc64: rework user access functions
> > 
> > Arnaldo Carvalho de Melo:
> >   o wanrouter: fix bug introduced by latest namespace fix
> >   o net: abstract access to struct sock ->flags
> >   o USB drivers: initialize struct usb_driver ->owner field
> >   o drivers/usb/media/ibmcam: remove MOD_{INC,DEC}_USE_COUNT
> >   o drivers/usb/media/konicawc: remove MOD_{DEC,INC}_USE_COUNT
> >   o drivers/usb/media/ultracam: remove MOD_{INC,DEC}_USE_COUNT
> >   o n_hdlc: CodingStyle cleanups and removal of old stuff
> >   o net: reduce the data dependency of struct sock/struct tcp_tw_bucket
> >   o net: create struct sock_common and use in struct sock & tcp_tw_bucket
> >   o list.h: improve hlist
> >   o udpv6: use the right struct sock when testing if it is PF_INET6 family
> > 
> > Art Haas:
> >   o C99 patches for fs/
> >   o C99 struct initializers for kernel files
> > 
> > Bart De Schuymer:
> >   o [BRIDGE]: Remove unnecessary code in br_input
> >   o [NETFILTER]: Fix ARPT_INV_MASK in arp_tables.h
> > 
> > Bartlomiej Zolnierkiewicz:
> >   o allow "hdX=scsi" for modular scsi/ide-scsi
> >   o kill "hdX=noremap"
> >   o fix two IDE list_head problems
> >   o create /proc/ide/hdX/capacity only once
> >   o kill recreate_proc_ide_device()
> >   o switch ide to taskfile IO
> > 
> > Ben Collins:
> >   o Update IEEE1394 (r939)
> >   o USB Multi-input quirk
> >   o Update IEEE1394 (r946)
> >   o [SPARC64]: Final image strip not to strip too much
> >   o USB: fix keyboard leds
> >   o Register scsi devices after naming them
> >   o Update IEEE1394 (r952)
> > 
> > Benjamin Herrenschmidt:
> >   o [SUNGEM]: Fix gcc3.3 warnings
> >   o Nuke check_highmem_ptes()
> > 
> > Bruce D. Elliott:
> >   o [SPARC64]: Fix transmit handling in sunsab.c serial driver
> > 
> > Bruce Fields:
> >   o gss_marshal and gss_validate depend on gss_cred_get_ctx never
> >     returning NULL; but gss_refresh depends on gss_cred_get_ctx
> >     returning NULL whenever the cred is not up to date.  So, I replaced
> >     the single gss_cred_get_ctx by a gss_cred_get_ctx and a
> >     gss_cred_get_uptodate_ctx.
> >   o add handling of the new CTXPROBLEM and CREDPROBLEM RPCSEC_GSS
> >     errors
> >   o Add a "protocol: udp/tcp" line so that gssd can use the same
> >     protocol for null calls that was specified in the mount options.
> >   o I believe we need to set a timeout before doing the sleep in
> >     gss-upcall
> >   o allow gssd to communicate failure to initialize contexts back to
> >     the kernel, so the kernel can return -EACCES when a user lacks
> >     credentials, instead of just hanging until they kinit.
> >   o This makes several changes to the gss upcalls
> >   o Trivial; I kept forgetting what each of the xdr_netobj's passed to
> >     the gss-api routine meant, so I thought I'd fool with the argument
> >     names in an effort to make them more helpful.
> >   o Trivial fix for a typo in fs/nfs/nfs4state.c
> > 
> > Chas Williams:
> >   o [ATM]: lane and mpoa module refcounting and locking cleanup
> >   o [ATM]: HE driver coding style conformance
> >   o [ATM]: HE driver misc irq handler cleanups
> >   o [ATM]: Move rategrid off stack in HE driver
> >   o [ATM]: more cleanup in HE driver
> > 
> > Chris Wright:
> >   o lsm: Early init for security modules (1/4)
> >   o lsm: Remove task_kmod_set_label hook (2/4)
> >   o lsm: Remove inode_permission_lite hook (3/4)
> >   o lsm: setfsuid/setgsuid bug fix (4/4)
> > 
> > Christoph Hellwig:
> >   o acpi serial stuff
> >   o kill register_pccard_driver
> >   o give ->proc_info a struct Scsi_Host * parameter
> >   o PPC32: Syscall cleanups
> >   o [NET]: Switch lanmedia driver to initcalls
> >   o [NET]: Remove sdla from setup.c
> >   o [SPARC64]: Kill sys_aplib
> >   o use second arg to scsi_add_host in usb storage
> >   o fix scsi_register_host abuse in usb scanner drivers
> >   o driver model for scsi upper drivers, take 2
> >   o LDM-based scsi host lookup
> >   o switch /proc/scsi/scsi to seq_file and proper device model
> >   o kill scsi_host_get_next
> >   o kill remaining direct uses of scsi_register_host
> >   o fix signal.h compilation on PPC
> >   o [NET]: Move dmascc away from setup.c
> >   o [NET]: Fix non-modular sdla.c build
> >   o [NET]: Kill useless/wrong Version line from net/core/dv.c
> >   o [NET]: net/core/dst.c typo
> >   o [NET]: Fix coding style in net/core/filter.c
> >   o [NET]: Fix coding style in net/core/iovec.c
> >   o [NET]: Convert ppc early-init drivers to initcalls
> >   o [NET]: Fix accidental revert of init_etherdev killing in PPC net drivers
> >   o [NET]: Convert skfp over to initcalls, kill fddi cruft from Space.c
> > 
> > Daniele Bellucci:
> >   o USB: replaced BKL in rio500.c
> > 
> > Dave Engebretsen:
> >   o [netdrvr pcnet32] bug fixes
> > 
> > Dave Jones:
> >   o AM53C974 request region
> >   o [AGPGART] Compilation fix
> >   o [AGPGART] Remove useless early agp_init() from i810fb agp_init()
> >     just printk's a banner. This is unnecessary at this early stage.
> >   o [AGPGART] Yet another missed typedef compile fix
> >   o [AGPGART] Report fixing of errata, and add missing printk stuff
> >     (\n's, KERN_INFO, PFX)
> >   o [AGPGART] Kill useless printk in frontend
> >   o [AGPGART] Missing printk levels
> >   o [CPUFREQ] Make powernow-k7 leap big buildings^Wranges
> >   o [CPUFREQ] kill cpufreq_driver export
> >   o [CPUFREQ] Kill unused variables
> >   o [CPUFREQ] CodingStyle fixes
> >   o [CPUFREQ] Fix ACPI P-State driver
> >   o [CPUFREQ] missing export powernow-k7 needs dmi_broken
> >   o [AGPGART] Add webpage link
> >   o [CPUFREQ] Fix documentation filename
> >   o [CPUFREQ] Add Athlon to list of supported cpufreq drivers
> >   o [CPUFREQ] sysfs moved some files around. update documentation to
> >     reflect reality
> >   o Cset exclude:
> >     davej@codemonkey.org.uk|ChangeSet|20030611121150|30244
> >   o [CPUFREQ] Merge Jeremy's Centrino speedstep driver
> >   o [CPUFREQ] Move old speedstep driver to speedstep-ich
> >   o [AGPGART] Some Intel chipsets were using the wrong masks
> >   o [CPUFREQ] speedstep docu clarification
> > 
> > Dave Kleikamp:
> >   o Update JFS team members in jfs.txt
> >   o JFS: i_acl & i_default_acl are not being re-initialized
> >   o JFS: resize fixes
> >   o JFS: add back read_inode super_operation
> > 
> > David Brownell:
> >   o USB: ethernet "gadget", rx overflows happen
> >   o USB: kerneldoc for gadget API
> >   o PCI: pci pool, poison more like slab code
> >   o USB: usb/core/devio: identify process
> >   o USB: net2280 patch: control-out fix, minor cleanups
> >   o USB: ohci-hcd, remove FIXME
> > 
> > David Gibson:
> >   o Update orinoco driver to 0.13e
> > 
> > David Mosberger:
> >   o fix TCP roundtrip time update code
> >   o allow thread_info to be allocated as part of task_struct
> >   o [TG3]: Workaround 4g DMA bug more portably
> > 
> > David S. Miller:
> >   o [NET]: One too many IRQ_HANDLED added to sunqe.c driver
> >   o [IPV4/IPV6]: Use Jenkins hash for fragment reassembly handling
> >   o [IPV6]: Input full addresses into TCP_SYNQ hash function
> >   o [IPV4]: Add sysctl to control ipfrag_secret_interval
> >   o [IPV6]: Fix typo in defragmentation changes
> >   o [TCP]: Do not access inet_sk() of a time-wait bucket
> >   o [SPARC64]: Fix probe error handling in envctrl.c driver
> >   o [SPARC64]: Fix probe error handling in bbc_{envctrl,i2c}.c driver
> >   o [SPARC64]: Do not export {un,}register_ioctl32_converstion twice
> >   o [NET}: Fix typo in sock_set_flag changes
> >   o [ATM]: Fix driver Makefile clean-files
> >   o [SPARC64]: Fix sys_shmat handling for 64-bit binaries
> >   o [XFRM]: Handle use_time expiration properly
> >   o [SOUND]: Revert buggy ALSA merge ioctl32 changes
> >   o [SOUND]: vx/vx_core.c needs linux/init.h
> >   o [SOUND]: Fix sparc cs4231 driver build due to pcm list changes
> >   o [SPARC64]: Update defconfig
> >   o [NET]: Kill PTI fddi driver, never completed and no plans to finish
> >   o [NET]: Fix CONFIG_HIPPI build
> >   o [NET]: Fix typos in init_trdev changes to lanstreamer.c
> >   o [NET]: Eliminate {init,register,unregister}_trdev()
> >   o [NET]: Eliminate init_etherdev usage from arch/um drivers
> >   o [IPV6]: In ipv6_add_dev dont call __ipv6_regen_rndid without
> >     initial reference held
> >   o [NET]: Use INIT_LIST_HEAD in arch/um/drivers/net_kern.c
> >   o [NET]: Typo in iph5527.c driver changes
> >   o [NET]: Use INIT_LIST_HEAD correctly in arch/um/drivers/net_kern.c
> >   o [IPSEC]: {esp,ah} --> {esp4,ah4}
> >   o [NET]: Move arch/cris drivers away from init_etherdev()
> >   o [NET]: Convert ia64 simeth.c away from init_etherdev()
> >   o [NET]: Convert PPC 8260_io/enet.c away from init_etherdev()
> >   o [NET]: Convert PPC 8260_io/fcc_enet.c away from init_etherdev()
> >   o [NET]: Convert PPC 8xx_io/enet.c away from init_etherdev()
> >   o [NET]: Convert PPC 8xx_io/fec.c away from init_etherdev()
> >   o [NET]: Actually apply Al's sunqe.c changes
> >   o [NET]: Fix thinkos in PPC 8260_io/fcc_enet.c changes
> >   o [PCI]: Move pci_remove_bus_device back to include/linux/pci.h,
> >     discussed with greg@kroah.com
> >   o [NET]: Kill drivers/net/setup.c, it no longer does anything
> >   o [IPSEC]: Implement xfrm type module autoloading
> >   o [NET]: Some stuff missed during acme's struct sock cleanup
> >   o [NET]: Missing __KERNEL__ ifdefs in linux/{tcp,udp}.h
> >   o [SCTP]: Kill unused local variable in init_sctp_mibs
> >   o [NET]: Process hotplug list in FIFO order
> >   o [NET]: Fix typo in neigh_sysctl_unregister changes
> >   o [LLC]: Fix typing error in procfs code
> > 
> > David Stevens:
> >   o [IGMP]: Make sock_alloc_send_skb calls non-blocking
> > 
> > David van Hoose:
> >   o Fix compilation errors in ppa and imm modules
> > 
> > David Woodhouse:
> >   o MTD and JFFS2 update
> >   o Final cleanups for MTD merge
> >   o Fix some accidental regressions which slipped in with the MTD merge
> > 
> > Davide Libenzi:
> >   o epoll race fix
> > 
> > Deepak Saxena:
> >   o [ARM PATCH] 1537/1: big-endian support for do_div64
> >   o [ARM PATCH] 1538/1: arch/arm/Makefile and KConfig Big-Endian
> >     changes
> > 
> > Dominik Brodowski:
> >   o [PCMCIA] Move socket_info_t
> >   o [PCMCIA] Move get_socket_info_by_nr
> >   o [PCMCIA] Remove socket_table
> >   o [PCMCIA] True driver module locking
> >   o [PCMCIA] split_init
> >   o [PCMCIA] register
> >   o [PCMCIA] Callbacks use pcmcia_socket not integer
> >   o [PCMCIA] socket reference in client_t
> >   o [PCMCIA] Replace more socket numbers with pcmcia_socket
> >   o [PCMCIA] Make ds.c use pcmcia_socket->sock rather than local
> >     version
> >   o [PCMCIA] unify yenta.c and pci_socket.c
> >   o [PCMCIA] Remove socket_info_t
> >   o [PCMCIA] i82365 depends on ISA
> >   o [PCMCIA] rename i82365.c socket_info_t
> >   o [PCMCIA] Rename tcic.c socket_info_t
> > 
> > Douglas Gilbert:
> >   o scsi_mid_low_api.txt in lk 2.5.69
> >   o sg driver for lk 2.5.70
> > 
> > Eddie Williams:
> >   o scsi: allow devices to restrict start on add
> > 
> > Edward Peng:
> >   o [netdrvr sundance] fix flow control bug
> >   o [netdrvr sundance] fix another flow control bug
> > 
> > Frank Cusack:
> >   o nfs_unlink() problem fix
> > 
> > Geert Uytterhoeven:
> >   o [NET]: asm/smp.h --> linux/smp.h in sch_ingress.c
> > 
> > Greg Kroah-Hartman:
> >   o USB: fix up unusual_devs.h merge mess
> >   o USB: remove some old references to /proc/bus/usb/drivers
> >   o Cset exclude: greg@kroah.com|ChangeSet|20030529215347|05329
> >   o USB: add usb_find_device() function to USB core
> >   o Root plug: remove USB bus walking functions, now use
> >     usb_find_device()
> >   o USB: added .owner to kobil_sct driver
> >   o PCI: make pci_setup_device(), pci_alloc_primary_bus() and
> >     pci_alloc_primary_bus_parented() static
> >   o PCI: make pools_lock and pci_lock static
> >   o ACPI PCI Hotplug: remove hand made pci_find_bus function
> >   o IBM PCI hotplug: remove hand made pci_find_bus function
> >   o IBM PCI hotplug: remove direct access of pci_devices variable
> >   o PCI Hotplug: move drivers/hotplug/* to drivers/pci/hotplug/*
> >   o PCI: Remove a lot of PCI core only functions from
> >     include/linux/pci.h
> >   o PCI: remove CONFIG_PROC_FS checks in .c files
> >   o PCI: Move more functions out of include/linux/pci.h that don't need
> >     to be there
> >   o PCI: Grab reference count on pci_dev if the pci driver binds to the
> >     device
> >   o PCI: remove usage of pci_for_each_dev() in drivers 
> >   o PCI: finally remove pci_for_each_dev() now that all users of it are
> >     gone
> >   o PCI: remove usage of pci_for_each_dev() in arch/ppc64/kernel/pci.c
> >   o PCI: remove direct access of pci_devices from
> >     arch/m68k/atari/hades-pci.c
> >   o PCI: remove direct access of pci_devices from
> >     drivers/macintosh/via-pmu68k.c
> >   o PCI: fix up previous fusion driver pci changes
> >   o PCI: add pci_find_device_reverse() for users of
> >     pci_find_each_dev_reverse() to use
> >   o PCI: remove usage of pci_for_each_dev_reverse() in
> >   o PCI: remove pci_for_each_dev_reverse() now that all users of it are
> >     gone
> >   o PCI: move pci_present() into drivers/pci/search.c
> >   o PCI: remove EXPORT_SYMBOL(pci_devices)
> >   o I2C: sync i2c-id.h with cvs version
> >   o TTY: add a release function for tty_class devices
> >   o TTY: release function should be set in the class, not the class_device
> >   o PCI: add pci_find_next_bus() function to prevent people from
> >     walking pci bus lists themselves
> >   o PCI: remove pci_for_each_bus() usage from
> >     arch/ia64/hp/common/sba_iommu.c
> >   o PCI: remove pci_present(), pci_for_each_bus() and pci_bus_b() usage
> >   o PCI: sparse fixups for drivers/pci/proc.c
> >   o USB: fix problem found by sparse in usb.h
> >   o USB: sparse fixups for drivers/usb/core/devices.c
> >   o USB: sparse fixups for drivers/usb/core/inode.c
> >   o USB: lots of sparse fixups for usbfs
> >   o I2C: coding style updates for i2c-iop3xx driver
> >   o I2C: fix some errors found by sparse in include/linux/i2c.h
> >   o I2C: fix up sparse warnings in drivers/i2c/i2c-core.c
> >   o I2C: fix up sparse warnings in the i2c-dev driver
> > 
> > Greg Ungerer:
> >   o create m68knommu/coldfire specific ints.c
> >   o remove common m68knommu ints.c
> >   o don't compile m68knommu/kernel ints.c
> >   o compile m68knommu/ColdFire ints.c
> >   o fix calls to do_fork()
> >   o remove obsolete BLKMEM driver reference
> >   o cleanup is_in_rom() checker
> >   o fix broken trace flag check in 68328 system call entry
> >   o security init call support in linker script
> >   o conditional ROMfs copy for ARNEWSH/5206 setup
> >   o support BOOTPARAM's on m68knommu/5206 targets
> >   o support BOOTPARAM's on m68knommu/5206e targets
> >   o m68knommu/pilot startup copy init segment to RAM
> > 
> > Hartmut Wahl:
> >   o USB:  Patch for Samsung Digimax 410
> > 
> > Henning Meier-Geinitz:
> >   o USB: new vendor/product ids for scanner driver
> > 
> > Herbert Xu:
> >   o [IPSEC]: Order SPD using priority
> >   o [NET]: Missing refcount bump in flow cache
> >   o [XFRM]: u64 --> __u64 in linux/xfrm.h
> >   o [XFRM_USER]: Fix xfrm_state_lookup args in xfrm_add_sa
> >   o [XFRM_USER]: Rename confusing member of struct xfrm_usersa_id
> >   o [XFRM]: Too many reference drops of delpol in xfrm_policy_insert
> >   o Fix ide-mod unload crash
> >   o [IPSEC]: Include linux/slab.h where necessary
> >   o [XFRM_USER]: Allow del policy by id and get policy by selector
> >   o [IPSEC]: Zap killed policies from the flow cache properly
> >   o [IPSEC]: Fix preempt race in flow_flush_cache
> >   o [IPSEC]: Kill object argument from flow_cache_flush
> >   o [IPSEC]: Proper percpu handling in flow cache
> >   o [IPSEC]: Initialize flow key properly in decode_session
> > 
> > Hideaki Yoshifuji:
> >   o [IPV6]: Convert /proc/net/if_inet6 to seq_file
> >   o [IPV6]: Fix order of destruction of procfs
> >   o [IPV6]: Make procfs destructors return void
> >   o [CRYPTO]: Fix compiler warnings in sha512.c
> >   o [IPV6]: Fix possible idev leakage in icmp.c
> >   o [IPV6]: Fix possible oops in ndisc_send_na
> >   o [IPV6]: Clean up ip6_dst_alloc() calls
> >   o [IPV6]: Always remove fragment header
> >   o [IPV6]: Fix possible dst leakage in ndisc_send_redirect
> >   o [IPV6]: Fix default router selection in some cases
> >   o [IPV6]: Add ip6frag sysctls
> >   o [NET]: Add ip-sysctl.txt entries for missing ip{,6}frag_* sysctls
> >   o [IPV6]: Set dead flag on idev if snmp6_register_dev() fails
> >   o [IPV6]: Fix several errors in udpv6_connect()
> >   o [IPV6]: typo, unrequired #undef and bad operator precedence
> >   o [netdrvr] C99 initializers for arcnet
> >   o [IPV6]: dev_get_by_name("lo") --> dev_hold(&loopback_dev)
> >   o [IPV6]: ipv6_addr_prefix() cleanup, eliminate duplication
> >   o [NET]: Make neigh_parms setup/teardown handling symmetric
> >   o [IPV6]: Fix payload length of reassembled packet
> >   o [IPV6]: Use sizeof(struct frag_hdr) instead of magic value
> > 
> > Hirofumi Ogawa:
> >   o Adds the large partition (> 128GB) support to FAT (1/5)
> >   o Fix VFAT_IOCTL_READDIR_BOTH/_SHORT ioctl (2/5)
> >   o Remove Documentation/filesystems/fat_cvf.txt (3/5)
> >   o FAT cluster chain cache per superblock (4/5)
> >   o FAT cluster chain cache per inode (5/5)
> > 
> > Hollis Blanchard:
> >   o awe_wave.c user pointer dereference
> > 
> > Ian Molton:
> >   o ARM26 architecture
> > 
> > Ivan Kokshaysky:
> >   o alpha: compile warning fix
> >   o alpha: fix panic on smp boot (fork_by_hand)
> >   o alpha: typo in EISA bridge detection
> >   o alpha: single-step breakpoints - updated fix
> >   o PCI domains warning
> > 
> > James Bottomley:
> >   o Fix up proc_info conversion in 53c700
> >   o Fix while in spinup loop of sd
> >   o SCSI: Make sysfs attributes mutable
> >   o Use of the new attribute modifiers on the 53c700
> >   o Fix up 53c700 compile
> >   o scsi sysfs add attribute release function
> >   o qla1280: convert the driver to be endian neutral
> >   o qla1280: set the data direction correctly
> >   o qla1280: convert the driver to the new SCSI error handler
> >   o Fix __exit routine of NCR_D700
> >   o fix character subsystem initialisation
> > 
> > James Morris:
> >   o [CRYPTO]: Use "select" kconfig facility instead of fragile defaults
> > 
> > Jaroslav Kysela:
> >   o Several ALSA updates
> > 
> > Jeff Garzik:
> >   o [netdrvr eepro] update MODULE_AUTHOR per old-author request
> >   o [netdrvr tlan] cleanup
> >   o [netdrvr] s/init_etherdev/alloc_etherdev/ in code comments, in
> >     8139too and pci-skeleton drivers.
> >   o [netdrvr 8139too] respond to "isn't this racy?" comment
> >   o [netdrvr r8169] use alloc_etherdev, pci_disable_device
> >   o [ROSE]: Kill kfree of net_device->name
> >   o Cset exclude: shemminger@osdl.org|ChangeSet|20030529205634|46794
> >   o [netdrvr] gcc 3.3 cleanups
> >   o [netdrvr skge] add ULL modifier to 64-bit constant
> >   o [netdrvr] add MAINTAINERS entry for atmel wireless driver
> > 
> > Jeff Wiedemeier:
> >   o compile fix for agp_memory struct definitition change
> > 
> > Jens Axboe:
> >   o remove buggy BUG_ON in ide-cd
> >   o blk layer tag resize
> >   o copy the tag_map
> >   o ide-cd buglets
> >   o scsi_ioctl HZ fixes
> >   o ide-cd/scsi/block fixups for SG_IO
> >   o kill old stuff
> > 
> > Jim Houston:
> >   o preallocate signal queue resource  - Posix timers
> > 
> > Joe Burks:
> >   o USB: vicam.c patch
> > 
> > Joe Thornber:
> >   o dm: Replace __HIGH() and __LOW() macros
> >   o dm: signed/unsigned audit
> >   o dm: new suspend/resume target methods
> >   o dm: Lift dm_div_up()
> >   o dm: Fix memory leak in dm_register_target()
> >   o dm: Remove some debug messages
> >   o dm: Remove an old FIXME
> > 
> > John Hawkes:
> >   o 2.5.70 remove smp_send_reschedule() cruft
> > 
> > John Levon:
> >   o OProfile: Export task->tgid in the buffer
> >   o OProfile: update Changes
> >   o OProfile: remove useless code
> >   o OProfile: fix init / exit routine
> > 
> > Jon Grimm:
> >   o [SCTP] Verify contents of SACK against underrun
> >   o [SCTP] Use slab cache for sctp_chunk & sctp_bind_bucket
> >   o [SCTP] Bug fix for bind_bucket leak & heartbeat error count
> >   o [SCTP] Use non-prefetch list walker for short list
> >   o [SCTP] CANT_STR_ASSOC could/should return error up to user.
> >     (ardelle.fan)
> >   o [SCTP] Multiple causes may be embedded in an ERROR chunk
> >     (ardelle.fan)
> >   o [SCTP] Don't use path thresholds determine the overall error thresh
> >   o [SCTP] Let T5 timer affect SHUTDOWN-PENDING associations
> >   o [SCTP] sctp_jitter() needs to protect against div by 0
> >   o [SCTP] Various bakeoff fixes
> >   o [SCTP]  Fix double free of chunk along unexepected INIT path
> >   o [SCTP] Incorrect WORD_ROUND on a network endian value
> >   o [SCTP] Special case the handling of HOST_NAME_ADDRESS parm
> >   o [SCTP] Hand merge bk pull conflict.  sk->state now sk->sk_state
> > 
> > Justin T. Gibbs:
> >   o Aic6xxx and Aic79xx Driver Update
> >   o Bump aic79xx driver version to 1.3.9
> > 
> > Jörn Engel:
> >   o zlib cleanup: remove FAR macro
> >   o zlib cleanup: __32BIT__ and STDC
> >   o zlib cleanup: ZEXTERN
> >   o zlib cleanup: ZEXPORT
> >   o zlib cleanup: z_off_t
> >   o zlib cleanup: OF
> >   o zlib cleanup: C++ workarounds
> >   o zlib merge: turboc
> >   o zlib merge: inffast.c
> >   o Mark Compaq MAINTAINERS entries stale
> >   o zlib cleanup: local
> >   o zlib cleanup: Z_NULL removal
> >   o zlib cleanup: unnecessary cast removal
> >   o zlib merge: return code
> >   o zlib merge: avoid 8-bit window errors
> >   o zlib changes: memlevel
> >   o Fix typo in comment
> >   o adjust ppp to zlib change
> > 
> > Krishna Kumar:
> >   o [NET]: Initialize sysctl_table to NULL in neigh_parms_alloc
> > 
> > Kurt Robideau:
> >   o Rocketport driver against 2.5.70-bk7
> >   o Rocket patch against 2.5.70-bk18
> > 
> > Linus Torvalds:
> >   o Remove a few zero-sized files, as noted by David Gibson
> >   o Make zlib_inflate look more like ANSI C code
> >   o zlib cleanup: final fixups
> >   o Remove half-deleted zero-sized sound file
> >   o Quick response to de-listing the Compaq FC/RAID controllers from
> >     the MAINTAINERS list. How they're HP, and maintained by Stephen
> >     Cameron.
> >   o Re-introduce debugging code in list handling, poisoning stale list
> >     pointers to give us a nice oops if somebody is doing something bad.
> >   o Fix __d_drop() to properly initialize the d_hash fields, so that
> >     __d_drop() can safely be done multiple times on a dentry without
> >     corrupting other hash entries.
> >   o Don't make the source checker default path be quite so hackish.
> >   o Avoid warning by using an inline function rather than a macro for
> >     the default "pci_domain_nr()" definition. The inline function will
> >     evaluate the argument.
> >   o Make chr_dev_init() happen after PCI init, but before low-level
> >     driver initializations
> >   o Fix rcu list poisoning - since another CPU may be traversing the
> >     list as we delete the entry, we can only poison the back pointer,
> >     not the traversal pointer (rcu traversal only ever walks forward).
> >   o Make d_move() be able to gracefully handle the case of the dentry
> >     already being unhashed on entry.
> >   o Remove strange and broken ACPI rule from serial Makefile
> >   o Linux 2.5.71
> > 
> > Manfred Spraul:
> >   o Prepare for page unmapper
> > 
> > Margit Schubert-While:
> >   o I2C: add LM85 driver
> > 
> > Mark Haverkamp:
> >   o megaraid driver fix for 2.5.70
> > 
> > Mark M. Hoffman:
> >   o I2C: fix oops w83781d during rmmod
> >   o I2C: more w83781d fixes
> > 
> > Martin Schlemmer:
> >   o ethertap: fix struct sock cleanup leftover
> > 
> > Matt Domsch:
> >   o dynids: use list_add_tail
> >   o dynids: free dynids on driver unload
> > 
> > Matt Porter:
> >   o PPC32: Fix a compile error on 4xx embedded PowerPC
> >   o PPC32: Resolve colliding includes in boot wrappers
> > 
> > Matthew Dharm:
> >   o USB: storage: abort and disconnect handling
> >   o USB: storage: collapse one-use functions
> >   o USB: usb-storage: fix typo
> >   o USB: usb-storage: timeouts and aborts
> >   o USB: usb-storage: usb_stor_control_msg() and stuff
> >   o USB: usb-storage: change result codes
> >   o USB: usb-storage: handle babble
> >   o USB: usb-storage: re-organize probe/disconnect
> >   o USB: usb-storage: remove dead code
> > 
> > Matthew Wilcox:
> >   o PCI: domain support for sysfs
> > 
> > Mike Anderson:
> >   o Call release on scsi legacy LLDD
> > 
> > Miles Bader:
> >   o Remove some unneeded register saving on the v850
> >   o Include <linux/fs.h> in arch/v850/kernel/rte_cb_leds.c
> >   o Miscellaneous v850 whitespace and comment cleanups
> >   o Handle new do_fork return value on v850
> >   o Add __KERNEL__ guard to nb85e_cache.h on v850
> >   o Add leading underline to new linker-script symbols on the v850
> >   o Whitespace and comment cleanups for v850 entry.S
> >   o Add v850 support for hardware single-step (via ptrace)
> >   o Update irq.c on v850 to use irqreturn_t
> >   o const-qualify memory arg in v850's __test_bit
> > 
> > Mitsuru Kanda:
> >   o [IPV6]: Fix esp6 extension headers handling
> > 
> > Moritz Mühlenhoff:
> >   o [CRYPTO]: Default CRYPTO and MD5 to y if IPV6_PRIVACY is enabled
> > 
> > Neil Brown:
> >   o md: Export bio_split_pool for md to use
> >   o md: Use new single page bio splitting for raid0 and linear
> >   o md: Handle concurrent failure of two drives in raid5
> >   o md: Improve test for which raid1 device doesn't need to be written
> >     to
> >   o md: Fix simple off-by-one error in md driver
> >   o md: Get rid of vmalloc/vfree from raid0
> >   o md: Always allow a half-built md array to be stopped
> >   o md: Improve raid0 mapping code to simplify and reduce mem usage
> >   o md: Remove dependancy on MD_SB_DISKS from multipath
> >   o md: Remove dependancy on MD_SB_DISKS from raid5
> >   o md: Remove dependancy on MD_SB_DISKS from raid0
> >   o md: Remove MD_SB_DISKS limits from raid1
> >   o md: Remove dependance on MD_SB_DISKS in linear personality
> >   o md: Replace bdev_partition_name with calls to bdevname
> >   o Fix raid5 bug where wrong 'dev' is used
> >   o Fix raid1 handling of writing to multiple devices
> >   o Fix up freeing of kmalloc structures
> >   o Fix bug in /proc/mdstat
> >   o md -  Zero out some kmalloced space in md driver
> > 
> > Nicolas Pitre:
> >   o [ARM PATCH] 1545/1: correct compiler flags for ARMv5TE/XScale
> >   o [ARM PATCH] 1540/2: fixes for gcc-3.3
> > 
> > Olaf Hering:
> >   o USB: incorrect ethtool -i driver name
> > 
> > Oliver Neukum:
> >   o fix irq handling for DC395
> >   o improve Documentation for DC395
> >   o 01-debug-cleanup.patch
> >   o major cleanup of the module code
> >   o USB: allocate memory for reset earlier
> >   o USB: return errors when disabling a port
> >   o USB: cut usb_set_config from hpusbscsi
> >   o USB: usb_set_configuration in empeg.c
> >   o USB: kill a compiler warning in hpusbscsi
> > 
> > Patrick McHardy:
> >   o [PPP] fix memory leak in ioctl error path
> > 
> > Patrick Mochel:
> >   o drver model: Add release method for class devices
> >   o sysfs: Fix binary file handling
> >   o [driver model] Clean up CPU unregistration
> >   o Driver Class: don't call put_device() when we never called
> >     get_device()
> >   o [driver model] Clean up class release handling
> >   o [kobject] Update Documentation and licenses
> >   o [driver model] Update copyrights and license statements
> >   o [driver model] fix comment in device.h
> >   o [fs] Remove kobject support for filesystems
> >   o [kobject] Remove kobj_lock and use lockless refcounting
> >   o [driver model] Add device_for_each_child iterator
> >   o [kobject] Add warning + back trace if kobject_get() is called with
> >     0 refcount
> >   o [driver model] Remove extraneous class device release method
> >   o [driver model] Rewrite system device API
> >   o [list.h] Add list_for_each_entry_reverse
> >   o [kobject] Add set_kset_name
> >   o [driver model] Make sure that system devices are handled specially
> >     power-wise
> >   o [driver model] Convert to new system device API
> >   o [lapic] Convert to new system device API
> >   o [i8259] Convert to use new system device API
> >   o [nmi] Convert to use new system device API
> >   o [timer] Convert to use new system device API
> >   o [oprofile] Convert to use new system device API
> >   o [x86-64 i8259] Convert to use new system device API
> >   o [s390 xpram] Convert to use new system device API
> >   o [driver model] Create include/linux/sysdev.h and define
> >     sysdev_attribute
> >   o [driver model] Make sure right header is used for cpu.c
> >   o [memblk] Convert to use new system device API
> >   o [numa nodes] Convert to use new system device API
> >   o [driver model] Remove system device definitions from device.h
> >   o [apic] Use sysdev.h instead of device.h
> >   o [i8259] Use sysdev.h instead of device.h
> >   o [nmi] Use sysdev.h instead of device.h
> >   o [timer] Use sysdev.h instead of device.h
> >   o [oprofile] Use sysdev.h instead of device.h
> >   o [x86-64 i8259] Use sysdev.h instead of device.h
> >   o [s390 xpram] Use sysdev.h instead of device.h
> >   o [driver model] Add save() and restore() methods for system device
> >     drivers
> >   o [driver model] Don't Oops when registering global sysdev drivers
> >   o [cpu] Use sysdev.h instead of device.h and export cpu_sysdev_class
> >   o [mtrr] Add save()/restore() methods
> >   o [cpufreq] Convert to use new system device API
> >   o [sysfs] Get zeroed page for file read/write buffers
> >   o hand merge
> >   o [driver model] Actually implement sysdev_{create,remove}_file()
> >   o [driver model] Compile fixes for NUMA
> >   o [sa1100 irq] Convert to new system device API
> >   o [driver model] Turn off debugging by defualt for device iterations
> >   o [kobject] Don't specially order objects in lists based on parent
> >   o [driver model] Make sure we walk lists on shutdown in right order
> >   o [sysfs] Add __user tag to appropriate parameters
> >   o [driver model] Remove extraneous get_device() from
> >     class_device_add()
> >   o [driver model] Make sure system device drivers are added if
> >     registered late
> > 
> > Paul Fulghum:
> >   o tty_register_driver
> > 
> > Paul Mackerras:
> >   o PPC32: Fix preempt bugs identified by Milton Miller
> >   o PPC32: Discard the __ksymtab* sections when we are linking the boot
> >     wrapper
> >   o PPC32: Re-open I/O windows on PCI-PCI bridges, needed for some
> >     powermacs
> >   o PPC32: Better handling of program check exceptions on 4xx, patch
> >     from Kumar Gala
> >   o PPC32: Simplify the BUG() implementation for now (a better one is
> >     coming)
> >   o get rid of CONFIG_ALL_PPC
> >   o PPC32: Compile fix for array initialization from Christoph Hellwig
> >   o PPC32: Cleanups from Christoph Hellwig and Tom Rini
> >   o PPC32: Start adding __user to mark pointers from userspace
> >   o PPC32: Fix irq_desc initialization
> >   o PPC32: Fix various minor problems pointed out by Linus' check
> >     program
> >   o PPC32: Convert some K&R-style functions to ANSI-style.  From Steven
> >     Cole
> >   o fix check warnings in drivers/macintosh
> >   o Fix check warnings in PPP code
> >   o Move BUG/BUG_ON/WARN_ON to asm headers
> >   o [PPP]: Fix PPP Deflate sequence number checking
> > 
> > Paul Mundt:
> >   o toplevel SH update
> >   o Move SH board-specific code around
> > 
> > Pavel Roskin:
> >   o Fix crash when unloading yenta_socket in Linux 2.5.69
> >   o USB: name uninitialized in scanner.c
> > 
> > Peter Milne:
> >   o [ARM PATCH] 1546/1: iop321 additional Hardware PMMR defines
> >   o I2C: add New bus driver: XSCALE iop3xx
> > 
> > Petko Manolov:
> >   o USB: pegasus patch
> > 
> > Petr Vandrovec:
> >   o matroxfb update to new API
> > 
> > Randy Dunlap:
> >   o [NET]: add RFC references for Linux SNMP MIBs
> >   o [NET]: Typo corrections only
> >   o [IPV6]: Add IPv6 routing table statistic: fib_discarded_routes
> >   o [IPV6]: Fix spelling/typos
> > 
> > Reeja John:
> >   o [netdrvr amd8111e] interrupt coalescing, libmii, bug fixes
> >   o [netdrvr amd8111e] link against mii lib
> > 
> > René Scharfe:
> >   o hugetlbfs: fix error reporting in case of invalid mount
> >   o Some more stuff missed during the struct sock cleanup
> > 
> > Richard Henderson:
> >   o [ALPHA] Add posix timer and clock syscalls
> >   o [ALPHA] Add semtimedop syscall
> >   o [ALPHA] Implement bcopy
> >   o [ALPHA] Avoid warning in asm/unaligned.h
> >   o [ALPHA] Fix missed __ex_table to conversion to pc-relative relocs
> >   o [ALPHA] Streamline calls to __copy_user and __do_clear_user
> >   o [ALPHA] Fixup fallout from force_successful_syscall_return change
> > 
> > Roland McGrath:
> >   o User FIXMAP area simplification
> > 
> > Roman Zippel:
> >   o Remove old code and macros
> >   o Change P_ROOTMENU into a MENU_ROOT flag
> >   o add new keywords to parser
> >   o expression support
> >   o reverse dependency support
> >   o support for 'range'
> >   o add more warnings
> >   o front end updates
> >   o create configuration in the destination directory
> >   o update kconfig documentation
> >   o choice handling fixes
> >   o boolean symbol state fix
> >   o ignore attempts to change unchangable symbols
> > 
> > Russell King:
> >   o [ARM] Fix GCC3.3 build error
> >   o [ARM] Remove old 26-bit ARM keyboard drivers
> >   o [ARM] Declare mmu_gathers using DEFINE_PER_CPU
> >   o [ARM] Fix more missing irqreturn_t and remove a static no_action
> >     func
> >   o [ARM] Move dma_alloc_coherent() to consistent.c
> >   o [ARM] Convert platform devices to use platform_device
> >   o [ARM] Tidy up Integrator core support
> >   o [PCMCIA] Fix sa11xx_core.c oops when changing cpu frequency
> >   o [PCMCIA] Convert sa11xx platforms to use new class code
> >   o [PCMCIA] Update SA11xx PCMCIA support for recent changes
> >   o [PCMCIA] sa11xx driver now takes pcmcia_socket instead of int
> >     socket
> > 
> > Rusty Russell:
> >   o kallsyms in proc
> >   o Move cpu notifiers et al to cpu.h
> >   o Fix module load failure case
> >   o [NETFILTER]: Delete unnecessary skb_linearize() calls in
> >     iptables_{filter,mangle}.c
> >   o sched.c neatening and fixes
> > 
> > Sam Ravnborg:
> >   o kbuild: [PATCH] Remove duplicate definitions in Makefile.build
> >   o kbuild: Updated make help
> >   o kbuild: Silence kbuild with make V=0
> >   o kbuild: CROSS_COMPILE and ARCH definitions
> >   o kbuild: Silence output with make 3.80
> >   o kbuild: Utilise kbuild infrastructure for vsyscall
> >   o kbuild: Nice output when generating PCI device list
> >   o kbuild: Nice output when generating crc32 table
> >   o docbook/kernel-api: include files updated
> >   o docbook: Recognize sis900 functions
> >   o docbook: Warn about missing parameter definitions
> >   o docbook: Move definition of MODULENAME_SIZE
> >   o kbuild: Kill use of do_cmd in drivers/char/Makefile
> >   o kbuild/i386: Add missing dependency in kernel/Makefile
> >   o kbuild: Enable modules to be build using the "make dir/" syntax
> >   o be more flexible about creating library archives
> >   o all archs: Replace O_TARGET with lib-y
> >   o kbuild: Document newly added lib-y
> >   o kbuild: kill do_cmd
> > 
> > Samuel Thibault:
> >   o cpufreq: correct initialization on Intel Coppermines
> >   o speedstep_detect_speed might not reenable interrupts
> > 
> > Scott Feldman:
> >   o [netdrvr e100] move register_netdev below netdev struct init
> >   o 10GbE ethtool support
> >   o remove ethtool privileged references
> > 
> > Shmulik Hen:
> >   o [netdrvr bonding] fix long failover in 802.3ad mode
> >   o [netdrvr bonding] fix ABI version control problem
> > 
> > Simon Kelley:
> >   o [netdrvr] add atmel[_cs], new wireless driver
> > 
> > Sridhar Samudrala:
> >   o [SCTP] Support for socket options that pass both addr and associd
> >   o [SCTP] Support for SCTP_GET_PEER_ADDR_INFO socket option
> >   o [SCTP] Rename struct sctp_protocol as struct sctp_globals and
> >     define macros for all the global fields in the structure.
> >   o [SCTP] SCTP_SHUTDOWN_EVENT notification support
> >   o [SCTP] /proc interface to display associations/endpoints
> >   o [IPV6]: Allow ipv6 fragmentation via ip6_xmit() when ipfragok is
> >     set
> > 
> > Stephen Hemminger:
> >   o [BRIDGE]: Make delete bridge work with current unregister semantics
> >   o [NET]: Sysfs netdev cleanup and bugfix
> >   o [NET]: Kill deprecated if_port_text and users
> >   o [NET]: Fix device unregister in TUN driver
> >   o typo in new class_device_release
> >   o sb1000 driver bugs
> >   o [DECNET]: Fix build warnings
> >   o [NET]: Fix sysfs kobj parent refcount handling
> >   o [NET]: Cleanup net-sysfs show and change functions
> >   o [NET]: Expose alloc_netdev() for use by drivers
> >   o [BRIDGE]: Bridge using alloc_netdev
> >   o [VLAN]: vlan network device using alloc_netdev
> >   o [TUN]: tun using alloc_netdev
> >   o [ACENIC]: Convert to alloc_etherdev
> >   o [NET]: Dynamic allocation for dummy net device
> >   o [IPV6]: Dynamic allocation for SIT net device
> >   o [IPV4]: Dynamic allocation for IPIP net device
> >   o [IPV4]: Dynamic allocation for IPGRE net device
> >   o [NET]: More reasonable error handling in SLIP driver unload
> > 
> > Steve French:
> >   o Make return code on failed cifs mounts more specific and fix
> >     incorrect smb to posix return code conversions
> >   o adjust for change of devname to const char (new mount format)
> > 
> > Steven Cole:
> >   o Use '#ifdef' to test for CONFIG options
> >   o K&R to ANSI C conversions for zlib
> >   o Yet more K&R to ANSI C conversions
> >   o More ANSI C cleanup of zlib
> >   o [SPARC]: Fix non-ansi parameter lists
> >   o Another final K&R to ANSI C cleanup of zlib
> >   o Two more sources of "non-ANSI parameter list" warnings
> >   o K&R to ANSI conversions for fs/jfs/jfs_dmap.c and jfs_xtree.c
> > 
> > Steven Whitehouse:
> >   o [AX25]: Sanitize ax25 netdevice private handling
> > 
> > Thomas Osterried:
> >   o [AX25]: AX.25 bug fixes
> > 
> > Thomas Schlichter:
> >   o [NET]: One missed non-netdev SET_MODULE_OWNER case
> >   o [NET]: IPSEC protocol module owner cleanup
> > 
> > Thomas Wahrenbruch:
> >   o USB: kobil_sct.c added support for KAAN SIM Reader
> > 
> > Trond Myklebust:
> >   o Fix udp_data_ready() to use the correct skbuff interface for
> >     extracting the XID. Following the introduction of zero-copy under
> >     UDP, the data may be entirely located in pages under
> >     skb_shinfo(skb)->frags[].
> > 
> > Ville Nuorvala:
> >   o [IPV6]: Add ip6ip6 tunnel driver
> > 
> > Zwane Mwaikambo:
> >   o cli/sti cleanup for fmvj18x
> > 
> > 
> > -
> > To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/
> > 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

