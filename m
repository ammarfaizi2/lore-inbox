Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261486AbTAQCT2>; Thu, 16 Jan 2003 21:19:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265633AbTAQCT2>; Thu, 16 Jan 2003 21:19:28 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:37128 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S261486AbTAQCTX>; Thu, 16 Jan 2003 21:19:23 -0500
Date: Thu, 16 Jan 2003 18:28:03 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Linux 2.5.59
Message-ID: <Pine.LNX.4.44.0301161826430.8879-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Updates to sparc, alpha, ppc64, fbdev, XFS, AGP, kbuild, arm...

Likely the last release by me in a while, but Andrew & co can hold the 
fort..

		Linus


Summary of changes from v2.5.58 to v2.5.59
============================================

<alex@ssi.bg>:
  o missing break in amd 486 cpu case

<cloos@jhcloos.com>:
  o i8k driver update to i8k-1.13
  o i8k driver cleanups
  o alsa before oss in Kconfig

Ulrich Drepper <drepper@redhat.com>:
  o new CPUID bit

Falk Hueffner <falk.hueffner@student.uni-tuebingen.de>:
  o [AGP] missing includes on Alpha

Jeff Wiedemeier <jeff.wiedemeier@hp.com>:
  o Fix marvel irq count computation

Nick Holloway <nick.holloway@pyrites.org.uk>:
  o cpia driver update

<ya@slamail.org>:
  o fix cardbus/hotplugging

Andi Kleen <ak@muc.de>:
  o x86_64 update

Andrew Morton <akpm@digeo.com>:
  o ext3 ino_t removal
  o factor free memory into max_sane_readahead()
  o fix ext3 memory leak
  o hugetlbfs: don't implement read/write file_ops
  o Use for_each_task_pid() in do_SAK()
  o Create a per-cpu proces counter for /proc reporting
  o remove has_stopped_jobs()

Anton Blanchard <anton@samba.org>:
  o pp64: move BUG into asm/bug.h
  o ppc64: update comment, we now zero extend all 6 arguments in the
    32bit syscall path, from Milton Miller
  o ppc64: 2.5 module support, from Rusty
  o ppc64: fix build when CONFIG_MODULES=n
  o ppc64: move BUG_ILLEGAL_INSTR into asm/bug.h, noted by Milton
    Miller
  o ppc64: remove old strace hack
  o ppc64: remove old signal code, unused on 64bit userspace
  o ppc64: Remove code which zero/sign extends arguments 5 and 6, its
    done unconditionally now
  o ppc64: fix exception handling in socket multiplexer
  o ppc64: Temporary workaround for oops during coredump

Bjorn Helgaas <bjorn_helgaas@hp.com>:
  o [AGP] factor device command updates
  o [AGP] fix old pci_find_capability merge botch
  o [AGP] Remove unused var
  o [AGP] Print AGP version & mode when programming devices
  o [AGP] factor device capability collection
  o [AGP] use PCI_AGP_* constants
  o [AGP] use pci_find_capability in sworks-agp.c

Christoph Hellwig <hch@lst.de>:
  o more procfs bits for !CONFIG_MMU
  o remove more junk from i2c headers
  o remove some junk from fs/devfs/Makefile
  o remove obsolete kern_umount alias for mntput
  o fix intermezzo compilation
  o don't include coda_fs_i.h in fs.h
  o umode_t changes from Adam's mini-devfs

Christoph Hellwig <hch@sgi.com>:
  o [XFS] remove superlous MAXNAMELEN checks
  o [XFS] some more rename cleanups
  o [XFS] xfs_getattr should be static
  o [XFS] remount r/o fixes
  o [XFS] update xattr.h copyright date
  o [XFS] add dmapi miscdevice minor number
  o [XFS] fix namespace pullution
  o stale bdev reference in quotactl
  o fix signed/unsigned issue in SGI partitioning code
  o remove GET_USE_COUNT
  o remove MOD_IN_USE

