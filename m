Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263517AbTDTDAP (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Apr 2003 23:00:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263518AbTDTDAP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Apr 2003 23:00:15 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:62476 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id S263517AbTDTC76 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Apr 2003 22:59:58 -0400
Date: Sat, 19 Apr 2003 20:11:40 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Linux 2.5.68
Message-ID: <Pine.LNX.4.44.0304192002580.9909-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
X-MIME-Autoconverted: from 8bit to quoted-printable by deepthought.transmeta.com id h3K3Bea21209
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Tons of changes all over the map. The diff is large, partly because the 
s390x support got merged into the s390 port as a 64-bit subset, and the 
old s390x architecture files thus became irrelevant. And a merge with Alan 
gave us a another architecture instead - h8300.

Lots of dvb updates (digital video), again through Alan. And a major 
aic79xx driver update.

Oh, and the devfs stuff by Christoph means that devfs users should beware:  
in particular, devfs users need to mount the pts filesystem like everybody 
else does, that duplication got killed.

Other than that, just a ton of updates. See changelog for details.

		Linus

---

Summary of changes from v2.5.67 to v2.5.68
============================================

<alborchers:steinerpoint.com>:
  o USB: patch for oops in io_edgeport.c

<arashi:yomerashi.yi.org>:
  o [ALPHA] Include module.h for EXPORT_SYMBOL

<ch:com.rmk.(none)>:
  o [ARM PATCH] 1489/1: SA-1111: usb_dev needs non-zero dev.dma_mask
    for usb core to work properly
  o [ARM PATCH] 1490/1: [BADGE4] Enable second serial port when needed
  o [ARM PATCH] 1492/1: [BADGE4] Make PCMCIA work in 2.5.65-rmk1 fro
    BadgePAD 4
  o [ARM PATCH] 1493/1: [BADGE4] Allow larger flash parts and partition
    for kernel in jffs2
  o [ARM PATCH] 1494/1: [mtd] Make code compile without
    CONFIG_MTD_CONCAT

<cmayor:ca.rmk.(none)>:
  o [ARM PATCH] 1453/1: fix clps711x framebuffer "use SRAM?" range

<dirk.behme:com.rmk.(none)>:
  o [ARM PATCH] 1497/1: Cleanup of head.S

<ehabkost:conectiva.com.br>:
  o [SPARC]: Export phys_base on sparc32

<eli.carter:com.rmk.(none)>:
  o [ARM PATCH] 1473/1: Add Russell's porting information to
    Documentation
  o [ARM PATCH] 1472/1: Rename *-iop310 directories to *-iop3xx
  o [ARM PATCH] 1472/1: Rename *-iop310 directories to *-iop3xx
  o [ARM PATCH] 1474/1: fix iq80310 default config
  o [ARM PATCH] 1501/1: fix a path name in comment
  o [ARM PATCH] 1502/1: rename IOP310 config vars to IOP3XX
  o [ARM PATCH] 1503/1: Adds basic support for the iq80321 board
  o [ARM PATCH] 1506/1: Add iq80321 MTD mapping

<eric.piel:bull.net>:
  o ia64: POSIX timer fixes
  o ia64: fix settimeofday() not synchronised with gettimeofday()

<gandalf:netfilter.org>:
  o [NETFILTER]: Fix modify-after-free bug in ip_conntrack

<jcdutton:users.sourceforge.net>:
  o USB: Add support for Pentax Still Camera to linux kernel

<jef:linuxbe.org>:
  o [IPSEC]: Check xfrm state expiration on input after replay check

<legoll:free.fr>:
  o USB: New USB serial device ID: Asus A600 PDA cradle

<marius:citi.umich.edu>:
  o Add support for mapping NFSv4 remote user/group names into local
    unix-style uid/gids.
  o Add hooks into the NFSv4 XDR code to make use of the new uid/gid
    mapper upcall mechanism.

<mort:wildopensource.com>:
  o ia64: print ISR for FPSWA faults
  o ia64: replace cpu_is_online with cpu_online
  o ia64: Fix up "extern inline"

<mrr:nexthop.com>:
  o [IPV6]: Allow protocol to percolate up into rt6 routing operations

<nico:org.rmk.(none)>:
  o [ARM PATCH] 1363/1: memcpy with preload support and other
    optimisations
  o [ARM PATCH] 1441/2: add preload to the XScale copy_user_page
    function
  o [ARM PATCH] 1442/1: add preload support to page_copy for ARM
    architectures that support it
  o [ARM PATCH] 1447/1: preload support to uaccess.S

<niv:us.ibm.com>:
  o [TCP]: Missing SNMP stats

<romain.lievin:wanadoo.fr>:
  o gconfig: bug #540

<schlicht:uni-mannheim.de>:
  o i2c: fix compilation error for various i2c-devices

<spyro:com.rmk.(none)>:
  o [ARM PATCH] 1445/1: [PATCH] removes CONFIG_CPU_{26,32} from
    arch/arm/kernel
  o [ARM PATCH] 1456/1: removes CONFIG_CPU_{26,32} from arch/arm/lib
  o [ARM PATCH] 1460/1: removes CONFIG_CPU_{26,32} from arch/arm/boot
    (Makefile)
  o [ARM PATCH] 1458/1: finish nwfpe CONFIG_CPUnn removal

<sv:sw.com.sg>:
  o ia64: improve show_trace_task() portability

<tausq:debian.org>:
  o getrlimit,setrlimit,getrusage,wait4 unification

<wesolows:foobazco.org>:
  o [sparc]: Attempt mul/div emulation handling on all cpus

<wolfgang:top.mynetix.de>:
  o ia64: Cross-compile fix

<xavier.bru:bull.net>:
  o ia64: fix missing symbol exports

Alan Cox:
  o [SPARC64]: syscalls returning long
  o alpha typos part 1
  o alpha typos part 2
  o fix the mode for bios call in x86-32 as well as -64
  o Config.in typos
  o read extended cpu revision data
  o fix i387 fxsr conversion
  o parisc - syscalls return long purity
  o ppc64 syscalls return long purity
  o v850 updates
  o compatmac not needed
  o compatmac not needed uaccess.h is
  o PC9800 floppy driver
  o config for PC98xx floppy
  o MOD_* can go for floppy
  o makefile for pc9800
  o unversion.h and compatmac applicom.c
  o update char Kconfig for PC9800
  o exterminate compatmac in sx
  o error handling for upd4990a
  o clean up pci interrupt line whacking
  o fix our handling of BIOS forced PIO serverworks OSB4
  o fix up capslock on pc9800
  o add drivers/media/common for mixed dvb/analog device stuff
  o update the dvb core
  o update the dvb front end chips
  o kill off a load of stuff now in common dvb
  o fix radio-cadet build
  o bring core media/video up to date with dvb changes
  o remaining dvb bits
  o fix error in cops port to 2.5
  o port ltpc to 2.5
  o fix arcnet locking for 2.5
  o first cut at scc.c for 2.5 locking
  o fix up yam for 2.5 locking
  o Update lp486e for 2.5
  o fix macmace get_free_pages parameters
  o first cut at 3c574_cs for SMP safety etc
  o update slip to new tty module locks
  o fix cosa verify_area
  o first pass at fixing strip for 2.5
  o junk header removal
  o compatmac is not needed
  o compatmac is not needed
  o asm-alpha typo fixe
  o add but do not yet use mach specific definitions for ports etc on PC
  o add the same mach specific headers for pc9800
  o and visws
  o and voyager
  o header for pc9800 type detection
  o x86-64 typo fixes
  o goodbye compatmac.h
  o update dvb headers
  o possible way to clean up fdreg.h
  o hdreg.h typo fix
  o continued compatmac exterminations
  o lock for scc drivers
  o shared multimedia includes for saa71xx
  o remove version crap
  o wireless uses __init
  o irda typo fixes
  o remove version.h's
  o small pc98xx fix for sound
  o more audiov ersion scrubbing
  o cs4232 should be devexit
  o C99 for sound
  o lots more version and C99 for audio
  o fix modular gus shared lock
  o another C99 and version casd
  o ics2101 needs to match the gus_lock name too
  o fix ; in mad16
  o ite C99 and version/h
  o yet more sound version/c99
  o sync opl3sa2 with 2.4
  o last batch of audio C99
  o suspend doesnt need compatmac either
  o use mach io_ports definitions in io_apic
  o make vm86 machine independant using new headers
  o make APM machine independant using mach headers
  o H8300 support
  o another broken APM bios
  o new summit ID
  o update visws to use generic mask names
  o use the mach resources we added before
  o generalise mptable access
  o use names for PIT access. Not all PIT is the same location
  o Update proc.c for renamed fpu irq
  o generalise PIC locations, PIT and FPU IRQ
  o now we have the time logic in Mach_* use it
  o generalise more PIT usage
  o generalise PIT usage in tsc code, plus tsc sync
  o generalise traps and nmi
  o generalise pic mask names since the port varies
  o generalise fpu_irq also add pc98 for x86 code
  o more random C99 initializers
  o more random C99 initializers
  o fix a make kerneldoc glitch
  o Fix z2ram
  o small ipmi updates
  o compile fix for rio_linux.c
  o compile fix for sx.c
  o input typo fixes
  o first cut at 3c505 clean up
  o update intermezzo contacts

Alex Williamson:
  o ia64: CPE & CMC polling for 2.5
  o ia64: Use PAL_HALT_LIGHT in cpu_idle
  o ia64: generic build fix
  o ia64: remove platform_pci_dma_addres
  o ia64: update PCI segment support

Andreas Schwab:
  o ia64: fix unwinder bug in unw_access_gr()
  o ia64: Fix request_module from ia32 process

Andrew Morton:
  o Fix futexes in hugetlb pages
  o fix wait_on_buffer() debug code
  o Enforce gcc-2.95 as the minimum compiler requirement
  o null-terminate the kmalloc tables
  o remove nr_reverse_maps VM accounting
  o speed up rmap searching
  o misc rmap speedups
  o Replace the radix-tree rwlock with a spinlock
  o rmap comments
  o fix unuse_pmd fixme
  o JBD pasting warning fix
  o task_vsize() speedup
  o Allow panics and reboots at oops time
  o epoll cross-thread deletion fix
  o Missing brelse() in ext2/ext3 extended attribute code
  o Make msync(MS_ASYNC) no longer start the I/O
  o struct address_space comments
  o task_lock commentary fixes
  o 3c59x EISA tidyup
  o fix file leak in fadvise()
  o [IPV4]: Fix bootup lockup when !CONFIG_IP_MULTICAST
  o kobject hotplug fixes
  o radix_tree_delete API improvement
  o Fix gen_rtc compilation error
  o remove the test for null waitqueue in __wake_up()
  o Remove flush_page_to_ram()
  o Fix deadlock with ext3+quota
  o don't clear PG_uptodate on ENOSPC
  o correct vm_page_prot on stack pages
  o convert file_lock to a spinlock
  o bootmem speedup from the IA64 tree
  o architecture hooks for mem_map initialization
  o Fix kmalloc_sizes[] indexing
  o /proc/interrupts allocates too much memory
  o vmalloc stats in /proc/meminfo
  o /proc/meminfo documentation
  o percpu_counters: approximate but scalable counters
  o blockgroup_lock: hashed spinlocks for ext2 and ext3
  o use spinlocking in the ext2 block allocator
  o use spinlocking in the ext2 inode allocator
  o Put all functions in kallsyms
  o missing file_lock conversions
  o Fix oprofile on hyperthreaded P4's
  o flush_work_queue() fixes
  o fix tty shutdown race
  o genrtc: jiffies type fix
  o export kernel_fpu_begin() to GPL modules
  o Posix timer hang fix
  o fix MCE startup ordering problems
  o Resource management for NFS
  o Use WARN_ON in local_bh_enable()
  o Handle invalid pfns in page_add/remove_rmap
  o Fix orlov allocator boundary case
  o remove unnecessary FIXME

Andries E. Brouwer:
  o paride fix: make timeouts unsigned long
  o krxtimod.c fix: make timeouts unsigned long
  o kafstimod.c fix: make timeouts unsigned long
  o tty_io.c: make redirect static
  o [SPARC64]: Remove LVM ioctls
  o struct loop_info64 with __u64
  o fix slab corruption in namespace.c
  o correct error message for failed clone ns
  o s/to long/too long/

Arnaldo Carvalho de Melo:
  o o linux/net.h: prune the include dependency tree, remove include socket.h
  o add include uaccess.h to drivers/char/sx.c

Art Haas:
  o USB: C99 initializers for drivers/usb files

Badari Pulavarty:
  o Isn't sd_major() broken ?

Ben Collins:
  o IEEE-1394/Firewire updates
  o Fix module param decleration in pcilynx
  o Fix nodemgr.c compile
  o IEEE-1394/Firewire updates
  o IEEE-1394/Firewire updates

Chris Wright:
  o remove __sk_filter

Christoph Hellwig:
  o [XFS] remove busy inode check in the umount path - Linux checked it
    for us before calling into the filesystem.  We're beyond the point
    of no return for umount anyway
  o [XFS] remove atomicIncWithWrap
  o [XFS] merge over some lost changes from the XFS tree
  o fix devfs support in i386 microcode driver
  o bring devfs_register calls in dvb in shape
  o make devpts filesystem mandatory even for CONFIG_DEVFS
  o remove DEVFS_FL_*
  o dm devfs fix
  o devfs: fix compilation
  o devfs: minor miscdev changes
  o devfs: cleanup devfs use in ide
  o devfs: cleanup devfs use in scsi
  o devfs: sanitize devfs_register_tape prototype
  o devfs: cleanup partition handling interaction
  o devfs: make devfs_generate_path static

Dave Jones:
  o [AGPGART] Remove unneeded inline
  o [AGPGART] Kill agp_generic_agp_3_0_enable, fold into
    agp_generic_agp_enable()
  o [AGPGART] namespace cleanup agp_generic_agp_enable ->
    agp_generic_enable
  o [AGPGART] other part of the namespace cleanup patch that got lost
  o [AGPGART] If agp 3.0 setup fails, fall back to agp 2.0 setup
  o [AGPGART] bump copyright dates
  o [AGPGART] Enable extra VIA GART IDs
  o [AGPGART] New PCI idents for new VIA GARTs
  o [AGPGART] Make i7x05 compilable again
  o [AGPGART] Remove unneeded test
  o [AGPGART] Remove flawed 'follow secondary PCI bus' logic
  o Cset exclude:
    davej@codemonkey.org.uk|ChangeSet|20030328161219|08037
  o [AGPGART] Fold Intel i7x05 GART into intel-agp driver
  o [AGPGART] ia64 related AGP fixes from David Mosberger
  o [AGPGART] Missing C99 struct initialiser for x86-64 GART
  o [AGPGART] Kconfig cleanups. (Remove no longer needed E7x05 entries)
  o [AGPGART] Remove CONFIG_AGP3
  o [AGPGART] x86-64 Kconfig fixes
  o [AGPGART] Print banner on detecting AMD64 GART
  o [AGPGART] update stale comment in x86-64 GART driver
  o [AGPGART] Fix up AMD64 references
  o [AGPGART] Remove unnecessary AGP printk's in DRM

David Brownell:
  o USB: ehci-hcd, minor hardware tweaks
  o USB: ohci-hcd, pci posting paranoia
  o USB usbnet: dynamic config, cdc-ether, net1080
  o USB: kerneldoc for usbfs
  o USB: set_configuration() missed some state
  o USB: disconnect cleanup, new HCD callback
  o disconnect cleanup, new HCD callback
  o USB: DocBook/usb.tmpl patch
  o USB: EHCI disconnect cleanup

David Mosberger:
  o ia64: Drop unused NEW_LOCK spinlock code and clean up unneeded test
    in kernel unwinder.
  o ia64: Remove ia64_spinlock_contention()
  o ia64: Rename __put_task_struct() to free_task_struct().  Based on
    patch by Peter Chubb
  o ia64: Fix settimeofday().  Based on patch by Eric Piel
  o ia64: Fix sys_clone() to take 5 input arguments
  o ia64: Patch by Andreas Schwab: The read_lock and read_unlock macros
    should not use such innocent variable names like tmp because they
    have a high probability to clash with (part of) the argument.
  o ia64: Minor Makefile cleanup
  o First draft at making modules work again (loosely based on Rusty's
    original and thoroughly broken ia64 patch).  Not all relocs are
    supported yet and the reloc code needs to be cleaned up, but simply
    stuff like loading the palinfo module works.  Also, linkage-stubs
    are optimized with brl for McKinley or better.
  o ia64: Manual merge of Keith Owen's patch to avoid deadlock on
    ia64_sal_mc_rendez().  Also prefix local-variables in SAL macros to
    avoid name collisions.
  o ia64: Rewrite the relocator in the kernel module loader.  Fix some
    bugs and simplify the handling of loader-created sections.
  o ia64: Add ia64-specific LDFLAGS_MODULE and export unwind API to
    modules
  o ia64: Fix typo in sys_clone()
  o ia64: Add module.lds
  o ia64: Minor fixes
  o ia64: Fix module loader by setting sh_type of place-holder
    sesctions to SHT_NOBITS
  o ia64: More module-loader fixing
  o ia64: Two small MCA fixes
  o ia64: Patch by Andreas Schwab to fix sys32_ptrace()
  o ia64: Change struct ia64_fpreg so it will get 16-byte alignment
    with all ia64 compilers, not just GCC.
  o ia64: Fix IA64_FETCHADD() macro
  o ia64: Checkin support files for vendor-specific ACPI extensions
  o ia64: Trivial stack-size correction in mca.c.  Patch by Keith Owens
  o ia64: Fix inconsistency in sys32_execve().  Reported by Chandra
    Kapate).
  o ia64: Sync sys32_ipc() with x86 counter-part
  o ia64: Initial sync with 2.5.67
  o module symbol fix
  o fix fs->lock deadlock with emulated name lookup

