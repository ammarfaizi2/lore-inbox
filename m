Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261943AbTCQWV2>; Mon, 17 Mar 2003 17:21:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261949AbTCQWV2>; Mon, 17 Mar 2003 17:21:28 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:60932 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S261943AbTCQWVP> convert rfc822-to-8bit; Mon, 17 Mar 2003 17:21:15 -0500
Date: Mon, 17 Mar 2003 14:31:01 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Linux 2.5.65
Message-ID: <Pine.LNX.4.44.0303171429040.2827-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
X-MIME-Autoconverted: from 8bit to quoted-printable by deepthought.transmeta.com id h2HMVda26561
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I've delayed this too long, but Ingo found why the scheduler sometimes did 
bad things, and this should all be good.

A lot of fairly small changes all over the map, see the full changelog for 
details.

		Linus

---


Summary of changes from v2.5.64 to v2.5.65
============================================

<alexey@technomagesinc.com>:
  o Re: hot scsi disk resize

<andre.breiler@null-mx.org>:
  o io_edgeport.c diff to fix endianess bugs

<arnd@arndb.de>:
  o [trivial] avoid a warning for each module on s390x

<chas@locutus.cmf.nrl.navy.mil>:
  o [ATM]: Get lec net_device names correct
  o [ATM]: Obsolete some atm_vcc members

<clemens@ladisch.de>:
  o usb-midi.h: fixes for SC-8820/50

<green@linuxhacker.ru>:
  o [VLAN]: Fix memory leak in procfs handling
  o Memleak in KOBIL USB Smart Card Terminal Driver
  o USB: more Edgeport USB Serial Converter driver stuff
  o USB: memleak in Edgeport USB Serial Converter driver

<j-nomura@ce.jp.nec.com>:
  o ia64: CONFIG_NUMA build fix

<jmorros@intercode.com.au>:
  o [CRYPTO]: Move km_types out of header

<laforge@netfilter.org>:
  o [NETFILTER]: Fix ipv6 build

<louisk@cse.unsw.edu.au>:
  o ia64: fsys-version of gettimeofday()

<manand@us.ibm.com>:
  o [NET]: Move SKB header init to allocation time for better cache
    behavior

<miyazawa@linux-ipv6.org>:
  o [IPSEC]: Add full ipv6 support

<msdemlei@cl.uni-heidelberg.de>:
  o USB: Patch for DSBR-100 driver

<stevef@steveft21.austin.ibm.com>:
  o Fix memory overwrite in readdir on large directories

Adam Belay <ambx1@neo.rr.com>:
  o Manual Resource Setting Update
  o Interface Changes
  o PnP Card Serivice Revisions
  o ALS100 Updates
  o OSS SB driver Updates
  o Aditional Card Service Changes

Alan Cox <alan@lxorguk.ukuu.org.uk>:
  o [NETFILTER]: Remove 2.0 and 2.2 stuff from netfilter
  o minor breakage fix from typo fixes
  o minor typo fix that got missed
  o remove 2.2 compatmac stuff from rio driver
  o exterminate 2.2 gunk from video stuff
  o look a typo 8)
  o more 2.0 crap
  o more 2.0/2.2 bits
  o another typo that escaped
  o fix aic7xxx aicasm build
  o remove a pile of 2.0 and 2.2 support
  o filter more 2.2 junk
  o kill stdarg in intermezzo
  o missed patch - static not extern inline in cia
  o correct BUG doc
  o kill the now dead ide_ioreg_t
  o kill long unused macro
  o add serial port table for PC9800
  o correct BUG doc in parisc
  o remove unused beep macro on sh
  o Add ELF types for Hitach H8 series
  o remove 2.2 junk from efs
  o remove 2.2 bits fromw anpipe
  o remove 2.0 and 2.2 stuff from netfilter
  o add a new PCI quirk type for the ALi Magik series
  o remove 2.0/2.2 stuff
  o remove 2.0/2.2 stuff from wanrouter
  o correct emu10k url
  o correct file names in comments in mm
  o clean up 2.2 stuff in wanrouter code
  o ALi it turns out has a 31bit audio device
  o update PCI quirks
  o correct irq logic for x86
  o correct building of the old ide/hd.c driver
  o clean up all the console inits using an initcall variant
  o bring ide-disk driver into line with 2.4.21pre
  o ide-dma
  o switch ide-floppy to ide_execute_command
  o switch ide-io (core ioctls etc) to ide_execute_command
  o add sensible names to the ide iops
  o remove spare cast
  o switch ide taskfile ioctls to ide_execute_command
  o fix wrong type and statics in amd ide
  o update via driver from 3.35-ac to 3.36

