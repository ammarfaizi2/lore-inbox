Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264890AbSK0XB0>; Wed, 27 Nov 2002 18:01:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264901AbSK0XB0>; Wed, 27 Nov 2002 18:01:26 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:53008 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S264890AbSK0XBU> convert rfc822-to-8bit; Wed, 27 Nov 2002 18:01:20 -0500
Date: Wed, 27 Nov 2002 15:07:38 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Linux v2.5.50
Message-ID: <Pine.LNX.4.44.0211271456160.18214-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
X-MIME-Autoconverted: from 8bit to quoted-printable by deepthought.transmeta.com id gARN8WR20479
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Taking a small thanksgiving break, but before that here's 2.5.50.

Merges from Alan, Dave and Andrew. ACPI, USB, LSM and SCSI updates. Sparc, 
ARM and v850 architecture updates.

I wish you all a Happy Thanksgiving (*).

		Linus

(*) For the non-US aware of you out there: it's the time of year when the
whole country turns into one big turkey-filled trough, and pretty much
everybody just pigs out. The amount of turkey consumed would roughly reach
5.4 times to the moon and back, if all the turkeys were laid in a straight
line. Small black holes form where enough fat people get together. It's
not pretty. And I'll do my best to blend in ;^).

----

Summary of changes from v2.5.49 to v2.5.50
============================================

<aris@cathedrallabs.org>:
  o drivers/acpi/ac.c: convert to seq_file
  o acpi: convert drivers/acpi/button.c to seq_file
  o acpi: convert drivers/acpi/power.c to seq_file
  o acpi: convert drivers/acpi/processor.c to seq_file
  o acpi: convert drivers/acpi/sleep.c to seq_file
  o acpi: convert drivers/acpi/thermal.c
  o acpi: convert drivers/acpi/toshiba_acpi.c to seq_file

<baldrick@wanadoo.fr>:
  o usbdevfs: finalize urbs on interface release

<ganesh@tuxtop.vxindia.veritas.com>:
  o added support for insmod options to specify vendor/product id. this

<jtyner@cs.ucr.edu>:
  o USB: [patch] fix vicam disconnect/locking
  o [patch] speed/clean up vicam_decode_color

<mark@hal9000.dyndns.org>:
  o USB ov511 driver: Update to version 1.63