Dave Jones <davej@codemonkey.org.uk>:
  o [WATCHDOG] clean up includes
  o [WATCHDOG] Final 2.4 bits for advantechwdt
  o [WATCHDOG] Final 2.4 bits for eurotechwdt
  o [WATCHDOG] Final 2.4 bits for ib700wdt
  o [WATCHDOG] Final 2.4 bits for softdog.c
  o [WATCHDOG] Final 2.4 changes for w83877f_wdt.c
  o [WATCHDOG] final 2.4 fixes for wdt.c
  o [WATCHDOG] Final 2.4 changes for wdt285.c
  o [WATCHDOG] Final 2.4 changes for wdt_pci.c
  o [AGPGART] warning fixes from Bjorn's last patches
  o [AGPGART] implement module locking that works
  o [AGPGART] Remove ancient unused bits from headers

David Brownell <david-b@pacbell.net>:
  o maintain hcd_dev queue in FIFO order

David S. Miller <davem@nuts.ninka.net>:
  o [SUNSAB]: Fix uart_get_baud_rate args
  o [SPARC64]: Define PAGE_BUG in asm/bug.h
  o [SPARC64]: Add UltraSPARC-III cpu frequency driver
  o [SPARC64]: Move topology_init to setup.c, it is not SMP specific
  o [SPARC64]: Use init/exit facility of cpufreq infrastructure
  o [SPARC64]: Update defconfig

Dominik Brodowski <linux@brodo.de>:
  o cpufreq: fix compilation, name of gx-suspmod driver

Duncan Sands <baldrick@wanadoo.fr>:
  o USB: kill speedtouch tasklet when shutdown
  o USB: make more speedtouch functions static
  o USB: SpeedTouch not Speed Touch

Eric Sandeen <sandeen@sgi.com>:
  o [XFS] Make sure we don't walk off the end of the err_level array
  o [XFS] Fix dyslexic definition of XFS_MAX_ERR_LEVEL
  o [XFS] Merge max file offset fix - use standard Linux macros
  o [XFS] Handle mode 0 inodes that find their way onto the unlinked
    list These shouldn't be there, probably the result of corruption.

Gabriel Paubert <paubert@iram.es>:
  o Cleanup of the lcall7/lcall27 entry path

Geert Uytterhoeven <geert@linux-m68k.org>:
  o Amiga keyboard fix
  o Q40/Q60 IRQ updates from 2.4.x
  o M68k exception table updates
  o Sun-3: Add missing deactivate_mm()
  o M68k generic RTC driver updates
  o Atari ST-RAM swap update
  o Q40/Q60 keyboard fixes
  o Generic RTC driver documentation
  o Mac/m68k NCR5380 SCSI updates

Greg Kroah-Hartman <greg@kroah.com>:
  o USB: put the usb storage's SCSI device in the proper place in sysfs
  o TTY: add module reference counting for tty drivers
  o USB: add dev attribute for usb-serial devices in sysfs
  o USB: added .owner for USB drivers that have a struct tty_driver

Greg Ungerer <gerg@snapgear.com>:
  o bug.h for m68knommu arch
  o remove BUG from m68knommu arch page.h
  o remove obsolete himem.ld from m68knommu sub-arch
  o clean up linker symbols in 68EZ328 ucsimm target
  o clean up linker symbols in 68EZ328 ucdimm target
  o move common macros into m68knommu entry.h
  o remove common code from m68knommu/5307 entry.S
  o remove common code from m68knommu/68328 entry.S
  o remove common code from m68knommu/68360 entry.S
  o build common m68knommu entry.S

Henning Meier-Geinitz <henning@meier-geinitz.de>:
  o Change maintainership of USB scanner driver