David S. Miller:
  o [SPARC]: Fix sys_ipc to return ENOSYS instead of EINVAL as
    appropriate
  o [SPARC]: Cleanup uaccess headers and add __user attributes
  o [SPARC]: Make SA_ signal mask values explicitly unsigned
  o [SPARC64]: Fix copy_in_user args in process.c
  o [SPARC64]: Use __user in ioctl32.c
  o [SPARC]: __user tagging in sys_sparc.c
  o [SPARC]: __user attributes in signal handling
  o [sparc]: Fix typo in uaccess.h
  o [sparc]: Add missing const qualifiers to uaccess.h
  o [sparc]: Make sure -m32 gets added to AFLAGS when needed
  o [SIGINFO]: asm-generic/siginfo.h needs linux/compiler.h
  o [IPV4]: Do proper netdev module refcounting in tunnel drivers
  o [IPV6]: Apply ipv4 tunnel module fixes to SIT driver
  o [IPV6]: Typo, try_get_module --> try_module_get
  o [ALSA]: Recent merge undid all of my build fixes, put them back in
  o [SCHED]: Some schedulers forget to flush filter list at destroy
  o [IPV4]: Fix IGMP build with CONFIG_IP_MULTICAST disabled
  o [PKTSCHED]: Fix double-define of __inline__ et al
  o [IPSEC]: Add ipv4 tunnel transformer
  o [IGMP]: Dont dork with igmp timers on device down if not
    CONFIG_IP_MULTICAST
  o [IPV4]: xfrm4_tunnel and ipip need to privateize some symbols
  o [SPARC64]: Update defconfig
  o [SPARC64]: file_lock is now a spin lock
  o [TUN]: Convert from MOD_{INC,DEC}_USE_COUNT to netdev->owner
  o [NET]: Use time_before in dst_set_expires
  o [PKT_SCHED]: Remove ugly arch ifdefs from generic code
  o [NETFILTER IPV6]: Fix route leak in ip6_route_me_harder
  o [NET]: Actually apply Yoshfuji's fl6_{src,dst} patch
  o [SPARC64]: Missed rusage/rlimit/wait4 compat conversions

