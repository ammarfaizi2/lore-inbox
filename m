Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265409AbTABDgs>; Wed, 1 Jan 2003 22:36:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265413AbTABDgr>; Wed, 1 Jan 2003 22:36:47 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:39941 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S265409AbTABDgl>; Wed, 1 Jan 2003 22:36:41 -0500
Date: Wed, 1 Jan 2003 19:43:40 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Linux v2.5.54
Message-ID: <Pine.LNX.4.44.0301011935410.8506-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Happy new year to you all, hopefully most of you are back from the dead 
and the hangovers are all long gone.  And if not, I'm told reading a large 
kernel patch is _just_ the medication for whatever ails you.

The 2.5.54 patch is largely mainly a big collection of various small
things, all over the place (diffstat shows a long list of small changes,
with some noticeable activity in UML, the MPT fusion driver and some of
the fbcon drivers).

Various module updates (deprecated functions, updated loaders etc), usb, 
m68k, x86-64 updates, kbuild stuff etc etc.

		Linus

----

Summary of changes from v2.5.53 to v2.5.54
============================================

<dmitri@users.sourceforge.net>:
  o Extra parameters removed from the ultracam driver

<pablo@menichini.com.ar>:
  o Handle kmalloc fails: drivers/usb/input/pid.c

<ramune@net-ronin.org>:
  o Documentation/Changes for modules

<redbliss@libero.it>:
  o fix null agp_bridge.dev with KT400

<wrlk@riede.org>:
  o One more update for osst in 2.5.53

Alan Stern <stern@rowland.harvard.edu>:
  o ide-tape driver update

Andi Kleen <ak@muc.de>:
  o kbuild: Stem compression for kallsyms
  o share i386/x86-64 oprofile code
  o x86-64 update
  o Add AMD K8 support to 2.5.53

Andrew Morton <akpm@digeo.com>:
  o INIT_TASK/INIT_TSS cleanup
  o remove unused local in drivers/pci/probe.c
  o Fix compile warning in drivers/serial/core.c
  o disable dead functions smp_read_mpc_oem() and
  o fix wakeup_secondary_cpu warning, code bloat
  o fix numaq builds
  o Docs: fix explanation of file-nr
  o Remove /proc/meminfo:MemShared
  o BIN_TO_BCD consolidation
  o Enable semtimedop for ia64 32-bit emulation
  o add drain_local_pages() for CONFIG_SOFTWARE_SUSPEND
  o kmalloc_percpu -- stripped down version
  o Don't cacheline-align vm_area_struct
  o remove task_struct.swappable
  o remove hugetlb syscalls
  o Fix missing brelse() on ext3 htree error path
  o promote the ALIGN() macro
  o don't call console drivers on non-online CPUs
  o Reduce context switch rate due to the random driver
  o Don't make the slab might_sleep() check dependent on slab debugging
  o quota locking update

Arnaldo Carvalho de Melo <acme@conectiva.com.br>:
  o sparc: add missing __{start,stop}___param to vmlinux.lds.S

Brian Murphy <brm@murphy.dk>:
  o crc32 speedup/use anywhere

Christoph Hellwig <hch@lst.de>:
  o remove CONFIG_X86_NUMA
  o nommu systems can't support /proc/<pid>/maps
  o rewrite i2c-amd756 to resemble a linux driver
  o check_region remove for drivers/i2c/
  o make i2c use initcalls everywhere
  o more deprectation bits
  o avoid deprecated module functions in core code
  o clean up subarchitecture selection
  o remove superflous module use count handling in jbd
  o more module warning fixes
  o get rid of TRUE/FALSE abuse in the scsi midlayer
  o fix i2c module handling
  o i2c updates
  o remove obsolete i2c headers
  o more obsolete module API fixes
  o rename CONFIG_VOYAGER to CONFIG_X86_VOYAGER
  o Missed one 'try_inc_mod_count()'
  o fix fs/dquot.c compilation
  o more i2c cruft removal
  o include <linux/vfs.h> only in files actually needing it
  o devfs creptomancy
  o some ppp/usecount bug

Dave Jones <davej@codemonkey.org.uk>:
  o [AGP] remove unused variable from 8151 GART driver
  o [AGP] CONFIG_AGP3 depends on CONFIG_AGP
  o [AGP] set the AMD8151 agp_bridge.type if we detected it
  o [AGP] propagate agp_backend_acquire() return code up to the ioctl
  o [AGP] Remove broken deprecated module locking
  o [AGP] Clean up atomic usage of agp_bridge.agp_in_use
  o [AGP] Gratuitous whitespace cleanups
  o [AGP] mmap readability cleanup
  o Fix up numerous '`xxxxx' is not at beginning of declaration' style
    warnings