Alan Stern <stern@rowland.harvard.edu>:
  o USB: Patch for auto-sense cmd_len

Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>:
  o [IPV4]: Fix deadlock in IGMP locking

Andi Kleen <ak@muc.de>:
  o Fast path context switch - microoptimize FPU reload
  o x86-64 updates for 2.5.64-bk3

Andrew Morton <akpm@digeo.com>:
  o i386 IRQ balancing cleanup
  o balance_irq lockup fix
  o Fix nfs oops during mount
  o rtc lock ranking fix
  o sk98lin 64-bit divide fix
  o cciss: fix initialization for PCI hotplug
  o export pfn_to_nid to modules
  o Reduced stack usage in random.c
  o fix inode reclaim imbalance
  o remove __pgd_offset
  o remove __pmd_offset
  o remove __pte_offset
  o missed unlock_kernel() in ext3+htree
  o reduce stack size: elf_core_dump()
  o uninlining in fs/binfmt_elf.c
  o ext3: fix error-path memory leak
  o fix ioremap off by one bug
  o register_blkdev cleanups
  o fix possible latency in balance_dirty_pages()
  o Implement sendfile() for NFS
  o Allow VFS readahead to fall to zero
  o Make diskstats per-cpu using kmalloc_percpu
  o Fix vm_area_struct slab corruption
  o slab use-after-free detector
  o slab debug: track caller program counter
  o slab debug: symbolic output in caller tracking
  o Fix copy_page_range()'s handling of invalid pages
  o move CONFIG_SWAP around
  o fix div-by-zero in bonding.c
  o usercopy checks in old_readdir()
  o hugetlb unmap_vmas() SMP && PREEMPT fix
  o ext2: fix error-path double-free
  o fix memory leak in load_elf_binary()
  o Extended attribute sharing and debug macro typo fixes
  o protect 'action' in show_interrupts
  o i386 show_interrupts() fix
  o fix SMP lockup in eepro100 with ethtool on unused
  o Larger buffer for /proc/interrupts display
  o Disable the "Unknown IO_APIC" message
  o raw.c: dev_t cleanup and oops fix
  o missing spin_unlock() in sysfs_remove_dir()
  o rpc_delete_timer race fix
  o remove compile warning from serial console initcall
  o revert the "remove kernel_flag" patch
  o fix a warning in eepro100.c
  o revert "noirqbalance still doesn't do anything"
  o ACPI suspend/resume locking fix
  o fix typo in init/Kconfig
  o pnp warning fix
  o fix console ordering default
  o work around gcc-3.x inlining bugs
  o NCPFS memleak fix
  o Memleak in Windows Logical Disk Manager partition
  o Fix memleak in ircomm_core
  o Force cache alignment of task_structs
  o ext3: error handling robustness
  o ext2: fix directory handling bug
  o unplugging fix
  o remove scsi_eh_retry_cmd
  o fix devfs oops
  o Fix mem= options
  o fix the fix for unmap_vmas & hugepages
  o Early writeback initialisation
  o Fix memleak in e100 driver
  o Ext2/3 noatime and dirsync fixes
  o ext2: block allocation fix
  o kiocbClear should use clear_bit instead of set_bit
  o initialise inode->i_rdev
  o AFFS fixes
  o fix raid0 oops
  o miropcm20-rds.c compile fixes

Andries E. Brouwer <andries.brouwer@cwi.nl>:
  o scsi_error fix
  o some more NAND flash IDs
  o fix affs/super.c

Anton Blanchard <anton@samba.org>:
  o ppc64: use fast version of mtmsrd when changing RI, from Milton
    Miller
  o ppc64: remove extra clear of RI, we do it later on, from Milton
    Miller
  o ppc64: Fix some warnings in the ppc64 build, from Andrew Morton
  o ppc64: rework pci PHB probe code
  o ppc64: add missing include
  o ppc64: remove old irq balance code
  o ppc64: move pSeries specific fixup_bus out of generic code
  o ppc64: really move pSeries_pcibios_fixup_bus this time
  o missing include
  o ppc64: handle 8 byte loads and stores atomically in xmon
  o ppc64: add/remove config.h where necessary
  o ppc64: compat_sys_fcntl from Stephen Rothwell, remove socketcall
    emulation
  o ppc64: remove -finline-limit now that we force inlines

Art Haas <ahaas@airmail.net>:
  o [NETFILTER]: C99 initializers for ipv6 netfilter
  o [NETFILTER]: C99 initializers for ipv4 netfilter
  o [NETFILTER]: Really apply the ipv4 C99 patches this time. :-)

