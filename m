Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265013AbUFGTdl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265013AbUFGTdl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Jun 2004 15:33:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265015AbUFGTdl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Jun 2004 15:33:41 -0400
Received: from fw.osdl.org ([65.172.181.6]:19929 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265013AbUFGTdB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Jun 2004 15:33:01 -0400
Date: Mon, 7 Jun 2004 12:32:45 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Linux 2.6.7-rc3
Message-ID: <Pine.LNX.4.58.0406071227400.2550@ppc970.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Ok, let's calm down for a while before the final 2.6.7.

-rc3 does a lot of sparse type cleanup, mainly thanks to Al Viro (but his
work ended up getting some other people involved too, since the list of
sparse warnings isn't as daunting any more). Some of that has unearthed 
real bugs which Al fixed.

But there are DRM, AGP, cpufreq, sparc64, and input updates there too. See 
the appended shortlog for more details,

			Linus

-----

Summary of changes from v2.6.7-rc2 to v2.6.7-rc3
============================================

Adam Kropelin:
  o [FB]: Fix uninitialized fb_cmap member in sbuslib.c

Adrian Bunk:
  o POSIX_MQUEUE depends on NET
  o SECURITY_SELINUX depends on NET

Alex Tsariounov:
  o ia64: fix comment-typo in entry.S

Alex Williamson:
  o ia64: setup cpu_to_node for cpus not present

Alexander Viro:
  o sparse: missed setsockopt wrappers
  o sparse: dev_ioctl() callers
  o sparse: missed piece of sock_get_timestamp() annotation
  o sparse: trivial part of net/* annotation
  o sparse: more net/* annotation
  o sparse: net/* non-ANSI argument lists
  o sparse: amd64 annotation - beginning
  o sparse: amd64 annotations - trivial part
  o sparse: amd64 - more trivial annotations
  o sparse: amd64 - #if abuse fixes
  o sparse: amd64 - long constants
  o sparse: amd64 - rest
  o sparse: fs/compat.c::copy_iocb() cleanup
  o sparse: tty_io annotation
  o sparse: tty_ioctl annotation
  o sparse: vt and friends
  o sparse: n_tty annotation
  o sparse: tty_driver ->write_proc()
  o sparse: SIOCGIFCONF handling - the rest of it
  o sparse alpha: beginning of __user annotation
  o sparse alpha: long constants
  o sparse alpha: #if abuses
  o sparse alpha: trivial parts of __user annotation
  o sparse alpha: utimes()
  o sparse alpha: the rest of it
  o trivial annotation for arch/i386/kernel/*
  o sparse: reiserfs annotation
  o sparse: asus_acpi dereference of userland pointers
  o sparse: sound sb fix
  o sparse: msnd sound fix
  o sparse: sound/core/timer.c fix
  o sparse: sound/core annotation - trivial part
  o sparse: annotation of include/sound (generic parts)
  o sparse: sound/core/pcm* annotation
  o sparse: opl annatation
  o sparse: rest of sound/core
  o sparse: sound/isa/gus annotation
  o sparse: sscape annotation
  o sparse: wavefront annotation
  o sparse: sb annotation
  o sparse: vx annotation
  o sparse: trident annotation
  o sparse: rme9652 annotation
  o sparse: emu10k1 annotation
  o sparse: rest of ALSA annotation
  o sparse: cs4281 annotation
  o sparse: cmpci annotation
  o sparse: es1371 annotation
  o sparse: es1370 annotation
  o sparse: esssolo annotation
  o sparse: rme96xx annotation
  o sparse: i810 annotation
  o sparse: cs46xx annotation
  o sparse: ali5455 annotation
  o sparse: sonicvibes annotation
  o sparse: maestro3 annotation
  o sparse: the rest of sound/* annotation
  o sparse: ad1889 annotation
  o sparse: btaudio annotation
  o sparse: maestro annotation
  o sparse: ymfpci annotation
  o sparse: msnd annotation
  o sparse: forte annotation
  o sparse: drivers/cpufreq annotation
  o sparse: drivers/cdrom annotation
  o sparse: drivers/md annotation
  o sparse: drivers/pnp annotation
  o sparse: DAC960 annotation
  o sparse: cciss annotation
  o sparse: cpqarray annotation
  o sparse: paride annotation
  o sparse: rest of drivers/block annotation
  o drivers/atm/ambassador.c delousing
  o drivers/atm/horizon.c delousing
  o sparse: atm annotation (core)
  o sparse: atm annotation - drivers
  o sparse: coda annotation
  o sparse: decnet annotation
  o sparse: ax25 annotation
  o sparse: netrom annotation
  o sparse: rose annotation
  o sparse: x25 annotation
  o sparse: ipx annotation
  o sparse: appletalk annotation
  o sparse: econet annotation
  o sparse: wanrouter annotation
  o sparse: net/bridge annotation
  o sparse: netlink annotation
  o sparse: irda annotation
  o sparse: vlan annotation
  o sparse: bluetooth annotation
  o sparse: sctp annotation
  o sparse: more netfilter annotation
  o sparse: mroute annotation
  o sparse: ->ifr_data annotation
  o sparse: ->ifr_data fixes
  o sparse: more wan annotations
  o sparse: selinux annotation
  o sparse: rest of net/* annotations (in this patchset, that is ;-)
  o sparse: hugetlb sysctl annotation
  o sparse: gdth.c annotation
  o sparse: misc scsi annotation
  o sparse: rest of drivers/net annotations in the patchset
  o sparse: misc headers annotations
  o sparse: ide-floppy annotation
  o sparse: synclink_cs annotation
  o sparse: synclink annotation
  o sparse: trivial fs annotations
  o sparse: usb/core/devio annotation
  o sparse: sonypi annotiation
  o sparse: ppdev annotation
  o sparse: misc drivers annotations
  o sparse: lp annotation
  o sparse: drivers/char/i8 annotation
  o sparse: tpqic annotation
  o sparse: if_mii() helper (from jgarzik)
  o sparse: the rest of ifr_data cleanups and annotations
  o sparse: drivers/net/tun.c annotation
  o sparse: depca annotation
  o sparse: slip.c annotation

Andi Kleen:
  o x86-64 update
  o Really fix empty node 0 on x86-64
  o Fix compilation on x86-64
  o Fix x86-64 compilation without CONFIG_NUMA
  o i386: add missing bitop.h memory clobbers
  o More x86-64 bugfixes
  o Use KERN_ALERT more for oopses

Andreas Dilger:
  o ext3: htree rename fix

Andrew Morton:
  o s2io section fix
  o ramfs o_sync oops fix
  o shrink_all_memory() fixes
  o Add reference_init.pl to `make buildcheck' target
  o direct-io invalidation fix
  o Add the sixth arg to the sys_futex() prototype
  o nfs-direct warning fix

Andries E. Brouwer:
  o partition table validity checking

Anton Altaparmakov:
  o NTFS: Add a new address space operations struct, ntfs_mst_aops, for
    mst protected attributes.  This is because the default ntfs_aops do
    not make sense with mst protected data and were they to write
    anything to such an attribute they would cause data corruption so
    we provide ntfs_mst_aops which does not have any write related
    operations set.
  o NTFS: Cleanup dirty ntfs inode handling (fs/ntfs/inode.[hc]) which
    also includes an adapted ntfs_commit_inode() and an implementation
    of ntfs_write_inode() which for now just cleans dirty inodes
    without writing them (it does emit a warning that this is
    happening).
  o NTFS: 2.1.12 release - Fix the second fix to the decompression
    engine

Anton Blanchard:
  o ppc64: add eeh_add_device_early/late
  o ppc64: reset iseries progress indicator on boot
  o ppc64: bolt first vmalloc segment into SLB
  o ppc64: SLB accounting fix
  o ppc64: iseries bolted SLB fix

Arjan van de Ven:
  o [libata] Use standard headers from include/scsi, not drivers/scsi

Arun Sharma:
  o ia64: tighten FPH state context switch check
  o ia64: disable in-kernel ia32 emulation post Madison

Bartlomiej Zolnierkiewicz:
  o ide: fix for generic IDE PCI module
  o ide: ide_pci_device_t sanitization
  o ide: merge amd74xx.h into amd74xx.c
  o ide: use generic ide_init_hwif_ports() on m68k
  o ide: use <asm-i386/ide.h> as <asm-x86_64/ide.h>
  o ide: add IDE_ARCH_OBSOLETE_DEFAULTS
  o ide: remove useless /proc/ide/siimage from siimage.c
  o ide: simplify CONFIG_IDEDMA_ONLYDISK logic a bit
  o DMA mode setup fixes for piix.c/ata_piix.c
  o apply nForce2 fixup only if C1 Halt Disconnect is enabled
  o ide: remove unused ide_remove_setting() from ide.c
  o ide: use try_to_flush_leftover_data() in idedisk_error()
  o ide: remove needless exports
  o ide: sanitize __ide_do_rw_disk() debugging code
  o ide: remove dead code from ide-taskfile.c

Ben Dooks:
  o [ARM PATCH] 1906/1: S3C2410: serial minor number fix

Benjamin Herrenschmidt:
  o Fix rivafb's OpenFirmware parsing
  o ppc32: Fix CPUs with soft loaded TLB
  o ppc32: missed flush_tlb_page_nohash() cases
  o ppc64: make the TLB flush logic match ppc32

Bert Hubert:
  o s/tkill/tgkill/ in /** documentation */

Bjorn Helgaas:
  o ia64: fix hotplug config placement
  o active_load_balance() deadlock

Brian Gerst:
  o Mark cache_names __initdata

Brian Lazara:
  o ide: add new nForce IDE/SATA device IDs to amd74xx.c

Catalin Marinas:
  o [ARM PATCH] 1912/1: Wrong cache aliasing bit check

Chris Mason:
  o direct-io hole fix

Christoph Hellwig:
  o farsync needs <asm/io.h>
  o pnpbios only makes sense for X86
  o linux/timer.h needs linux/stddef.h
  o fix mca procfs stub
  o [SBUS]: Define dma direction bits in terms of enum
    dma_data_direction
  o [ATM]: Simplify fore200e DMA macros even further
  o [SBUS]: Further cleanup of scsi driver header usage
  o ide: change CONFIG_IDEDISK_STOKE to a runtime option
  o [WATCHDOG] linux/watchdog.h include types.h patch

Colin Gibbs:
  o Fix readahead handling in knfsd

Colin Leroy:
  o Fix DRM mismerge(?)

Corey Minyard:
  o Fix procfs warnings when removing ipmi_si module
  o Fix ipmi compile failure

Darren Williams:
  o ia64: define pending_irq_cpumask in irq.c

Dave Airlie:
  o fix missing DRM_ERR()s - Eric Anholt
  o add R200_EMIT_RB3D_BLENDCOLOR state packet to support
    GL_EXT_blend_color, GL_EXT_blend_func_separate and
    GL_EXT_blend_equation_separate on r200 from Roland Scheidegger
  o MTD: add st m50fw0* to jedec_probe.c
  o Remove check that is needed only for 2.4 kernel fixes bug reports
    on lk

Dave Jones:
  o [AGPGART] If ati_create_gatt_pages() fails, don't propagate an
    address we've freed
  o [AGPGART] Various Intel/EM64T AGP fixes
  o [AGPGART] Don't abort if Intel-agp can't find AGP capability
  o [AGPGART] Make the driver only announce the PCI IDs it actually
    supports
  o [AGPGART] kill trailing whitespace & indentation fixes
  o [AGPGART] Make the VIA AGP driver only announce PCI IDs it actually
    supports
  o [AGPGART] Make the Nvidia AGP driver only announce PCI IDs it
    actually supports
  o [AGPGART] Add missing SIS755 ID to AMD64 AGP driver From: Andi
    Kleen
  o [AGPGART] Remove lots of trailing whitespace from amd64 gart driver
  o [AGPGART] Fix a potential leak in intel driver
  o [CPUFREQ] Silence noisy debugging printk in longhaul driver
  o [CPUFREQ] Convert longhaul driver to use module_param
  o [CPUFREQ] Remove some unneeded includes
  o [CPUFREQ] Use correct printk prefix in p4-clockmod driver
  o [CPUFREQ] Quieten the powernow-k7 init printk a little
  o [CPUFREQ] Remove a bunch of trailing whitespace from the
    powernow-k8 driver
  o [CPUFREQ] Fix leak in powernow-k8 Spotted by Yury Umanets
  o [CPUFREQ] Make longhaul debug a module option
  o [CPUFREQ] Scaling on VIA C3 Nehemiah works now
  o [CPUFREQ] fix panic in powernow_k8_verify on MP but PSB systems
  o [CPUFREQ] Make powernow-k7 module parameter not need powernow
    prefix
  o [AGPGART] Fix broken serverworks tlb flush routine
  o [AGPGART] Make agp=off work again
  o [AGPGART] Improve the resume functions for Intel AGP bridges by
    restoring config space (the bios might not have done that).
  o [CPUFREQ] Fix build of longhaul
  o Cset exclude: davej@redhat.com|ChangeSet|20040523113850|65135
  o [AGPGART] intel-agp: skip non-AGP devices From: Matt Domsch.
  o [CPUFREQ] Consolidate version checking in longhaul_get_cpu_mult
    reduce code duplication.
  o [CPUFREQ] Remove duplicate declaration of debug var from longhaul
  o [CPUFREQ] Change longhaul debugging info printk's to dprintk's
  o [CPUFREQ] Fix powernow-k7 when ACPI_PROCESSOR built as module
  o [CPUFREQ] Remove lots of redundant code from longhaul driver
  o [CPUFREQ] Document some oddness in the longhaul driver
  o [CPUFREQ] Unify the EBLCR parsing code in longhaul
  o [CPUFREQ] Remove duplicate debug printk from longhaul driver
  o [CPUFREQ] Move longhaul multiplier debug printk to somewhere more
    useful
  o [CPUFREQ] Remove bogus longhaul v4 The code only supports 3
    versions, so numbering them 1,2 and 4 doesn't make a lot of sense.
  o [CPUFREQ] Convert longhaul debug printk to use varargs
  o fix warning in synclink.c
  o Fix missing padding in DMI table

David Gibson:
  o Add watchdog timer to iseries_veth driver
  o hugetlbpage msync() fix
  o hugetlbpage: reinitialise compound page destructor

David Goodenough:
  o Support for SC1100

David Mosberger:
  o ia64: Reserve syscall # for vserver()
  o Update ia64 linux mailing-list and web-site addresses
  o ia64: Add defconfig for Ski simulator (patch by Darren Williams)
  o move #endif to correct place
  o ia64: Avoid intermediate-overflows in sched_clock()
  o ia64: Kill unused external declaration of "acpi_legacy_devices"

David S. Miller:
  o [SPARC64]: Update defconfig
  o [SPARC]: Do tty_flip_buffer_push outside of port lock
  o [PKT_SCHED]: Missing rta_len init in sch_delay
  o [SPARC64]: Fix NR_IRQS check in hardirq.h
  o [SPARC64]: Annotate 64-bit constants with 'UL'
  o [SPARC64]: __volatile --> __volatile__
  o [SPARC64]: Lots of sparse work for arch/sparc64
  o [SPARC]: Set sparse arch defines explicitly
  o [SPARC]: First stage of sparc32 sparse work
  o [IPV6]: ndisc_dst_alloc can never get a NULL dev
  o [SPARC64]: Compat syscall overhaul
  o [SPARC64]: Kill _exit kernelsyscall stub from unistd.h
  o [ATM]: fore200e dma direction macro tests no longer needed
  o [SPARC64]: New 6th arg of sys_futex needs sign extension
  o [SPARC64]: Update defconfig
  o [NETFILTER]: In ipt_TCPMSS, SYN packets are never hw checksummed
  o [SPARC64]: Fix compat_sys_wait4 extern decl
  o [SPARC64]: Tidy asm macros in sfp-util.h
  o [COMPAT]: Add __user attributes for pointers passed while KERNEL_DS
  o [AIO]: Split ki_user_obj into a 2 member union
  o [COMPAT]: Fix some sparse annotations in fs/compat_ioctl.c
  o [KERNEL]: Some sparse fixes for init/main.c
  o [TCP]: Need tcp_get_info decl in net/tcp.h

Diego Calleja García:
  o Document checkstacks

Dmitry Torokhov:
  o Input: synaptics driver cleanup
  o Input: support Synaptics touchpads that have separate middle button
  o Input: pass maximum allowed protocol to psmouse_extensions instead
    of accessing psmouse_max_proto directly allowing to avoid changing
    the global parameter when synaptics initialization fails
  o Input: Change spurious ACK warning in atkbd to soften accusation
    against XFree86
  o Input: fix trailing whitespace in atkbd
  o Input: remove unneeded fields in atkbd structure, convert to
    bitfields
  o Input: Do not generate events from atkbd until keyboard is
    completely initialized. It should suppress messages about suprious
    NAKs when controller's timeout is longer than one in atkbd
  o Input: when getting a new device announce (0xAA 0x00) in psmouse
    try reconnecting instead of rescanning to preserve (if possible)
    the same input device.
  o Input: move "reconnect after so many errors" handling from
    synaptics driver to psmouse so it can be used by other PS/2 protcol
    drivers (but so far
  o Input: add protocol_handler to psmouse structure to ease adding new
    protocols to psmouse module
  o Input: add psmouse_sliced_command (passes extended commands encoded
    with 0xE8 to the mouse) and use it in Synaptics and Logitech
    drivers
  o Input: do not modify device's properties when probing for protocol
    extensions on reconnect as it may interfere with reconnect process
  o Input: allow disabling legacy psaux device even for non-embedded
    systems
  o Input: serio trailing whitespace fixes
  o Input: make serio open and close methods optional
  o Input: trailing whitespace fixes
  o Input: - move set_abs_params from synaptics driver to input and
    rename to input_set_abs_params
  o Input: trailing whitespace fixes in drivers/input/serio
  o Input: kbd98io_interrupt should return irqreturn_t
  o Input: kbd98_interrupt should return irqreturn_t
  o Input: various fixes for H3600 touchscreen driver
  o Input: twidjoy module
  o Input: trailing whitespace fixes in drivers/input/keyboard
  o Input: power - add MODULE_LICENSE
  o Input: trailing whitespace fixes in drivers/input/joystick
  o Input: trailing whitespace fixes in drivers/input/gameport
  o Input: trailing whitespace fixes in drivers/input
  o Input: do not call synaptics_init unless we are ready to do full
    mouse setup
  o Input: split i8042 interrupt handling into an IRQ handler and a
    tasklet
  o Patch from Sau Dan Lee Input: i8042 - kill the timer only after
    removing interrupt handler,
  o Input: mousedev - better multiplex absolute and relative devices;
    cleanups

Eugene Surovegin:
  o ppc32: reorg DMA API, add coherent alloc in irq

Gary Hade:
  o ia64: Fix early serial console setup regression on the IBM x450 and
    x455

George France:
  o cpqarray.c: seed the random number pool

Herbert Xu:
  o [IPSEC]: Fix xfrm_tunnel leak
  o Check cmd in plip_ioctl

Hideaki Yoshifuji:
  o [IPV6] use appropriate __alignof__() for mibs
  o [NET] Introduce and use several common stuff for snmp item list
  o [IPV{4,6}] introduce ip-independent ipstats_mib based on ipv6_mib
  o [IPV6] rename snmp6_ipv6_list to snmp6_ipstats_list
  o [IPV4] use ip-independent ipstats_mib to store IPv4 statistics
  o [IPV6]: Store idev in routes
  o [IPV4]: Store idev in routes
  o [UDPv4]: Pass correct socket to ip_mc_sf_allow

Hugh Dickins:
  o mm: swapper_space.i_mmap_nonlinear
  o mm: follow_page invalid pte_page
  o mm: vma_adjust adjust_next wrap
  o mm: vma_adjust insert file earlier
  o mm: get_user_pages vs. try_to_unmap
  o mm: kill missed pte warning

Ian Campbell:
  o [ARM PATCH] 1890/2:  Consolidate CPUFREQ handling in SOC PCMCIA
    driver

Ingo Molnar:
  o md.c message during quiet boot
  o sched: remove noinline workaround
  o sched: honor the "sync" wakeup bit

Ivan Kokshaysky:
  o ide: don't put disks in standby mode on halt on Alpha

J. Bruce Fields:
  o kNFSd: exp_find(): remove null pointer check
  o kNFSd: nfsd_acceptable() typo fix
  o kNFSd: nfsd4 xdr name encoding improvements
  o kNFSd: gss_svc locking and refcounting fixes
  o kNFSd: rsc_lookup simplification
  o kNFSd: nfsd4_release_lockowner() oops fix
  o kNFSd: nfsd getattr fix
  o kNFSd: nfsd4 setclientid fix
  o kNFSd: nfsd4 file creation fix
  o kNFSd: documentation typo fixes

Jack Steiner:
  o sched: balance-on-exec fix

Jakub Jelínek:
  o Add FUTEX_CMP_REQUEUE futex op

Jamal Hadi Salim:
  o [NET]: Add ARPHRD_NONE and use it in tun driver
  o [NETFILTER]: Small cleanup for {ipt,ip6t,arpt}_find_target

James Morris:
  o [NETFILTER]: Fix checksum bug for multicast/broadcast packets on
    postrouting hook
  o [IPVS]: IPVS needs checksum fixups

Jan Kara:
  o quota: fix writing of quota info
  o quota: fix for old quota format

Jeff Garzik:
  o [netdrvr e1000] use generic ethtool_ops provided in
    net/core/ethtool.c
  o [netdrvr 8139too] remove bogus config option test
  o Cset exclude: jgarzik@redhat.com|ChangeSet|20040527204246|14084
  o [libata promise] revert broken taskfile delivery change
  o [libata scsi] ack SYNCHRONIZE CACHE command

Jeff Mahoney:
  o ext3_orphan_del may double-decrement bh->b_count

Jens Axboe:
  o fix cdrom length check
  o kill drivers/ide TCQ support

Jeremy Kerr:
  o Fix signal race during process exit

Jerzy Szczepkowski:
  o bug in sys_io_setup

Jesse Barnes:
  o ia64: don't udelay() in sn_mmiob

Jorge Hernandez-Herrero:
  o [SCTP] Fix to not setup a new association if the endpoint is in
    SHUTDOWN_ACK_SENT state and recognizes that the peer has restarted.
  o [SCTP] Fix to not start a new association on a 1-many style
    sendmsg() with MSG_EOF/MSG_ABORT flag and no data.

Jurriaan:
  o radeonfb fix (non-8bpp clear doesn't use palette)

Jörn Engel:
  o Improve `make checkstack'

Keith Owens:
  o ia64: work around linker bug

Kevin Corry:
  o dm: dm-ioctl.c: change an int* to a size_t*

Krzysztof Halasa:
  o Re: [Fwd: [PATCH] Stop queue on close in hdlcdrv]
  o 2.6 Generic HDLC update

Linus Torvalds:
  o Add __user annotations to sock_get_timestamp()
  o ppc64: fix untyped large constants so that they don't cause sparse
    to warn about implicit typing.
  o ppc64: use "ASM_CONST()" to give proper C type to constants that
    can also be used in assembly language context.
  o ppc64: more explicitly typed constants
  o ppc64: mark the "regshere" marker with proper type information
  o sparse: add "__force" type attribute for forcing a cast
  o ppc64: check more of the user access functions for proper arguments
  o ppc64: missing __user annotations noticed by stricter checks
  o sparse: make x86 user pointer checks stricter
  o ppc64: fix more user pointers in signal handling
  o ppc64: add more user annotations to ptrace.c
  o ppc64: more user address fixups
  o sparse: make x86 and ppc64 set the architecture-specific #define's
    explcitly.
  o sparse: use new generic __chk_user_ptr() macro in x86/ppc64/sparc*
  o Start documenting the sign-off procedure in SubmittingPatches
  o Add comments on load balancing special cases
  o sparse: fix up futex address space warning
  o sparse: annotate (and comment on) kmod.c user pointer usage
  o rpc: Use proper printk format for size_t argument
  o Linux 2.6.7-rc3

Luiz Capitulino:
  o fix net/ixgb/ixgb_main.c warning
  o fix possible NULL pointer in fs/ext3/super.c
  o mm/oom_kill.c trivial cleanup

Maeda Naoaki:
  o ia64: fix /proc/ioports regression in 2.6.6 on Tiger4

Marc-Christian Petersen:
  o vesafb: vram boot option the same as 2.4.x

Marcel Holtmann:
  o [Bluetooth] Move function exports out of syms.c
  o [Bluetooth] Remove CVS tags and cleanup the code
  o [Bluetooth] Update Kconfig help entries
  o [Bluetooth] Allocate protocol number for HIDP support
  o [Bluetooth] Add dynamic PSM allocation for L2CAP server sockets
  o [Bluetooth] Add dynamic channel allocation for RFCOMM server
    sockets
  o [Bluetooth] Add quirk for broken RTX Telecom based dongles

Marcus Meissner:
  o dm: add DM_REMOVE_ALL_32 compat ioctl

Margit Schubert-While:
  o prism54: delete cvs tags
  o prism54: Add new private ioctls
  o prism54: Reset card on tx timeout
  o prism54: Add iwspy support
  o prism54: Add avs header support

Martin Schwidefsky:
  o s390: core
  o s390: common i/o layer
  o s390: block device driver
  o s390: network device driver

Matt Porter:
  o ppc32: add "indirect" DCR access, pass 2

Matt Tolentino:
  o kill off efi_dir in efi.h
  o update elilo loader location in Kconfig

Matthew Wilcox:
  o Better tulip handling on PA-RISC

Mikael Starvik:
  o CRIS architecture update

Nathan Lynch:
  o ppc64 gives up too quickly on hotplugged cpu
  o use c99 struct initializer in hotcpu_notifier

Neil Brown:
  o md: rationalise device selection in md/multipath
  o md: make sure md_check_recovery will remove a faulty device when
    ->nr_pending hits 0
  o md: allow an md personality to refuse a hot-remove request
  o md: make sure the size of a raid5/6 array is a multiple of the
    chunk size
  o md: abort the resync of raid1 there is only one device
  o md: allow md arrays to be resized if devices are large enough
  o md: support reshaping raid1 arrays - adding or removing drives
  o md: fix BUG in raid5 resync code

Nick Piggin:
  o sched: improve wakeup-affinity

Nicolas Pitre:
  o [ARM PATCH] 1896/2: distinguish between memory and LCD clock on PXA
  o [ARM PATCH] 1910/1: rework Mainstone and IDP include files

Olaf Hering:
  o ppc64: kernel Makefile options for $(AS)
  o ppc64: update info about available iseries_veth interfaces
  o [NET]: Fix compat bug in recvmsg/sendmsg wrt MSG_CMSG_COMPAT

Olaf Kirch:
  o kNFSd: Fix nfs3 dentry encoding

Oliver Heilmann:
  o [AGPGART] SIS AGP updates

Pat Gefre:
  o ia64: for SN2, disable MST errors on probe

Patrick J. LoPresti:
  o Better names for EDD legacy_* fields
  o Use decimal instead of hex for EDD values

Paul Clements:
  o md: handle hot-add for arrays with non-persistent superblocks

Paul Fulghum:
  o synclinkmp.c driver init modifications
  o synclink_cs.c driver init modifications
  o synclink.c driver init modifications

Paul Jackson:
  o ia64: uninline find_next_bit on ia64

Paul Mackerras:
  o ppc64: fix missing RELOCs, add linux,phandle property
  o ppp ldisc close deadlock prevention
  o ppc32: Add _raw_write_trylock
  o ppc32: Don't synchronize in disable_irq() if no handler
  o ppc32: Suppress bogus info in /proc/ppc_htab on 64-bit cpus
  o ppc32: Use -fPIC instead of -mrelocatable-lib
  o ppc32: Make ppc32 PCI code more robust
  o ppc32: Fix preemptible check
  o ppc32: Reduce WARN_ON(0) to nothing
  o ppc32: Fix locks.c properly this time
  o ppc64: don't clear MSR.RI in do_hash_page_DSI
  o ppc32: Fix typo in ppc32 spinlock.h

Paul Slootman:
  o floppy minor number fix

Peter Osterlund:
  o Avoid excessive stack usage in NFS

Piotr Kaczuba:
  o make vram boot option actually work

Pádraig Brady:
  o [WATCHDOG] v2.6.6 w83627hf_wdt.c-patch

Rob Melby:
  o evdev.c

Russell King:
  o [ARM] Add two more missing __user annotations for sparse
  o [PCMCIA] Fix up SOC PCMCIA socket timing calculations
  o [ARM] Eliminate meminfo 'end' element
  o [ARM] Correct permissions on several ARMv6 files
  o [ARM] Update ARM memory region reservations
  o [ARM] Fix missing spinlock initialisation
  o [ARM] asm_do_IRQ takes an unsigned IRQ number
  o Fix loop device cache handling
  o Export swapper_space
  o [ARM] Don't include lubbock.h in asm/arch/hardware.h
  o [PCMCIA] Add sparse annotations to ds.c
  o [ARM] Uninline flush_dcache_page()
  o [ARM] Update mach-types

Rusty Russell:
  o Export kthread primitives
  o fix sysfs node cpumap for large NR_CPUS

Sridhar Samudrala:
  o [SCTP] Fix the use of cached non-zero vtag in an INIT that is
    resent after a stale cookie error.
  o [SCTP] Fix missing VTAG validation on certain incoming packets
  o [SCTP] Fix to wakeup blocking connect() after max INIT retries
    failed
  o [SCTP] Fix poll() on a 1-1 style socket so that it returns when the
    association is aborted by peer.

Stephen D. Smalley:
  o selinux: check processed security context length

Stephen Hemminger:
  o [TCP]: Common code for generating tcp_info

Stephen Rothwell:
  o ppc64: iSeries default config update
  o ppc64: iSeries virtual ethernet minor optimisation
  o ppc64: iSeries fix virtual ethernet transmit block

Takashi Iwai:
  o input: Fix oops in hiddev

Todd E. Johnson:
  o input: Microtouch USB driver update Changed reset from standard USB
    dev reset to vendor reset Changed data sent to host from
    compensated to raw coordinates Eliminated vendor/product module
    params Performed multiple successfull tests with an EXII-5010UC

Tom 'spot' Callaway:
  o [SBUS]: Stop using drivers/scsi/{scsi,hosts}.h in drivers

Tony Lindgren:
  o [ARM PATCH] 1902/1: OMAP update 1/3: entry-armv.S

Toshihiro Kobayashi:
  o [ARM PATCH] 1911/1: fix of odd PMD handling in
    do_translation_fault()

Vojtech Pavlik:
  o input: Chips passing MUX detection incorrectly due to USB Legacy
    support report MUX version 10.12, not 12.10. Fixed.
  o input: Profusion/ServerWorks chipset workaround in i8042.c for Ingo
    Molnar
  o input: Fix emulation of mouse reset (0xff) command
  o input: Check for IM Explorer mice even if IMPS check failed
  o input: Exclude tasklet changes to i8042.c

William Lee Irwin III:
  o use aio workqueue in fs/aio.c
  o correct use_mm()/unuse_mm() to use task_lock() to protect ->mm
  o use const in time.h unit conversion functions
  o aio: fix io_getevents() timer expiry setting