David Brownell <david-b@pacbell.net>:
  o usbcore dma updates (and doc)
  o cleanup after dead hc needs task context
  o ehci.txt (doc update)

Dominik Brodowski <linux@brodo.de>:
  o cpufreq: deprecated usage of CPUFREQ_ALL_CPUS
  o cpufreq: longhaul cleanup
  o cpufreq: powernow-k6 cleanup
  o cpufreq: remove usage of #typedef

Douglas Gilbert <dougg@torque.net>:
  o 2.5.53 SCSI_IOCTL_GET_IDLUN+GET_BUS_NUMBER revisited

Ganesh Varadarajan <ganesh@tuxtop.vxindia.veritas.com>:
  o USB ipaq driver update

Geert Uytterhoeven <geert@linux-m68k.org>:
  o M68k {,smp_}read_barrier_depends()
  o M68k do_coredump() update
  o M68k module list updates
  o M68k do_fork() updates
  o M68k *__param sections
  o M68k thread_info.restart_block
  o STRAM for_each_process()
  o NCR5380 unbalanced curly brace
  o struct font_desc
  o Atari NCR5380 SCSI: bitops operate on long
  o Sun-3 and Atari NCR5380 scsi_host_hn_get()
  o Ataflop compile fix
  o Amiflop incorrect sti()
  o M68k local_irq_count update
  o NCR53C9x ESP updates
  o duplicate bwtwofb Makefile entry
  o Mac/m68k VIA updates
  o struct font_desc external use
  o M68k parport local_irq*() updates
  o M68k net local_irq*() updates
  o M68k bogus prototype
  o BVME6000 core local_irq*() updates
  o Sun-3x core local_irq*() updates
  o Mac/m68k core local_irq*() updates
  o M68k block local_irq*() updates
  o M68k char local_irq*() updates
  o MVME147 core local_irq*() updates
  o M68k fbdev local_irq*() updates
  o M68k misc_register audit
  o Mac/m68k early startup fixes
  o Sun-3 core local_irq*() updates
  o M68k mac local_irq*() updates
  o M68k initramfs updates
  o Q40/Q60 core local_irq*() updates
  o MVME16x core local_irq*() updates
  o Atari core local_irq*() updates
  o Nubus local_irq*() updates
  o Mac/m68k config fixes
  o Missing #include <linux/interrupt.h>
  o WD33C93 SCSI irq framework updates
  o M68k MAP_* definitions
  o Sun-3/3x PTE updates
  o M68k module updates
  o M68k SCSI host templates
  o Sun-3 SBUS updates
  o register_console() comment typo
  o Mac/m68k Nubus updates
  o Sun-3 serial
  o Amiga FastLane SCSI z_io{re,un}map()
  o STRAM printf() format
  o z2ram: unused variables
  o Q40 keyboard warnings
  o M68k scsi local_irq*() updates
  o Atari Falcon IDE: clean up ide_intr_lock handling
  o Atari NCR5380 SCSI: bitops operate on long

