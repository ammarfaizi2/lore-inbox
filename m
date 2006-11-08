Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753920AbWKHCdv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753920AbWKHCdv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Nov 2006 21:33:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753917AbWKHCdv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Nov 2006 21:33:51 -0500
Received: from smtp.osdl.org ([65.172.181.4]:9155 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1753920AbWKHCdt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Nov 2006 21:33:49 -0500
Date: Tue, 7 Nov 2006 18:33:44 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Linux 2.6.19-rc5
Message-ID: <Pine.LNX.4.64.0611071829340.3667@g5.osdl.org>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="21872808-292547592-1162953224=:3667"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--21872808-292547592-1162953224=:3667
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT


Ok, things are finally calming down, it seems.

The -rc5 thing is mainly a few random architecture updates (arm, mips, 
uml, avr, power) and the only really noticeable one there is likely some 
fixes to the local APIC accesses on x86, which apparently fixes a few 
machines.

The rest is really mostly one-liners (or close) to various subsystems. New 
PCI ID's, trivial fixes, cifs, dvb, things like that. I'm feeling better 
about this - there may be a -rc6, but maybe we don't even need one.

As usual, thanks to everybody who tested and chased down some of the 
regressions,

		Linus

---
Adrian Bunk (2):
      [TIPC] net/tipc/port.c: fix NULL dereference
      PCI: Let PCI_MULTITHREAD_PROBE depend on BROKEN

Akinobu Mita (4):
      tokenring: fix module_init error handling
      n2: fix confusing error code
      edac_mc: fix error handling
      sunrpc: add missing spin_unlock

Al Viro (8):
      [IPV6]: File the fingerprints off ah6->spi/esp6->spi
      [IPX]: Trivial parts of endianness annotations
      [IPX]: Annotate and fix IPX checksum
      [IPV6]: Fix ECN bug on big-endian
      [NETFILTER] bug: NFULA_CFG_QTHRESH uses 32bit
      [NETFILTER] bug: nfulnl_msg_config_mode ->copy_range is 32bit
      [NETFILTER] bug: skb->protocol is already net-endian
      [PKTGEN]: TCI endianness fixes

Alexey Dobriyan (1):
      [GFS2] don't panic needlessly

Amol Lad (1):
      drivers/isdn/hysdn/hysdn_sched.c: sleep after taking spinlock fix

Andreas Gruenbacher (1):
      Fix user.* xattr permission check for sticky dirs

Andrew Morton (6):
      find_bd_holder() fix
      tidy "md: check bio address after mapping through partitions"
      Add printk_timed_ratelimit()
      schedule removal of FUTEX_FD
      acpi_noirq section fix
      spi section fix

Andy Fleming (2):
      [POWERPC] Fix rmb() for e500-based machines it
      [POWERPC] Fix oprofile support for e500 in arch/powerpc

Ankita Garg (1):
      Fix for LKDTM MEM_SWAPOUT crashpoint

Atsushi Nemoto (2):
      [MIPS] Fixup migration to GENERIC_TIME
      [MIPS] Do not use -msym32 option for modules.

Auke Kok (1):
      e1000: Fix regression: garbled stats and irq allocation during swsusp

Ben Dooks (5):
      [ARM] 3915/1: S3C2412: Add s3c2410_gpio_getirq() to general gpio.c
      [ARM] 3920/1: S3C24XX: Remove smdk2410_defconfig
      [ARM] 3921/1: S3C24XX: remove bast_defconfig
      [ARM] 3922/1: S3C24XX: update s3c2410_defconfig to 2.6.19-rc4
      [ARM] 3923/1: S3C24XX: update s3c2410_defconfig with new drivers

Benjamin Herrenschmidt (2):
      [POWERPC] Fix various offb issues
      [POWERPC] Make alignment exception always check exception table

Bjorn Schneider (1):
      USB: new VID/PID-combos for cp2101

Brice Goglin (1):
      myri10ge: ServerWorks HT2000 PCI id is already defined in pci_ids.h

Daniel Drake (1):
      jfs: Add splice support

Daniel Ritz (1):
      usbtouchscreen: use endpoint address from endpoint descriptor

Daniel Yeisley (1):
      init_reap_node() initialization fix

Dave Kleikamp (1):
      JFS: Remove redundant xattr permission checking

David Brownell (3):
      USB: fix compiler issues with newer gcc versions
      USB: use MII hooks only if CONFIG_MII is enabled
      [ARM] 3926/1: make timer led handle HZ != 100

David Härdeman (1):
      V4L/DVB (4785): Budget-ci: Change DEBIADDR_IR to a safer default

David Rientjes (1):
      net s2io: return on NULL dev_alloc_skb()

David S. Miller (7):
      [APPLETALK]: Fix potential OOPS in atalk_sendmsg().
      [XFRM] xfrm_user: Fix unaligned accesses.
      [ETH1394]: Fix unaligned accesses.
      [SPARC64]: Fix Tomatillo/Schizo IRQ handling.
      [SPARC64]: Add some missing print_symbol() calls.
      [SPARC64]: Fix futex_atomic_cmpxchg_inatomic implementation.
      [SPARC]: Fix robust futex syscalls and wire up migrate_pages.

Dmitry Mishin (3):
      [NETFILTER]: Missed and reordered checks in {arp,ip,ip6}_tables
      [NETFILTER]: ip_tables: compat code module refcounting fix
      [IPV6]: Add ndisc_netdev_notifier unregister.

Dominic Cerquetti (1):
      USB: xpad: additional USB id's added

Enrico Scholz (1):
      [ARM] 3919/1: Fixed definition of some PXA270 CIF related registers

Erez Zilber (1):
      IB/iser: Start connection after enabling iSER

Eric Sandeen (1):
      fix UFS superblock alignment issues

Eric W. Biederman (3):
      Improve the removed sysctl warnings
      sysctl: allow a zero ctl_name in the middle of a sysctl table
      sysctl: implement CTL_UNNUMBERED

Gautham R Shenoy (1):
      Fix the spurious unlock_cpu_hotplug false warnings

Grant Grundler (1):
      hid-core: big-endian fix fix

Greg Kroah-Hartman (2):
      PCI: Revert "PCI: i386/x86_84: disable PCI resource decode on device disable"
      USB: add another sierra wireless device id

Gui,Jian (1):
      [POWERPC] Disallow kprobes on emulate_step and branch_taken

Haavard Skinnemoen (4):
      AVR32: Get rid of board_early_init
      AVR32: Fix thinko in generic_find_next_zero_le_bit()
      AVR32: Wire up sys_epoll_pwait
      AVR32: Add missing return instruction in __raw_writesb

Hartmut Hackmann (1):
      V4L/DVB (4770): Fix mode switch of Compro Videomate T300

Heiko Carstens (4):
      [NET]: fix uaccess handling
      sys_pselect7 vs compat_sys_pselect7 uaccess error handling
      [S390] revert add_active_range() usage patch.
      [S390] IRQs too early enabled.

Herbert Xu (2):
      [NET]: Fix segmentation of linear packets
      [SCTP]: Always linearise packet on input

Hugh Dickins (3):
      [POWERPC] Make current preempt-safe
      [POWERPC] Make high hugepage areas preempt safe
      [POWERPC] Make mmiowb's io_sync preempt safe

Jack Morgenstein (1):
      IB/uverbs: Return sq_draining value in query_qp response

James Morris (3):
      [IPV6]: fix lockup via /proc/net/ip6_flowlabel
      [IPV6]: return EINVAL for invalid address with flowlabel lease request
      [IPV6]: fix flowlabel seqfile handling

Jamie Lenehan (2):
      sh: Fix IPR-IRQ's for IRQ-chip change breakage.
      sh: Titan defconfig update.

Jan Luebbe (1):
      USB: sierra: Fix id for Sierra Wireless MC8755 in new table

Jan Mate (1):
      USB Storage: unusual_devs.h entry for Sony Ericsson P990i

Jan-Benedict Glaw (1):
      Update for the srm_env driver.

Jan-Bernd Themann (1):
      ehea: kzalloc GFP_ATOMIC fix

Jeff Dike (4):
      uml: add _text definition to linker scripts
      uml: add INITCALLS
      uml: fix I/O hang
      uml: include tidying

Jeff Garzik (1):
      Revert "Add 0x7110 piix to ata_piix.c"

Jeff Mahoney (1):
      reiserfs: reset errval after initializing bitmap cache

Jens Axboe (3):
      CFQ: request <-> request merging rr_list fixup
      Add 0x7110 piix to ata_piix.c
      splice: fix problem introduced with inode diet

Jes Sorensen (1):
      [IA64] don't double >> PAGE_SHIFT pointer for /dev/kmem access

Jiri Benc (1):
      ieee80211: don't flood log with errors

Johannes Berg (1):
      b44: change comment about irq mask register

Keith Owens (1):
      [IA64] Correct definition of handle_IPI

Kenji Kaneshige (1):
      [IA64] cpu-hotplug: Fixing confliction between CPU hot-add and IPI

Kevin Hilman (2):
      [ARM] 3917/1: Fix dmabounce symbol exports
      [ARM] 3918/1: ixp4xx irq-chip rework

Krishna Kumar (1):
      RDMA/cma: rdma_bind_addr() leaks a cma_dev reference count

Kristoffer Ericson (1):
      video: Fix include in hp680_bl.

Larry Finger (1):
      bcm43xx: fix unexpected LED control values in BCM4303 sprom

Larry Woodman (1):
      [NET]: __alloc_pages() failures reported due to fragmentation

Lennert Buytenhek (3):
      ep93xx_eth: fix RX/TXstatus ring full handling
      ep93xx_eth: fix unlikely(x) > y test
      ep93xx_eth: don't report RX errors

Linas Vepstas (1):
      [POWERPC] Use 4kB iommu pages even on 64kB-page systems

Linus Torvalds (6):
      i386: clean up io-apic accesses
      i386: write IO APIC irq routing entries in correct order
      Revert unintentional "volatile" changes in ipc/msg.c
      Fix unlikely (but possible) race condition on task->user access
      Make sure "user->sigpending" count is in sync
      Linux 2.6.19-rc5

Manish Lachwani (1):
      [MIPS] Add missing file for support of backplane on TX4927 based board

Martin Josefsson (1):
      [NETFILTER]: nf_conntrack: add missing unlock in get_next_corpse()

Meelis Roos (1):
      [NETFILTER]: silence a warning in ebtables

Michael Buesch (1):
      bcm43xx: Fix low-traffic netdev watchdog TX timeouts

Michael Chan (1):
      [TG3]: Fix 2nd ifup failure on 5752M.

Michael Halcrow (7):
      eCryptfs: Clean up crypto initialization
      eCryptfs: Hash code to new crypto API
      eCryptfs: Cipher code to new crypto API
      eCryptfs: Consolidate lower dentry_open's
      eCryptfs: Remove ecryptfs_umount_begin
      eCryptfs: Fix handling of lower d_count
      eCryptfs: Fix pointer deref

Michael S. Tsirkin (1):
      IB/mthca: Fix MAD extended header format for MAD_IFC firmware command

Naranjo Manuel Francisco (1):
      USB: HID: add blacklist AIRcable USB, little beautification

NeilBrown (2):
      md: check bio address after mapping through partitions.
      md: send online/offline uevents when an md array starts/stops

nkalmala (1):
      mm: un-needed add-store operation wastes a few bytes

OGAWA Hirofumi (4):
      Cleanup read_pages()
      cifs: ->readpages() fixes
      fuse: ->readpages() cleanup
      gfs2: ->readpages() fixes

Oleg Nesterov (2):
      taskstats: fix sub-threads accounting
      fix Documentation/accounting/getdelays.c buf size

Oliver Endriss (1):
      V4L/DVB (4784): [saa7146_i2c] short_delay mode fixed for fast machines

Oliver Neukum (2):
      USB: failure in usblp's error path
      USB: usblp: fix system suspend for some systems

Paolo 'Blaisorblade' Giarrusso (11):
      uml ubd driver: allow using up to 16 UBD devices
      uml ubd driver: document some struct fields
      uml ubd driver: var renames
      uml ubd driver: give better names to some functions.
      uml ubd driver: change ubd_lock to be a mutex
      uml ubd driver: ubd_io_lock usage fixup
      uml ubd driver: convert do_ubd to a boolean variable
      uml ubd driver: reformat ubd_config
      uml ubd driver: use bitfields where possible
      uml ubd driver: do not store error codes as ->fd
      uml ubd driver: various little changes

Patrick Caulfield (2):
      [DLM] Fix kref_put oops
      [DLM] fix oops in kref_put when removing a lockspace

Patrick McHardy (2):
      [NETFILTER]: remove masq/NAT from ip6tables Kconfig help
      [IPV6]: Give sit driver an appropriate module alias.

Paul Gortmaker (1):
      [ARM] 3912/1: Make PXA270 advertise HWCAP_IWMMXT capability

Paul Mackerras (2):
      IB/ehca: Fix eHCA driver compilation for uniprocessor
      powerpc: Eliminate "exceeds stub group size" linker warning

Paul Moore (2):
      [NetLabel]: protect the CIPSOv4 socket option from setsockopt()
      [NETLABEL]: Fix build failure.

Paul Mundt (2):
      sh: Wire up new syscalls.
      sh: Update r7780rp_defconfig.

Pavel Emelianov (1):
      Fix ipc entries removal

Pavel Roskin (1):
      hostap_plx: fix CIS verification

Peer Chen (5):
      [libata] sata_nv: Add PCI IDs
      [libata] Add support for PATA controllers of MCP67 to pata_amd.c.
      [libata] Add support for AHCI controllers of MCP67.
      pci_ids.h: Add NVIDIA PCI ID
      IDE: Add the support of nvidia PATA controllers of MCP67 to amd74xx.c

Peter Zijlstra (1):
      lockdep: fix delayacct locking bug

Phil Dibowitz (1):
      USB: usb-storage: Unusual_dev update

Rafael J. Wysocki (1):
      swsusp: debugging

Ralf Baechle (26):
      [MIPS] TX4927: Remove indent error message that somehow ended in the code.
      [MIPS] Sort out missuse of __init for prom_getcmdline()
      [MIPS] VSMP: Fix initialization ordering bug.
      [MIPS] Flags must be unsigned long.
      [MIPS] VSMP: Synchronize cp0 counters on bootup.
      [MIPS] 16K & 64K page size fixes
      [MIPS] SMTC: Fix crash if # of TC's > # of VPE's after pt_regs irq cleanup.
      [MIPS] SMTC: Synchronize cp0 counters on bootup.
      Revert "[MIPS] Make SPARSEMEM selectable on QEMU."
      [MIPS] Fix merge screwup by patch(1)
      [MIPS] IP27: Allow SMP ;-)  Another changeset messed up by patch.
      [MIPS] Fix warning about init_initrd() call if !CONFIG_BLK_DEV_INITRD.
      [MIPS] Ocelot G: Fix : "CURRENTLY_UNUSED" is not defined warning.
      [MIPS] Don't use R10000 llsc workaround version for all llsc-full processors.
      [MIPS] Ocelot C: Fix large number of warnings.
      [MIPS] Ocelot C: fix eth registration after conversion to platform_device
      [MIPS] Ocelot C: Fix warning about missmatching format string.
      [MIPS] Ocelot C: Fix mapping of ioport address range.
      [MIPS] Ocelot 3: Fix large number of warnings.
      [MIPS] SB1: On bootup only flush cache on local CPU.
      [MIPS] Ocelot C: Fix MAC address detection after platform_device conversion.
      [MIPS] Ocelot 3: Fix MAC address detection after platform_device conversion.
      [MIPS] EV64120: Fix timer initialization for HZ != 100.
      [MIPS] Make irq number allocator generally available for fixing EV64120.
      [MIPS] EV64120: Fix PCI interrupt allocation.
      [MIPS] Fix EV64120 and Ocelot builds by providing a plat_timer_setup().

