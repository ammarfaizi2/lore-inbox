Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265404AbTFVSk4 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Jun 2003 14:40:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265408AbTFVSk4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Jun 2003 14:40:56 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:13331 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id S265404AbTFVSjV convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Jun 2003 14:39:21 -0400
Date: Sun, 22 Jun 2003 11:53:14 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Linux 2.5.73
Message-ID: <Pine.LNX.4.44.0306221150440.17823-100000@old-penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
X-MIME-Autoconverted: from 8bit to quoted-printable by deepthought.transmeta.com id h5MIrEB29349
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Various updates all over the map here. Lots of ia64 updates, and Andrew 
merged the ext3 locking cleanups/fixes that have been in the -mm tree for 
a while.

		Linus

---

Summary of changes from v2.5.72 to v2.5.73
============================================

<a.wegele:tu-bs.de>:
  o input: logical maximum and minimum can have the same value in HID

Adam Belay:
  o [PNP] Resource Management Cleanups and Updates
  o [PNP] /drivers/pnp/resource.c check_region warning fix
  o [PNP] Module Compilation Fix
  o [PNP] PnPBIOS resource setting fix
  o [PNP] re-add the previously removed "get" command in interface.c
  o [PNP] Trivial Typo fix regarding DMAs
  o [PNP] Remove some leftover resource config options in isapnp
  o [PNP] Important Resource Parsing Fixes

Adrian Bunk:
  o aha1740.c doesn't compile
  o [NET]: Fix namespace pollution in two wireless drivers
  o [netdrvr ixgb] fix clash with newly-updated ethtool.h

Alan Stern:
  o USB: Keep root hub status timer running during suspend
  o USB: Use separate transport_flags bits for transfer_dma

Alex Tsariounov:
  o ia64: small patch for arch/ia64/lib/Makefile for xor.o

Andi Kleen:
  o Remove copied inet_aton code in bond_main.c
  o Remove spinlock workaround for pre 2.95 gccs

Andreas Schwab:
  o ia64: fix ia32 sched_{s,g}etaffinity()

Andrew Morton:
  o ext3: move lock_kernel() down into the JBD layer
  o JBD: journal_get_write_access() speedup
  o ext3: concurrent block/inode allocation
  o ext3: scalable counters and locks
  o JBD: fix race over access to b_committed_data
  o JBD: plan JBD locking schema
  o JBD: remove jh_splice_lock
  o JBD: fine-grain journal_add_journal_head locking
  o JBD: rename journal_unlock_journal_head to
  o JBD: Finish protection of journal_head.b_frozen_data
  o JBD: implement b_committed_data locking
  o JBD: implement b_transaction locking rules
  o JBD: Implement b_next_transaction locking rules
  o JBD: b_tnext locking
  o JBD: remove journal_datalist_lock
  o JBD: t_nr_buffers locking
  o JBD: t_updates locking
  o JBD: implement t_outstanding_credits locking
  o JBD: implement t_jcb locking
  o JBD: implement j_barrier_count locking
  o JBD: implement j_running_transaction locking
  o JBD: implement j_committing_transaction locking
  o JBD: implement j_checkpoint_transactions locking
  o JBD: implement journal->j_head locking
  o JBD: implement journal->j_tail locking
  o JBD: implement journal->j_free locking
  o JBD: implement journal->j_commit_sequence locking
  o JBD: implement j_commit_request locking
  o JBD: implement dual revoke tables
  o JBD: remove remaining sleep_on()s
  o JBD: remove lock_kernel()
  o JBD: remove lock_journal()
  o JBD: journal_release_buffer: handle credits fix
  o JBD: journal_unmap_buffer race fix
  o ext3: ext3_writepage race fix
  o JBD: buffer freeing non-race comment
  o JBD: add some locking assertions
  o JBD: additional transaction shutdown locking
  o JBD: fix log_start_commit race
  o JBD: do_get_write_access() speedup
  o ext3: fix data=journal mode
  o JBD: journal_try_to_free_buffers race fix
  o ext3: add a dump_stack()
  o ext3: fix error-path handle leak
  o ext3: Fix leak in ext3_acl_chmod()
  o ext3: remove mount-time diagnostic messages
  o JBD: journal_dirty_metadata() speedup
  o JBD: journal_dirty_metadata diagnostics
  o JBD: fix race between journal_commit_transaction and
  o ext3: fix data=journal for small blocksize
  o JBD: remove j_commit_timer_active
  o ext3: explicitly free truncated pages
  o JBD: log_do_checkpoint() locking fixes
  o JBD: fix locking around log_start_commit()
  o JBD: hold onto j_state_lock after
  o ext3: disable O_DIRECT in journalled-data mode
  o ia32 copy_from_user() fix
  o kjournald shutdown fix
  o range checking in rd_open()
  o Fix /proc/kcore for i386
  o /proc/kcore: handle unmapped areas
  o Add system calls statfs64 and fstatfs64
  o kmem_cache_destroy(): use slab_error()
  o slab poisoning fix
  o Fix potential set_child_tid/clear_child_tid bug
  o revert adjtimex changes
  o show_stack() portability and cleanup patch
  o sysv semundo fixes
  o raw.c devfs support
  o hugetlbfs: specify size & inodes at mount
  o hugetlbfs:update statfs
  o misc fixes
  o Permit big console scrolls
  o remove swapper_inode
  o dirty inode writeback fix
  o workqueue.c subtle fix and core extraction
  o proc_pid_lookup use-after-free fix
  o Fix kmod return value
  o mach-generic build fix
  o Fix suspend with NFS mounts active
  o Fix binfmt_elf.c bug on ppc64
  o node-local allocation for hugetlbpages
  o highmem.h needs mm.h
  o Restore Daniel Phillips' copyright
  o JBD: honour read-only mounts more carefully
  o ext3/JBD: remove trailing whitespace
  o psmouse compile fix
  o Fix CIFS breakage from the statfs64 patch

