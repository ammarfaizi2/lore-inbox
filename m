Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262569AbSJGS62>; Mon, 7 Oct 2002 14:58:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262574AbSJGS62>; Mon, 7 Oct 2002 14:58:28 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:33796 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S262569AbSJGS6G> convert rfc822-to-8bit; Mon, 7 Oct 2002 14:58:06 -0400
Date: Mon, 7 Oct 2002 12:02:59 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Linux v2.5.41
Message-ID: <Pine.LNX.4.33.0210071157270.1917-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
X-MIME-Autoconverted: from 8bit to quoted-printable by deepthought.transmeta.com id g97J3dA15742
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Tons of stuff. Mucho merges with the "A-Team" (Alan, Al, Alexey, Andrew,
Anton, Arjan, Arnaldo and Art), but the "M-Team" (Maksim, Marcel, Martin's
and Mike) is a close runner up. The J's are doing well too.

		Linus "Go L, go L" Torvalds

----

Summary of changes from v2.5.40 to v2.5.41
============================================

Alan Cox <alan@lxorguk.ukuu.org.uk>:
  o 2.5 trivial - MCA comments
  o disable GMX2000
  o PC110 pad docs are wrong
  o Forward port AMD random number generator
  o 2.5 Fix set_bit abuse in ATP driver
  o move tulip into ethernet 10,100
  o aacraid driver for 2.5
  o forward port toughbook fixes for maestro3
  o fix warning in longhaul.c
  o update docs to match maestro3 changes
  o flush the right thing in the rd cache
  o Clean up sf16fmi radio
  o Fix cs89x0 warnings
  o NCR5380 port to 2.5 first pass
  o Fix stupid scsi setup bug in 53c406, fix addressing
  o first pass at the ancient wd7000 crap
  o bring telephony in line with 2.4
  o add the mini 4x6 font from uclinux
  o make jffs/jffs2 work with signal changes
  o 6x4 font headers
  o sane minimum proc count

Alexander Viro <viro@math.psu.edu>:
  o pd switched to dynamic allocation
  o pd.c cleanups
  o mtd switched to dynamic allocation
  o md switched to dynamic allocation
  o old cdroms switched to dynamic allocation
  o loop.c switched to dynamic allocation
  o rd.c switched to dynamic allocation
  o hd.c switched to dynamic allocation
  o floppy.c switched to dynamic allocation
  o pcd switched to alloc_disk()
  o initrd fix (missing set_capacity)
  o umem switched to alloc_disk()
  o ps2esdi switched to alloc_disk()
  o xd switched to alloc_disk()
  o acorn mfm switched to alloc_disk()
  o i2o switched to alloc_disk()
  o stram/z2ram switched to alloc_disk()
  o nbd switched to alloc_disk()
  o dasd switched to alloc_disk()
  o ubd switched to alloc_disk()
  o swim* switched to alloc_disk()
  o jsflash switched to alloc_disk()
  o xpram switched to alloc_disk()
  o atari floppy switched to alloc_disk()
  o amiga floppy switched to alloc_disk()
  o acorn floppy switched to alloc_disk()
  o paride floppy switched to alloc_disk()
  o DAC960 switched to alloc_disk()
  o cciss.c switched to use of alloc_disk()
  o fix of bug in previous DAC960 patch
  o cpqarray switched to alloc_disk()
  o acsi switched to alloc_disk()

Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>:
  o net/ipv6/mcast.c: Handle IPV6_LEAVE_GROUP with ipv6mr_interface==0

Andrew Morton <akpm@digeo.com>:
  o misc (mainly documentation)
  o sys_ioperm atomicity fix
  o mprotect bugfix
  o remove bogus BUG in page_remove_rmap()
  o radix tree gang lookup
  o truncate/invalidate_inode_pages rewrite
  o add /proc/vmstat (start of /proc/stat cleanup)
  o add kswapd success accounting to /proc/vmstat
  o "io wait" process accounting
  o convert direct-io to use bio_add_page()
  o fix /proc/vmstat:pgpgout/pgpgin
  o hugetlb kmap fix
  o remove debug code from list_del()
  o distinguish between address span of a zone and the number
  o truncate fixes
  o O_DIRECT invalidation fix
  o mempool wakeup fix
  o separation of direct-reclaim and kswapd functions
  o fix reclaim for higher-order allocations
  o use bio_get_nr_vecs() hint for pagecache writeback
  o Documentation/filesystems/ext3.txt
  o use bio_get_nr_vecs() for sizing direct-io BIOs
  o remove write_mapping_buffers()
  o use buffer_boundary() for writeback scheduling  hints
  o remove page->virtual
  o stricter dirty memory clamping
  o clean up ll_rw_block()
  o smbfs compile fix

