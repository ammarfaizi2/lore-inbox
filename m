Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268664AbUI3Diz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268664AbUI3Diz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Sep 2004 23:38:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268677AbUI3Diz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Sep 2004 23:38:55 -0400
Received: from fw.osdl.org ([65.172.181.6]:34514 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S268664AbUI3Dht (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Sep 2004 23:37:49 -0400
Date: Wed, 29 Sep 2004 20:37:46 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Linux 2.6.9-rc3
Message-ID: <Pine.LNX.4.58.0409292036010.2976@ppc970.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Ok, this 2.6.9 cycle is getting too long, but here's a -rc3 and hopefully 
we're getting there now.

Architecture updates, networking, drivers, sparse annotations. You name 
it.

		Linus

---

Summary of changes from v2.6.9-rc2 to v2.6.9-rc3
============================================

<ananth:broadcom.com>:
  o [libata sata_svw] race condition fix, new device support

Aaron Grothe:
  o [CRYPTO]: Whirlpool algorithm updates

Adam Kropelin:
  o input: Add 64-bit compatible ioctls for hiddev
  o This patch fixes another disconnect oops in hiddev

Alan Cox:
  o serial-cs and unusable port size ranges
  o tty locking cleanup and fixes

Alan Modra:
  o ppc64: give the kernel an OPD section

Alasdair G. Kergon:
  o device-mapper: fix minor number check
  o device-mapper: rename emit macro

Alex Williamson:
  o [IA64] discontig.c: fixup pxm_to_nid_map
  o [IA64] sba_iommu.c: sba_iommu NUMA locality
  o [IA64] iosapic.h, pci.c, iosapic.c, acpi.c: iosapic NUMA interrupt
    locality
  o fix compat_do_execve stack usage

Alexander Viro:
  o cifs: annotate NEGOTIATE_{REQ,RESP}
  o cifs: annotate DELETE_FILE_{REQ,RESP}
  o cifs: annotate DELETE_DIRECTORY_{REQ,RESP}
  o cifs: annotate CREATE_DIRECTORY_{REQ,RESP}
  o cifs: annotate OPEN_{REQ,RESP}, endianness bugfix
  o cifs: annotate READ_{REQ,RESP}
  o cifs: annotate WRITE_{REQ,RESP}
  o cifs: annotate LOCK_{REQ,RESP}
  o cifs: annotate RENAME_{REQ,RESP}
  o cifs: annotate TRANSACTION2_SFI_{REQ,RESP}
  o cifs: annotate COPY_{REQ,RESP}, minor endianness bugfix
  o cifs: annotate TRANSACTION2_SPI_{REQ,RESP}
  o cifs: annotate NT_RENAME_{REQ,RESP}
  o cifs: annotate TRANSACTION2_QPI_{REQ,RESP}
  o cifs: annotate TRANSACT_IOCTL_{REQ,RESP}
  o cifs: annotate TRANSACTION2_FFIRST_{REQ,RESP}, typo fix in
    CIFSSMBFindSingle()
  o cifs: annotate TRANSACTION2_FNEXT_{REQ,RESP}
  o cifs: annotate TRANSACTION2_GET_DFS_REFER_{REQ,RESP}, minor
    endianness bugfix
  o cifs: annotate TRANSACTION2_QFSI_{REQ,RESP}
  o cifs: annotate file_..._info
  o cifs: annotate TRANSACT_CHANGE_NOTIFY_{REQ,RESP}
  o cifs: annotate fea{,list}, endianness bugfix
  o cifs: annotate stat-related structures
  o cifs: annotate FILE_DIRECTORY_INFO, clean up cifs_readdir()
  o cifs: annotate FILE_SYSTEM_DEVICE_INFO
  o cifs: annotate FILE_SYSTEM_ATTRIBUTE_INFO
  o cifs: annotate T2_F{FIRST,NEXT|_RSP_PARMS
  o cifs: annotate smb_hdr
  o cifs: annotate TCONX_{REQ,RESP}
  o cifs: annotate SESSION_SETUP_ANX
  o cifs: assorted endianness bugfixes
  o cifs: IPv4-related endianness annotations and bugfixes
  o sysvfs endianness annotations and bugfixes
  o ext3 endianness annotations and bugfixes
  o fat endianness annotations
  o efs endianness annotations
  o jbd endianness annotations
  o afs endianness annotations
  o rxrpc endianness annotations
  o net2280 iomem annotations
  o applicom iomem annotations
  o drivers/input annotations

Alexey Kuznetsov:
  o [IPV4]: Fix fa_list walking in fib_hash.c

Andi Kleen:
  o [NET]: Fix missing spin lock in lltx path
  o Add prctl to modify current->comm
  o Fix ABI in set_mempolicy()
  o x86-64: add atomic64_t
  o x86-64: make APIC errors KERN_DEBUG
  o x86-64: add apic={verbose,quiet,debug}
  o x86-64: update defconfig
  o x86-64: avoid deadlock in page fault handler
  o x86-64: avoid panic when APIC ID cannot be set
  o x86-64: IO-APIC suspend/resume
  o x86-64: make machine check handler configurable
  o x86-64: remove WARN_ON in smp_call_function
  o x86-64: print mce bank enable mask in hex
  o x86-64: add might_sleeps to more *_user functions
  o x86-64: fix for mem= on NUMA systems
  o x86-64: sibling map fix for clustered mode
  o x86-64: synchronize video.S with i386
  o x86-64: add read implies exec macro
  o x86-64, x86: don't pass CR2 on alignment faults
  o x86-64: turn tss into per cpu data
  o x86-64: copy ioperm bitmaps more efficiently at context  switch

Andrew Morton:
  o isofs buffer management fix
  o bio_alloc() cleanup
  o remove sh64 smplock.h

Andrew Zabolotny:
  o input

Andrey V. Savochkin:
  o fix for fsync ignoring writing errors

Andy Fleming:
  o ppc32: 85xx spurious interrupt bug

Anil Keshavamurthy:
  o Online CPU with maxcpus option panics

Anton Altaparmakov:
  o NTFS: Remove vol->nr_mft_records as it was pretty meaningless and
    optimize the calculation of total/free inodes as used by statfs().
  o NTFS: Fix scheduling latencies in ntfs_fill_super() by dropping the
    BKL because the code itself is using the ntfs_lock semaphore which
    provides safe locking.  (Ingo Molnar)
  o NTFS: Fix a potential bug in fs/ntfs/mft.c::map_extent_mft_record()
    that could occur in the future for when we start closing/freeing
    extent inodes if we don't set base_ni->ext.extent_ntfs_inos to NULL
    after we free it.
  o NTFS: Rename {find,lookup}_attr() to ntfs_attr_{find,lookup}() as
    well as find_external_attr() to ntfs_external_attr_find() to
    cleanup the namespace a bit and to be more consistent with libntfs.
  o NTFS: Rename {{re,}init,get,put}_attr_search_ctx() to
    ntfs_attr_{{re,}init,get,put}_search_ctx() as well as the type
    attr_search_context to ntfs_attr_search_ctx.
  o NTFS: - Fix endianness bug in ntfs_external_attr_find()
  o NTFS: 2.1.18 release
  o NTFS: - Remove BKL use from ntfs_setattr() syncing up with the rest
    of the kernel.
  o NTFS: Get rid of the ugly transparent union in
    fs/ntfs/dir.c::ntfs_readdir() and ntfs_filldir() as per suggestion
    from Al Viro.
  o NTFS: Improve the previous transparent union removal
  o NTFS: Change '\0' and L'\0' to simply 0 as per advice from Linus
    Torvalds
  o NTFS: - Update ->truncate (fs/ntfs/inode.c::ntfs_truncate()) to
    check if the inode size has changed and to only output an error if
    so.
  o NTFS: Begin of sparse annotations: new data types and endianness
    conversion
  o NTFS: Continuing sparse annotations: finish data types and header
    files
  o NTFS: Finish off sparse annotation
  o NTFS: 2.1.19 - Many cleanups, improvements, and a minor bug fix
  o NTFS: Fix a stupid bug where I forgot to actually do the attribute
    lookup and then went and used the looked up attribute...  Ooops.
  o NTFS: Remove silly (__force le32) casts from __ntfs_is_magic{,p}
    helper functions.  Thanks to Al Viro for spotting them.
  o NTFS: Convert final enum (fs/ntfs/logfile.h) to define to silence
    last bitwise sparse warning.
  o NTFS: Change {const_,}cpu_to_le{16,32}(0) to just 0 as suggested by
    Al Viro
  o Update for the LDM driver (fs/partitions/ldm.c): The last_vblkd_seq
    can be before the end of the vmdb, just make sure it is not out of
    bounds.
  o NTFS: Change all the defines back to simple enums since sparse is
    now happy typed enums.  This completes the sparse annotations in
    NTFS.

Anton Blanchard:
  o Clean up compat sched affinity syscalls
  o Backward compatibility for compat sched_getaffinity
  o ppc64: remove SPINLINE config option
  o ppc64: RTAS error logs can appear twice in dmesg
  o ppc64: Enable NUMA API
  o ppc64: use nm --synthetic where available
  o ppc64: clean up kernel command line code
  o ppc64: remove unused ppc64_calibrate_delay
  o ppc64: remove EEH command line device matching code
  o ppc64: use early_param
  o ppc64: restore smt-enabled=off kernel command line option
  o ppc64: enable POWER5 low power mode in idle loop
  o ppc64: clean up idle loop code
  o ppc64: remove -Wno-uninitialized
  o ppc64: Fix real bugs uncovered by -Wno-uninitialized removal
  o ppc64: Fix spurious warnings uncovered by -Wno-uninitialized
    removal
  o hvc: uninitialised variable
  o ppc32: remove -Wno-uninitialized
  o Allocate correct amount of memory for pid hash
  o ppc64: force_sigsegv fixes
  o ppc64: powersave_nap sysctl
  o ppc64: replace mmu_context_queue with idr allocator
  o ppc64: iseries build fixes
  o ppc64: clean up asm/mmu.h
  o ppc64: Remove A() and AA()
  o ppc64: export probe_irq_mask
  o ppc64: fix hotplug CPU when building a pseries+pmac kernel
  o ppc64: disable some drivers broken on 64bit
  o ppc64: fix CONFIG_CMDLINE
  o ppc64: User tasks must have a valid thread.regs

Antonino Daplas:
  o fbcon: fix fbcon's setup routine
  o fbdev: Initialize i810fb after agpgart
  o fbdev: Arrange driver order in Makefile

Arnaldo Carvalho de Melo:
  o [NET] generalise per protocol slab cache handling
  o [SOCKET] make enum socket_type be arch overridable
  o [NET] Calculate ipv6_pinfo offset from struct proto->slab_obj_size
  o [SOCK] remove sk_pair, only really used by AF_UNIX

Badari Pulavarty:
  o dio fine alignment and pages in io

Bart De Schuymer:
  o [NETFILTER]: port physdev to ip6tables

Bartlomiej Zolnierkiewicz:
  o ide: small cleanup for sis5513
  o [ide] hpt34x: remove dead /proc/ide/hpt34x code
  o [ide] remove ide_hwif_t->sg_dma_active

Ben Dooks:
  o [ARM PATCH] 2090/2: S3C2410 - usb gadged (udc) include
  o [ARM PATCH] 2091/1: S3C2410 - change id of s3c2410-ohci
  o [ARM PATCH] 2092/1: S3C2410 - gpio bugfix and additions
  o [ARM PATCH] 2093/1: S3C2410 - remove un-necessary resource from
    NAND
  o [ARM PATCH] 2110/1: S3C2410 - NAND platform data
  o [ARM PATCH] 2112/1: S3C2410 - fix <asm/arch/regs-clock.h> for
    assembly inclusion

Benjamin Herrenschmidt:
  o ppc32: pmac cpufreq for ibook 2 600
  o ppc64: Fix some bogus warnings & cleanup tlbie code path
  o ppc64: Fix __raw_* IO accessors
  o pmac: don't add °C suffix in sys for adt746x driver
  o ppc64: monster cleanup
  o ppc32: Fix Apple Xserve G4 PCI probing
  o ppc32: Fix bogus return value in pmac_cpufreq.c
  o ppc32: Fix potentially uninitialized var in chrp_setup.c
  o ppc32: Fix type/bug in pmac_feature.c
  o ppc32: Fix use of uninitialized pointer in offb
  o ppc32: adapt prom_init to offb change
  o ppc32: Fix typo/bug in bus resource allocation
  o ppc32/64: Fix warning in pmac ide
  o ppc32: ADB keycode conversion update
  o ppc32: Fix warning in pmac battery code
  o radeonfb: Fix newer PowerBook & warnings
  o ppc64: Fix 32 bits conversion of SI_TIMER signals
  o ppc64: fix 32-bit SI_TIMER conversion fix
  o ppc64: Fix spelling error in callback name
  o ppc64: Remote some userland-only stuff from kernel header
  o ppc64: Make the DART "iommu" code more generic
  o ppc/ppc64: Fix g5 access to PCI IO cycles
  o ppc64: DART iommu allocation fix
  o ppc64: Fix !SMP build

Bjorn Helgaas:
  o drm: add pci_enable_device

Brett Russ:
  o [ide] make sure we are looking at the low bits post error

Carsten Rietzschel:
  o input: Add CodeMercs IOWarrior to hid-core device blacklist

Chas Williams:
  o [ATM]: [drivers] fix warnings related to readl/writel changes
  o [ATM]: [lanai] get sleep interval right
  o [ATM]: [eni] fix __iomem related warnings
  o [ATM]: [ambassador] remove warnings related to unused variables
  o [ATM]: [fore200e] fix warnings related to dma_addr_t

Christoph Hellwig:
  o make kmem_find_general_cachep static in slab.c
  o mark md_interrupt_thread static
  o mark dq_list_lock static
  o remove exports from audit code
  o small <linux/hardirq.h> tweaks
  o <asm/softirq.h> crept back in h8300 and sh64
  o mark amiflop non-unloadable
  o [XFS] handle nfs requesting ino 0 gracefully
  o [XFS] fix handling of bad inodes

Christoph Lameter:
  o device driver for the SGI system clock, mmtimer
  o time interpolators logic fix
  o mmtimer quietness

Colin Leroy:
  o [SUNGEM]: Add polling support

Colin Phipps:
  o [IPX]: Make sure sockaddr_ipx objects are initialized completely

Dave Airlie:
  o drm: fix bug introduced in the macro removal
  o drm: use set_current_state instead of direct assignment
  o drm: actually __set_current_state is more correct
  o drm: complete fix for drm_scatter.h
  o drm: drop __HAVE_COUNTER macros

Dave Jiang:
  o [ARM PATCH] 2100/1: Fix compilation error due to missing typedefs
    (u32) for XScale IOP platforms
  o [ARM PATCH] 2105/1: Fix compilation error for IOP and remove
    unnecessary legacy code

Dave Jones:
  o Pointer dereference before NULL check in ACPI thermal driver

David Gibson:
  o ppc64: improved VSID allocation algorithm
  o [IPV4]: Initialize newly allocated hash tables in fib_semantics.c
  o ppc64: remove LARGE_PAGE_SHIFT constant

David S. Miller:
  o [TCP]: Just silently ignore ICMP Source Quench messages
  o [IOMAP]: Make ioport_map() take unsigned long port argument
  o [TCP]: Fix logic error in packets_out accounting
  o [SPARC64]: __iomem annotations and iomap implementation
  o [IPV4]: Use list.h facilities for fib_info_list
  o [IPV4]: Make fib_semantics algorithms scale better
  o [TG3]: Recognize all onboard Sun variants, not just 5704
  o [TG3]: Update driver version and reldate
  o [CRYPTO]: Zero out tfm before freeing in crypto_free_tfm()
  o [NETFILTER]: Fix off-by-one test error in ip_tables.c
  o [IPV4]: Basic cleanups in fib_hash.c
  o [IPV4]: Use hlist_for_each_entry_safe in fib_hash_move
  o [NETFILTER]: Fix tcp_find_option() bug properly
  o [IPV4]: More fib_hash cleanups
  o [SPARC64]: Add io{read,write}{8,16,32}_rep()
  o [SPARC64]: Update defconfig
  o [FC4]: Fix iomem warnings in SOC driver
  o [FC4]: Fix iomem warnings in SOCAL driver
  o [SPARC64]: Make IDE ops take __iomem pointers
  o [SPARC64]: Fix iomem warnings in amd7930 sound driver
  o [SPARC64]: Fix iomem warnings in cs4231 sound driver
  o [SPARC64]: Fix iomem warnings in i8042-sparcio.h
  o [MPTFUSION]: Fix iomem warnings
  o [SUNHME]: Fix iomem warnings
  o [SUNLANCE]: Fix iomem warnings
  o [SUNQE]: Fix iomem warnings
  o [SUNBMAC]: Fix iomem warnings
  o [MYRI_SBUS]: Fix iomem warnings
  o [TYPHOON]: Fix iomem warnings
  o [SPARC64]: Fix iomem warnings in envctrl driver
  o [SPARC64]: Fix iomem warnings in display7seg driver
  o [SPARC64]: Fix iomem warnings in cpwatchdog driver
  o [SPARC64]: Fix iomem warnings in flash driver
  o [B44]: Fix remaining iomem warnings
  o [SPARC64]: Fix iomem warnings in esp scsi driver
  o [SPARC64]: Fix iomem warnings in qlogicpti driver
  o [SPARC64]: Fix I/O port args to string routines
  o [SPARC64]: Missing ioremap() in parport support
  o [SPARC]: Kill dump_dma_regs, unused
  o [XFRM] make xfrm_lookup() fully af-independent
  o [IPV4]: Fix BUG triggered in fib_sync_down()
  o [SPARC64]: Improve kernel stack backtraces
  o [SPARC64]: Fix memset() in sunsu.c and sunzilog.c
  o [IPV4]: Clean up fib_hash.c list handling
  o [IPV4]: Zap CONFIG_IP_ROUTE_TOS
  o [SPARC64]: Update compat code for sys_waitid changes
  o [ATM]: Use __iomem where appropriate
  o [IPV4]: Fix list traversal in fn_hash_insert()
  o [NET]: Add ethtool support to loopback driver
  o Cset exclude: pablo@eurodev.net|ChangeSet|20040828001121|29246
  o [NET]: Abstract neigh table walking
  o [NET]: Apply NEIGH_HASHMASK at tbl->hash() caller
  o [NET]: Privatize {P,}NEIGH_HASHMASK
  o [NET]: Create neigh_lookup_nodev for decnet
  o [NET]: Grow neigh hash table dynamically
  o [NET]: Convert neigh hashing over to jenkins
  o [SPARC64]: Update defconfig
  o [SPARC64]: Start timer tick after interpolator is registered
  o [NET]: Neighbour hashing tweaks
  o [NET]: Smooth out periodic neighbour GC
  o [NET]: Fix some neigh table locking errors
  o [NET]: Remove INCOMPLETE checks from neigh_forced_gc()
  o [TCP]: Fix congestion window expansion when using TSO
  o [NET]: Neighbour cache statistics like rt_stat
  o [TCP]: Fix third arg to __tcp_trim_head()
  o [TCP]: Uninline tcp_current_mss()
  o [TCP]: Move TSO mss calcs to tcp_current_mss()
  o [NETLINK]: In netlink_trim(), verify that SKB is not on a list
  o [SPARC64]: Do not log streaming byte hole errors
  o [SPARC64]: Disable SBH interrupt properly
  o [IPV4]: Define fib_alias in new header fib_lookup.h
  o [IPV4]: Move some fib_semantics exports into fib_lookup.h
  o [IPV4]: Do fib_alias lookup walk directly in fib_semantic_match()
  o [TCP]: Fix inaccuracies in tso_factor settings

Dean Roehrich:
  o [XFS] Need to vn_revalidate after dm_set_fileattr

Deepak Saxena:
  o Add support for word-length UART registers
  o Document ARM pci=firmware option
  o Update IXP4xx MTD driver from CVS MTD
  o Add MTD map driver for Intel IXP2000 NPU

Denis Vlasenko:
  o reduce [compat_]do_execve stack usage
  o reduce stack consumption in load_elf_binary

Dmitry Torokhov:
  o Cset exclude:
    dtor_core@ameritech.net|ChangeSet|20040510063935|25419
  o Input: logips2pp - do not call get_model_info 2 times
  o Input: mousedev - better handle button presses when under load
  o Input: mousedev - implement tapping for touchpads working in
    absolute mode, such as Synaptics
  o Input: make connect and disconnect methods mandatory for serio
    drivers since that's where serio_{open|close} are called from to
    actually bind driver to a port.
  o Input: rename serio->driver to serio->port_data in preparation to
    sysfs integration
  o Input: more renames in serio in preparations to sysfs integration
  o Input: switch to dynamic (heap) serio port allocation in
    preparation to sysfs integration. By having all data structures
    dynamically allocated serio driver modules can be unloaded without
    waiting for the last reference to the port to be dropped.
  o Input: allow serio drivers to create children ports and register
    these ports for them in serio core to avoid having recursion in
    connect methods.
  o Input: serio sysfs integration
  o Input: allow users manually rebind serio ports, like this
  o Input: allow marking some drivers (that don't do HW autodetection)
    as manual bind only. Such drivers will only be bound to a serio
    port if user requests it by echoing driver name into port's sysfs
    driver attribute.
  o Input: Add serio_raw driver that binds to serio ports and provides
    unobstructed access to the underlying serio port via a char device.
    The driver tries to register char device 10,1 (/dev/psaux) first
    and if it fails goes for dynamically allocated minor. To bind use
    sysfs interface:
  o Input: link serio ports to their parent devices in ambakmi, gscps2,
    pcips2 and sa1111ps2 drivers
  o Input: move input/serio closer to the top of drivers/Makefile so
    serio_bus is available early
  o Input: rearrange code in sunzilog so it registers its serio ports
  o Input: workaround for i8042 active multiplexing controllers losing
    track of where data is coming from. Also sprinkled some "likely"s
    in i8042 interrupt handler.
  o Input: add serio_pause_rx and serio_continue_rx so drivers can
    protect their critical sections from port's interrupt handler
  o Input: when changing psmouse state (activated, ignore) use
    srio_pause_rx/ serio_continue_rx so it will not fight with the
    interrupt handler
  o Input: do not call protocol handler in psmouse unless mouse is
    filly initialized - helps when USB Legacy emulation gets in our way
    and starts generating junk data stream while psmouse is detecting
    hardware
  o Input: synaptics - do not try to process packets from slave device
    as if they were coming form the touchpad itself if pass-through
    port is disconnected, just pass them to serio core and it will
    attempt to bind proper driver to the port
  o Input: rearrange activation/children probe sequence in psmouse so
    reconnect on children ports works even after parent port is fully
    activated:
  o Input: drop __attribute__ ((packed)) from mousedev_emul
  o Input: make i8042 a platform device instead of system device so its
    serio ports have proper parent
  o Input: integrate ct82c710, maceps2, q40kbd and rpckbd with sysfs as
    platform devices so their serio ports have proper parents
  o Input: Switch to use bus' default device and driver attributes to
    manage serio sysfs attributes
  o Input: allow marking serio ports (in addition to serio drivers) as
    manual bind only, export the flag through sysfs
  o Input: serio - switch to use driver_find, adjust reference count
  o Input: fix psmouse_sendbyte logic
  o Input: psmouse - harden command mode processing logic
  o Input: switch psmouse driver from busy-polling for command
    completion to waiting for event
  o Input: atkbd - harden ACK/NAK and command processing logic
  o Input: switch atkbd driver from busy-polling for command completion
    to waiting for event
  o Input: fix reader wakeup conditions in mousedev, joydev and tsdev
    (we want readers to wake up when underlying device is gone so they
    would get -ENODEV and close the device).
  o Input: fix absolute device handling in mousedev that was broken by
    recent change that tried to do better multiplexing.

Domen Puncer:
  o [ATM]: [he] Make code more readable with list_for_each_entry

Dominik Brodowski:
  o powernow-k7: fix latency calculation

Doug Dumitru:
  o uml: don't trash return value

Eric Lemoine:
  o [SUNGEM]: Add tx_lock
  o [SUNGEM]: LLTX support
  o [SUNGEM]: Add netpoll support

François Romieu:
  o r8169: default on disabling PCIDAC

Gerd Knorr:
  o bttv bugfix

Gordon Jin:
  o [IA64] ia32compat: Disable syscalls sys32_iopl() and sys32_ioperm()
    on ia64

Grzegorz Jaskiewicz:
  o gcc-4.0 build fixes

Harald Welte:
  o [NETFILTER]: add sysctl to read out the number of current
    connections
  o [NET]: Generic network statistics

Heinz J. Mauelshagen:
  o device-mapper: mirror log sync optional

Herbert Xu:
  o input: Fix boundary checks for GUSAGE/SUSAGE in hiddev
  o [IPV6]: Add option to copy DSCP in decap in ip6_tunnel
  o [NET]: Convert RTM+_* to enum
  o [IPV6]: Kill ip6_get_dsfield
  o [IPSEC]: Implement DSCP decapsulation
  o [IPV4]: Size fib_info_devhash[] correctly
  o [IPV4]: Fix some stray IP_ROUTE_TOS references
  o [NETFILTER]: Fix comment typo in ip_nat_helper
  o [IPV4]: Check PAGE_SIZE in fz_hash_alloc
  o [IPV4]: Kill remnant of ip_nat_dumb
  o [IPV4]: Fix endless loop in fn_hash_delete
  o [IPV4]: Fix thinko in fib_find_alias
  o [IPV4]: Missing TOS checks after fib_find_alias
  o [TCP]: Use mss_cache_std in tcp_init_metrics()
  o [NETLINK]: Kill export of netlink_broadcast_deliver
  o [NETLINK]: Trim SKBs at netlink_{unicast,broadcast}() time
  o [RTNETLINK]: Calculate rtmsg_ifinfo() SKB size more accurately

Hideaki Yoshifuji:
  o [NET] NEIGHBOUR: save number of arguments for neigh_update() by
    flags
  o [IPV6] NDISC: suspect REACHABLE entry if new lladdr is different
  o [IPV6] NDISC: keep original state if new state is STALE and lladdr
    is unchanged
  o [NET] NEIGHBOUR: merge two flags for neigh_update() into one
  o [IPV6] NDISC: update IsRouter flag appropriately
  o [NET] NEIGHBOUR: use time_after() and its friends
  o [IPV6] NDISC: update entry appropriately when receiving NS
  o [NET] NEIGHBOUR: improve neighbour state machine
  o [IPV6] NDISC: Fix message validation against Redirects
  o [IPV6] don't use expired default routes
  o [IPV6] ensure to aging default routes
  o [IPV6] purge routes via non-router neighbour but gateway
  o [IPV6]: Do not export rt6_dflt_{pointer,lock}
  o [IPV6]: Missing xfrm_lookup() in icmpv6_{send,echo_reply}()
  o [IPV6]: NDISC: ensure responding to NS without link-layer
    information
  o [NET]: Fix non-existent reference to tulip.txt
  o [ARCNET]: Fix crash in 2.6.8.1
  o [IPV6] Fix device multicast list leakage when forwarding is on
  o [IPV6] Don't multiply join multicast/anycast addresses
  o [IPV6] Save number of arguments for __ipv6_dev_mc_dev()
  o [IPV6] use __ipv6_dev_mc_dec() where appropriate
  o [IPV6] leave solicited-node multicast address during device
    deletion
  o [IPV6] leave subnet-routers anycast address during device deletion
  o [IPV6] Clean up anycast membership management
  o [IPV6] Fix routing header handling
  o [IPV6] Fix skb allocation size for RST and ACK

Hirokazu Takata:
  o m32r architecture
  o m32r: update for profiling
  o m32r: update zone_sizes_init()
  o m32r: update to fix compile errors
  o m32r: update uaccess.h
  o m32r: update checksum functions
  o m32r: update CF/PCMCIA drivers
  o m32r: update headers to remove useless  iBCS2 support code
  o atomic_inc_return for m32r
  o m32r: change from EXPORT_SYMBOL_NOVERS to  EXPORT_SYMBOL
  o m32r: modify sys_ipc() to remove useless  iBCS2 support code
  o m32r: add ELF machine code
  o m32r: upgrade to 2.6.8.1 kernel
  o m32r: support a new bootloader "m32r-g00ff"
  o m32r: modify IO routines for m32700ut CF  access
  o m32r: remove network drivers
  o m32r: modify drivers/net/smc91x.c for  m32r
  o m32r: modify drivers/net/ne.c for m32r
  o m32r: slim arch/m32r/Kconfig
  o m32r: upgrade include/asm-m32r/atomic.h
  o m32r: fix to build SMP kernel
  o m32r: upgrade for recent kernel changes
  o m32r: support PTRACE_GETREGS and  PTRACE_SETREGS

Horst Hummel:
  o s390: dasd driver

Hugh Dickins:
  o shmem: don't SLAB_HWCACHE_ALIGN
  o shmem: inodes and links need lowmem
  o shmem: no sbinfo for shm mount
  o shmem: no sbinfo for tmpfs mount?
  o shmem: avoid the shmem_inodes list
  o shmem: rework majmin and ZERO_PAGE
  o shmem: Copyright file_setup trivia

Ian Campbell:
  o Remove stray 0 from drivers/video/Makefile

Ingo Molnar:
  o blk: max_sectors tunables
  o i386: elf_read_implies_exec() fixup
  o x86 TSS: io port caching
  o x86 TSS: io bitmap lazy updating
  o tune vmalloc size
  o fix diskstats_show() accounting with PREEMPT

James Courtier-Dutton:
  o input: Add Audigy LS PCI ID to emu10k1-gp.c

Jason Davis:
  o ES7000 subarch update

Javier Achirica:
  o Compatibility fixes for different card versions

Jeff Dike:
  o uml: remove ghash.h
  o uml: eliminate useless thread field
  o uml: fix scheduler race
  o uml: fix binary layout assumption
  o uml: disable pending signals across a reboot
  o uml: update handle_IRQ_event
  o uml: finish conversion to sigjmp_buf/siglongjmp
  o uml: finish the signals across a reboot fix
  o uml: fix a signal race
  o uml: enable the timer *after* the timer handler
  o uml: convert the real-time clock to gettimeofday from rdtsc
  o uml: cleaning up
  o uml: let page faults always be delivered immediately
  o uml: eliminate signal order delivery dependency
  o uml: iomem fix
  o uml: fix call to sys_clone
  o uml: copy_user fixes
  o uml: comment UML's signal handling
  o uml: export memmove
  o uml: restrict tlb flushing
  o uml: clean up terminal state handling
  o uml: get rid of the arch EXTRAVERSION
  o uml: more EINTR protection
  o uml: mconsole fixes and cleanups
  o uml: network driver fixes
  o uml: remove useless ioctls
  o uml: code cleanup
  o uml: update defconfig
  o uml: move linker script
  o uml: small Makefile fixes
  o uml: free wrapper fixes
  o uml: remove an unused header
  o uml: allow UML to load in the normal location
  o uml: linker script cleanup
  o uml: implement current_text_addr
  o uml: error message improvement
  o uml: fix fencepost errors in printks
  o uml: print errno before resetting it

Jeff Garzik:
  o [libata sata_nv] sync with 2.4
  o [libata] remove distinction between MMIO/PIO helper functions
  o [libata] consolidate legacy/native mode init code into helpers
  o [libata] minor comment updates, preparing for iomap merge
  o [libata] add hook, and export functions needed for sata2 drivers

Jeff Mahoney:
  o Fix for default ACL handling on ReiserFS

Jens Axboe:
  o block highmem flushes
  o bio_unmap_user(): original bio passed in
  o partial io completion problem
  o thinko in kmalloc check in partial completion fix
  o Fix sparse warning in bio.c

Jesper Juhl:
  o __copy_to_user() check in cdrom_read_cdda_old()
  o check copy_from_user return value in act2000_isa_download

Jesse Barnes:
  o [IA64-SGI]: disable non-display ROM resources
  o fix uninitialized warnings in mempolicy.c
  o [IA64-SGI]: fix `qw' might be used uninitialized warning
  o [IA64] Kconfig: Add help text for IA64_SGI_SN2 config option
  o fix sysrq handling bug in sn_console.c
  o [IA64] sn2_defconfig update take 2
  o mmtimer cleanups
  o disable sched domains debug code
  o [IA64] sn2_defconfig: disable hotplug cpu

John Engel:
  o compat_sys_fcntl64: fix for locking near end of file

John Levon:
  o fix OProfile locking

Julian Anastasov:
  o [IPV4]: Fix fib_alias TOS walking and insertion

KaiGai Kohei:
  o list_replace_rcu() in include/linux/list.h

Keith Owens:
  o [IA64] ar.k[56] have virtual addresses already, don't convert

Kevin Tian:
  o [IA64] ia32compat: Put signal restorer code on a gate page

Kirill Korotaev:
  o Fix of race in writeback_inodes()
  o Rearrangement of inode_lock in writeback_inodes()

Krishna Kumar:
  o [NET]: Remove unnecessary local var initialization

Li Shaohua:
  o idr: fix missing spin_unlock()
  o preserve irqs in time_resume()

Linus Torvalds:
  o Add skeleton "generic IO mapping" infrastructure
  o Export new PCI iomem access interfaces to modules too
  o Fix fork failure case
  o fivafb; Increase DDC/CI timeouts
  o Fix up stupid last-minute edit of fork cleanup
  o Update shipped version of zconfig.tab.c to match bison/yacc file
  o ppc64: first cut at new iomap interfaces
  o Add support for "string" ioread/iowrite
  o Fix up typo in ppc64 eeh ioport_map() code
  o remove i2o_core.c
  o ppc64: Need to define HPAGE_SHIFT even when HUGETLB_PAGE not
    configured
  o Do __iomem annotations on VGA state handling
  o sym53c8xx_2: remove unnecessary IO pointer casts
  o fb: add __iomem annotations to cfbcopyarea
  o fb: add __iomem annotations to cfbfillrect
  o usb: add host controller __iomem annotations
  o ppc: annotate pmac ide driver
  o fb: add __iomem annotations to cfbimgblt
  o ppc64: clean up generated files at "make clean"
  o The generic iomap library needs to be linked unconditionally
  o Make smbfs with UNIX extensions get file disk usage count right
  o Add __user annotation to PR_SET_NAME
  o Convert system suspend states to proper PCI device states
  o Fix up tty locking update for sgttyb emulation (TIOCGETP and
    TIOCSETP)
  o Linux 2.6.9-rc3

Marcel Holtmann:
  o [Bluetooth] Don't use ISOC transfers for Broadcom dongle
  o [Bluetooth] Don't send L2CAP reject command for bad responses
  o [Bluetooth] Check checksums for BNEP

Mark Goodwin:
  o [IA64-SGI] sn_proc_fs.c: convert to use seq_file API
  o [IA64] SGI Altix hardware performance monitoring API

Markus Lidel:
  o reduce ioremap memory size for Adaptec I2O controllers

Martin Josefsson:
  o [NETFILTER]: Cleanup ctstat

Martin Schwidefsky:
  o s390: core changes

Martin Wilck:
  o [TG3]: Fix pause handling, we had duplicate flags for the same
    thing

Matt Mackall:
  o netpoll endian fixes

Matthew Wilcox:
  o fix posix_locks_deadlock()

Matthieu Castet:
  o pnpbios parser bugfix

Maximilian Attems:
  o compile fix 3c59x for eisa without pci
  o [MMC] replace schedule_timeout() with msleep_interruptible()

Michal Januszewski:
  o fbdev: Fix userland compile breakage

Mikael Pettersson:
  o WANPIPE/SDLA driver gcc-3.4 fixes
  o Specialix RIO driver gcc-3.4 fixes

Mike Waychison:
  o [TG3]: Fix thinko in 5704 fibre hw autoneg code

Nathan Lynch:
  o fix schedstats null deref in sched_exec
  o ppc64: don't use state == SYSTEM_BOOTING

Nathan Scott:
  o Fix generic direct IO code for XFS
  o [XFS] Fix incorrect use of do_div on realtime device growfs code
    path
  o [XFS] Fix some locking oddities in extended attributes code (ilock
    excl vs shared).
  o [XFS] Convert to list_for_each_entry_safe form in reclaim list walk
  o [XFS] Ensure bytes read statistic is not updated when the generic
    routines fail.
  o [XFS] Ensure we update the wbc pages skipped count correctly when
    writing pages.
  o [XFS] Add nosymlinks inode flag for the security folks, reserve
    projinherit flag.
  o [XFS] Update XFS quota header - add macros, use standard gpl
    template
  o [XFS] Make xfssyncd more generic, hand off out-of-space flushing to
    it; fixes two deadlocks when near-full and fixes a 4KSTACKS problem
    in XFS.

Neil Brown:
  o Fix disconnected dentries on NFS exports

Nicholas Reilly:
  o [ide] amd74xx: don't probe for IRQs

Nick Piggin:
  o fix missing unlock_page in mm/rmap.c

Nicolas Pitre:
  o linux/dma-mapping.h needs linux/device.h
  o [ARM PATCH] 2094/1: don't lose the system timer after resuming from
    sleep on SA11x0 and PXA2xx
  o update MAINTAINERS/CREDITS
  o [ARM PATCH] 2097/2: more gcc-3.4.1 warning fixes
  o [ARM PATCH] 2108/1: pxa-regs.h fixes and updates
  o [ARM PATCH] 2109/1: fix PCMCIA on Mainstone/PXA270
  o [ARM PATCH] 2111/1: restrict scope of PXA2xx register definitions

Nishanth Aravamudan:
  o [ATM]: [drivers] Use msleep() instead of schedule_timeout()
  o macintosh/macserial: replace schedule_timeout() with
    msleep_interruptible()
  o macintosh/therm_windtunnel: replace schedule_timeout() with
    msleep_interruptible()
  o net/airport: replace schedule_timeout() with ssleep()/msleep()
  o [SPARC64]: Make bbc_envctrl use msleep_interruptible()
  o [SPARC64]: Make bbc_i2c use msleep_interruptible()

Olaf Hering:
  o input: Re-add PC Speaker support for PPC
  o mark mace and bmac as ppc32 only
  o ppc32: open_pic2.c build fix
  o fix make O= for ppc64/boot
  o [NET]: Remove leading space in linux/skbuff.h

Paolo 'Blaisorblade' Giarrusso:
  o uml: refer to CONFIG_USERMODE, not to CONFIG_UM
  o uml: remove commented old code in Kconfig
  o uml: remove CONFIG_UML_SMP

Patrick McHardy:
  o [XFRM]: Fix unbalanced spin_unlock_bh in __xfrm_find_acq_byseq
  o [NETFILTER]: kill struct ip_nat_hash, saves two pointers per
    conntrack
  o [NETFILTER]: kill struct nf_ct_info, saves five pointers per
    conntrack
  o [NETFILTER]: Use u_int16_t for initialized/num_manips in struct
    ip_nat_info
  o [NETFILTER]: Keep conntrack/nat protocols in array instead of
    linked list
  o [NETFILTER]: Fix two broken assertions
  o [NETFILTER]: Fix invalid return values in sctp_new
  o [NETFILTER]: add comment match
  o [NETFILTER]: Move ip_ct_log_invalid to ip_conntrack_core.c
  o [NETFILTER]: Fill hole in netfilter skb fields on 64bit
  o [NETFILTER]: make ipt_helper depend on ipt_conntrack again
  o [NETFILTER]: Convert sctp match to skb_header_pointer
  o [NETFILTER]: Convert sctp conntrack protocol to skb_header_pointer
  o [NETFILTER]: Convert udp conntrack protocol to skb_header_pointer
  o [NETFILTER]: Convert icmp conntrack protocol to skb_header_pointer
  o [NETFILTER]: move check for already tracked/untracked before
    fragment check

Patrick Mochel:
  o [Power Mgmt] Make pmdisk dependent on swsusp
  o [Power Mgmt] Remove duplicate relocate_pagedir() from pmdisk
  o [Power Mgmt] Remove more duplicate code from pmdisk
  o [Power Mgmt] Share variables between pmdisk and swsusp
  o [Power Mgmt] Merge first part of image writing code
  o [Power Mgmt] Consolidate code for allocating image pages in pmdisk
    and swsusp
  o [Power Mgmt] Consolidate page count/copy code of pmdisk and swsusp
  o [swsusp] Add helper suspend_finish, move common code there
  o [Power Mgmt] Consolidate pmdisk and swsusp low-level handling
  o [Power Mgmt] Remove arch/i386/power/pmdisk.S
  o [Power Mgmt] Fix up call in kernel/power/disk.c to swsusp_suspend()
  o [Power Mgmt] Consolidate pmdisk and swsusp early swap access
  o [Power Mgmt] Merge pmdisk/swsusp image reading code
  o [Power Mgmt] Merge swsusp and pmdisk info headers
  o [swsusp] Fix nasty bug in calculating next address to read from
  o [Power Mgmt] Merge pmdisk and swsusp signature handling
  o [Power Mgmt] Merge pmdisk and swsusp pagedir handling
  o [Power Mgmt] Merge pmdisk and swsusp read wrappers
  o [Power Mgmt] Merge pmdisk and swsusp write wrappers
  o [Power Mgmt] Remove pmdisk_free()
  o [Power Mgmt] Make default partition config option part of swsusp
  o [Power Mgmt] Remove pmdisk
  o [swsusp] Remove unneeded suspend_pagedir_lock
  o [Power Mgmt] Merge swsusp entry points with the PM core
  o [swsusp] Fix nasty typo
  o [swsusp] Add big fat comment to calc_order()
  o [Power Mgmt] Add CONFIG_PM_DEBUG option
  o [swsusp] Kill unneeded write_header()
  o [swsusp] Make sure software_suspend() takes right path
  o [swsusp] Fix x86-64 low-level support
  o [swsusp] Make sure we call restore_highmem()
  o [Power Mgmt] Make sure we shutdown devices on shutdown and reboot
  o [power mgmt] Make system state enums match device state values

Paul E. McKenney:
  o Updates to RCU documentation

Paul P. Komkoff Jr.:
  o [IPV4]: Add wccp v1/v2 support to ip_gre.c

Pavel Machek:
  o mm swsusp: make sure we do not return to userspace where image is
    on disk
  o mm swsusp: copy_page is harmfull
  o swsusp: do not disable platform swsusp because S4bios is available
  o swsusp: fix default powerdown mode
  o swsusp: do not oops after allocation failure
  o swsusp: Documentation update
  o Small cleanups for swsusp
  o swsusp: another simplification
  o swsusp: kill crash when too much memory is free

Peter Nelson:
  o input: Enhancements/fixes for PSX pad support

Peter Osterlund:
  o bttv: fix DMA setup bug in latest update

Petr Vandrovec:
  o matroxfb update + sparse annotations

Pierre Ossman:
  o [MMC] Add power up delay

Randolph Chung:
  o add missing declaration to fix kernel/compat.c warning

Raphael Zimmerer:
  o ide: remove obsolete CONFIG_BLK_DEV_ADMA

Richard Henderson:
  o [ALPHA] Check set_fd_set return
  o [ALPHA] Use "long" on some internal bitops routines
  o [ALPHA] Arrange to return EINTR for sigsuspend on signal path
  o [ALPHA] Add waitid
  o [ALPHA] Minor updates for cpumask_t
  o [ALPHA] Implement _raw_write_trylock
  o [ALPHA] Fix some compiler warnings from gcc 4
  o Correct prototypes for sys_wait4 and sys_waitpid
  o [ALPHA] Add compile-time assert concerning rt_sigframe layout
  o [ALPHA] Fix signed one bit fields
  o [ALPHA] Add __user as necessary to fix sparse warnings
  o [ALPHA] Update readb and friends for __iomem
  o [ALPHA] Map readb_relaxed to __raw_readb, not plain readb
  o [ALPHA] Implement new ioread interface
  o [ALPHA] Fix bitops.h, kernel.h include loop
  o [ALPHA] Turn off GENERIC_IOMAP.  Arrange for iomap routines to be
    linked unconditionally.
  o [ALPHA] Regenerate defconfig

Robert Olsson:
  o [PKTGEN]: Update to 1.4

Robin Holt:
  o Fix write() return values for tmpfs
  o Fix write() return values for reiserfs

Roland Dreier:
  o ppc64: remove pSeries IO token translations

Roland McGrath:
  o BSD disklabel: handle more than 8 partitions
  o back out siginfo_t.si_rusage from waitid changes
  o fix posix-timers leak
  o x86-64: waitid fallout

Roman Zippel:
  o properly fix double current_menu

Russell King:
  o input: Update pcips2 driver
  o [ARM] Fix ARM APM emulation sparse errors
  o [ARM] Remove the hh.org H3600 "example" code
  o [ARM] Convert list_for_each()/list_entry() to list_for_each_entry()
  o [ARM] Abstract APM circular queue object
  o [ARM] Convert APM user list lock to r/w sem
  o [ARM] APM: "Battery life" needs to be a signed integer
  o [ARM] Remove APM standby support - it's unused
  o [ARM] Convert suspend to a state machine
  o [ARM] No point having "nonblock" local variable - kill it
  o [ARM] Keep APM threads frozen
  o [ARM] Update APM state definitions
  o [ARM] Revive kapmd and provide apm_queue_event()
  o [ARM] i8042 is available on many footbridge hosts, not just
    ARCH_EBSA285
  o [MMC] Use raw CID rather than decoded CID
  o [MMC] Save MMC card raw CSD structure
  o [MMC] Export raw MMC card CID and CSD registers via device model
  o [MMC] Clean up MMC card CID/CSD decoding, stage 1
  o [MMC] Add v2.x and v3.x CID parsing
  o [MMC] Fix suspend/resume buglet
  o [MMC] Fix mmc_block suspend/resume handling (again)
  o [MMC] Ensure PXA MMC interrupts are disabled on chip
  o [ARM] Prevent state machine leakage in ARM APM emulation
  o [MMC] PXAMCI: enable use of platform specific data
  o [MMC] Ensure semaphores are initialised before use.  Gah
  o fix problematic flush_cache_page in kernel/ptrace.c
  o [ARM] Fix circular include dependency in asm/system.h
  o Add wait_event_timeout()
  o [PCMCIA] Add device ID for TI4520 to yenta_socket table
  o [MMC] Provide major= module parameter for mmc_block
  o [MMC] Make MMC card initialisation more reliable
  o [MMC] Use scatter-gather lists rather than walking the BIOs
  o [MMC] Fix mmci.c build problem

Rusty Russell:
  o Fix ip_nat_ftp registration when no ports= arg
  o Another ip_conntrack seq fix: ip_conntrack_expect
  o Warn that ipchains and ipfwadm are going away
  o [NETFILTER]: Don't try to do any random dropping since we now use
    jenkins hash
  o [NETFILTER]: Shuffle conntrack structure for better cacheline
    behavior

Ryan Cumming:
  o implement roundup_pow_two()

Ryan S. Arnold:
  o HVCS fix to replace yield with tty_wait_until_sent in hvcs_close
  o hvc_console fix to protect hvc_write against ldisc write after
    hvc_close

Seiji Kihara:
  o ext3: journalled data fsync fix

Sonny Rao:
  o uml: smp build fix

Steffen Thoss:
  o s390: qeth network driver

Stephen Hemminger:
  o [B44]: Fix b44 I/O mem space access warnings
  o [TCP]: Choose congestion algorithm at initialization
  o [TCP]: Diagnostics enhancement for westwood
  o [TCP]: Westwood cleanup
  o [TIME]: Put jiffies_to_usecs in time.h

Stephen Rothwell:
  o ppc64 iSeries: allow ibmvscsic to initialise
  o ppc64: fix CONFIG check typo

Stéphane Eranian:
  o [IA64] Makefile: fix for the PTRACE_SYSCALL corruption bug

Thierry Vignaud:
  o fix driver name in eth1394 as returned by ETHTOOL_GDRVINFO

Thomas Graf:
  o [PKT_SCHED]: Fix slab corruption in cbq_destroy
  o [NET]: Fix ifmap alignment issues over rtnetlink
  o [PKT_SCHED]: Report qdisc parent to userspace
  o [PKT_SCHED]: Remove unneeded line in sch_sfq.c

Tom Rini:
  o ppc32: Don't make cmd_line be an emptry string
  o ppc32: Fix some warnings in rheap from newer compilers
  o ppc32: Fix a problem with the FCC enet driver for CPM2 systems
  o ppc32: The ISA PIC address for int-ack wasn't being picked out
    right
  o ppc32: Fix arch/ppc/boot/common/ns16550.c

Tony Luck:
  o [IA64] make INIT dump work again
  o [IA64] When we exhaust the supply of records to read, clear the
    event status
  o [IA64] cleanup contig/discontig/virt_mem_map macros
  o [IA64] zx1_defconfig: bring zx1_defconfig up to date
  o [IA64] add default config file for intel tiger

Torben Mathiasen:
  o devices.txt update

Trond Myklebust:
  o __iomem fixups for atiixp soundcards

Vojtech Pavlik:
  o Cset exclude:
    dtor_core@ameritech.net|ChangeSet|20040510063935|25419
  o input: An attempt at fixing locking in i8042.c and serio.c
  o input: Fix an oops in poll() on uinput.  Thanks to Dmitry Torokhov
    for suggesting the fix.
  o input: Make atomicity and exclusive access to variables explicit in
    atkbd.c, using bitops.
  o input: Return 0 from uinput poll if device isn't yet created
  o input: Explicit variable access rules for psmouse.c, using bitops
  o input: Add reporting of raw scancodes to atkbd.c
  o input: Use raw events generated by atkbd in keyboard.c to implement
    true rawmode for PS/2 keyboards.
  o input: Fixes in serio locking. We need per-serio lock for
    passthrough ports, some locks were missing, and spin_lock_irq was
    wishful thinking in serio_interrupt. There is no guarantee that
    serio_interrupt won't be called twice at the same time.
  o input: Disable the AUX LoopBack command in i8042.c on Compaq
    ProLiant 8-way Xeon ProFusion systems, as it causes crashes and
    reboots
  o input: Make atkbd.c's atkbd_command() function immune to keys being
    pressed and scancodes coming from the keyboard while it's
    executing.
  o input: More locking improvements (and a fix) for serio. This merges
    both my and Dmitry's changes.
  o input: Add a missong dmi_noloop declaration in i8042.c
  o input: Make hardware rawmode optional for AT-keyboards, and check
    for rawmode bits in keyboard.c
  o input: Add a missing extern i8042_dmi_loop
  o input: Remove OSB4/Profusion hack in i8042, as it's handled by DMI
    blacklist now.
  o Input: rearrangements and cleanups in serio.c
  o input: Remove an extra dmi_noloop declaration in i8042.c
  o input: when probing for ImExPS/2 mice, the ImPS/2 sequence needs to
    be sent first, but the result should be ignored.
  o input: Fix array overflows in keyboard.c when KEY_MAX > keycode >
    NR_KEYS > 128
  o input: Add Dell SB Live! PCI ID to the emu10k1-gp driver
  o input: Fix Peter Nelson's e-mail address in gamecon.c
  o input: Fix Kconfig so that the joydump module can be compiled
  o input: Move Compaq ProLiant DMI handling (ServerWorks/OSB
    workaround) to i8042.c.
  o input: Fix a missing index in tmdc.c
  o input: Check the range for HIDIOC?USAGES num_values
  o input: Fix an i8042 access timing violation spotted by Alan Cox
  o input: Update MAINTAINERS entries for Vojtech Pavlik
  o input: Make sure the HID request queue survives report transfer
    failures gracefully

Werner Almesberger:
  o round log buffer size to power of two

Will Schmidt:
  o ppc64: lparcfg fixes for processor counts
  o ppc64: lparcfg whitespace and wordwrap cleanup

William Lee Irwin III:
  o input: Move CONFIG_USB_HIDDEV a little lower in hiddev.h, to fix
    compilation breakage when it is not defined.
  o sparc32: vmalloc address fix

Yoichi Yuasa:
  o mips: fixed do_signal in arch/mips/kernel/signal.c
  o mips: fixed vr41xx serial
  o mips: fixed initialization error
  o mips: fixed undeclared giu_cascade
  o mips: fixed definition order of _sigchld

Yuval Turgeman:
  o searching for parameters in 'make menuconfig'

Zinx Verituse:
  o input: Fix bad struct hidinput initialization in hid-tmff.c

Zou Nanhai:
  o [IA64] discontig.c: remove max_gap and related call to
    efi_memmap_walk

Zwane Mwaikambo:
  o Close race with preempt and modular pm_idle callbacks