David Stevens:
  o [IPV4]: IGMPv3 support, with help from Vinay Kulkarni
  o [IPV6]: Add MLDv2 support

Duncan Sands:
  o USB speedtouch: handle failure of usb_set_interface
  o USB speedtouch Kconfig fix; CREDITS entry out of order
  o USB speedtouch: don't open a connection if no firmware
  o USB speedtouch: discard packets for non-existant vcc's

Geert Uytterhoeven:
  o Atari Atyfb fixes
  o M68k module support
  o M68k IDE irq
  o Amiga keyboard updates
  o Amiga Gayle IDE fixes

George Anzinger:
  o too much timer simplification
  o Cleanups for posix timer hang fix

Gerd Knorr:
  o i2c: add i2c_clientname()

Greg Kroah-Hartman:
  o USB: remove redundant checks for NULL when it can never happen
  o kobject: cause /sbin/hotplug to be called when kobjects are added
    and removed
  o Kobject: add NULL to decl_subsys() due to addition of hotplug
    operations
  o driver core: move the hotplug support for /sys/devices to use the
    kobject logic
  o block: add /sbin/hotplug support for when block devices are created
    and destroyed
  o Kobject: add NULL to decl_subsys() due to addition of hotplug
    operations
  o i2c: fix up CONFIG_I2C_SENSOR configuration logic
  o i2c: fix up via686a.c driver based on previous i2c api changes
  o USB: set port->tty to NULL after we have closed the port
  o i2c: fix up compile error in scx200_i2c driver
  o i2c: clean up i2c-dev.c's formatting, DEBUG, and ioctl mess
  o USB: fix uss720 driver to work properly with recent parport changes
  o Input: change input_init() to be a subsys initcall
  o USB: fix up spin_unlock_irqrestore() issues in previous patch
  o USB: add better check to prevent oops in hcd_unlink_urb()
  o USB: kl5kusb105 fix up errors found by smatch
  o USB: kobil_sct fix up errors found by smatch
  o USB: io_edgeport: stop unlinking a urb that we don't need to unlink
  o USB: keyspan: fixed up might_sleep() problems on device close
  o Cset exclude:
    arndt@lin02384n012.mc.schoenewald.de|ChangeSet|20030415031138|37565
  o USB: fix oops in usb_hotplug for root devices

