Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318726AbSIPCZF>; Sun, 15 Sep 2002 22:25:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318734AbSIPCZE>; Sun, 15 Sep 2002 22:25:04 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:24071 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S318726AbSIPCY7>; Sun, 15 Sep 2002 22:24:59 -0400
Date: Sun, 15 Sep 2002 19:32:56 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Linux 2.5.35
Message-ID: <Pine.LNX.4.33.0209151926330.10806-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hmm.. Lots of threading work by Ingo Molnar, more merges with Andrew
Morton, and Rusty "trivial" Russell (because BK only holds one person
responsible the trivial patches get attributed to the original author, not
Rusty, but Rusty should get a special attribution for maintaining the set
of patches).

Oh, and Jeff Dike's UML is in.

ACPI, PPC, USB, Sparc etc updates.

		Linus


Summary of changes from v2.5.34 to v2.5.35
============================================

<ahaas@neosoft.com>:
  o designated initializer patches for fs_nfs

Andi Kleen <ak@suse.de>:
  o Because x86-64 also always reserves the kbd region, we must not
    call request_region() in i8042-io.h, like we don't for i386, alpha,
    etc.

Andrew Morton <akpm@digeo.com>:
  o writer throttling fix
  o pass the correct flags to aops->releasepage()
  o exact dirty state accounting
  o discontigmem code cleanup #1
  o discontigmem code cleanup #2
  o reduce the default dirty memory thresholds
  o buffer_head takedown for bighighmem machines
  o rmap pte_chain speedup and space saving
  o resurrect CONFIG_HIGHPTE
  o readv/writev speedup
  o Use a sync iocb for generic_file_read

<berny.f@aon.at>:
  o typo: include_linux_pci_ids.h s_DEVIDE_DEVICE

<bmatheny@purdue.edu>:
  o Lexar USB CF Reader

<celso@bulma.net>:
  o drivers_net_pcmcia_fmvj18x_cs.c save_flags unsigned check
  o drivers_net_arcnet_arcnet.c save_flags unsigned check
  o drivers_net_hamradio_scc.c save_flags unsigned check
  o drivers_net_3c505.c save_flags unsigned check
  o drivers_net_pcmcia_3c574_cs.c save_flags unsigned check
  o drivers_net_ni65.c save_flags unsigned check
  o drivers_net_de600.c save_flags unsigned check
  o drivers_net_pcmcia_aironet4500_cs.c save_flags unsigned check
  o drivers_net_pcmcia_smc91c92_cs.c
  o drivers_net_at1700.c save_flags unsigned check

<defouwj@purdue.edu>:
  o net/ipv4/ip_options.c: IPOPT_END padding needs to increment optptr

<drow@false.org>:
  o Typo in do_syslog/__down_trylock lockup fix

<fokkensr@fokkensr.vertis.nl>:
  o USER_HZ & NTP problems

<fzago@austin.rr.com>:
  o [PATCH] (repost) fix for big endian machines in scanner.c

<james@cobaltmountain.com>:
  o Typos in drivers_s390_net_iucv.h
  o drivers_scsi_aic7xxx_aic7xxx_core.c, typo: the the

<jblack@linuxguru.net>:
  o Toshiba.c IRQ Patch (Christoph Hellwig eats people?)

Jeff Dike <jdike@karaya.com>:
  o UML arch (user-mode Linux)

<johann.deneux@it.uu.se>:
  o A small documentation update and a unused constant removal

<lopezp@grupocp.es>:
  o usbmidi patch

<lucasvr@terra.com.br>:
  o 2.5.31_drivers_char_lp.c

<maalanen@ra.abo.fi>:
  o [patch, 2.5] fix errorpath in apne.c
  o [patch 2.5] at1700 trivial

<mlang@delysid.org>:
  o HandyTech HandyLink patch

<pe1rxq@amsat.org>:
  o USB: se401 driver update

<petkan@users.sourceforge.net>:
  o USB: pegasus driver patch

<rct@gherkin.frus.com>:
  o 2.5.X config: USB speedtouch driver

<rz@linux-m68k.org>:
  o Few small fixes for Q40 keyboard support

<sam@ravnborg.org>:
  o ftape EXPORT_SYMBOL damage clean-up
  o zftape: Cleanup zftape_syms.c
  o drivers/char/Makefile: Remove pty.o from export-objs