Randy Dunlap (8):
      [NET] sealevel: uses arp_broken_ops
      [DCCP]: fix printk format warnings
      SCSI: ISCSI build failure
      V4L/DVB (4786): Pvrusb2: use NULL instead of 0
      update some docbook comments
      docbook: merge journal-api into filesystems.tmpl
      lkdtm: cleanup headers and module_param/MODULE_PARM_DESC
      Kconfig: remove redundant NETDEVICES depends

Ray Lehtiniemi (1):
      [ARM] 3927/1: Allow show_mem() to work with holes in memory map.

Raymond Mantchala (1):
      V4L/DVB (4787): Budget-ci: Inversion setting fixed for Technotrend 1500 T

Russ Anderson (1):
      [IA64] MCA recovery: Montecito support

Sean Hefty (1):
      RDMA/addr: Use client registration to fix module unload race

Srinivasa Ds (1):
      NFS4: fix for recursive locking problem

Stephen Hemminger (4):
      sky2: not experimental
      skge, sky2, et all. gplv2 only
      sky2: netpoll on dual port cards
      [TCP]: Set default congestion control when no sysctl.

Stephen Rothwell (3):
      Create compat_sys_migrate_pages
      powerpc: wire up sys_migrate_pages
      Fix sys_move_pages when a NULL node list is passed