Hanna Linder:
  o USB: input class hookup to existing support

Henning Meier-Geinitz:
  o USB scanner.c endpoint detection fix

Hideaki Yoshifuji:
  o [IPV{4,6}]: Convert from MOD_{INC,DEC}_USE_COUNT
  o [IPV6]: Fixed multiple mistake extension header handling
  o [IPV6]: Set noblock to 1 in NDISC sock_alloc_send_skb calls
  o [NET]: Use fl6_{src,dst} etc

Ivan Kokshaysky:
  o alpha: execve() fix
  o alpha: move_initrd fix (from Jeff Wiedemeier)
  o alpha: lynx support

Jakub Jelínek:
  o ia64: clone2/clone argument order fixes

James Bottomley:
  o lasi700 add missing dma-mapping.h #include
  o sym53c8xx driver v1: PA-RISC needs same PCI command fix as powerpc
  o fix scsi queue plugging behaviour

James Morris:
  o [IPSEC]: Move xfrm type destructor out of spinlock
  o [NET]: skb_headlen() cleanup
  o [IPSEC]: AH/ESP forget to free private structs
  o [IPSEC]: Really move type destructor out of spinlock
  o [IPSEC]: Support for optional policies on input got lost
  o [IPSEC]: Add initial IPCOMP support
  o [PKTSCHED]: Kill redefinition of IPPROTO_ESP in sch_sfq.c
  o [IPSEC]: Fix handling of uncompressable packets in tunnel mode

