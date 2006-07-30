Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751156AbWG3G1R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751156AbWG3G1R (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Jul 2006 02:27:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751177AbWG3G1R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Jul 2006 02:27:17 -0400
Received: from smtp.osdl.org ([65.172.181.4]:31425 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751156AbWG3G1Q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Jul 2006 02:27:16 -0400
Date: Sat, 29 Jul 2006 23:27:11 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Linux v2.6.18-rc3
Message-ID: <Pine.LNX.4.64.0607292320490.4168@g5.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Ok, this missed a week (it should really have been -rc4, and we should 
have had a -rc3 a week ago), but the fact is, with a lot of people at the 
kernel summit and at OLS, it was so quiet for a week that there simply was 
no point.

In fact, it's been pretty quiet since too, which I attribute to 2.6.18-rc2 
just being so good, rather than the fact that it's summer and most people 
have probably been at the beach (or wished they were).

Or maybe it was just me missing some emails due to being away at the 
kernel summit. But I'll obviously blame just about anything else before 
admitting my own incompetence, so I seriously doubt that was it.

Anyway, shortlog appended, but there really hasn't been tons of stuff. 
Some network (and network driver) updates, infiniband, some scsi, and some 
fairly minor architecture updates (sparc, x86-64, arm).

		Linus

---
Adrian Bunk:
      [SCSI] aic79xx: make ahd_done_with_status() static
      [I/OAT]: net/core/user_dma.c should #include <net/netdma.h>
      [NETFILTER]: conntrack: fix SYSCTL=n compile

Alexey Dobriyan:
      [SUNLANCE]: fix compilation on sparc-UP

Alexey Kuznetsov:
      [IPV4] ipmr: ip multicast route bug fix.

Andi Kleen:
      i386/x86-64: Add user_mode checks to profile_pc for oprofile
      x86_64: Don't clobber r8-r11 in int 0x80 handler
      x86_64: Dump leftover backtrace entries when dwarf2 unwinder got stuck
      x86_64: Document backtracer selection options
      i386: Do backtrace fallback too
      x86_64: Update defconfig
      x86_64: On Intel systems when CPU has C3 don't use TSC
      x86_64: Revert k8-bus.c northbridge access change
      x86_64: Fix swiotlb=force
      i386: Fix up backtrace fallback patch
      MM: Remove rogue readahead printk

Andreas Krebbel:
      [S390] get_clock inline assembly.

Arjan van de Ven:
      Reorganize the cpufreq cpu hotplug locking to not be totally bizare

Auke Kok:
      e1000: Redo netpoll fix to address community concerns
      e1000: remove CRC bytes from measured packet length
      e1000: fix panic on large frame receive when mtu=default
      e1000: bump version to 7.1.9-k4

Ben Dooks:
      [ARM] 3732/1: S3C24XX: tidy syntax in osiris and anubis machines
      [ARM] 3733/2: S3C24XX: Remove old IDE registers in Anubis

bibo mao:
      x86_64: Enlarge debug stack for nested kprobes

Bob Breuer:
      [SPARC]: Fix property name acquisition in prom.c
      [SPARC]: Defer clock_probe to fs_initcall()

Brice Goglin:
      myri10ge - Always do a dummy RDMA after loading the firmware

Catalin Marinas:
      [ARM] 3734/1: Fix the unused variable warning in __iounmap()

Christoph Hellwig:
      [SCSI] aha152x: stop poking at saved scsi_cmnd members
      [SCSI] hide EH backup data outside the scsi_cmnd
      [SCSI] More buffer->request_buffer changes
      [NET]: Remove CONFIG_HAVE_ARCH_DEV_ALLOC_SKB
      [NET]: Correct dev_alloc_skb kerneldoc
      fix compile regression for a few scsi drivers
      [XFS] All xfs_disk_dquot_t values are (as the name says) disk endian.

Chuck Ebbert:
      ieee80211: TKIP requires CRC32
      i386: switch_to(): misplaced parentheses

Cornelia Huck:
      [S390] channel measurement interval display.
      [S390] duplicate ccw devices in ccwgroup.

Dan Williams:
      orinoco: fix setting transmit key only

Daniel Drake:
      softmac: do shared key auth in workqueue

Dave C Boutcher:
      [SCSI] ibmvscsi: allocate lpevents for ibmvscsi on iseries
      [SCSI] ibmvscsi: handle inactive SCSI target during probe

David S. Miller:
      [SPARC64]: Fix more of_device layer IRQ bugs, and correct PROMREG_MAX.
      [SPARC]: Kill prom_getname, unused and not implemented properly.
      [SERIAL] sunsab: Get line numbers and table sizing correct.
      [SPARC] sbus: Make sure sbus nodes are named uniquely.
      [SERIAL] sunzilog: Register IRQ after all devices have been probed.
      [SPARC]: Fix initialization of sun4d SBUS interrupts.
      [SPARC]: Simplify and correct __cpu_find_by()
      [SERIAL] sunzilog: Remove duplicate IRQ registry in zs_probe().
      [SERIAL] sunzilog: Fix instance enumeration.
      [SPARC]: Fix length parameter verification in sys_getdomainname().
      [SPARC64]: Update defconfig.
      [MAINTAINERS]: Mark LAPB as Oprhan.
      [IPV6] xfrm6_tunnel: Delete debugging code.
      [SPARC64]: Explicitly print return PC when the kernel fault PC is bogus.
      [SPARC]: Fix SA_STATIC_ALLOC value.
      [SCSI] esp: Fix build.
      [SPARC64]: Fix quad-float multiply emulation.
      [SPARC64]: Fix typo in pgprot_noncached().

Dotan Barak:
      IB/mthca: Fix SRQ limit event range check

Douglas Gilbert:
      [SCSI] update additional sense codes and some opcode names

Eric Moore:
      [SCSI] mptsas: use unnumbered port API and remove driver porttracking
      [SCSI] mptfusion: sas enclosures with smart drive
      [SCSI] mptfusion: mptctl panic when loading
      [SCSI] mptfusion: sas loginfo update
      [SCSI] mptfusion: sas nexus loss support
      [SCSI] mptfusion: task abort fix's
      [SCSI] mptfusion: firmware download boot fix's
      [SCSI] mptfusion: misc fix's
      [SCSI] mptfusion: bump version to 3.04.01

George G. Davis:
      [ARM] 3737/1: Export ARM copy/clear_user_page symbols

Guillaume Chazarain:
      [PKT_SCHED] netem: Fix slab corruption with netem (2nd try)
      [PKT_SCHED]: Fix regression in PSCHED_TADD{,2}.
      [IPV6]: Clean skb cb on IPv6 input.
      [IPV4]: Clear the whole IPCB, this clears also IPCB(skb)->flags.

Heiko Carstens:
      [S390] Fix gcc warning about unused return values.
      [S390] xpram module parameter parsing - take 2.
      [S390] .align 4096 statements in head.S
      [S390] sysfs_create_xxx return values.

Henrik Kretzschmar:
      [I/OAT]: Remove pci_module_init() from Intel I/OAT DMA engine

Herbert Xu:
      [IPV4]: Get rid of redundant IPCB->opts initialisation
      [NET]: Fix reversed error test in netif_tx_trylock

Ian McDonald:
      [DCCP]: Fix default sequence window size

Ingo Molnar:
      pi-futex: robust-futex exit crash fix
      pi-futex: robust-futex exit

James Bottomley:
      [SCSI] scsi_transport_sas: add unindexed ports
      [SCSI] scsi_transport_sas: add expander backlink
      [SCSI] scsi_transport_sas: kill the use of channel
      [SCSI] NCR_D700: misc fixes (section and argument ordering)

James Smart:
      [SCSI] lpfc 8.1.7: Use mod_timer instead of add_timer in lpfc_els_timeout_handler
      [SCSI] lpfc 8.1.7: Standardize the driver on a single define for the maximum supported targets
      [SCSI] lpfc 8.1.7: Fix memory leak and cleanup code related to per ring lookup array
      [SCSI] lpfc 8.1.7: Fixed infinite retry of REG_LOGIN mailbox failed due to MBXERR_RPI_FULL
      [SCSI] lpfc 8.1.7: Issue DOWN_LINK prior to INIT_LINK to work around link failure issue
      [SCSI] lpfc 8.1.7: Fix txcmplq related panics on heavy IO while downloading firmware
      [SCSI] lpfc 8.1.7: Correct bogus nodev_tmo message on NPort that changes its NPort Id
      [SCSI] lpfc 8.1.7: Consolidate dma buf cleanup into a separate function
      [SCSI] lpfc 8.1.7: Fix panic in lpfc_sli_validate_fcp_iocb
      [SCSI] lpfc 8.1.7: Adding new issue_reset sysfs attribute
      [SCSI] lpfc 8.1.7: Remove depricated sysfs attribute board_online
      [SCSI] lpfc 8.1.7: Correct the wait in attachment that delays for topology discovery
      [SCSI] lpfc 8.1.7: Add lpfc_sli_flush_mbox_queue() function
      [SCSI] lpfc 8.1.7: Misc Fixes
      [SCSI] lpfc 8.1.7: Change version number to 8.1.7

Jay Cliburn:
      via-velocity: fix speed and link status reported by ethtool

Jeff Garzik:
      [libata] ata_piix: Consolidate PCS register writing
      [libata] ata_piix: attempt to fix ICH8 support
      [libata] ata_piix: minor cleanups noticed in prior patch run
      [libata] ata_piix: correct 'invalid MAP value' typo-caused error
      [NET] ethtool: fix oops by testing correct struct member
      [libata] sata_promise: comment out duplicate PCI ID

Jens Axboe:
      cciss: fix stall with softirq handling and CFQ
      cfq-iosched: don't use a hard jiffies value, translate from msecs
      ide: option to disable cache flushes for buggy drives
      ide: if the id fields looks screwy, disable DMA
      it821x: fix ide dma setup bug
      scsi: kill overeager "not-ready" messages

Jens Osterkamp:
      spidernet: bug fix for init code
      spidernet: rework tx queue handling

Jiri Slaby:
      [NET]: sun happymeal, little pci cleanup

Jon Mason:
      x86_64: Calgary IOMMU - Multi-Node NULL pointer dereference fix

Krzysztof Halasa:
      [WAN]: Added missing netif_dormant_off() to generic HDLC
      [WAN]: Cosmetic changes to N2 and C101 drivers
      [WAN]: Converted synclink drivers to use netif_carrier_*()

Lennert Buytenhek:
      [ARM] 3730/1: ep93xx: enable usb ohci driver in the defconfig
      [ARM] 3736/1: xscale: don't mis-report 80219 as an iop32x

Linus Torvalds:
      [cpufreq] ondemand: make shutdown sequence more robust
      cpu hotplug: simplify and hopefully fix locking
      Linux v2.6.18-rc3

Luben Tuikov:
      [SCSI] st.c: Improve sense output

Marc Zyngier:
      [SPARC64] Fix sunsab ports ordering

Marcel Holtmann:
      [Bluetooth] Correct RFCOMM channel MTU for broken implementations
      [Bluetooth] Correct SCO buffer size for another Broadcom chip
      [Bluetooth] Correct SCO buffer size for Belkin devices
      [Bluetooth] Add quirk for another broken RTX Telecom based dongle
      [Bluetooth] Enable SCO support for Broadcom HID proxy dongle

Martin Michlmayr:
      [ARM] 3731/1: Allow IRQ definitions of IQ80331 and IQ80332 to co-exist

Martin Schwidefsky:
      [S390] update default configuration

Matthew Wilcox:
      [SCSI] aic7[9x]xx: Remove last vestiges of reverse_scan

Michael Chan:
      [TG3]: Add tg3_restart_hw()
      [TG3]: Handle tg3_init_rings() failures
      [TG3]: Update version and reldate

Michael S. Tsirkin:
      IB/uverbs: Fix unlocking in error paths
      IB/ipoib: Fix packet loss after hardware address update

Milton Miller:
      blktrace: fix read-ahead bit

Muli Ben-Yehuda:
      x86_64: Calgary IOMMU - fix off by one error

Nathan Scott:
      [XFS] Fix remount vs no/barrier options by ensuring we clear unwanted
      [XFS] Fix a barrier related forced shutdown on mounts with quota enabled.
      [XFS] Ensure bulkstat from an invalid inode number gets caught always with

Nicolas Dichtel:
      [IFB] After ifb_init_one() failed, i is increased. Decrease
      [DUMMY]: Avoid an oops when dummy_init_one() failed

Or Gerlitz:
      IB/ipoib: Fix oops with ipoib_debug_mcast set

Panagiotis Issaris:
      [NET]: Conversions from kmalloc+memset to k(z|c)alloc.
      [TIPC]: Removing useless casts

Patrick McHardy:
      [IPV4]: Fix nexthop realm dumping for multipath routes
      [NETFILTER]: H.323 helper: fix possible NULL-ptr dereference
      [NETFILTER]: nf_queue: handle NF_STOP and unknown verdicts in nf_reinject
      [NETFILTER]: SNMP NAT: fix byteorder confusion
      [NETFILTER]: bridge netfilter: add deferred output hooks to feature-removal-schedule
      [NETFILTER]: Demote xt_sctp to EXPERIMENTAL

Paul Jackson:
      Cpuset: fix ABBA deadlock with cpu hotplug lock

Pavel Machek:
      zd1201: workaround interference problem

Peter Oberparleiter:
      [S390] permanent subchannel busy conditions may cause I/O stall

Phil Oester:
      [NETFILTER]: xt_pkttype: fix mismatches on locally generated packets

Ralph Campbell:
      IB/ipath: Fix a data corruption
      IB/ipath: Fix ib_ipath driver to work with SRP
      IB/ipath: ipath_skip_sge() can break if num_sge > 1

Randy Dunlap:
      [SCSI] scsi_debug: must_check fixes

Raymond Burns:
      [SPARC]: Initialize iounit spinlock in iounit_init().
      [SPARC]: Do not call sun4m_irq_rotate on sun4d.
      [SPARC]: Get sun4d SMP building again.

Robert Schulze:
      airo: should select crypto_aes

Roland Dreier:
      IB/uverbs: Fix lockdep warnings
      IB/mthca: Initialize max_cmds before debug code prints it

Russell King:
      [ARM] Fix cats build
      [ARM] Fix SMP booting

Samuel Ortiz:
      [IrDA]: Use alloc_skb() in IrDA TX path

Sean Hefty:
      IB/mad: Validate MADs for spec compliance

Sridhar Samudrala:
      [SCTP]: Check for NULL arg to sctp_bucket_destroy().
      [SCTP]: Verify all the paths to a peer via heartbeat before using them.
      [SCTP]: Set chunk->data_accepted only if we are going to accept it.
      [SCTP]: ADDIP: Don't use an address as source until it is ASCONF-ACKed

Stefan Rompf:
      [VLAN]: Fix link state propagation

Stephen Hemminger:
      sky2: NAPI poll fix
      skge: chip clock rate typo

Tejun Heo:
      ata_piix: add host_set private structure
      libata: fix autopsy ehc->i.action and ehc->i.dev handling
      libata: fix eh_skip_recovery condition
      libata: improve EH action and EHI flag handling

Tetsuo Handa:
      [IPV4/IPV6]: Setting 0 for unused port field in RAW IP recvmsg().

Vlad Yasevich:
      [SCTP]: Unhash the endpoint in sctp_endpoint_free().