Anton Blanchard <anton@samba.org>:
  o 64-bit timer fix

Arjan van de Ven <arjanv@redhat.com>:
  o Remove sys_call_table export

Arnaldo Carvalho de Melo <acme@conectiva.com.br>:
  o LLC: remove unused mac_dev_peer
  o LLC: grab the skb in llc_conn_state_event, use llc_pdu_sn_hdr
  o LLC: kill llc_conn_free_ev, use plain kfree_skb instead
  o LLC: start using seq_file for proc stuff
  o LLC: now it only uses seq_file for proc stuff
  o IPX: use seq_file for proc stuff
  o X25: use seq_file for proc stuff
  o X25: fix permission bogosity in create_proc_entry usage
  o Appletalk: use seq_file for proc stuff

Art Haas <ahaas@neosoft.com>:
  o C99 designated initializers for include/linux/isapnp.h
  o [IPV4/IPV6]: C99 designated initializers

Ben Collins <bcollins@debian.org>:
  o IEEE1394 updates to 2.5.40
  o More 1394 updates

Bjorn Andersson <bjorn.andersson@erc.ericsson.se>:
  o net/8021q/vlan_dev.c: Fix lockup when setting egress priority

Brian Gerst <bgerst@didntduck.org>:
  o struct super_block cleanup - hpfs
  o struct super_block cleanup - ext3
  o unistd.h cleanups

Christer Weinigel <christer@weinigel.se>:
  o Updated NatSemi SCx200 patches for Linux-2.5

Christoph Hellwig <hch@dhcp212.munich.sgi.com>:
  o XFS: temporarily switch to schedule_task for I/O completion
  o XFS: remove description of mount option not in mainline

Christoph Hellwig <hch@sgi.com>:
  o XFS updates for workqueues
  o workqueue flush on destroy
  o no more flush_workqueue in xfs
  o Remove some more devfs crap

Chuck Lever <cel@citi.umich.edu>:
  o add struct file* to ->direct_IO addr space op
  o remove NFS client internal dependence on page->index
  o initial support for NFS direct I/O for 2.5

Daisy Chang <daisy@teetime.dynamic.austin.ibm.com>:
  o sctp: Added the 'Unrecognized Parameter' handling
  o Remove excessive spaces
  o Remove more excessive spaces

Dave Kleikamp <shaggy@kleikamp.austin.ibm.com>:
  o JFS: Releasing LOGGC_LOCK too early

David Brownell <david-b@pacbell.net>:
  o USB: framework for testing usbcore
  o pci/pool.c less spinlock abuse

David S. Miller <davem@nuts.ninka.net>:
  o [EQL]: Rewrite to be SMP safe
  o net/sctp/inqueue.c: Convert to work queue
  o net/ipv6/route.c: Fix typo in previous change
  o net/ipv6/ipv6_sockglue.c: Support IPV6_ADDRFORM getsockopt
  o [SPARC64]: header cleanup, extern inline --> static inline
  o include/asm-sparc64/pstate.h: Kill asm routines, nobody uses them
  o [SPARC]: Update for dequeue_signal changes
  o [SPARC]: Uninline kmap atomic operations
  o arch/sparc64/defconfig: Update
  o [VLAN]: Accept zero vlan at unregister
  o arch/sparc64/mm/init.c: Initialize {min,max}_low_pfn and max_pfn
    properly
  o net/core/dev.c: Print lethal dev/protocol errors with KERN_CRIT
  o net/8021q/vlan.c: Unsigned value may never be < 0

David S. Miller <davem@redhat.com>:
  o USB: usbkbd fix