James Simmons:
  o [RAGE 128/CONTROL/PLATNIUM FBDEV] PPC updates
  o [FBCON] Could be called outside of a process context. This fixes
    that
  o [FBCON] Now we use workqueues so framebuffer code can always work
    in a process context
  o [FBDEV] The image color depth of zero hack has been killed
  o [I810 FBDEV] Driver updates
  o [FBDEV] Documentation on the device numbers of /dev/fb being
    mulitples of 32 is no longer true. Removed that info
  o [FBDEV] Massive cleanups of the cursor api
  o [FBDEV] Final cursor code cleanups. Now the burden of handling the
    cursor code lies on the driver side. The reason for this is that a
    invalid cursor might come from userland
  o [FBDEV SOFT CURSOR] Test to see if kmalloc failed
  o [FBDEV] Use C99 style
  o [FBDEV] Killed off shutting down IRQs. We need them for some types
    of hardware
  o [FBDEV] Made the upper layer code always use the cursor mask of
    struct fb_cursor inside struct fb_info. This moved memory
    management of the mask and image data to the upper layers
  o [FBDEV] Made the upper layer code always use the cursor mask of
    struct fb_cursor inside struct fb_info. This moved memory
    management of the mask and image data to the upper layers
  o [FBDEV] EDID support from OpenFirmware on PPC platoforms and from
    the BIOS on intel platforms
  o [RADEON FBDEV] Detect 8 Megs of RAM not 8 Kilobytes
  o [RADEON FBDEV] Compile fixes
  o [RIVA FBDEV] Cursor fixes. Almost done. At least it looks normal
    most of the time
  o [FBDEV] Improved speed performance. We copy many bytes of data
    instead of just one at a time