Bart De Schuymer <bdschuym@pandora.be>:
  o [EBTABLES]: Trivial changes and cleanups

Benjamin LaHaise <bcrl@redhat.com>:
  o [NET]: Make sure nr_frags is accurate on paged SKB allocation
    failure
  o [NET]: Simplify scm handling and sendmsg/recvmsg invocation,
    consolidate net compat syscalls

Bjorn Helgaas <bjorn_helgaas@hp.com>:
  o ia64: iosapic: make pcat_compat system property
  o ia64: iosapic: remove find_iosapic duplication
  o ia64: iosapic: simplify ISA IRQ init
  o ia64: iosapic: self-documenting polarity/trigger arguments
  o ia64: iosapic: rationalize __init/__devinit
  o ia64: IA32 support without sysctl doesn't work

Christoph Hellwig <hch@lst.de>:
  o update fdomain pcmcia support
  o update qlogic pcmcia support
  o remove some braindamage from drivers/scsi/pcmcia/Kconfig
  o i2c-core.c procfs updates
  o remove devfs_only()
  o fix possible NULL pointer dereference in scsi_scan.c
  o fix OOPS in i2c sysctl registration
  o fix up the i2c locking changes
  o switch over /proc/bus/i2c to seq_file interface
  o fix kmem_cache_size() for new slab poisoning
  o remaining bits of DEVFS_FL_AUTO_DEVNUM
  o remove regular file support from devfs
  o missing drivers/video/Makefile entry
  o i2c ID updates
  o update i2c algorithm drivers
  o i2c-core locking updates

Dave Jones <davej@codemonkey.org.uk>:
  o [CPUFREQ] fix cpufreq core breakage(s)
  o [CPUFREQ] fix userspace governor
  o [CPUFREQ] remove unneeded code
  o [CPUFREQ] updated cpufreq ref-counting and locking scheme
  o [CPUFREQ] add support for ICH4-M chipset in speedstep driver
  o [CPUFREQ] allow cpufreq drivers to export sysfs files
  o [CPUFREQ] update documentation
  o [CPUFREQ] Move pci define to pci_ids.h
  o [WATCHDOG] amd7xx_tco updates from Zwane, and nuke
    EXPORT_NO_SYMBOLS
  o [CPUFREQ] Fix documentation typos
  o [CPUFREQ] powernow-k7 lazy voltage setting
  o [CPUFREQ] More typos
  o [CPUFREQ] Yet another typo From Steven Cole
  o [CPUFREQ] Yet more typos
  o [CPUFREQ] Fix formatting of 'nothing' output
  o [CPUFREQ] powernow_decode_bios can be static
  o [CPUFREQ] Fix signed comparison warning in powernow-k7
  o [CPUFREQ] fix signed comparison warnings for longhaul
  o [CPUFREQ] Drop FSB scaling from VIA longhaul driver

Dave Kleikamp <shaggy@shaggy.austin.ibm.com>:
  o JFS: Fix hang while flushing outstanding transactions under heavy
    load

David Brownell <david-b@pacbell.net>:
  o USB: track usb ch9 device state
  o USB ohci:  "registers" sysfs file

David Gibson <david@gibson.dropbear.id.au>:
  o Squash warnings in usb-serial.c
  o Squash warning in ohci-pci.c on PowerBooks

David Mosberger <davidm@tiger.hpl.hp.com>:
  o ia64: Minor whitespace & formatting fixups in asm-ia64/sal.h
  o ia64: Minor cleanups
  o ia64: Make signal deliver work when the current register frame is
    incomplete (as a result of a faulting mandatory RSE load).
  o ia64: Fix typo in #error message of page-fault handler
  o ia64: Sync up with 2.5.60
  o ia64: Fix do_gettimeoffset() to not update last_nsec_offset with
    (potentially) invalid values.
  o ia64: Fix fsys_gettimeofday() and tune it some more
  o ia64: Add forgotten probe.w.fault checks in fsys_gettimeofday()
  o ia64: Fix formatting inconsistencies introduced by my
    fsys_gettimeofday() patch.
  o ia64; Improve debug output from kernel unwinder.  Based on patch by
    Keith Owens.
  o ia64: In kernel unwinder, replace dump_info_pt() with
    get_scratch_regs() and reformat to make it fit in 100 columns.
  o ia64: Correct region_start calculation in kernel unwinder
  o ia64: Minor formatting fixes for the preemption patch
  o ia64: Fix ia32 sysinfo() emulation
  o ia64: Fix SAL processor-log info handling.  Based on patch by Keith
    Owens.
  o ia64: Implement _raw_write_trylock().  Based on patch by Joel
    Guillet
  o ia64: Implement pcibios_prep_mwi() and define HAVE_ARCH_PCI_MWI to
    ensure that PCI line-size gets programmed properly.  Based
  o ia64: Make ia64_fetch_and_add() simpler to optimize so lib/rwsem.c
    can be optimized properly.
  o ia64: Correct the value of siginfo.si_addr for SIGSEGV signals
    triggered by NaT-page-consumption faults.
  o ia64: Hook up POSIX-timer syscalls.  Take advantage of
    ptrace_notify()
  o ia64: Fix several small bugs/omissions from the 2.5.64 sync
  o ia64: Minor formatting/whitespace fixes in ia64-version of acpi.c
  o ia64: Don't output backspaces in palinfo output