Alan Cox <alan@lxorguk.ukuu.org.uk>:
  o mips people cant spell either
  o trivial exception typo fix in m68k
  o fix journalling api doc
  o update mouse drivers doc
  o big much needed magic number update from Petr Baudis
  o acpi people can't spell
  o update nbd driver to large sizes etc
  o AGP defines for intel 7505
  o rescue ftape from the ravages of that Rusty chap
  o fix up ip2main for rusty
  o add extra pad/app mappings for ARM/PC98 keyboars
  o fix tpqic02 + tidy it up
  o fixups for error path on sc1200 wdog
  o fix cpq asm
  o Make IDEDMA handled by a tuning option not masses of ifdef
  o switch ide taskfile to new DMA policy
  o remove IDE DMA conditionals from tape
  o add printk levels to ide taskfile
  o put back the comment someone randomly deleted
  o printk levels for cmd640
  o add prototype Cyrix 5510/5520 driver for IDE PIO VDMA
  o clean up cs5530 driver DMA ifdef
  o clean up generic IDE dma for new ifdefs
  o clean up ite ide for new ifdef stuff
  o clean up highpoint ide for new dma ifdef stuff
  o clean up natsemi IDE for new ifdef stuff
  o clean up nvidia dma for new ifdef stuff, fox pci res type
  o clean up opti ide for new ifdef stuff
  o clean up promise IDE, ifdefs, unused code etc
  o clean up pdc adma for new dma bits
  o clean up intel PIIX for new style dma ifdefs
  o driver for National SCx200 IDE
  o clean up serverworks DMA handling, fix /proc bugs etc
  o clean up siiimage ide for new ifdef style
  o clean up trm290 for new ifdef style
  o clean up sis ide for new ifdef style
  o clean up via dma for new ifdef stuff
  o split up setup-pci further
  o update amd7xx ide for new dma bits
  o update ALi IDE for new ifdefs, avoid ali/ati combo
  o update cmd64x for new ide bits
  o update cy82c693 ide for new dma bits
  o update aec ide for new ifdefs
  o add new ide stuff to makefile
  o update ide i/o ops to new dma, saner naming
  o remove io related stuff from ide.c
  o update ide-disk
  o add new ide config entries fix cmd680 doc
  o clean up ide floppy
  o IDE DMA updates
  o put ide i/o code from ide.c into ide-io.c and comment it
  o update ide makefile for split ide
  o ide-probe bits
  o ide headers
  o make some gameports compile again
  o isdn people cant spell
  o make bttv compile
  o update sa7111/7185 to new i2c
  o dvb updates - mostly typedef to structs and other similar cleaning
  o make arcnet compile
  o bring i2o back into sync, clean up oddments
  o mpt fusion update from vendor
  o make ewrk3/depca work again
  o update baycom drivers, remove soundmodem deps
  o locking for dmascc
  o kill soundmodem makefile entry
  o make aironet compile
  o fix missing PCMCIA timer inits
  o make vlsi IR compile
  o kill soundmodem
  o more people cant spell
  o printk levels for slip
  o fix tokenring builds
  o fix hostess driver for 2.5
  o add missing attributions to pc300
  o update sealevel isa sync card to 2.5.x
  o add a fixme for the pci
  o update nec pci idents
  o update quirks
  o add sis apic workaround support
  o sanitize pnp init order
  o davem cant spell 8()
  o 3ware needs interrupt.h
  o domex driver needs interrupt.h
  o more scsi header cleanup/fixes
  o fix eata_pio
  o i60scsi to new eh
  o fix in2000 compile
  o inia header
  o new eh for inia wrapper too
  o switch ips to request_region check
  o dont include removed header
  o pas16 needs interrupt.h
  o restore lost proc_print_scsi prototype
  o t128 needs interrupt.h
  o ultrastor reset callback bug
  o 68328 frame buffer
  o fix vga16 build until James console updates are merged
  o proc is in the wrong order
  o dvb header updates
  o more pci ident defines
  o reserve a serio bit for PC98
  o we can kill off the soundmodem headers too now
  o remove junk from vlsi_ir
  o dm updates merged with 2.5.49 ones
  o place pnp early but after acpi
  o forward port 2.4 isa handling
  o 2.4 pci ops fix backport
  o kill soundmodem docs
  o update /proc/sys doc
  o fix mce setup for SMP with cpus=1
  o fix cs46xx build
  o update to OSDL DAC960 driver
  o cyrix cpu optimisations
  o fix crap in cs4281 pm save
  o update i810 audio
  o fix lxdialog behaviour
  o fix sound kconfig file locations
  o fix wanrouter build
  o quieten ATM noise
  o fix wrong check in BUG() test for UDMA on serverworks

Andrew Morton <akpm@digeo.com>:
  o IDE fix for -ac merge
  o blk_run_queues() locking fix
  o misc fixes
  o Allow for profile_buf size = kernel text size
  o kernel_stat cleanup
  o Updated Documentation/kernel-parameters.txt
  o shrink task_struct by removing per_cpu utime and stime
  o reduced context switch rate in writeback
  o Add some low-latency scheduling points
  o realtime swapspace accounting
  o swapoff accounting cleanup
  o Add a scheduling point to page reclaim
  o Don't hold BKL across sync_blockdev() in blkdev_put()
  o reduced latency in dentry and inode cache shrinking
  o oprofile build fix

Andries E. Brouwer <andries.brouwer@cwi.nl>:
  o Silence debugging message