Florian Thiel <florian.thiel@gmx.net>:
  o Documentation/networking/tuntap.txt: Completely rework, this
    document was much outdated

GOTO Masanori <gotom@debian.or.jp>:
  o NinjaSCSI-32Bi/UDE PCI/Cardbus SCSI core driver
  o NinjaSCSI-32Bi/UDE PCI/Cardbus SCSI driver incidentals

Greg Kroah-Hartman <greg@kroah.com>:
  o USB: speedtouch driver fix due to ioctl function parameter change
  o hotplug: fix for non-pci and usb calls
  o USB: split the usb serial console code out into its own file
  o PCI: remove pcibios_find_class()
  o PCI: remove pci_find_device()
  o PCI: removed pcibios_present()
  o PCI: fixed remaining usages of pcibios_present() that I missed
    previously
  o PCI: remove usages of pcibios_find_class()
  o PCI: remove pcibios_find_device() from the 53c7,8xx.c SCSI driver

Hideaki Yoshifuji <yoshfuji@linux-ipv6.org>:
  o [IPv6]: Rework default router selection
  o [IPV4/IPV6]: General cleanups

Hugh Dickins <hugh@veritas.com>:
  o Oracle startup split_vma fix
  o tmpfs swapoff deadlock
  o cleanup of page->flags manipulations
  o shmem_rename() fixes
  o tpmfs: fake a non-zero size for directories
  o tmpfs: minor fixes
  o add shmem_vm_writeback()
  o shmem truncate race fix
  o shmem: remove info->sem
  o consolidate shmem_getpage and shmem_getpage_locked
  o shmem: avoid metadata leakiness
  o put shmem metadata in highmem
  o shmem accounting fixes
  o shmem: misc changes and cleanups
  o shmem whitespace cleanups

Ingo Molnar <mingo@elte.hu>:
  o Workqueue Abstraction
  o dump_stack() cleanup, BK-curr
  o futex-2.5.40-B5
  o sigfix-2.5.40-D6
  o timer-2.5.40-F7
  o workqueue lossage (fwd)

Ivan Kokshaysky <ink@jurassic.park.msu.ru>:
  o alpha compile fixes

James Bottomley <jejb@mulgrave.(none)>:
  o first cut at fixing unable to requeue with no outstanding commands
  o add cache synchronisation to sd
  o remove mid-layer assumption that devices must be able to queue at
    least one command
  o [PATCH SCSI] make BUSY status stall the device for a while
  o [SCSI] remove debugging from zero depth queue handling
  o [SCSI] remove comment that every host is expected to be able to
    queue at least one command
  o [SCSI] tidy up sd synchronize cache messages into a single line
  o [SCSI] sd moved synchronisation from release to detach

Jaroslav Kysela <perex@suse.cz>:
  o ALSA update [1-12] - 2002/08/09-2002/10/01
  o ALSA fixes
  o fix sgalaxy.c driver cli/sti code

Jeff Garzik <jgarzik@mandrakesoft.com>:
  o Fix natsemi net drvr build, s/KERN_WARN/KERN_WARNING/
  o airo wireless netdrvr: s/routine/func/ to fix build (wq-related
    breakage)

Jens Axboe <axboe@suse.de>:
  o deadline updates
  o ide-cd updates
  o ide config.in
  o cleanup taskfile submit
  o remove _P/_p delaying iops
  o ide low level driver updates
  o pass elevator type by reference, not value
  o ide io port types

Jochen Karrer <cip307@cip.physik.uni-wuerzburg.de>:
  o USB: string query fix

