Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263572AbTDGRmi (for <rfc822;willy@w.ods.org>); Mon, 7 Apr 2003 13:42:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263573AbTDGRmi (for <rfc822;linux-kernel-outgoing>); Mon, 7 Apr 2003 13:42:38 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:47887 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id S263572AbTDGRmX (for <rfc822;linux-kernel@vger.kernel.org>); Mon, 7 Apr 2003 13:42:23 -0400
Date: Mon, 7 Apr 2003 10:53:43 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Linux 2.5.67
Message-ID: <Pine.LNX.4.44.0304071051190.1385-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


All over the place as usual - there's definitely a lot of small things 
going on. PCMCIA and i2c updates may be the most noticeable ones.

		Linus

---

Summary of changes from v2.5.66 to v2.5.67
============================================

<marijnk:gmx.co.uk>:
  o fix for drivers/video/logo/Makefile

Adam Belay:
  o PnP Card Service Cleanups
  o PnPBIOS Update
  o ALS100 Memory Leak Fix
  o [PATCH 2.5] PnP changes to allow MODULE_DEVICE_TABLE()
  o ALSA SB16 PnP Update
  o Silently Ignore if the device is already active/disabled
  o Increment Version Number
  o AZT2320 PnP Updates
  o ALSA DT019X PnP Updates
  o [PATCH 2.5] ALS100: kmalloc params fix
  o [PATCH 2.5] ES968: kmalloc params fix

Adrian Bunk:
  o fix .text.exit error in drivers/net/r8169.c
  o [ATM]: Fix IPHASE driver build

Alan Cox:
  o Avoid unknown IDE commands
  o Add a comment that the irq_nosync stuff needs revisiting
  o Ensure hdparm errors to the user when the request isnt allowed
  o Remove obsolete IDE timing hack
  o fix radio_cadet driver locking
  o Fix up 3w-xxxx driver
  o Merge the serial config entries for PC9800
  o Make cramfs compile again
  o fs/exec.c does not need __NO_VERSION__
  o Quota should not reference user addresses directly
  o PC9800 uses different IDE i/o bases for legacy mode devices
  o Wrong kind of NUL fix for asm headers
  o S/390 typo fixes

Alexey Kuznetsov:
  o [IPV4]: Make sure rtcache flush happens after sysctl updates

Andi Kleen:
  o aio compat patches
  o ACPI NUMA option fix for x86-64
  o x86-64 updates
  o x86-64 merge

Andrew Morton:
  o ppc64: support for Ingo's "fileoffset in pte" patch
  o ppc64: add PTE_FILE_MAX_BITS
  o initcall debug code
  o POSIX timers interface long/int cleanup
  o slab: fix off-by-one in size calculation
  o add flush_cache_page() to install_page()
  o posix timers: fix double-reporting of timer expiration
  o remove SWAP_ERROR
  o permit page unmapping if !CONFIG_SWAP
  o make add_to_swap_cache() static
  o tmpfs truncation fix
  o handle oom in tmpfs
  o remove vm_enough_memory double counting
  o ext3: fix max file size
  o wait_on_buffer refcounting checks
  o x86 clock override boot option
  o fix to support discontigmem for 16way x440
  o tty_io cleanup
  o speed up ext3_sync_file()
  o add a might_sleep() check to kmap()
  o ext3: remove dead code and variables
  o use page_to_pfn() in __blk_queue_bounce()
  o init_inode_once() wants sizeof(struct hlist_head)
  o honour VM_DONTEXPAND in vma merging
  o Fix 64bit warnings in mm/page_alloc.c
  o make cdevname() callable from interrupts
  o register_chrdev_region() leak and race fix
  o slab: cache sizes cleanup
  o sync blockdevs on the final close only
  o Remove unused variable in nfs_readpage_result()
  o tmpfs blk_congestion_wait fix
  o handle bad inodes in put_inode
  o monotonic clock source for hangcheck timer
  o Fix some compile warnings
  o bio kmapping changes
  o file limit checking simplification
  o tmpfs 1/6 use generic_write_checks
  o tmpfs 2/6 remove shmem_readpage
  o tmpfs 3/6: use generic_file_llseek
  o tmpfs 4/6: use mark_page_accessed
  o tmpfs 5/6: use cond_resched
  o tmpfs 6/6: percentile sizing of tmpfs
  o struct stat - support larger dev_t
  o misc fixes
  o aic7xxx timer deletion fix
  o Additional 3c980 device support
  o sync dirty pages in fadvise(FADV_DONTNEED)
  o add vt console scrollback ioctl
  o Fix devfs' partition handling
  o umsdos fixes
  o exp_parent locking fixes
  o real_lookup race fix
  o remove dparent_lock
  o Add less-severe assert-failure form for ext3
  o Fix jbd assert failure on IO error
  o ext3_mark_inode_dirty() speedup
  o ext3_commit_write speedup
  o ext3: create a slab cache for transaction handles
  o ext3 journal commit I/O error fix
  o acpi compile fix