Andy Grover <agrover@groveronline.com>:
  o ACPI: Interpreter update to 20021122 Fixed a problem with RefOf and
    named fields Fixed a protection fault involving Packages with
    Null/nested packages Fixed GPE initialization to handle a
    pathological case
  o ACPI: Fix IRQ assignment on Tiger (JI Lee)

Anton Blanchard <anton@samba.org>:
  o fix build with IDE disabled

Arnaldo Carvalho de Melo <acme@conectiva.com.br>:
  o acpi/processor.o: fix up seq_file conversion, add missing comma

Christoph Hellwig <hch@infradead.org>:
  o remove sys_security
  o remove unused include in scsi_ioctl.c
  o split busy check out of scsi_remove_host
  o make a few more routines private to scsi_lib.c
  o cleanup code for /proc add/remove single device
  o get rid of scan_scsis
  o remove useless includes from scsi.h
  o some HBA compile warning fixes
  o turn scsi_allocate_device into readable code

Dave Jones <davej@suse.de>:
  o CONFIG_DEBUG_SPINLOCK_SLEEP
  o Extra ID for aic7770
  o incorrect flags sizes
  o Coding style police
  o make cardbus PCI enable earlier
  o Remove unused 486 string copies
  o Overflow checks in i2c
  o Jiffies wrap fix for w9966 driver
  o sb_card addition/deletion
  o Plug memory leak in iph5526
  o hd64465 region handling cleanup
  o Indentation brain damage
  o missing kmalloc check in airo_cs
  o missing kmalloc check in qnx4fs
  o cmpxchg8b needs lock prefix
  o missing unlock_kernel()'s in reboot path
  o Mobility_pp parport support
  o memleak in myri_sbus
  o i810 audio - skip softmodems
  o MCE fixes
  o delete obsolete includes from sdla_fr
  o OSS Makefile fixes
  o speed clarification in sb_audio
  o MODULE_DESCRIPTION doesn't need a \n
  o nm256 dell latitude fix
  o Fix PPPoE oops
  o i810 audio new idents
  o cs4232 memleak
  o region handling cleanups for ali-ircc
  o MPU401 resource cleanups
  o sbc60xxwdt region fix
  o stradis overflow check
  o sf16fmi janitor work
  o wan sbni region cleanups
  o microoptimise do_exit()
  o Mem leak in sunbmac
  o rocket driver janitor bits
  o pcmcia tcic region cleanups
  o request_region fix in madgemc.c
  o scsi scan blacklist update
  o extern inline -> static inline
  o unwrapped var usage in unbz64wrap
  o Make various bits of synclink static
  o named struct initialiser updates
  o add missing clipping for zr36067
  o Check request_region() in inia100
  o region cleanups etc in ips driver
  o remove unused EISA_bus__is_a_macro macro
  o Remove unneeded verify_area from sg.c
  o region handling cleanups for appletalk ltpc
  o extra parport IDs
  o si1_isa board addition to sx driver
  o memleak in macsonic
  o region handling cleanup for de600
  o watchdog compile fixes
  o Credits update
  o CONFIG_FRAME_POINTER

David Brownell <david-b@pacbell.net>:
  o drivers/base/hotplug.c, fix $DEVPATH
  o remove CONFIG_USB_LONG_TIMEOUT
  o ohci uses less slab memory

David S. Miller <davem@nuts.ninka.net>:
  o [ELF] Enter KERNEL_DS after fill_psinfo, which does user acceses
  o [SPARC64]: Fix spinlock init in sparc64 parport support
  o [SPARC]: Update elf coredump macros for recent threading changes
  o [SPARC]: Ignore SIGURG if not caught
  o [SPARC]: Add DEBUG_SPINLOCK_SLEEP config option
  o [AIC7XXX]: aic7xxx_osm.h needs asm/io.h
  o [SPARC ESP]: Convert to slave_{attach,destroy}

