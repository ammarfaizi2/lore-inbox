Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261529AbTAIE2V>; Wed, 8 Jan 2003 23:28:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261581AbTAIE2V>; Wed, 8 Jan 2003 23:28:21 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:42255 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S261529AbTAIE2L>; Wed, 8 Jan 2003 23:28:11 -0500
Date: Wed, 8 Jan 2003 20:35:45 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Linux v2.5.55
Message-ID: <Pine.LNX.4.44.0301082033410.1438-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


All over the map again: arm, alpha, ppc, sparc, usb, isdn, dm, sysfs,
knfsd - you name it. 

		Linus


Summary of changes from v2.5.54 to v2.5.55
============================================

<adaplas@pol.net>:
  o [AGPGART]:  early agp init fix intel_agp_init() must not be
    declared static for explicit early initialization to work (ie
    i810fb).

<arnd@bergmann-dalldorf.de>:
  o [NET-DV]: Add some missing statics

<craig@homerjay.homelinux.org>:
  o Fix errors making Docbook documentation

<daniel.ritz@gmx.ch>:
  o Fix kallsyms stem compression crash
  o Stop APM initialization race from oopsing

<gerg@moreton.com.au>:
  o remove malloc.h from 68328 serial driver

<joe@fib011235813.fsnet.co.uk>:
  o dm: Don't let the ioctl interface drop a suspended device
  o dm: Correct clone info initialisation
  o dm: Correct target_type reference counting
  o dm: rwlock_t -> rw_semaphore (fluff)
  o dm: Call dm_put_target_type() *after* calling the destructor
  o dm: Remove explicit returns from void fns (fluff)
  o dm: printk tgt->error if dm_table_add_target() fails
  o dm: Simplify error->map
  o dm: Export dm_table_get_mode()
  o dm: Remove redundant error checking

<john@grabjohn.com>:
  o Fix two mis-spellings of 'kernel'

<kala@pinerecords.com>:
  o remove net config from arch-alpha
  o remove net config from arch-arm
  o remove net config from arch-cris
  o remove net config from arch-ia64
  o remove net config from arch-m68k
  o remove net config from arch-m68k_nommu
  o remove net config from arch-mips32
  o remove net config from arch-mips64
  o remove net config from arch-parisc
  o remove net config from arch-ppc
  o remove net config from arch-ppc64
  o remove net config from arch-sparc32
  o remove net config from arch-sparc64
  o remove net config from arch-superh
  o remove net config from arch-v850
  o remove net config from arch-x86
  o remove net config from arch-x86_64
  o add proper bus dependencies to net driver configs
  o add m68k dependencies to net driver config
  o Add the unified NETDEVICES submenu
  o Bring the "Networking support" menu to life

<mikal@stillhq.com>:
  o misc_register-011-002
  o xpad_typo
  o cli_sti_removal-002
  o misc_register-008-004
  o misc_register-029-004
  o misc_register-007-005

<pablo@menichini.com.ar>:
  o Handle kmalloc fails: drivers_pci_probe.c
  o [SPARC-ENVCTRL]: Handle failed kmalloc

<valko@linux.karinthy.hu>:
  o [SPARC64]: Translate IPT_SO_SET_REPLACE socket option for 32-bit
    apps

<wd@denx.de>:
  o PPC32: Add support for SPI and RISC timers to the MPC8xx commproc.h
    file.
  o PPC32: Minor updates for a few MPC8xx platforms
  o PPC32: Make the MPC8xx FEC driver PHY selection configurable
  o PPC32: Add code to support the AMD AM79C874 PHY to the MPC8xx FEC
    driver

<wrlk@riede.org>:
  o fix ide-scsi oops with abort