Ivan Kokshaysky <ink@jurassic.park.msu.ru>:
  o alpha ksyms From Jeff.Wiedemeier@hp.com:
  o alpha bootp target From Jeff.Wiedemeier@hp.com:
  o alpha ipi timeout From Jeff.Wiedemeier@hp.com:
  o alpha HARDIRQ_BITS From Jeff.Wiedemeier@hp.com:
  o alpha kernel layout From Jeff.Wiedemeier@hp.com:
  o alpha osf_shmat lock From Jeff.Wiedemeier@hp.com:
  o alpha ev6/ev7 virt_to_phys From Jeff.Wiedemeier@hp.com:
  o alpha console callbacks From Jeff.Wiedemeier@hp.com:
  o alpha ide hwifs From Jeff.Wiedemeier@hp.com:
  o alpha mem_size_limit From Jeff.Wiedemeier@hp.com:
  o alpha numa iommu From Jeff.Wiedemeier@hp.com:
  o alpha numa update From Jeff.Wiedemeier@hp.com:
  o alpha smp fixes From Jeff.Wiedemeier@hp.com:
  o alpha kernel start address From Jeff.Wiedemeier@hp.com:
  o alpha PCI setup update
  o alpha_remap_area_pages From Jeff.Wiedemeier@hp.com:
  o alpha titan update From Jeff.Wiedemeier@hp.com:
  o alpha irq proc update From Jeff.Wiedemeier@hp.com:
  o alpha smp callin From Jeff.Wiedemeier@hp.com:

James Morris <jmorris@intercode.com.au>:
  o [CRYPTO]: Add support for SHA-386 and SHA-512
  o [CRYPTO] remove superfluous goto from des module init exception
    path
  o [CRYPTO] Add AES and MD4 to tcrypto crypto_alg_available() test

James Simmons <jsimmons@kozmo.(none)>:
  o [ATY] Somehow a merge mistake happened. We removed fb_set_var

