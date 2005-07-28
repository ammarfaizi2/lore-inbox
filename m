Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262107AbVG1Xel@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262107AbVG1Xel (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Jul 2005 19:34:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262077AbVG1Xel
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Jul 2005 19:34:41 -0400
Received: from smtp.osdl.org ([65.172.181.4]:6091 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262125AbVG1Xee (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Jul 2005 19:34:34 -0400
Date: Thu, 28 Jul 2005 16:34:29 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Linux 2.6.13-rc4
Message-ID: <Pine.LNX.4.58.0507281625270.3307@g5.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hey everybody,

 as many of you are aware, we were talking (not enough) about the release
process at LKS this year. 

This ain't it.

This is just the regular old release "process", with some LKS backlog put 
in for good measure. 

But the good news is, that I'll try the new release process after 2.6.13
is out, which is hopefully not too far away. Which means that we should
try to let people know about the fact that if they want to merge stuff,
they should do so in the first two weeks after the 2.6.13 release, and no
later (also, no earlier either, by now).

So if you have a favourite kernel developer, please wake him up with a
friendly kick to the head and explain this concept to him in small
easy-to-understand words, and tell him that we're in the freeze process
for 2.6.13 now, and that he should be gathering up the patches, and make
sure they get to me _after_ 2.6.13 is out, but at that point do it in a
timely manner.

Ok?

In the meantime, here's the 2.6.13-rc4 update, with a diffstat so horribly
ugly that I won't even show it (the kernel list would eat it as too big
anyway), and I'll have to go fix my code that generates it.

Oh, and in case you wonder, it's ugly because a cris architecture update
with long filenames that really causes git-apply to output som rather
nasty-looking diffstats ;)

ALSA, IB, NTFS, SCSI (qla2xxx) and the cris architecture update.

			Linus

----
Adrian Bunk:
  VIDEO_SAA7134 must depend on SOUND
  drivers/media/video/tveeprom.c: possible cleanups
  Documentation/Changes: document the required udev version
  m32r: add missing Kconfig help text
  i386: add missing Kconfig help text
  drivers/pnp/pnpbios/rsparser.c: fix compile error with PCI=n
  [NETFILTER]: Fix ip_conntrack_put() prototype.
  [SPARC]: Remvoe APM_RTC_IS_GMT from config.
  [NET]: NETCONSOLE must depend on INET
  [NET]: BRIDGE_EBT_ARPREPLY must depend on INET
  [IPV4]: fix IP_FIB_HASH kconfig warning

Alan Stern:
  scsi_scan: check return code from scsi_sysfs_add_sdev

Alexander Schulz:
  ARM: 2816/1: Shark: boot kernel images bigger than 1 MB
  ARM: 2815/1: Shark: new defconfig, fixes with __io and serial ports

Alexey Dobriyan:
  drm: via: fix sparse warnings
  Really __nocast-annotate kmalloc_node()
  visws: reexport pm_power_off

Andi Kleen:
  Undo mempolicy shared policy rbtree microoptimization
  x86_64: fix SMP boot lockup on some machines

Andreas Gruenbacher:
  reiserfs doesn't use mbcache
  mbcache: Remove unused mb_cache_shrink parameter

Andreas Steinmetz:
  Fix RLIMIT_RTPRIO breakage

Andrew Morton:
  bio_clone fix
  Avoid device suspend on reboot
  ppc64: tpm_infineon build fix
  ppc64: genrtc build fix
  statically link halfmd4
  check_user_page_readable() deadlock fix
  user_mode_vm() build fix
  x86_64 fsnotify build fix
  softdog build fix
  eurotechwdt build fix
  qla2xxx: Kconfig dependency fix
  qla: remove anonymous union
  inotify: fix oops fix
  [SCSI] dpt_i2o warning fix
  [SCSI] aic79xx: ahd_linux_dev_reset() cleanup

Andrew Vasquez:
  More qla2xxx configuration fixes
  [SCSI] qla2xxx: Cleanup FC remote port registration.
  [SCSI] qla2xxx: Consolidate ISP24xx chip reset logic.
  [SCSI] qla2xxx: Add firmware version number to qla24xx_fw_version_str().
  [SCSI] qla2xxx: Update version number to 8.01.00b5-k.
  [SCSI] qla2xxx: Correct maximum supported lun and target-id definitions.
  [SCSI] qla2xxx: Update copyright banner.
  [SCSI] qla2xxx: Firmware updates.
  [SCSI] qla2xxx: Code scrubbing.
  [SCSI] qla2xxx: NVRAM id-list updates.
  [SCSI] qla2xxx: Add OS initialization codes for ISP24xx recognition.
  [SCSI] qla2xxx: Add ISP24xx initialization routines.
  [SCSI] qla2xxx: Add ISP24xx ISR routines.
  [SCSI] qla2xxx: Add ISP24xx IOCB manipulation routines.
  [SCSI] qla2xxx: Add ISP24xx flash-manipulation routines.
  [SCSI] qla2xxx: Add MBX command routines for ISP24xx support.
  [SCSI] qla2xxx: Generalize SNS generic-services routines.
  [SCSI] qla2xxx: Add ISP24xx diagnostic routines.
  [SCSI] qla2xxx: Add ISP24xx definitions.
  [SCSI] qla2xxx: Add pci ids for new ISP types.
  [SCSI] qla2xxx: Factor-out ISP specific functions to method-based call tables.

Andrey Panin:
  consolidate CONFIG_WATCHDOG_NOWAYOUT handling
  Serial: Add support for SIIG Quartet serial card

Andy Whitcroft:
  Remove bogus warning in page_alloc.c

Anton Altaparmakov:
  Automatic merge with /usr/src/ntfs-2.6.git.
  Fix soft lockup due to NTFS: VFS part and explanation
  Automatic merge with /usr/src/ntfs-2.6.git.
  Automerge with /usr/src/ntfs-2.6.git.
  Automatic merge with /usr/src/ntfs-2.6.git.
  NTFS: Fix a nasty deadlock that appeared in recent kernels.
  NTFS: Prepare for 2.1.23 release: Update documentation and bump version.
  NTFS: Change ntfs_map_runlist_nolock() to only decompress the mapping pairs
  NTFS: Add an extra parameter @last_vcn to ntfs_get_size_for_mapping_pairs()
  NTFS: Change the runlist terminator of the newly allocated cluster(s) to
  NTFS: Fix several occurences of a bug where we would perform 'var & ~const'
  NTFS: Detect the case when Windows has been suspended to disk on the volume
  NTFS: Fix a bug in address space operations error recovery code paths where
  NTFS: Stamp the transaction log ($UsnJrnl), aka user space journal, if it
  Automerge with /usr/src/ntfs-2.6.git.
  Automatic merge with /usr/src/ntfs-2.6.git.
  Automatic merge with /usr/src/ntfs-2.6.git
  Automatic merge with /usr/src/ntfs-2.6.git.
  NTFS: Use C99 style structure initialization after memory allocation where
  Merge with /usr/src/ntfs-2.6.git.
  Merge with /usr/src/ntfs-2.6.git
  Merge with /usr/src/ntfs-2.6.git
  Merge with /usr/src/ntfs-2.6.git
  NTFS: Use MAX_BUF_PER_PAGE instead of variable sized array allocation for
  NTFS: Minor cleanup: Define and use NTFS_MAX_CLUSTER_SIZE constant instead
  NTFS: Update attribute definition handling.
  NTFS: Some utilities modify the boot sector but do not update the checksum.
  NTFS: Fix compilation when configured read-only.
  NTFS: Include linux/swap.h in fs/ntfs/attrib.c for mark_page_accessed().
  NTFS: - Modify ->readpage and ->writepage (fs/ntfs/aops.c) so they detect
  NTFS: Fix sign of various error return values to be negative in
  NTFS: Add fs/ntfs/attrib.[hc]::ntfs_attr_make_non_resident().
  NTFS: - Fix bug in fs/ntfs/attrib.c::ntfs_find_vcn_nolock() where after
  NTFS: Add fs/ntfs/attrib.[hc]::ntfs_attr_vcn_to_lcn_nolock() used by the new
  NTFS: Add AT_EA in addition to AT_DATA to whitelist for being allowed to be
  NTFS: Correct sparse file handling.  The compressed values need to be
  NTFS: Make fs/ntfs/namei.c::ntfs_get_{parent,dentry} static and move the
  NTFS: - Set the ntfs_inode->allocated_size to the real allocated size in the
  NTFS: Fix a nasty runlist merge bug when merging two holes.
  NTFS: Change time to u64 in time.h::ntfs2utc() as it otherwise generates a
  NTFS: - Split ntfs_map_runlist() into ntfs_map_runlist() and a non-locking
  NTFS: Fix a bug in fs/ntfs/runlist.c::ntfs_mapping_pairs_decompress() in
  NTFS: - Add disable_sparse mount option together with a per volume sparse
  NTFS: Optimise/reorganise some error handling code in fs/ntfs/aops.c.
  NTFS: Fixup the resident attribute resizing code in
  NTFS: Fix stupid bug in fs/ntfs/mft.c introduced in last changeset.
  NTFS: Repeat a failed ntfs_truncate() in fs/ntfs/aops.c::ntfs_writepage()
  NTFS: Use i_size_{read,write}() in fs/ntfs/{aops.c,mft.c} and protect
  NTFS: Use i_size_read() in fs/ntfs/inode.c once and then use the cached value
  NTFS: - Use i_size_read() in fs/ntfs/super.c once and then use the cached
  NTFS: In fs/ntfs/dir.c, use i_size_read() once and then the cached value
  NTFS: - In fs/ntfs/compress.c, use i_size_read() at the start and then use the
  Merge with /usr/src/ntfs-2.6.git
  Merge with /usr/src/ntfs-2.6.git
  NTFS: Use i_size_read() in fs/ntfs/file.c::ntfs_file_open().
  NTFS: Use i_size_read() once and then use the cached value in
  NTFS: Use i_size_read() in fs/ntfs/logfile.c::ntfs_{check,empty}_logfile().
  NTFS: Use i_size_read() in fs/ntfs/attrib.c::ntfs_attr_set().

Anton Wöllert:
  ppc32: 8xx avoid icbi misbehaviour in __flush_dcache_icache_phys

Artem B. Bityuckiy:
  [JFFS2] Init locks early during mount
  [JFFS2] Rename function and update comments
  [JFFS2] Remove needless variable initialization
  [JFFS2] Avoid alloc/dealloc for zero sized nodes

Ben Dooks:
  ARM: 2831/1: S3C2440 - split s3c2440 clocks from central clock code
  ARM: 2829/1: S3C2410 - split s3c2440 irq specifics from core irq.c
  ARM: 2828/1: BAST - remove static map of ASIX area
  ARM: 2818/1: BAST - Use platform device for SuperIO 16550s

Bjorn Helgaas:
  PCDP: if PCDP contains parity information, use it

Brian Gerst:
  Fix warning in powernow-k8.c

Cal Peake:
  [IPV6]: fix implicit declaration of function `xfrm6_tunnel_unregister'

Carsten Otte:
  fix xip sparse file handling in ext2
  execute-in-place fixes

Chas Williams:
  [ATM]: allow bind() on point-to-multpoint svcs (from Martin Whitaker <martin_whitaker@ntlworld.com>)
  [ATM]: [zatm] eliminate kfree warning (from Tobias Hirning <sskyman@web.de>)

Chen, Kenneth W:
  [SCSI] Redundant this_count check in sd_init_command()
  [SCSI] Redundant memset in scsi_alloc_sgtable

Christian Borntraeger:
  s390: use __cpcmd in vmcp_write

Christoph Hellwig:
  [SCSI] aic7xxx: remove ahc_tailq
  [SCSI] aic7xxx: sane pci probing
  [SCSI] ifdef out broken fc4 EH code
  [SCSI] use list_for_each_entry_safe in scsi_error.c
  [SCSI] remove scsi_eh_eflags_ macros
  [SCSI] remove scsi_cmnd->state
  [SCSI] remove scsi_cmnd->owner
  [SCSI] remove scsi_cmnd->abort_reason
  [SCSI] remove scsi_cmnd.eh_state
  [SCSI] remove scsi_set_device

Christoph Lameter:
  [IA64] Altix pcibus_to_node implementation
  [IA64] pcibus_to_node implementation for IA64

Christophe Lucas:
  [SCTP]: Audit return code of create_proc_*

Chuck Ebbert:
  i386: clean up user_mode macros

Clemens Ladisch:
  [ALSA] usb-audio - change quirk type handling
  [ALSA] usb-audio - add support for Miditech USB MIDI keyboards
  [ALSA] seq-midi - silently ignore non-MIDI events
  [ALSA] ac97 - remove unused variable
  [ALSA] usb-audio - use bDeviceSubClass to detect MOTU FastLane
  [ALSA] usb-audio - rename QUIRK_MIDI_MOTU to QUIRK_MIDI_RAW
  [ALSA] usb-audio - enable high speed transfers with Audiy 2 NX
  [ALSA] usb-audio: add support for an unknown Yamaha USB MIDI device
  [ALSA] usb-audio - fix capture of non-48k sample rates on Audigy 2 NX
  [ALSA] usb-audio - high speed audio support

Cornelia Huck:
  s390: resource accessibility event handling
  s390: debug data for ifcc/ccc

Daniel Ritz:
  pcmcia: disable read prefetch/write burst on old O2Micro bridges
  yenta: free_irq() on suspend.

Dave Kleikamp:
  JFS: Fix i_blocks accounting when allocation fails
  JFS: Don't set log_SYNCBARRIER when log->active == 0
  JFS: Fix typo in last patch
  Merge with /home/shaggy/git/linus-clean/
  JFS: Remove assert statement in dbJoin & return -EIO instead
  JFS: Remove bogus WARN_ON statement and some dead code
  JFS: Allow security.* xattrs to be set on symlinks
  Merge with /home/shaggy/git/linus-clean/
  JFS: Code cleanup - getting rid of never-used debug code

David Gibson:
  ppc64: remove another fixed address constraint
  ppc64: dynamically allocate segment tables
  ppc64: kill bitfields in ppc64 hash code

David Mosberger-Tang:
  [IA64] Make PCDP work again.

David Ranson:
  serial: MRi MRI-PCIDS1 dual port serial card

David S. Miller:
  [SPARC64]: Fix ugly dependency on NR_CPUS being a power-of-2.
  [SPARC]: Add inotify syscall entries.
  [ATM]: speedtch: Revert 86cf42e4e029b83110cf98692420239103363dbf
  [TG3]: Update driver version and reldate.
  [SPARC64]: Move syscall success and newchild state out of thread flags.
  [SPARC64]: Privatize sun5_timer.
  [SPARC64]: Kill totally unused inline functions from asm/spitfire.h
  [SPARC64]: Simplify asm/rwsem.h slightly.
  [SPARC64]: Non-atomic bitops do not need volatile operations
  [SPARC]: Fix __KERNEL_SYSCALLS__ defining in envctrl.c and bbc_envctrl.c
  [W1]: Do not use NFLOG netlink number.
  [PKT_SCHED]: em_meta: Kill TCF_META_ID_{INDEV,SECURITY,TCVERDICT}
  [PKT_SCHED]: Kill TCF_META_ID_REALDEV from meta ematch.
  [NET]: Fix tc_verd thinko in skb_clone()
  [EMATCH]: Kill TCF_META_ID_TCCLASSID reference from meta ematch as well.

Dean Nelson:
  [IA64] fix call of smp_processor_id() by XPC while

Dimitry Andric:
  ARM: 2819/1: Fix several S3C24x0 IIS defines

Dominik Brodowski:
  pcmcia: fix sharing IRQs and request_irq without IRQ_HANDLE_PRESENT
  pcmcia: update documentation
  pcmcia: avoid duble iounmap of one address
  pcmcia: update au1000 to work with recent changes
  Add pcibios_bus_to_resource for parisc

Dominik Hackl:
  uml: update module interface

Downing, Thomas:
  ppc32: fix compilation error with CONFIG_PQ2FADS

Duncan Sands:
  [ATM]: [speedtch] cure atm_printk() macro gcc-2.95 compile error

Eric W. Biederman:
  acpi: Don't call acpi_sleep_prepare from acpi_power_off
  acpi_power_off: Don't switch to the boot cpu
  x86_64 sync machine_power_off with i386
  APM: Remove redundant call to set_cpus_allowed
  i386 machine_power_off cleanup
  machine_shutdown: Typo fix to actually allow specifying which cpu to reboot on
  pcwd.c: Call kernel_power_off not machine_power_off
  swpsuspend: Have suspend to disk use factors of sys_reboot
  68328serial: sysrq should use emergency_reboot
  In hangcheck-timer.c call emergency_restart()
  Fix watchdog drivers to call emergency_reboot()
  Update sysrq-B to use emergency_restart()
  Call emergency_reboot from panic
  Use kernel_power_off in sysrq-o
  x86_64: Implemenent machine_emergency_restart
  x86_64: Fix reboot_force
  i386: Implement machine_emergency_reboot
  Don't export machine_restart, machine_halt, or machine_power_off.
  Fix the arguments to machine_restart on cris
  Add emergency_restart()
  Make ctrl_alt_del call kernel_restart to get a proper reboot.
  Refactor sys_reboot into reusable parts
  Add missing device_suspsend(PMSG_FREEZE) calls.

Eugene Surovegin:
  ppc32: fix 440SP MAL channels count

Francois Romieu:
  [ATM]: zatm: mailbox converted to pci_alloc_consistent()

Geert Uytterhoeven:
  Amiga joystick: Fix typo introduced by the open/close race fixes

George Anzinger:
  itimer fixes

Giancarlo Formicuccia:
  Fix incorrect Asus k7m irq router detection

Gleb Natapov:
  [IB/uverbs]: Add O_ASYNC support

Greg Edwards:
  [IA64] remove CONFIG_IA64_SGI_SN_SIM

Gregory B Frost:
  DVICO Fusion DVB-T1 Tuner (LG-Z201) fix

Guillaume Autran:
  ppc32: fix destroy_context() race condition

Hal Rosenstock:
  [IB/ucm]: Clean up userspace CM
  IB: Add core locking documentation to Infiniband
  IB: Eliminate sparse warnings in SA client
  IB: Hook up userspace CM to the make system
  IB: Add kernel portion of user CM implementation
  IB: Add the header file for user space CM
  IB: Implementation for RMPP support in user MAD
  IB: User MAD ABI changes to support RMPP
  IB: Add the kernel CM implementation
  IB: Add the header file for kernel CM (Communications Manager)
  IB: Add Service Record support to SA client
  IB: Add RMPP implementation
  IB: Introduce RMPP APIs
  IB: A couple of IB core bug fixes
  IB: Add ib_create_ah_from_wc to IB verbs
  IB: Fix a couple of MAD code paths
  IB: Optimize canceling a MAD
  IB: Add ib_modify_mad API to MAD
  IB: Eliminate MAD cache leak associated with local completions
  IB: Simplify calling of list_del in MAD
  IB: Add automatic retries to MAD layer
  IB: Add ib_coalesce_recv_mad to MAD
  IB: Minor cleanup during MAD startup and shutdown
  IB: Fix timeout/cancelled MAD handling
  IB: Change ib_mad_send_wr_private struct
  IB: Change saving of user's send wr_id in MAD
  IB: Combine some MAD routines
  IB: Add MAD helper functions
  IB: Update MAD client API
  IB: Update FMR functions

Hans-Juergen Tappe (SYSGO AG):
  [IPV4]: Fix Kconfig syntax error

Harald Welte:
  [ALSA] Add new pci device id (SB400) to atiixp-modem

Heiko Carstens:
  s390: cpu timer reset in machine check handler
  s390: 31 bit memory size limit
  s390: external call performance
  s390: atomic64 inline functions

Henrik Kretzschmar:
  [ALSA] typo-fix and snd_assert()-expression-split
  [ALSA] fix compiler warning
  [ALSA] cleanup and typo-correction
  [ALSA] Fix two typos and changes on snd_assert()

Herbert Xu:
  [XFRM]: Fix possible overflow of sock->sk_policy
  [CRYPTO]: Fix zero-extension bug on 64-bit architectures.

Horst Hummel:
  s390: free dasd slab cache
  s390: fba dasd i/o errors

Ian Campbell:
  cs89x0: collect tx_bytes statistics

Ian Dall:
  JFS: Need to be root to create files with security context

Ian Kent:
  autofs4: fix infamous "Busy inodes after umount ..." message

Ian Wienand:
  [IA64] Fix undefined reference to can_cpei_retarget for simulator

James Bottomley:
  [SCSI] fix function prototype warning
  fix voyager subarchitecture EXPORT_SYMBOL breakage caused by i386_ksym reduction
  [SCSI] SPI transport class, don't negotiate options not supported
  [SCSI] add TYPE_RBC to our type table
  [SCSI] aic7xxx: fix boot hang with Fujitsu drives
  [SCSI] aic7xxx: correct target valid check in aic7xxx_proc.c
  [SCSI] 	megaraid: fix compilation after eh locking changes

James Courtier-Dutton:
  [ALSA] ac97: Fix volume control bit size detection for STAC9704.
  [ALSA] emu10k1: Add EMU 1212m card entry and document it as not supported yet.
  [ALSA] snd-emu10k1: Fixes recognition of Audigy ES.
  [ALSA] emu10k1: Add module option uint subsystem.
  [ALSA] emu10k1: Added tested status comments.
  [ALSA] emu10k1: Sort by card id.
  [ALSA] snd-emu10k1: Tidy mixer controls.
  [ALSA] snd-emu10k1: Card capabilities tidy up.

James Morris:
  SELinux: default labeling of MLS field

James.Smart@Emulex.Com:
  [SCSI] add int_to_scsilun() function
  [SCSI] lpfc: Change version to 8.0.29.
  [SCSI] lpfc: Update copyright notices
  [SCSI] lpfc: Remove $Id$ keyword strings.
  [SCSI] lpfc: Fix ADISC completion incorrectly putting initiators on mapped list
  [SCSI] lpfc: Add completion handler to the abort iocbs
  [SCSI] lpfc: Fix LS_RJT never sent by lpfc_els_unsol_event()
  [SCSI] lpfc: Add LP6000 PCI ID
  [SCSI] lpfc: Set max_sectors in host template
  [SCSI] lpfc: Fix error loading on sparc
  [SCSI] lpfc: Fixes in mbox_timeout_handler
  [SCSI] Fix issue where all hosts log nodev message for other initiators
  [SCSI] lpfc: hgp/pgp cleanups

Jan Kara:
  ext3: drop quota references before releasing inode
  ext2: drop quota reference before releasing inode

Jar:
  pcmcia: remove duplicates in orinoco_cs

Jaroslav Kysela:
  [ALSA] version 1.0.9b
  [ALSA] ens1371 - added extra delay for ac97 codec initialization
  [ALSA] via82xx - changed MSI K7T266 Pro2 - 4005:4710 in white list (SRC enable)
  [ALSA] via82xx - added MSI K7T266 Pro2 - 4005:4710 to white list (DXS enable)
  [ALSA] ak4114: removed duplicate wake_up()

Jeff Dike:
  uml: fix misdeclared function

Jeff Mahoney:
  reiserfs: fix deadlock in inode creation failure path w/ default ACL
  Lindent: ignore .indent.pro

Jens Axboe:
  as-iosched tunable encoding fix

Jesper Juhl:
  Update CREDITS entry and listings in source files for Jesper Juhl
  clean up inline static vs static inline
  [ATM]: Trivial spelling fix patch for net/Kconfig
  NTFS: Remove checks for NULL before calling kfree() since kfree() does the

Joachim Nilsson:
  fix gconfig crash

Joern Engel:
  [MTD] cfi_cmdset_0002: Plugged a mem leak.

Jon Smirl:
  fbdev: colormap fixes
  radeonfb: clean up EDID sysfs attribute
  fbmem: use unregister_chrdev() on unload
  fbmon: horizontal frequency rounding fix

Keith Owens:
  [IA64] unwind.c uses wrong unat from switch_stack

Komuro:
  pcmcia: fix many device IDs

Kumar Gala:
  ppc32: Fix building of TQM8260 board
  ppc32: Fix building of radstone_ppc7d
  ppc32: Fix building of prpmc750
  ppc32: Fix typo in setup of 2nd PCI bus on 85xx
  ppc32: Make the UARTs on MPC824x individual platform devices
  ppc32: Add proper prototype for cpm2_reset()
  I2C-MPC: Restore code removed

Kurt Wall:
  Add text for dealing with "dot releases" to README

Kyle Moffett:
  [NET]: Fix setsockopt locking bug

Linda Xie:
  [SCSI] IBM VSCSI Client: sending client info to server

Linus Torvalds:
  Linux 2.6.13-rc4
  Revert broken "statement with no effect" warning fix
  Merge master.kernel.org:/.../perex/alsa
  Merge master.kernel.org:/.../davem/sparc-2.6
  Fix up qla2xxx configuration bogosity
  Merge head 'for-linus' of master.kernel.org:/.../shaggy/jfs-2.6
  Merge master.kernel.org:/.../davem/net-2.6
  Merge master.kernel.org:/.../aegl/linux-2.6
  Merge master.kernel.org:/home/rmk/linux-2.6-arm-smp
  Merge master.kernel.org:/.../davem/net-2.6
  Merge master.kernel.org:/home/rmk/linux-2.6-arm
  Merge master.kernel.org:/home/rmk/linux-2.6-arm-smp
  Fix compiler warning in qla_iocb.c
  Merge master.kernel.org:/.../jejb/scsi-for-linus-2.6
  Merge master.kernel.org:/.../davem/net-2.6
  Merge master.kernel.org:/.../davem/sparc-2.6
  Merge master.kernel.org:/home/rmk/linux-2.6-serial
  Merge master.kernel.org:/home/rmk/linux-2.6-arm
  Remove "noreplacement" kernel command line option.
  x86: use alternative instructions for fnsave/fxsave too
  Merge master.kernel.org:/.../davem/net-2.6
  x86: make restore_fpu() use alternative assembler instructions
  Fix up incorrect "unlikely()" on %gs reload in x86 __switch_to
  Merge master.kernel.org:/home/rmk/linux-2.6-serial
  Merge master.kernel.org:/home/rmk/linux-2.6-arm
  Merge master.kernel.org:/.../aia21/ntfs-2.6
  Merge master.kernel.org:/.../tglx/mtd-2.6
  Merge master.kernel.org:/.../aegl/linux-2.6
  Merge master.kernel.org:/.../aegl/linux-2.6
  Merge master.kernel.org:/.../tglx/mtd-2.6
  Merge head 'for-linus' of master.kernel.org:/.../shaggy/jfs-2.6
  Merge /home/torvalds/linux-2.6-arm

Loic Le Loarer:
  [EQL]: Proper num_slaves decrement

Lucas Correia Villa Real:
  ARM: 2825/1: S3C2410: turns %d into %ld on DMA printk

Luming Yu:
  /home/lenb/linux-2.6 branch 'acpi-2.6.12'
  ACPI: delete unnecessary EC console messages

Marcel Selhorst:
  tpm: Support for Infineon TPM

Marcelo Feitoza Parisi:
  [ATM]: [idt77252] use time_after() macro
  [NET PCMCIA]: drivers/net/pcmcia/smc91c92_cs.c : Use of time_after macro
  [WAN]: drivers/net/wan/: use of time_after macro

Marcelo Tosatti:
  ppc32: 8xx remove BROKEN Kconfig entry
  cpm_uart: use DPRAM for early console
  ppc32: 8xx: update DataTLBMiss exception comment

Mark Haverkamp:
  [SCSI] aacraid: Fix sgmap error
  [SCSI] aacraid: New products patch

Martin Schwidefsky:
  s390: find_next_{zero}_bit fixes
  s390: spin lock retry
  s390: fadvise hint values.

Matt:
  [ALSA] hda: add sigmatel hp detect support
  [ALSA] hda: enable unsolicited responses
  [ALSA] hda-codec - SigmaTel HDA resume support
  [ALSA] hda-codec - SigmaTel HDA multichannel support

Matt Mackall:
  [NET]: Move in_aton from net/ipv4/utils.c to net/core/utils.c

Matt Porter:
  ppc32: fix dma_map_page() to use page_to_bus()

Matthias Urlichs:
  Option Card driver update, Maintainer entry

Mauro Carvalho Chehab:
  v4l: bug fixes for tuner, cx88 and tea5767

Michael Burian:
  ARM: 2794/1: Add "Image" and "mach-types.h" to dontdiff list

Michael Chan:
  [TG3]: add 5780 fiber support
  [TG3]: disallow jumbo TSO on 5780
  [TG3]: consolidate all DMA water mark settings
  [TG3]: add variable buffer size for standard ring
  [TG3]: add 5780 basic jumbo frame support
  [TG3]: add 5780 basic support

Michael Gernoth:
  ARM: 2830/1: Fix Jornada 720 PCMCIA-support

Michael Hunold:
  v4l: fix tuning with MXB driver

Michael Krufky:
  dvb: rename lgdt3302 frontend module to lgdt330x
  v4l: hybrid dvb: rename CFLAGS from CONFIG_DVB_xxxx back to original HAVE_xxxx
  v4l: hybrid dvb: move #defines to Makefile
  v4l: hybrid dvb: fix warnings with -Wundef
  dvb/v4l: cx88 cleanup
  lgdt3302: warning fix
  dvb/4vl: RF input selection fir
  dvb/v4l: lgdt3302: isolate tuner
  v4l: fix regression modprobe bttv freezes the computer
  dvb: LGDT3302 QAM lock bug fix

Michael S. Tsirkin:
  [IB/mthca]: Use io_remap_pfn_range for PCI space

Michal Januszewski:
  fbdev: update info->cmap when setting cmap from user-/kernelspace.
  fbcon: don't repaint the cursor when it is disabled.

Michal Ostrowski:
  rocket.c: Fix ldisc ref count handling

Mikael Starvik:
  CRIS IDE driver
  CRIS update: new subarchitecture v32
  CRIS update: updates for 2.6.12
  CRIS update: synchronous serial port driver
  CRIS update: SMP
  CRIS update: profiler
  CRIS update: pci
  CRIS update: mm
  CRIS update: misc patches
  CRIS update: IRQ
  CRIS update: I/O and DMA allocator
  CRIS update: drivers
  CRIS update: debug
  CRIS update: console
  CRIS update: configuration and build
  CRIS update: arch split

Mike Miller:
  cciss per disk queue

Miles Bader:
  v850: Define L1_CACHE_SHIFT and L1_CACHE_SHIFT_MAX
  v850: Update PCI support
  v850: Add pte_file
  v850: Update ioremap return type and add ioread/iowrite functions
  v850: Add defconfigs
  v850: const-qualify first parameter of find_next_zero_bit
  v850: Define pfn_valid
  v850: Align ___start___param to match parameter alignment

Moore, Eric Dean:
  [SCSI] - mptfusion - convert to new change_queue_depth API

Neil Brown:
  Fix raid0's attempt to divide by 64bit numbers

NeilBrown:
  md: when resizing an array, we need to update resync_max_sectors as well as size
  md/raid1: clear bitmap when fullsync completes

Nick Sillik:
  [NETFILTER]: Fix -Wunder error in ip_conntrack_core.c

Nicolas Graziano:
  [ALSA] hda driver, correct bug in model 'auto'

Nigel Cunningham:
  Address BUG: using smp_processor_id() in preemptible [00000001] code
  Fix missing refrigerator invocation in jffs2
  Add missing tvaudio try_to_freeze()
  try_to_freeze() call fixes

Nishanth Aravamudan:
  [ALSA] Fix-up sleeping in sound/usb
  [ALSA] Fix-up sleeping in sound/ppc
  [ALSA] sound/pci: fix-up sleeping paths
  [SPARC]: sbus/vfc_i2c: remove sleep_on() usage
  [SPARC]: sbus/envctrl: replace schedule_timeout() with msleep_interruptible()
  [SPARC]: sbus/aurora: replace schedule_timeout() with msleep_interruptible()
  vt.c build fix
  [SCSI] scsi/qla1280: replace schedule_timeout() with ssleep()

Olaf Hering:
  turn many #if $undefined_string into #ifdef $undefined_string
  make a few functions static in pmac_setup.c
  ppc64: hide CONFIG_ADB
  ppc64: update defconfigs
  ppc32: update defconfigs
  ppc/ppc64: use Kconfig.hz
  uml: add dependency to arch/um/Makefile for parallel builds
  uml: readd missing define to arch/um/Makefile-i386
  [ATM]: [he] remove linux/version.h include
  Serial: Remove linux/version.h
  ratelimit the ieee1394 IR legacy activated messages
  ppc32: make -j12 all fails in uImage target
  ARM: remove linux/version.h include from arch/arm

Olivier Blin:
  i4l: add Olitec ISDN PCI card in hisax gazel driver

Olof Johansson:
  ppc64: add 970MP PVR

Paolo 'Blaisorblade' Giarrusso:
  sys_get_thread_area does not clear the returned argument
  uml: add skas0 command-line option
  remove EXPORT_SYMBOL for root_dev
  uml: hostfs: unuse ROOT_DEV
  uml: allow building as 32-bit binary on 64bit host
  uml: reintroduce pcap support
  uml: fix hppfs error path
  uml: gcc 2.95 fix and Makefile cleanup
  uml: consolidate modify_ldt
  uml: workaround host bug in "TT mode vs. NPTL link fix"
  uml: fix lvalue for gcc4

Patrick Boettcher:
  dvb: cx88 output mode fix

Patrick McHardy:
  [EMATCH]: Remove feature ifdefs in meta ematch.
  [NETFILTER]: Fix ip6t_LOG MAC format
  [NETFILTER]: Use correct byteorder in ICMP NAT
  [NETFILTER]: Wait until all references to ip_conntrack_untracked are dropped on unload
  [NETFILTER]: Fix potential memory corruption in NAT code (aka memory NAT)
  [NETFILTER]: Fix deadlock in ip6_queue
  [NET]: Make ipip/ip6_tunnel independant of XFRM
  [IPV4]: Don't select XFRM for ip_gre
  [NET]: Only build flow.o if CONFIG_XFRM=y
  [PKT_SCHED]: Kill TCF_META_ID_TCCLASSID.

Pavel Roskin:
  pcmcia: fix comment
  pcmcia: ide-cs id_table update

Pekka Enberg:
  NTFS: Remove spurious void pointer casts from fs/ntfs/.

Pete Zaitcev:
  ub: fix for blank CDs

Peter Staubach:
  stale POSIX lock handling

Qu Fuping:
  JFS: fsync wrong behavior when I/O failure occurs

Ralf Baechle:
  serial_core whitespace fix

Randy Dunlap:
  kernel/crash_dump.c: add kerneldoc
  kernel/cpuset.c: add kerneldoc, fix typos
  kernel/capability.c: add kerneldoc
  [NET]: Improve presentation of networking driver families.
  [NET]: Kconfig: NETCONSOLE and NETPOLL together
  NTFS: Fix printk format warnings on ia64. (Randy Dunlap)

Richard Henderson:
  alpha: fix "statement with no effect" warnings
  new alpha syscalls

Robert Love:
  [IA64] inotify: ia64 syscalls.
  inotify: add x86-64 syscall entries
  inotify: add missing hook to sys32_open
  inotify: check retval in init
  inotify: change default limits
  inotify: exit path cleanups
  inotify: oops fix
  inotify: use fget_light
  inotify: misc. cleanup
  inotify: MAINTAINERS
  inotify: documentation update
  inotify: misc cleanup
  inotify: event ordering
  inotify: move sysctl

Roland Dreier:
  Merge /scratch/Ksrc/linux-git/
  [IB/ipoib]: Fix unsigned comparisons to handle wraparound
  [IB/mthca]: Fix error CQ entry handling on mem-free HCAs

Rolf Eike Beer:
  watchdog: add missing 0x in alim1535_wdt.c

Russell King:
  [ARM SMP] Fix data corruption in test_* bitops
  ARM SMP: Mark device mappings as "device" in ARMv6 parlance
  ARM SMP: Add ARMv6 memory barriers
  ARM SMP: Use exclusive load/store for __xchg
  ARM SMP: Fix ARMv6 spinlock and semaphore implementations
  Serial: No need to check for priv != NULL in remove_one
  ARM SMP: Mark mroe CPU init data with __cpuinitdata
  ARM SMP: Mark CPU init functions/data with __cpuinit/...data
  ARM: Remove global nwfpe register variable
  ARM: Allow register_undef_hook to be called with IRQs off
  ARM: Convert bitops to use ARMv6 ldrex/strex instructions
  Serial: Move deprecation of register_serial forward to September
  ARM SMP: Initialise cpu_present_map
  ARM SMP: We list IRQs for present CPUs, not online CPUs
  ARM SMP: Rename cpu_present_mask to cpu_possible_map

Rusty Russell:
  [NETFILTER]: ip_conntrack_expect_related must not free expectation

Sascha Hauer:
  ARM: 2687/1: i.MX framebuffer: make dmacr register platform configurable

Sergey Ulanov:
  [ALSA] Jack Sense support for AD1980 and AD1888

Siddha, Suresh B:
  x86_64: TASK_SIZE fixes for compatibility mode processes

Sonny Rao:
  JFS: performance patch

Sridhar Samudrala:
  [SCTP]: Fix potential null pointer dereference while handling an icmp error

Stefan Bader:
  s390: channel tape fixes

Stephen Hemminger:
  [IPV4]: Fix up lots of little whitespace indentation stuff in fib_trie.

Steve Dickson:
  NFS: procfs/sysctl interfaces for lockd do not work on x86_64

Steven Rostedt:
  speed up on find_first_bit for i386 (let compiler do the work)
  fix MAX_USER_RT_PRIO and MAX_RT_PRIO

suzuki:
  madvise() does not always return -EBADF on non-file mapped area

Takashi Iwai:
  [ALSA] wavefront - declare initialization data as static
  [ALSA] via82xx - Fix dxs_support of twinhead laptop
  [ALSA] vx-driver - Fix the calculation of frequency parameter
  [ALSA] hdsp - Add 'Sample Clock Source Locking' control
  [ALSA] Add ARM PXA2xx AC97 driver
  [ALSA] Add DBRI driver on Sparcs
  [ALSA] Add help texts to Kconfig
  [ALSA] maestro3 - Clean up
  [ALSA] Fix resume of intel8x0
  [ALSA] cmipci - Add Mic Boost capture switch
  [ALSA] vxpocket - Remove unused code
  [ALSA] Fix and clean-up of vxpocket driver
  [ALSA] Use kstrdup
  [ALSA] Fix dependency of GUS driver
  [ALSA] hda-codec - Add entry for Acer APFV
  [ALSA] hda-codec - Add 6stack model for ALC880
  [ALSA] trident - Shut up compile warnings
  [ALSA] hda-codec - Fix oops with ALC880

Thomas Gleixner:
  [MTD] NAND: Fix broken bad block scan for 16 bit devices
  Merge with rsync://fileserver/linux
  [JFFS2] Fix node allocation leak
  Merge with rsync://fileserver/linux
  [MTD] Make XIP support depend on CONFIG_ARM

Thomas Graf:
  [PKT_SCHED]: Reduce branch mispredictions in pfifo_fast_dequeue
  [PKT_SCHED]: Remove debugging leftover from textsearch ematch

Todd Poynor:
  Merge with rsync://fileserver/linux
  [JFFS2] Avoid compiler warnings when JFFS2_FS_WRITEBUFFER=n

Tom Duffy:
  Add kernel portion of user CM implementation (fix)

Tom Rini:
  Change PowerPC MPC8xx maintainer

Tony Luck:
  e1000: no need for reboot notifier
  Auto merge with /home/aegl/GIT/linus
  Auto merge with /home/aegl/GIT/linus
  Auto merge with rsync://rsync.kernel.org/.../torvalds/linux-2.6.git
  Auto merge with /home/aegl/GIT/linus
  Auto merge with /home/aegl/GIT/linus

V. ANANDA KRISHNAN:
  jsm: warning fixes
  jsm: use dynamic major number allocation

Victor Fusco:
  [ALSA] sound/core Fix the sparse warning 'implicit cast to nocast type'
  [ATM]: [ambassador] Fix the sparse warning "implicit cast to nocast type"
  [ATM]: [firestream] fix the sparse warning "implicit cast to nocast type"
  [NET]: Fix "nocast type" warnings in skbuff.h
  [NETLINK]: Fix "nocast type" warnings

Yoichi Yuasa:
  mips: remove obsolete GIU driver for vr41xx
  mips: fbdev Kcofnig fix

Zoltan Menyhart:
  [IA64] improve flush_icache_range()