Steve French (3):
      [CIFS] Fix readdir breakage when blocksize set too small
      [CIFS] Allow null user connections
      [CIFS] report rename failure when target file is locked by Windows

Steve Wise (2):
      IB/amso1100: Use dma_alloc_coherent() instead of kmalloc/dma_map_single
      IB/amso1100: Fix incorrect pr_debug()

Steven Whitehouse (2):
      [GFS2] Fix incorrect fs sync behaviour.
      [GFS2] Fix OOM error handling

Tejun Heo (4):
      sata_sis: fix flags handling for the secondary port
      libata: unexport ata_dev_revalidate()
      ata_piix: allow 01b MAP for both ICH6M and ICH7M
      ahci: fix status register check in ahci_softreset

Thomas Klein (3):
      ehea: Nullpointer dereferencation fix
      ehea: Removed redundant define
      ehea: 64K page support fix

Tilman Schmidt (1):
      isdn/gigaset: convert warning message

Timur Tabi (1):
      [POWERPC] qe_lib: qe_issue_cmd writes wrong value to CECDR

Trent Piepho (2):
      V4L/DVB (4752): DVB: Add DVB_FE_CUSTOMISE support for MT2060
      V4L/DVB (4751): Fix DBV_FE_CUSTOMISE for card drivers compiled into kernel

Troy Heber (1):
      [IA64] move SAL_CACHE_FLUSH check later in boot

Vasily Averin (1):
      [NETFILTER]: ip_tables: compat error way cleanup

Vlad Yasevich (2):
      [SCTP]: Correctly set IP id for SCTP traffic
      [SCTP]: Remove temporary associations from backlog and hash.

Yoichi Yuasa (3):
      [MIPS] Yosemite: fix uninitialized variable in titan_i2c_xfer()
      [MIPS] Fix warning of printk format in mips_srs_init()
      [MIPS] Fix warning in mips-boards generic PCI

Yvan Seth (1):
      ipmi_si_intf.c sets bad class_mask with PCI_DEVICE_CLASS

--21872808-292547592-1162953224=:3667--