Jon Grimm <jgrimm@touki.austin.ibm.com>:
  o sctp:  mark functions needed by testsuite as SCTP_STATIC
  o sctp:  Fix GFP_KERNEL allocation with lock held
  o sctp: Fix GFP_KERNEL allocation with lock held
  o sctp:  Fix bug where we were erroneously throwing away packets >
    frag_point. (jgrimm)
  o sctp:  Cleanup 'sacked' queue upon teardown.  (jgrimm)

Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>:
  o NET: Do not use dev->hard_header_len in eth_header()
  o NET: Do not use dev->hard_header_len in eth_type_trans()
  o ISDN: Use a skb queue instead of open coded solution in isdn_ppp.c
  o ISDN: More moving of per-channel stuff into isdn_net_dev
  o ISDN: More sorting out of members for isdn_net_local / isdn_net_dev
  o ISDN: adapt to task queue changes
  o ISDN: Use list.h list for list of online channels
  o Cset exclude:
    kai@tp1.ruhr-uni-bochum.de|ChangeSet|20020929194514|33195
  o kbuild: Small cleanups
  o kbuild: Remove xfs vpath hack
  o kbuild: Standardize ACPI Makefiles
  o kbuild: Small quirks for separate obj / src trees
  o kbuild: Add some bug traps
  o kbuild: Handle $(core-y) the same way as $(init-y), $(drivers-y)
    etc
  o kbuild: Use $(core-y) and friends directly
  o kbuild: Always build helpers in script/
  o kbuild: Don't cd into subdirs during build
  o kbuild: include arch-Makefile in common place
  o kbuild: Adapt mrproper targets
  o ISDN: Alloc isdn_net_dev and struct net_device separately
  o ISDN: Use generic eth_type_trans()
  o ISDN: Separate hard_start_xmit() for different types of ISDN net
    devices
  o ISDN: Make hard_start_xmit() device type specific
  o kbuild: Fix build with modversions
  o kbuild: small fixes
  o kbuild: Nicer warnings
  o kbuild: Don't descend into arch/i386/boot
  o kbuild: Put .bss back to the end of vmlinux
  o ISDN: New file for net interface config and basic setup
  o ISDN: Convert remaining users of the old slave list
  o ISDN: split isdn_net state machine
  o kbuild: fix make -jN warnings
  o ISDN: Reuse the dial_timer for idle hangup
  o kbuild: Fix arch/i386/boot clean targets
  o ISDN: Make idle timeout and retry wait parts of the state machine
  o Cset exclude:
    kai@tp1.ruhr-uni-bochum.de|ChangeSet|20021005215705|12351
  o kbuild: Fix kallsyms build
  o kbuild: Fix make clean in scripts/lxdialog
  o ISDN: tidy up isdn_net_log_skb()
  o ISDN: Replace rx_netdev, st_netdev by a single field
  o ISDN: Separate state machine actions into single functions
  o ISDN: Move call control to isdn_net_lib.c
  o ISDN: Make the state machine explicit
  o ISDN: Use a tasklet for the Eicon driver
  o ISDN: Extend state machine
  o ISDN: Allow for return values in the state machine

Kai Makisara <Kai.Makisara@kolumbus.fi>:
  o SCSI tape devfs & driverfs fix

Lennert Buytenhek <buytenh@gnu.org>:
  o [NET]: Remove net_call_rx_atomic
  o [BRIDGE]: Skip the LISTENING_STP state if STP is disabled
  o [BRIDGE]: take BR_NETPROTO_LOCK for unlinking bridge device slaves

Linus Torvalds <torvalds@home.transmeta.com>:
  o Update to DRI CVS tree
  o Fix sigio process lookup handling
  o Undo due to weird behaviour on various boxes Cset exclude:
    ink@jurassic.park.msu.ru|ChangeSet|20021003201553|58706
  o Use dump_stack() for the USB storage buffer size checking, to make
    it possible to track down.
  o Increase the delay in waiting for pcmcia drivers to register
  o Make wildcard dependency filenames be relative, not absolute
  o Don't add the $(obj) prefix twice
  o bitmap_member() => DECLARE_BITMAP()
  o Add <linux/linkage.h> include to get FASTCALL() define
  o IO scheduler is a subsystem, not a driver. Initialize it as such
  o Oops, it's 'xxx_initcall()', not 'xxx_init()' (except for the
    legacy module_init(), just to confuse people).
  o Export the gdt table GPL-only for APM
  o Linux v2.5.41

Luc Van Oostenryck <luc.vanoostenryck@easynet.be>:
  o 2.5.40: warning fix for drivers/usb/core/usb.c

Maksim Krasnyanskiy <maxk@viper.(none)>:
  o Sync up Bluetooth core with 2.4.x
  o Bluetooth USB driver update
  o Syncup HCI UART driver with 2.4.x
  o BNEP (Bluetooth Network Encapsulation Protocol) support
  o RFCOMM protocol support
  o Fix designated initializers in RFCOMM TTY layer