Greg Kroah-Hartman <greg@kroah.com>:
  o USB: make the usbserial driver have the same name for the tty, usb,
    and module subsystems
  o USB: convert visor driver to use dev_err() and dev_info() macros
  o USB: convert usbserial core to use dev_err() and dev_info() macros
  o USB: convert empeg driver to use dev_err() and dev_info() macros
  o USB: convert io_edgeport driver to use dev_err() and dev_info()
    macros
  o USB: convert io_ti driver to use dev_err() and dev_info() macros
  o USB: convert ir-usb driver to use dev_err() and dev_info() macros
  o USB: convert keyspan driver to use dev_err() and dev_info() macros
  o USB: convert pl2303 driver to use dev_err() and dev_info() macros
  o USB: take out private pointer from struct usb_serial_port
  o USB: fix up the usb-serial drivers due to the removal of the struct
    usb_serial_port private pointer
  o USB: add usb_get_serial_data() and usb_set_serial_data() functions
  o USB: use usb_get_serial_data() and usb_set_serial_data() functions
  o USB: remove private_data pointer from struct usb_interface, as it
    shouldn't be used anymore
  o USB: fix compiler warnings in the isdn usb drivers
  o USB misc drivers: remove direct calls to dev_set* and dev_get*
  o USB serial drivers: remove direct calls to dev_set* and dev_get*
  o USB core drivers: remove direct calls to dev_set* and dev_get*
  o USB media drivers: remove direct calls to dev_set* and dev_get*
  o USB skeleton driver: remove direct calls to dev_set* and dev_get*
  o USB class drivers: remove direct calls to dev_set* and dev_get*
  o USB image drivers: remove direct calls to dev_set* and dev_get*
  o USB input drivers: remove direct calls to dev_set* and dev_get*
  o USB skeleton: missed a dev_get_drvdata usage
  o USB net drivers: remove direct calls to dev_set* and dev_get*
  o USB storage driver: remove direct calls to dev_set* and dev_get*
  o USB drivers outside /drivers/usb: remove direct calls to dev_set*
    and dev_get*
  o USB: fix up some bugs in the cpia driver
  o USB: rename usb_free_dev() to usb_put_dev()
  o USB: use the driver model to handle reference counting of struct
    usb_device
  o USB: fix kaweth driver which was accessing the struct usb_device
    refcnt variable directly
  o USB: more dev_printk() cleanups
  o TTY: Change tty_*register_devfs() to tty_*register_device()
  o TTY: add tty_devclass to the tty core
  o TTY: Use the tty_devclass for all usb-serial devices
  o TTY: replace MIN and MAX macro usages with min() and max()
  o USB: fix up init_module and cleanup_module mess in speedtouch
    driver
  o USB: convert more dbg() calls to dev_dbg for the ohci driver
  o USB: convert more dbg() calls to dev_dbg for the usb core

Henning Meier-Geinitz <henning@meier-geinitz.de>:
  o scanner.c: Accept scanners with more than one interface
  o scanner.c: fix compilation error with debugging enabled

Hirofumi Ogawa <hirofumi@mail.parknet.co.jp>:
  o adds st_blocks for [lf]stat() to ramfs
  o Simplify ramfs_getattr() and move it to the generic libfs.c

Ingo Molnar <mingo@elte.hu>:
  o Save fs/gs over vm86 mode switch

Ivan Kokshaysky <ink@jurassic.park.msu.ru>:
  o fix PCI bridge handling in probe.c

James Bottomley <james.bottomley@steeleye.com>:
  o kbuild: fix bug in scripts/kallsyms.c
  o Fix pci-dma compatibility code for "dev == NULL"
  o Fix hw_irq to test the proper CONFIG variable
  o Enable Voyager in current kernel
  o separate out trampoline so other subarchs can use it
  o Move voyager sysrq to V key and remove from char/sysrq.c
  o subarch: change SMP define to X86_HT
  o Make the TSC a run-time specifier only
  o boot with small  GDT
  o fix aic7xxx highmem bouncing

James Simmons <jsimmons@infradead.org>:
  o Fixes from the PPC guys. Lots of small fixes
  o More STI updates
  o Fix for m68k. They need the struct font_desc super early in the
    boot process
  o Added in Radeon PCI ids into pci_ids.h from radeon.h. IGA fbdev
    uses C99 now
  o Anothe rattempt at commting
  o Updates for the STI fbdev and console driver
  o Updates to the NVIDIA driver. We now support more cards. I still
    have more hacking to do
  o Voodoo 1 ported to new api. STI and NVIDIA updates. MDA console
    fixes. Moved the logo code from fbcon to fbdev
  o Port of chipsfb driver to new api. Removed the fontwidth8 option.
    Let the xxxfb_imageblit function handle this. 64 bit m achine fixes
  o Merge with davem work
  o Merged with Linus tree. Some conflicts to resolve
  o Ported Voodoo1 driver to new api
  o Radeon driver port to final api. Cleanup of vga16fb
  o Link in fix and cleanup plus a typo in pmagb-b-fb.h file
  o Remove old module crap
  o Showing the logo on every open became annoying. I leave it up to
    the driver writers when they want to display the logo. Fo embeded
    devices it probably is wise to have them set there mode themselves
    then display the logo to let them know if the hartdware worked.
    FOnt header file location changed

Jaroslav Kysela <perex@suse.cz>:
  o PnP update