Andrey Panin:
  o visws framebuffer driver needs mm.h
  o missing FB_VISUAL_PSEUDOCOLOR in fb_prepare_logo()
  o allow penguin with SGI logo for visws
  o cleanup mach-visws/mpparse.c

Andries E. Brouwer:
  o readlink in /proc w/ overlong path
  o kill TIOCTTYGSTRUCT

Andy Grover:
  o ACPI: Re-enable build w/o CONFIG_PCI (Pavel Machek)
  o ACPI: Fix GPE 1 handling (Takayoshi Kochi)
  o ACPI: Fix off by 1 error in C2/3 detection (Ducrot Bruno)
  o ACPI: Interpreter update to 20030321
  o ACPI: Disable NUMA support on x86-64 (Andi Kleen)
  o ACPI: Fix compile issue (reported by Brendan Burns and Christian
    Neumair)
  o ACPI: Interpreter update to 20030328

Anton Blanchard:
  o ppc64: Rework pci probe to be like alpha
  o ppc64: fix pci probe on large bus systems
  o ppc64: Disable 32bit SLB invalidation optimisation for the moment
  o ppc64: Fix problem with casting out the segment for our kernel
    stack

Arnaldo Carvalho de Melo:
  o af_ipx: code reformatting
  o linux/net.h: CodingStyle changes and kerneldoc style structs
    documentation
  o linux/net.h: bye bye struct net_proto
  o net: CodyngStyle reformatting, no code changes

Ben Collins:
  o [SPARC64]: Allow cpufreq drivers to be built statically
  o [SPARC64]: Fix boot target deps

Benjamin Herrenschmidt:
  o PPC32: Factor out common code for reading/setting various SPRs
  o PPC32: Add support for CPU frequency scaling on some PowerMacs
  o PPC32: Add function for choosing which PLL to use on 750FX cpus
  o PPC32: Forward-port support for new powermacs from 2.4 tree
  o PPC32: Unmap the VIA (versatile interface adaptor) chip after we
    are done with it
  o PPC32: Get Open Firmware to initialize all the displays, not just
    one

Brad Hards:
  o USB: CDC Ethernet zero packet fix
  o USB: CDC Ethernet maintainer transfer

Brian J. Murrell:
  o [NETFILTER]: Add amanda conntrack + NAT support

Burton N. Windle:
  o [tulip] remove unnecessary linux/version.h includes

Chas Williams:
  o [ATM]: Fix total_len calculation in IPHASE driver
  o [ATM]: Fix IPHASE build with debugging enabled

Chris Wright:
  o USB: potential dereference of user pointer errors in kobil_sct.c

Christoph Hellwig:
  o [NET]: Kill dev_init_buffers, was scheduled to die in 2.5.x
  o fix rescan warning
  o aha152x tidbits
  o [XFS] Separate the quota source into its own subdirectory ala dmapi
  o [XFS] remove fs/xfs/xfs_dqblk.h
  o update qlogic and fdomain drivers to use pcmcia_register_driver
  o some more entries for the largelun list
  o aha152x pcmcia updates
  o [IPV6]: Fix warning with modular ipv6
  o remove kdevname() before someone starts using it again
  o [PCMCIA] drivers/pcmcia/Makefile tidyups
  o [SERIAL] switch over 8250_cs to pcmcia_register_driver

Corey Minyard:
  o fix ipmi_devintf.c compilation
  o IPMI driver version 19 release

Daniel Ritz:
  o [IPV4]: Fix /proc/net/route missing the default route

Dave Blaschke:
  o Code cleanup suggested by static analysis tool