Jan Dittmer:
  o i2c: convert via686a i2c driver to sysfs

Jan Harkes:
  o Fix coda/devfs oops

Jaroslav Kysela:
  o ALSA update
  o ALSA and PnP update

Jeb J. Cramer:
  o [E1000] Fixed syntax error for C99 initializers

Jeff Garzik:
  o [ia32] use __builtin_memcpy compiler intrinsic for small memcpy's

Jens Axboe:
  o no blk_queue_empty
  o move q->queuedata assign after queue init

Jes Sorensen:
  o ia64: don't try to synchronize ITCs on ITC_DRIFT platforms

Jesse Barnes:
  o ia64: remove stale mmiob function
  o ia64: SN makefile update take
  o ia64: machine vectors for readX routines

Jon Grimm:
  o [IPV6]: Catch up SCTP to inet6_protocol changes

Justin T. Gibbs:
  o Aic79XX Driver Update
  o Aic79xx Driver Update
  o Aic79xx Driver Update
  o Aic79xx Driver Update to version 1.3.2
  o Update aicasm/Makefile so that link specifications are specified
    after all object files.  This seems to be required in order to link
    correctly in some cases.
  o Update Aic7xxx driver to version 6.2.29
  o Update Aic79xx Driver
  o Update aic7xxx driver
  o Update aic79xx Driver to 1.3.4
  o Update Aic7xxx Driver to 6.2.30
  o Complete Aic7xxx and Aic79xx driver merge with Linux 2.5.X mainline
  o Fix Aic7xxx and Aic79xx Driver builds for 2.4.X
  o AICLIB Update
  o Aic79XX Driver Update [Rev 1.3.5]
  o Update Aic7xxx driver [Rev 6.2.31]

Kai Makisara:
  o SCSI tape ILI and timeout fixes
  o SCSI tape EOT write fixes
  o SCSI tape sysfs and module parameter additions

Keith Owens:
  o ia64: unwind.c - allow unw_access_gr(r0)
  o ia64: mca rendezvous fix

Kochi Takayoshi:
  o ia64: update email address