David S. Miller <davem@redhat.com>:
  o sys_swapoff bug

Doug Ledford <dledford@aladin.rdu.redhat.com>:
  o aic7xxx_old: fix up the biosparam function to do 64bit math safely
  o aic7xxx_old: update biosparam function with the (ugly) detail that
    cylinder values > 65535 get truncated
  o scsi.c, scsi.h, scsi_syms.c, aic7xxx_old: add new function to track
    queue full events at the mid layer instead of at the low level
    device driver
  o st.c:   Clean up init failure paths Fix the detach code so it
    doesn't call sysfs unregister with a lock held
  o fs/proc/inode.c: Make proc use new module loader semantics so that
    touching a /proc/* file doesn't pin a module in memory
  o scsi: Update lldd API to slave_alloc/slave_configure/slave_destroy
    interface instead of slave_attach/slave_detach interface.  Change
    all users
  o Convert from host->host_queue to host->my_devices list usage Add in
    usage of new same_target_siblings list Add
    scsi_release_commandblocks() call to scsi_free_sdev() Make all scsi
    device freeing use scsi_free_sdev()

Ganesh Varadarajan <ganesh@vxindia.veritas.com>:
  o uninitialized spinlock in ipaq.c

Greg Kroah-Hartman <greg@kroah.com>:
  o LSM: add #include <linux/security.h> to a lot of files as they all
    have security calls in them
  o LSM:  Create CONFIG_SECURITY and disable it by default for now
  o LSM: change all usages of security_ops->ptrace() to
    security_ptrace()
  o LSM: change all security bprm related calls to the new format
  o LSM: change all of the VFS related security calls to the new format
  o LSM: convert over the remaining security calls to the new format
  o LSM: remove last remanants of sys_security missed by last patch
  o driver core: fix compiler warning if CONFIG_HOTPLUG is not defined
  o USB: added Palm Tungsten W support
  o LSM: fix up some needed header file #includes
  o LSM: Move the definition of capable() into sched.h if
    CONFIG_SECURITY is set to help make the #include nightmare more
    managable.
  o LSM: put CONFIG_SECURITY back into the Kconfig file (was lost in
    the merge)
  o USB serial: move the ezusb functions into their own file
  o USB serial: split the generic functions out into their own file

Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>:
  o ISDN: Simplify chip init
  o ISDN: Un-split inithscxisac
  o ISDN: Move transmitter reset into initisac()
  o ISDN: Remove compatibility ifdefs
  o ISDN: Introduce .owner
  o ISDN: Remove unused commands
  o ISDN: Move isdn_slot into isdn_driver
  o ISDN: Introduce get/put_slot()
  o ISDN: Update eicon driver for removal of pcibios_*
  o ISDN: Remove cli()/.. from hisax/hscx driver
  o ISDN/HiSax: Don't call back up in hard-IRQ context
  o ISDN/HiSax: Remove pcibios_* leftovers
  o ISDN/HiSax: Shared function for scheduling a B-channel event
  o ISDN/HiSax: Unified xmit_complete_b()
  o ISDN/HiSax: Separate out xmit_ready_b()
  o ISDN/HiSax: Shared xmit_data_req() for B-channel
  o ISDN/HiSax: Shared PH_PULL handling for B-Channel
  o ISDN/HiSax: Share XPR interrupt handling for B-Channel
  o ISDN/HiSax: Share code for retransmitting frame on B-channel
  o ISDN/HiSax: Share XDU handling for B-Channel
  o ISDN/HiSax: Share fill_fifo() for B-Channels
  o ISDN/HiSax: Shared xmit_fill_fifo() for D-Channel
  o ISDN/HiSax: Shared sched_event() for D-channel
  o ISDN/HiSax: Share xmit_ready_d()
  o ISDN/HiSax: Consolidate D-Channel XPR interrupt handling
  o ISDN/HiSax: Share D-Channel XDU interrupt handling
  o ISDN/HiSax: Move more code into the shared xmit_xpr_d()
  o ISDN/HiSax: Share D-channel PH_DATA request handling
  o ISDN/HiSax: Share D-Channel PH_PULL code
  o ISDN/HiSax: Remove broken home-made lock primitives

Linus Torvalds <torvalds@home.transmeta.com>:
  o Undo bogon from the -dj merge
  o Revert duplicate initialization from -ac merge Cset exclude:
    alan@lxorguk.ukuu.org.uk|ChangeSet|20021126021252|43411
  o Revert over-eager memory leak "fix" from the -dj merge
  o Revert bad PCI bridge resource handling from -dj tree Cset exclude:
    davej@codemonkey.org.uk|ChangeSet|20021126023731|33210
  o Fix up Alan's huge patch set. It couldn't have compiled for him
    either. Tssk, tssk.

Miles Bader <miles@lsi.nec.co.jp>:
  o Consolidate various v850 platform banner printks
  o Fix some minor type problems in v850 code
  o Add asm macros on v850 so the size of asm data objects can be
    recorded
  o Add v850 support for new module loader
  o Add v850 versions of dump_stack and show_stack
  o Add support for AS85EP1 platform to v850 arch
  o Add v850 nanosecond stat fields
  o Make NB85E_UART_CKSR_MAX_FREQ (in nb85e_uart driver) overridable
  o Update `nb85e_uart' driver for recent serial framework changes
  o Random minor fixes for v850 `anna' platform
  o Add v850 support for initramfs
  o Update v850 usage of do_fork to supply new args
  o Add TASK_UNMAPPED_BASE for v850
  o The v850 doesn't need sys_old_getrlimit
  o Update v850 to use kstat_cpu in irqs.c
  o Update includes in v850 files to reflect recent header changes
  o Add my name to CREDITS file
  o Random whitespace tweaks in v850 files
  o Tweak some v850 name strings
  o Change the default baud rate of the `nb85e_uart' driver to 115200
  o Update make variable used by initramfs `binary blob' creation on
    v850
  o Make the v850 leds driver's seek routine always return a value
  o Give a compile-time error on the v850 if MAX_ORDER is too large
  o Add id for v850 `nb85e_uart' to serial_core.h
  o Make v850 syscall6 macro support both old and new gcc versions
  o Change type of v850 function `gbus_int_disable_irqs' to void
  o Shrink v850 exception-trap handling code a bit
  o Add `unlikely' to error-return path in v850 __syscall_return macro

Nemosoft Unv. <nemosoft@smcc.demon.nl>:
  o [PATCH] PWC 8.9

Patrick Mansfield <patmans@us.ibm.com>:
  o current scsi-misc-2.5 include files
  o cleanup code for /proc add/remove single device

Paul Mackerras <paulus@samba.org>:
  o PPC32: update for recent changes to clone system call

Pete Zaitcev <zaitcev@redhat.com>:
  o [sparc]: Clobber %l3 in switch_to

Ralf Bächle <ralf@linux-mips.org>:
  o do_mounts.c ioctl fix

Randy Dunlap <randy.dunlap@verizon.net>:
  o USB: use time_before() to compare times
  o tiglusb timeouts

Russell King <rmk@flint.arm.linux.org.uk>:
  o [ARM] 2.5.49 Build fixes
  o [ARM PATCH] 1311/1: BadgePAD 4 PCMCIA Update
  o [ARM PATCH] 1329/1: Shark: new def-config
  o [ARM PATCH] 1330/1: Shark: Fixes for via PCI
  o [ARM PATCH] 1331/1: Shark: Compilation fixes
  o [ARM PATCH] 1332/1: DMA Scatter-Gather Primitives for SA-1111
    Bounce Buffer Layer

Stuart MacDonald <stuartm@connecttech.com>:
  o usb-serial.c disconnect race
  o WhiteHEAT update


