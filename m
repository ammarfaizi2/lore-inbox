Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262135AbUDDDvg (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Apr 2004 22:51:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262138AbUDDDvg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Apr 2004 22:51:36 -0500
Received: from fw.osdl.org ([65.172.181.6]:22696 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262135AbUDDDvQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Apr 2004 22:51:16 -0500
Date: Sat, 3 Apr 2004 19:51:15 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Linux v2.6.5
Message-ID: <Pine.LNX.4.58.0404031949170.20005@ppc970.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Soma more architecture updates, and a few fixes for silly broken stuff in 
-rc3. And an ALSA update.

And I'll be offline for a week, so have fun with this, and if you get the 
shakes because you want to compile a new kernel every day, there's always 
the -mm tree to play with while I'm gone.. 

		Linus

---

Summary of changes from v2.6.5-rc3 to v2.6.5
============================================

Adrian Bunk:
  o fix ALSA au88x0 compilation

Andrew Morton:
  o Make pdflush run at nice 0
  o io_getevents leak fix
  o remove __ARCH_SI_BAND_T
  o ksoftirqd: missing barrier
  o run page_address_init() earlier
  o Show more stats in the sysrq-M output
  o uninline signal_wake_up
  o uninline __group_send_sig_info
  o uninline sig_ignored
  o uninline __group_complete_signal
  o uninline __wake_up_parent
  o export hugetlb_total_pages

Alexander Stohr;
  o double semicolon cleanup

Andy Whitcroft:
  o Fix hugetlb-vs-memory overcommit

Anton Blanchard:
  o ppc64: make iSeries boot mostly
  o ppc64: clean up virtual <-> absolute code

Arjan van de Ven:
  o ALSA CVS update - Jaroslav Kysela <perex@suse.cz> ICE1712 driver

Armin Schindler:
  o ISDN Eicon driver: NULL pointer check inside spinlock
  o ISDN Eicon driver: tasklet_kill removal

Art Haas:
  o [SPARC32]: gcc 3.4+ compile fixes

Bart De Schuymer:
  o [NETFILTER]: Do not require ip_forwarding for reset on a bridge

Benjamin Herrenschmidt:
  o ppc32: Even more preempt fixes
  o ppc32: Remove duplicate export
  o ppc32: context switch  fixes
  o ppc32: Allow PREEMPT with SMP in KConfig
  o ppc32: PCI mmap update
  o ppc64: Add a sync in context switch on SMP
  o ppc64: More incorrect syscall error test
  o PowerMac: cleanup of some scsi drivers

Bjorn Helgaas:
  o kbuild: Add cscope to make help

Chas Williams:
  o [ATM]: mpoa_proc warning cleanup (from Willy TARREAU
    <willy@w.ods.org>)

Chris Mason:
  o loop setup calling bd_set_size too soon

Christoph Hellwig:
  o [XFS] use ssize_t to store VOP_READ/VOP_WRITE return value
  o [XFS] Fix r/o check in xfs_ioc_space, fix checks on xfs_swapext
    validity

Dave Kleikamp:
  o JFS: initialize log->bp before calling lmNextPage

David Gibson:
  o ppc64: bugfix for hugepage support
  o ppc64: allow MAP_FIXED hugepage mappings
  o ppc64: add useful warning message in hugepage code

David Mosberger:
  o Replace MAX_MAP_COUNT with /proc/sys/vm/max_map_count

David S. Miller:
  o [SOC]: Fix cast-as-lvalue warnings in soc fc4 driver
  o [CARMEL]: Fix 64-bit platform warning
  o [INTERMEZZO]: Fix 64-bit platform warnings
  o [SPARC64]: Export prom_palette

David Stevens:
  o [IPV4]: Fix IGMPv3 timer initialization when device not upped

Eric Sandeen:
  o [XFS] Use PFLAGS_RESTORE_FSTRANS in place of PFLAGS_RESTORE, only
    restore previously saved FSTRANS state.  Otherwise we can lose
    process flags.

Glen Overby:
  o [XFS] Add space for inode and allocation btrees to ITRUNCATE log
    reservation
  o [XFS] Define a new superblock field for more feature bits.  Take
    the last feature bit in sb_versionnum to use to indicate that the
    new feature bit field is to be used.

Greg Kroah-Hartman:
  o back out sysfs reference count change

Harald Welte:
  o [NETFILTER]: Fix DEBUG compile in ipt_MASQUERADE
  o [NETFILTER]: Fix DELETE_LIST oopses
  o [NETFILTER]: Fix circular conntrack header file dependency

Hideaki Yoshifuji:
  o [CREDITS]: Update my affiliation

Ingo Molnar:
  o kbuild: Trivial spelling / rephrasing

Ivan Kokshaysky:
  o Alpha: UP1500 pci_mem fix

James Bottomley:
  o fix the subarch build again after ACPI breakage

James Morris:
  o [IPV6]: Link some packet walker helpers always statically

Jaroslav Kysela:
  o ALSA CVS update - Clemens Ladisch <clemens@ladisch.de> USB generic
    driver remove calls to usb_driver_release_interface (not needed
    when disconnect is called)
  o ALSA CVS update - Clemens Ladisch <clemens@ladisch.de> USB generic
    driver replace usage of interface index with calls to
    usb_ifnum_to_if (forgot this in 1.88)
  o ALSA CVS update - Clemens Ladisch <clemens@ladisch.de> USB generic
    driver clean up get_iface again :)
  o ALSA CVS update - Clemens Ladisch <clemens@ladisch.de> USB generic
    driver high speed support
  o ALSA CVS update - Takashi Iwai <tiwai@suse.de> Intel8x0 driver
    added the quirk for Compaq Evo D510C.
  o ALSA CVS update - Takashi Iwai <tiwai@suse.de> PCM Midlevel
  o ALSA CVS update - Takashi Iwai <tiwai@suse.de> Documentation The
    description about ALSA proc files, including debug information.
  o ALSA CVS update - Takashi Iwai <tiwai@suse.de> Intel8x0 driver
    Removed the unprocessed IRQ detection, it seems bogus.
  o ALSA CVS update - Jaroslav Kysela <perex@suse.cz> I2C cs8427,ALSA
    Version,ICE1712 driver Added cs8427_timeout parameter to the
    ICE1712 driver
  o ALSA CVS update - Jaroslav Kysela <perex@suse.cz> Documentation
    Added cs8427_timeout to the snd-ice1712 module description
  o ALSA CVS update - Jaroslav Kysela <perex@suse.cz> Sound Core
    PDAudioCF driver Adrian Bunk <bunk@fs.tum.de> Fix warnings
    (SNDRV_GET_ID is not required since these files don't use get_id).
  o ALSA CVS update - Clemens Ladisch <clemens@ladisch.de> USB generic
    driver fix deadlock on register_mutex and other bugs in
    initialization error paths
  o ALSA CVS update - Jaroslav Kysela <perex@suse.cz> PCM Midlevel Fix
    in snd_pcm_timer_resolution_change() - it no longer oops when
    32-bit value overflows.
  o ALSA CVS update - Clemens Ladisch <clemens@ladisch.de> USB generic
    driver adjust usb_set_interface() calls for 2.6.5-rc2
  o ALSA CVS update - Jaroslav Kysela <perex@suse.cz> Documentation
    Corrected cs8427_timeout
  o ALSA CVS update - Takashi Iwai <tiwai@suse.de> Documentation,I2C
    cs8427,ICE1712 driver fixed cs8427_timeout option to use the
    correct value in msec.
  o ALSA CVS update - Takashi Iwai <tiwai@suse.de> Intel8x0 driver
    disable the legacy midi/joystick properly as default.
  o ALSA CVS update - Jaroslav Kysela <perex@suse.cz> ALSA Version
    release: 1.0.4rc1
  o ALSA CVS update - Jaroslav Kysela <perex@suse.cz> PPC PowerMac
    driver Remove global enable variable
  o ALSA CVS update - Jaroslav Kysela <perex@suse.cz> CS46xx driver
    Added parsing of mmap_valid,external_amp and thinkpad parameters at
    boot time
  o ALSA CVS update - Jaroslav Kysela <perex@suse.cz> CS46xx driver
    mmap_valid is 1 by default
  o ALSA CVS update - Jaroslav Kysela <perex@suse.cz> ICE1712 driver
    Fixed Delta410 cs8427 i/o
  o ALSA CVS update - Takashi Iwai <tiwai@suse.de> IOCTL32 emulation
    disabled the entries conflifting with TIOC* ioctls.
  o ALSA CVS update - Clemens Ladisch <clemens@ladisch.de> AC97 Codec
    Core fix detection of 2.3 codecs
  o ALSA CVS update - Clemens Ladisch <clemens@ladisch.de> AC97 Codec
    Core fix superfluous rate register assignments
  o ALSA CVS update - Clemens Ladisch <clemens@ladisch.de> AC97 Codec
    Core fix hang because of uninitialized ad18xx.mutex with AD1985
  o ALSA CVS update - Clemens Ladisch <clemens@ladisch.de> AC97 Codec
    Core don't clobber other bits in SERIAL_CFG register with AD codecs
    when changing codec selection bits
  o ALSA - fixed date in version.h
  o ALSA CVS update - Clemens Ladisch <clemens@ladisch.de> USB generic
    driver add usb_device->speed wrapper for compiling with 2.2.x
    kernels
  o ALSA CVS update - Jaroslav Kysela <perex@suse.cz> au88x0 driver
    Cleanups - removed duplicate PCI IDs
  o ALSA - 1.0.4rc2

Jasper Spaans:
  o kbuild: Preset locale variables

Jeff Garzik:
  o Fix oopses in fealnx driver TX path
  o fix VIA SATA device detection

Jens Axboe:
  o Fix BLKPREP_KILL

Keith M. Wesolowski:
  o [SPARC32]: Correct init_thread_union section and alignment for gcc
    3.3+
  o [SPARC32]: Allow debugging locks to compile again
  o [SPARC32]: Replace deprecated EXPORT_SYMBOL_NOVERS
  o [SPARC32]: Use model-specific cpuid calls in model-specific code
  o [SPARC32]: Optimize SMP IPI handling
  o [SPARC32]: Rename cpuid functions
  o [SPARC32]: Update module linking for symbols starting with "."
  o [SPARC32]: Display useful information in the event of a bad trap
  o [SPARC32]: Fix cast-as-lvalue
  o [SPARC32]: Regenerate defconfig

Len Brown:
  o [ACPI] allow building ACPI w/ CMPXCHG when CONFIG_M386=y
    http://bugzilla.kernel.org/show_bug.cgi?id=2391
  o [ACPI] delete extraneous IRQ->pin mappings below IRQ 16
    http://bugzilla.kernel.org/show_bug.cgi?id=2408
  o [ACPI] PCI bridge interrupt fix (David Shaohua Li)
    http://bugzilla.kernel.org/show_bug.cgi?id=2409
  o [ACPI] Restore PIC-mode SCI default to Level Trigger (David Shaohua
    Li) http://bugme.osdl.org/show_bug.cgi?id=2382

Linus Torvalds:
  o Fix serious naming problem
  o Add __user pointer annotations
  o acpi: enable global wake events by default
  o Re-instate __ARCH_SI_BAND_T, to allow architecture overrides
  o Linux 2.6.5

Marcelo Tosatti:
  o pc300 driver misplaced ;

Marcus Meissner:
  o siginfo.si_band is long

Martin Schaffner:
  o kbuild: Avoid "expr length" in Makefile

Martin Schwidefsky:
  o Fix swp_entry_t encoding

Matt Porter:
  o PPC32 build fix
  o PPC32: PPC40x build fix
  o PPC32: Add missing PPC44x PVRs
  o PPC32: Fix some 4xx defconfigs
  o PPC32: Fix latent PPC44x tlb bug

Mike Christie:
  o catch errors when completing bio pairs

Nathan Scott:
  o [XFS] Fix up mrlock debug code, and ensure its only built under
    DEBUG
  o [XFS] Remove dup fdatasync/fdatawait call on fsync.  Means we no
    longer take the iolock here, and readers no longer conflict with
    concurrent fsync activity.  Kudos to Steve!
  o [XFS] Fix debug builds - need sb_features2 details in endian
    translation code
  o [XFS] Reenable non-block flag for DMAPI
  o [XFS] Reinstate some accidentally dropped log IO error injection
    code
  o [XFS] Fix shortform attr flags botch affecting listxattr - from
    Andreas Gruenbacher
  o [XFS] Disallow logbufs=0 unless the correct compilation flags used,
    else we panic.
  o [XFS] Ensure sb not flushed async on a SYNC_WAIT sync.  Fixed by
    Bart Samwel
  o [XFS] Make the XFS access checks like the other Linux filesystems
    for DAC

Nathan Straz:
  o [XFS] Use unsigned long long for end_offset so we don't overflow it

Nivedita Singhvi:
  o [TCP]: Use tcp_tw_put on time-wait sockets
  o [TCP]: IPV6, do not use sock_put() on timewait sockets

Richard Henderson:
  o [ALPHA] Use __attribute_used__
  o [ALPHA] Detect and export cache shapes to userland
  o [ALPHA] DISCONTIGMEM fix From Ivan Kokshaysky <ink@jurassic.park.msu.ru>.
  o [ALPHA] Use progbits for got section
  o [ALPHA] Add pci_dma_mapping_error
  o [ALPHA] Use raw asm instead of attributes for cond_syscall


Russell King:
  o [ARM] Add ARM virtual memory layout documentation
  o [ARM] Update ARM makefiles

Rusty Russell:
  o kbuild: Less modules printed when warned about SUBDIRS usage

Sam Ravnborg:
  o kbuild: $LANG fix

Srivatsa Vaddagiri:
  o Fix obvious stupid race in do_stop

Stephen Rothwell:
  o ppc64: create dma_mapping_error

Timothy Shimmin:
  o [XFS] Be explicit in adding in the non-transactional data to the
    reservation estimate.  We must add in for the worst case of a log
    stripe taking us the full distance for a log stripe boundary.

Tom Rini:
  o PPC32: Fix thinko in arch/ppc/boot/simple/relocate.S

Ulises Alonso Camaró:
  o [AF_PACKET]: Fix packet_set_ring memleak and remove num frame limit
  o [AF_PACKET]: Add PACKET_MMAP documentation
