Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751470AbWBQWp3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751470AbWBQWp3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Feb 2006 17:45:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751472AbWBQWp3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Feb 2006 17:45:29 -0500
Received: from smtp.osdl.org ([65.172.181.4]:34539 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751470AbWBQWp2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Feb 2006 17:45:28 -0500
Date: Fri, 17 Feb 2006 14:45:23 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Linux 2.6.16-rc4
Message-ID: <Pine.LNX.4.64.0602171438050.916@g5.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Since it's a long weekend in the US, and since I know you'll all be bored 
to tears without a new release to play with, I'm cutting 2.6.16-rc4 a few 
days early.

[ Actually, since -rc2 and -rc3 were both late, we're still off the normal 
  "once a week" release schedule, but let's ignore that ]

The bulk of it is some SCSI driver updates (have you ever seen a diffstat 
without the qla driver taking the top spot? No? Neither have I), with a 
few architectures thrown in, and a number of mostly trivial fixes for good 
measure.

It is, as we say in the business, a "perfect" release. No bugs. No sirree. 
But just to verify that, you should all immediately download and test it. 
Since, quite frankly, what else do you have to do over the weekend?

		Linus

---
adam radford:
      [SCSI] 3ware 9000 driver >4GB memory fix

Adrian Bunk:
      fix a typo in the CPU_H8300H dependencies
      arch/sh/Kconfig: fix the ISA_DMA_API dependencies

Adrian Drzewiecki:
      [BRIDGE]: Fix deadlock in br_stp_disable_bridge

Alan Cox:
      Fix locking error in esp

Alan Stern:
      usb-storage: new unusual_devs entry
      usb-storage: unusual_devs entry
      USB: unusual_devs.h entry: TrekStor i.Beat
      USB: unusual_devs.h entry: iAUDIO M5

Albert D. Cahalan:
      x86: document sysenter path

Albert Lee:
      libata: minor fix for 2.6.16-rc3

Alessandro Zummo:
      Input: ixp4xx-beeper - fix compile error

Andi Kleen:
      x86_64: Update defconfig
      x86_64: Add boot option to disable randomized mappings and cleanup
      x86_64: Don't call do_exit with interrupts disabled after IRET exception
      x86_64: Don't enable ATI apicmaintimer workaround when the machine has C2 or C3
      x86_64: Disable tsc when apicpmtimer is active
      x86_64: Resolve the RIP of an early exception using kallsyms
      x86_64: Relax SRAT covers all memory check a bit
      x86_64: Always pass full number of nodes to NUMA hash computation
      Handle all and empty zones when setting up custom zonelists for mbind

Andreas Herrmann:
      [SCSI] zfcp: get rid of physical_wwpn and physical_s_id
      [SCSI] zfcp: fix adapter erp when link is unplugged
      [SCSI] zfcp: fix: avoid race between fc_remote_port_add and scsi_add_device

Andreas Schwab:
      [IA64] Remove duplicate EXPORT_SYMBOLs

Andrew Morton:
      [APPLETALK]: warning fix
      ide: touch softlockup detector during pio
      swsusp: nuke noisy message
      smctr warning fix
      select: time comparison fixes

Andrew Vasquez:
      [SCSI] qla2xxx: Add port-speed FC transport attribute.
      [SCSI] qla2xxx: Add host port-type FC transport attribute.
      [SCSI] qla2xxx: Add host-statistics FC transport attributes.
      [SCSI] qla2xxx: Add beacon support via class-device attribute.
      [SCSI] qla2xxx: Return correct data-len during NVRAM retrieval.
      [SCSI] qla2xxx: Add support to retrieve/update HBA option-rom.
      qla2xxx: Close window on race between rport removal and fcport transition.
      qla2xxx: Remove bogus debug-code.
      qla2xxx: Pass input-buffer length to Get-ID-List mailbox command.
      qla2xxx: Correct lun assignment during IOCB submission.

Arthur Othieno:
      Input: kill remnants of 98kbd{,-io} and 98spkr
      [SERIAL] Documentation/jsm.txt is a no show.

Ashok Raj:
      [IA64] Dont set NR_CPUS for cpu_possible_map when CPU hotplug is enabled.
      [IA64] Count disabled cpus as potential hot-pluggable CPUs
      [IA64] Count disabled cpus as potential hot-pluggable CPUs

Atsushi Nemoto:
      [MIPS] Rewrite get_wchan and its helper functions using kallsyms_lookup.
      [MIPS] Add protected_blast_icache_range, blast_icache_range, etc.
      [MIPS] Fix typo in _sys32_rt_sigreturn and _sysn32_rt_sigreturn.

Benjamin LaHaise:
      kbuild: revert "fix make -jN with multiple targets with O=..."

Bjorn Helgaas:
      HPET: handle multiple ACPI EXTENDED_IRQ resources
      mmconfig: add kernel parameter documentation
      ACPI: fix vendor resource length computation

Brian King:
      [SCSI] ipr: Fix adapter initialization failure

Chen, Kenneth W:
      sched: revert "filter affine wakeups"

Chris Wright:
      sys_mbind sanity checking

Christian Lindner:
      USB: PL2303: Leadtek 9531 GPS-Mouse

Christian Trefzer:
      neofb: avoid resetting display config on unblank
      neofb: avoid resetting display config on unblank (v2)

Chuck Ebbert:
      i386: fix singlestepping though a syscall

Cornelia Huck:
      s390: ccw device disbanding
      s390: fix assignment instead of check in ccw_device_set_online()

Dan Williams:
      wireless/atmel: fix setting TX key only in ENCODEEXT
      wireless/atmel: fix Open System authentication process bugs
      Necessary evil to get sata_vsc to initialize with Intel iq3124h hba

Daniel Yeisley:
      x86_64: early initialization of cpu_to_node

Dave Jones:
      [CPUFREQ] cpufreq_notify_transition cleanup.
      [CPUFREQ] Whitespace/CodingStyle cleanups
      Remove "RV370 5B60 [Radeon X300 (PCIE)]" from DRI list
      [ATM]: Ratelimit atmsvc failure messages
      [IPV4] ICMP: Invert default for invalid icmp msgs sysctl
      [P8023]: Fix tainting of kernel.

David Brownell:
      USB: fix up the usb early handoff logic for EHCI
      USB: sl811_cs needs platform_device conversion too
      Input: ads7846 - assorted updates

David Gibson:
      powerpc: Fix accidentally-working typo in __pud_free_tlb

David Howells:
      FRV: Miscellaneous fixes
      FRV: Use virtual interrupt disablement

David S. Miller:
      [SPARC]: sys_newfstatat --> sys_fstatat64
      [NET]: Revert skb_copy_datagram_iovec() recursion elimination.

Dean Nelson:
      [IA64-SGI] enforce proper ordering of callouts by XPC

Dean Roe:
      [IA64-SGI] fix the size of __sn_cnodeid_to_nasid

Dmitry Torokhov:
      Input: trackpoint - enable devices connected to external port
      Input: ads7846 - convert to to dynamic input_dev allocation

Francois Romieu:
      sis190: early setting of the pci driver private data

Frank Pavlic:
      s390: lcs performance enhancements
      s390: some qeth driver fixes

Gerald Britton:
      x86: fix oprofile kernel callgraph regression

Harald Welte:
      [NETFILTER] Fix Kconfig menu level for x_tables

hawkes@sgi.com:
      [IA64] ia64: simplify and fix udelay()

Heiko Carstens:
      s390: fix __delay implementation
      s390: fix preempt_count of idle thread with cpu hotplug
      s390: additional_cpus parameter
      s390: possible_cpus parameter
      s390: smp initialization speed
      s390: sys32_fstatat -> sys32_fstatat64

Herbert Poetzl:
      [ARM] remove duplicate #includes

Herbert Xu:
      [IPSEC]: Fix strange IPsec freeze.

Horms:
      [IA64] support panic_on_oops sysctl

Hugh Dickins:
      compound page: use page[1].lru
      compound page: default destructor
      compound page: no access_process_vm check

Ingo Molnar:
      hrtimer: round up relative start time on low-res arches
      Introduce CONFIG_DEFAULT_MIGRATION_COST

Jack Steiner:
      [IA64] Missing check for TIF_WORK if trace/audit enabled

Jamal Hadi Salim:
      [NETLINK] genetlink: Fix bugs spotted by Andrew Morton.

James Bottomley:
      add scsi_execute_in_process_context() API
      [SCSI] fix wrong context bugs in SCSI
      fix x86 topology export in sysfs for subarchitectures

Jan Beulich:
      x86_64: make touch_nmi_watchdog() not touch impossible cpus' private data

Jay Vosburgh:
      bonding: fix a locking bug in bond_release

Jean Delvare:
      vt8231: Fix sysfs temperature interface
      w83781d: Use real-time status registers
      w83627hf: Document the reset module parameter
      it87: Fix oops on removal
      i2c: Drop outdated probe/remove code in i2c-isa

Jean Tourrilhes:
      Wavelan_cs bitfield fixes

Jeff Mahoney:
      reiserfs: fix potential (unlikely) oops in reiserfs_get_acl

Jens Axboe:
      [SCSI] gdth: don't map zero-length requests
      Add missing FUA write to sata_mv dma command list

Jes Sorensen:
      [IA64-SGI] sn2 minor fixes and cleanups
      [IA64] remove obsolete corporate address
      [IA64-SGI] remove compile time warning

Jim Keniston:
      kprobes: Update Documentation/kprobes.txt

Joe Perches:
      [IRDA]: Ratelimit messages.

Johannes Berg:
      allow windfarm_pm112 module to load

Joshua Giles:
      [SCSI] megaraid_sas: register 16 byte CDB capability

Joshua Kinard:
      Fix SGI O2 compile error in drivers/video/gbefb.c

Ju, Seokmann:
      [SCSI] megaraid_legacy: kobject_register failure

Karsten Keil:
      Fix NULL pointer dereference in isdn_tty_at_cout

Kurt Hackel:
      ocfs2: recheck recovery state after getting lock
      ocfs2: fix release of ast never reserved
      ocfs2: add dlm_wait_for_node_death
      ocfs2: manually grant remote recovery lock
      ocfs2: detach from heartbeat events before freeing mle

Kyle McMartin:
      [PARISC] Convert ccio-dma.c to use seq_file
      [PARISC] Convert sba_iommu.c to use seq_file
      [PARISC] Stub out pselect6/ppoll until TIF_RESTORE_SIGMASK is done
      sys_newfstatat -> sys_fstatat64

Linus Torvalds:
      Handle holes in node mask in node fallback list setup
      Linux v2.6.16-rc4

Maciej W. Rozycki:
      [MIPS] Fix CPU type bitmasks for MIPS III, IV and V.

Marcel Holtmann:
      [Bluetooth] Reduce L2CAP MTU for RFCOMM connections
      [Bluetooth] Fix NULL pointer dereferences of the HCI socket
      [Bluetooth] Fix firmware loading problem of BT3C driver

Marcel Selhorst:
      Infineon TPM: IO-port leakage fix, WTX-bugfix

Mark Fasheh:
      jbd: revert checkpoint list changes
      ocfs2: only checkpoint journal when asked to

Mark Haverkamp:
      [SCSI] aacraid: reduce device probe warnings
      [SCSI] aacraid: Update global function names
      [SCSI] aacraid: use no_uld_attach flag

Mark Maule:
      [IA64-SGI] export sn_pcidev_info_get

Martin Michlmayr:
      [ARM] 3337/1: Fix NSLU2 flash support according to window size configuration patch

Matthew Wilcox:
      [SCSI] sym2: Mask off opcode from RBC

Maxim Shchetynin:
      [SCSI] zfcp: fix logging during device reset

Meelis Roos:
      Input: logips2pp - add new signature (99)

Michael Hund:
      USB: add new device ids to ldusb
      USB: change ldusb's experimental state

Michael S. Tsirkin:
      IPoIB: Don't start send-only joins while multicast thread is stopped
      IPoIB: Fix another send-only join race
      madvise MADV_DONTFORK/MADV_DOFORK
      add asm-generic/mman.h

Mike Christie:
      [SCSI] iscsi update: cleanup iscsi class interface
      [SCSI] iscsi update: pass correct skb to skb_trim
      [SCSI] iscsi update: setup pool before using
      [SCSI] iscsi update: set deamon pid earlier
      [SCSI] iscsi update: rm conn lock
      [SCSI] iscsi update: set correct state at creation time
      [SCSI] iscsi update: fix mgmt pool err path release
      [SCSI] iscsi update: use gfp_t
      [SCSI] iscsi update: rm unused sessions list

Miklos Szeredi:
      fuse: fix bug in aborted fuse_release_end()

Moore, Eric:
      [SCSI] fusion - mptctl - MPTCOMMAND - adding function types.
      [SCSI] fusion - mptctl - adding support for bus_type=SAS
      [SCSI] fusion - mtctl - change to wait_event_timeout
      [SCSI] fusion - mptctl - Event Log Fix
      [SCSI] fusion - mptctl -sense width fix
      [SCSI] fusion - mptctl - backplane istwi fix
      [SCSI] fusion - mptctl -firmware download fix
      [SCSI] fusion - mptctl -adding asyn event notification support

NeilBrown:
      Fix over-zealous tag clearing in radix_tree_delete

Nicolas DICHTEL:
      [IPV6] Don't store dst_entry for RAW socket

Nicolas Pitre:
      [ARM] 3338/1: old ABI compat: sys_socketcall
      [ARM] 3339/1: ARM EABI: make unmuxed syscalls visible

Oleg Nesterov:
      fix kill_proc_info() vs CLONE_THREAD race
      fix kill_proc_info() vs fork() theoretical race
      fix zap_thread's ptrace related problems

Patrick McHardy:
      [NETFILTER]: Fix xfrm lookup after SNAT
      [XFRM]: Fix SNAT-related crash in xfrm4_output_finish
      [NETFILTER]: Don't invoke okfn in CONFIG_NETFILTER=n variant of nf_hook()

Paul Fulghum:
      tty reference count fix

Paul Jackson:
      cpuset: oops in exit on null cpuset fix

Paul Mackerras:
      Provide an interface for getting the current tick length

Peter Osterlund:
      pktcdvd: Don't spam the kernel log when nothing is wrong
      pktcdvd: Allow non-writable media to be mounted
      pktcdvd: Don't unlock the door if the disc is in use
      pktcdvd: Reduce stack usage

Peter Staubach:
      fix deadlock in ext2

Phil Dibowitz:
      USB: unusual-devs bugfix

Rafael J. Wysocki:
      swsusp: fix breakage with swap on LVM

Ralf Baechle:
      [MIPS] RM200: Give RM200 it's own timex.h.
      [MIPS] Update docs to reflect the latest status of the Alchemy IDE driver.
      [MIPS] Fold non-__mips64 case into CONFIG_32BIT case.
      [MIPS] Remove commented out function prom_build_cpu_map.
      [MIPS] More uaccess.h fixes with gcc >= 4.0.1.
      [MIPS] Get rid of kludgery needed to keep stdargs of old compilers working.
      [MIPS] MT: Fix c0 back-to-back hazard.
      [MIPS] MT: Propagate config7 into VPE.
      [SERIAL] Fix typo in comment

Ralph Campbell:
      IB/mad: Handle DR SMPs with a LID routed part

Roland Dreier:
      IB/mthca: Don't print debugging info until we have all values
      IPoIB: Yet another fix for send-only joins
      IB/mthca: bump driver version and release date

Roman Zippel:
      hrtimer: fix multiple macro argument expansion

Russell King:
      [ARM] Fix SMP initialisation oops
      [MMC] mmci: allow small data transfers

Stephen Hemminger:
      [BRIDGE]: Better fix for netfilter missing symbol has_bridge_parent
      sk98lin: no d-link support (kconfig)
      skge: no longer experimental
      skge: speed setting
      sky2: speed setting fix

Steve French:
      CIFS: fix cifs_user_read oops when null SMB response on forcedirectio mount

Sumant Patro:
      [SCSI] megaraid_sas: support for 1078 type controller added

Thomas Koeller:
      [MIPS] RM9000: Fix buggy I-cache workaround.

Thomas Meyer:
      x86: gitignore some autogenerated files for i386

Thomas Renninger:
      [CPUFREQ] Check for not initialized freq on cpufreq changes
      [CPUFREQ] Check whether driver init did not initialize current freq

Tim Hockin:
      Remove KERN_INFO from middle of printk line

Trond Myklebust:
      NLM: Fix the NLM_GRANTED callback checks

Yasuyuki Kozakai:
      [NETFILTER]: x_tables: fix dependencies of conntrack related modules
      [NETFILTER]: nf_conntrack: move registration of __nf_ct_attach
      [NETFILTER]: nf_conntrack: attach conntrack to TCP RST generated by ip6t_REJECT
      [NETFILTER]: nf_conntrack: attach conntrack to locally generated ICMPv6 error
      [NETFILTER]: nf_conntrack: Fix TCP/UDP HW checksum handling for IPv6 packet

Yoichi Yuasa:
      MIPS 32bit machines need fstatat64 support.