Jeff Dike <jdike@uml.karaya.com>:
  o Moved the net changes to arch/um/drivers/Makefile into updates to a
    void a merge conflict.
  o Merged the network fixes from the 2.4 pool
  o Copied in the new files for the slirp transport and slip cleanup
  o Merged the help text from the 2.4 Configure.help
  o Added the UML HOWTO in Documentation/uml
  o Updated to 2.5.48
  o Merged the get_config changes from 2.4
  o A few more fixes to get 2.4.48 to boot
  o Merged a number of bug fixes from the 2.4 pool
  o Moved the ptproxy code from arch/um/ptproxy to
    arch/um/kernel/tt/ptproxy.
  o Fixed the Makefiles so that the ptproxy move from arch/um/ptproxy
    to arch/um/kernel/tt/ptproxy works.
  o Merged the os_kill_process and the driver from_user changes from
    the 2.4 pool.
  o Fixes to the last merge
  o Merged the signal frame cleanups and fixes from 2.4
  o Fixed a couple of buglets in the signal frame merge
  o Merged the skas exec reorg
  o Declared mode_tt in user_util.h
  o Merged most of the rest of the skas changes
  o Added arch/um/kernel/skas/util/*, which I missed somehow
  o Added ptrace-skas.h and ptrace-tt.h
  o Added mode.h, mk_constants_kern.c, mk_constants_user.c, and
    um_mmu.h
  o Added the mode mmu.h and mode.h headers
  o Changed the config to pull in zlib
  o Added arch/um/include/mode_kern.h
  o Added a batch of files under arch/um/kernel/skas
  o Added a bunch of C files under arch/um/kernel/skas and
    arch/um/kernel/tt.
  o Added skas/mem_user.c and tt/gdb.c
  o Added the uaccess changes from the skas merge
  o A number of small fixes for the uaccess merge
  o Applied the sigcontext changes in the skas code
  o Some minor build and compilation fixes to the copy_sc merge
  o Merged the IP checksum changes from the skas code
  o Removed the checksum.S symlink from arch/um/sys-i386/Makefile
  o Some small build fixes to the IP checksum merge
  o Merged a number of small skas changes
  o Minor build fixes to the last batch of skas merges
  o Merged the tlb.c changes from the skas patch
  o Fixed various build problems with the tlb.c merge
  o Merged the rest of the skas changes
  o Finished the skas merge by eliminating a syntax error, fixing the
    new compilation warnings, and fixing a call to handle_page_fault.
  o Updated to 2.5.49, which involved fixing the calls to do_fork
  o A whole lot of small changes to sync up the 2.4 and 2.5 pools
    somewhat.  Mostly whitespace changes, plus some code movement.
  o Small fixes to sync up the 2.4 and 2.5 pools
  o Fixed a stupid compile bug
  o Updated to 2.5.50
  o Added a couple of includes as part of the 2.5.50 update
  o Applied updates from 2.5.51 and 2.5.52
  o Removed includes of Rules.mk
  o Updated to 2.5.52.  A couple of changes relating to system call
    restarting.
  o Forward ported a bunch of fixes from 2.4
  o Fixed the calls to os_get_process in port_kern.c

Jochen Hein <jochen@jochen.org>:
  o fix uninitialized timer in yenta.c

Justin T. Gibbs <gibbs@overdrive.btc.adaptec.com>:
  o Decend into the aic7xxx directory for the aic79xx driver too
  o Correct leading whitespace
  o Remove incorrect dependency on SCSI_AIC7XXX_BUILD_FIRMWARE and
    AIC7XXX_REG_PRETTY_PRINT.  The constant rebuild is due to the build
    process deciding that the pretty_print.c file is an intermediate
    file and that problem lies elsewhere.
  o Preface the "asserting atn" diagnostic with controller/target
    information
  o Preface the "asserting atn" diagnostic with controller/target
    information
  o Correctly enable highmem_io option in 2.5.X
  o Restore driver style.  All functions are declared prior to being
    defined
  o Fix the last reference to the reg_print.c file handle in
    symtable_dump
  o Use down_interruptable() rather than down() to avoid having the DV
    threads counted toward the load average. 
  o Ignore media not-present errors during DV.  This caused DV to fail
  o Clean up check_region() usage.  It is deprecated in 2.5.X and
    2.4.X, but is still required in earlier kernels.
  o Add a failsafe mechanism to configure devices that have inquiry
    data but somehow are not handled by the DV state machine.  This
    ensures that the behavior seen before DV is restored in the event
    of a DV state machine failure.
  o Bump aic7xxx and aic79xx driver versions to reflect recent DV
    changes

Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>:
  o kbuild: Fix sounds/synth/emux/Makefile
  o kbuild: Fix "make some/file.lst"
  o kbuild: Fix kallsyms on 64 bit archs
  o kbuild: Provide "make some/dir/module.ko"

Linus Torvalds <torvalds@home.transmeta.com>:
  o AIC7XX_PROBE_EISA_VL should depend on SCSI_AIC7XXX
  o Make the default values for DS/ES be the _user_ segment descriptors
  o The fast poll code incorrectly assumed that "sizeof pp" was the
    same as "offsetof pp->entries". Which happens to be true on 32-bit
    platforms, but not on 64-bit ones.
  o Get rid of atari-specific "ide_intr_lock" from generic IDE code
  o Enable prefetching on P4/PIII class machines with
    CONFIG_X86_PREFETCH
  o Lost CONFIG_X86_TSC in voyager merge
  o Update x86 "defconfig" to something that matches our current config
    a bit more closely.
  o Fix some special cases for "sysenter" - some system calls depend on
    doing a full register restore on return to user space, and thus
    require the long system call exit path (ie "iret" instead of
    "sysexit").
  o Force 64-bit extend for x86 __put_user_u64(), since nothing in the
    inline asm will do it for us.
  o Put X86_NUMAQ and X86_SUMMIT under the "Subarchitecture Type"
    config
  o Add proper dependencies for the i2c chips/busses
  o Crapectomy
  o Avoid unused variable in route.c
  o Make x86 platform choice strings more easily selectable
  o Find the QT libs in more places.. (At least RH-8.1)
  o Quoth James: "Oops, mea culpa on that one.  It's missing a trailing `__'
  o From louis.zhuang@intel.com: missed field_width reset in vsscanf()
  o Ignore generated files in lib/
  o Remove old kernel version test that didn't even compile

Mikael Pettersson <mikpe@csd.uu.se>:
  o Fix AGP module oops The stack trace shows that we should be in
    agp_find_max() as called from agp_backend_initialize(). However,
    agp_find_max() is __init and its code has already been removed at
    this point (since agpgart and intel-agp are separate modules),
    causing the kernel to execute random code and eventually oops.  

Pam Delaney <pdelaney@lsil.com>:
  o Fusion-MPT Update (2.03.01.01)

Pavel Machek <pavel@ucw.cz>:
  o Make swsuspend restore DS/ES segments properly
  o amd756 and amd8111 sensors support

Randy Dunlap <randy.dunlap@verizon.net>:
  o fix "deprecated" typos

Richard Henderson <rth@twiddle.net>:
  o [FB] Fix minor typos wrt readq/writeq support on 64-bit targets
  o [FB] First cut at updating tgafb to 2.5 fb api.  A large scale
    rewrite modeled off of skeletonfb.c.
  o [FB] Use u32 instead of unsigned long for cfbimgblt bit ops
  o [TGAFB] Minor bug fixes to obtain a working TGA console with the
    new FB API.
  o Cset exclude: rth@are.twiddle.net|ChangeSet|20021227230408|33498
  o [TGAFB] Implement the fb_imageblit hook
  o Trivial patch for param.h: make it const
  o Trivial patch for module.c: Strtab by sh_link field

Robert Love <rml@tech9.net>:
  o deprecated function attribute
  o __deprecated requires gcc 3.1

Rusty Russell <rusty@rustcorp.com.au>:
  o Modules without init functions don't need exit functions
  o Embed __this_module in module itself
  o Fix MODULE_PARM for arrays of s
  o Minor compile fix for some modules
  o more module parameter parsing bugs
  o MODULE_PARM "c" support
  o Modules 1/3: remove common section handling
  o Modules 2/3: Use sh_addr instead of sh_offset
  o Modules 3/3: Sort sections

Sam Ravnborg <sam@ravnborg.org>:
  o kbuild: More src/objtree fixes
  o kbuild: $(build) and $(clean) macros for make invocation
  o kbuild: Move archhelp to arch/$(ARCH)/Makefile
  o kbuild/arm: archhelp and $(build)
  o kbuild/sparc64: archhelp and $(build)
  o kbuild/x86_64: archhelp, $(build) usage and cleaning
  o Spurious recompile with defconfig

Stephen Rothwell <sfr@canb.auug.org.au>:
  o eliminate __kernel_..._t32 from s390x

Tomas Szepe <szepe@pinerecords.com>:
  o fix up UP-APIC compile
  o i810: get rid of a forgotten Rules.make include

Vojtech Pavlik <vojtech@suse.cz>:
  o USB Joypad quirk
  o Workaround (ide-timing.h) for many ATAPI CD/DVD-ROMs and burners

William Stinson <wstinson@wanadoo.fr>:
  o mark check_region "deprecated"