David S. Miller <davem@nuts.ninka.net>:
  o [IPSEC]: Use dst_hold unless assigning result to something
  o [FRAMEBUFFER]: No need for check_var/set_par ops in SBUS fb drivers
  o [SBUSFB]: Implement enough ioctls to get X working
  o [SBUSFB]: Fix up ioctl helper changes
  o [SPARC64]: Fix cpufreq config deps
  o [KERNEL]: Add typecheck macro for verifying types at compile time
  o [JIFFIES]: Use typecheck in time_foo jiffies macros
  o [NET]: Do not duplicate verify_compat_iovec in sparc64 solaris
    module
  o [IPSEC]: Fix build when ipsec is disabled
  o [SPARC]: One too many chars in INIT_C_CC
  o [FRAMEBUFFER]: Convert SBUS LEO driver to new APIs
  o [SPARC64]: Use pci_remove_bus_device to delete, found by Ben
    Collins
  o [SPARC64]: Update defconfig
  o [SPARC64]: Make sure update_process_times runs inside of
    irq_{enter,exit} region
  o [ATM]: Add missing $(obj) to driver makefile
  o Fix time comparison typing bugs

Dominik Brodowski <linux@brodo.de>:
  o pcmcia: it works again!

Douglas Gilbert <dougg@torque.net>:
  o scsi_debug in 2.5.64
  o sg version 3.5.28 for lk 2.5.64
  o scsi_debug version 1.68 mark III

Duncan Sands <baldrick@wanadoo.fr>:
  o USB speedtouch: send path optimization

Gerd Knorr <kraxel@bytesex.org>:
  o v4l: video-buf update
  o v4l: crunch MIN/MAX macros
  o v4l: create include/media

Greg Kroah-Hartman <greg@kroah.com>:
  o LSM: fix merge where we lost a prototype in security.h
  o USB: add support for Treo devices to the visor driver
  o USB: added support for radio shack device to pl2303 driver
  o USB: unfortunatly, we can't call usb_unlink_urb() right now all of
    the time
  o gen_init_cpio: Add the ability to add files to the cpio image
  o kbuild: handle any failures of the gen_init_cpio or initramfs image
    to stop the build
  o LSM: restore d_instantiate function that got lost in the mege
  o USB: added support for the palm M100
  o USB: fix up a comment in usb_unlink()
  o USB: Added support for the Sony Clie NZ90V device
  o i2c: add bus driver for ALI15x3 devices
  o i2c: get i2c-ali15x3 driver to actually bind to a PCI device
  o i2c: add bus driver for Intel 801 devices
  o i2c: get i2c-i801 driver to actually bind to a PCI device
  o i2c: add bus driver for Intel PIIX4 devices
  o i2c: get i2c-piix4 driver to actually bind to a PCI device
  o i2c: i2c-piix4.c: Clean up the ibm dma scan logic
  o i2c: add i2c sysfs bus support
  o driver core: Export the legacy_bus structure for drivers to use
  o i2c: add driver model support to i2c adapter drivers
  o USB: fixup from previous io_ti.c patch
  o USB: added support for Ericsson data cable to pl2303 driver