Andy Grover:
  o ACPI: Add ASUS Value-add driver (Karol Kozimor and Julien Lerouge)
  o ACPI: Re-add acpitable.c and acpismp=force. This improves backwards
    compatibility and also cleans up the code to a significant degree.
  o ACPI: Mention acpismp=force in config help
  o ACPI: Export acpi_disabled for sonypi (Stelian Pop)
  o ACPI: acpiphp update (Takayoshi Kochi)
  o ACPI: Interpreter update to 20030619

Anton Blanchard:
  o Fix compat_sys_getrusage.  Again

Arnaldo Carvalho de Melo:
  o o sock: remove sk_prev
  o o ipx: fix var shadowing paramente with CONFIG_IPX_INTERN is
    enabled
  o o net: make sk_{add,del}_node functions take care of sock
    refcounting
  o o llc: don't use inverted logic
  o input: fix double kfree of device->rdesc on hid_parse_parse error
    path in hid-core.c
  o fix sysfs bogosity in i82365.c

Art Haas:
  o [SPARC]: C99 initializers for xor.h
  o C99 initializers for asm-alpha/include/xor.h

Arun Sharma:
  o ia64: make ia32 ioctl()s work again
  o ia64: fix IA-32 emulation of msgctl()
  o ia64: fix IA-32 version of shmctl()
  o ia64: work around race conditions in ia32 support code

Asit K. Mallick:
  o ia64: replace RAID xor routine into an assembly file
  o ia64: three more fph fixes (all UP-related)

Bart De Schuymer:
  o [NET]: Let arptables see bridged arp traffic

Chas Williams:
  o [ATM]: Split atm_ioctl into vcc_ioctl and atm_dev_ioctl
  o [ATM]: Remove recvmsg and rename atm_async_release_vcc
  o [ATM]: Keep vcc's on global list instead of per device
  o [ATM]: Fix possible unlock of a non-locked lock in HE driver

Christoph Hellwig:
  o ISDN: [PATCH] switch pcmcia isdn drivers to pcmcia_register_driver
  o give all LLDD driver a ->release method
  o don't create /proc/scsi/ entries for drivers without
  o kill reamining scsi_scan.c typedef abuse
  o fix sd medium removal handling
  o constants.c codingstyle fixes
  o scsi_ioctl.c codingstyle fixes
  o fix parameter naming
  o kill scsihosts= boot parameter
  o introduce scsi_host_alloc
  o revamp legacy host registration
  o kill blk_nohighio boot parameter
  o kill unused scsi_device fields
  o kill some sysfs left-overs in st
  o cleanup device_busy/host_busy handling
  o rename struct SHT to something sensible
  o consolidate legacy typedefs in one place
  o missing scsi_host_alloc bits
  o update lasi700 to new style template
  o don't dereference sdev->access_count in dpt_i2o
  o some sd.c code consolidation
  o kill 53c700 ->proc_info
  o remove an unused variable from scsi.c
  o remove superflous ->command instances
  o start moving and splitting the scsi headers
  o more header reshuffling
  o kill of ->command

