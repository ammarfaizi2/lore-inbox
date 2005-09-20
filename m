Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964851AbVITDWk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964851AbVITDWk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Sep 2005 23:22:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964853AbVITDWk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Sep 2005 23:22:40 -0400
Received: from smtp.osdl.org ([65.172.181.4]:44763 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964851AbVITDWj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Sep 2005 23:22:39 -0400
Date: Mon, 19 Sep 2005 20:22:36 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Arrr! Linux v2.6.14-rc2
Message-ID: <Pine.LNX.4.58.0509192003410.2553@g5.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Ahoy landlubbers!

Here be t' Linux-2.6.14-rc2 release.

Not a whole lot o' excitement, ye scurvy dogs, but it has t' ALSA, LSM,
audit and watchdog merges that be missed from -rc1, and a merge series
with Andrew. But on t' whole pretty reasonable - you can see t' details in
the shortlog (appended).

Arrr!

		Linus

---
Abhay Salunke:
  dell_rbu: enhancements and fixes

Adam Kropelin:
  ibmphp: Use dword accessors for PCI_ROM_ADDRESS
  pciehp: Use dword accessors for PCI_ROM_ADDRESS
  shpchp: Use dword accessors for PCI_ROM_ADDRESS
  qla2xxx: Use dword accessors for PCI_ROM_ADDRESS

Adrian Bunk:
  SECURITY must depend on SYSFS

Al Viro:
  epca iomem annotations + several missing readw()

Alan Cox:
  ide: clean up the garbage in eighty_ninty_three

Alexander Nyberg:
  Fix fs/exec.c:788 (de_thread()) BUG_ON

Alexey Dobriyan:
  [8021Q]: Add endian annotations.

Alok Kataria:
  Fix slab BUG_ON() triggered by change in array cache size

Amy Griffis:
  AUDIT: Prevent duplicate syscall rules

Andi Kleen:
  Fix MPOL_F_VERIFY
  Make BUILD_BUG_ON fail at compile time.
  x86_64: Export end_pfn

Andrew Morton:
  [WATCHDOG] driver-for-ibm-automatic-server-restart-watchdog-fix
  i2c-keywest warning fix
  set_current_state() commentary
  schedule_timeout_[un]interruptible() speedup
  s2io warning fixes
  x86_64: e820.c needs module.h
  x86_64: desc.h-needs smp.h
  seclvl-use-securityfs tidy
  dell_rbu tidy
  joystick-vs-x.org fix

Andrey Panin:
  [WATCHDOG] driver-for-ibm-automatic-server-restart-watchdog.patch

Anton Altaparmakov:
  NTFS: Fix various bugs in the runlist merging code.  (Based on libntfs
  NTFS: Fix handling of compressed directories that I broke in earlier changeset.
  NTFS: Fix ntfs_{read,write}page() to cope with concurrent truncates better.

Anton Blanchard:
  hvc_console: start kernel thread before registering tty
  ppc64: build fix

Antonino A. Daplas:
  fbdev Kconfig fix
  nv_i2c oops fix
  savagefb: Fix load failure of the Twister chipset
  vgacon: Fix sanity checking in vgacon_resize
  vc: Use correct size on buffer copy in vc_resize

Arnaldo Carvalho de Melo:
  [DCCP]: Check if already in the CLOSING state in dccp_rcv_closereq
  [DCCP]: Handle SYNC packets in dccp_rcv_state_process
  [DCCP]: More precisely set reset_code when sending RESET packets
  [DCCP]: Introduce DCCP_SOCKOPT_SERVICE
  [DCCP]: Add MAINTAINERS and CREDITS entries
  [DCCP]: Move the ack vector code to net/dccp/ackvec.[ch]
  [CCID3]: Introduce include/linux/tfrc.h
  [DCCP]: Don't use necessarily the same CCID for tx and rx
  [DCCP]: Introduce CCID getsockopt for the CCIDs

Arnaud Patard:
  sata_sis: Fix typo in sata port2 initialisation

Arnaud Patard (Rtp):
  [WATCHDOG] s3c2410_wdt.c-state_warning.patch

Badari Pulavarty:
  AUDIT: Fix definition of audit_log_start() if audit not enabled

Bart De Schuymer:
  [BRIDGE-NF]: Fix iptables redirect on bridge interface

Cal Peake:
  Even more fallout from ATI Xpress timer workaround

Chris Mason:
  reiserfs: use mark_inode_dirty instead of reiserfs_update_sd

Chuck Ebbert:
  i386: Ignore masked FPU exceptions

Clemens Ladisch:
  [ALSA] ad1889: add AD1889 driver
  [ALSA] ad1889: add AD1889 driver docs
  [ALSA] hdsp: always initialize card name
  [ALSA] usb-audio: add SNDRV_PCM_INFO_BATCH flag
  [ALSA] sparse address space annotations
  [ALSA] opti93x: optimize a register access
  [ALSA] rtctimer: add option to make RTC timer the default sequencer timer
  [ALSA] set owner field in struct pci_driver

Con Kolivas:
  vm: kswapd cleanup: use pgdat

Dave Hansen:
  fix mm/Kconfig spelling

David Hardeman:
  [WATCHDOG] i6300esb.patch
  [WATCHDOG] i6300.h-removal-patch

David L Stevens:
  [IPV6]: Fix per-socket multicast filtering in sk_reuse case

David S. Miller:
  [NETLINK]: Reserve a slot for NETLINK_GENERIC.
  [COMPAT]: Fixup compat_do_execve()
  [LIB]: Consolidate _atomic_dec_and_lock()
  [NET]: Do not leak MSG_CMSG_COMPAT into userspace.
  [TG3]: Add AMD K8 to list of write-reorder chipsets.

David Woodhouse:
  AUDIT: Allow filtering of user messages
  AUDIT: Drop user-generated messages immediately while auditing disabled.
  AUDIT: Really exempt auditd from having its actions audited.
  AUDIT: Report lookup flags with path/inode records.
  AUDIT: Spawn kernel thread to list filter rules.
  AUDIT: Optimise the audit-disabled case for discarding user messages
  Add audit subsystem to MAINTAINERS, for my sins.
  AUDIT: Wait for backlog to clear when generating messages.
  AUDIT: Remove stray declaration of tsk from audit_receive_msg().
  AUDIT: No really, we don't want to audit auditd.
  AUDIT: Return correct result from audit_filter_rules()
  AUDIT: Clean up user message filtering
  AUDIT: Use KERN_NOTICE for printk of audit records
  AUDIT: Fix definition of audit_log() if audit not enabled
  AUDIT: Stop waiting for backlog after audit_panic() happens
  AUDIT: Really don't audit auditd.
  Fix positioning of audit in MAINTAINERS.
  AUDIT: Exempt the whole auditd thread-group from auditing
  AUDIT: Avoid scheduling in idle thread
  AUDIT: Fix compile error in audit_filter_syscall
  AUDIT: Fix livelock in audit_serial().
  AUDIT: Reduce contention in audit_serial()
  AUDIT: Fix task refcount leak in audit_filter_syscall()
  AUDIT: Speed up audit_filter_syscall() for the non-auditable case.
  Fix missing audit_syscall_exit() on ppc64 sigsuspend exit path
  [AUDIT] Allow filtering on system call success _or_ failure
  Fix build failure on ppc64 without CONFIG_AUDIT

Davide Libenzi:
  [ALSA] hda-codec - Bring the Vaio's RA826G HDA (82801) to life ...
  epoll: fix delayed initialization bug

Deepak Saxena:
  [ARM] 2917/1: Make IXP4xx mach_desc's depend on config options

Denis Lukianov:
  [MCAST]: Fix MCAST_EXCLUDE line dupes

Dipankar Sarma:
  Fix the fdtable freeing in the case of vmalloced fdset/arrays
  files: fix preemption issues

Domen Puncer:
  Remove arch/arm26/boot/compressed/hw-bse.c

Dominik Brodowski:
  pcmcia: warn on IOCTL usage

Florin Malita:
  [BOND]: Fix bond_init() error path handling.

Frank Pavlic:
  s390: ctc driver fixes
  s390: TSO related fixes in qeth driver
  s390: qeth driver fixes

George G. Davis:
  [ARM] 2896/1: Add sys_ipc_wrapper to pass 'fifth' argument on stack

Greg KH:
  add securityfs for all LSMs to use

H. Peter Anvin:
  RAID6 Altivec fix

Harald Welte:
  [NETFILTER]: Fix oops in conntrack event cache
  [NETFILTER] Fix Kconfig dependencies for nfnetlink/ctnetlink
  [NETFILTER] move nfnetlink options to right location in kconfig menu
  [NETFILTER]: Solve Kconfig dependency problem
  [NETFILTER]: Add new PPTP conntrack and NAT helper
  [NETFILTER]: Export ip_nat_port_{nfattr_to_range,range_to_nfattr}

Heiko Carstens:
  s390: bl_dev array size
  s390: show_cpuinfo fix

Herbert Xu:
  [TCP]: Compute in_sacked properly when we split up a TSO frame.
  [TCP]: Handle SACK'd packets properly in tcp_fragment().

Hidetoshi Seto:
  [IA64] mca_drv cleanup

Hugh Dickins:
  error path in setup_arg_pages() misses vm_unacct_memory()

Ian E. Morgan:
  [WATCHDOG] New SBC8360 watchdog driver (revised)

Ingo Molnar:
  Fix spinlock owner debugging

Ivan Kokshaysky:
  yenta oops fix
  Alpha: ISA IRQs fixup for dp264

James Chapman:
  [WATCHDOG] mv64x60_wdt.patch

James Courtier-Dutton:
  [ALSA] snd-ca0106: Tidy up volume controls
  [ALSA] snd-ca0106, snd-emu10k1: Add symlink in the sys tree.
  [ALSA] snd-emu10k1: ALSA bug#1297: Fix a error recognising the SB Live Platinum.

Jan Beulich:
  free initrd mem adjustment
  minor fbcon_scroll adjustment
  fbcon: constify font data
  matroxfb adjustments
  x86_64: NMI watchdog frequency calculation adjustments

Jaroslav Kysela:
  [ALSA] version 1.0.10rc1

Jay Vosburgh:
  bonding: plug reference count leak

Jean Delvare:
  i2c: kill an unused i2c_adapter struct member

Jeff Dike:
  uml: _switch_to code consolidation
  uml: breakpoint an arbitrary thread
  uml: Remove an unused file
  uml: Remove a useless include
  uml: Remove some build warnings
  uml: preserve errno in error paths
  uml: move libc code out of mem_user.c and tempfile.c
  uml: merge mem_user.c and mem.c
  uml: return a real error code
  uml: remove include of asm/elf.h
  uml: UML/i386 cmpxchg fix

Jeff Garzik:
  [libata] fix PIO completion race

Jens Axboe:
  fix pf request handling

Jens Osterkamp:
  net: fix spider_net media detection

Jimi Xenidis:
  ppc64: Fix recent regression

Jiri Slaby:
  [WATCHDOG] removes pci_find_device from i6300esb.c
  [WATCHDOG] i6300esb.c-2-bugs-little-cleanup.patch
  [ALSA] pci_find_device remove
  drivers/base/*: use kzalloc instead of kmalloc+memset

John W. Linville:
  e1000: correct rx_dropped counting
  e100: correct rx_dropped and add rx_missed_errors
  ixgb: correct rx_dropped counting
  pci: only call pci_restore_bars at boot

Jose Miguel Goncalves:
  [WATCHDOG] w83977f-watchdog-driver.patch

Julian Anastasov:
  [IPVS]: Really invalidate persistent templates
  [IPVS]: ip_vs_ftp breaks connections using persistence

Karsten Keil:
  i4l: Sedlbauer speed star II V 3.1 exist with various subversions
  Add PCI IDs for Sitecom DC-105
  cleanup whitespace in pci_ids.h
  Fix ST 5481 USB driver

Keith Owens:
  Correct xircom_cb use of CONFIG_NET_POLL_CONTROLLER
  [IA64] Add Documentation/ia64/mca.txt

Komuro:
  pcmcia: add another orinoco_cs id

KOVACS Krisztian:
  [NETFILTER] CLUSTERIP: introduce reference counting for entries
  [NETFILTER] CLUSTERIP: use a bitmap to store node responsibility data

Krzysztof Halasa:
  [WAN] hdlc_cisco: Fix regression introduced by skb->tail changes.

Kumar Gala:
  ppc32: remove use of asm/segment.h

Lennert Buytenhek:
  [ARM] 2911/1: ixp2000_reg_{read,write} accessors
  [ARM] 2909/1: remove IXP2000_PROD_ID
  [ARM] 2904/1: update ixp2000 defconfigs to 2.6.13
  [ARM] 2905/1: enable the ixp2000 i2c bus driver in ixp2000 defconfigs

Linus Torvalds:
  Fix up more strange byte writes to the PCI_ROM_ADDRESS config word
  Fix yenta error message when unable to find a bus assignment
  Partially revert "Fix time going twice as fast problem on ATI Xpress chipsets"
  x86-64/smp: fix random SIGSEGV issues
  Make fsnotify possibly work better for the inode removal case
  Linux v2.6.14-rc2

Marcel Holtmann:
  [Bluetooth] Add support for extended inquiry responses
  [Bluetooth] Prevent RFCOMM connections through the RAW socket
  [Bluetooth] Add ignore parameters to the HCI USB driver

Marcelo Tosatti:
  relayfs documentation typo

Mark J Cox:
  raw_sendmsg DoS on 2.6

Martin Habets:
  [ALSA] Several fixes for the Sun DBRI driver

Martin Schwidefsky:
  s390: default configuration
  s390: crypto driver patch take 2

matthieu castet:
  airo : fix channel number in scan

Mauro Carvalho Chehab:
  v4l: experimental Sliced VBI API support
  v4l: fixup on cx88_dvb for Dvico HDTV5 Gold

Michael Chan:
  [TG3]: Fix 4GB boundary tx handling

Michael Kerrisk:
  PR_GET_DUMPABLE returns incorrect info

Michal Piotrowski:
  dontdiff: add asm_offsets

Mike Miller:
  cciss: new controller pci/subsystem ids
  cciss: busy_initializing flag
  cciss: new disk register/deregister routines
  cciss: direct lookup for command completions
  cciss: bug fix in cciss_remove_one
  cciss: fix for DMA brokeness
  cciss: One Button Disaster Recovery support
  cciss: SCSI tape info for /proc

Mitsuru KANDA:
  [IPV6]: Check connect(2) status for IPv6 UDP socket (Re: xfrm_lookup)

Naveen Gupta:
  [WATCHDOG] i6300esb.c-WDT_ENABLE-bug
  [WATCHDOG] i6300esb-set_correct_reload_register_bit
  [WATCHDOG] i6300esb.c-pci_dev_put+nowayout-patch

Neil Brown:
  nfsd4: printk reduction
  nfsd4: move replay_owner
  nfsd4: fix open seqid incrementing in lock
  nfsd4: fix setclientid unlock of unlocked state lock
  Code cleanups in calbacks in svcsock

Nicolas Pitre:
  [ARM] 2910/1: missing Lubbock audio device declaration

OGAWA Hirofumi:
  FAT: miss-sync issues on sync mount (miss-sync on write)

Pantelis Antoniou:
  ppc32 8xx: flush_tlb_range() declaration uses wrong pointer type

Patrick McHardy:
  [NETFILTER]: Use correct type for "ports" module parameter
  [NETFILTER]: Simplify netbios helper
  [NETFILTER]: Fix rcu race in ipt_REDIRECT
  [NETFILTER]: Fix DHCP + MASQUERADE problem
  [NETFILTER]: Rename misnamed function

Paul Mackerras:
  ppc64: Make eeh_init function again

Pavel Machek:
  Tell people not to use pm_register()

Pekka J Enberg:
  CodingStyle: memory allocation

Peter Chubb:
  [IA64] Remove warnings for gcc 4.0 IA64 compilation.

Peter Hagervall:
  [TG3]: Sparse fixes for tg3

Peter Oberparleiter:
  s390: kernel stack corruption

Peter Osterlund:
  Remove unnecessary check_region references in comments
  pktcdvd: fix bogus BUG_ON
  pktcdvd: documentation update
  pktcdvd: more accurate I/O accounting
  pktcdvd: use kcalloc and kzalloc
  pktcdvd: BUG_ON cleanups

Peter Staubach:
  open returns ENFILE but creates file anyway

Randy Dunlap:
  use add_taint() for setting tainted bit flags
  Doc: update oops-tracing.txt (Tainted flags)
  feature removal of io_remap_page_range()

Richard Purdie:
  SharpSL: Abstract c7x0 specifics from Corgi SSP
  SharpSL: Add cxx00 support to the Corgi LCD driver
  SharpSL: Abstract c7x0 specifics from Corgi Touchscreen driver
  SharpSL: Abstract model specifics from Corgi Backlight driver
  SharpSL: Add new ARM PXA machines Spitz and Borzoi with partial Akita Support
  SharpSL: Add an input keyboard driver for Zaurus cxx00 series
  [ARM] 2915/1: SA1100 Collie: Correct scoop device calls
  [ARM] 2912/1: PXA Corgi: Cleanup some unneeded code
  [ARM] 2913/1: PXA Poodle: Cleanup some unneeded code
  [ARM] 2914/1: PXA Poodle: Add MMC and UDC support
  SharpSL: Add missing hunk from backlight update
  MTD: Update SharpSL partition definitions
  Fix up some pm_message_t types

Robert Love:
  hdaps driver update

Robert Olsson:
  [IPV4]: fib_trie tnode stats refinements
  [IPV4]: fib_trie RCU refinements

Roland Dreier:
  add PCI IDs so RME32 and RME96 drivers build

Russell King:
  [ARM SMP] Add timer/watchdog defines for MPCore
  [I2C] Add a functionality method, and remove algorithm ids
  [ARM SMP] Add timer/watchdog defines for MPCore
  [ARM] Remove PFN_TO_NID for !DISCONTIGMEM
  [ARM] Tighten pfn_valid() test.
  [ARM] Fix warning in asm/futex.h
  [ARM] Fix warning in arch/arm/kernel/semaphore.c
  [ARM] Fix warning in arch/arm/mach-sa1100/generic.c

Serge Hallyn:
  seclvl: use securityfs (fix)

serue@us.ibm.com:
  seclvl securityfs

Srivatsa Vaddagiri:
  CPU hotplug breaks wake_up_new_task

Stephen Hemminger:
  sk98lin: remove PCI id info for cards for conflicting devices
  skge: gmac register access errors in dual port
  8139cp: allocate statistics space only when needed

Takashi Iwai:
  [ALSA] Fix EAPD for MSI S270
  [ALSA] atiixp - Fix PM resume
  [ALSA] intel8x0 - Add quirk for IBM NetVisa A30p
  [ALSA] Fix ALC658D support
  [ALSA] Add snd_card_set_dev()
  [ALSA] hda-intel - Check validity of DMA position
  [ALSA] Update/fix ALSA document
  [ALSA] Introduce snd_card_set_generic_dev()
  [ALSA] Add snd_card_set_generic_dev() call
  [ALSA] Add snd_card_set_generic_dev() call to ISA drivers
  [ALSA] hda-codec - Assign audio PCMS first
  [ALSA] Fix DocBook warnings
  [ALSA] Remove superfluous PCI ID definitions
  [ALSA] hda-intel - Fix modem PCM creation
  [ALSA] powermac - Add AUTO_DRC config
  [ALSA] pcm-oss - Add bugg-yptr option
  [ALSA] intel8x0 - Add buggy_semaphore option
  [ALSA] hda-codec - Added ASUS A6
  [ALSA] Replace with kzalloc() - core stuff
  [ALSA] Replace with kzalloc() - seq stuff
  [ALSA] Replace with kzalloc() - isa stuff
  [ALSA] Replace with kzalloc() - pci stuff
  [ALSA] Replace with kzalloc() - others
  [ALSA] Another fix for DocBook
  [ALSA] Add missing sound PCI IDs to pci_ids.h

Thomas Maguin:
  scsi_ioctl: Add WRITE_LONG_2 as write safe command

Timothy Thelin:
  ide: fix null request pointer for taskfile ioctl

Tobias Klauser:
  arch/i386: Replace custom macro with isdigit()
  drivers/video: Replace custom macro with isdigit()

Tom Rini:
  ppc32: discard *.exit.text and *.exit.data sections

Tony Luck:
  [IA64] fix circular dependency on generation of asm-offsets.h

Uwe Koziolek:
  sata_sis: uninitialized variable

Victor Fusco:
  [AUDIT] Fix sparse warning about gfp_mask type

Vincent Pelletier:
  [ALSA] Correct detection of iBook G4 1420Mhz soundcard

Vincent Sanders:
  [ARM] 2907/1: GCC 4 serial driver compile fixes

Vitaly Bordug:
  ppc32: Add ppc_sys descriptions for PowerQUICC I devices

Vivek Goyal:
  More documentation, minor cleanup in kdump.txt

Volker Sameske:
  s390: diag 0x308 reipl

Wim Van Sebroeck:
  [WATCHDOG] Kconfig+Makefile-clean2
  [WATCHDOG] driver-for-ibm-automatic-server-restart-watchdog-fix2.patch
  [WATCHDOG] sbc8360+w83977f_wdt-consolidate_CONFIG_WATCHDOG_NOWAYOUT_handling
  [WATCHDOG] pcwd_pci-include+WDIOC_SETOPTIONS-patch

Yasuyuki Kozakai:
  [NETFILTER] ip6tables: remove duplicate code

Zach Brown:
  Add smp_mb__after_clear_bit() to unlock_kiocb()