James Simmons <jsimmons@maxwell.earthlink.net>:
  o I810 fbdev updates. Cursor fix for ati mach 64 cards on big endian
    machines. Buffer over flow fix for fbcon putcs function. C99
    initializers for the STI console drivers.Voodoo 1/2 and NVIDIA
    driver updates
  o Added resize support for the framebuffer console. Now you can
    change the console size via stty. Also support for color palette
    changing on VC switch is supported
  o [RIVA FBDEV] Driver now uses its own fb_open and fb_release
    function again. It has no ill effects. The drivers uses strickly
    hardware acceleration so we don't need cfb_fillrect and
    cfb_copyarea
  o Updates from Helge Deller for the console/fbdev drivers for the
    PARISC platform. Small fix for clearing the screen and a string
    typo for the Voodoo 1/2 driver
  o [MONITOR support] GTF support for VESA complaint monitors. Here we
    calculate the general timings needed so we don't over step the
    bounds for a monitor
  o Remove fb_set_var. Some how it was missed in a merge conflict
  o Final updtes to the GTF code. Now the code can gnerate GTF timings
    regardless of the validity of info->monospecs
  o [TRIDENT FBDEV] Driver ported to the new api
  o [GENERIC IMAGEBLIT ACCEL]
  o [STI] Updates to latest PARISC changes. Use the latest PCI ids

Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>:
  o Module Sanity Check
  o ISDN/HiSax: Fix typo in drivers/isdn/hisax/config.c
  o ISDN/HiSax: Fix PnP merge
  o ISDN: Fix the janitor fix
  o Consolidate read-only sections in arch/*/vmlinux.lds.S
  o kbuild: fix broken kallsyms on non-x86 archs
  o kbuild/modules: Save space on symbol list
  o kbuild: Make asm-generic/vmlinux.lds.h usable for IA-64
  o kbuild: kallsyms cleanup

Laszlo Valko <valko@linux.karinthy.hu>:
  o [SPARC64]: Handle SO_TIMESTAMP properly in compat recvmsg

Linus Torvalds <torvalds@home.transmeta.com>:
  o We need to assign resources to cardbus cards _regardless_ of
    whether probing tells us they already have a range. The old
    information is stale.
  o Fix backslash at end of file
  o Fix page_address() to not re-evaluate its arguments multiple times
    under certain circumstances.

Marc Zyngier <mzyngier@freesurf.fr>:
  o sysfs EISA support
  o EISA naming database
  o EISA sysfs updates to 3c509 and 3c59x drivers
  o EISA sysfs AIP update

Martin J. Bligh <mbligh@aracnet.com>:
  o Fix interrupt dest mode / delivery mode confusion
  o Add ACPI hook, rename raw_phys_apicid to bios_cpu_apicid
  o Make IRQ balancing work with clustered APICs
  o Fix APIC header defines for Summit
  o Enable Summit in makefile, update summit subarch code
  o make vm_enough_memory more efficient
  o (1/3) Minimal NUMA scheduler
  o (2/3) Initial load balancing
  o (3/3) NUMA rebalancer

Matthew Wilcox <willy@debian.org>:
  o acpi_bus_register_driver patch

Nathan Scott <nathans@sgi.com>:
  o [XFS] Fix up some comments, tidy up some macros - no functional
    changes

Patrick Mansfield <patmans@us.ibm.com>:
  o USB storage sysfs fix

Patrick Mochel <mochel@osdl.org>:
  o driver model: update documentation
  o kobject: export kset_find_obj
  o sysfs: fixup some remaining s390 files
  o sysfs: fixup NUMA file that was missed
  o sysfs: minor documentation update
  o sysfs: fixup SCSI debug driver files
  o deadline iosched: make sure queue is valid before unregistering it
  o driver model: fix bogus driver binding error reporting and handling

Paul Mackerras <paulus@samba.org>:
  o PPC32: Add support for PPC 4xx on-chip devices using the generic
    device model.
  o PPC32: Page-align the data section of the boot wrapper
  o PPC32: Better support for PPC 4xx debug facilities
  o PPC32: Use a per-cpu variable for prof_counter and prof_multiplier

Randy Dunlap <randy.dunlap@verizon.net>:
  o update LOG BUF SIZE config

Richard Henderson <rth@are.twiddle.net>:
  o [ALPHA] Expose shifts in virt_to_phys to the compiler
  o [ALPHA] Use direct calls to titan_ioremap/unmap when building a
    titan specific kernel.
  o [ALPHA] AGP infrastructure for AGP implemented in Alpha corelogic
    (Titan / Marvel), Kconfig and headers.
  o [ALPHA] Marvel (AlphaServer ES47, ES80, GS1280) support
  o [ALPHA] Fixups to Marvel and Titan for incomplete merging
  o [ALPHA] Formatting cleanup, warning removal, move declarations to
    header files where they belong.
  o [ALPHA] Correct io.h exports and inlining for marvel and titan
  o [ALPHA] Corrections to recent vmlinux.lds.S changes

Roger Luethi <rl@hellgate.ch>:
  o export skb_pad symbol
  o Fix via-rhine using skb_padto

Roland Dreier <roland@topspin.com>:
  o [NET]: Fix up RTM_SETLINK handling

Russell Cattelan <cattelan@sgi.com>:
  o [XFS] Fix the cmn_err stuff to mask the error level before it
    checks for max value
  o [XFS] make *cmn_err interrupt safe
  o [XFS] Revisit the remount read only code again

Russell King <rmk@flint.arm.linux.org.uk>:
  o [ARM] Add new system call entries
  o [ARM] Remove redundant definitions from ide.h
  o [ARM] Fix CPUFREQ initialisation oops
  o [ARM] Update sa1100fb
  o [ARM] Update acornfb for new fbcon layer
  o [ARM] Use new asm/bug.h for arch/arm/kernel/bios32.c
  o [ARM] Prevent "scheduling while atomic" in cpu_idle()
  o [ARM] Update mach-types; add 8 new machine types, fix karo entry
  o [ARM] Fix failure paths in fd1772.c initialisation
  o [ARM/IDE] Fix BLK_DEV_IDEDMA setting on non-Acorn ARM systems
  o [ARM] Fix Integrator __virt_to_bus/__bus_to_virt

Stephen Rothwell <sfr@canb.auug.org.au>:
  o compat_{old_}sigset_t generic part
  o compat_{old_}sigset_t s390x part
  o compat_sys_sigpending and compat_sys_sigprocmask
  o compat_sys_sigpending and compat_sys_sigprocmask

Tom Rini <trini@kernel.crashing.org>:
  o PPC32: Change the MontaVista copyright / GPL boilerplate to a
    condensed version.

Trond Myklebust <trond.myklebust@fys.uio.no>:
  o Fix RPC client warning in 2.5.58
  o Fix NFS root mount handling