Daniel Ritz:
  o xirc2ps_cs update
  o xirc2ps_cs update

Dario Ballabio:
  o eata and u14-34f update

Dave Jones:
  o input: remove unused var from serio struct

David Brownell:
  o USB:  ehci-hcd: short reads, chip workaround, cleanup
  o USB: ehci, fix qh re-activation problem
  o USB: ehci-hcd micro-patch
  o USB: net2280, halt ep != 0
  o USB: usbnet talks to boot loader (blob)

David Mosberger:
  o ia64: Clean up purge-page-size-from-PAL patch a bit
  o ia64: Allow 4GB TLB purges by default.  Reported by Rohit Seth
  o ia64: Fix ptrace() RNaT accessors
  o ia64: Couple of minor NEW_LOCK spinlock fixes.  Put RAID5 xor
    routines only into kernel if CONFIG_MD_RAID5 is declared.
  o ia64: Move ia64 ELF relocations to ia64-specific elf.h
  o ia64: Patch by Arun Sharma: Undo bad sys32_select() fix: The
    biggest value of n below is INT_MAX and the value of size for n =
    INT_MAX is 268435456. So I don't think there'll be an overflow.
  o ia64: Fix SMP fph-handling.  Patch by Asit Mallick with some
    additional changes by yours truly.
  o ia64: Fix various minor merge errors and build errors.  Fix
    page-fault handler so it handles not-present translations for
    region 5 (patch by John Marvin).
  o Check in new SN2 file from Jes' gettimeoffset() patch
  o ia64: Fix typo in do_settimeofday()
  o ia64: Desupport GCC 2.96 and everything older
  o ia64: Fix Makefile typo and retain -frename-registers for Itanium
  o ia64: Fix more merge errors.  Correct SN2 callbacks to also invoke
    the generic ia64 callbacks so last_nsec_offset gets updated, too.
  o ia64: Fix obsolete call to ia64_set_fpu_owner() (affected UP only)
  o ia64: Re-enable -frename-registers for McKinley
  o ia64: Make Ski bootloader work with virtually-mapped kernel
  o ia64: Fix UP build: ia64_spinlock_contention() is for SMP only
  o ia64: Update for new time_interpolator infrastructure
  o ia64: More time-interpolation cleanups; correct SN2 interpolator
  o ia64: Remove unnecesary include of <asm/offsets.h>
  o ia64: Make hugetlb support compile again
  o ia64: Fix unwinder so core-dumps work again.  Without this patch,
    most scratch-regs came out wrong.
  o ia64: Restructure pt_regs and optimize syscall path
  o ia64: Patch by Arun Sharma: In the absence of the patch, this
    system call fails:
  o ia64: Lots of formatting fixes for the optimized syscall paths
  o ia64: Reformat .mem.offset directives.  Affects many lines, but
    they're all whitespace changes only.
  o ia64: In start_thread(), remove the clearing of the scratch
    registers which are now cleared by the syscall exit path.
  o ia64: Make fsyscalls work again.  They broke because the
    streamlined syscall path didn't preserve b6 and r11 anymore. 
    Unfortunately, preserving them costs a few cycles (~5 cycles in the
    cached case).  The uncached case is hopefully mostly unaffected
    because the number of cache-lines touched is the same (without
    preserving b6 and r11, the entry-patch _almost_ got away with
    touching a single 128-byte cacheline, but not quite, because r8
    also had to be initialized).
  o ia64: Implement a first cut of a streamlined fsys_fallback_syscall
  o ia64: Minor fixes: remove obsolete ia64_ret_from_execve_syscall()
    and fix bit rot in signal debug printk.
  o ia64: Fix typo introduced on May 28 which had the effect of
    asynchronous signals corrupting r14.
  o ia64: Small formatting fixes
  o ia64: Finish the fsyscall support (finally!).  Now fsyscall stubs
    will run faster than break-based syscall stubs, even if there is no
    light-weight syscall handler.
  o .del-print_offsets.awk~ce325580e04f9929
  o ia64: Patch by Tony Luck: The INIT path was broken by the virtually
    mapped kernel patch.  This patch makes it work again.  The MCA path
    is similarly broken.  Patch will follow later.
  o ia64: Based on patch by Rohit Seth: Use "hint @pause" in more
    places
  o ia64: Fix unwinder bug which caused it to allocate more memory than
    strictly necessary.
  o ia64: Make task allocation/freeing compatible with the improved
    generic kernel infrastructure.
  o ia64: Move force_successful_syscall_return() from ptrace.h to
    unistd.h
  o ia64: Misc small fixe: adjust for 2-argument version of
    show_stack(), remove left-over bits from the old
    task-creation/destruction hacks.  Fix typo in comment for
    pgprot_noncached().
  o ia64: Remove no longer needed show_trace_task()
  o ia64: Move RGN_MAP_LIMIT from pgtableh to page.h and use that in
    ustack.h so we can escape include-hell.
  o ia64: Make kernel work better on machines with I/O MMU hardware
  o mca.h, mca_asm.S, mca.c
  o perfmon_generic.h, perfmon.c, Makefile
  o handle_fpu_swa() doesn't scale well if multiple CPUs need
    concurrent fp assist.  The problem lies with concurrent,
    potentially frequent updates of fpu_swa_count, which serves as the
    throttle for doing the printk().  A frenzy of concurrent updates
    will produce a frenzy of cacheline ping-ponging.
  o smpboot.c, acpi.c
  o ia64: Get rid of pci_dma_bus_is_phys in favor of
    ia64_max_iommu_merge_mask
  o ia64: Andrew changed his mind about the location of
    force_successful_syscall_return(), so move it back to ptrace.h.
  o ia64: No early printk for GENERIC
  o ia64: Add back lost change for PCI_DMA_BUS_IS_PHYS
  o ia64: Split ia32-only definitions into separate ia32int.h header
    file
  o ia64: Two small fixes: fix Makefiles so "make clean" removes
    .offsets.h.stamp.  Remove unused variable in acpi-ext code.
  o ia64: Build the gate page(s) as an ELF DSO
  o patch.c
  o ia64: Minor cleanups: export more symbols, remove uncessary stop
    bits
  o ia64: Fine-tune the gate DSO support a bit
  o Export some more symbols to get tg3.c to build as a module
  o pgtable.h
  o ia64: Still more gate DSO tuning.  Turns out a linker bug prevented
    us from building the gate DSO in a way that makes it fit in <= 1
    page. If a fixed linker is available, we do it in this space-saving
    way now. Otherwise, we'll do it the old way (the gate DSO will then
    take up about 18KB instead of just ~3KB).  Thanks to Roland McGrath
    for making this all work.
  o ia64: Make brl-branches to ia64_spinlock_contention work from
    modules
  o PCI: move pci_domain_nr() inside "#ifdef CONFIG_PCI" bracket
  o ia64: Sync with 2.5.71
  o ia64: Initial sync with 2.5.72
  o re-enable the building of 8250_hcdp and 8250_acpi
  o Add 2 HP PCI ids
  o init_thread_union really needed by modules?

