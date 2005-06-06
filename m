Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261516AbVFFSNO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261516AbVFFSNO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Jun 2005 14:13:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261492AbVFFSNO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Jun 2005 14:13:14 -0400
Received: from fire.osdl.org ([65.172.181.4]:7608 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261516AbVFFSG3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Jun 2005 14:06:29 -0400
Date: Mon, 6 Jun 2005 11:08:25 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Linux v2.6.12-rc6
Message-ID: <Pine.LNX.4.58.0506061104190.1876@ppc970.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


It's being uploaded right now, the git tree is already up-to-date, and by 
the time this hits the mailing list the mirroring of the tar-ball will 
hopefully be done too.

And since Jeff wrote me a shortlog script for git, the easist way to tell
what's new since -rc5 is to just do the shortlog and diffstat output. 
Network drivers, USB and CPU-freq stand out.

And the good news is that people do seem to have taken my rumblings about 
calming down for 2.6.12 seriously. Let's hope that pans out, and I can 
release that one asap.. But give this a good beating first, and holler 
(again, if you must) about any issues you have,

		Linus

---
Adrian Bunk:
  USB: remove drivers/usb/media/pwc/ChangeLog
  drivers/net/hamradio/baycom_epp.c: cleanups
  [IPV6]: Kill export of fl6_sock_lookup.
  [IPVS]: remove net/ipv4/ipvs/ip_vs_proto_icmp.c
  arch/i386/kernel/cpu/intel_cacheinfo.c: section fix
  Input:
  SIS900 must select MII

Alan Cox:
  remove non-cleanroom pwc driver compression

Albert Lee:
  libata: Fix zero sg_dma_len() on 64-bit platform

Alexander Nyberg:
  acpi build fix: x86 setup.c
  Note on ACPI build fix
  Fixup VIA IRQ quirk
  x86_64: CONFIG_BUG=n fixes

Alexey Dobriyan:
  [TOKENRING]: net/802/tr.c: s/struct rif_cache_s/struct rif_cache/
  [TOKENRING]: be'ify trh_hdr, trllc, rif_cache_s

Andi Kleen:
  x86_64 CONFIG_ACPI=n build fix
  x86_64: More fixes for compilation without CONFIG_ACPI

Andrew Morton:
  Input: Fix a warning in psmouse-base.c

Andrew Vasquez:
  [SCSI] qla2xxx: fix bad locking during eh_abort

Andy Currid:
  PCI: amd74xx patch for new NVIDIA device IDs

Anton Blanchard:
  ppc64: remove decr_overclock
  ppc64: cleanup iseries runlight support
  ppc64: cleanup SPR definitions
  ppc64: allow timer based profiling on iseries

Bartlomiej Zolnierkiewicz:
  convert IDE device drivers to driver-model

Benjamin Herrenschmidt:
  ppc64: Fix result code handling in prom_init
  ppc32/ppc64: cleanup /proc/device-tree
  ppc32: Apple device-tree bug fix
  ppc64: Fix a device-tree bug on Apple's
  ppc32: Fix cpufreq vs. sleep issue
  ppc32: Fix Alsa PowerMac driver on old machines
  ppc32: small cpufreq update

Benjamin LaHaise:
  ns83820 update

Bodo Stroesser:
  s390: uml ptrace fixes

Christoph Hellwig:
  [NET]: Fix locking in shaper driver.
  [XFS] remove an over-zealous WARN_ON
  Merge with /.../torvalds/linux-2.6.git

Colin Leroy:
  therm_adt746x: show correct sensor locations
  Make sure therm_adt746x only handles known hardware

Craig Shelley:
  USB: CP2101 Add support for flow control

Dan Williams:
  wireless/airo: WEXT and quality corrections

Daniel Ritz:
  3c574_cs: disable interrupts in el3_close

Daniele Venzano:
  More ethtool support for sis900 and warning fix

Dave Jones:
  [CPUFREQ] Typos.
  [CPUFREQ] longhaul - adjust transition latency.
  [CPUFREQ] Longhaul: Magic timer frobbing.
  [CPUFREQ] longhaul - disable PCI mastering around transition.
  [CPUFREQ] ondemand governor default sampling downfactor as 1
  [CPUFREQ] ondemand governor automatic downscaling
  [CPUFREQ] ondemand,conservative governor idle_tick clean-up
  [CPUFREQ] ondemand,conservative governor store the idle ticks for all cpus
  [CPUFREQ] ondemand,conservative minor bug-fix and cleanup
  [CPUFREQ] Allow ondemand stepping to be changed by user.
  [CPUFREQ] Prevents un-necessary cpufreq changes if we are already at min/max
  [CPUFREQ] Add support to cpufreq_ondemand to ignore 'nice' cpu time
  [CPUFREQ] Conservative cpufreq governer
  [CPUFREQ] fix up comment in cpufreq.h
  [CPUFREQ] dual-core powernow-k8
  [CPUFREQ] make cpufreq_gov_dbs static
  [CPUFREQ] Recalibrate cpu_khz [2/2]
  [CPUFREQ] Recalibrate cpu_khz [1/2]
  [CPUFREQ] AMD Elan SC520 cpufreq driver.
  [CPUFREQ] Add warning comment about default governors.
  [CPUFREQ] speedstep-smi: it works on at least one P4M
  [CPUFREQ] ondemand: trivial clean-ups
  [CPUFREQ] speedstep-centrino: Pentium 4 - M (HT) support
  [CPUFREQ] cpufreq-core: reduce warning messages.
  [CPUFREQ] powernow-k7: don't print khz element of FSB.
  Fix up pwc driver compilation.

David Brownell:
  USB: resolve Zaurus problem
  USB: add sl811_cs support
  USB: sl811-hcd fixes

David Mosberger-Tang:
  [IA64] Correct convert_to_non_syscall()
  [IA64] Avoid .spillpsp directive in handcoded assembly
  [IA64] fix "section mismatch" compile-time-error
  [IA64] Fix stack placement when INIT hits in kernel mode.

David S. Miller:
  [SPARC64]: Refine PCI strbuf ctx-based flush.
  [SPARC64]: Fix streaming buffer flushing on PCI and SBUS.
  Merge of /home/davem/src/GIT/tg3-2.6/
  [NET]: Use %lx for netdev->features sysfs formatting.
  [IPV6]: Clear up user copy warning in flowlabel code.
  Merge of /home/davem/src/GIT/linux-2.6/.git/
  Merge of davem@nuts.davemloft.net:/disk1/GIT/sparc-2.6/.git/
  [SPARC64]: Add boot option to force UltraSPARC-III P-Cache on.

David Woodhouse:
  Speedtouch resync after lost signal.

Dmitry Torokhov:
  Input: synaptics - reduce verboseness of synaptics driver - there
  Input: yet another model that does not play nicely when i8042 is
  Input: automatically disable MUX mode on Toshiba Satellite P10
  Input: gunze - fix out-of-bound array access reported by Adrian Bunk.
  Input: Tone down the severity of a printk() in i386/ia64 arch code

Domen Puncer:
  drivers/scsi/ahci: add #include req'd for the DMA_{64,32}BIT_MASK constants
  drivers/scsi/sata_vsc: add #include req'd for DMA_32BIT_MASK constant

Don Fry:
  pcnet32: fix resource leak with loopback test

Edgar E Iglesias:
  [IPSEC]: Fix esp_decap_data size verification in esp4.

Edward Falk:
  libata: update inline source docs

Francisco Javier:
  sata_promise: add PCI ID for FastTrak TX2200 2-ports

Francois Romieu:
  r8169: incoming frame length check

Frank Pavlic:
  s390: qeth bug fixes
  s390: qeth bug fixes
  s390: fakell for high speed token ring
  s390: qeth bug fixes
  s390: enable iucv_send2way_xxx functions
  s390: ctc code cleanup
  s390: schedule_timeout cleanup in ctctty
  s390: set online race in the lcs driver
  s390: multicast address registration in lcs
  s390: claw driver wiring

Gerald Schaefer:
  s390: deadlock in appldata

Gerd Knorr:
  v4l: bttv i2c oops fix

Goffredo Baroncelli:
  UDF filesystem: array '__mon_yday' declared as not static

Greg Kroah-Hartman:
  USB: add Vernier devices to HID blacklist
  USB: fix usb-serial generic initialization

Greg Ungerer:
  m68knommu: fix scheduling and race problems in idle loop

Harald Welte:
  [NETFILTER]: Fix deadlock with ip_queue and tcp local input path.
  [IPV4]: Primary and secondary addresses

Herbert Xu:
  [IPV4]: Fix BUG() in 2.6.x, udp_poll(), fragments + CONFIG_HIGHMEM
  Fw: [Bugme-new] [Bug 4482] New: natsemi: incorrect initialization of IPv6 Neighbor-discovery multicast

Hideaki YOSHIFUJI:
  commit 2f872f0401d4b470990864fbf99c19130f25ad4d

Ian Abbott:
  USB: ftdi_sio: new PID for ELV UM100

James Harper:
  fix PROMISC/bridging in TLAN driver

Jan Beulich:
  [ATM]: fix ATM makefile for out-of-source-tree builds

Jan Kara:
  ext3: fix list scanning in __cleanup_transaction
  ext3: fix log_do_checkpoint() assertion failure

Jay Vosburgh:
  [BONDING]: bonding using arp_ip_target may stay down with active path 

Jeff Dike:
  uml: remove unused code
  uml: fix segfault on exit with CONFIG_GCOV
  uml: single-space a help message
  uml: remove 2_5compat.h
  uml: turn off kmalloc always on a fatal signal
  uml: fix a couple of warnings

Jeff Garzik:
  Automatic merge of /spare/repo/netdev-2.6 branch r8169-fix
  Automatic merge of /spare/repo/linux-2.6/.git branch HEAD
  libata: kernel-doc warning fixes
  libata: more docs updates
  libata: doc updates
  libata: more doc updates
  libata: minor DocBook update
  libata: bump version
  Automatic merge of /spare/repo/netdev-2.6 branch use-after-unmap
  libata: Fix use-after-iounmap
  Automatic merge of rsync://rsync.kernel.org/.../torvalds/linux-2.6.git branch HEAD
  Automatic merge of rsync://rsync.kernel.org/.../torvalds/linux-2.6.git branch HEAD
  Automatic merge of /spare/repo/netdev-2.6 branch tlan
  Automatic merge of /spare/repo/netdev-2.6 branch sis900
  Automatic merge of /spare/repo/netdev-2.6 branch veth
  Automatic merge of /spare/repo/netdev-2.6 branch qeth
  Automatic merge of /spare/repo/netdev-2.6 branch ns83820
  Automatic merge of /spare/repo/netdev-2.6 branch natsemi
  Automatic merge of /spare/repo/netdev-2.6 branch forcedeth
  Automatic merge of /spare/repo/netdev-2.6 branch airo
  Automatic merge of /spare/repo/netdev-2.6 branch atmel
  Automatic merge of /spare/repo/netdev-2.6 branch amd8111
  Automatic merge of /spare/repo/netdev-2.6 branch pcnet32
  Automatic merge of /spare/repo/netdev-2.6 branch ixgb
  Automatic merge of /spare/repo/netdev-2.6 branch e1000
  Automatic merge of /spare/repo/netdev-2.6 branch e100
  Merge of /spare/repo/netdev-2.6 branch misc-fixes

Jens Axboe:
  Relax idecd dma alignment check
  relax ide-cd dma restrictions

Jesper Juhl:
  [ATM]: [drivers] kill pointless NULL checks and casts before kfree()

Jesse Barnes:
  update sn2 maintainer

Jiri Benc:
  [NET]: Fix HH_DATA_OFF.

John Hawkes:
  drop note_interrupt() for per-CPU for proper scaling

John W. Linville:
  tulip: add return to ULI526X clause in tulip_mdio_write

Jon Mason:
  [NET]: Add ethtool support for NETIF_F_HW_CSUM.

Kenji Kaneshige:
  PCI Hotplug: SHPCHP driver doesn't enable PERR and SERR properly
  PCI Hotplug: shpchp driver doesn't program _HPP values properly

Kumar Gala:
  ppc32: i8259 PIC should not be initialized if PCI is not configured
  ppc32: Add soft reset to MPC834x
  ppc32: MPC834x BCSR_SIZE too small for use in a BAT.
  ppc32: Simplified load string emulation error checking
  ppc32: Fix building MPC8555 CDS when CONFIG_PCI is disabled
  ppc32: Add VIA IDE support to MPC8555 CDS platform
  ppc32: Fix some minor issues related to FSL Book-E KGDB support
  ppc32: Fix uImage make target to report success correctly

Kurt Garloff:
  Input: Avoid double unregistering of i8042 PnP driver. This can happen

Len Brown:
  ACPI build fix
  VIA IRQ quirk

Linus Torvalds:
  Linux 2.6.12-rc6
  Automatic merge of 'misc-fixes' branch from
  Automatic merge of rsync://www.parisc-linux.org/~jejb/git/scsi-for-linus-2.6
  Automatic merge of rsync://rsync.kernel.org/.../davem/net-2.6
  Merge of 'docs' branch from
  Merge of master.kernel.org:/.../aegl/linux-2.6
  Automatic merge of rsync://rsync.kernel.org/.../sfrench/cifs-2.6
  Automatic merge of rsync://rsync.kernel.org/.../davem/net-2.6
  Automatic merge of rsync://rsync.kernel.org/.../davem/sparc-2.6
  Automatic merge of rsync://rsync.kernel.org/.../gregkh/usb-2.6
  Automatic merge of rsync://rsync.kernel.org/.../gregkh/i2c-2.6
  Automatic merge of rsync://rsync.kernel.org/.../gregkh/pci-2.6
  Automatic merge of rsync://rsync.kernel.org/.../aegl/linux-2.6
  Merge of rsync://rsync.kernel.org/.../davem/tg3-2.6
  Automatic merge of 'misc-fixes' branch from
  Automatic merge of 'for-linus' branch from
  Automatic merge of rsync://rsync.kernel.org/.../hch/xfs-2.6
  ide-cd: revert DMA mask test change
  Automatic merge of rsync://rsync.kernel.org/.../davem/net-2.6
  Automatic merge of 'for-linus' branch from
  Merge of 'misc-fixes' branch from
  Merge of rsync://rsync.kernel.org/.../davem/sparc-2.6
  Merge of 'new-ids' branch from
  Merge of 'for-linus' branch from

Liu Tao:
  drivers/net/amd8111e.c: fix NAPI interrupt in poll

Lonnie Mendez:
  USB: hid-core: add Earthmate lt-20 productid to blacklist table

Malli Chilakala:
  e100: Driver version, white space, comments, device id
  e100: Performance optimizations to e100 Tx Path
  e100: Fix Wake on lan related issues
  e100: Synchronize interface link state with poll routine
  e100: Render e100 NAPI state machine
  e100: Execute tx_timeout task outside interrupt context
  ixgb: Driver version, white space, comments, device id
  ixgb: Fixed msec_delay in osdep to use msleep
  ixgb: Code optimization
  ixgb: Remove hook for suspend, no power management
  ixgb: Support for ethtool -d
  ixgb: Fix EEPROM functions to be endian-aware
  ixgb: Reset status in the Rx
  ixgb: Mask RXO interrupt
  ixgb: Change RDT write bump size to 4
  ixgb: Do not set the RS bit on context descriptors
  ixgb: Fix multi-cast packet count in statistics
  e1000:Driver version,white space,comments,device id
  e1000:Adjust flow control watermarks for Jumbo Frames
  e1000:Fix Packet Buffer Allocation logic for 82547_rev_2
  e1000:82573 specific code & packet split code
  e1000: Modified e1000_clean: exit poll
  e1000:Removed redundant statement in e1000_clean_tx_irq
  e1000: Implement a workaround for 82546 errata 10
  e1000: e1000 stops working after resume
  e1000:Fix computation of netdev stats from controller stats counters
  e1000: Dump information on Tx ring
  e1000: Delay clean-up of last Tx packet
  e1000: Fix kernel panic with 82541 LOM
  e1000: Enable polling before enabling interrupts
  e1000: MSI support for PCI-e adapters
  e1000: Fix msec-delay definition to use msleep
  e1000: made loopback test robust

Manfred Spraul:
  forcedeth: Update error handling

Manu Abraham:
  dvb: Small cleanup
  dvb: Fix 22k tone control
  dvb: Fix LNB power switching
  dvb: Remove unnecessary casts
  dvb: Fix Mini DiSEqC bug

Marcello Maggioni:
  timeout at boottime with NEC3500A (and possibly others) when inserted a CD in it

Martin Schwidefsky:
  s390: in_interrupt vs. in_atomic
  s390: ptrace peek and poke

Matthias Urlichs:
  USB: add Option Card driver

Michael Chan:
  [TG3]: Fix bug in tg3_load_firmware_cpu
  [TG3]: Add interrupt test
  [TG3]: Add loopback test
  [TG3]: Add memory test
  [TG3]: Add register test
  [TG3]: Add parameter to tg3_halt
  [TG3]: Add link test
  [TG3]: Add nvram test
  [TG3]: Add basic selftest infrastructure
  [BNX2]: New Broadcom gigabit network driver.

Michael Ellerman:
  [NET]: Add is_multicast_ether_addr() in include/linux/etherdevice.h
  iseries_veth: Cleanup skbs to prevent unregister_netdevice() hanging
  iseries_veth: Don't leak skbs in RX path
  iseries_veth: Set dev->trans_start so watchdog timer works right
  iseries_veth: Don't send packets to LPARs which aren't up

Michal Schmidt:
  forcedeth: netpoll support

NAKAMURA Kenta:
  sata_sil: new ID 1002:437A for ATI IXP400

Nathan Lynch:
  prom_find_machine_type typo breaks pSeries lpar boot
  [SCSI] fix slab corruption during ipr probe

Nathan Scott:
  [XFS] Fix directory inodes ioctl compat code, minor code consistency cleanups

Neil Horman:
  ipmi build fix

Nick Piggin:
  h8300 sleep problem

Oliver Korpilla:
  x86_64: signal.c build fix

Paolo 'Blaisorblade' Giarrusso:
  uml: remove jail mode + other leftovers
  uml: fixlet for arch_prctl_skas
  irq code: Add coherence test for PREEMPT_ACTIVE
  uml: fix PREEMPT_ACTIVE
  uml: stack dump fix
  uml: split CONFIG_FRAME_POINTER from DEBUG_INFO
  uml: add MOD_LICENSE to random driver
  uml: add modversions support

Patrick McManus:
  intelfb section fix

Paul Jackson:
  cpuset exit NULL dereference fix

Paul Mackerras:
  ppc64: actually call prom_send_capabilities

Paul Mundt:
  sh: PREEMPT_ACTIVE fix

Paulo Marques:
  USB: make MODALIAS code a bit smaller devices

Pavel Machek:
  fix jumpy mouse cursor on console

Pete Zaitcev:
  USB: Support multiply-LUN devices in ub

Peter Chubb:
  [IA64] fix compilation warning in sys32_epoll_wait()
  [IA64] Cleanup compile warnings for ski config
  pcdp.c build fix

Phil Dibowitz:
  USB Storage: Add unusual_devs for Trumpion Voice Recorder

Ping Cheng:
  USB: add new wacom device to usb hid-core list

Pravin B. Shelar:
  [IPV4]: Kill MULTIPATHHOLDROUTE flag.

Qu Fuping:
  mpage_end_io_write() I/O error handling fix

Roland Dreier:
  IB: fix endianness of path record MTU field
  IB: fix potential ib_umad leak
  IB: allow NULL sa_query callbacks

Roland McGrath:
  i386: fix prevent_tail_call

Roman Kagan:
  USB: update urb documentation

Roman Zippel:
  flush icache in correct context

Rudolf Marek:
  I2C: ALI1563 SMBus driver fix

Russ Anderson:
  [IS64-SGI] Set Altix error handling features
  [IA64-SGI] Make Altix SAL call to POD reentrant
  [IA64-SGI] cpe interrupts are not being enabled.

Russell Cattelan:
  [XFS] Fix a bug in xfs_iomap for extent handling of write cases

Scott Murray:
  PCI Hotplug: more CPCI updates

Shaohua Li:
  swsusp: ahd_dv_0 can't be stopped

Siddha, Suresh B:
  x86: fix smp_num_siblings on buggy BIOSes

Simon Kelley:
  atmel wireless

Stephen Hemminger:
  [BRIDGE]: receive path optimization
  [BRIDGE]: prevent bad forwarding table updates
  [BRIDGE]: set features based on enslaved devices
  [BRIDGE]: make dev->features unsigned
  [BRIDGE]: features change notification
  [PKT_SCHED] netem: allow random reordering (with fix)
  [PKT_SCHED] netem: use only inner qdisc -- no private skbuff queue
  [PKT_SCHED]: netem: reinsert for duplication
  tlan: restore deleted module parameters.

Stephen Rothwell:
  ppc64 iSeries: make virtual DVD-RAMs writable again
  ppc64 iSeries: fix boot time setting
  ppc64: fix initialisation of gettimeofday calculations

Steve French:
  Merge with rsync://rsync.kernel.org/.../torvalds/linux-2.6.git
  [CIFS] fix casts of unicode strings to match function definition
  [CIFS] Fix oops in cifs_unlink.  Caused in some cases when renaming over existing,
  [CIFS] missing break needed to handle < when mount option "mapchars" specified

Stuart Hayes:
  ide-scsi: kmap scatter/gather before doing PIO  

Thomas Graf:
  [PKT_SCHED]: Disable dsmark debugging messages by default
  [PKT_SCHED]: make dsmark try using pfifo instead of noop while grafting
  [PKT_SCHED]: Fix dsmark to count ignored indices while walking

Tony Luck:
  [IA64] Use "PER_CPU" form of EXPORT macro
  [IA64] initialize spinlock pfm_alt_install_check
  Sync with Linus - rsync://rsync.kernel.org/.../torvalds/linux-2.6.git
  [IA64] alternate perfmon handler
  Merge with linus
  Merge with /home/aegl/GIT/linus

Venkatesh Pallipadi:
  cpufreq-stats driver documentation
  cpufreq-stats driver updates

Vitaly Bordug:
  ppc32: Support for 82xx PQII on-chip PCI bridge

Vojtech Pavlik:
  Input: Fix fast scrolling scancodes in atkbd.c
  input: Fix fast scrolling scancodes in atkbd.c
  Input: Fix button mapping in joydev - BTN_TRIGGER was being
  Input: Workaround for Sunrex K8561 IR Keyboard/Mouse. The mouse
  Input: Only write the CTR in i8042 resume function. Reading it is
  Input: Remove (now) unused variable in i8042.c
  Input: Add a missing KERN_INFO message designation, fix behavior

Yoichi Yuasa:
  serial: update NEC VR4100 series serial support

Zhang Yanmin:
  [IA64] sys_mmap doesn't follow posix.1 when parameter len=0

 Documentation/DocBook/libata.tmpl                 |  156 -
 Documentation/cpu-freq/cpufreq-stats.txt          |  128 
 MAINTAINERS                                       |   10 
 Makefile                                          |    2 
 arch/h8300/kernel/process.c                       |    2 
 arch/i386/Kconfig                                 |    2 
 arch/i386/kernel/cpu/cpufreq/Kconfig              |   14 
 arch/i386/kernel/cpu/cpufreq/Makefile             |    1 
 arch/i386/kernel/cpu/cpufreq/longhaul.c           |   58 
 arch/i386/kernel/cpu/cpufreq/powernow-k7.c        |   11 
 arch/i386/kernel/cpu/cpufreq/powernow-k8.c        |  113 
 arch/i386/kernel/cpu/cpufreq/powernow-k8.h        |   15 
 arch/i386/kernel/cpu/cpufreq/sc520_freq.c         |  186 +
 arch/i386/kernel/cpu/cpufreq/speedstep-centrino.c |    6 
 arch/i386/kernel/cpu/cpufreq/speedstep-lib.c      |    6 
 arch/i386/kernel/cpu/cpufreq/speedstep-smi.c      |    3 
 arch/i386/kernel/cpu/intel_cacheinfo.c            |    2 
 arch/i386/kernel/setup.c                          |    2 
 arch/i386/kernel/smpboot.c                        |    4 
 arch/i386/kernel/timers/common.c                  |    6 
 arch/i386/kernel/timers/timer_tsc.c               |   20 
 arch/i386/pci/irq.c                               |    5 
 arch/ia64/ia32/sys_ia32.c                         |    2 
 arch/ia64/kernel/entry.S                          |    4 
 arch/ia64/kernel/mca.c                            |    8 
 arch/ia64/kernel/minstate.h                       |    3 
 arch/ia64/kernel/perfmon.c                        |  175 +
 arch/ia64/kernel/ptrace.c                         |   20 
 arch/ia64/kernel/smpboot.c                        |    2 
 arch/ia64/kernel/sys_ia64.c                       |    7 
 arch/ia64/sn/kernel/setup.c                       |    2 
 arch/m68knommu/kernel/process.c                   |   17 
 arch/ppc/Kconfig                                  |    4 
 arch/ppc/boot/images/Makefile                     |    3 
 arch/ppc/configs/mpc8555_cds_defconfig            |  117 
 arch/ppc/kernel/head_fsl_booke.S                  |   15 
 arch/ppc/kernel/traps.c                           |    7 
 arch/ppc/platforms/83xx/mpc834x_sys.c             |    1 
 arch/ppc/platforms/83xx/mpc834x_sys.h             |    7 
 arch/ppc/platforms/85xx/mpc8540_ads.c             |    3 
 arch/ppc/platforms/85xx/mpc85xx_cds_common.c      |  143 +
 arch/ppc/platforms/85xx/mpc85xx_cds_common.h      |    3 
 arch/ppc/platforms/85xx/sbc8560.c                 |    3 
 arch/ppc/platforms/pmac_cpufreq.c                 |   36 
 arch/ppc/platforms/pq2ads.h                       |   47 
 arch/ppc/syslib/Makefile                          |    4 
 arch/ppc/syslib/m8260_pci.c                       |  193 -
 arch/ppc/syslib/m8260_pci.h                       |   76 
 arch/ppc/syslib/m8260_pci_erratum9.c              |   10 
 arch/ppc/syslib/m8260_setup.c                     |   11 
 arch/ppc/syslib/m82xx_pci.c                       |  383 +
 arch/ppc/syslib/m82xx_pci.h                       |   92 
 arch/ppc/syslib/open_pic.c                        |    4 
 arch/ppc/syslib/ppc83xx_setup.c                   |   28 
 arch/ppc/syslib/ppc85xx_setup.c                   |   16 
 arch/ppc/syslib/prom_init.c                       |   10 
 arch/ppc64/kernel/entry.S                         |    9 
 arch/ppc64/kernel/head.S                          |   10 
 arch/ppc64/kernel/iSeries_setup.c                 |   22 
 arch/ppc64/kernel/idle.c                          |    8 
 arch/ppc64/kernel/mf.c                            |   85 
 arch/ppc64/kernel/pSeries_reconfig.c              |    8 
 arch/ppc64/kernel/process.c                       |    3 
 arch/ppc64/kernel/prom_init.c                     |  118 
 arch/ppc64/kernel/rtc.c                           |   39 
 arch/ppc64/kernel/setup.c                         |   56 
 arch/ppc64/kernel/smp.c                           |    3 
 arch/ppc64/kernel/sysfs.c                         |    8 
 arch/ppc64/kernel/time.c                          |    3 
 arch/s390/appldata/appldata_base.c                |   72 
 arch/s390/appldata/appldata_mem.c                 |    2 
 arch/s390/appldata/appldata_net_sum.c             |    2 
 arch/s390/appldata/appldata_os.c                  |    4 
 arch/s390/kernel/ptrace.c                         |   55 
 arch/s390/mm/fault.c                              |    2 
 arch/sparc64/kernel/pci_iommu.c                   |   88 
 arch/sparc64/kernel/pci_psycho.c                  |    2 
 arch/sparc64/kernel/pci_sabre.c                   |    2 
 arch/sparc64/kernel/pci_schizo.c                  |    2 
 arch/sparc64/kernel/sbus.c                        |   20 
 arch/sparc64/kernel/setup.c                       |   11 
 arch/sparc64/kernel/smp.c                         |    3 
 arch/sparc64/kernel/traps.c                       |   19 
 arch/um/Kconfig.debug                             |    4 
 arch/um/drivers/random.c                          |   16 
 arch/um/drivers/ssl.c                             |    1 
 arch/um/drivers/stdio_console.c                   |    1 
 arch/um/drivers/ubd_kern.c                        |    7 
 arch/um/include/2_5compat.h                       |   24 
 arch/um/include/sysrq.h                           |    3 
 arch/um/kernel/exec_kern.c                        |    1 
 arch/um/kernel/initrd_kern.c                      |   59 
 arch/um/kernel/initrd_user.c                      |   46 
 arch/um/kernel/main.c                             |   42 
 arch/um/kernel/process_kern.c                     |   36 
 arch/um/kernel/ptrace.c                           |   19 
 arch/um/kernel/sysrq.c                            |   21 
 arch/um/kernel/trap_kern.c                        |    1 
 arch/um/kernel/tt/process_kern.c                  |    8 
 arch/um/kernel/um_arch.c                          |    6 
 arch/um/sys-i386/sysrq.c                          |   80 
 arch/um/sys-ppc/sysrq.c                           |   14 
 arch/um/sys-x86_64/syscalls.c                     |   16 
 arch/um/sys-x86_64/sysrq.c                        |   11 
 arch/x86_64/Kconfig                               |    3 
 arch/x86_64/kernel/io_apic.c                      |    1 
 arch/x86_64/kernel/mpparse.c                      |    1 
 arch/x86_64/kernel/signal.c                       |    1 
 arch/x86_64/kernel/time.c                         |    2 
 arch/x86_64/kernel/traps.c                        |    2 
 arch/x86_64/kernel/x8664_ksyms.c                  |    3 
 drivers/acpi/Kconfig                              |    5 
 drivers/acpi/pci_irq.c                            |    4 
 drivers/atm/Makefile                              |    3 
 drivers/atm/fore200e.c                            |    6 
 drivers/atm/he.c                                  |    6 
 drivers/atm/nicstar.c                             |   20 
 drivers/atm/zatm.c                                |   11 
 drivers/block/ub.c                                |  598 +-
 drivers/cdrom/viocd.c                             |   14 
 drivers/char/ipmi/ipmi_devintf.c                  |    4 
 drivers/cpufreq/Kconfig                           |   24 
 drivers/cpufreq/Makefile                          |    1 
 drivers/cpufreq/cpufreq.c                         |    8 
 drivers/cpufreq/cpufreq_conservative.c            |  586 ++
 drivers/cpufreq/cpufreq_ondemand.c                |  180 -
 drivers/cpufreq/cpufreq_stats.c                   |   47 
 drivers/firmware/pcdp.c                           |    1 
 drivers/i2c/busses/i2c-ali1563.c                  |   46 
 drivers/ide/ide-cd.c                              |   52 
 drivers/ide/ide-disk.c                            |   41 
 drivers/ide/ide-floppy.c                          |   42 
 drivers/ide/ide-probe.c                           |   51 
 drivers/ide/ide-proc.c                            |   52 
 drivers/ide/ide-tape.c                            |   51 
 drivers/ide/ide.c                                 |  307 -
 drivers/ide/pci/amd74xx.c                         |    3 
 drivers/infiniband/core/sa_query.c                |   35 
 drivers/infiniband/core/user_mad.c                |    4 
 drivers/infiniband/include/ib_sa.h                |    4 
 drivers/input/gameport/Kconfig                    |   20 
 drivers/input/joydev.c                            |    2 
 drivers/input/keyboard/atkbd.c                    |    6 
 drivers/input/mouse/psmouse-base.c                |    7 
 drivers/input/mouse/synaptics.c                   |   39 
 drivers/input/mousedev.c                          |   15 
 drivers/input/serio/i8042-x86ia64io.h             |   32 
 drivers/input/serio/i8042.c                       |   50 
 drivers/input/touchscreen/gunze.c                 |    3 
 drivers/macintosh/therm_adt746x.c                 |  125 
 drivers/macintosh/via-pmu.c                       |    8 
 drivers/media/dvb/bt8xx/dst.c                     |  122 
 drivers/media/video/bttv-i2c.c                    |    3 
 drivers/net/Kconfig                               |   10 
 drivers/net/Makefile                              |    1 
 drivers/net/amd8111e.c                            |   24 
 drivers/net/bnx2.c                                | 5530 +++++++++++++++++++++
 drivers/net/bnx2.h                                | 4352 +++++++++++++++++
 drivers/net/bnx2_fw.h                             | 2468 +++++++++
 drivers/net/bonding/bond_main.c                   |    2 
 drivers/net/e100.c                                |  165 +
 drivers/net/e1000/e1000.h                         |   37 
 drivers/net/e1000/e1000_ethtool.c                 |  105 
 drivers/net/e1000/e1000_hw.c                      | 2147 ++++++--
 drivers/net/e1000/e1000_hw.h                      |  570 ++
 drivers/net/e1000/e1000_main.c                    | 1147 +++-
 drivers/net/e1000/e1000_osdep.h                   |   32 
 drivers/net/e1000/e1000_param.c                   |    3 
 drivers/net/forcedeth.c                           |  103 
 drivers/net/hamradio/baycom_epp.c                 |  126 
 drivers/net/iseries_veth.c                        |   32 
 drivers/net/ixgb/ixgb.h                           |    2 
 drivers/net/ixgb/ixgb_ee.c                        |   24 
 drivers/net/ixgb/ixgb_ethtool.c                   |    4 
 drivers/net/ixgb/ixgb_main.c                      |  153 -
 drivers/net/ixgb/ixgb_osdep.h                     |    3 
 drivers/net/natsemi.c                             |    6 
 drivers/net/ns83820.c                             |   69 
 drivers/net/pcmcia/3c574_cs.c                     |    3 
 drivers/net/pcnet32.c                             |    7 
 drivers/net/r8169.c                               |   31 
 drivers/net/shaper.c                              |   86 
 drivers/net/sis900.c                              |   52 
 drivers/net/tg3.c                                 |  571 ++
 drivers/net/tlan.c                                |   12 
 drivers/net/tulip/media.c                         |    1 
 drivers/net/wireless/airo.c                       |  150 -
 drivers/net/wireless/atmel_cs.c                   |    1 
 drivers/pci/hotplug/cpci_hotplug_core.c           |  302 +
 drivers/pci/hotplug/cpci_hotplug_pci.c            |  144 -
 drivers/pci/hotplug/shpchprm_acpi.c               |    4 
 drivers/pci/quirks.c                              |   40 
 drivers/s390/net/Makefile                         |    3 
 drivers/s390/net/ctcdbug.h                        |   12 
 drivers/s390/net/ctcmain.c                        |  616 +-
 drivers/s390/net/ctcmain.h                        |  276 +
 drivers/s390/net/ctctty.c                         |    5 
 drivers/s390/net/cu3088.c                         |    4 
 drivers/s390/net/cu3088.h                         |    3 
 drivers/s390/net/iucv.c                           |   10 
 drivers/s390/net/lcs.c                            |   33 
 drivers/s390/net/qeth.h                           |   35 
 drivers/s390/net/qeth_eddp.c                      |   51 
 drivers/s390/net/qeth_main.c                      |  316 +
 drivers/s390/net/qeth_tso.c                       |  285 -
 drivers/s390/net/qeth_tso.h                       |  168 +
 drivers/scsi/ahci.c                               |    3 
 drivers/scsi/aic7xxx/aic79xx_osm.c                |    2 
 drivers/scsi/ata_piix.c                           |   18 
 drivers/scsi/ide-scsi.c                           |   86 
 drivers/scsi/libata-core.c                        |  498 ++
 drivers/scsi/libata-scsi.c                        |    2 
 drivers/scsi/libata.h                             |    2 
 drivers/scsi/qla2xxx/qla_os.c                     |   24 
 drivers/scsi/sata_nv.c                            |    2 
 drivers/scsi/sata_promise.c                       |    3 
 drivers/scsi/sata_qstor.c                         |    2 
 drivers/scsi/sata_sil.c                           |    2 
 drivers/scsi/sata_sis.c                           |    1 
 drivers/scsi/sata_svw.c                           |    1 
 drivers/scsi/sata_sx4.c                           |    2 
 drivers/scsi/sata_uli.c                           |    1 
 drivers/scsi/sata_via.c                           |    1 
 drivers/scsi/sata_vsc.c                           |    2 
 drivers/scsi/scsi_scan.c                          |    1 
 drivers/serial/vr41xx_siu.c                       |   66 
 drivers/usb/atm/speedtch.c                        |    2 
 drivers/usb/core/sysfs.c                          |   22 
 drivers/usb/host/Kconfig                          |   11 
 drivers/usb/host/Makefile                         |    1 
 drivers/usb/host/sl811-hcd.c                      |  146 -
 drivers/usb/host/sl811_cs.c                       |  442 ++
 drivers/usb/input/hid-core.c                      |   18 
 drivers/usb/media/pwc/ChangeLog                   |  143 -
 drivers/usb/media/pwc/Makefile                    |    2 
 drivers/usb/media/pwc/pwc-ctrl.c                  |   14 
 drivers/usb/media/pwc/pwc-dec1.c                  |   42 
 drivers/usb/media/pwc/pwc-dec1.h                  |   36 
 drivers/usb/media/pwc/pwc-dec23.c                 |  623 --
 drivers/usb/media/pwc/pwc-dec23.h                 |   58 
 drivers/usb/media/pwc/pwc-if.c                    |    9 
 drivers/usb/media/pwc/pwc-kiara.c                 |  573 --
 drivers/usb/media/pwc/pwc-timon.c                 | 1130 ----
 drivers/usb/media/pwc/pwc-uncompress.c            |    4 
 drivers/usb/net/usbnet.c                          |    2 
 drivers/usb/serial/Kconfig                        |   11 
 drivers/usb/serial/Makefile                       |    1 
 drivers/usb/serial/cp2101.c                       |  363 +
 drivers/usb/serial/ftdi_sio.c                     |    3 
 drivers/usb/serial/ftdi_sio.h                     |    2 
 drivers/usb/serial/option.c                       |  729 +++
 drivers/usb/serial/usb-serial.c                   |   20 
 drivers/usb/storage/unusual_devs.h                |    9 
 drivers/video/intelfb/intelfbdrv.c                |   22 
 fs/cifs/README                                    |    4 
 fs/cifs/cifsproto.h                               |    2 
 fs/cifs/cifssmb.c                                 |   56 
 fs/cifs/dir.c                                     |    3 
 fs/cifs/inode.c                                   |   24 
 fs/cifs/misc.c                                    |    1 
 fs/hostfs/hostfs_kern.c                           |    1 
 fs/jbd/checkpoint.c                               |    5 
 fs/mpage.c                                        |    5 
 fs/proc/proc_devtree.c                            |  105 
 fs/udf/udftime.c                                  |    2 
 fs/xfs/linux-2.6/xfs_aops.c                       |    1 
 fs/xfs/linux-2.6/xfs_file.c                       |    7 
 fs/xfs/linux-2.6/xfs_ioctl32.c                    |   29 
 fs/xfs/linux-2.6/xfs_ioctl32.h                    |    6 
 fs/xfs/linux-2.6/xfs_super.c                      |    3 
 fs/xfs/xfs_iomap.c                                |    4 
 include/asm-i386/linkage.h                        |    4 
 include/asm-i386/timer.h                          |    1 
 include/asm-ia64/perfmon.h                        |    8 
 include/asm-ia64/sn/sn_sal.h                      |   28 
 include/asm-ppc/cpm2.h                            |   46 
 include/asm-ppc/m8260_pci.h                       |    1 
 include/asm-ppc/mpc8260.h                         |    2 
 include/asm-ppc64/iSeries/mf.h                    |    1 
 include/asm-ppc64/processor.h                     |  186 -
 include/asm-ppc64/prom.h                          |   13 
 include/asm-ppc64/thread_info.h                   |    4 
 include/asm-s390/user.h                           |    2 
 include/asm-sh/thread_info.h                      |    2 
 include/asm-sh64/thread_info.h                    |    2 
 include/asm-sparc64/iommu.h                       |    2 
 include/asm-sparc64/pbm.h                         |    8 
 include/asm-sparc64/spitfire.h                    |    3 
 include/asm-um/page.h                             |    8 
 include/asm-um/pgtable.h                          |    8 
 include/asm-um/thread_info.h                      |    9 
 include/asm-x86_64/bug.h                          |    2 
 include/linux/acpi.h                              |    5 
 include/linux/cpufreq.h                           |    2 
 include/linux/etherdevice.h                       |   22 
 include/linux/ethtool.h                           |    1 
 include/linux/gameport.h                          |   28 
 include/linux/hardirq.h                           |    6 
 include/linux/ide.h                               |   20 
 include/linux/if_shaper.h                         |    3 
 include/linux/if_tr.h                             |    6 
 include/linux/inetdevice.h                        |    2 
 include/linux/libata.h                            |   59 
 include/linux/mii.h                               |    8 
 include/linux/netdevice.h                         |    5 
 include/linux/notifier.h                          |    1 
 include/linux/pci_ids.h                           |    8 
 include/linux/pkt_sched.h                         |    9 
 include/linux/sysctl.h                            |    1 
 include/linux/usb.h                               |    6 
 include/net/route.h                               |    3 
 include/net/xfrm.h                                |    2 
 init/Kconfig                                      |    2 
 kernel/cpuset.c                                   |   24 
 kernel/irq/handle.c                               |    2 
 kernel/module.c                                   |    6 
 lib/Kconfig.debug                                 |    3 
 net/802/tr.c                                      |   26 
 net/bridge/br_device.c                            |   15 
 net/bridge/br_if.c                                |   23 
 net/bridge/br_input.c                             |    8 
 net/bridge/br_notify.c                            |    9 
 net/bridge/br_private.h                           |    1 
 net/bridge/br_stp_bpdu.c                          |    3 
 net/core/dev.c                                    |   12 
 net/core/ethtool.c                                |   20 
 net/core/net-sysfs.c                              |    3 
 net/ipv4/devinet.c                                |   34 
 net/ipv4/esp4.c                                   |    2 
 net/ipv4/ipvs/Makefile                            |    2 
 net/ipv4/ipvs/ip_vs_proto.c                       |    3 
 net/ipv4/ipvs/ip_vs_proto_icmp.c                  |  182 -
 net/ipv4/multipath_drr.c                          |   18 
 net/ipv4/multipath_rr.c                           |   20 
 net/ipv4/netfilter/ip_queue.c                     |   10 
 net/ipv4/udp.c                                    |   12 
 net/ipv6/ip6_flowlabel.c                          |   10 
 net/ipv6/ipv6_syms.c                              |    1 
 net/ipv6/xfrm6_policy.c                           |    4 
 net/sched/sch_dsmark.c                            |   16 
 net/sched/sch_netem.c                             |  211 -
 net/xfrm/xfrm_policy.c                            |    4 
 sound/oss/Kconfig                                 |   12 
 sound/ppc/pmac.c                                  |   30 
 344 files changed, 24709 insertions(+), 8238 deletions(-)