<skip.ford@verizon.net>:
  o 2.5.34 ufs/super.c
  o Comment fix asm-i386_hardirq.h
  o include/asm-sparc/hardirq.h: Fix comment

<stern@rowland.harvard.edu>:
  o USB storage: abort bug fix

<willy@debian.org>:
  o sleeping file locks
  o Remove unused Config.help
  o remove SERIAL_IO_GSC

<zubarev@us.ibm.com>:
  o IBM PCI Hotplug driver update
  o IBM PCI Hotplug driver update for ISA based controllers
  o IBM PCI Hotplug driver update for PCI based controllers

<zwane@mwaikambo.name>:
  o pci_free_consistent on ohci initialisation failure

Adam J. Richter <adam@yggdrasil.com>:
  o The following patch shaves a six bytes from the loaded size
  o Building list of drives in right order

Alexander Viro <viro@math.psu.edu>:
  o Missing IDE partition 3 of 3 on 2.5.34

Andries E. Brouwer <Andries.Brouwer@cwi.nl>:
  o Feiya 5-in-1 Card Reader

Andy Grover <agrover@groveronline.com>:
  o ACPI trivial cleanups (Kochi Takayoshi)
  o By John Belmonte - improvements to Toshiba ACPI driver
  o ACPI Config.in update by Christoph Hellwig
  o Remove obsolete OSL functions (Kochi Takayoshi)
  o ifdef some arch-specific ACPI code
  o ACPI: Remove interpreter debugger and kdb directories. These
    ultimately didn't prove useful enough to be used on a regular
    basis.
  o ACPI: Do not do certain bits of APIC config if CONFIG_ACPI_HT_ONLY
    is set
  o ACPI: Do not compile functions not used in HT_ONLY mode
  o ACPI: Fix possible sleeping at interrupt context (Matthew Wilcox)

Anton Blanchard <anton@samba.org>:
  o ppc64: remove some unnecessary sign extensions
  o ppc64: remove ancient stat syscalls
  o ppc64: add mmap64 support
  o ppc64: add sendfile64 support and restore ioperm syscall
  o ppc64: Dont force O_LARGEFILE on for 32 bit apps. From sparc64
  o ppc64: merge in changes from x86 irq balance code
  o ppc64: Update the fake pci read code to handle a return of all 1s
  o ppc64: Fix sys32_readahead wrapper to obey ABI wrt passing long
    longs
  o ppc64: remove status, no longer used
  o ppc64: Remove use of <asm/smplock.h>
  o ppc64: remove some old code
  o ppc64: clean up syscall table, making it obvious which are obsolete
    and which are 32 bit only
  o ppc64: Remove old keyboard code
  o ppc64: fixes for 2.5.32
  o hvc_console: stop HVC console while xmon is running
  o ppc64: make udelay a barrier, fixes problem with input layer
    keyboard probing
  o ppc64: defconfig update
  o ppc64: config.in cleanup
  o ppc64: Add security and AIO syscalls ppc64: copy FE0 and FE1 bits
    into MSR when ptracing ppc64: warn when registering duplicate
    ioctls
  o ppc64: Compile in LLC, needed for token ring
  o ppc64: turn off token ring for the moment, it oopses
  o ppc64: add arg to do_fork and fix ELF_AUX entries as done in ppc32
  o ppc64: INIT_SIGNALS fix
  o ppc64: add rwlock_is_locked
  o ppc64: xtime.tv_nsec fixes
  o ppc64: DISCONTIGMEM updates, rework to be like x86 version
  o ppc64: add in_atomic
  o ppc64: updates from Rochester
  o ppc64: EEH update from Todd Inglett
  o ppc64: Allocate RTAS above OF, from Peter Bergner
  o ppc64: new pci config methods, from Todd Inglett
  o ppc64: updates from Rochester
  o ppc64: UP compile fixes