Manfred Spraul <manfred@colorfullife.com>:
  o drivers/net/natsemi.c:  create a function for rx refill
  o drivers/net/natsemi.c: combine drain_ring and init_ring
  o drivers/net/natsemi.c: OOM handling
  o drivers/net/natsemi.c: stop abusing netdev_device_{de,a}ttach
  o drivers/net/natsemi.c: write MAC address back to the chip
  o drivers/net/natsemi.c: lengthen EEPROM timeout, and always warn
    about all timeouts
  o drivers/net/natsemi.c: comments update
  o pipe bugfix /cleanup

Marcel Holtmann <marcel@holtmann.org>:
  o Bluetooth kbuild fix and config cleanup

Martin Devera <devik@cdi.cz>:
  o net/sched/sch_htb.c: Check that node is really leaf before
    modifying cl->un.leaf

Martin Schwidefsky <schwidefsky@de.ibm.com>:
  o s390 update (1/27): arch
  o s390 update (2/27): include
  o s390 update (3/27): drivers
  o s390 update (4/27): syscalls
  o s390 update (5/27): ibm partition
  o s390 update (6/27): config
  o s390 update (7/27): dasd driver
  o s390 update (8/27): xpram driver
  o s390 update (9/27): bottom half removal
  o s390 update (10/27): bitops bug
  o s390 update (11/27): 31 bit emulation
  o s390 update (12/27): linker scripts
  o s390 update (13/27): preemption support
  o s390 update (14/27): inline optimizations
  o s390 update (15/27): 64 bit spinlocks
  o s390 update (16/27): timer interrupts
  o s390 update (17/27): beautification
  o s390 update (18/27): fpu registers
  o s390 update (19/27): ptrace cleanup
  o s390 update (20/27): signal quiesce
  o s390 update (21/27): sync i/o bug
  o s390 update (22/27): s390_process_IRQ
  o s390 update (23/27): channel paths
  o s390 update (24/27): boot sequence
  o s390 update (25/27): init call
  o s390 update (26/27): /proc/interrupts
  o s390 update (27/27): control characters
  o s390 dasd driver update

Matthew Wilcox <willy@debian.org>:
  o [NET]: Move common ioctl code up a layer
  o Remove another for_each_process loop

Mike Anderson <andmike@us.ibm.com>:
  o sg might_sleep fixes

Paul Mackerras <paulus@au1.ibm.com>:
  o pcmcia resource allocation fix

Pavel Machek <pavel@ucw.cz>:
  o Swsusp updates, do not thrash ide disk on suspend

Pete Zaitcev <zaitcev@redhat.com>:
  o mm/highmem.c: Include asm/tlbflush.h
  o arch/sparc/kernel/sun4d_irq.c: init_timers --> sparc_init_timers

Petko Manolov <petkan@users.sourceforge.net>:
  o USB: rtl8150 update
  o USB: pegasus update

Petr Vandrovec <vandrove@vc.cvut.cz>:
  o FAT/VFAT memory corruption during mount()

Richard Henderson <rth@twiddle.net>:
  o alpha strncpy fix

Russell King <rmk@flint.arm.linux.org.uk>:
  o [SERIAL] Allow PCMCIA serial cards to work again
  o [SERIAL] Fix serial includes for modversions/modules

Steven Whitehouse <steve@gw.chygwyn.com>:
  o Trivial fix to aio.c:__aio_get_req()

Tim Hockin <thockin@freakshow.cobalt.com>:
  o Add dp83816 support to drivers/net/natsemi.c
  o drivers/net/natsemi.c: janitorial - whitespace, wrap, and indenting
    cleanup
  o drivers/net/natsemi.c: stop tx/rx and reinit_ring on a PHY reset
  o drivers/net/natsemi.c: cleanup version string, fix compile error
  o drivers/net/natsemi.c: boost some printk() levels to WARN

Trond Myklebust <trond.myklebust@fys.uio.no>:
  o NFS: readdir reply truncated
  o NFS: readdir reply truncated!