David S. Miller:
  o [SPARC64]: Fix wal_to_monotonic initialization
  o [SPARC]: Fix wall_to_monotonic initialization
  o [ATM]: Revert vcc global list changes, broke the build
  o [SPARC]: ESP scsi driver already has a release method, do not add a
    second one :-)
  o [NET]: Mark skb_linearize() as deprecated
  o [NET]: Check for flow cache allocation failure
  o [NET]: Size hh_cache->hh_data more appropriately
  o [AIC79XX]: Protect ahd_linux_pci_reserve_mem_region with MMAPIO
  o [KCONFIG]: Fix pointer cast from int in mconf.c
  o [INITRAMFS]: Use correct size_t printf format in gen_init_cpio.c
  o [PROC]: Printf field widths must be of type int, fix this in
    task_mmu.c
  o [SOUND]: Fix 64-bit warnings in korg1212 driver
  o [AACRAID]: Fix 64-bit warnings/errors
  o [NET]: Don't compare a dma_addr_t with NULL in pcnet32.c
  o [NET]: Use proper size_t printf format specifier in sundance.c
  o [IRDA]: Fix 64-bit warnings
  o [TELEPHONY]: Fix 64-bit warnings in ixj.c 1) Use unsigned long for
    types holding jiffies.
  o [NCPFS]: Use proper size_t printf format specifier in sock.c
  o [SPARC64]: Update defconfig
  o [NET]: Fix ppp_async tty discipline module ref counting
  o [IPV4]: Do not use skb_linearize() in ARP handling
  o [IPV6]: Do not use skb_linearize() in ICMP/NDISC handling