Arnaldo Carvalho de Melo <acme@conectiva.com.br>:
  o LLC: small cleanups, leave debug on for a while
  o LLC: tcpfying the beast
  o LLC: sys_listen already checks for backlog > SOMAXCONN
  o LLC: llc_build_and_send_pkt
  o LLC: kill llc_prim_data and LLC_PRIM_DATA for sap->ind() and
    sap->conf()
  o [LLC] split llc_pdu_router into llc_{station,sap,conn}_rcv
  o [LLC] llc_ui_wait_for_data and socket locking fixes
  o [LLC] use llc_mac_{match,null} in more places
  o [LLC] turn tons of simple pdu functions into returning void
  o [LLC] use just one struct sock per connection
  o LLC: llc_lookup_listener
  o [LLC] llc_establish_connection & LLC_CONN_PRIM bits the bucket
  o [LLC] llc_send_disc & LLC_DISC_PRIM bites the dust
  o [LLC] add missing kfree_skb in llc_conn_state_process
  o [LLC] remove unsupported flowcontrol prim bits
  o [LLC] save sockaddr_llc info in connection packets
  o [LLC] kill sap->req()
  o [LLC] remove all tmr ev structs & fix psnap and p8022 wrt ui
    sending

Brad Hards <bhards@bigpond.net.au>:
  o header cleanup - drivers_char_dz.c
  o header cleanup - drivers_char_serial_tx3912.c
  o Re: header cleanup - drivers_ieee1394_sbp2.c
  o Change "D: Drivers=" to "H: Handlers=" in /proc/bus/input/devices

Chris Wright <chris@wirex.com>:
  o 2.5.34 kernel-api DocBook fix

Dave Kleikamp <shaggy@kleikamp.austin.ibm.com>:
  o Bump up JFS_LINK_MAX from 64K to 4G
  o Extended attribute fixes for JFS
  o JFS: add permission checks before getting or setting xattrs
  o JFS: cleanup -- Remove excessive typedefs

David Brownell <david-b@pacbell.net>:
  o uhci, doc + cleanup
  o Re: [patch 2.5.31-bk5] uhci, misc
  o ehci locking
  o Re: updated ehci patch
  o ohci-hcd endpoint scheduling, driverfs
  o usbnet, add YOPY device IDs
  o [PATCH 2.5.33+] ohci and iso-in
  o usbnet, Epson client
  o ehci misc fixes
  o ehci, async idle timout

David S. Miller <davem@nuts.ninka.net>:
  o [TIGON3]: Merge to version 1.1
  o [TIGON3] Initial TCP segmentation offload support
  o [TIGON3] Fix typos in TSO changes
  o [TIGON3]: Force use of PCI config space reg writes when loading
    firmare
  o [TIGON3]: Disable TSO for now, tso firmware can hang tx cpu
  o [TCP]: Delay tstamp state commit in input fast path until we verify
    csum
  o [TIGON3]: Do not reference vlgrp unless TG3_VLAN_TAG_USED is set
  o [TIGON3]: Fix slight perf regression from TSO changes
  o [VLAN] Use unregister_netdevice to prevent rtnl double-lock
  o [TIGON3]: New way to flush posted writes of GRC_MISC_CFG
  o [NAPI]: Do not check netif_running() in netif_rx_schedule_prep
  o [NAPI]: Set SCHED before dev->open, clear if fails.  Restore
    netif_running check to netif_rx_schedule_prep
  o [TIGON3]: Use spin_lock_irqsave in tg3_interrupt, fixes SMP hang
  o [TIGON3]: Add 5704 support
  o [TIGON3]: GRC_MISC_CFG_BOARD_ID_5704CIOBE is wrong
  o kernel/signal.c: Not all systems have SIGSTKFLT
  o [SPARC]: Catchup with signal infrastructure changes
  o [SPARC]: pcibios_enable_device has new mask argument
  o [SPARC64]: timespecs now have tv_nsec in place of tv_usec
  o [SPARC64]: Delete do_gettimeofday asm
  o [SPARC]: Update ide headers.  WARNING: this is known broken, fixes
    coming from Jens Axboe
  o [SPARC64]: Add rwlock_is_locked and in_atomic
  o arch/sparc64/defconfig: Update
  o arch/sparc/kernel/check_asm.sh: Handle output from newer versions
    of GCC
  o [SPARC]: Add rwlock_is_locked
  o [SPARC]: Add is_atomic
  o [SPARC]: Update for tv_nsec in xtime
  o [SPARC]: Add irqs_disabled
  o [SPARC]: Add kmap_atomic_to_page
  o [SPARC]: Add sys_exit_group syscall entries
  o [LLC]: Fix build bustage