Adrian Bunk <bunk@fs.tum.de>:
  o remove kernel 2.0 compatibility code from i91uscsi.c
  o Remove stale zft_dirty() caller and declaration
  o remove code for 2.0 kernels from drivers/char/ftape/*

Andi Kleen <ak@suse.de>:
  o x86-64 updates for 2.5.54
  o 2.5.54 AGP driver fixes for x86-64
  o x86_64 extable fixes
  o Fix x86-64 AGPGART/IOMMU compilation

Andrew Morton <akpm@digeo.com>:
  o hugetlbfs deadlock
  o move LOG_BUF_SIZE to header/config
  o devfs mount-time readdir fix and cleanup
  o misc fixes
  o 3c59x: 3c920 support
  o copy_page_range: minor cleanup
  o infrastructure for handling pte_chain_alloc() failures
  o handle pte_chain_alloc() failures
  o infrastructure for handling radix_tree_node allocation
  o handle radix_tree_node allocation failures
  o mempool_resize fix
  o slab: redzoning cleanup
  o shrink the amount of vmalloc space reserved for kmap
  o Dynamically size the pidhash hash table
  o AIO exit fix
  o return the correct thing from direct-io
  o AIO support for raw/O_DIRECT
  o bio dirtying infrastructure
  o AIO support for raw/O_DIRECT
  o Reduced wakeup rate in direct-io code

Andries E. Brouwer <andries.brouwer@cwi.nl>:
  o scsi_scan.c
  o htmldoc fix

Anton Blanchard <anton@samba.org>:
  o ppc64: remove yaboot hooks, we dont use them on ppc64
  o ppc64: remove MSCHUNKS code from prom.c, its no longer used on
    pSeries
  o ppc64: call quiesce
  o ppc64: quieten boot wrapper a bit
  o ppc64: Makefile cleanup from Sam Ravnborg
  o ppc64: remove some old xmon code
  o ppc64: move sys32_times + sys32_newstat from Stephen Rothwell
  o ppc64: remove some old code
  o ppc64: remove xics_isa_init
  o ppc64: move xics.h into include/asm-ppc64
  o ppc64: add identifiers to asm statements, makes reading disassembly
    slightly easier
  o ppc64: wrap pSeries and iSeries specific code
  o ppc64: Split up pSeries and iSeries specific files, helps with
    bloat and TOC utilisation
  o ppc64: Makefile cleanup from Sam Ravnborg
  o ppc64: support for > 32 CPUs (24 way RS64 with HMT shows up as 48
    way)
  o ppc64: Fix for memcpy from paulus
  o ppc64: Add readahead ioctls
  o ppc64: restore FB ioctls
  o ppc64: eliminate the rest of the __kernel_..._t32 typedefs from
    Stephen Rothwell
  o ppc64: update
  o small module patch

Benjamin Herrenschmidt <benh@kernel.crashing.org>:
  o PPC32: Extend CPU and idle handling for new 7xx/7xxx PPC cpus
  o PPC32: Update L2/L3 cache control register handling (from 2.4)

Bjorn Helgaas <bjorn_helgaas@hp.com>:
  o [AGP] Remove bogus AGP/DRM assumptions [Forward port of a 2.4 patch
    that got applied last month -- DJ] 
  o [AGP] size AGP mem correctly when memory is discontiguous
  o 440GX AGP update
  o i810/i830 AGP update

Bob Miller <rem@osdl.org>:
  o Remove unused function from radeon_mem.c
  o Fixed ifdefs for a label in ncpfs_sock.c

Chris Wilson <chris@qwirx.com>:
  o misc_register sx.c version 2
  o Kernel Janitors patch to drivers_macintosh_ans-lcd.c
  o ip27-rtc.c create_proc_read_entry patch
  o perf.c misc_register patch
  o drivers_macintosh_via-pmu_.c
  o drivers_sgi_char_streamable.c misc_register patch
  o drivers_sgi_char_usema.c misc_register patch
  o cli_sti in drivers_net_irda_sa1100_ir.c

Christoph Hellwig <hch@infradead.org>:
  o Fix PCMCIA SCSI driver build

Dave Jones <davej@codemonkey.org.uk>:
  o [AGP] add agp_num_entries() function to determine GATT table size -
    reserved IOMMU entries
  o [AGP] Move the VIA KT400 to its own driver
  o [AGP] Add debug info to failure path of AGP 3.0 rate enabling
  o [AGP] VIA KT400 AGP 3.0 aperture size decoding
  o [AGP] Flesh out the VIA KT400 driver some more
  o [AGP] VIA VT8235/P4X400 GART support (based upon 2.4 patch from
    Richard Baverstock <beaver@gto.net>)
  o [AGP] Clean up some comments
  o [AGP] P4X333 uses same northbridge as P4X400 Also renumber it. (The
    previous patch used the number of the southbridge by mistake)
  o x86-64 RAID XOR compile fix
  o Fix READ_CD fallback
  o CDROM changers timeout tweak
  o Wacky gdth driver vendor update
  o P4 typo
  o CREDITS updates
  o Appletalk bits depend on ISA/EISA
  o yenta comment typo
  o Missed checks in hisax
  o Make ip2 module variable dependant on CONFIG_MODULE
  o Missing check in PCI hotplug
  o Fix up dma_alloc_coherent with 64bit DMA masks on i386
  o zoran ioctl sleeping fixes
  o x86-64 pmd corruption fix
  o size_t fixes
  o tracer pid
  o Correct header
  o Remove broken prefetching in free_one_pgd()
  o x86-64 spinlock code typo
  o compiler warning silence
  o EDD typo
  o signal.h -W cleanup
  o Remove unneeded CONFIG_X86_USE_STRING_486
  o Remove unused proto

Dave Kleikamp <shaggy@shaggy.austin.ibm.com>:
  o JFS: In jfs_extendfs, brelse was being called with wrong bufferhead
  o JFS: Clean up flushing outstanding transactions to journal
  o JFS: add sync_fs super_operation
  o JFS: define aio_read and aio_write file_operations

David Jeffery <david_jeffery@adaptec.com>:
  o ips driver 1/3: remove 2.2 kernel compat code
  o ips driver 2/3: adapter error handling fixes
  o ips driver 3/3: code cleanup

David S. Miller <davem@nuts.ninka.net>:
  o [AIC7xxx]: aic7xxx_osm.h needs asm/io.h, this keeps being deleted
    by Justin :(
  o [SPARC]: Kill ide intr lock crap from asm ide.h headers
  o [SPARC64]: Add dummy archclean target
  o [USB]: core/hcd.c needs dma-mapping.h
  o [USB]: Add missing quotes in ohci debugging snprintf
  o [SPARC64]: Only include linux/cache.h in asm/smp.h if not assembler
  o [NFS4]: Use proper printf format for size_t
  o [SPARC64]: Add dummy archmrproper rule
  o [SPARC64]: Fix aic7xxx kconfig path
  o [SPARC]: sbus.c ifdeffing cleanup
  o [SPARC64]: flock compat changes
  o kernel/pid.c: Use proper size_t printf format string
  o [SPARC64]: Fix typos in Rustys extable changes
  o [SUNRPC]: svcauth.h needs linux/string.h
  o [CRC32]: Fix pointer casts on 64-bit
  o [SUNGEM]: Add warning to ppc code wrt. MAX_ADDR_LEN change
  o [NET]: Remove dup wireless.h include in socket.c

Dipankar Sarma <dipankar@in.ibm.com>:
  o [IPV4]: barriers in lockfree rtcache

Dominik Brodowski <linux@brodo.de>:
  o cpufreq: p4-clockmod bugfixes
  o cpufreq: elanfreq cleanup and compile fix
  o cpufreq: update timer notifier

Geert Uytterhoeven <geert@linux-m68k.org>:
  o Remove unused prototype for init_modules()

Gerd Knorr <kraxel@bytesex.org>:
  o add tda9887 module
  o video-buf.c update
  o add v4l1-compat module
  o bttv driver update
  o update bttv documentation
  o add bt832 module
  o media/video i2c updates
  o i2c update for tuner.c
  o saa7134 driver update

Greg Kroah-Hartman <greg@kroah.com>:
  o IBM PCI Hotplug: fix compile time error due to find_bus() function
    name
  o PCI: properly unregister a PCI device if it is removed
  o PCI hotplug: clean up the try_module_get() logic a bit

Hideaki Yoshifuji <yoshfuji@linux-ipv6.org>:
  o [IPV6]: Fix Length of Authentication Extension Header

Hugh Dickins <hugh@veritas.com>:
  o I/O APIC confusion
  o demystify do_boot_cpu stack

James Bottomley <jejb@raven.il.steeleye.com>:
  o parisc update for 53c700/lasi700
  o shuffle sr_ioctl include ordering for parisc
  o update ncr53c8xx to new dma_ API (needed to incorporate zalon)

James Morris <jmorris@intercode.com.au>:
  o [SUNSAB]: Bug fixes for new sunsab uart driver

Jeff Garzik <jgarzik@redhat.com>:
  o [netdrvr mii] fix ugly lack of useful bit masking
  o [netdrvr] add AMD-8111 ethernet driver (yet another PCI lance)
  o [netdrvr eepro100] new pci id
  o [netdrvr de4x5] fix uninitializer timer
  o [netdrver e1000] wol updates
  o [netdrvr e1000] restore VLAN settings after resume
  o [netdrvr e1000] small cleanups and fixes
  o [netdrvr e100] Bug fix: system panic in watchdog when repeating
    ifdown, rmmod, insmod
  o [netdrvr e100] Bug fix: enable/disable WOL based on EEPROM settings
  o [netdrvr e100] fix ethtool/mii interface up/down issues
  o [IrDA] s/MOD_foo_COUNT/SET_MODULE_OWNER/ cleanups
  o [netdrvr] ethernet crc fixes
  o [netdrvr e100] better debugging for command failures/timeouts
  o [netdrvr e100] changelog/whitespace updates, small fixes
  o [netdrvr amd8111e] add to drivers/net/Makefile.lib too, as it uses
    crc32

Justin T. Gibbs <gibbs@overdrive.btc.adaptec.com>:
  o Update the aic7xxx Makefile so that the register information tables
    are not rebuilt on every build.
  o aic7xxx/aicasm
  o aic7xxx and aic79xx drivers Correct several DV issues
  o aic7xxx and aic79xx driver updates

Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>:
  o ISDN/HiSax: Fix compilation for !CONFIG_ISAPNP
  o ISDN/HiSax: Remove unused B-Channel callbacks
  o ISDN/HiSax: un-virtualize W6692 B-Channel access
  o ISDN/HiSax: Helper functions for B-Channel {read,write}_reg()
  o ISDN/HiSax: Move BC_{Read,Write}_Reg into struct bc_hw_ops
  o ISDN/HiSax: Un-virtualize D-channel access in hfc_2bds0.c
  o ISDN/HiSax: Un-virtualize D-channel access in w6692.c
  o ISDN/HiSax: Helper functions for D-Channel {read,write}_reg() etc
  o ISDN/HiSax: Move isac{read,write}{,fifo} into struct dc_hw_ops
  o ISDN/HiSax: Simplify readreg()/writereg() use
  o ISDN/HiSax: Use u8 instead of u_char
  o ISDN/HiSax: Renaming ReadISAC -> isac_read etc
  o ISDN/HiSax: Add B-Channel FIFO ops
  o ISDN/HiSax: Use {isac,hscx}_{read,write} and friends
  o ISDN/HiSax: Un-inline hscx_irq.c
  o ISDN/HiSax: Un-inline jade_irq.c
  o ISDN/HiSax: Remove unnecessary locking
  o ISDN/HiSax: "ops" structure for the shared xmit handling

Linus Torvalds <torvalds@home.transmeta.com>:
  o Fix befs/romfs breakage from vfs.h cleanups by Christoph
  o Needs <linux/string.h> for strlen()
  o Move x86 signal handler return stub to the vsyscall page, and stop
    honoring the SA_RESTORER information.
  o Make vm86 traps correctly distinguish between vm86 and kernel mode

Luca Barbieri <ldb@ldb.ods.org>:
  o Fix sysenter iopl
  o Fix sysenter (%ebp) fault handling
  o Introduce TIF_IRET and use it to disable sysexit

Martin J. Bligh <mbligh@aracnet.com>:
  o create generalised apic_to_node mapping
  o make i386 topology caching
  o changes do_boot_cpu to return an error code
  o move one more to subarch, general tidy up
  o cleanup apicid <-> cpu mapping
  o remove clustered_apic_mode from smpboot.c
  o nuke clustered_apic_mode and friends

Martin Mares <mj@ucw.cz>:
  o PCI IDs update

Mikael Pettersson <mikpe@csd.uu.se>:
  o fix ide-cd/ide-scsi oopses after module unload

Neil Brown <neilb@cse.unsw.edu.au>:
  o knfsd: Avoid opps when NFSD decodes bad filehandle
  o knfsd: Fix bug in RPC cache when entry in replaced
  o knfsd: Fix some bugs in qword management
  o knfsd: Handle -EAGAIN from exp_find properly in nfsfh.c
  o knfsd: Don't assume a reader on an RPC cache channel at statup
  o knfsd: rpc/svc auth_unix tidyup
  o knfsd: Allow rpcsvc caches to provide a 'cache_show' method
  o knfsd: Provide content file for auth.unix.ip cache
  o knfsd: Provide 'flush' interface for userspace to flush rpc/svc
    caches
  o knfsd: Fixes for nfsd filesystem files
  o knfsd: Change names of legacy interfaces in nfsd filesys to start
    with period
  o knfsd: Add 'filehandle' entry for nfsd filesystem for looking up a
    filehandle
  o knfsd: Add 'threads' file to nfsd filesystem to allow changing
    number of threads
  o knfsd: Use hash_long from hash.h for hashing in rpc/svc caches
  o knfsd: NFSv4 server fixes
  o md: Make sure yielding thread actually yields cpu when waiting for
    turn at reconstruct
  o md: Make MD device-is-idle test check whole device, not partition
  o md: Record location of incomplete resync at shutdown and restart
    from there

Patrick Mochel <mochel@osdl.org>:
  o kobjects: minor updates
  o fs/partitions/check.c - minor updates
  o driver model: eliminate struct device_driver::bus_list
  o driver model: get correct pointer of interfaces from data
  o Deprecate /proc/pci
  o kobject.h - add check that we're being included by other kernel
    entities
  o kobject: Introduce struct kobj_type
  o driver model: clean up struct bus_type a bit
  o driver model: clean up struct device_class a bit
  o Introduce struct kset
  o kobjects: Remove kobject::subsys and subsystem::kobj
  o edd: fix up for changes in kobject infrastructure
  o acpi: use decl_subsys() macro
  o remove kernel/platform.c
  o block devices: use list and lock in block_subsys, instead of those
    defined in genhd.c
  o net devices: Get network devices to show up in sysfs
  o bus drivers: fix leaking refcounts
  o driver model: allow manual binding of devices to drivers
  o add kset_find_obj() to search for object in a kset's list
  o Implement find_bus() for finding a struct bus_type by name
  o Update kobject documentation

Paul Mackerras <paulus@samba.org>:
  o PPC32: Update the support for the IBM 40x embedded PowerPC chips
    and boards
  o PPC32: Fix so that we don't use the 6xx-specific idle code on
    POWER3
  o PPC32: remove support for IBM iSeries machines
  o PPC32: create arch/ppc/platforms/4xx/Kconfig and move the config
  o PPC32: Fix an oops that could happen if ptrace caused a page fault
  o PPC32: Misc. updates to arch/ppc/Kconfig
  o PPC32: Makefile and other fixes for the boot wrappers
  o PPC32: Use non-pinned large-page TLB entries for kernel RAM mapping
  o PPC32: adapt platform code to changes in i8259 PIC code
  o PPC32: Use C99 initializer syntax in INIT_THREAD
  o PPC32: move some declarations from asm/pci-bridge.h to asm/prom.h
  o PPC32: Move IRQ sense/polarity definitions from open_pic.h to irq.h
  o PPC32: use CONFIG_FRAMEBUFFER_CONSOLE for logo rather than
    CONFIG_FB
  o PPC32: Move files for the "oak" 403-based platform in with the
  o PPC32: Update the defconfigs
  o PPC32: remove execute permission from some ppc source files
  o PPC32: Add support for the IBM405LP-based "Beech" board
  o PPC32: Add support for the "Redwood-6" STB03xxx-based eval board
  o PPC32: Add support for new IBM embedded PPC cpus

Pete Zaitcev <zaitcev@redhat.com>:
  o [SPARC]: Add Ravnborg Makefile cleanups
  o [SPARC]: Include file cleanups, fixes restart_block compile
  o [SPARC]: Build problem in ksyms
  o [SPARC]: Eric Browers sbus interrupts decoders

Ravikiran G. Thirumalai <kiran@in.ibm.com>:
  o [NET]: Convert sockets_in_use to use per_cpu areas
  o [IPV4]: Convert mibstats to use kmalloc_percpu
  o [IPV6]: Convert mibstats to use kmalloc_percpu
  o [SCTP]: Convert mibstats to use kmalloc_percpu
  o [IPV4]: Convert rt_cache_state to use kmalloc_percpu

Ray Lee <ray-lk@madrabbit.org>:
  o Re: unix_getname buglet - > 2.5.4(?)

Richard Henderson <rth@twiddle.net>:
  o [ALPHA] ET_REL modules support
  o [ALPHA] Export scr_memcpyw for modular fbcon
  o [TGAFB] Implement the fb_fillrect hook
  o [TGAFB] Implement the fb_copyarea hook
  o [MODULES] Fix compiler warning wrt try_module_get when modules are
    disabled.
  o [FB] Re-add fb_readq for non-sparc
  o [ALPHA] Distribute the irq and extra device init routines in
    arch/alpha/kernel/ to the config options that need them.  Fix a few
    build problems for XLT and RX164.
  o [ALPHA] Makefile cleanup from Sam Ravnborg <sam@ravnborg.org>
  o [ALPHA] Corrections to last makefile patch
  o [ALPHA] Update for generic exception table cleanup
  o [ALPHA] Adjust signature of module_frob_arch_sections
  o fix alpha boot oops

Richard Hirst <rhirst@linuxcare.com>:
  o Add parisc Zalon SCSI card

Rob Radez <rob@osinvestor.com>:
  o [SPARC]: Add param section to linker script

Robert Love <rml@tech9.net>:
  o remove wavelan_cs warning

Roland Dreier <roland@topspin.com>:
  o [NET]: Increase MAX_ADDR_LEN

Russell King <rmk@flint.arm.linux.org.uk>:
  o [ARM] Fix up location of Acorn font file
  o [ARM] Fix child-structure named initialisers
  o [ARM] Semaphore functions need to be memory barriers
  o [ARM] Add restart block infrastructure
  o [ARM] Add __param section for kernel/module parameters
  o [ARM] Fix up {__,}put_user macros
  o [ARM] Allow arch/arm/kernel/asm-offsets.s to be regenerated
  o [ARM] Convert semaphore initialisers to C99 syntax
  o [ARM] IOP310 build fixes
  o [ARM] Allow arch/arm/kernel/bios32.c to build for iop310
  o [ARM] Make jornada720 build again
  o [ARM] Minor fixes to drivers/pcmcia/sa1111_generic.c
  o [ARM] Fix ups for ARM generic dma mapping interface
  o [ARM] Sanitise sa1111 and neponset device driver names
  o [ARM] Update mach-types
  o [ARM] Add basic support for enable/disable_irq_wake
  o [ARM] Add support for IRQ-based wakeup for SA11x0 CPUs
  o [ARM] Add IRQ wake support for SA1111 PS/2 interfaces

Rusty Russell <rusty@rustcorp.com.au>:
  o Modules: fix plt sections
  o Use sh_entsize for ELF section offsets
  o MODULE_LICENSE and EXPORT_SYMBOL_GPL support
  o Exception table cleanup
  o /proc/modules change
  o Fix BUG() decl warning in smp.h for UP
  o Update MAINTAINERS for modules
  o "constfrobbing considered harmful"
  o Remove mod_bound macro and unify kernel_text_address()

Stephen Rothwell <sfr@canb.auug.org.au>:
  o x86 savesegment() cleanup
  o better compat_jiffies_to_clock_t
  o compat_flock: generic
  o compat_flock: ppc64
  o compat_flock: x86_64
  o compat_flock: ia64
  o compat_flock: s390x
  o [SPARC64]: Kill __kernel 32-bit compat types, use compat_foo
    instead
  o {get,put}_compat_timspec: generic
  o {get,put}_compat_timspec: s390x

Thibaut Varene <varenet@parisc-linux.org>:
  o linux-2.5.46: Remove unused static variable

Thomas Sailer <sailer@scs.ch>:
  o 2.5.54: fix oopsable bug in OSS PCI sound drivers

Tom Callaway <tcallawa@redhat.com>:
  o [SUNLANCE]: Add missing asm/machine.h include for sun4 builds

Tom Rini <trini@kernel.crashing.org>:
  o PPC32: Cleanup the questions under CONFIG_ADVANCED_OPTIONS
  o PPC32: Fix a delay which could occur when booting on machines
    without an RTC.
  o PPC32: Add explicit parens to the _ALIGN macro
  o PPC32: Fix some 'prep' machines which are not true PRePs, and can
    safely poll for interrupts on the i8259.
  o PPC32: Fix a problem in the bootloader/wrapper where we might
  o PPC32: Remove extra __KERNEL__ checks in some headers, as well as
    adding /* __KERNEL__ */ to the #endif of others.