Greg Ungerer <gerg@snapgear.com>:
  o include unistd.h in m68knommu 68360 entry code
  o include unistd.h in m68knommu 68328 entry code
  o include errn0.h in m68knommu 68328 interrupt setup code
  o m68knommu/ucdimm should use generic 68328 irq setup
  o fix spelling in m68knommu Kconfig help
  o m68knommu/de2 should use generic 68328 irq setup
  o fix wrong argument prototype in m68knommu/68360 for interrupt
    handler
  o include errno.h in m68knommu 68360 interrupt setup code
  o fix m68knommu/68VZ328 Makefile to traverse sub-dirs
  o fix m68knommu COMEM-lite PCI bios code
  o move common timer and vector code for m68knommu/ColdFire/5272
  o fix m68knommu/68VZ328/de2 Makefile to compile local code files
  o fix m68knommu/68VZ328/ucdimm Makefile to compile local code files
  o call schedule_tail() in m68knommu return from fork code path
  o move common timer and vector code for m68knommu/ColdFire/5307
  o fix m68knommu/68360 Kconfig wrong define
  o inline some mm functions for MMUless targets
  o include stddef.h in include/linux/list.h
  o fix m68knommu COMEM-lite PCI header code
  o move common timer and vector code for m68knommu/ColdFire/5407
  o fix m68knommu/68328 serial driver to use work_struct
  o build m68knommu/ColdFire common vectors.c and timers.c
  o create common timer code for m68knommu/ColdFire processors
  o move common timer and vector code for m68knommu/ColdFire/5249
  o move common timer and vector code for m68knommu/ColdFire/5206e
  o move common timer and vector code for m68knommu/ColdFire/5206
  o fix m68knommu/68360 serial driver to use work_struct
  o fix spelling in m68knommu comem PCI support code
  o fix spelling in m68knommu signal.c
  o add support to m68knommu linker script for console init section

Henning Meier-Geinitz <henning@meier-geinitz.de>:
  o USB: Fix crash in read/write/ioctl in scanner driver

Ingo Molnar <mingo@elte.hu>:
  o "interactivity changes", sched-2.5.64-A6
  o NUMA scheduler breakage
  o more "interactivity changes", sched-B2
  o "interactivity changes", sched-2.5.64-B2
  o sched-2.5.64-bk10-C4
  o sched-2.5.64-bk10-D0

Ivan Kokshaysky <ink@jurassic.park.msu.ru>:
  o nautilus poweroff
  o alpha pcibios_claim_console_setup fix

James Bottomley <jejb@raven.il.steeleye.com>:
  o Correct nested variable thinko in scsi_error.c
  o Fix DMA to stack problem in scsi_error.c
  o Fix loop problem in SCSI error handler sense collection
  o revert fs/block_dev.c change for hot resize: breaks initrd

James Morris <jmorris@intercode.com.au>:
  o [IPSEC]: Add family argument to compile_policy
  o [NET]: Convert volatile char socket flags to real bitops mask, work
    by Pedro Hortas
  o [NET]: dst_clone --> dst_hold where appropriate
  o [IPV4]: Fix multicast route lookups
  o [TCP]: Commonize duplicated code into a new function,
    tcp_bucket_destroy
  o [NET]: Nuke SO_BSDCOMPAT
  o [CRYPTO]: Add encrypt_iv() and decrypt_iv() methods
  o [CRYPTO]: Eliminate crypto_tfm.crt_ctx, from Adam Richter
  o [CRYPTO]: Documentation updates

Jean Tourrilhes <jt@bougret.hpl.hp.com>:
  o export platform_bus_type

Jeff Garzik <jgarzik@redhat.com>:
  o [hw_random] shuffle files in preparation for hw_random driver
    update
  o [hw_random] update amd768_rng driver to be modular; add Intel
    support
  o [ia32] cpu capabilities cleanups and additions
  o [hw_random] add support for VIA Nehemiah RNG ("xstore" instruction)
  o [hw_random] fixes and cleanups

Jeff Wiedemeier <jeff.wiedemeier@hp.com>:
  o enable setting of marvel/titan agp->type

Jens Axboe <axboe@suse.de>:
  o Fix x86-64 build
  o remove redundant local_irq_disable in bio_kmap_irq()
  o honor hard barrier in deadline
  o extra tokens after endif

Jesse Barnes <jbarnes@sgi.com>:
  o ia64: SN updates for mmzone.h
  o ia64: SN update
  o ia64: ACPI fix for no PCI

Johannes Erdfelt <johannes@erdfelt.com>:
  o uhci-hcd.c 2.5 finish completions in correct order

John Levon <levon@movementarian.org>:
  o Fix oprofile on UP, small additional fix
  o fix oprofile on x86 > 1 counter