franz.sirl-kernel@lauterbach.com <Franz.Sirl-kernel@lauterbach.com>:
  o I needed this small patch if i8042.c is built as a module. Franz

Greg Kroah-Hartman <greg@kroah.com>:
  o USB: remove __NO_VERSION__
  o USB: clean up the error path in create_special_files() for usbfs
  o Compaq PCI Hotplug driver: fixed __FUNCTION__ usages
  o PCI: hotplug core cleanup to get pci hotplug working again
  o PCI: export pci_scan_bus() as the IBM PCI Hotplug driver needs it
  o PCI Hotplug: remove pci_*_nodev() prototypes as the functions are
    gone
  o Compaq PCI Hotplug driver: changed calls to pci_*_nodev() to
    pci_bus_*()
  o IBM PCI Hotplug driver: changed calls to pci_*_nodev() to
    pci_bus_*()
  o USB: compile time fix for previous kaweth patch

Ingo Molnar <mingo@elte.hu>:
  o Re: do_syslog/__down_trylock lockup in current BK
  o exit.c compilation warning fix
  o sys_exit_group(), threading, 2.5.34
  o Thread deadlock fix
  o ptrace-fix-2.5.34-A2, BK-curr
  o sys_exit() threading improvements, BK-curr
  o NMI watchdog SMP fix
  o thread exit deadlock bug
  o signal failures in nightly LTP test
  o hide-threads-2.5.34-C1
  o wait4-fix-2.5.34-A0, BK-curr
  o clone-fix-2.5.34-A0, BK-curr
  o detached-fix-2.5.34-A0, BK-curr
  o exit-thread-2.5.34-A0, BK-curr
  o wait4-fix-2.5.34-B2, BK-curr
  o exit-fix-2.5.34-C0, BK-curr
  o thread-exec-2.5.34-B1, BK-curr
  o thread exec fix, BK-curr

Ivan Kokshaysky <ink@jurassic.park.msu.ru>:
  o alpha update

Jens Axboe <axboe@suse.de>:
  o Move around IDE files to match 2.4.20-pre5-ac4 layout. Do this
    before applying patches, for clarity and for keeping bk revision
    history.
  o Add Makefile's for the new arm/ legacy/ pci/ pci/ directories
  o update IDE to 2.4.20-pre5-ac4
  o ide_map_buffer() and ide_unmap_buffer() could cause imbalanced
    calls to bio_kmap/kunmap_irq(), which would screw the preemption
    count. pass in rq to ide_unmap_buffer() as well to make the right
    decision.
  o PCI individual resource handling
  o blk_fs_request()
  o IDE pci ids
  o hdreg command updates etc

Juan Quintela <quintela@mandrakesoft.com>:
  o Grammatical fixes

Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>:
  o kbuild: Fix up non-verbose mode
  o kbuild: Fix copying of shipped files
  o kbuild: Use normal rule for preprocessing vmlinux.lds.S

Linus Torvalds <torvalds@transmeta.com>:
  o Get Intel model name from the CPU
  o atari_rootsec.h moved to fs/partitions/atari.h, but somehow the
    version in include/linux didn't get deleted.
  o The scheduler should complain not just about interrupts, but also
    about being called whenever we're holding any
  o Oops, lost ID in 2.4.x merge
  o Missing <linux/version.h>, yet testing the kernel version
  o Make sure MTRR setting is atomic on SMP, since
  o Use CLONE_KERNEL for the common kernel thread flags
  o Never _ever_ BUG() if you don't have to Cset exclude:
    greg@kroah.com|ChangeSet|20020905153320|19047
  o Allocate system call numbers: 250 and 251 for hugetlb, with 252 for
    exit_group

Matthew Dharm <mdharm-usb@one-eyed-alien.net>:
  o usb-storage: fix software eject

matt_domsch@dell.com <Matt_Domsch@dell.com>:
  o Domsch zip code change

Mikael Pettersson <mikpe@csd.uu.se>:
  o 2.5.34 floppy driver init/exit fixes
  o undo 2.5.34 ftape damage