Dave Jones:
  o [tulip dmfe] add pci id
  o finish init_etherdev conversion for gt96100eth
  o Add new cache descriptors, as found on P4-M (Centrino)
  o fix up newer x86 cpuinfo flags
  o [CPUFREQ] missing include in acpi driver
  o [CPUFREQ] Fix memleak in longhaul.c found by smatch
  o [CPUFREQ] propagate longhaul_get_ranges() failure up if something
    went wrong
  o undefined reference to ip_amanda_lock

Dave Kleikamp:
  o JFS: Avoid deadlock when all tblocks are allocated

David Brownell:
  o usb_connect() kerneldoc
  o usb hub diagnostics
  o usbtest catch -ENOMEM
  o add missing usb_put_urb() after error
  o USB: usb-skeleton, usbtest use "real" device ids

David S. Miller:
  o [TCP]: Forward port of 2.4.x bugfix, noticed as missing by
    davej@codemonkey.org.uk
  o [DRM]: Fix warnings and build errors introduced by previous changes
    to drm_drv.h
  o [IPSEC]: Kill skb_ah_walk, not needed
  o [NET]: Make SKB layout/initialization/copy more cache friendly
  o [SPARC64]: Uninline rwsem assembler
  o [SPARC64]: cpufreq cleanup, move notifier into common area
  o [SPARC64]: Initial cut at Ultra-IIe cpufreq driver
  o [SPARC64]: Make boot targets get cleaned up properly
  o [IPSEC]: Remove unused field 'owner' from selector
  o [IPSEC]: linux/xfrm.h u32 --> __u32
  o [USB]: In ohci-pci.c, use size_t printf format
  o [SPARC64]: Fix pcibios_resource_to_bus and the build for this
    platform
  o [SPARC64]: Implement dump stack and handle dumping currents stack
    properly
  o [SPARC64]: Use GFP_ATOMIC in request_irq
  o [SPARC64]: Fix interrupt enabling on trap return
  o [SPARC64]: Update defconfig
  o [SPARC64]: Implement pcibios_bus_to_resource
  o [NET]: Nuke CONFIG_FILTER
  o [SPARC64]: Get ALI trident sound working again
  o [NET]: Use might_sleep in alloc_skb
  o Check for disabled local interrupts in "might_sleep()"
  o [SPARC64]: Use tick_ops for get_cycles, export it
  o [SOFTIRQ]: Move softirq implementation to common area, add debug
    check
  o [SOFTIRQ]: interrupt.h needs preempt.h
  o [SOFTIRQ]: Define local_softirq_pending, use it in softirq.c
  o [CRYPTO]: deflate.c needs slab.h
  o [IPSEC]: In TCP/v6 input, check policy before socket filter
  o [IPSEC]: xfrm_{state,user}.c need asm/uaccess.h
  o [IPSEC]: Revert xfrm_state use_time patch, it was wrong
  o [IPSEC]: Store xfrm_encap_tmpl directly in xfrm_state
  o [IPSEC]: Add encap support for xfrm_user
  o [SHAPER]: Fix time_before_eq args
  o [IPSEC]: Clean up decap state, minimize its size
  o [SPARC64]: Dont transition in us2e drivers if divisor does not
    change
  o [SPARC64]: Update defconfig
  o [SPARC64]: Support OLO10 relocations for modules
  o [SPARC64]: Missing break; statement in module reloc code
  o [SPARC64]: Fix trap stack allocations so gcc-3.x builds work
  o [MODULE]: On sparc, ignore undefined symbols of type STT_REGISTER

Dean Roehrich:
  o [XFS] fix initialization of dmapi code

Derek Atkins:
  o [IPSEC]: Implement UDP Encapsulation framework

Dominik Brodowski:
  o [PCMCIA] "driver services" socket add/remove abstraction
  o [PCMCIA] remove "init_status" from struct pcmcia_driver
  o convert ds.c's socekt_info_t to struct pcmcia_bus_socket
  o [PCMCIA] remove unused include/pcmcia/driver_ops.h
  o [PCMCIA] fix pcmcia_bind_driver
  o [PCMCIA] fix compilation with PCMCIA_DEBUG on
  o [PCMCIA] generic suspend/resume capability
  o [PCMCIA] don't inform "driver services" of cardbus-related events
  o [PCMCIA] Fix "Removing wireless card triggers might_sleep
    warnings."