Joshua Uziel <uzi@uzix.org>:
  o [SPARC64]: Fix warning during uniprocessor build of US3 cpufreq
  o [SPARC64]: Need to export up_clock_tick on uniprocessor

Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>:
  o ISDN: Fix up missed return value
  o kbuild: Make build stop on vmlinux link error
  o kbuild: Add some missing FORCE
  o kbuild: Make per-cpu-check ignore __crc_ symbols
  o do_mounts: Fix boot from ramdisk
  o kbuild: Fix asm/offset.h generation
  o ISDN: Resolve name clash in hisax
  o ISDN/HiSax: Fix some warnings
  o ISDN: [PATCH] isdn_net_lib.c must include isdn_concap.h
  o ISDN/AVMB1: Fix compile w/o CONFIG_ISDN_DRV_AVMB1_B1PCIV4
  o ISDN: Fix compile error w/o CONFIG_ISDN_PPP_MP
  o ISDN: Fix hisax_fcpcipnp PnP
  o ISDN/HiSax: Introduce probe() functions
  o ISDN/HiSax: config.c cleanup
  o ISDN/HiSax: Remove unused ISDN_CHIP_* macros
  o ISDN/HiSax: Get rid of CARD_* defines
  o ISDN/HiSax: Remove amd7930.c
  o kbuild: Fix output when linking vmlinux

Keith Owens <kaos@sgi.com>:
  o ia64: fix scratch-regs handling in kernel unwinder

Kenneth W. Chen <kenneth.w.chen@intel.com>:
  o ia64: rwsem using atomic primitive

Linus Torvalds <torvalds@transmeta.com>:
  o Fix up some timeouts to use the proper types
  o Make the "interactive bonus" work both ways - both the process that
    is actually showing interactive behaviour (sleeping) and the
    process that wakes up the interative process get a bonus.
  o Fix "con_init()" function type and stale (and incorrect)
    declaration
  o Fix a very theoretical race between the new RCU lookup and
    concurrent renames in another directory.
  o Avoid warning due to missing return value
  o Ignore initramfs cpio file
  o Fix up i387 task switching bug introduced by Andi Kleen's patch to
    speed it up - use the proper bitmask for clearing "used-fpu" state.
  o Fix nanosleep() problem noticed by Todd Mokros <tmokros@neo.rr.com>
  o Cache the MSR_IA32_SYSENTER_CS value in the per-CPU TSS (using the
    otherwise unused cpl1 entry for SS), so that we can avoid
    re-loading it on task switches if it doesn't change.
  o Move "used FPU status" into new non-atomic thread_info->status
    field
  o Remove <asm-i386/xor.h>'s own home-made FPU begin/end macros, use
    the real ones instead.
  o Use a fixed per-cpu SYSENTER_MSR_ESP value by having the sysenter
    entry routine load the real ESP0 off that per-cpu stack. Make this
    even faster by putting the sysenter stack in the per-CPU TSS, so
    that we can use the tss->esp0 value directly (which we have to
    update on task switches anyway).
  o Use cond_sched() instead of manual expansion of it
  o Error out for the case of a gcc-2.96 compiler with
    CONFIG_FRAME_POINTER set. A few versions of gcc-2.96 generate
    seriously incorrect code.
  o Revert duplicate <linux/stddef.h> addition

Luben Tuikov <luben@splentec.com>:
  o scsi_softirq queue is now list_head, eliminate bh_next

Marc Zyngier <mzyngier@freesurf.fr>:
  o Fix fs/binfmt_elf.c build
  o Fix arch/alpha/vmlinux.lds.S typos
  o EISA/sysfs update

Marcel Holtmann <marcel@holtmann.org>:
  o [SPARC64]: Translate AUTOFS_IOC_EXPIRE_MULTI ioctl

Mark A. Greer <mgreer@mvista.com>:
  o PPC32: Fix our L2 / L3 cache updates for the bootloader
  o PPC32: Fix a problem with 'next' and 'step' type KGDB commands

Mark Haverkamp <markh@osdl.org>:
  o aacraid driver for 2.5

Martin J. Bligh <mbligh@aracnet.com>:
  o Fix NUMA scheduler problem after interactivity merge
  o revert pfn_to_nid change
  o 1/6 Share common physnode_map code between NUMA-Q and Summit
  o 2/6 Make CONFIG_NUMA work on non-numa machines
  o 3/6 Convert physnode_map to u8
  o 4/6 Fix the type of get_zholes_size for NUMA-Q
  o 5/6 Provide basic documentation for profiling
  o 6/6 cacheline align files_lock
  o NUMA scheduler fixup

Matthew Wilcox <willy@debian.org>:
  o Remove naked GFP_DMA from drivers/scsi/sd.c
  o Remove naked GFP_DMA from drivers/scsi/sr.c
  o Some parisc updates for SCSI
  o fs/locks.c: fix bugs
  o neaten fs/locks.c a little

Mike Anderson <andmike@us.ibm.com>:
  o Fix SCSI error handler abort case