Linus Torvalds:
  o Avoid using pointers to anonymous structure initializers. It's a
    gcc'ism, and even gcc can apparently get confused by it.
  o Make it more explicit that jiffies are "unsigned long", but that we
    for the initial value ctually want to check only wrap-around in an
    "unsigned int". 
  o Fix up merge with Alan
  o More left-over fixups from the merge with Alan
  o Fix mtdblock.c compile. From Adrian Bunk
  o Add __user/__kernel address space modifiers. When not checking,
    these end up being no-ops, but they get enabled by the type checker
    as special address_space attributes.
  o Add the proper sprinkling of __user attributes to the user space
    access functions. This allows the type checker to check proper
    usage.
  o Add __user attributes to user pointers in kernel/signal.c. This was
    the first file tested with my type checker with the anal pointer
    attribute checking turned on.
  o Make __SI_MASK explicitly unsigned, instead of depending on magic C
    promotion to silently do so for us.
  o Annotate scheduler system calls as taking user pointers
  o Annotate i386/signal.c with address space type annotations
  o Add user pointer attributes to kernel/module.c
  o Annotate fs/exec.c with user pointer annotations
  o Annotate fs/namei.c with user pointer annotations
  o Annotate x87 user space access functions with proper type
    attributes
  o User pointers are not just in another address space, they also must
    never be dereferenced directly. Make that clear in the attribute.
  o Add user pointer attributes to kernel/sys.c
  o Tag more user-supplied path strings as being user pointers for type
    evaluation.  This tags the system call interfaces in fs/open.c,
    fs/dcache.c and mm/swapfile.c - and tags the path walking helper
    functions.
  o Annotate sysct with user pointer annotations
  o Annotate kernel/time.c with user pointer annotations
  o Annotate uid16 with user pointer annotations
  o Annotate kernel/ptrace.c with user pointer information
  o Annotate kernel/printk.c with user pointer annotations
  o Fix bad prototypes in kernel/softirq.c
  o Fix kernel/posix-timers.c
  o Merge from DRI CVS: Use the list_entry() macro instead of depending
  o Annotate fs/stat.c with user pointer annotations
  o Annotate kernel/futex.c with user pointer annotations
  o Annotate kernel/itimer.c with user pointer annotations
  o Annotate read/write paths with user pointer annotations
  o Clean up types and remove unnecessary casts from fs/readdir.c
  o Add user pointer annotations to fs/seq_file.c
  o Add user pointer annotations to fs/super.c
  o Add user pointer annotations to fs/select.c
  o Add a user pointer annotation to sysinfo()
  o Make sure to kunmap() the right address in fs/nfs/dir.c
  o Annotate sys_uselib() with user pointer annotation
  o Remove all of arch/s390x and include/asm-s390x, since the 390x
    architecture is now just a 64-bit configuration option of the basic
    s390 architecture.
  o Store EDID only when CONFIG_VIDEO_SELECT is set and edid function
    actually exists.
  o Make the x86 flags save/restore code check the type of the macro
    argument, so that portability issues will be found in a timely
    manner.
  o Fix incorrect 'flags' usage pointed out by stricter type checking
  o Fix typo (and logic bug that the typo hid) in bit value testing. 
  o Annotate sys_nfsservctl() with user pointer annotations
  o Fix user pointer annotations in more places, now that 'sparse'
    verifies declarations against definitions and checks argument
    types.
  o Annotate namespace system calls (mount, umount, pivot_root etc)
    with user pointer annotations.
  o Add more user pointer annotations
  o Don't allow rmap to touch reserved or out-of-range pages
  o Cleanups: remove unused label and fix crappy counting code that
    didn't work.

Luca Tettamanti:
  o i2c: Add i2c-viapro.c driver

Martin Josefsson:
  o [NETFILTER IPV6]: Fix Makefile typo

Martin Schlemmer:
  o i2c: Fix w83781d sensor to use Milli-Volt for in_* in sysfs
  o i2c: remove compiler warning in w83781d sensor driver

Martin Schwidefsky:
  o s390: base s390 fixes
  o s390: syscall numbers > 255
  o s390: common i/o layer update
  o s390: console changes
  o s390: uni-processor builds
  o s390: dasd driver fixes
  o s390: dasd driver coding style (1/2)
  o s390: dasd driver coding style (2/2)
  o s390/s390x unification (1/7)
  o s390/s390x unification (2/7)
  o s390/s390x unification (3/7)
  o s390/s390x unification (4/7)
  o s390/s390x unification (5/7)
  o s390/s390x unification (6/7)
  o s390/s390x unification (7/7)
  o s390 network driver fixes

Matt Porter:
  o Fix scsi build on !CONFIG_GENERIC_ISA_DMA

Matthew Dharm:
  o usb-storage: fix CB/CBI
  o usb-storage: variable renames
  o usb-storage: remove BUG/BUG_ON
  o usb-storage: add info to /proc interface

Mikael Pettersson:
  o lapic_nmi_watchdog resume fix

Miles Bader:
  o On the v850/nb85e, acknowledge interrupts immediately after
    handling them

Nathan Scott:
  o [XFS] Fix definition of setresblks - nothing uses it yet, but DMF
    will (so fix now)
  o [XFS] Fix a pagebuf leak with the pagebufs used to coordinate IO
    completion for unwritten extent writes.
  o [XFS] Fix up some minor namespace pollution problems

Neil Brown:
  o kNFSd: nfsd/export.c tidyup and add missing exp_put
  o kNFSd: Return correct result for ACCESS(READ) on eXecute-only file
  o kNFSd: NFSD binary compatibility breakage
  o kNFSd: First step to adding state management to NFSv4 server
  o md: Fix raid1 oops

Oliver Neukum:
  o USB: leave usage counts during probe/remove to driver core
  o USB: locking reset/probe
  o USB: removing unnecessary calls to usb_set_configuration
  o USB: remove unnecessary setting of configuration from audio
  o USB: remove configuration change from rtl8150
  o USB: remove configuration change from pegasus.c

