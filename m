Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264256AbUGKSbq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264256AbUGKSbq (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Jul 2004 14:31:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266646AbUGKSbq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Jul 2004 14:31:46 -0400
Received: from fw.osdl.org ([65.172.181.6]:16875 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264256AbUGKS3s (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Jul 2004 14:29:48 -0400
Date: Sun, 11 Jul 2004 11:29:44 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Linux 2.6.8-rc1
Message-ID: <Pine.LNX.4.58.0407111120010.1764@ppc970.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Ok, there's been a long time between "public" releases, although the
automated BK snapshots have obviously been keeping people up-to-date. 
Sorry about that, I blame mainly moving boxes and stuff around...

The diff is big, and skewed by some QLogic SCSI controller firmware
updates along with a few new (and some moved) drivers. Most of the rest is 
a large collection of fairly small patches. The shortlog gives a 
reasonable overview.

		Linus

----

Summary of changes from v2.6.7 to v2.6.8-rc1
============================================

Aaron Grothe:
  o [CRYPTO]: Add TEA and XTEA algorithms

Adam J. Richter:
  o dnotify.c: use inode->i_lock in place of dn_lock

Adam Osuchowski:
  o [NETFILTER]: Fix opt[] to be array of u_int8_t in tcp_find_option()

Adam Radford:
  o 1/2 3ware 9000 SATA-RAID driver v2.26.00.009
  o 2/2 3ware 9000 SATA-RAID driver v2.26.00.009
  o 3ware 9000 driver update
  o 3ware 9000 schedule_timeout fix

Adrian Bunk:
  o add NAPI help texts
  o modular scsi/mca_53c9x doesn't work
  o more PC9800 removal
  o 2.6.7-mm1: drivers/scsi/hosts.h -> scsi/scsi_host.h
  o fix linker trouble with CONFIG_FB_RIVA_I2C=y and modular I2C
  o [NET]: Kill spurious ifndef in net/ip.h
  o remove unused variable in esp.c
  o remove unused variable in mxser.c
  o s/2.5/2.6/ in MAINTAINERS
  o remove allowdma0 documentation
  o Fix MCA_LEGACY dependencies
  o fix (UDF_FS=y && NLS=m) compile error
  o remove outdated ext2 help text parts
  o remove drivers/char/h8.{c,h}
  o kill IKCONFIG_VERSION

Alan Cox:
  o Stop megaraid trashing other i960 based devices
  o Lost 2.4 change for BusLogic info
  o add new via-velocity gigabit ethernet driver
  o Further aacraid work
  o make the 3c59x/3c90x driver somewhat more reliable
  o Dell laptop lockup fix for ALSA
  o vc locking

Alan Stern:
  o USB: unusual_devs.h update
  o USB: Fix disconnect bug in dummy_hcd
  o USB: Minor cleanups for hub driver
  o USB: Move usb_new_device() et al. into hub.c
  o USB: 2.6-BK usb (printing) broken
  o USB: Code cleanup for the UHCI driver
  o USB: Debounce all connect change events
  o USB: Superficial improvements to hub_port_debounce()
  o USB: Genuine changes to hub_port_debounce()
  o Make the scsi error handler bus settle delay a per template option
  o USB: Fix logic in usb_get_descriptor()
  o USB: Check port reset return code
  o USB: Fix resource leakage in the hub driver
  o USB: unusual_devs.h update
  o USB: Initialize endpoint autoconfig in g_file_storage
  o USB: Fix bus-list root-hub race
  o USB: Minor tidying up of hub driver
  o USB: Update root-hub code for the ohci-lh7a404 driver
  o USB: Mark devices as NOTATTACHED as soon as possible
  o USB: Fix bug in TT initialization introduced by earlier
  o USB: Remove private khubd semaphore
  o USB: Only process ports with change events pending
  o USB Storage: unusual_devs.h update
  o USB: Fix endian bug in g_file_storage
  o USB: dummy_hcd shouldn't reject SET-ADDRESS requests
  o USB: Add logical connect-change notices to the hub driver
  o USB: Fail pending URBs in dummy_hcd upon disconnect
  o USB: Imiprove usb_device tracking in dummy_hcd
  o USB: Add mb() during initialization of UHCI controller
  o (as333) BLIST flag for non-lockable devices
  o USB Storage: Unusual_devs.h update

Alasdair G. Kergon:
  o dm-io: device-mapper i/o library for kcopyd
  o Device-mapper: kcopyd
  o dm: kcopyd: remove superfluous INIT_LIST_HEADs
  o dm: kcopyd: No need to lock pages
  o Device-mapper: snapshots
  o Device-mapper: mirroring
  o Device-mapper: dm-zero
  o dm: dm-zero version

Alex Grijander:
  o fealnx-mac-address-and-other-issues.patch

Alex Tomas:
  o ext3: htree readdir fix

Alex Williamson:
  o ia64: delete McKinley A-stepping code
  o ia64: trashing bootmem on non-NUMA boxes

Alexander Viro:
  o sparse: i387 math-emu annotation
  o sparse: rt_sigsuspend/sigaltstack sanitized
  o sparse: vm86.c annotated
  o sparse: ixj annotated
  o sparse: drivers/char/watchdog annotation
  o sparse: drivers/input annotations
  o sparse: ide-tape annotation
  o sparse: ibmasmfs annotations
  o crapectomy - last users of kernel_scsi_ioctl() gone
  o sparse: drivers/message/fusion annotations and fixes
  o sparse: binfmt_aout annotation
  o sparse: mwave annotation
  o sparse: nfs partial annotation
  o sparse: drivers/video partial annotation
  o sparse: drivers/video/kyro annotation
  o sparse: drivers/video/matrox annotation
  o sparse: udf cleanups
  o sparse: applicom annotation
  o sparse: amd64 bits
  o sparse: ipmi annotation
  o sparse: cyclades annotation
  o sparse: synclinkmp annotation
  o sparse: autofs annotation
  o sparse: drivers/video/aty annotation
  o sparse: drivers/video/sis annotation
  o airo.c broke
  o ibmtr missing include
  o sparse: ncpfs/ioctl.c annotation
  o sparse: zlib stray extern removal
  o sparse: efivars.c initializer fix
  o sparse: drivers/net/wan annotation
  o sparse: raw1394 annotation
  o sparse: sock_fprog sanitized
  o sparse: quota annotation
  o sparse: hd.c annotation
  o sparse: the rest of ieee1394 annotation
  o bug in V-link handling (arch/i386/pci/irq.c)
  o make DVD ioctls that can legitimately fail quiet
  o sparse: trivial drivers/net/* annotations
  o sparse: trivial drivers/char/* annotation and format fixes
  o sparse: trivial annotations in drivers/char/*
  o isdn_writebuf_stub() sanitized
  o sparse: trivial drivers/isdn/* annotations
  o sparse: i2o fixed
  o sparse: trivial i2o annotations
  o sparse: scsi ->ioctl() annotation
  o symlink 1/9: infrastructure and explanation
  o symlink 2/9: ext2 conversion and helper functions
  o symlink 3/9: trivial filesystems
  o symlink 4/9: simple filesystems
  o symlink 5/9: smbfs
  o symlink 6/9: xfs
  o symlink 7/9: shmfs
  o symlink 8/9: befs
  o symlink 9/9: jff2
  o symlink: fix missing 'depth' initialization
  o sparse: removal of iovec use in mtd
  o sparse: NULL noise is mtd
  o sparse: NULL noise in jffs
  o sparse: NULL noise in jfs

Alexey Dobriyan:
  o Remove include/asm-*/init.h
  o Remove include/{asm-i386,linux}/upd4990a.h
  o trivial: scripts_kernel-doc: ignoring embedded structs shouldn't be
  o trivial: scripts_kernel-doc: missing bracket

Andi Kleen:
  o Use numa policy API for boot time policy
  o NUMA API updates
  o Fix early CPU vendor detection for non intel cpus
  o NUMA API: fix use-after-free bug

Andre Noll:
  o nfs oops fix

Andrea Arcangeli:
  o remap_file_pages() speedup
  o zombie with CLONE_THREAD and strace
  o writepage fs corruption fix
  o __block_write_full_page() comment fixups
  o mpage_writepages() i_size reading fix

Andrew Chew:
  o [libata] Add NVIDIA SATA driver

Andrew Morton:
  o scsi_transport_spi.c build fix
  o I2C: w83627hf.c build fix
  o prism94 build fix
  o [BRIDGE]: Fix bridge sysfs improprely initialized kobject
  o ppc64: uninline __pte_free_tlb()
  o idr: remove counter bits from id's
  o i2c fixups for idr API change
  o invalidate_inodes2(): mark pages not uptodate
  o i386 uninline some bitops
  o Make update_one_process() static
  o [NET]: Fix eql.c failed dev_get_by_name() return value check
  o mptctl.c build fix
  o [NET]: Fix econet build bustage
  o [NET]: Fix warning in farsync WAN driver
  o [SPARC64]: bug.h needs compiler.h
  o ppc64 CONFIG_ALTIVEC=n build fix
  o ppc64: eeh.h warning-fix
  o swapoff: activate pages
  o move as documentation
  o jfs warning fix
  o [NET]: Fix dev_queue_xmit build with older gcc
  o [NET]: Loopback, allocate per-cpu stats statically and fix cpu
    refcounting
  o x86_64: cpu_online fix
  o ppc64: cpu_online fix
  o vmscan.c: shuffle things around
  o vmscan.c scan rate fixes
  o vmscan.c: dont reclaim too many pages
  o vm: vfs shrinkage tuning
  o Use fancy wakeups in wait.h
  o abs() fixes
  o nr_pagecache can go negative
  o make total_swap_pages a long
  o kswapd warning fix
  o balanced_irq warning fix
  o [NET]: Fix warning in tr.c
  o [NET]: Fix warning in fc.c
  o [NETFILTER]: ip_fw_compat_masq.c needs net/ip.h for IP_OFFSET
  o [PKT_SCHED]: Fix pkt_sched.h warnings
  o x86: fix up cpumask breakage
  o [SPARC64]: Make find_next_bit take a const pointer
  o [SPARC64]: Make ___arch_swapXp() take a const pointer
  o mptbase.c build fix
  o ppc64: COMMAND_LINE_SIZE fix
  o sysfs: fill_read_buffer() fix
  o i386: uninline memmove
  o inodes_stat.nr_unused fix
  o lock ordering comment update
  o ext3: direct-io transaction extending fix
  o ext2_setattr retval fix
  o reiserfs_setattr retval fix
  o jfs_setattr() fix
  o cifs_setattr() retval fix
  o ncpfs_setattr() retval fix
  o affs_setattr() retval fix
  o x86 stack dump fixes
  o USB: pwc-uncompress.h
  o x86_64 .init.setup alignment fix
  o err2-14: skge locking fix
  o [err1-10] journal_extend() locking fix
  o [err1-25] snd_ctl_read() locking fix
  o ntfs build fix
  o i386 math emu build fix
  o err1-40: sysvfs locking fix
  o err1-2: sscape locking fix
  o err1-14: sb_audio locking fix
  o err2-1 dvb_register_i2c_device locking fix
  o err2-25: dvb_register_i2c_bus() locking fix
  o err2-27: i2o_claim_device() locking fix
  o err2-29: ufs_new_fragments() locking fix
  o apm.c warning fix
  o ppc64: remove MachineCheck_Pseries
  o wavefront_fx.c build fix
  o kyrofb warning fix
  o [ROSE]: rose_route locking fix
  o [AX25]: ax25_ds_idletimer_expiry() locking fix
  o [LAPB]: lapb_unregister() locking fix
  o [AX25]: ax25_rt_add() locking fix
  o [SPARC64]: Kill silo_args bogus .globl
  o update kernel-parameters.txt for the noexec option
  o pagefault readaround fix
  o slab: fix get_user inside spinlock
  o crc16 kconfig touchups

Andrew Vasquez:
  o [1/18]  qla2xxx: Add wmb() to critical paths
  o [2/18]  qla2xxx: Correct residual counts
  o qla2xxx: remove unnecessary command direction determination
  o [3/18]  qla2xxx: PCI DMA mappings rework
  o [4/18]  qla2xxx: ISR RISC paused fixes
  o [5/18]  qla2xxx: Add module parameter permissions
  o [6/18]  qla2xxx: Initialization fixes
  o [7/18]  qla2xxx: Tape command handling fixes
  o [8/18]  qla2xxx: Remove dead code
  o [9/18]  qla2xxx: Tape command handling fixes
  o [10/18] qla2xxx: Additional tape handling fixes
  o [11/18] qla2xxx: Misc. fixes
  o [12/18] qla2xxx: Extend firmware dump support
  o [13/18] qla2xxx: Remove TRUE/FALSE usage
  o [14/18] qla2xxx: Use proper include files
  o [15/18] qla2xxx: SRB handling cleanup and fixes
  o [16/18] qla2xxx: 23xx/63xx firmware updates
  o [17/18] qla2xxx: Bus reset handler fixes
  o [18/18] qla2xxx: Update driver version
  o qla2xxx: Remove qla_os.h

Andrey Panin:
  o export DMI check functions
  o use new DMI API for HP Pavilion
  o dmi_scan: port Acer laptop irq routing workaround to new DMI
    probing
  o dmi_scan: port PnP BIOS driver to new DMI probing
  o dmi_scan: port sonypi driver to new DMI probing
  o dmi_scan: port PIIX4 SMBUS driver to new DMI probing
  o dmi_scan: port powernow-k7 driver to new DMI probing
  o dmi_scan: remove unused ASUS K7V-RM DMI quirk
  o dmi_scan: port APM BIOS driver to new DMI probing
  o crc: add common CRC16 module
  o crc: use it in async PPP driver
  o crc: use it in IRDA drivers
  o crc: use it in ISDN drivers
  o crc: use it in AX.25 drivers
  o port reboot workarounds to new DMI probing
  o port ACPI sleep workaround to new DMI probing
  o DMI isn't broken anymore
  o fix CRC16 misnaming
  o CRC16 renaming in AX25 drivers
  o CRC16 renaming in IRDA drivers
  o CRC16 renaming in ISDN drivers
  o CRC16 renaming in PPP driver

Andries E. Brouwer:
  o revert partition nonsense
  o isofs fixes
  o minor CAP_DAC_OVERRIDE fix
  o fat/inode.c

Andy Adamson:
  o knfsd: nfsd4 lockowner fixes
  o knfsd: parse nsfd4 callback information
  o knfsd: allow user to set NFSv4 lease time

Andy Whitcroft:
  o fix allocate_pgdat comments
  o consolidate in-kernel configuration
  o fix NUMA boundaray between ZONE_NORMAL and HIGHMEM
  o ia32: fix deadlocks when oopsing while mmap_sem is held
  o fix GFP zone modifier interators
  o ppc64: fix deadlocks when oopsing while mmap_sem is held
  o convert uses of ZONE_HIGHMEM to is_highmem

Aneesh Kumar:
  o alpha: print the symbol name in Oops

Anton Altaparmakov:
  o NTFS: - Add new element itype.index.collation_rule to the ntfs
    inode structure and set it appropriately in
    ntfs_read_locked_inode().
  o NTFS: Ensure that there is no overflow when doing page->index <<
    PAGE_CACHE_SHIFT by casting page->index to s64 in fs/ntfs/aops.c.
  o NTFS: Use atomic kmap instead of kmap() in
    fs/ntfs/aops.c::ntfs_read{page,_block}()
  o NTFS: Use case sensitive attribute lookups instead of case
    insensitive ones
  o NTFS: Lock all page cache pages belonging to mst protected
    attributes while accessing them to ensure we never see corrupt data
    while the page is under writeout.
  o NTFS: Add framework for generic ntfs collation
    (fs/ntfs/collation.[hc])
  o NTFS: Add a new type, ntfs_index_context, to allow retrieval of an
    index entry using the corresponding index key.  To get an index
    context, use ntfs_index_ctx_get() and to release it, use
    ntfs_index_ctx_put().
  o NTFS: Load the quota file ($Quota) and check if quota tracking is
    enabled and if so, mark the quotas out of date.  This causes
    windows to rescan the volume on boot and update all quota entries.
  o NTFS: Forgot the set_page_writeback()/end_page_writeback() in the
    mst protected writepage case.
  o Remove NOOP code from fs/buffer.c::drop_buffers()
  o NTFS: Add a set_page_dirty address space operation for
    ntfs_m[fs]t_aops
  o NTFS: Add fs/ntfs/index.c::__ntfs_index_entry_mark_dirty() which
    sets all buffers that are inside the ntfs record in the page dirty
    after which it sets the page dirty.  This allows ->writepage to
    only write the dirty index records rather than having to write all
    the records in the page.  Modify
    fs/ntfs/index.h::ntfs_index_entry_mark_dirty() to use this rather
    than __set_page_dirty_nobuffers().
  o NTFS: Update __ntfs_index_entry_mark_dirty() so it makes sure that
    the page has buffers.  Otherwise we could end up with a dirty page
    without buffers and our set_page_dirty() would not mark the buffers
    dirty when they are created and thus they would not be written out
    and the dirty records would be lost.
  o NTFS: 2.1.15 - Implement fs/ntfs/aops.c::ntfs_write_mst_block()
    which enables the writing of page cache pages belonging to mst
    protected attributes like the index allocation attribute in
    directory indices and other indices like $Quota/$Q, etc.  This
    means that the quota is now marked out of date on all volumes
    rather than only on ones where the quota defaults entry is in the
    index root attribute of the $Quota/$Q index.

Anton Blanchard:
  o [NET]: Allow IP header alignment to be overriden
  o Make nr_swap_pages a long
  o ppc64: fix POWER3 NUMA init
  o ppc64: fix oprofile on 970
  o ppc64: udbg should use snprintf
  o ppc64: another udbg fix
  o ppc64: udbg fix
  o ppc64: remove a stale comment in rtas.c
  o __alloc_bootmem_node should not panic when it fails
  o ppc64: gcc 3.5 fixes
  o ppc64: gcc 3.5 fixes #2
  o ppc64: SPLPAR spinlock optimisation
  o gcc 3.5 fixes
  o gcc 3.5 fixes #2
  o ppc64: uninline some user copy routines

Antonino Daplas:
  o Updates to rivafb driver
  o More updates to rivafb driver
  o help text for FB_RIVA_I2C
  o Core fbcon fixes
  o fbdev: video mode change notify (fbset)
  o fbcon: fix display artifacts
  o Rivafb fixes
  o Mode Switch in fbcon_blank()
  o Another batch of fbcon fixes
  o fbcon: optimization for accel_putcs()
  o fbcon mode switching fix
  o fbcon: refinements for fbcon
  o fbcon: new scrolling mode: YPAN + REDRAW
  o fbdev: set capabilities flag for vesafb and vga16fb

Arjan van de Ven:
  o SCSI: replace deprecated hosts.h file
  o sk98lin pci id
  o final hosts.h usage removal
  o fix amd64 boot breakage
  o Permit root to choose vfat policy to UTF8
  o produce a warning on unchecked inode_setattr use

Arnaldo Carvalho de Melo:
  o [NET] first bits of net/core/stream.c
  o [ECONET] kill some trivial warnings
  o [NET] generalise tcp_add_data, skb_split and tcp_copy_to_page
  o [NET] move skb_can_coalesce to skbuff.h
  o [NET] move tcp_memory_free to sk_stream_memory_free
  o [NET] generalise wait_for_tcp_connect
  o [NET] introduce sk_stream_wait_close, from tcp code
  o [NET] generalise wait_for_tcp_memory
  o [NET] generalise tcp_set_owner_r and tcp_rfree
  o [NET] generalise tcp_error, renaming it to sk_stream_error
  o [NET] generalise tcp_free_skb, renaming it to sk_stream_free_skb
  o [NET] generalise tcp_moderate_sndbuf
  o [NET] move send_head from tcp private area to struct sock
  o [NET] Move sndmsg_page and sndmsg_off to struct sock
  o [NET] rename struct inet_protocol to net_protocol
  o [NET] remove fill_page_desc, its just a copy of skb_fill_page_desc
  o [NET] Generalise tcp memory pressure handling
  o [NET] Generalise
    tcp_{writequeue_purge,rmem_schedule,alloc_{pskb,page}}
  o [NET] make the struct proto entries related to memory pressure be
    pointers
  o [NET] move already shared functions from inet to core
  o [NET] share tcp_v4_destroy_sock with tcpv6

Arnd Bergmann:
  o cpumask: rewrite cpumask.h - single bitmap based implementation
  o s390: common i/o layer

Arthur Kepner:
  o [NET]: Lockless loopback patch (version 2)
  o [NET]: In loopback, make get_stats() get correct per-cpu stats

Arthur Othieno:
  o Kill stale references to Documentation/networking/8139too.txt

Arun Sharma:
  o ia64: fix ia32 virtual memory leaks due to partial-page mappings
  o sys_getdents64 needs compat wrapper
  o ia64: fix ia32 partial-page map support for overlapping mmaps

Ashok Raj:
  o don't create cpu/online sysfs file
  o ia64: move move_irq() from iosapic.c to irq.c

Bart Samwel:
  o laptop-mode documentation update

Bartlomiej Zolnierkiewicz:
  o ide: remove redundant hwgroup->handler checks from ide-taskfile.c
  o ide: end request fix for CONFIG_IDE_TASKFILE_IO=y PIO handlers
  o ide: PIO-in drive busy fix (CONFIG_IDE_TASKFILE_IO=y)
  o ide: check drive->mult_count in flagged_taskfile()
  o ide: last IRQ fix for task_mulout_intr() (CONFIG_IDE_TASKFILE_IO=n)
  o ide: remove DTF() debugging printks from ide-taskfile.c
  o ide: add task_multi_sectors() to ide-taskfile.c
  o ide: split task_sectors() and task_multi_sectors()
  o ide: don't clear rq->errors for REQ_DRIVE_TASKFILE requests
  o ide: use task_buffer[_multi]_sectors() in ide-taskfile.c
  o ide: PIO-out setup fixes (CONFIG_IDE_TASKFILE_IO=n)
  o ide: reduce > 3kb call path in ide-cs
  o ide: check_region removal - trm290.c
  o ide: limit max_sectors to 256 for PDC20265

Benjamin Herrenschmidt:
  o ppc32: Cleanups & warning fixes of traps.c
  o ppc32: oprofile support
  o ppc32: Support for new Apple laptop models
  o radeonfb: Fix panel detection on some laptops
  o ppc64: Fix booting on LPAR machines with more than 1 CPU

Bert Hubert:
  o [NET]: Update some sysctl documentation
  o (o)profile Documentation/basic_profiling.txt updates

Bjoern Jacke:
  o NLS support for ASCII

Bjorn Helgaas:
  o PCI: clarify pci.txt wrt IRQ allocation
  o ia64: minor IOSAPIC cleanup
  o Add PCDP console detection support
  o ia64: define cpu_logical_id() always
  o ia64: fix a couple of comment typos
  o PCDP console detection support fixes
  o pcdp.c needs io.h

Bogdan Costescu:
  o 3c59x: support for ATI Radeon 9100 IGP

Brian Gerst:
  o kbuild: clean up module install rules
  o kbuild: sort modules for modpost and modinst

Brian King:
  o ipr scsi busy io hang
  o ipr duplicate ioa reset fix
  o ipr driver version 2.0.8
  o ipr operational timeout oops
  o ipr abort hang fix
  o ipr only tcq cancel all
  o ipr bump version to 2.0.10

Burton N. Windle:
  o fix 3c59x.c to allow 3c905c 100bT-FD

Cesar Eduardo Barros:
  o O_NOATIME support

Chas Williams:
  o [ATM]: fix sparse checker warnings (by Stephen Hemminger
    <shemminger@osdl.org>)

Chris Heath:
  o trivial: remove warning in ftape

Chris Mason:
  o reiserfs: block allocator should not inherit "packing locality 1"
  o reiserfs: remove debugging warning from block allocator
  o reiserfs: btree readahead
  o reiserfs data logging support
  o fix possible stack corruption during reiserfs_file_write
  o jbd needs to wait for locked buffers

Chris Wright:
  o binfmt_misc: improve calculation of interpreter's credentials
  o RLIM: add rlimit entry for controlling queued signals
  o RLIM: add sigpending field to user_struct
  o RLIM: add simple get_uid() helper
  o RLIM: add rlimit entry for POSIX mqueue allocation
  o RLIM: add mq_bytes to user_struct
  o RLIM: add mq_attr_ok() helper
  o RLIM: enforce rlimits for POSIX mqueue allocation
  o RLIM: adjust default mqueue sizes
  o fix simple_strtoul base 16 handling
  o RLIM: pass task_struct in send_signal()
  o RLIM: enforce rlimits on queued signals
  o RLIM: remove unused queued_signals global accounting
  o remove extraneous security_inode_setattr call in hugetlbfs
  o check attr updates in /proc
  o chown permission check fix for ATTR_GID
  o selinux build fix
  o selinux space saving

Christoph Hellwig:
  o move scsi debugging helpers and give them sane names
  o fix dpt_i2o compilation for alpha and sparc
  o remove sleep_on_timeout usage in megaraid
  o handle NO_SENSE in sd
  o fix check_region usage in eata_pio
  o fix sym53c416 check_region usage
  o remove obsolete API usage from dpt_i2o
  o scsi_dev_flags must be __initdata, not __init
  o missing forward declarations in scsi_eh.h
  o update 53c700 to avoid obsolete headers
  o kill dead compat code in advansys
  o clean up SCSI_TIMEOUT usage
  o avoid obsolete scsi APIs in eata_pio
  o fix standalone inclusion of asm-i386/dma-mapping.h
  o switch scsi core and sd to <scsi/*.h> headers
  o fix isdn to not assume mem*io return values
  o avoiding obsolete scsi APIs in dc395
  o wd7000 updates
  o wd33c93 update
  o avoid obsolete APIs in sr
  o avoid obsolete APIs in fdomain
  o avoid obsolete APIs in atp870u
  o ppc32: fix compilation
  o MPT Fusion driver 3.01.09 update
  o some tmscsim consolidation
  o [NETLINK]: Fix NLMSG_OK/RTA_OK length checking
  o [XFS] Don't dereference buffer after pagebuf_iostrategy()
  o ppc32: compilation failure on ppc32
  o __bdevname leak fix
  o remove dead isdn pcmcia code

Christoph Lameter:
  o Support NetMOS based PCI cards providing serial and parallel ports

Christophe Saout:
  o Device-mapper: dm-zero flushing fix

Corey Minyard:
  o Fixes for idr code
  o IDR fixups
  o IPMI base patch to fix channel handling and add polling

Cornelia Huck:
  o s390: comon i/o layer

Coywolf Qi Hunt:
  o kbuild: distclean srctree fix

Craig Nadler:
  o USB: EHCI IRQ tweaks

Dale Farnsworth:
  o Patch 1/2 enable smc91x enet driver for use by PPC
  o Patch 2/2 enable smc91x enet driver for use by PPC

Daniel McNeil:
  o handle partial DIO write

Daniel Ritz:
  o PCI: fix irq routing on acer travelmate 360 laptop
  o pcmcia: enable read prefetch on o2micro bridges to fix HDSP

Darren Salt:
  o fix handling of '/' embedded in filenames in isofs

Darren Williams:
  o fix broken alpha build ptrace.c error

Dave Airlie:
  o typo
  o typo in radeon_state.c
  o whitespace cleanup in radeon.h

Dave Hansen:
  o fix page->count discrepancy for zero page

Dave Jones:
  o USB / SCSI multi-card reader whitelist updates
  o SCSI: more whitelist updates for usb card readers
  o SCSI: Correct BELKIN card reader whitelist entry
  o [AGPGART] Kconfig Typo fix From: Tuncer M zayamut Ayaz
  o [AGPGART] Don't waffle about unsupported serverworks chipsets if
    they don't do AGP
  o [AGPGART] Re-add VIA VP3 support
  o [AGPGART] Delete trailing whitespace in generic routines
  o [AGPGART] If we can't do AGP x8 in v3 mode, just drop back to x4
  o [AGPGART] Show the untampered arguments in debug printk
  o [AGPGART] Improved AGPx8 handling
  o [AGPGART] Extra debugging info just in case
  o [AGPGART] Remove typo from comment
  o [AGPGART] Fix silly logic bug in AGPx8 ->x4 fallback code
  o [AGPGART] Fix sparse NULL pointer warnings
  o [AGPGART] K8T800 Pro support in amd64 driver
  o MTRR __initdata fix

Dave Kleikamp:
  o jfs build fix

Dave Olien:
  o dm: Fix error cleanup in dm_create_persistent()

David Brownell:
  o USB: pxa/rndis device descriptor
  o USB: usb retry cleanups
  o USB: rndis (1/4) update OID support
  o USB: rndis (4/4) start documenting spec variances
  o USB: usb root hubs can set power budgets
  o USB: usb suspend/resume work better on net2280
  o lh7a404 USB host against 2.6.7-rc2
  o USB: usbtest just uses module_param()
  o USB: usbnet shouldn't oops on cdc error path
  o USB: retry string fetches on ZLPs not just STALLs
  o USB: usb gadget drivers should be stricter about ZLPs
  o USB: gadgetfs AIO support

David Eger:
  o fb accel capabilities
  o fbcon: prefer pan when available
  o fix radeonfb panning and make it play nice with copyarea()
  o rivafb: fb accel capabilities
  o cirrusfb: major update
  o radeonfb accel capabilities
  o radeonfb: 16bpp copyarea() fix
  o err1-7, err1-8: double locking fix for radeonfb

David Gibson:
  o ppc64: remove RTAS arguments from PACA
  o ppc64: PACA cleanup
  o trivial: RCS___IGNORE quilt backup files

David Howells:
  o Permit inode & dentry hash tables to be allocated > MAX_ORDER size
  o ppc64: fix usage of cpumask_t on iSeries
  o missing semicolon in 2.6.7 VIODASD driver
  o intrinsic automount and mountpoint degradation support
  o kAFS automount support

David Mosberger:
  o ia64: Update defconfig
  o ia64: Fix ia32 partial-page-list code to compile cleanly in more
    configs
  o ia64: Nuke two warnings in mca.c that showed in the simulator
    configuration
  o ia64: Squish compiler-warning in perfmon.c when compiling for UP
  o ia64: Squish some more hazards & warnings for UP compile
  o ia64: Fix build-problem when CONFIG_IA32 is not enabled
  o ia64: Fix UP-build breakage caused by early_console_setup() patch

David S. Miller:
  o [TCP]: Tweak some default sysctl values
  o [TG3]: Always do 4gb tx dma test, and fix the test
  o [TCP]: No vegas by default just yet
  o Cset exclude: kuznet@ms2.inr.ac.ru|ChangeSet|20040616204246|05149
  o [NET]: In unregister_netdevice(), do synchronize_net() before final
    dev_put()
  o [PKT_SCHED]: Do not check netif_queue_stopped() in dequeue ops,
    races with driver
  o [IPV6]: Export necessary xfrm6_tunnel functions
  o hamachi DMA
  o [SPARC64]: Check _TIF_SYSCALL_SUCCESS before syscall return value
  o [IPSEC]: In ESP, do not put scatterlist array on stack
  o [NETFILTER]: Use correct size_t printk format string in
    ipt_addrtype.c
  o [ATM]: In proc_mpc_read, make length ssize_t
  o [PKT_SCHED]: Fix typo in config help text, noticed by Geert
  o [SPARC64]: Update defconfig
  o [SPARC64]: No longer set WANT_PAGE_VIRTUAL
  o [NET]: Fix SO_{RCV,SND}TIMEO getsockopt handling
  o Cset exclude:
    dtor_core@ameritech.net|ChangeSet|20040629212548|46753
  o [IPV4]: Bootp packet extension area is variable length
  o [SPARC64]: Document reserved and soft2 bits in PTE
  o [SPARC64]: Reserve a software PTE bit for _PAGE_EXEC
  o [SPARC64]: Non-executable page support
  o [TG3]: Fibre PHY fixes from Sun
  o [TG3]: Update driver version and reldate
  o [PKT_SCHED]: Rip out requeue stat addition, user ABI breaker
  o [PKT_SCHED]: Do not embed spinlock in tc_stats structure
  o [NETFILTER]: Fix initializer of ip6table.c:initial_table
  o [PKT_SCHED]: Fix some missing qdisc_copy_stats() conversions
  o [PKT_SCHED]: Another missed qdisc_copy_stats() conversion
  o [PKT_SCHED]: Kill CONFIG_CLS_U32_PERF2 cruft code
  o [PKT_SCHED]: Kill fix_u32_bug ifdef tests in cls_u32.c
  o [IPV4]: Set UDP accept back to sock_no_accept

David Stevens:
  o [IPV4]: Fix interface selection in multicast sockops
  o [IPV6]: Handle user asking for any device in mcast calls

David Vrabel:
  o [ARM PATCH] 1940/1: asm-arm/checksum.h - missing include

David Woodhouse:
  o PPC: Make Motorola CPM2 I/O core support more generic
  o PPC: Move CPM2 common core routines to arch/ppc/syslib/
  o UART driver for Motorola CPM/CPM2 I/O core on 8xx/8xxx chips
  o Remove old MPC82xx (CPM2) uart driver
  o PPC SBC82xx: Move RTC to 0xd0000000 to make room for PCI I/O stuff
  o PCI host bridge support for Motorola MPC826x
  o Add support for i8259 IRQ controller on WindRiver PowerQUICC II
  o Change new Motorola copyright notices and email addresses to
    Freescale
  o Workaround for MPC826x PCI erratum #9
  o Add support for MPC8560 CPU and WindRiver PowerQUICC III SBC8560
  o Update CPM UART driver according to feedback from Dan Malek
  o WindRiver PowerQUICC III platform support cleanup

Davide Libenzi:
  o epoll: replace the file lookup hash with rbtrees

Dean Nelson:
  o add wait_event_interruptible_exclusive() macro

Dean Roehrich:
  o [XFS] Change things to use new version of xfs_dm_init/xfs_dm_exit
  o [XFS] Fix non-dmapi build

Deepak Saxena:
  o [ARM] Timer cleanup
  o [ARM] Remove bogus gettimeoffset ptr from machine_desc struct
  o [ARM] Delete include/asm-arm/arch-nexuspci/time.h
  o [ARM] Delete include/asm-arm/arch-iop3xx/time.h
  o [ARM] Delete include/asm-arm/arch-ixp4xx/time.h
  o [ARM] Delete include/asm-arm/arch-versatile/time.h
  o [ARM] Add include/asm-arm/mach/time.h for shared timer definitions
  o [ARM] Consolidate various ARM timer fns. into single timer_tick()
    call
  o [ARM] Remove ADIFCC machine type

Dely Sy:
  o Fixes for hot-plug drivers (updated)

Dipankar Sarma:
  o reduce rcu_head size - core
  o rcu: avoid passing an argument to the callback function

Dmitry Torokhov:
  o Driver Core: Suppress platform device suffixes
  o Driver Core: Whitespace fixes

Dominik Brodowski:
  o mull'ify multiplication with HZ in __const_udelay()
  o round up  in __udelay()
  o add 1 in __const_udelay()
  o [PCMCIA] check for proper registration with device core
  o [PCMCIA] core socket sysfs support, export card type
  o [PCMCIA] card voltage
  o [PCMCIA] card vpp / vcc
  o [PCMCIA] card insert / eject
  o [PCMCIA] Use a class interface to provide sysfs attributes

Don Fry:
  o pcnet32: discard oversize rx packets
  o pcnet32: recover after rx hang
  o pcnet32: cleanup IRQ limitation
  o pcnet32: acknowledge all interrupts early
  o pcnet32: Add HomePNA parameter for 79C978
  o pcnet32:  correctly program bcr32
  o pcnet32: change to use module_param

Douglas Gilbert:
  o sg update to 20040516
  o scsi_debug: num_parts, ptype and (re-)scans
  o More advansys fixes

Duncan Sands:
  o USB devio.c: deadlock fix

Eberhard Mönkeberg:
  o CREDITS update

Egmont Koblinger:
  o Shift+PgUp if nr of scrolled lines is < 4

Eric Dean Moore:
  o MPT Fusion driver 3.01.07 update

Eric Delaunay:
  o fix duplicate environment variables passed to init

Eric Dumazet:
  o [NET]: Tidy somaxconn sysctl doc

Eric Lammerts:
  o asiliantfb fix

Evgeniy Polyakov:
  o Typo in ethtool code in acenic driver

Fabian Frederick:
  o sparse annotation for sys_quotactl()

Frank A. Uepping:
  o Driver Core: fix struct device::release issue

Frank Neuber:
  o USB: usb ethernet gadget build fixes on PXA

François Romieu:
  o cirrusfb: minor fixes

Gary Lerhaupt:
  o proper bios handoff in ehci-hcd

Geert Uytterhoeven:
  o fix warning in fbmem.c
  o m68k: IFPSP060 update
  o m68k: handle new gcc's
  o m68k: new gcc optimizations
  o m68k: bus error handling
  o m68k: use set_page_count()
  o affs remount fixes
  o m68k: Mac Sonic Ethernet
  o m68k: sparse infrastructure
  o m68k: Mac IOP fix
  o m68k: atomic op fixups
  o m68k: I/O abstraction updates
  o Fix idr.h comment

George Anzinger:
  o Bugfix for CLOCK_REALTIME absolute timer

Gerd Knorr:
  o v4l: v4l2 API updates
  o v4l: update video-buf for per-frame input switching
  o v4l: video-buf magic numbers
  o v4l: video-buf fixes
  o v4l: msp3400 cleanup
  o v4l: ir-common update
  o v4l: tuner + tda9887 updates
  o v4l: bttv driver update
  o v4l: IR input driver update
  o saa7134 driver update
  o v4l: cx88 driver update

Greg Banks:
  o knfsd: mark NFS/TCP server not EXPERIMENTAL

Greg Kroah-Hartman:
  o Add basic sysfs support for raw devices
  o Driver Model: More cleanup of silly scsi use of the *ATTR macros
  o Driver Model: Cleanup the i2c driver silly use of the *ATTR macros
    which just broke
  o Cset exclude: vojtech@suse.cz|ChangeSet|20040602201956|45549
  o USB: remove "devfs" message from kernel log for usb-serial driver
  o Driver Model: And even more cleanup of silly scsi use of the *ATTR
    macros
  o PCI: convert to using dev_attrs for all PCI devices
  o Driver core: finally add a MAINTAINERS entry for it
  o USB: make usb devices remove their sysfs files when disconnected
  o cpuid: fix hotplug cpu remove bug for class device
  o USB: crap, I misapplied a patch with the wrong level
  o Driver Core: more whitespace fixups
  o USB: sparse cleanups for the whole driver/usb/* tree
  o USB: fix up dumb int_user_arg variable name as pointed out by Al
    Viro
  o I2C: sparse cleanups for drivers/i2c/*
  o I2C: sparse cleanups again, based on comments from lkml
  o remove EXPORT_SYMBOL(kallsyms_lookup)
  o USB: mark pwc driver broken again, as it still is :(
  o merge fixups
  o USB: sparse fixups for devio.c
  o USB: enable the pwc driver to be able to be built again
  o USB: provide support for the HX version of pl2303 chips
  o USB: fix bug where removing usb-serial modules or usb serial
    devices could oops

Guennadi Liakhovetski:
  o SCSI: slave_detach -> slave_destory comment fix
  o Convert tmcscsim to new probing interfaces
  o tmscsim: Update version after "new API"
  o tmscsim: remove DeviceCnt
  o tmscsim: convert to slave_
  o tmscsim: Store pDCB in device->hostdata
  o tmscsim: 64-bit cleanup
  o tmscsim: init / exit cleanup
  o tmscsim: host_lock use in LLD
  o kill obsolete typedefs and wrappers from tmscsim

Gérard Robin:
  o unregister driver if probing fails in sb_card.c

H. J. Lu:
  o ia64: Don't use -mtune=merced for gcc 3.4

H. Peter Anvin:
  o Use first-fit for pty allocation

Hanna V. Linder:
  o Add class support to cpuid.c
  o Add cpu hotplug support to cpuid.c
  o Driver Model: Add class support to msr.c

Harm Verhagen:
  o USB: shut-up kaweth usb/net driver

Herbert Xu:
  o [NETDRV #1] Ifdef builtin-only probe in ISA/MCA drivers
  o [NETDRV #2] Use driver-specific name for resources
  o [NET]: Clear dev refs in dst->child
  o Check return status of register calls in i82365
  o omdisk memory leak fix
  o remove unnecessary memsets from swsusp and pmdisk
  o swsusp: remove copy_pagedir
  o Re: linux-2.6.7 Equalizer Load-balancer.  eql.c. local
    non-privileged DoS
  o [NET]: In sungem driver, keep track of rx buffer alloc size based
    upon MTU
  o [IPSEC]: Check encap_type at config time
  o [IPSEC]: Check encap_type at config time, in user API code
  o [IPSEC]: Fix alen calcs in non-IKE encapsulation
  o [IPSEC]: Remove run-time encap_type checks in esp4
  o [IPSEC]: Drop bogus NAT-T printks in esp_input
  o [IPSEC]: Move common code out of udp_encap_rcv()
  o USB: Fix pegasus_set_multicast lockup in drivers/usb/net/pegasus.c
  o [NETLINK]: Check connect address
  o [NETLINK]: Return err in netlink_connect
  o [ESP4]: Merge NAT-T code in esp_output()
  o [AH4]: Harmonization of output function
  o [XFRM]: Convert XFRM_MSG_* macros to an enum
  o [IPCOMP]: Exclude IPCOMP header from props.header_len

Hervé Eychenne:
  o Laptop mode control script improvements

Hideaki Yoshifuji:
  o [IPV6]: UDPv6 checksum
  o [IPV6] make several functions static in ip6_tunnel that should be
  o [IPV6] XFRM: add missing xfrm6_policy_check()
  o [IPV6] XFRM: support (uncompressed) tunnel mode ipcomp6 using
    xfrm6_tunnel infrastructure
  o [XFRM] fix dependency issues for CONFIG_IPV6=m
  o [IPV6]: Fix autoconf description in ip-sysctl.txt
  o [NET]: Fix some userland header bustage
  o [ECONET]: Fix some warnings
  o [NETFILTER]: Fix iptable_raw.c build with older gcc
  o [IPV6] Bring lo up before setting other interface up
  o [IPV6]: Fix flags for ndisc dst
  o [TCP]: Inline message
  o [NET]: Save space for dst underflow message

Hidetoshi Seto:
  o ia64: Quiet corrected errors (CMC/CPE)

Hirofumi Ogawa:
  o FAT: don't use "utf8" charset and NLS_DEFAULT
  o FAT: update document

Horst Hummel:
  o s390: dasd driver changes

Hugh Dickins:
  o mm: flush TLB when clearing young
  o mm: pretest pte_young and pte_dirty
  o mprotect propagate anon_vma
  o zap_pte_range speedup
  o anon_vma list locking bug
  o Don't hold i_sem on swapfiles
  o tmpfs: scheduling-while-atomic fix

Ian Campbell:
  o [ARM PATCH] 1926/3:  PXAFB cleanups and fixes
  o [ARM PATCH] 1930/1: Allocate correct number of pseudo palette
    entries in pxafb
  o [ARM PATCH] 1934/2:  Consolidate code to set CKEN on PXA
  o [ARM PATCH] 1933/1: Convert PXA serial driver to device model and
    implement suspend and resume
  o [ARM PATCH] 1939/1: SA1100 watchdog driver also works on PXA2xx
  o [ARM PATCH] 1953/1: Omit id for platform devices where only one can
    possibly exist
  o [ARM PATCH] 1954/2:  Make pxa platform device names more sensible

Ingo Molnar:
  o x86: remove APIC_LOCKUP_DEBUG
  o x86: remove io_apic_sync
  o NX (No eXecute) support for x86
  o enable SMP Opterons boot an NX-enabled x86 kernel
  o i386 nx prefetch fix & cleanups

Ivan Kokshaysky:
  o alpha: fix discontigmem+initrd build

Jaap Keuter:
  o [IPV4]: Calculate default broadcast even when using SIOCSIGNETMASK

Jamal Hadi Salim:
  o [NET]: Add tc extensions infrastructure
  o [NET]: Fix module refcounting of TC actions
  o [PKT_SCHED]: C99'ify act_police_ops
  o [PKT_SCHED]: In tca_action_flush, don't pass NULL netlink callback
    into ops->walk()
  o [NET]: Two tc action fixes
  o [PKT_SCHED]: Pass NET_XMIT_* status properly back through
    classifiers
  o [PKT_SCHED]: New version of u32 classifier hashing workaround

James Bottomley:
  o Advansys: Add basic highmem/DMA support
  o Fix endless loop in SCSI SPI transport class
  o SCSI: fix uninitialised variable warning
  o Enable clustering in the 53c700 driver
  o SCSI Flexible timout intfrastructure
  o [patch-kj] kernel_thread() audit drivers/scsi/aacraid/rx.c
  o HSV100 is verified as supporting REPORT LUNs
  o advansys: add warning and convert #includes
  o fix aic7xxx probing
  o Fix up fdomain after mismerge
  o ncr53c8xx turn on clustering
  o dma_get_required_mask()
  o dma_get_required_mask() build fix

James Morris:
  o [SELINUX]: Fix sock_orphan race
  o [SELINUX]: Fine-grained Netlink support - SELinux headers
  o [SELINUX]: Fine-grained Netlink support - move
    security_netlink_send() hook
  o [SELINUX]: Fine-grained Netlink support - add sk to netlink_send
    hook
  o [SELINUX]: Fine-grained Netlink support - SELinux changes
  o [IPV6]: Fix OOPS in fragmentation
  o Add security_file_permission() to AIO paths
  o Fix sock_orphan race
  o SELinux: Fine-grained Netlink support - SELinux headers update
  o SELinux: Fine-grained Netlink support - move
    security_netlink_send() hook
  o SELinux: Fine-grained Netlink support - add sk to netlink_send hook
  o SELinux: Fine-grained Netlink support - SELinux changes

Jan Gregor:
  o fix isofs ignoring noexec and mode mount options

Jan Kara:
  o Fix minor quota race
  o quota: inode->i_flags locking fixes

Jan Spitalnik:
  o USB: pegasus driver and ATEN device support

Javier Achirica:
  o [wireless airo] Clean initialization of Mini-PCI cards even from
    suspend

Jay Fenlason:
  o sunhme patch

Jean Delvare:
  o I2C: update I2C IDs
  o I2C: Drop out-of-date code in w83781d and w83627hf

Jeb J. Cramer:
  o e1000 management reset fix

Jeff Garzik:
  o [netdrvr acenic] remove unneeded ifdefs
  o [libata] don't probe from workqueue
  o [libata] PCI IDE DMA code shuffling
  o [libata] PCI IDE command-end/irq-acknowledge cleanup
  o [libata] ->qc_prep hook
  o [IDE] Introduce SATA enable/disable config option
  o [libata] put nvidia in Kconfig, in alphabetical order
  o [libata/IDE nvidia] shuffle pci ids
  o Rename 'carmel' block driver to 'sx8'
  o [libata] move some code around
  o [libata] fix build error, minor cleanups
  o [libata ata_piix] combined mode bug fix; improved ICH6 support
  o [blk carmel] s/carmel/sx8/ in the driver itself
  o [libata sata_sil] Re-fix mod15write bug
  o [netdrvr] add fec_8xx to Makefile
  o [netdrvr] disable certain drivers that are broken on 64-bit
  o [netdrvr] fix warnings found on 64-bit platforms
  o [libata] add ->qc_issue hook
  o [libata] add ata_queued_cmd completion hook
  o [libata] create, and use, ->irq_clear hook
  o [ata] add ata_ok() inlined helper, and ATA_{DRDY,DF} bit to
    linux/ata.h
  o [libata] split ATA_QCFLAG_SG into ATA_QCFLAG_{SG,SINGLE}
  o [libata] create, and use aga_sg_init[_one] helpers
  o [libata sata_promise] update driver to use new ->qc_issue hook

Jeff Mahoney:
  o reiserfs: block allocator optimizations

Jens Axboe:
  o fix cdrom mt rainier probe
  o blk: move threshold unplugging
  o cfq sysfs support
  o cfq allocation race
  o cfq direct io alias problem
  o iommu max segment size
  o deadline I/O scheduler documentation
  o only clear ->last_merge when appropriate
  o ide: idle disk on resume
  o cfq: bad allocation

Jeremy Higdon:
  o SCSI whitelist changes

Jerzy Szczepkowski:
  o Fix memory leak in epoll

Jesper Juhl:
  o isp16 check_region() removal
  o Fix warning in tdfxfb.c
  o SubmittingDrivers fix
  o tidy up the identify_cpu() output
  o cpufreq_delayed_get() inlining fix

Jesse Barnes:
  o ia64: update sn2_defconfig
  o export sys_ioctl to modules
  o ppc32: Support for new Apple laptop models
  o ia64: early console registration
  o ia64: make SN2 use 16MB granules, too
  o ia64: another sn2_defconfig update
  o ia64: update early printk for new console driver

Joe Nardelli:
  o USB: fix Memory leak in visor.c and ftdi_sio.c

Joel Soete:
  o Make ncr53c8xx respect clustering

John Lenz:
  o [ARM PATCH] 1935/1: Fix bug in sa1111 driver
  o [ARM PATCH] 1936/1: Update collie fb entries to use new style
    initializers
  o [ARM PATCH] 1938/1: Support for Collie device
  o [ARM PATCH] 1937/1: LoCoMo common device

John Levon:
  o OProfile: allow normal user to trigger sample dumps

Jon Neal:
  o USB: rndis (3/4) Big Endian support for gadget RNDIS

Jon Thackray:
  o lower priority of "too many keys" msg in atkbd.c

Jonas Munsin:
  o I2C: drivers/i2c/chips/it87.c cleanup patch

Jonas Thornblad:
  o ide: hpt36x/37x tuning fix

Jonathan Corbet:
  o Module section offsets in /sys/module

Joris van Rantwijk:
  o Validate PM-Timer rate at boot time

Joseph Fannin:
  o ppc32: command_line_size build fix

Josh Litherland:
  o md: XOR template selection redo

Joël Bourquard:
  o Add support for ISD-300 controller

Jörn Engel:
  o Add m68k support to checkstack
  o small fixes to checkstack

Kai Engert:
  o USB: enable pwc usb camera driver

Kalin Rumenov Kozhuharov:
  o Translate Japanese comments in arch/v850

Karsten Desler:
  o [NET]: Fix typos in pktgen docs

Keith Owens:
  o ia64: Rename SN "modules" variable to "sn_modules"
  o ia64: Remove warnings when unwind debug is turned on
  o ia64: Support SN platform specific error features
  o contify some scheduler functions
  o kallsyms: exclude kallsyms-generated symbols
  o kallsyms: verify that System.map is stable
  o kallsyms ppc32 fix

Kenneth W. Chen:
  o ia64: fix race in fsys_bubble_down to avoid fp-register corruption
  o Hugetlb page bug fix for i386 in PAE mode
  o hugetlb.c: use safe iterator
  o hugetlb.c - fix try_to_free_low()
  o per node huge page stats in sysfs
  o Fix direct I/O into hugetlb page
  o ia64: change ia64_switch_mode_{phys,virt}() to preserve bsp/sp
  o ia64: Clean up needlessly large stack frames in PAL-call stubs
  o ia64: fix incorrect initialization of ar.k4 for BP

Kevin Corry:
  o kcopyd commentary
  o dm: Documentation
  o dm: Create/destroy kcopyd on demand
  o dm: Use structure assignments instead of memcpy
  o dm: dm-io: Error handling
  o dm: dm-raid1.c: Make delayed_bios a bio_list
  o dm: dm-raid1.c: Use list_for_each_entry_safe
  o dm: kcopyd.c: Remove unused include
  o dm: kcopyd.c: make client_add() return void
  o dm: dm-raid1.c: Enforce max of 9 mirrors
  o dm: dm-raid1.c: Use fixed-size arrays
  o dm: Remove 1024 devices limitation

Krzysztof Rusocki:
  o cmpci oops on rmmod + fix

Kumar Gala:
  o PPC: Add support for ADS8272 board
  o ppc32: support for e500 and 85xx
  o Add PPC85xx MAINTAINERS entry
  o ppc32: CPM UART fixes

Len Brown:
  o Kconfig typo fix from Jochen Voss
  o [ACPI] PCI IRQ update (Bjorn Helgaas)
    http://bugme.osdl.org/show_bug.cgi?id=2574
  o [ACPI] fix !CONFIG_PCI build (Bjorn Helgaas)
  o [ACPI] acpi=force overrides blacklist pci=noacpi or acpi=noirq
    (Andi Kleen)
  o [ACPI] *** Warning: "acpi_register_gsi"
    [drivers/serial/8250_acpi.ko] undefined!
  o [ACPI] mp_find_ioapic() oops from mp_register_gsi() on device
    resume
  o [ACPI] delete "__init" from x86_64 version of mp_find_ioapic()
    Signed-off-by: Andrew Morton <akpm@osdl.or
  o [ACPI] Fix a lockup which Sid Boyce <sboyce@blueyonder.co.uk>
    discovered with IOAPIC disabled.
  o [ACPI] PCI bus numbering workaround for ServerWorks from David
    Shaohua Li http://bugzilla.kernel.org/show_bug.cgi?id=1662
  o [ACPI] fix passive cooling mode indicator (Luming Yu)
    http://bugzilla.kernel.org/show_bug.cgi?id=1770
  o [ACPI] avoid spurious interrupts on VIA
    http://bugzilla.kernel.org/show_bug.cgi?id=2243
  o [ACPI] handle SCI override to nth IOAPIC
    http://bugzilla.kernel.org/show_bug.cgi?id=2835
  o [ACPI] fix double timer interrupt mapping (Hans-Frieder Vogt)
    caused by errant fix for OSDL 2835
  o [ACPI] re-factor previous mpparse IRQ override fix (Linus Torvalds)
    Reflect that only the dstirq depends on the dstapic.

Lennert Buytenhek:
  o PCI: New PCI vendor/device ID for Radisys ENP-2611 board

Linas Vepstas:
  o PCI Hotplug: rpaphp null pointer deref
  o PCI Hotplug: RPAPHP structure size/performance
  o ppc64: remove deprecated firmware API
  o ppc64: EEH fixes for POWER5 machines (1/2)
  o ppc64: EEH fixes for POWER5 machines (2/2)
  o ppc64: RTAS error log locking fix

Linda Xie:
  o PCI Hotplug: rpaphp.patch -- multi-function devices not handled
    correctly
  o PCI: export pci_scan_child_bus for the pci hotplug drivers to use

Linus Torvalds:
  o Fix kill_pg_info(): return success if _any_ signal succeeded
  o This removes the files orphaned by the earlier PC9800 removal
  o Remove old stale header files that aren't referenced anywhere
  o sparse: fix up fusion/mptctl.c after merge
  o Follow 2.4.x semantics for in-kernel signal sending
  o Fix up permissions of some files that were not readable by "other".
    The normal permissions for the kernel tree should be -rw-r--r--.
  o Fix C99'ism that breaks older gcc's
  o sparse: clean up warning in swapfile.c
  o Make bitops/cpumask functions be "const" where appropriate
  o ppc64: fix silly typo ("1" vs "i")
  o sparse: fix pointer/integer confusion
  o sparse: get rid of more integer/pointer confusion
  o logo/logo.c needs <stddef.h> for NULL
  o sparse: annotate signal handler and ss_sp as user pointers
  o ppc64: export the user copy functions
  o Linux 2.6.8-rc1

Ludovic Aubry:
  o USB: Use 64-bit IO addresses in UHCI driver

Luiz Capitulino:
  o qla1280.c warning fix
  o unchecked kmalloc in sr_audio_ioctl()
  o drivers/char/ipmi/ipmi_si_intf.c warnings
  o CREDITS update
  o net/at1700.c depends on MCA_LEGACY
  o net/ne2.c needs MCA_LEGACY

Manfred Spraul:
  o rcu lock update: Add per-cpu batch counter
  o rcu lock update: Use a sequence lock for starting batches
  o rcu lock update: Code move & cleanup
  o hwcache align kmalloc caches
  o reduce function inlining in slab.c

Marc Singer:
  o [ARM PATCH] 1928/1: lh7a40x #7 Changes to memory model to support
    contiguous SDRAM
  o [ARM PATCH] 1913/1: lh7a40x #3 (1/2) serial

Marcel Holtmann:
  o [Bluetooth] Fix connection creation error handling
  o [Bluetooth] Fix config change for firmware loading
  o [Bluetooth] Change inquiry_cache to hci_inquiry_cache
  o [Bluetooth] Fix deadlock in the 3Com driver
  o [Bluetooth] Fix kobject oops on firmware loading
  o [Bluetooth] Add HID protocol support
  o [Bluetooth] Allocate protocol number for AVDTP support

Marcel Sebek:
  o [NETFILTER]: ip6t_LOG and packets with hop-by-hop options

Marcelo Tosatti:
  o update Marcelo CREDITS info

Margit Schubert-While:
  o prism54: Kernel compatibility
  o prism54: Fix endian patch
  o prism54: Fix bugs 74/75
  o prism54: Fix bugs 39/73
  o prism54: Fix bug 77, strengthened oid txn
  o prism54: Don't allow mib reads while unconfigured
  o prism54: Add likely/unlikely, KO wds completely
  o prism54: Align skb patch
  o prism54: Reduce module verbosity
  o prism54: Fix channel stats, bump version to 1.2
  o prism54: Fix typo
  o prism54: White space and indentation
  o prism54 cleanup functions
  o prism54 missing error check
  o prism54 fix unlikely
  o prism54 device list cleanup
  o prism54 remove prog reg poke
  o prism54 use set_pci_mwi()

Mark Haverkamp:
  o aacraid 32bit app ioctl compat patch (Updated)

Mark M. Hoffman:
  o I2C: add alternate VCORE calculations for w83627thf and w83637hf
  o I2C: add alternate VCORE calculations for w83627thf and w83637hf

Mark W. McClelland:
  o Add ovcamchip driver

Markus Lidel:
  o get I2O working with Adaptec's zero channel
  o remove calls of obsolete scsi APIs in i2o_scsi

Martin J. Bligh:
  o make __free_pages_bulk more comprehensible
  o ia32 NUMA: physnode_map entries can be negative
  o fix up physnode_map

Martin Schwidefsky:
  o s390: lost dirty bits
  o 64 bit bug in radix-tree lookup
  o s390: core changes
  o s390: cpu-idle notifier
  o s390: cpu hotplug support
  o s390: cpu hotplug bugs

Matt Domsch:
  o EDD: store mbr_signature on first 16 int13 devices
  o EDD: x86-64 build fix

Matt Porter:
  o Add PPC4xx MAINTAINERS entry, merge CREDITS from 2.4
  o ppc32: PPC44x defconfig update and fixes
  o ppc32: PPC4xx preempt fix
  o ppc32: Fix dual UICs in 4xx PIC support
  o ppc32: Redwood[56] support for smc91x Ethernet driver

Matthew Dharm:
  o USB Storage: GetMaxLUN tightening
  o USB Storage: INQUIRY fixup, mode-sense options, Genesys devices
  o USB Storage: Fix race when removing the SCSI host
  o USB Storage: Lexar Jumpshot CF reader
  o USB: Patch to signal underflow in usb-storage driver

Matthew Wilcox:
  o ahc1542 !CONFIG_MCA build fix
  o ncr53c8xx updates

Maxim Shchetynin:
  o s390: zfcp host adapter

Maximilian Attems:
  o [patch-kj] kernel_thread() audit drivers/scsi/aacraid/rkt.c
  o kernel_thread() audit drivers/scsi/aacraid/sa.c

Michael Geng:
  o saa5246a Videotext driver update

Michael Hunold:
  o drivers/media/video/tda9840.c: honour return code of
    i2c_add_driver()

Mika Kukkonen:
  o NTFS: sparse fix: void function with return (value)
  o Comment out an unused function in drivers/scsi/wd7000.c
  o sparse: kernel/module.c sparse fix
  o sparse: lib/string.c sparse fix
  o Uninline machine_specific_memory_setup()
  o Fix sparse warning in fs/devfs/base.c
  o Fix sparse warning in fs/proc/base.c
  o Fix sparse warning in drivers/block/ll_rw_blk.c
  o sparse: fixes for "assignment expression in conditional" in fs/*
  o sparse: fix ugly include/linux/efi.h typedef
  o Combined patch for remaining trivial sparse warnings in allnoconfig
    build
  o sparse: NULL vs 0 - arch/i386/*
  o sparse: NULL vs 0 - drivers/acpi/*
  o sparse: NULL vs 0 - drivers/char/*
  o sparse: NULL vs 0 - rest of drivers
  o sparse: NULL vs 0 - drivers/usb
  o sparse: NULL vs 0 - filesystems
  o sparse: NULL vs 0 - net/*
  o sparse: NULL vs 0 - sound/*
  o sparse: NULL vs 0 - the rest of it
  o Fix sound/isa/gus/* compile error without CONFIG_PNP
  o sparse: define max kernel symbol length and clean up errors in
    kernel/kallsyms.c
  o sparse: fix sparse warnings in kernel/power/*
  o sparse: fix sparse in drivers/pnp/pnpbios/*
  o Remaining sparse warnings in allnoconfig
  o sparse: remaining integer zero / NULL fixes in allmodconfig &
    vmlinux
  o Fix sparse warnings in fs/udf/*
  o sparse: fix remaining three non-ANSI warnings
  o Use NULL instead of integer 0 in security/selinux/
  o int return to unsigned in smb_proc_readdir_long() in
    fs/smbfs/proc.c
  o Remove always false check in mm/slab.c
  o Correct return type of hashfn() in fs/dquot.c
  o Fix misplaced 'inline' in include/linux/iso_fs.h

Mikael Pettersson:
  o ppc32 irq.c cpumask fix

Mike Christie:
  o SCSI: remove extra queue unplug calls

Mike Miller:
  o cciss ioctl32 update

Mikulas Patocka:
  o HPFS fixes for 2.6.7 kernel

Miles Bader:
  o v850: guard declaration of handle_IRQ_event with #ifdef
    !__ASSEMBLY__
  o v850: add missing end-of-line backslash to vmlinux.lds.S
  o v850: add find_next_bit
  o v850: remove bogus __ARCH_WANT_ macro defs
  o make CONFIG_SYSVIPC depend on CONFIG_MMU
  o v850: Get rid of lvalue-casts in memset.c to make gcc happy
  o v850: Use __volatile__ qualifier on test_bit asm statements
  o v850: Return value from no_action in irq.c

Natalie Protasevich:
  o es7000 subarch update for target_cpus()

Nathan Scott:
  o [XFS] No longer hold the BKL for the entire ioctl operation, its
    not needed here.
  o [XFS] Remove a couple of redundant NULL parent inode pointer checks
  o [XFS] Fix xfs_lowbit64, it mishandled zero in the high bits
  o [XFS] sparse: fix uses of macros before their definitions, etc
  o [XFS] Ensure buffers that map to unwritten extents are only
    submitted when properly setup.
  o [XFS] Sanitise the ACL initialisation macros
  o [XFS] Remove unused MAC macros, never needed on Linux
  o [XFS] Remove the one remaining, broken use of XFS_WRITEIO_LOG and
    sanitize direct IO map blocks call.
  o [XFS] Fix flags argument to xfs_incore call on attr removal
  o [XFS] Fix a race condition in the undo-delayed-write buffer routine
  o [XFS] Fix up memory allocators to be more resilient
  o [XFS] Fix up highmem build and error handling on inode shrink
    register

Neil Bortnak:
  o USB: add support for Buffalo LUA-U2-KTX

Neil Brown:
  o Fix raid1 read_balancing code
  o md: Fix up handling for read error in raid1
  o knfsd: simplify nfsd4 name encoding
  o knfsd: simplify nfsd4_release_lockowner
  o knfsd: delete an obsolete comment from nfsd rpc code
  o knfsd: reduce stack usage in nfsd4
  o knfsd: improve cleaning up of nfsd4 requests
  o Use llseek instead of f_pos= for directory seeking

Nemosoft Unv.:
  o USB: PWC 9.0.1

Nick Piggin:
  o Fix read() vs truncate race
  o lindent rwsem

Nicolas Pitre:
  o [ARM PATCH] 1932/1: fix comment about cache handling syscall
  o [ARM PATCH] 1942/1: basic LCD support for the PXA270/Mainstone
    board
  o move prototype for __get_vm_area() to a sane location
  o [ARM PATCH] 1948/1: Mainstone compile fix
  o [ARM PATCH] 1949/1: warning fix
  o [ARM PATCH] 1950/1: SIZEOF_MACHINE_DESC requires asm/constants.h

Olaf Hering:
  o ppc64: avoid multiline /proc/cmdline content on iSeries
  o [DECNET]: Fix signed bug in
    net/decnet/dn_nsp_in.c:dn_nsp_linkservice()
  o signed bug in drivers/video/console/fbcon.c con2fb_map[]
  o ppc32: biarch gcc support
  o ppc32: serial console autodetection

Oleg Nesterov:
  o kill mm_struct.used_hugetlb

Oliver Neukum:
  o USB: proper evaluation of the union descriptor for CDC ACM
  o USB: error handling of open of acm driver
  o USB: fix racy access to urb->status in cdc acm driver
  o USB: fix race between disconnect and write of acm driver
  o USB: add printer reset ioctl
  o USB:  patches to acm driver
  o USB: another error check in acm
  o USB: GFP_KERNEL in irq
  o USB: kaweth not handling ESHUTDOWN

Oswald Buddenhagen:
  o PCI: (one more) PCI quirk for SMBus bridge on Asus P4 boards

Pantelis Antoniou:
  o add new fec_8xx network driver

Pat Gefre:
  o ia64: fix SN2 interrupt rerouting

Pat LaVarre:
  o ata_check_bmdma

Patrick McHardy:
  o [NETFILTER]: Fix non-existant config option for IP_NF_ASSERT, fix
    some broken assertions
  o [NETFILTER]: complain about brokeness on SMP for pid, sid and
    command matching in ipt_owner
  o [NETFILTER]: Change permissions of /proc/net/ip_conntrack to 0440
  o [NETFILTER]: skip internal targets in iptables proc listing
  o [NETFILTER]: Fix inverted matching in ipt_helper
  o [NETFILTER]: 'any' matching in ipt_helper
  o [NETFILTER]: Don't reroute on nfmark change in mangle table when
    routing by nfmark is not enabled
  o [NETFILTER]: Fix expectation eviction order
  o [NETFILTER]: Fix offset calculation in amanda conntrack helper
  o [NETFILTER]: Relax hook check in ipt_CLASSIFY
  o [NETFILTER]: Add new function 'nf_reset' to reset netfilter related
    skb-fields
  o [NETFILTER]: Add addrtype match
  o [NETFILTER]: Add realm match
  o [NETFILTER]: ip_table_raw C99 initialization
  o [NETFILTER]: Fix IP_NF_TARGET_NOTRACK config deps

Patrick Mochel:
  o [Driver Model] Consolidate attribute definition macros
  o [Driver Model] Fix up silly scsi usage of DEVICE_ATTR() macros
  o [sysfs] Add attr_name() macro
  o [Driver Model] Add default attributes for classes class devices
  o [Driver Model] Add default attributes for struct bus_type
  o [Driver Model] Add default device attributes to struct bus_type

Paul Focke:
  o v4l: radio-zoltrix fix

Paul Fulghum:
  o ppp_synctty.c receive/write_wakeup fix
  o ppp_generic.c get_filter made conditional

Paul Jackson:
  o cpumask: make cpu_present_map real even on non-smp
  o cpumask: bitmap cleanup preparation for cpumask overhaul
  o cpumask: bitmap inlining and optimizations
  o cpumask: remove 26 no longer used cpumask*.h files
  o cpumask: remove obsolete cpumask macro uses - i386 arch
  o cpumask: remove obsolete cpumask macro uses - other archs
  o cpumask: Remove no longer used obsolete macro emulation
  o cpumask: optimize various uses of new cpumasks
  o cpumask: comment, spacing tweaks
  o remaining cpumask const qualifiers
  o Fix ia64 UPF_RESOURCES pcdp.c 2.6.7-mm5 build
  o sparc32 cpumask bitop build fix

Paul King:
  o Telephony Driver ISAPNP fix
  o telephony: support devfs

Paul Mackerras:
  o ppc64: Implement CONFIG_PREEMPT
  o ppc64: Optimize exception/syscall entry/exit
  o Handle altivec assist exception properly
  o ppc64: clean up prom.c and related files
  o Better memset
  o Clean up head.S whitespace
  o ppc64: fix memset
  o ppc64: janitor log_rtas_error() call arguments
  o ppc64: Janitor rtas_call() return variables
  o ppc64: set ppc_md.log_error
  o ppc64: fix unbalanced dev_get/put calls in EEH code
  o ppc64: enable EEH on PCI host bridges

Paul Mundt:
  o asiliantfb init fix
  o sh: SH-3 On-Chip ADC support
  o sh: dma-mapping updates
  o sh: DMA driver updates
  o sh: early printk() cleanup
  o sh: fixmap support
  o sh: Renesas HS7751RVoIP board support
  o sh: IDE cleanup
  o sh: ptep_get_and_clear() compile fix
  o sh: sh-sci updates
  o sh: SolutionEngine 7300 board support
  o sh: Renesas RTS7751R2D board support
  o sh: PCI updates
  o sh: SH7705/SH7300 subtype support, ST40 updates
  o sh: VoyagerGX companion chip support
  o sh: merge
  o sh: Consolidate SystemH with other Renesas boards
  o sh64 support
  o sh64: Fix syscall table alignment
  o kyrofb: Fix modedb usage when built as a module
  o sh/sh64: MAINTAINERS update
  o swap_unplug_io_fn() nommu update
  o sh64: cpumask cleanup
  o sh64: Fix init_task.c build
  o sh64: Add asm-sh64/setup.h
  o sh64: defconfig update

Paul Serice:
  o iso9660: fix handling of inodes beyond 4GB
  o iso9660: NFS fix

Pavel Machek:
  o io_apic.c code consolidation
  o Fix memory leak in swsusp
  o swsusp minor docs updates
  o Prepare for SMP suspend
  o swsusp: shuffle cpu.c to make it usable for smp suspend
  o swsusp.S: meaningful assembly labels
  o swsusp: preparation for smp support & fix device suspending

Pawe³ Sikora:
  o ad1889 warning fix

Peter Chubb:
  o Fix Alpha compilation

Peter Oberparleiter:
  o s390: sclp console driver

Peter Osterlund:
  o Can't open CDROM device for writing

Peter Tiedemann:
  o s390: network driver changes
  o s390: ctc driver changes

Petr Slansky:
  o USB: PL2303 module, new IDs

Petr Vandrovec:
  o Decrease stack usage in ncpfs's ioctl
  o [VLAN]: Do not access released memory

Ralf Bächle:
  o Use netdev_priv in sgiseeq
  o Reformat
  o Cosmetic cleanups to sb1250-mac.c
  o hdlcdrv needs to stop queueing
  o mips: remove old junk
  o DS1286 cleanups
  o Cobalt LCD Driver update
  o Add M48T35 RTC driver
  o mips: SGI A2 audio rewrite and 2.6 fixes
  o MIPS Update
  o Indydog update
  o mips: kconfig spelling fixes
  o mips: update config symbols
  o mips: MIPS updates
  o mips: MAINTAINERS updates
  o mips: MIPS needs a 32-bit ioaddr_t
  o mips: delete IRIX emul misc minors

Randy Dunlap:
  o fix check_region usage in eata_pio
  o Remove PC9800 support
  o istallion printk fix
  o remove blank line in show_trace()
  o sparse: make sys_quotactl() prototype match function
  o update ikconfig help text
  o fdomain screwup
  o convert private ABS() to kernel's abs()
  o smbfs compilation warning fix

Rene Herman:
  o pc9800: merge std_resources.c back into setup.c
  o small tweaks to standard resource stuff
  o same small resource tweaks, x86_64 version

Rick Sewill:
  o USB: usb on big endian, ehci needs a byteswap

Ricky Beam:
  o [libata sata_sil] add drive to mod15write quirk list

Robert Picco:
  o ia64: mark non-existent NUMA-nodes as offline
  o HPET driver
  o hpet fixes
  o hpet fixes

Robert T. Johnson:
  o 2.6.7-rc3 drivers/usb/core/devio.c: user/kernel pointer bugs
  o drivers/scsi/megaraid.c: user/kernel pointer bugs
  o drivers/char/ipmi/ipmi_devintf.c: user/kernel pointer typo

Robin Holt:
  o ia64: Fixups for the SN2 Block Transfer Engine

Roger Luethi:
  o Nuke HAS_IP_COPYSUM for net drivers
  o Nuke HAS_IP_COPYSUM
  o Nuke CanHaveMII and related code
  o Nuke HasESIPhy and related code
  o Nuke default_port, references to if_port, medialock
  o Nuke all pci_flags
  o Return codes for rhine_init_one
  o Rewrite special-casing
  o Add rhine_power_init(): get power regs into sane state
  o PCI: Fix PME bits in pci.txt
  o PCI: Fix off-by-one in pci_enable_wake

Roland Dreier:
  o PCI: Fix MSI-X setup
  o PCI: Add some PCI Express constants to pci.h

Roland McGrath:
  o fix x86-64 ptrace access to 32-bit vsyscall page

Roman Zippel:
  o update ikconfig generator script

Russell Cattelan:
  o [XFS] Fix for NFS+XFS data corruption problem

Russell King:
  o Add platform_get_resource()
  o add ARM smc91x driver
  o [ARM] Add clock API
  o [ARM] pxafb doesn't need to include asm/mach-types.h
  o [ARM] Add support code for ARM hardware vector floating point
  o Clean up asm/pgalloc.h include
  o Clean up asm/pgalloc.h include
  o Clean up asm/pgalloc.h include 3
  o [ARM] Remove TBOX
  o [ARM] Remove NexusPCI/FTVPCI platform
  o Couple of sysfs patches
  o [PCMCIA] Add Cirrus PD6729 PCMCIA bridge support
  o [PCMCIA] 02-validatemem
  o [PCMCIA] 03-memwin
  o [PCMCIA] 04-memres
  o [PCMCIA] 05-nonbusy
  o [PCMCIA] 06-ide
  o [ARM] Move cpu_switch_mm() and cpu_get_pgd() to asm/proc-fns.h
  o [ARM] Correct MMCI clock rate on Integrator/CP
  o [ARM] Fix Integrator/CP timer support
  o [ARM] Fix platform device registration
  o [ARM] Fix EBSA110 timer functions
  o [ARM] Fix Footbridge timer functions
  o [ARM] Fix acornfb build error
  o [PCMCIA] Fix bogus align value
  o [ARM] Fix SA1100 build after timer changes
  o ARM COMMAND_LINE_SIZE build fix
  o [ARM] Update ARM kernel install script
  o [ARM] Move ZTEXTADDR/ZBSSADDR initialisation to compressed/Makefile
  o [ARM] arch/arm/boot variable name consistency
  o [ARM] Fix install/zinstall to work with separated source/build
    trees
  o [ARM] Convert bootp to use kbuild infrastructure
  o [ARM] Kernel boot decompressor updates
  o [ARM] Prevent static data in misc.o
  o [ARM] EBSA110 I/O and decompressor fixes
  o [ARM] arch/arm/Makefile cleanups
  o [ARM] Move ISA_DMA_THRESHOLD to asm/memory.h
  o [ARM] Move arch_adjust_zones to asm/memory.h
  o [ARM] Reliably update SIZEOF_MACHINE_DESC
  o [ARM] MMC mclk is no longer used, so remove it
  o [ARM] Miscellaneous fixes
  o Provide console_device()
  o Provide console_suspend() and console_resume()
  o PCMCIA net device unplugging ordering fix
  o [SERIAL] Remove UPF_RESOURCES
  o [ARM] asm/arch-versatile/uncompress.h does not need linux/kernel.h
  o [ARM] Timer fixes for CLPS711x
  o [ARM] Use platform_get_resource/platform_get_irq in sa1111.c
  o [ARM] Usual mach-types update
  o Back out smc91x late collision "performance" hack
  o [ARM] Remove asm/hardware.h from SMC91x ethernet driver
  o [ARM] Fix allocation of 8390 ethernet device structure in etherh
  o [ARM] Fix two bugs in Acorn expansion card subsystem
  o [PCMCIA] Clean up class device attribute registration and fix build
    error

Rusty Russell:
  o Move saved_command_line to init/main.c
  o clean up cpumask_t temporaries
  o Fix race between CONFIG_DEBUG_SLABALLOC and modules
  o trivial: little arch_i386_kernel_timers_timer_none.c fix
  o trivial: arch_i386_kernel_scx200.c: kill duplicate #include
  o trivial: kill off CONFIG_PCI_CONSOLE

Ryan Anderson:
  o orinoco.c rate limit lost information frame message

Sam Ravnborg:
  o wanxl firware build fix
  o Avoid rebuild of IKCFG when using O=
  o kbuild: add deb-pkg target

Scott Cytacki:
  o USB: kyocera 7135 patch

Sean Young:
  o USB: PhidgetServo driver fixes

Sebastian Henschel:
  o sysfs: fs/sysfs/inode.c: modify parents ctime and mtime on creation

Siegfried Hildebrand:
  o Re: Problems with cyberjack usb-serial-module since kernel 2.6.2

Simon Kelley:
  o [Bug 2948] New: Atmel wireless driver Oopses

Stas Sergeev:
  o larger IO bitmaps
  o vm86: set IOPL to 3 on pushf

Stefan Weinhuber:
  o s390: dasd driver changes

Stelian Pop:
  o sonypi driver update (PM and DMI VGN-)
  o meye driver update (wait_ms -> msleep)

Stephen D. Smalley:
  o SELinux: Extend and revise calls to secondary module
  o SELinux: fix build with CONFIG_SECURITY_NETWORK=n

Stephen Hemminger:
  o fix oops from acenic ethtool
  o [ATM]: Include compiler.h in atm.h
  o [SPARSE]: Get rid of warning in irtty_ioctl()
  o [SPARSE]: Add annotations to sock_filter.h
  o [SPARSE]: Annotate csum_and_copy_to_user()
  o [SPARSE]: Get rid of warning in bridge ethtool ioctl
  o [SPARSE]: Fix another net warning
  o [BRIDGE]: Kill sysfs hotplug avoidance hacks
  o [PKT_SCHED]: Delay scheduler enqueue always succeeds
  o [PKT_SCHED]: Delay scheduler should retry if requeue fails
  o [PKT_SCHED]: Add loss option to network delay scheduler
  o convert sk fddi driver to ANSI C
  o PCI: remove duplicate in pci_ids.h
  o PCI: fix out of order entry in pci_ids.h
  o PCI: add id's for sk98 driver
  o [NET]: rtentry->rt_dev is __user
  o [IPV4]: ip_rt_ioctl argument is user pointer
  o [BRIDGE]: Turn off debug message in bridge ioctl
  o [PKT_SCHED]: Packet scheduler exports
  o [PKT_SCHED]: Bad TDIFF_SAFE in csz
  o [PKT_SCHED]: Eliminate guard from TDIFF_SAFE
  o [PKT_SCHED]: Use get_jiffies_64()
  o [BRIDGE]: Fix message age in bridge STP config packets
  o (1/3) skfp - cleanup is_XXX functions
  o (2/3) skfp -- sparse __user annotation
  o [sparse] get rid of warnings about #if DEBUG
  o get rid of __OPTIMIZE__ requirement in net drivers
  o skfddi - fix warning
  o skfddi - cleanup local and dead functions
  o [TCP]: TCP acts like it is always out of memory
  o [NET]: Allow large MTU on dummy net device
  o [PKT_SCHED]: Update to network emulation QOS scheduler
  o [PKT_SCHED]: Two small netem fixes

Stephen Rothwell:
  o PPC64 iSeries fails to boot
  o ppc64: vio infrastructure modifications
  o ppc64: iseries_veth integration
  o ppc64: viodasd integration
  o ppc64: viocd integration
  o ppc64: viotape integration

Steve French:
  o fix throttle to limit number of requests to 50 on wire to server at
    one time
  o Fix /proc/fs/cifs/Stats to handle larger return data, and correct
    Kconfig reference to /proc/fs/cifs/Stats
  o fix typo in cifs kernel config option title
  o Fix typo in name of CIFS Kconfig option and add rename stats
  o Do not send junk in bcc area of oplock break SMB Lock request, and
    always let oplock break release through even if requests are ahead
    of it waiting for responses to complete.
  o check better for free files on writepage retry
  o Do not kill cifsd thread until last smb session on tcp session is
    SMBulogged off.  Fixes umounting bug (pointed out by Nick
    Millington) when multiple mounts with different userids are mounted
    to the same server from the client.  
  o Do not loop in cifsd demultiplex thread when someone sigkills it
  o Fix cifs xid transaction counts to be more consistent. Start using
    __set_page_dirty_no_buffers
  o hash cifs inodes
  o merge /proc/fs/cifs/SimultaneousOps into /proc/fs/cifs/Stats

Stéphane Eranian:
  o ia64: fix info in /proc/pal/*/bus_info
  o ia64: perfmon stack consumption fix

Tao Huang:
  o USB: rndis (2/4) fix memory leaks

Theodore Y. T'so:
  o Ext3: Retry allocation after transaction commit (v2)

Thierry Vignaud:
  o checksatck.pl fixes

Thomas Winischhofer:
  o sisfb update 1.7.10

Tigran Aivazian:
  o fix to microcode driver for the old CPUs

Tim Schmielau:
  o BSD accounting format rework

Tom L. Nguyen:
  o Fix and Reenable MSI Support on x86_64

Tom Nguyen:
  o msi TARGET_CPUS fix

Tom Rini:
  o [PPC32] Add SysRq-G support to our KGDB stub
  o [PPC32] Change how we handle DP memory on MPC8xx
  o [PPC32] Update CPM2 (MPC82xx/MPC85xx) code to use rheap for DP
    memory Originally from: Rune Torgersen <runet@innovsys.com>
  o Add <linux/compiler.h> to <linux/fd.h>
  o ppc32: OCP for MP10x

Tomas Olsson:
  o getgroups16() fix

Tony Lindgren:
  o [ARM PATCH] 1931/1: Allow device address translation in
    dma-mapping, version 3
  o [ARM PATCH] 1943/1: OMAP compile fix
  o [ARM PATCH] 1947/1: Remove unused async_struct in OMAP pm.h

Tony Luck:
  o ia64: switching between CPEI & CPEP
  o ia64: fix reloc-out-of-range error on module loading

Torrey Hoffman:
  o USB: ATI Remote driver update

Torsten Scherer:
  o USB Storage: unusual_devs.h addition

Ulrich Weigand:
  o s390: signals & exceptions

Vojtech Pavlik:
  o I2C i2c-piix: Don't treat ServerWorks servers as Laptops

Wen-chien Jesse Sung:
  o snd_ctl_read() fix fix

Will Schmidt:
  o ppc64: update lparcfg to use seq_file

William Lee Irwin III:
  o x86_64 numa cpumask build fix
  o APIC enumeration fixes
  o apic: fix kicking of non-present cpus
  o apic: remove marking of non-present physids in phys_cpu_present_map
  o apic: make mach_default compile again
  o [IRDA]: Remove usage of isa_virt_to_bus()
  o alpha: cpumask fixups
  o make irqaction use a cpu mask
  o tweak the buddy allocator for better I/O merging
  o oom killer: ignore free swapspace
  o [AIO]: kiocb->private is too large for kiocb's on-stack
  o force O_LARGEFILE in sys_swapon() and sys_swapoff()
  o spurious remap_file_pages() -EINVAL

Wim Van Sebroeck:
  o watchdog: indydog.c update

Yanmin Zhang:
  o ia64: fix free_huge_page() call in hugetlb_prefault()

Yoav Zach:
  o Handle non-readable binfmt_misc executables
  o binfmt misc fd passing via ELF aux vector

Yoshinori Sato:
  o H8/300: ptrace fix
  o H8/300: io.h cleanup
  o H8/300: smc9194 driver
  o h8300: delete obsolute header

Yury Umanets:
  o memory allocation checks in eth1394_update()
  o memory allocation checks in mtdblock_open()
  o memory allocation checks in cs46xx_dsp_proc_register_scb_desc()

Zinx Verituse:
  o USB: hid-tmff fix

Zwane Mwaikambo:
  o Allow i386 to reenable interrupts on lock contention
  o Remove smbfs server->rcls/err
  o Fix smbfs readdir oops