Neil Brown <neilb@cse.unsw.edu.au>:
  o md: Missing mddev_put in md resync code
  o md: Convert /proc/mdstat to use seq_file
  o md: C99 initiailzers for xor.h
  o md: Opencode flush_curr_signals in md.c
  o md: Tidy up recovery_running flags in md
  o md: Include asm-i386/387.h in asm-i386/xor.h
  o md: Remove md_recoveryd thread for md
  o md: Fulltime delayed 'safe_mode' for md
  o md: Fix bad interaction between sync checkpointing and recovery
  o md: Allow components of MD raid array to have data start at offset
    from start of device
  o md: Allow md to select between superblock formats
  o md: Add new superblock format for md
  o kNFSd: Fix exit-without-free bug in nfsd
  o kNFSd: Fix race in svcsock.c
  o kNFSd: Fix deadlock problem in lockd
  o kNFSd: Assort fixes to nfsd auth cache stuff
  o kNFSd: Rename NFSEXP_CROSSMNT to NFSEXP_NOHIDE
  o kNFSd: Introduce CROSSMNT flag for knfsd

Oleg Drokin <green@namesys.com>:
  o reiserfs: Correctly free all the allocated memory if open of the
    journal failed
  o memleak in drivers/char/vt.c

Patrick Mochel <mochel@osdl.org>:
  o sysfs: Make sure root inode is executable and readable by everyone
  o driver model: fix platform_match()
  o sysfs: don't complain when sysfs can't register
  o cpufreq: fix compile error
  o sysfs: fix up directory removal, once and for all
  o sysfs: Fix binary file handling
  o sysfs: fix BUG()s on directory creation and removal
  o driver model: add bus_rescan_devices()

Paul Mackerras <paulus@samba.org>:
  o PPC32: Add a thread-pointer argument to the clone syscall, make a
    prepare_to_copy()
  o PPC32: Better check for when we should expand the stack
  o PPC32: Set max_pfn correctly
  o PPC32: Make sure interrupts are disabled in IPI handlers
  o PPC32: Don't reregister existing /proc/irq entries

Peter Anvin <hpa@zytor.com>:
  o bootsect removal
  o Fix $(src) versus $(obj)

Peter Chubb <peter@chubb.wattle.id.au>:
  o ia64: Preemption patch against ~2.5.60

Randy Dunlap <rddunlap@osdl.org>:
  o reduce stack in qlogicfc.c
  o update filesystems config. menu
  o typos only
  o fsmenu update
  o [IPV4/IPV6]: ICMP cleanups
  o [SNMP]: Fix SNMP_STAT_{USR,BH}PTR

Robert Love <rml@tech9.net>:
  o no need for kernel_flag on UP

Rohit Seth <rohit.seth@intel.com>:
  o ia64: HugeTLB Page patch for IA-64 2.5.60 kernel
  o ia64: 2nd update for HugeTLB Page patch for IA-64 2.5.60 kernel

Roland McGrath <roland@redhat.com>:
  o signal fix for wedge on multithreaded core dump

Roman Zippel <zippel@linux-m68k.org>:
  o restore old config behaviour for dependencies on 'm'
  o menu structure fix
  o add menuconfig support
  o add menuconfig support to the front ends
  o gtk front end