Douglas Gilbert:
  o minor scsi_lib.c cleanup for 2.5.64
  o scsi_ioctl.c for SEND_DIAGNOSTIC
  o block scsi_ioctl.c lk 2.5.66
  o scsi_debug version 1.69 for lk 2.5.66

Duncan Sands:
  o USB speedtouch: code reorganization
  o USB speedtouch: trivial cleanups
  o USB speedtouch: per vcc data cleanups
  o USB speedtouch: eliminate ATM open/close races

Eric Sandeen:
  o [XFS] Use mod_timer in place of del/modify/add (can race) Also use
    del_timer_sync when we're done.

Geoffrey Lee:
  o [TRIVIAL]: Add missing module license for ipfwadm_core.c

Greg Kroah-Hartman:
  o i2c: remove i2c_adapter->name and use dev->name instead
  o i2c: remove *data from i2c_adapter, as dev->data should be used
    instead
  o i2c: add struct device to i2c_client structure
  o i2c: remove the data field from struct i2c_client
  o i2c: Removed the name variable from i2c_client as the dev one
    should be used instead
  o i2c: actually register the i2c client device with the driver core
  o i2c: fix up the chip driver names to play nice with sysfs
  o i2c: ugh, clean up lindent mess in i2c-proc.c::i2c_detect()
  o i2c: fix up drivers/media/video/* due to previous i2c changes
  o i2c: fix up drivers/acorn/char/i2c.c due to previous i2c changes
  o i2c: fix up drivers/ieee1394/pcilynx.c due to previous i2c changes
  o i2c: fix up drivers/video/matrox/i2c-matroxfb.c due to previous i2c
    changes
  o i2c: fix typo that newer versions of gcc catch
  o i2c: set up a "generic" i2c driver to prevent oopses when devices
    are registering
  o USB: fix Makefile to allow usb midi driver to be built if it's the
    only class driver selected
  o USB: fix compiler warning in usb-storage
  o USB: remove unneeded #include <linux/version.h>
  o i2c: fix memleak caused by my last patch fo the adv7175.c driver
  o i2c: change the way i2c creates the bus ids to actually be unique
    now
  o i2c: convert lm75 chip driver to use sysfs files
  o i2c: convert adm1021 chip driver to use sysfs files
  o i2c: remove sysctl and proc functions from via686a.c driver
  o i2c: remove proc and sysctl code from i2c-proc as it is no longer
    used
  o i2c: remove unused paramater in found_proc callback function
  o i2c: move i2c-proc to i2c-sensor and clean up all usages of it
  o i2c: remove all proc code from the i2c core, as it's no longer
    needed
  o i2c: clean up previous w83781d patch due to changes I made to i2c
    core and build
  o i2c: fix up broken drivers/i2c/busses build due to I2C_PROC now
    being gone
  o i2c: remove old proc documentation and add sysfs file documentation

Hanna Linder:
  o [SPARC]: sbus_char_aurora tty_driver add .owner field remove
    MOD_INC_DEC_USE_COUNT

Harald Welte:
  o [NETFILTER]: iptables iptable_mangle LOCAL_IN bugfix
  o [NETFILTER]: ipt_REJECT bugfix for TCP RST packets + asymm. routing

Hideaki Yoshifuji:
  o [IPSEC]: Make get_acqseq() xfrm_state.c:xfrm_get_acqseq()
  o [IPSEC]: Move xfrm_*.c into net/xfrm/
  o [IPSEC]: Remove duplicate / obsolete entry in include/linux/dst.h
  o [IPV6]: Don't allow multiple instances of the same IPv6 address on
    an interface
  o [IPSEC]: Use of "sizeof" for header sizes, part II

Ingo Molnar:
  o revert scheduler back-boosting

Ivan Kokshaysky:
  o alpha: err_titan.c compile fix
  o alpha: file offset in pte
  o alpha: handle unaligned REFQUADs produced by BUG() macro
  o alpha: pci update
  o alpha: nautilus_init_pci() cleanup
  o alpha: fix jiffies compile warning in smp.c
  o USB: missing include
  o [NET]: Fix pointer arith in ICMP stats

James Bottomley:
  o fix scsi/qlogicfc.c stack problems

James Morris:
  o [NET]: Warn only once about SO_BSDCOMPAT
  o [CRYPTO]: Add Deflate algorithm to crypto API
  o [IPSEC]: Fix xfrm_state refcounts
  o [CRYPTO]: deflate module: workaround zlib bug

Jan Dittmer:
  o i2c: fix compile bugs in tvmixer.c
  o i2c: add i2c-via686a driver

Jan Kara:
  o Quota module licences

Jay Vosburgh:
  o [bonding] bug fixes, and a few minor feature additions

Jean Tourrilhes:
  o Discovery locking fixes
  o IrLAP dynamic window code fix
  o irda-usb Rx path cleanup + no clear_halt
  o irtty-sir ZeroCopy Rx
  o IrDA timer fix
  o IrNET module fix

Jean-Francois Dive:
  o [IPSEC]: Missing xfrm_state use_time updates

Jeff Garzik:
  o [hw_random] add AMD pci id

Jens Axboe:
  o scsi queueing weirdness
  o kill blk_queue_empty()

Joe Perches:
  o USB: usb_skeleton.c trivial fix

John Levon:
  o module load notification
  o Convert APIC to driver model
  o bk - fix oprofile for pm driver register
  o oprofile doesn't compile with CONFIG_MODULES=n

Jon Grimm:
  o [SCTP]  Bundle SACK with outgoing DATA
  o [SCTP] Add icmpv6 handler to SCTP
  o [SCTP] Add SEND_FAILED support.  (Ardelle Fan)
  o [IPV6]: Export some icmpv6 symbols for SCTP
  o [SCTP] Add LINKLOCAL/sin6_scope_id support
  o [SCTP] Fix SACK bundling bug
  o [SCTP] Fix warning and unused (sfr@canb.auug.org.au)

Kai Germaschewski:
  o USB: Add missing #include <asm/uaccess.h>
  o modules: Fix exporting symbols from modules
  o kbuild: Fix dependencies for generated .mod.o files

Krzysztof Halasa:
  o generic HDLC update

Linus Torvalds:
  o Update direct-rendering to current DRI CVS tree
  o Did you know that C integer constant promotions are different
    depending on whether the constant is a hexadecimal one as
  o Fix SMP/preemption race condition in vm86 entry mode
  o Fix another non-preempt-safe CPU# access in vm86.c
  o Add missing <asm/uaccess.h> header includes
  o Fix naming confusion: number of symbol kallsyms is "num_kallsyms",
    while number of symbols is "num_syms". It used to be "num_syms" and
    "num_ksyms" respectively (ie the "k" was the wrong way around).
  o The irq vector offset should spread the irq's out evenly, which
    implies that it should vary between 0-7, not any further (the
    higher bits are done by updating current_vector by 8).

Magnus Boden:
  o [NETFILTER]: Add tftp conntrack + NAT support

Martin J. Bligh:
  o remove warning for 3c509.c

Martin Schlemmer:
  o i2c: w83781d i2c driver updated for 2.5.66-bk4 (with sysfs support,
    empty tree)

Matthew Dharm:
  o usb-storage: LUN and isd200
  o usb-storage: initialize urb status
  o usb-storage: cleanup

Matthew Wilcox:
  o C3000 support in sym53c8xx

Nathan Scott:
  o [XFS] Next step in bhv code cleanup - this is a start on moving
    quota and dmapi into behavior layers, purging several points where
    these sit slap bang in the middle of XFS code (esp. read_super). 
    Also removes numerous #ifdef's and a bunch of unused #define's from
    all over the place.  More to come.
  o [XFS] In showargs, report the usrquota/grpquota option variant,
    which is common
  o [XFS] whitespace and code formatting changes
  o [XFS] Cleanup/remove a bunch of macros, comments and code
  o [XFS] Header shuffling to try and keep several source trees aligned
    - move the realtime inode detection macro somewhere more
    appropriate.
  o [XFS] Cut and paste stuff up on my part in the DMAPI headers
  o [XFS] Cut and paste stuff up on my part in the DMAPI headers
  o [XFS] Add back the pagebuf flag for scheduling on the data daemon. 
    Moving this into just a pagebuf_iodone parameter was broken as we
    don't have sufficient state in all the places we need it to make
    the decision.

Neil Brown:
  o kNFSd: READ_BUF macro update
  o kNFSd: fix WRITE decoding
  o kNFSd:fix read encoding
  o kNFSd: Be more careful with readlock in exp_parent
  o md: md/linear oops fix
  o md: Cleanup #define TEXT text ... printk(TEXT)
  o md: Convert md personalities to new module interface
  o kNFSd: Verify exportability when updating export cache
  o md: Fix stupid oops in recent md.c module changes
  o md: Cleanups for md to move device size calculations into
    personalities
  o md: Add some new lines to diagnostic printks

Oliver Neukum:
  o USB: Another memory allocation in block IO error handling path
  o USB: storage device reset cleanup
  o USB: storage: add logging to reset

Oliver Spang:
  o USB: Compiler error in cdc-acm when DEBUG defined

Osamu Tomita:
  o Complete support for PC-9800 sub-arch (9/9) SCSI

Patrick Mochel:
  o driver model: don't define DEBUG in base.h
  o driver model: Make sure we initialize drivers' class_list
  o driver model:  Fix error handling in sysfs registration
  o driver model: increase BUS_ID_SIZE to 20
  o driver model: fix warning in cpu init
  o sysfs: Fix file removal

Paul Mackerras:
  o ppc64: make sys_clone handle the CLONE_SETTLS flag
  o PPC32: Add the definitions needed for nonlinear file mappings
    (pte_file etc.)
  o ppc64: Add missing RELOCs
  o PPC32: Fix compilation of powermac cpufreq stuff
  o MACE ethernet driver update
  o update adb driver
  o update apm emulation for mac
  o add some more Apple PCI ids

Paul Mielke:
  o [NETFILTER]: ip_conntrack bugfix for LOCAL_NAT and PPTP

Pete Zaitcev:
  o [SPARC]: Handle make w/o arg sanely, by Sam Ravnborg
  o [SPARC64]: Kill ELF_FLAGS_INIT

Petr Vandrovec:
  o Fix kobject_get oopses triggered by i2c in 2.5.65-bk

Randolph Chung:
  o [COMPAT]: Fix sock_fprog handling
  o [COMPAT]: Fix MSG_CMSG_COMPAT flag passing, kill
    cmsg_compat_recvmsg_fixup

Randy Dunlap:
  o USB: usb/misc/emi26.c stack reduction
  o [NET]: typo and comment fixes
  o reduce stack usage in cdrom/optcd.c
  o [IPV6]: Convert /proc/net/{sockstat6,snmp6} to seq_file
  o [IPV6]: Make /proc/net/snmp6 use %lu instead of %ld

Rob Radez:
  o [SPARC]: sys_remap_file_pages returns long

Roland McGrath:
  o linux-2.5.66-signal-cleanup.patch

Roman Zippel:
  o gconf update
  o update diffserv URL

Russell King:
  o [PCMCIA] pcmcia-2: Remove get_io_map and get_mem_map socket methods
  o [PCMCIA] pcmcia-3: Remove bus_ops abstractions
  o [PCMCIA] pcmcia-4: introduce SOCKET_CARDBUS_CONFIG
  o [PCMCIA] pcmcia-5: Add locking to resource manager
  o [PCMCIA] pcmcia-6: s/CONFIG_ISA/CONFIG_PCMCIA_PROBE/
  o [PCMCIA] pcmcia-7: Remove cb_enable() and cb_disable()
  o [PCMCIA] pcmcia-8/9: Clean up CIS setup
  o [PCMCIA] pcmcia-10: Make cardbus use the new PCI functionality
  o [ARM] Add pte_file() and friends to pgtable.h
  o [ARM] Fix ARM do_div() implementation
  o [ARM] Remove EXPORT_NO_SYMBOLS
  o [ARM] Update mach-types
  o [ARM] Pass prev task_struct through __switch_to
  o [ARM] console init functions return type int
  o [ARM] Update Cyber2000fb driver for new fbcon API
  o [ARM] Support write combining on framebuffers
  o [ARM] Fix potential oops in epxa10db-flash.c
  o [ARM] Quieten dc21285 host bridge driver during bus probing
  o [ARM] Kill compiler warning about uninitialised ppcr in
    cpu-sa1110.c
  o [ARM] Ensure transmit lines are held in mark state
  o [PCMCIA] Reorganise SA11xx PCMCIA support

Rusty Russell:
  o remove outdated fs/ChangeLog
  o include/asm-i386/dma.h: wrong lowest DMA channel
  o fix linewrap in Documentation/filesystems/befs.txt
  o [PATCH 2.5.63] pty tty_driver add .owner field remove
    MOD_INC_DEC_USE_COUNT
  o rio_linux.c misc_register patch
  o fix wrong module documentation
  o Fix use of const with __initdata in znet.c
  o Kill unnecessary bootup messages
  o Fix use of const with __initdata in vfb.c
  o fix linewrap in Documentation_swsusp.txt
  o remove KERNEL_VER from ftape.h
  o fix linewrap in Documentation/filesystems/sysv-fs.txt
  o fix linewrap in Documentation/pci.txt
  o fix linewrap in Documentation/ia64/efirtc.txt
  o fix linewrap in Documentation/filesystems/cifs.txt
  o tty_driver add .owner field remove MOD_INC_DEC_USE_COUNT
  o fix linewrap in Documentation/power/pci.txt
  o Explanation of sleep levels for swsusp
  o Change "char *version" to "char version[]"
  o [PATCH 2.5.59] Change __initdata to __initdata_or_module
  o remove unreachable code (and comments) in fs/befs/linuxvfs.c
  o vt tty_driver add .owner field
  o eisa_eeprom.c misc_register patch
  o tty_io tty_driver add .owner field
  o Trivial documentation fix
  o drivers_media_video_saa7111.c cleanup
  o net_pcnet32.c remove check_region
  o fix the static compilation of mxser.c
  o 2.5.60 i386_mm_init.c comment cleanup
  o Remove compile warning from fs/ncpfs/inode.c
  o Fix use of const with __initdata
  o module_text_address returns the module pointer
  o Symbol list removal
  o Extable list removal
  o Subdivide PCI class for aliases
  o Fix floppy.h
  o [SPARC]: Implement STT_REGISTER sparc support more cleanly

Sam Ravnborg:
  o ppc64: makefile updates

Sridhar Samudrala:
  o [SCTP] listen() backlog support for TCP-style sockets

Stelian Pop:
  o fix ec_read using wrong #define's in sonypi driver

Stephen Hemminger:
  o [NET]: Add synchronize_net
  o [NET]: More synchronize_net call sites
  o [IPV6]: ipv6 can use synchronize_net
  o [IPV6]: C99 initializers for IPV6 sockglue (and spelling fix)
  o [NETFILTER]: Get rid of unused include in ip_nat_core.c
  o [IPV4]: C99 initializers for ip_output.c

Stephen Lord:
  o [XFS] optimize timestamp updates, use new hires timestamps more
    directly, also fix a bug where the mtime field was not correctly
    updated.

Stephen Rothwell:
  o compat_sys_fcntl{,64} 9/9 Aalpha part
  o [SCTP]: Fix IRQ flags warnings
  o stop even more macros for comverting compat pointers
  o more compat types

Tom Lendacky:
  o [IPSEC]: Fix IPV6 UDP policy checking
  o [IPSEC]: Missing ipv6 policy checks
  o [IPSEC]: IPV6 AH/ESP fixes
  o [IPSEC]: Use "sizeof" for header sizes

Tom Rini:
  o PPC32: Update the banner printed for the Spruce board

Trond Myklebust:
  o Fix xprt.c so that it resends RPC requests immediately after a
    timeout
  o Micro-optimization: rename rpc_lookup_path() as rpc_lookup_parent()
    and drop the 'flags' argument (it was always set too
    LOOKUP_PARENT).
  o Fix the RPC debugging code so that it doesn't Oops if a task has a
    null 'p_proc' procedure pointer.
  o Fix misleading EIO on NFS client
  o Fix a typo in auth_gss.c. Clean out an unused variable
  o Fix a memory corruption bug in NFSv4 client
  o Fix clnt.c to skip re-encoding an RPC call in the case when we're
    writing over TCP and have done a partial send.

Ulrich Drepper:
  o Signal invalid ipc operation with ENOSYS

Zwane Mwaikambo:
  o smp_call_function needs mb()
  o Grab SET_MODULE_OWNER from the clutches of the deprecated
  o rng_vendor_ops init.data is referenced after being freed
  o Disable irqbalance for single cpu SMP configurations


