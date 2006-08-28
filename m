Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750840AbWH1Eaz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750840AbWH1Eaz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Aug 2006 00:30:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751288AbWH1Eaz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Aug 2006 00:30:55 -0400
Received: from smtp.osdl.org ([65.172.181.4]:59852 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750840AbWH1Eay (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Aug 2006 00:30:54 -0400
Date: Sun, 27 Aug 2006 21:30:50 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Linux v2.6.18-rc5
Message-ID: <Pine.LNX.4.64.0608272122250.27779@g5.osdl.org>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="21872808-1730480591-1156739450=:27779"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--21872808-1730480591-1156739450=:27779
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT


Ok,
 this was delayed three weeks due to a combination of vacations and a 
funeral in Finland, but Greg and Andrew kept on top of things, and we were 
fairly late in the release cycle anyway, so it hopefully caused no real 
problems apart from obviously delaying the final release a tiny bit.

Linux 2.6.18-rc5 is out there now, both in git form and as patches and 
tar-balls (the latter which I forgot for -rc4, but Greg covered for me - 
blush).

The shortlog (appended) tells the story: various fixes all around. 
Powerpc, V4L, networking, SCSI..

Pls test it out, and please remind all the appropriate people about any 
regressions you find (including any found earlier if they haven't been 
addressed yet).

	Thanks,
		Linus


---
Adam Litke:
      [POWERPC] hugepage BUG fix

Adrian Bunk:
      fs/ocfs2/dlm/dlmmaster.c: unexport dlm_migrate_lockres
      drivers/net/e1000/: possible cleanups

Alan Cox:
      PATCH: 2.6.18 oops on boot fix for IDE
      tty layer comment the locking assumptions and functions somewhat
      Fix tty layer DoS and comment relevant code

Alan Stern:
      unusual_devs update for UCR-61S2B

Albert Lee:
      libata: Use ATA_FLAG_PIO_POLLING for pdc_adma

Alexander Zarochentsev:
      fuse: fix error case in fuse_readpages

Alexey Dobriyan:
      xircom_cb: wire up errors from pci_register_driver()
      Input: remove dead URLs from Doclumentation/input/joystick.txt
      Fix docs for fs.suid_dumpable

Alexey Kuznetsov:
      [IPV4]: severe locking bug in fib_semantics.c

Ananth N Mavinakayanahalli:
      [POWERPC] kprobes: Fix possible system crash during out-of-line single-stepping

Andreas Herrmann:
      [SCSI] zfcp: minor erp bug fixes
      [SCSI] zfcp: bump version number

Andrew Morton:
      adfs error message fix
      panic.c build fix
      workqueue: remove lock_cpu_hotplug()
      [NETFILTER]: xt_physdev build fix
      82596 section fixes
      ac3200 section fixes
      cops section fix
      cs89x0 section fix
      at1700 section fix
      e2100 section fix
      eepro section fix
      eexpress section fix
      es3210 section fix
      eth16i section fix
      lance section fix
      lne390 section fix
      ni52 section fix
      ibmtr section fix
      smctr section fix
      wd section fix
      ni65 section fix
      seeq8005 section fix
      winbond-840 section fix
      fealnx section fix
      sundance section fix
      s2io build fix
      /proc/meminfo: don't put spaces in names

Andrew Vasquez:
      [SCSI] qla2xxx: Log Trace/Diagonostic asynchronous events.
      [SCSI] qla2xxx: Update version number to 8.01.05-k4.
      [SCSI] qla2xxx: Correct PLOGI retry logic.
      [SCSI] qla2xxx: Properly re-enable EFT support after an ISP abort.
      [SCSI] qla2xxx: Update version number to 8.01.07-k1.

Andries Brouwer:
      Fix for minix crash
      ext2: prevent div-by-zero on corrupted fs

Andy Fleming:
      [POWERPC] Fix interrupts on 8540 ADS board
      [POWERPC] Fix CDS IRQ handling and PCI code
      [POWERPC] Add 85xx DTS files to powerpc
      [POWERPC] Fix FEC node in 8540 ADS dts

ASANO Masahiro:
      VFS: add lookup hint for network file systems

Badari Pulavarty:
      Manage jbd allocations from its own slabs

Ben Dooks:
      [ARM] 3753/1: S3C24XX: DMA fixes
      [ARM] 3754/1: S3C24XX: tidy arch/arm/mach-s3c2410/Makefile
      drivers/rtc: fix rtc-s3c.c
      rtc-s3c.c: fix time setting checks

Benjamin Herrenschmidt:
      [POWERPC] Fix irq radix tree remapping typo
      [POWERPC] Fix BootX booting with an initrd

Bjorn Helgaas:
      PCI: quirk to disable e100 interrupt if RESET failed to

Brandon Philips:
      genhd.c reference in Documentation/kobjects.txt

Brice Goglin:
      myri10ge: always re-enable dummy rdmas in myri10ge_resume

Catalin Marinas:
      [ARM] 3757/1: Use PROCINFO_INITFUNC in head.S

Chen-Li Tien:
      [PKTGEN]: Fix oops when used with balance-tlb bonding

Christoph Hellwig:
      [SCSI] fix simscsi
      [SCSI] hptiop: backout ioctl mess
      [NET]: Fix alloc_skb comment typo
      [NET]: Assign skb->dev in netdev_alloc_skb
      [TG3]: skb->dev assignment is done by netdev_alloc_skb

Chuck Lever:
      SUNRPC: avoid choosing an IPMI port for RPC traffic

Cornelia Huck:
      [S390] retry after deferred condition code.

Dan Bastone:
      initialize parts of udf inode earlier in create

Daniel Kobras:
      dm: Fix deadlock under high i/o load in raid1 setup.

Daniel Ritz:
      PCI: use PCBIOS as last fallback
      PCI: i386 mmconfig: don't forget bus number when setting fallback_slots bits
      PCI: fix ICH6 quirks

Danny Tholen:
      1394: fix for recently added firewire patch that breaks things on ppc

Dave Jones:
      PCI: remove dead HOTPLUG_PCI_SHPC_PHPRM_LEGACY option.
      cpufreq: acpi-cpufreq: Ignore failure from acpi_cpufreq_early_init_acpi
      fix up lockdep trace in fs/exec.c

Dave Kleikamp:
      JFS: Quota support broken, no quota_read and quota_write
      JFS: Fix bug in quota code.  tmp_bh.b_size must be initialized

David Brownell:
      build fixes: smc91x
      i2c: tps65010 build fixes

David Howells:
      NFS: Check lengths more thoroughly in NFS4 readdir XDR decode

David Kuehling:
      USB: unusual_devs entry for A-VOX WSX-300ER MP3 player

David L Stevens:
      [MCAST]: Fix filter leak on device removal.

David S. Miller:
      [PKTGEN]: Make sure skb->{nh,h} are initialized in fill_packet_ipv6() too.
      [RTNETLINK]: Fix IFLA_ADDRESS handling.
      [IPX]: Fix typo, ipxhdr() --> ipx_hdr()
      [TCP]: Fix botched memory leak fix to tcpprobe_read().
      [IPSEC]: Validate properly in xfrm_dst_check()
      [VLAN]: Make sure bonding packet drop checks get done in hwaccel RX path.
      [NET]: Disallow whitespace in network device names.
      [SPARC64]: Fix pfn_pte() build failure.
      [SCSI] esp: Fix build on SUN4.
      [SERIAL] sunzilog: Mirror the sunsab serial setup bug fix.

David Wilder:
      [POWERPC] Make secondary CPUs call into kdump on reset exception

Deepak Saxena:
      Update smc91x driver with ARM Versatile board info

Diego Calleja:
      V4L/DVB (4430): Quickcam_messenger compilation fix

Dirk Eibach:
      char/moxa.c: fix endianess and multiple-card issues

Dmitry Mishin:
      [NET]: add_timer -> mod_timer() in dst_run_gc()

Dmitry Torokhov:
      Input: wistron - fix crash due to referencing __initdata

Don Fry:
      pcnet32: break in 2.6.18-rc1 identified

Douglas Gilbert:
      [SCSI] sg: fix incorrect page problem

Edgar E. Iglesias:
      skge: remember to run netif_poll_disable()

Edgar Hucek:
      add imacfb documentation and detection

Eric Sesterhenn:
      Signedness issue in drivers/net/3c515.c

Evgeniy Dushistov:
      ufs: write to hole in big file
      ufs: truncate correction

Evgeniy Polyakov:
      [CONNECTOR]: Add userspace example code into Documentation/connector/

Florin Malita:
      Input: atkbd - fix overrun in atkbd_set_repeat_rate()

George G. Davis:
      [ARM] 3745/1: Add EXPORT_SYMBOL(rtc_next_alarm_time) to ARM rtctime.c

Gerald Schaefer:
      [S390] add __cpuinit to appldata_cpu_notify

Grant Grundler:
      [SCSI] sym2: claim only "Storage" class

Greg Kroah-Hartman:
      USB: fix bug in cypress_cy7c63.c driver

Handle X:
      ACPI: hotkey.c fixes, fix for potential crash of hotkey.c

Hans de Goede:
      PATCH: 1 line 2.6.18 bugfix: modpost-64bit-fix.patch
      hwmon: abituguru timeout fixes

Hans Verkuil:
      V4L/DVB (4416): Cx25840_read4 has wrong endianness.
      V4L/DVB (4418): Fix broken msp3400 module option 'standard'
      V4L/DVB (4419): Turn on the Low Noise Amplifier of the Samsung tuners.

Haren Myneni:
      [POWERPC] Fix might-sleep warning on removing cpus

Heiko Carstens:
      [S390] tape class return value handling.
      [S390] dasd slab cache alignment.
      [S390] kernel page table allocation.
      s390: fix arp_tbl lock usage in qeth

Henrik Kretzschmar:
      PCI: kerneldoc correction in pci-driver

Herbert Xu:
      Send wireless netlink events with a clean slate
      [IPV6]: The ifa lock is a BH lock
      [INET]: Use pskb_trim_unique when trimming paged unique skbs
      [BRIDGE]: Disable SG/GSO if TX checksum is off

HighPoint Linux Team:
      [SCSI] hptiop: wrong register used in hptiop_reset_hba()

Horms:
      Change panic_on_oops message to "Fatal exception"

Horst Hummel:
      [S390] dasd set offline kernel bug.
      [S390] dasd calls kzalloc while holding a spinlock.
      [S390] dasd PAV enabling.

Ian McDonald:
      [DCCP]: Fix typo
      [DCCP]: Update contact details and copyright
      [DCCP]: Introduces follows48 function
      [DCCP]: Introduce dccp_rx_hist_find_entry
      [DCCP]: Fix CCID3

Ingo Molnar:
      [IPV6] lockdep: annotate __icmpv6_socket
      lockdep: annotate idescsi_pc_intr()
      lockdep: annotate reiserfs

J. Bruce Fields:
      NFSv4: increase client-provided nfs4 clientid size

Jack Morgenstein:
      IB/core: Fix SM LID/LID change with client reregister set

James Smart:
      [SCSI] lpfc 8.1.7 : Add statistics reset callback for FC transport
      [SCSI] lpfc 8.1.7 : Fix failing firmware download due to mailbox delays needing to be longer
      [SCSI] lpfc 8.1.7 : Fix race condition between lpfc_sli_issue_mbox and lpfc_online
      [SCSI] lpfc 8.1.7 : Short bug fixes
      [SCSI] lpfc 8.1.7 : ID String and Message fixes
      [SCSI] lpfc 8.1.7 : Change version number to 8.1.8
      [SCSI] lpfc 8.1.9 : Misc Bug Fixes
      [SCSI] lpfc 8.1.9 : Stall eh handlers if resetting while rport blocked
      [SCSI] lpfc 8.1.9 : Change version number to 8.1.9

Jan "Yenya" Kasprzak:
      [NET]: Terminology in ip-sysctl.txt

Jan Blunck:
      fix hrtimer percpu usage typo

Jan Kara:
      Fix possible UDF deadlock and memory corruption (CVE-2006-4145)

Jean Delvare:
      ACPI: fix kfree in i2c_ec error path

Jeff Garzik:
      [libata] manually inline ata_host_remove()

Jeff Mahoney:
      [DISKLABEL] SUN: Fix signed int usage for sector count

Jim Lewis:
      Add ethtool -g support to Spidernet network driver

Joerg Ahrens:
      xirc2ps_cs: Cannot reset card in atomic context

Johannes Berg:
      USB: appletouch: fix atp_disconnect

john stultz:
      futex_handle_fault always fails

Jon Loeliger:
      [POWERPC] Convert to mac-address for ethernet MAC address data.
      [POWERPC] Add MPC8641 HPCN Device Tree Source file.
      [POWERPC] Offer PCI as a CONFIG choice for PPC_86xx.
      [POWERPC] Fix the mpc8641_hpcn.dts file.
      [POWERPC] Rewrite the PPC 86xx IRQ handling to use Flat Device Tree

Jonathan Davies:
      USB: ftdi_sio driver - new PIDs

Jonathan McDowell:
      MTD NAND: Fix ams-delta after core conversion

Ju, Seokmann:
      [SCSI] megaraid_{mm,mbox}: 64-bit DMA capability checker
      [SCSI] megaraid_{mm,mbox}: a fix on INQUIRY with EVPD
      [SCSI] megaraid_{mm,mbox}: a fix on "kernel unaligned access address" issue

Juha [кцlд:
      [ARM] 3744/1: MMC: mmcqd gets stuck when block queue is plugged

KAMEZAWA Hiroyuki:
      register_one_node() compile fix
      CONFIG_ACPI_SRAT NUMA build fix
      x86: NUMAQ Kconfig fix

Keith Owens:
      Fix compile problem when sata debugging is on

Kevin Hao:
      net: Add netconsole support to dm9000 driver

Kevin Hilman:
      [ATM]: Compile error on ARM
      [ARM] 3755/1: dmabounce: fix return value for find_safe_buffer

Kirill Korotaev:
      [IPV4]: Limit rt cache size properly.
      sys_getppid oopses on debug kernel

Kristen Carlson Accardi:
      ACPI: add Dock Station driver to MAINTAINERS file
      pciehp: make pciehp build for powerpc
      ACPIPHP: allow acpiphp to build without ACPI_DOCK

Krzysztof Halasa:
      WAN: fix C101 card carrier handling

Krzysztof Helt:
      [SPARC]: enabling of the 2nd CPU in 2.6.18-rc4
      [SPARC]: Small smp cleanup.

Kurt Hackel:
      ocfs2: Fix lvb corruption
      ocfs2: do not modify lksb->status in the unlock ast
      ocfs2: fix check for locally granted state during dlmunlock()

Len Brown:
      ACPI: restore some dmesg to DEBUG-only, ala 2.6.17
      ACPI: skip smart battery init when acpi=off
      ACPI: avoid irqrouter_resume might_sleep oops on resume from S4

Lennert Buytenhek:
      smc91x: disable DMA mode on the logicpd pxa270

Li Yang:
      Freescale QE UCC gigabit ethernet driver
      [POWERPC] Fix compile problem without CONFIG_PCI

Linus Torvalds:
      Linux v2.6.18-rc5

Luc Van Oostenryck:
      V4L/DVB (4395): Restore compat_ioctl in pwc driver

Marc Zyngier:
      [SERIAL] sunsab: Fix E250 console with RSC.

Mark Fasheh:
      ocfs2: limit cluster bitmap information saved at mount
      ocfs2: better group descriptor consistency checks
      ocfs2: allocation hints

Mark Huang:
      [NETFILTER]: ulog: fix panic on SMP kernels

Martin Hicks:
      libata: PHY reset requires writing 0x4 to SControl

Martin Michlmayr:
      [ARM] 3747/1: Fix compilation error in mach-ixp4xx/gtwx5715-setup.c

Martin Schwidefsky:
      [S390] xpram system device class.

Masoud Asgharifard Sharbiani:
      eventpoll.c compile fix

Matt LaPlante:
      [WATCHDOG] Kconfig typos fix.

Mauro Carvalho Chehab:
      V4L/DVB (4340): Videodev.h should be included also when V4L1_COMPAT is selected.
      V4L/DVB (4371a): Fix V4L1 dependencies on compat_ioctl32
      V4L/DVB (4371b): Fix V4L1 dependencies at drivers under sound/oss and sound/pci
      V4L/DVB (4399): Fix a typo that caused some compat stuff to not work
      V4L/DVB (4407): Driver dsbr100 is a radio device, not a video one!
      V4L/DVB (4427): Fix V4L1 Compat for VIDIOCGPICT ioctl

Michael Chan:
      [TG3]: Fix tx race condition
      [BNX2]: Fix tx race condition.
      [BNX2]: Convert to netdev_alloc_skb()

Michael Ellerman:
      [POWERPC] Move some kexec logic into machine_kexec.c
      [POWERPC] Make crash.c work on 32-bit and 64-bit

Michael Rash:
      [TEXTSEARCH]: Fix Boyer Moore initialization bug

Michael Reed:
      [SCSI] mptfc: properly wait for firmware target discovery to complete
      [SCSI] mptfc: correct out of order event processing

Michael S. Tsirkin:
      IB/mthca: Make fence flag work for send work requests
      IB/mthca: Update HCA firmware revisions

Michal Januszewski:
      fbdev: include backlight.h only when __KERNEL__ is defined

Michal Miroslaw:
      dm: BUG/OOPS fix

Michal Ruzicka:
      [IPV4]: Possible leak of multicast source filter sctructure

Mike Christie:
      [SCSI] iscsi bugfixes: send correct error values to userspace
      [SCSI] iscsi bugfixes: fix r2t handling
      [SCSI] iscsi bugfixes: handle data rsp errors
      [SCSI] iscsi bugfixes: fix abort handling
      [SCSI] iscsi bugfixes: fix oops when iser is flushing io
      [SCSI] iscsi bugfixes: fix oops when removing session
      [SCSI] iscsi bugfixes: dont use GFP_KERNEL for sending errors
      [SCSI] iscsi bugfixes: reduce memory allocations
      [SCSI] iscsi bugfixes: pass errors from complete_pdu to caller
      [SCSI] iscsi bugfixes: fix mem leaks in libiscsi
      [SCSI] iscsi bugfixes: update and move version number
      [SCSI] fix scsi_send_eh_cmnd regression

Mingming Cao:
      ext3 filesystem bogus ENOSPC with reservation fix

Nathan Lynch:
      [POWERPC] Fix gettimeofday inaccuracies

Nathan Scott:
      [XFS] Fix xfs_free_extent related NULL pointer dereference.

NeilBrown:
      md: avoid backward event updates in md superblock when degraded.
      md: fix recent breakage of md/raid1 array checking

Nick Piggin:
      cpuset: oom panic fix

Nicolas Pitre:
      [ARM] 3746/2: Userspace helpers must be Thumb mode interworkable

Nikita Danilov:
      NFS: Fix a potential deadlock in nfs_release_page

Norihiko Tomiyama:
      USB: Additional PID for SHARP W-ZERO3

Oleg Nesterov:
      sys_ioprio_set: minor do_each_thread+break fix
      Fix current_io_context() vs set_task_ioprio() race
      uninline ioprio_best()
      cfq_cic_link: fix usage of wrong cfq_io_context
      elv_unregister: fix possible crash on module unload
      revert "Drop tasklist lock in do_sched_setscheduler"
      futex_find_get_task(): remove an obscure EXIT_ZOMBIE check

Olof Johansson:
      [POWERPC] powerpc: Clear HID0 attention enable on PPC970 at boot time

Orjan Friberg:
      USB: usbtest.c: unsigned retval makes ctrl_out return 0 in case of error

Panagiotis Issaris:
      [PPP]: handle kmalloc failures and convert to using kzalloc

Patrick McHardy:
      [NETFILTER]: xt_hashlimit: fix limit off-by-one
      [NETFILTER]: {arp,ip,ip6}_tables: proper error recovery in init path
      [NETFILTER]: ctnetlink: fix deadlock in table dumping
      [NETFILTER]: ip_tables: fix table locking in ipt_do_table
      [NETFILTER]: arp_tables: fix table locking in arpt_do_table

Paul A. Clarke:
      matroxfb: fix jittery display on non-ppc systems

Paul Gortmaker:
      [ARM] 3756/1: Assign value for HWCAP_IWMMXT

Paul Jackson:
      cpuset: top_cpuset tracks hotplug changes to cpu_online_map

Paul Mackerras:
      [POWERPC] Correct masks used in emulating some instructions

Pavel Machek:
      pr_debug() should not be used in drivers
      ACPI: fix boot with acpi=off

Pavel Roskin:
      spectrum_cs: Fix incorrect use of pcmcia_dev_present()
      hostap: Restore antenna selection settings after port reset

Peter Korsgaard:
      smc911x: Re-release spinlock on spurious interrupt

Peter Oberparleiter:
      [S390] lost interrupt after chpid vary off/on cycle.
      [S390] inaccessible PAV alias devices on LPAR.

Peter Zijlstra:
      lockdep: fix blkdev_open() warning

Phil Oester:
      [NETFILTER]: xt_string: fix negation

Pierre Ossman:
      [MMC] Fix base address configuration in wbsd
      [MMC] Another stray 'io' reference

Pozsar Balazs:
      Input: psmouse - fix Intellimouse 4.0 initialization

Rafael J. Wysocki:
      swsusp: Fix swap_type_of

Ralf Hildebrandt:
      [PKT_SCHED] cls_u32: Fix typo.

Randy Dunlap:
      ACPI: handle firmware_register init errors
      ACPI: scan: handle kset/kobject errors
      ACPI: add message if firmware_register() init fails
      ACPI: verbose on kset/kobject_register errors
      cdrom/gdsc: fix printk format warning

Richard Purdie:
      spectrum_cs: Fix firmware uploading errors
      mtd corruption fix

Roger Luethi:
      via-rhine: NAPI support
      via-rhine: add option avoid_D3 (work around broken BIOSes)

Roland Dreier:
      IB/mthca: Fix potential AB-BA deadlock with CQ locks
      IB/mthca: No userspace SRQs if HCA doesn't have SRQ support

Rolf Eike Beer:
      tty: remove bogus call to cdev_del()

Russell King:
      [ARM] Fix pci export warnings
      [ARM] Fix NCR5380-based SCSI card build
      [ARM] Fix Acorn platform SCSI driver build failures
      lockdep: fix smc91x

Sam Ravnborg:
      kbuild: do not try to build content of initramfs
      kbuild: external modules shall not check config consistency
      kbuild: correct assingment to CFLAGS with CROSS_COMPILE

Samuel Thibault:
      vcsa attribute bits -> ioctl(VT_GETHIFONTMASK)

Scott Murray:
      CPCI hotplug: fix resource assignment

Shyam Sundar:
      [SCSI] qla2xxx: Correct endianess problem while issuing a Marker IOCB on ISP24xx.

Sonny Rao:
      [POWERPC] fix PMU initialization on pseries lpar

Sridhar Samudrala:
      Fix sctp privilege elevation (CVE-2006-3745)

Starikovskiy, Alexey Y:
      ACPI: relax BAD_MADT_ENTRY check to allow LSAPIC variable length string UIDs

Stephen Hemminger:
      [IPX]: Header length validation needed
      [IPX]: Another nonlinear receive fix
      sky2: phy power problems on 88e805X chips
      [LLC]: multicast receive device match
      via-rhine: NAPI poll enable
      [TCP]: Limit window scaling if window is clamped.
      [IPV6]: Segmentation offload not set correctly on TCP children
      [BRIDGE] netfilter: memory corruption fix

Steven Rostedt:
      Add stable branch to maintainers file

Suresh Siddha:
      [NET]: Fix potential stack overflow in net/core/utils.c

Tejun Heo:
      libata: fix ata_port_detach() for old EH ports
      ata_piix: fix host_set private_data intialization
      sata_sil24: don't set probe_ent->mmio_base
      libata: fix ata_device_add() error path
      libata: clear sdev->locked on door lock failure
      ata_piix: fix ghost device probing by honoring PCS present bits
      ata_piix: ignore PCS on ICH5
      ata_piix: implement force_pcs module parameter
      sata_via: use old SCR access pattern on vt6420

Thomas Meyer:
      x86: Fix dmi detection of MacBookPro and iMac

Tom Zanussi:
      Documentation update for relay interface

Tomasz Kazmierczak:
      USB: pl2303: removed support for OTi's DKU-5 clone cable

Trent Piepho:
      V4L/DVB (4411): Fix minor errors in build files

Trond Myklebust:
      fcntl(F_SETSIG) fix
      SUNRPC: make rpc_unlink() take a dentry argument instead of a path
      NFS: clean up rpc_rmdir
      SUNRPC: rpc_unlink() must check for unhashed dentries
      SUNRPC: Fix dentry refcounting issues with users of rpc_pipefs
      LOCKD: Fix a deadlock in nlm_traverse_files()
      NFS: Fix issue with EIO on NFS read
      NFSv4: Add v4 exception handling for the ACL functions.
      VFS: Fix access("file", X_OK) in the presence of ACLs
      VFS: Remove redundant open-coded mode bit check in prepare_binfmt().
      VFS: Remove redundant open-coded mode bit checks in open_exec().

Vitaly Bordug:
      PAL: Support of the fixed PHY
      FS_ENET: use PAL for mii management
      ppc32: board-specific part of fs_enet update

Vladislav Bolkhovitin:
      [SCSI] qla2xxx: Fix to allow to reset devices using sg interface (sg_reset).

Volker Sameske:
      [SCSI] zfcp: improve management of request IDs

Wei Yongjun:
      [TCP]: SNMPv2 tcpOutSegs counter error

Will Schmidt:
      [POWERPC] update {g5,iseries,pseries}_defconfigs

William Morrrow:
      ACPI: Handle BIOS that resumes from S3 to suspend routine rather than resume vector

Yasunori Goto:
      ACPI: memory hotplug: remove useless message at boot time

Yeasah Pell:
      V4L/DVB (4431): Add several error checks to dst

Yingchao Zhou:
      Remove redundant up() in stop_machine()

Yoav Steinberg:
      [ARM] 3752/1: fix versatile flash resource map

Yoichi Yuasa:
      USB: removed a unbalanced #endif from ohci-au1xxx.c

Zang Roy-r61911:
      [POWERPC] Update mpc7448hpc2 board irq support using device tree
      [POWERPC] Pass UPIO_TSI flag to 8259 serial driver

--21872808-1730480591-1156739450=:27779--