Russell King <rmk@arm.linux.org.uk>:
  o Separate out pci bus resource allocator
  o Eliminate stack allocation of struct pci_dev
  o Only add devices to bus->devices while scanning
  o Convert setup-bus resource allocation to use bus->devices
  o Fix up pci_scan_bridge and friends
  o [ARM] Remove set_mac_address from acorn drivers
  o [ARM] Convert ecard.c shutdown/reboot to use driver model
  o [ARM] Always call schedule_tail() after a fork()
  o [ARM] Always claim the timer IRQ using SA_INTERRUPT
  o [ARM] Add new kernel typedefs for __kernel_{timer,clockid}_t
  o [ARM] Add dummy set_pgd() implementation
  o [ARM] Make ARM's pci_controller_num dev argument appear to be used
  o [ARM] Kill old mkdep dependency hack
  o [ARM] Fix ARM ide.h
  o [ARM] Make TLB instruction selection more fine-grained
  o [ARM] Update mach-types to latest vesion
  o [ARM] Ensure we preserve other CPSR bits when switching to SVC mode
  o [ARM] Power management updates
  o [ARM] Add better PM support to SA1111 and SA11x0
  o [ARM] Clean up ARM PCI support (bios32.c)
  o [CPUFREQ] Update ARM CPUFREQ drivers
  o [ARM] CPUFREQ - allow ARM to work with userspace governor
  o [CPUFREQ] Make sa11x0_ppcr_to_freq return in units of kHz, not
    100kHz
  o [ARM] Add generic SSP "PIO" mode driver
  o [SERIAL] Overhaul 8250_pci.c
  o [SERIAL] Update 8250_acorn.c
  o [SERIAL] Add ttydriver->owner initialisation
  o [SERIAL] Make tty->driver_data point at the uart_state structure
  o [SERIAL] Make uart_tasklet_action take uart_state
  o [SERIAL] Eliminate some more passing of struct uart_info
  o [SERIAL] Add per-port semaphore
  o [SERIAL] Remove remaining notifier-based PM support
  o [SERIAL] Four bug fixes
  o [SERIAL] Prevent multiple calls to tty_{un,}register_device()
  o [SERIAL] Add new device model based power management infrastructure
  o [SERIAL] Add sa1100 serial PM support using device model
  o [SERIAL] Add uart_console(port) macro
  o [SERIAL] Add PCI serial power management support
  o [SERIAL] Add Xircom RBM56G PCI ID
  o [SERIAL] Only update the console termios cflag once
  o [TTY] Register tty devclass before use
  o [PCI] pci-6 - Fix scanning of non-zero functions
  o [PCI] pci-7: Remove second argument to pcibios_update_resource()
  o [PCI] pci-8: pci_resource_to_bus()
  o [PCI] pci-9: Kill per-architecture pcibios_update_resource()
  o [PCI] pci-10: Miscellaneous cleanups to probe.c
  o [PCI] pci-11: use u32 for bus numbers/latency not unsigned long
  o [PCI] pci-12: Add #defines for cardbus specifics
  o [PCI] pci-13: unuse pci_do_scan_bus()
  o [PCI] pci-14: Add the Mobility Electronics EV1000 PCI device
    numbers
  o [PCI] pci-15: Fix setup-bus.c resource sizing

Sam Ravnborg <sam@mars.ravnborg.org>:
  o kbuild: Smart notation for non-verbose output
  o kbuild: touch-module after successfull creation only
  o kbuild: Do not clutter output with make -jN
  o kbuild/all arch: Use filechk rule for offsets generation
  o kbuild: Use targets := to tell kbuild about additional targets
  o kbuild: Introduced extra-y, as replacement for EXTRA_TARGETS
  o kbuild: build-targets replaced with always
  o kbuild: Updated Documentation/kbuild/makefiles.txt

Stephen D. Smalley <sds@epoch.ncsc.mil>:
  o Add LSM hook to do_kern_mount
  o Replace inode_post_lookup hook with d_instantiate hook
  o allocate and free security structures for private files
  o Restore LSM hook calls to setpriority and setpgid
  o LSM: Add LSM sysctl hook to 2.5.59
  o LSM: Add LSM syslog hook to 2.5.59
  o LSM: coding style fixups in sb_kern_mount

Stephen Hemminger <shemminger@osdl.org>:
  o Turn off aio printk meant for debugging (2.5.64)

Stephen Rothwell <sfr@canb.auug.org.au>:
  o ia64: compat_sys_futex() support
  o compat_sys_fcntl{,64} Generic part
  o compat_sys_fcntl{,64} x86_64 part
  o compat_sys_fcntl{,64} s390x part
  o compat_sys_fcntl{,64} parisc part
  o [COMPAT]: Sparc64 part of fcntl changes

Steve French <stevef@smfhome1.austin.rr.com>:
  o Remember to free mapping in all writepage paths
  o Fix oops in getdfs when null path passed in on mount.  Fix oops
    when changed readsize caused readpages problem.  Add support for
    altering rsize so can reduce pages read across net below default of 4

Steven Cole <elenstev@mesatop.com>:
  o Documentation spelling cleanup
  o USB: spelling fixes for drivers/usb

Stéphane Eranian <eranian@hpl.hp.com>:
  o ia64: perfmon patch for 2.5.59

Suresh Siddha <suresh.b.siddha@intel.com>:
  o ia64: 1/2 fix for generic kernel
  o ia64: 2/2 fix in machvec.h

Tom Rini <trini@kernel.crashing.org>:
  o PPC32: Fix a typo in modular IDE support on Motorola LoPEC
  o PPC32: Fix building of the Motorola LoPEC and CONFIG_DUMMY_CONSOLE
  o PPC32: Replace 2 inline functions with their normal macro
    equivalents

Willem Riede <wrlk@riede.org>:
  o fix jiffies compare warning in osst

Zwane Mwaikambo <zwane@linuxpower.ca>:
  o noirqbalance still doesn't do anything