Patrick Mansfield:
  o 1/7 starved changes - use a list_head for starved queue's
  o 2/7 add missing scsi_queue_next_request calls
  o 3/7 consolidate single_lun code
  o 4/7 cleanup/consolidate code in scsi_request_fn
  o 5/7 alloc a request_queue on each scsi_alloc_sdev call
  o 6/7 add and use a per-scsi_device queue_lock
  o 7/7 fix single_lun code for per-scsi_device queue_lock
  o scsi-locking-2.5 rename scsi_check_sdev and
  o 1/5 scsi-locking-2.5 single_lun store scsi_device pointer
  o 2/5 scsi-locking-2.5 remove lock hierarchy
  o 3/5 scsi-locking-2.5 prevent looping when processing
  o 4/5 scsi-locking-2.5 list_del starved_entry plus use
  o 5/5 scsi-locking-2.5 remove extra sdev2, remove extra

Paul Mackerras:
  o USB: small fix to pegasus.c
  o i2c: Add driver for powermac keywest i2c interface

Pete Zaitcev:
  o [sparc]: BUglet in copy_thread
  o [sparc] Force type in __put_user
  o [sparc]: pte_file & friends
  o [sparc] Add #include <asm-generic/pci.h>
  o [sparc] Update system.h (gcc-3 & misc)
  o [sparc]: pte_file with constant number of bits

Peter Chubb:
  o ia64: declare test_bit() arg as "const"

Petko Manolov:
  o USB: pegasus link status fix

Randolph Chung:
  o {get,set}affinity unification

Richard Henderson:
  o [ALPHA] Remove parameter list from cond_syscall decl
  o [ALPHA] Elide cabriolet_init_irq for CONFIG_ALPHA_PC164

Rob Radez:
  o [sparc]: Fix uninitialized spinlock in SRMMU code

Russell King:
  o [SERIAL] Remove USR 56K voice modem specific PCI table entry
  o [ARM] Make sys_ipc return ENOSYS for unrecognised IPC calls
  o [SERIAL] Console initcalls return int, zero for success
  o [ARM] Fix exception table handling
  o flush_cache_mm in zap_page_range
  o [SERIAL] Move make modem control signals accessible to line
    discplines
  o [ARM] Fix Kconfig breakage in arch/arm/mach-iop3xx/Kconfig
  o [PCMCIA] Fix non-PCI PCMCIA bridge oops

Rusty Russell:
  o Unreachable code in drivers_net_fc_iph5526.c
  o Remove naked GFP_DMA from drivers_net_macmace.c
  o Clear up GFP confusion in rcpci45.c
  o [PATCH 2.5.63] net_wan_sdla_chdlc tty_driver add .owner field
    remove MOD_INC_DEC_USE_COUNT
  o [PATCH 2.5.63] net_wan_pc300_tty tty_driver add .owner field remove
    MOD_INC_DEC_USE_COUNT
  o [2.5 patch] fix the compilation of drivers_net_tokenring_tms380tr.c
  o [PATCH 2.5.63] epca tty_driver add .owner field remove
    MOD_INC_DEC_USE_COUNT
  o [IPSEC]: Avoid using SET_MODULE_OWNER
  o [NETFILTER]: Push skb linearization deeper inside of implementation
  o [NETFILTER_IPV4]: De-linearization of IP Connection Tracking

Scott Feldman:
  o [E1000] Revert NAPI back to interrupt disable/enable mode

Stephen Hemminger:
  o [VLAN]: Update to new module semantics, use synchronize_net
  o [VLAN]: More device registry error handling fixes
  o [BRIDGE]: Fix several locking bugs, plus cleanups
  o [BRIDGE]: Kill excessive stack usage in br_ioctl
  o [EBTABLES]: Get rid of brlock in ebtable_broute
  o [VLAN]: Cleaner module interface
  o [BRIDGE]: Fix race in br_fdb_get_entries
  o [BRIDGE]: Ethernet bridge driver device mangling cleanup

Stephen Rothwell:
  o ia64: compat_sys_fcntl{,64}
  o ia64: compat_uptr_t and compat_ptr

Steven Whitehouse:
  o [DECNET]: DECnet routing fixes etc

Trond Myklebust:
  o Fix a series of NFS read/readdir/readlink errors
  o Remove bogus check on the size of NFSv4 'readdir' cookies
  o Prepare for the introduction of NFSv4 state code
  o Implement stateful open() for NFSv4 as per RFC3010-bis
  o Setup code to tear down the NFSv4 state once we're done with a file
  o Make NFSv4 'setattr()' method use the cached stateid if the file is
    already open.
  o Make NFSv4 'read' code use the cached stateid if it exists
  o Make the NFSv4 write code use the stateid if it exists

Ulrich Drepper:
  o unwinding for vsyscall code

Zwane Mwaikambo:
  o SET_MODULE_OWNER for tulip_core