David Stevens:
  o [IPV4/IPV6]: Make sure SKB has enough space while building IGMP/MLD
    packets
  o [IPV4/IPV6]: Fix IGMP device refcount leaks, with help from
    yoshfuji@linux-ipv6.org

David T. Hollis:
  o USB: AX8817X Driver for 2.5

Deepak Saxena:
  o [ARM PATCH] 1553/1: BE support for __put_user_asm_dword()

Dominik Brodowski:
  o pci: add Asus P4G8X Deluxe to asus_hides_smbus quirk

Duncan Sands:
  o USB speedtouch: add module parameters

Fenghua Yu:
  o ia64: performance-tweak syscall exit path some more

Frank Cusack:
  o nfs_unlink() fix and trivial nfs_fhget cleanup

Gabriel Devenyi:
  o input: Fix gameport.c - gameport was never closed after calibrating

Greg Kroah-Hartman:
  o I2C: add lm78 chip to Makefile
  o USB: fixed up some __user warnings reported by sparse in
    drivers/usb/net/*
  o I2C: fix resource leak in i2c-ali15x3.c
  o USB: fix up sparse warnings in ax8817x driver
  o PCI: add locking to the pci device lists
  o USB: fix up sparse warnings in drivers/usb/class/*
  o USB: fix up sparse warnings in drivers/usb/misc/*
  o DRIVER: firmware class build cleanups
  o DRIVER: make generic driver menu option, and move firmware
    selection there
  o DRIVER: add drivers/base/Kconfig to all arch main Kconfig files
  o PCI: merge bits missed from the pci locking patch
  o PCI: well, everyone is treating me like the maintainer
  o PCI: rename pci_get_dev() and pci_put_dev() to pci_dev_get() and
    pci_dev_put()
  o Cset exclude: willy@debian.org|ChangeSet|20030621161842|52492
  o PCI: fix minor problem in previous proc naming patch

Greg Ungerer:
  o configuration boot arguments for ColdFire/5249 targets
  o conditional ROMfs copy for M5249C3 board
  o configuration boot arguments for ColdFire/5272 targets
  o conditional ROMfs copy for M5272C3 board

Hanno Böck:
  o USB: Patch for Vivicam 355

Heiko Carstens:
  o sd.c: set data direction to SCSI_DATA_NONE for START_STOP

Herbert Xu:
  o [NET]: Fix per-cpu flow cache initialization
  o [NET]: Remove duplicate linux/interrupt.h include in
    net/core/flow.c
  o [NET]: More error checking in flow cache init function

Hideaki Yoshifuji:
  o [IPV6]: Fix warnings in ip6ip6 tunnel driver
  o [IPV6]: Use in6_dev_hold/__in6_dev_put in net/ipv6/mcast.c

Ivan Kokshaysky:
  o alpha srmcons fix
  o alpha oprofile fix

James Bottomley:
  o make the SCSI mid-layer obey the device online flag
  o Add XRAYTEX to SCSI whitelist
  o sd.c: initialise the gendisk private_data pointer earlier
  o Fix warning in scsi_proc.c
  o Fix USB storage mismerge
  o NCR53c406a print error and abort on non queueing mode
  o Fix SCSI ID setting for HP Cirrus-II card
  o SCSI: tidy up io vs mem mapping in 53c700 driver

Jamie Lenehan:
  o introduce scsi_host_alloc for dc395x

Jay Estabrook:
  o any_online_cpu for arch/alpha/kernel/smp.h

Jeff Garzik:
  o [netdrvr sis900] add new phy id to phy table

Jeff Smith:
  o [NET]: Export netdev_boot_setup_check

Jes Sorensen:
  o ia64: gettimeoffset hooks
  o cpu_idle() cleanup

Jesse Barnes:
  o ia64: SGI SN update
  o ia64: SN cleanups
  o ia64: more SN2 cleanups

Joe Thornber:
  o dm: dm-ioctl.c: Unregister with devfs before renaming the device

John Levon:
  o OProfile: small NMI shutdown fix
  o OProfile: IO-APIC based NMI delivery
  o OProfile: thread switching performance fix

Jon Grimm:
  o o hlist change on sctp not quite right

Kai Germaschewski:
  o ISDN: cleanup Makefiles
  o ISDN: Fix jiffies / flags types
  o ISDN: Fix SET_MODULE_OWNER() use
  o ISDN: Fix the modemd change notification
  o ISDN: Make isdn_tty.c compile again
  o ISDN: Make PPP compressors unload-safe
  o ISDN: Use standard list for PPP compressors
  o ISDN: Protect ipc_head list

Kai Makisara:
  o SCSI tape write error fix

Keith Owens:
  o ia64: fix unwinder to call get_scratch_regs() only when really
    needed

Kochi Takayoshi:
  o ia64: Discontigmem bank fix

Linus Torvalds:
  o Fix moxa compile (at least for UP) and remove a few warnings
  o Fix MELAN config compile by just making the PIC range allocation
    have only the two standard ports by default.
  o Make sure that unallocated consoles don't cause us to oops in
    VT_RESIZEX handling.
  o Don't register SCSI devices until they are actually fully set up

Lionel Bouton:
  o Enhanced SiS96x support

Manuel Estrada Sainz:
  o DRIVER: request_firmware() hotplug interface
  o DRIVER: request_firmware() hotplug interface documentation
  o DRIVER: request_firmware() vmalloc patch

Margit Schubert-While:
  o I2C: lm85 fixups
  o I2C: Sensors patch for adm1021

Mark Haverkamp:
  o megaraid driver update

Mark M. Hoffman:
  o i2c: Add lm78 sensor chip support
  o I2C: w83781d bugfix

Martin Devera:
  o [NET]: Fix jiffies races in net/sched/sch_htb.c

Martin Hicks:
  o ia64: Change mmu_gathers into per-cpu data
  o ia64: runtime platform detection for 2.5
  o ia64: compile fix for HP Sim serial/console
  o ia64: max user stack size of main thread configurable via
    RLIMIT_STACK

Martin Schlemmer:
  o I2C: ICH5 SMBus and W83627THF additions
  o I2C: fix for previous W83627THF sensor chip patch

Matthew Dharm:
  o USB storage: cleanups
  o USB storage: unusual_devs fixups
  o USB storage: more cleanups
  o USB storage: avoid NULL-ptr OOPS

Matthew Wilcox:
  o Unification of the SCSI Kconfig menus
  o PCI: Tidy up sysfs a bit
  o Consolidate Kconfigs for binfmts
  o PCI: pci_raw_ops patch to fix acpi on ia64
  o reimplement pci proc name

Mikael Pettersson:
  o [netdrvr tulip] Kconfig help text fix

Mike Christie:
  o fixes compile error in inia100.c

Miles Bader:
  o v850 whitespace tweaks
  o Add .con_initcall.init section on v850
  o Add linker script support for v850 "rte_nb85e_cb" platform
  o Add __raw_ read/write ops to v850 io.h

Muli Ben-Yehuda:
  o ISDN: [PATCH] memory leak in tpam_queues.c

Neil Brown:
  o kNFSd: Fix bug in svc_pushback_unused_pages that occurs on zero
    byte NFS read
  o kNFSd: Assorted fixed for NFS export cache
  o kNFSd: Make sure an early close on a nfs/tcp connection is handled
    properly
  o kNFSd: Allow nfsv4 readdir to return filehandle when a mountpoint
    is found is a directory
  o kNFSd: Make sure unused bits of NFSv4 xfr buffered are zero
  o kNFSd: RENEW and lease management for NFSv4 server
  o kNFSd: Do NFSv4 server state initialisation when nfsd starts
    instead of when module loaded
  o kNFSd: Set nfsd user every time a filehandle is verified
  o input: Three fixes for the uinput userspace input device driver
  o input: Change order of search for beeper devices in keyboard.c, so
    that it is easier to replace a beeper with a different driver

Oliver Neukum:
  o USB: convert kaweth to usb_buffer_alloc

Patrick Mansfield:
  o convert scsi core to use module_param interfaces

Patrick Mochel:
  o [kobject] Add sequence number to kobject hotplug
  o [driver model] Remove struct sys_device::entry
  o [driver model] Call the i8253 a PIT, not an RTC
  o [kobject] Remove Stupid Documentation License
  o [driver model] Export sysdev_{create,remove}_file()
  o [driver model] Make sure type is set correctly for system devices

Paul Fulghum:
  o syncppp fixes

Peter Chubb:
  o ia64: use generic build infrastructure for generating offsets.h
  o ia64: Include lib/Kconfig for HPSIM
  o ia64: Define ia64_max_iommu_merge_mask unconditionally

Randy Dunlap:
  o USB: missed one usblp status buffer change
  o USB: handle USB printer error bits independently

Reeja John:
  o [netdrvr amd8111e] fix spinlock recursion / if close failure

Richard Henderson:
  o [ALPHA] Fix memmove/memset GP interaction
  o [ALPHA] Implement execve entirely in assembly.  Force KSP to the
    top of the kernel stack space before entering userland.

Russell King:
  o [PCMCIA] Rename yenta to yenta_socket
  o [PCMCIA] Remove check_mem_resource()
  o [PCMCIA] Move SS_CAP_PAGE_REGS test into find_mem_region()
  o [PCMCIA] Prevent duplicate insertion events calling socket_insert()
  o [ARM] Separate ICS525 VCO calculation code
  o [ARM] Add AMBA bus type for ARM PrimeCells on Integrator
  o [ARM] Convert ambakmi.c to AMBA device driver
  o [ARM] Tighten virt_addr_valid(), add comments for __pa and friends
  o [ARM] Fix sa1100 irq.c build errors
  o [ARM] Fix flush_cache_page address parameter
  o [ARM] Allow ECC and cache write allocations on ARMv5 and higher
    CPUs
  o [ARM] Fix SECURITY_INIT in linker script
  o [ARM] fix missing includes in pm.c
  o [SCSI] Fix powertec.c build errors
  o [ARM] Remove unnecessary redefinition of predeclared register
    aliases
  o [ARM] Add new machine types
  o [ARM] Add SA11x0 UDC DMA mask support, and SSP platform device
  o Update Acorn partition parsing

Rusty Russell:
  o any_online_cpus to return NR_CPUS to mean "none"
  o More care in sys_setaffinity

Seth Rohit:
  o ia64: small update for hugetlb
  o ia64: patch to use >256MB purges
  o ia64: fix syscall optimization path so CONFIG_PREEMPT works again

Stefan Becker:
  o USB: Patch to cdc-acm.c to detect ACM part of USB WMC devices

Stephen Hemminger:
  o [NET]: alloc_netdev for shaper
  o [NET]: Fix module owner for bonding driver
  o [NET]: Use alloc_netdev in bonding driver
  o [NET]: Move Red Creek VPN drier to alloc_etherdev()
  o [NET]: Kill unused function in Red Creek VPN driver
  o [NET]: Add prefetch to skb_queue_walk
  o [NET]: Missing owner field on pppoe /proc
  o [NET]: Use unlikely and BUG_ON in SKB assertions

Steve French:
  o Cleanup compiler warnings generated by new gcc
  o Do not generate warning on ro (read only) cifs mount option
  o Fix most cifs vfs sign/unsigned gcc 3.3 compile warnings
  o Fix oops on stopping cifs oplock thread when removing cifs module

Stéphane Eranian:
  o ia64: perfmon fix
  o ia64: two small fixes (perfmon & GENERIC build)
  o ia64: switch to perfmon2
  o ia64: fix NULL pointer dereferences in perfmon
  o ia64: minor perfmon fixes

Tom Lendacky:
  o [IPV6]: Fix xfrm bundle address setup and comparisons

Tony Luck:
  o ia64: put kernel into virtually mapped area
  o ia64: provide a more generic vtop patching infrastructure
  o ia64: fix SAVE_RESET so OS INIT handler works again

Venkatesh Pallipadi:
  o ia64: IA-32 emulation patch: ptrace get_FPREGS bug fix

Vojtech Pavlik:
  o input: Fix misdetection of PS2 mice as AT keyboards on non-PC
    machines where ATKBD_CMD_RESET_BAT is used.
  o input: Add locking to serio.c
  o input: Add Logitech MX PS2++ support, move Logitech PS2++ code to a
    separate source file, always enable Synaptics support. Some more
    fixes in Synaptics code and documentation.
  o input: Fixes for sidewinder.c: Workaround for misbehaving 3DPro
    joysticks, don't trust FreestylePro 1-bit data packet for data
    width recognition, invert FreestylePro buttons.
  o input: make GC_PSX_DELAY lower (25 usec instead of 60), to burn
    less CPU time while reading PSX pads, and make it a module
    parameter also, for devices which would need the huge value of 60.

Walter Harms:
  o ia64: improve kernel_thread() cleanliness

Zwane Mwaikambo:
  o Remove warning due to comparison in drivers/net/pcnet32.c