Tomas Szepe <szepe@pinerecords.com>:
  o unify netdev config follow-up
  o [NET]: Protect secpath references in skbuff.c with CONFIG_INET

Trond Myklebust <trond.myklebust@fys.uio.no>:
  o Fix NFS 'off by one' bug
  o allow arbitrary alignment of NFS read/write requests
  o Cleanup for SunRPC auth code

William Stinson <wstinson@wanadoo.fr>:
  o remove check_region in drivers_isdn_hisax_mic.c
  o remove check_region from drivers_isdn_hisax_sedlbauer.c
  o remove check_region calls from drivers_telephony_ixj.c
  o remove check_region from drivers_isdn_hisax_asuscom.c
  o remove check_region from drivers_isdn_hisax_enternow_pci.c
  o remove check_region from drivers_isdn_hisax_teles0.c
  o remove check_region from drivers_isdn_hisax_w6692.c
  o remove check_region from isdn_hisax_s0box.c
  o remove check_region from fdc-io.c version 2
  o remove check_region from drivers_isdn_hisax_avm_pci.c
  o remove check_region from drivers_isdn_hisax_bkm_a8.c
  o remove check_region from sportster.c
  o remove check_region from nj_u.c
  o remove check_region from Documentation_DocBook_videobook.tmpl
  o remove check_region from saphir.c
  o [SPARC-BPP]: remove check_region