Neil Brown <neilb@cse.unsw.edu.au>:
  o md - 1 of 3 - Remove BUG in md.c that change in 2.5.33 triggers
  o md - 2 of 3 - Fix bug in raid5 AGAIN
  o md - 3 of 3 - Fix compile errors when tracing enabled in MD
  o kNFSd 1: New structure initialisers for lockd
  o kNFSd 2: Lockd to shutdown without engaging with nfsd
  o kNFSd 3: Increase separation between lockd and nfsd
  o kNFSd 4: Discard svc_uidmap structure
  o kNFSd 5: Get rid of ex_parent from svc_export
  o kNFSd 6: Expose anon uid and gid in /proc/fs/nfs/exports
  o kNFSd 7: Discard cl_idlen
  o kNFSd 8: Don't store path in exports table
  o kNFSd 9: Discard cl_addr
  o kNFSd 10: Discard ex_dev and ex_ino from svc_export
  o kNFSd 11: Remove problematic "security" checks when NFS exporting
  o kNFSd 12: Change exp_parent to talk directory tree, not hash table
  o kNFSd 13: Separate out the multiple keys in the export hash table
  o kNFSd 14: Filehandle lookup makes use of new export table structure
  o kNFSd 15: Unite per-client export key hash tables
  o kNFSd 16: Remove per-client list of exports
  o md - Fix problems with freeing gendisk in md.c
  o cset 1.497.59.25 breaks MD autodetect

Oliver Neukum <oliver@neukum.name>:
  o fix for error handling in microtek
  o new ids for hpusbscsi
  o open/close fix for kaweth
  o fixes for races in kaweth probe

oliver.neukum@lrz.uni-muenchen.de <Oliver.Neukum@lrz.uni-muenchen.de>:
  o two byte offset for kaweth

Patrick Mochel <mochel@osdl.org>:
  o Re: Performance issue in 2.5.32+
  o Reorganize the mtrr init sequence a bit. All mtrr init now happens
    during the initcall sequence, after all CPUs have been brought up. 

Paul Mackerras <paulus@samba.org>:
  o PPC32: Use vunmap rather than vfree in iounmap
  o PPC32: Update the PCI config-space access functions for PReP
  o PPC32: rearrange includes in arch/ppc/kernel/irq.c to fix a compile
    error
  o PPC32: extra argument for pcibios_enable_resources/device
  o PPC32: add argument to INIT_SIGNALS use in
    arch/ppc/kernel/process.c
  o PPC32: convert xtime usage from timeval to timespec
  o PPC32: define atomic_add_negative
  o PPC32: allocate syscall #s for alloc/free_hugepages and exit_group
    and add exit_group to the syscall table.
  o PPC32: remove the ppc32-specific ide_fix_driveid
  o PPC32: define kmap_atomic_to_page
  o PPC32: remove unused IDE functions from include/asm-ppc/ide.h
  o PPC32: define rwlock_is_locked()

Pete Zaitcev <zaitcev@redhat.com>:
  o arch/sparc/config.in: Add missing parts for modern fashion configs
  o arch/sparc/defconfig: Supply working defconfig to show what is
    working, what is not
  o [SPARC]: Kill remaining remnants of kgdb support
  o [SPARC64]: Cleanup serial_console declarations
  o [SPARC]: Get 2.5.x building once more
  o drivers/serial/sunzilog.c: Fix build of sparc32 probing code
  o [SPARC] sparc 2.5.x again

Peter Samuelson <peter@cadcamlab.org>:
  o remove duplicated AGP Config.in

Petr Vandrovec <vandrove@vc.cvut.cz>:
  o 2.5.34: recalc_sigpending missing for modules
  o 2.5.34-bk fcntl lockup

Randy Dunlap <rddunlap@osdl.org>:
  o 2.5.31 spell_typo fix

Russell King <rmk@arm.linux.org.uk>:
  o 2.5.32-usb

Rusty Russell <rusty@rustcorp.com.au>:
  o Designated initializers for shm
  o Designated initializers for cs46xx drivers

Stephen Rothwell <sfr@canb.auug.org.au>:
  o cdrom.c is the only file to include asm/fcntl.h

Vojtech Pavlik <vojtech@suse.cz>:
  o This fixes problems in serport.c found by Russell King


