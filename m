Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932506AbWBCGhA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932506AbWBCGhA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Feb 2006 01:37:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932516AbWBCGg7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Feb 2006 01:36:59 -0500
Received: from smtp.osdl.org ([65.172.181.4]:60322 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932506AbWBCGg5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Feb 2006 01:36:57 -0500
Date: Thu, 2 Feb 2006 22:36:50 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Linux v2.6.16-c2
Message-ID: <Pine.LNX.4.64.0602022232410.3462@g5.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Ok, 
 it's much bigger than I would have wished for, but I guess that's what I 
get for going away for Linux.Conf.Au and letting two weeks pass rather 
than the normal one-week schedule between -rc's.

Mostly driver (mainly sound, network cards and SCSI) and ACPI updates 
here. And a lot of small fixes. Shortlog appended.

		Linus

----
Adam Belay:
      [ALSA] check return code in pnp_register_card_driver()

Adrian Bunk:
      [ACPI] make two processor functions static
      ipw2100: remove code for WIRELESS_EXT < 18
      hostap: don't #include C files in hostap_main.c
      [CPUFREQ] X86_GX_SUSPMOD must depend on PCI
      Input: make needlessly global code static
      PCMCIA=m, HOSTAP_CS=y is not a legal configuration
      USB: drivers/usb/media/w9968cf.c: remove hooks for the vpp module
      USB: drivers/usb/media/ov511.c: remove hooks for the decomp module
      PCI: schedule PCI_LEGACY_PROC for removal
      PCI: drivers/pci/pci.c: #if 0 pci_find_ext_capability()
      kernel/posix-timers.c: remove do_posix_clock_notimer_create()

Al Viro:
      nfsd/vfs.c: endianness fixes
      nfsd4_truncate() bogus return value
      NFSERR_SERVERFAULT returned host-endian
      nfsd4_lock() returns bogus values to clients
      [ARM] safer handling of syscall table padding

Alan Cox:
      libata: Pre UDMA EIDE PIO mode selection
      libata: add a function to decide if we need iordy
      Fix warning with b44.c on 64bit boxes
      libata: Fix heuristic typos add LBA48PIO flag and support code, add IRQ flag for next diff
      libata: Fix sector lock to apply to both drives not drive 0 twice
      libata: Code for the IRQ mask flag
      EDAC: atomic scrub operations
      EDAC: drivers for AMD 76x and Intel E750x, E752x
      EDAC: drivers for Intel i82860, i82875
      EDAC: drivers for Radisys 82600
      EDAC: core EDAC support code
      [SERIAL] 8250 serial console fixes
      USB: libusual: fix warning on 64bit boxes

Alan Hourihane:
      [AGPGART] 945GM support for agpgart

Alan Stern:
      USB: UHCI: No FSBR until device is configured
      USB: gadgetfs: set "zero" flag for short control-IN response

Alasdair G Kergon:
      device-mapper snapshot: load metadata on creation
      device-mapper ioctl: reduce PF_MEMALLOC usage
      device-mapper snapshot: barriers not supported
      dm: dm-table warning fix

Albert Herranz:
      powerpc: fix for kexec ppc32

Alessandro Zummo:
      Input: add ixp4xx beeper driver

Alexandre Duret-Lutz:
      USB: usb-storage support for SONY DSC-T5 still camera

Alexey Dobriyan:
      Input: iforce - do not return ENOMEM upon successful allocation
      USB: arm26: fix compilation of drivers/usb/core/message.c
      [ALSA] Fix adding second dma channel
      tsunami_flash: fix "parse error before ';' token"
      lp486e: remove SLOW_DOWN_IO
      alpha: dma-mapping.h: add "struct scatterlist;"
      ipw2200: fix ->eeprom[EEPROM_VERSION] check
      mips: gdb-stub.c: fix parse error before ; token
      Mark CONFIG_UFS_FS_WRITE as BROKEN
      arch/sh64/kernel/time.c: add module.h
      arm26: fix find_first_zero_bit related warnings
      arm26: fix warnings about NR_IRQS being not defined
      arm26: remove irq_exit() from hardirq.h
      arm26: select system type via "choice"
      arm26: fixup get_signal_to_deliver call
      arm26: fixup asm statement in kernel/fiq.c
      arm26: drop local task_running copy
      arm26: drop first arg of prepare_arch_switch, finish_arch_switch
      arm26: add __kernel_old_dev_t for nfsd
      arm26: select BLK_DEV_FD only on A5K
      xtensa: add asm/futex.h

Alexey Starikovskiy:
      [ACPI] fix reboot upon suspend-to-disk

Alon Bar-Lev:
      [SERIAL] Add 8250 support for Decision Computer International Co. PCCOM2

Amnon Aaronsohn:
      [PKT_SCHED] sch_prio: fix qdisc bands init

Ananda Raju:
      s2io: scatter-gather fix

Andi Kleen:
      PCI: handle bogus MCFG entries

Andreas Gruenbacher:
      knfsd: Restore recently broken ACL functionality to NFS server

Andrew Morton:
      [AGPGART] Suspend/Resume support for AMD64 GART.
      [AGPGART] Suspend/Resume support for ATI GART
      [AGPGART] Semaphore to Mutex conversion.
      [CASSINI]: Fix printk warning.
      [IPV4]: RT_CACHE_STAT_INC() warning fix
      [CPUFREQ] Convert drivers/cpufreq semaphores to mutexes.
      [CPUFREQ] Don't free held mutex in cpufreq_add_dev()
      scsi_transport_spi build fix
      mm: dirty_exceeded speedup
      [ALSA] Fix a typo in snd_assert()
      [ALSA] hdsp - Fix printk warnings
      [ALSA] pcxhr - Fix printk warning
      "Fix uidhash_lock <-> RXU deadlock" fix
      USB: fix ehci early handoff issues warning
      USB: add new auerswald device ids
      USB: yealink printk warning fix
      x86_64: compat_sys_futimesat fix
      smbfs readdir vs signal fix
      compat_sys_pselect7() fix
      tpm_bios: securityfs error checking fix
      tpm_bios indexing fix
      hrtimers: fix posix-timer requeue race
      dump_stack() in oom handler

Andrew Vasquez:
      [SCSI] qla2xxx: Correct synchronization issues during rport addition/deletion.
      [SCSI] qla2xxx: Correct issue where the rport's upcall was not being made after relogin.
      [SCSI] qla2xxx: Drop legacy 'bypass lun scan for tape device' code.

Andrew Victor:
      [ARM] 3268/1: AT91RM9200 serial update for 2.6.15-git12

Andriy Skulysh:
      video: hp680 backlight driver

Andy Adamson:
      nfsd4: misc lock fixes
      svcrpc: gss: handle the GSS_S_CONTINUE

Andy Whitcroft:
      GFP_ZONETYPES: add commentry on how to calculate
      GFP_ZONETYPES: calculate from GFP_ZONEMASK

Antonino A. Daplas:
      fbcon: Fix screen artifacts when moving cursor

Arjan van de Ven:
      [ACPI] move some run-time structure inits to compile time
      [CPUFREQ] convert remaining cpufreq semaphore to a mutex
      USBATM: semaphore to mutex conversion

Arnaud Patard:
      [ALSA] patch_realtek.c: Add new model

Arnd Bergmann:
      spidernet: check if firmware was loaded correctly
      spidernet: read firmware from the OF device tree
      spidernet: fix HW structures for 64 bit dma_addr_t
      spidernet: performance optimizations
      spidernet: fix missing include
      add missing syscall declarations

Arthur Othieno:
      PCI: cyblafb: remove pci_module_init() return, really.

Ashok Raj:
      __cpuinit functions wrongly marked __meminit

Baruch Even:
      [TCP] H-TCP: Fix accounting

Ben Collins:
      [CPUFREQ] p4-clockmod: Workaround for CPU's with N60 errata
      Input: hiddev - fix off-by-one for num_values in uref_multi requests
      powerpc: enable irq's for platform functions.

Benjamin Herrenschmidt:
      [SUNGEM]: Make PM of PHYs more reliable (#2)
      sound/ppc/pmac.c typo

Benjamin LaHaise:
      Use 32 bit division in slab_put_obj()

Benoit Boissinot:
      [ACPI] fix acpi_cpufreq.c build warrning
      [NETFILTER] ip[6]t_policy: Fix compilation warnings

Bjorn Helgaas:
      [ACPI] enable PNPACPI support for resource types used by HP serial ports

Bob Moore:
      [ACPI] ACPICA 20050930
      [ACPI] ACPICA 20051021
      [ACPI] ACPICA 20051102
      [ACPI] ACPICA 20051117
      [ACPI] ACPICA 20051202
      [ACPI] ACPICA 20051216
      [ACPI] ACPICA 20060113
      [ACPI] ACPICA 20060127

Bodo Stroesser:
      uml: move LDT creation
      uml: change interface to boot_timer_handler
      uml: TT mode softint fixes

brking@us.ibm.com:
      [SCSI] Prevent scsi_execute_async from guessing cdb length

Bryan O'Sullivan:
      Fix sparse parse error in lppaca.h
      Define BITS_PER_BYTE
      Introduce __iowrite32_copy
      Add faster __iowrite32_copy routine for x86_64

Catalin Marinas:
      [ARM] 3289/1: Enable the LCD support for Integrator/CP

Chris Ball:
      [ALSA] intel8x0: Add quirk for Optiplex GX270

Chris Mason:
      resierfs: fix reiserfs_invalidatepage race against data=ordered
      reiserfs: zero b_private when allocating buffer heads
      reiserfs: reiserfs hang and performance fix for data=journal mode
      reiserfs: reiserfs write_ordered_buffers should not oops on dirty non-uptodate bh
      reiserfs: reiserfs fix journal accounting in journal_transaction_should_end

Chris Wright:
      Make sure to always check upper bits of tv_nsec in timespec_valid.

Christoph Hellwig:
      exportfs: add find_acceptable_alias helper
      [SCSI] fusion: setting timeouts in eh threads appropiatley for fc/sas/spi
      [SCSI] fusion: add MSI support
      [SCSI] mptsas: don't complain on bogus slave_alloc calls
      reiserfs: remove reiserfs_permission_locked
      reiserfs: use generic_permission

Christoph Lameter:
      Simplify migrate_page_add
      Zone reclaim: resurrect may_swap
      Zone reclaim: Reclaim logic
      Zone reclaim: proc override
      NUMA policies in the slab allocator V2
      mm: optimize numa policy handling in slab allocator
      Optimize off-node performance of zone reclaim
      zone_reclaim: reclaim on memory only node support
      mm: improve function of sc->may_writepage
      zone_reclaim: minor fixes
      zone_reclaim: do not unmap file backed pages
      zone_reclaim: partial scans instead of full scan
      zone_reclaim: configurable off node allocation period.
      Zone reclaim: Allow modification of zone reclaim behavior
      Reclaim slab during zone reclaim
      Direct Migration V9: PageSwapCache checks
      Direct Migration V9: migrate_pages() extension
      Direct Migration V9: remove_from_swap() to remove swap ptes
      Direct Migration V9: upgrade MPOL_MF_MOVE and sys_migrate_pages()
      Direct Migration V9: Avoid writeback / page_migrate() method
      slab: minor cleanup to kmem_cache_alloc_node

Clemens Ladisch:
      [ALSA] usb-audio: don't use empty packets at start of playback
      [ALSA] ymfpci: fix SPDIF sample rate information
      [ALSA] usb-audio: fix non-48k sample rates with SB Audigy 2 ZS
      USB: EHCI, another full speed iso fix

Cornelia Huck:
      s390: Fix modalias for ccw devices

Craig Shelley:
      USB: cp2101 Add new device IDs

Dale Farnsworth:
      mv643xx_eth: Add Dale Farnsworth as a maintainer
      mv643xx_eth: Add multicast support
      mv643xx_eth: Receive buffers require 8 byte alignment
      mv643xx_eth: iounmap the correct SRAM buffer
      mv643xx_eth: Hold spinlocks only where needed
      mv643xx_eth: Fix transmit skb accounting
      mv643xx_eth: Merge open and stop helper functions
      mv643xx_eth: Remove needless mask of extended intr register
      mv643xx_eth: Fix spinlock recursion bug
      mv643xx_eth: Whitespace cleanup
      mv643xx_eth: Fix for building as a module

Dan Williams:
      drivers/net/wireless: correct reported ssid lengths

Daniel =?ISO-8859-1?Q?Marjam=E4ki:
      [AGPGART] Loop cleanup

Daniel Drake:
      Clarify help text of SKGE/SK98LIN/SKY2

Dave Airlie:
      drm: Fix sparce warning in radeon driver
      drm: add i945GM PCI ID
      drm: add X600 PCI IDs
      drm: use NULL instead of 0
      drm: ati_pcigart: simplify page_count manipulations
      drm: i915 patches from Tungsten Graphics
      drm: Fixes sparse warnings in via_dmablit.c
      drm: drivers/char/drm/: make some functions static
      sem2mutex: drivers/char/drm/

Dave C Boutcher:
      [SCSI] ibmvscsi: handle re-enable firmware message

Dave Jones:
      [X86] Remove Winchip 4 ID.
      [X86] Rename MTRR mutex to something more sensible.
      [X86] Remove pointless versioning of mtrr driver.
      [X86] Add new Intel cache descriptors.
      [IPV4] igmp: remove pointless printk
      fix saa7146 kobject register failure

Davi Arnaut:
      ebcdic do_kdsk_ioctl off-by-one

David Brownell:
      USB: fix EHCI early handoff issues
      USB: net2280 warning fix
      USB: USB authentication states
      USB: gadget zero and dma-coherent buffers

David Chinner:
      [XFS] Fix a race in xfs_submit_ioend() where we can be completing I/O for

David Elliott:
      hfs: add HFSX support

David Gibson:
      powerpc: Add flattened device tree documentation

David Hollis:
      USB: asix - Add device IDs for 0G0 Cable Ethernet

David Howells:
      Handle TIF_RESTORE_SIGMASK for FRV
      Handle TIF_RESTORE_SIGMASK for i386

David L Stevens:
      [IPV4]: Fix multiple bugs in IGMPv3
      [IPV6] MLDv2: fix change records when transitioning to/from inactive

David S. Miller:
      [NETFILTER]: ip_conntrack_proto_gre.c needs linux/interrupt.h
      [NET]: Make second arg to skb_reserved() signed.
      [SPARC]: Fix sbusfb build.
      [SOUND]: sparc/cs4231: Fix some typos which wrecked the build.
      [SPARC64]: Update defconfig.
      [PKTGEN]: Respect hard_header_len of device.
      [SPARC64]: Fix build with CONFIG_COMPAT disabled.
      [SPARC]: sparc32 needs PROMDEV_{I,O}RSC defines too.
      [SPARC]: Add support for *at(), ppoll, and pselect syscalls.
      [NETFILTER] x_tables: Make XT_ALIGN align as strictly as necessary.
      Fix regression added by ppoll/pselect code.
      [SPARC64]: Use compat_sys_futimesat in 32-bit syscall table.
      [NETFILTER]: Unbreak x-tables on x86.
      [SPARC]: Increase NR_SYSCALLS to 299
      [SPARC64]: Implement __raw_read_trylock()
      [SPARC64]: Kill compat_sys_clock_settime sign extension stub.
      [SPARC]: Fix compile failures in math-emu.
      [SUNGEM]: Unbreak Sun GEM chips.
      [DCCP] ipv6: dccp_v6_send_response() has a DST leak too.

David Shaohua Li:
      [ACPI] SMP S3 resume: evaluate _WAK after INIT

David Shaw:
      knfsd: Provide missing NFSv2 part of patch for checking vfs_getattr.

David Vrabel:
      [ARM] 3267/1: PXA27x SSP controller register defines
      [ARM] 3281/1: ixp4xx: export ixp4xx_exp_bus_size for modules

David Woodhouse:
      Generic sys_rt_sigsuspend()
      TIF_RESTORE_SIGMASK support for arch/powerpc
      Add pselect/ppoll system call implementation
      Add pselect/ppoll system calls on i386

Dean Roe:
      [IA64-SGI] add sn_feature_sets bit

Denis MONTERRAT:
      USB: add new pl2303 device ids

Diego Calleja:
      reiserfs: missing kmalloc failure check

Dirk Mueller:
      NFSv3: fix sync_retry in direct i/o NFS

Dmitry Torokhov:
      Input: psmouse - set name for Genius mice
      Input: grip - fix crash when accessing device
      Input: grip - handle errors from input_register_device()
      Input: db9 - fix possible crash with Saturn gamepads
      Input: db9 - handle errors from input_register_device()
      Input: sidewinder - handle errors from input_register_device()
      Input: gamecon - fix crash when accessing device
      Input: gamecon - handle errors from input_register_device()
      Input: turbografx - handle errors from input_register_device()
      Input: tmdc - handle errors from input_register_device()
      Input: a3d - convert to dynamic input_dev allocation
      Input: iforce - fix detection of USB devices

Duncan Sands:
      USBATM: trivial modifications
      USBATM: add flags field
      USBATM: remove .owner
      USBATM: kzalloc conversion
      USBATM: xusbatm rewrite
      USBATM: shutdown open connections when disconnected
      USBATM: return correct error code when out of memory
      USBATM: use dev_kfree_skb_any rather than dev_kfree_skb
      USBATM: measure buffer size in bytes; force valid sizes
      USBATM: allow isochronous transfer
      USBATM: handle urbs containing partial cells
      USBATM: bump version numbers
      USBATM: -EILSEQ workaround

Eddie C. Dost:
      [SPARC64]: Serial Console for E250 Patch

Eric Dumazet:
      [IPV4]: rt_cache_stat can be statically defined

Eric Sesterhenn:
      [SPARC]: change if() BUG(); to BUG_ON in iommu.c
      bonding: fix ->get_settings error checking
      acenic: fix checking of read_eeprom_byte() return values
      alpha show_interrups() trashes argument

Eric Sesterhenn / snakebyte:
      USB: Remove LINUX_VERSION_CODE check in pwc/pwc-ctrl.c

Eric Van Hensbergen:
      v9fs: add readpage support

Eric W. Biederman:
      [IPV6] tcp_v6_send_synack: release the destination
      alpha: Fix getxpid on alpha so it works for threads

Fred Isaman:
      nfsd4: Fix bug in rdattr_error return
      nfsd4: clean up settattr code

Gennady Sharapov:
      uml: move libc-dependent utility procedures
      uml: move libc-dependent time code
      uml: move headers to arch/um/include
      uml: move libc-dependent skas memory mapping code
      uml: move libc-dependent skas process handling

George Anzinger:
      hrtimers: cleanups and simplifications

George G. Davis:
      [ARM] 3269/1: Add ARMv6 MT_NONSHARED_DEVICE mem_types[] index

Giuliano Pochini:
      [ALSA] fix typos in writing-an-alsa-driver

Graham Gower:
      prism54/islpci_eth.c: dev_kfree_skb used with interrupts disabled

Grant Coady:
      PCI: pci_ids: remove duplicates gathered during merge period

Grant Grundler:
      PCI: make it easier to see that set_msi_affinity() is used

Greg Edwards:
      [IA64] sn2 maintainer update (Jes Sorensen)

Greg Kroah-Hartman:
      USB: remove some left over devfs droppings hanging around in the usb drivers
      USB: add might_sleep() to usb_unlink_urb() to warn developers

Guennadi Liakhovetski:
      [SCSI] dc395x: "fix" virt_addr calculation on AUTO_REQSENSE

Hannes Reinecke:
      [SCSI] aic7xxx: Update aicasm
      [SCSI] aic79xx: sequencer fixes
      [SCSI] aic79xx: SLOWCRC fix
      [SCSI] aic7xxx: update documentation
      [SCSI] aic79xx: Fix timer handling

Heiko Carstens:
      powerpc: Fix sigmask handling in sys_sigsuspend.
      s390: Remove CVS generated information
      s390: New default configuration
      s390: Add support for new syscalls/TIF_RESTORE_SIGMASK

Henk:
      drivers/usb/input/yealink.c: Cleanup device matching code

Herbert Xu:
      [NET]: Fix skb fclone error path handling.

Horst Hummel:
      s390: dasd open counter
      s390: dasd wait for clear i/o interrupt

Hugh Dickins:
      mm: hugepage accounting fix

Ian Abbott:
      USB: ftdi_sio: new IDs for Westrex devices

Ingo Molnar:
      sem2mutex: mm/slab.c
      [ALSA] Remove BKL from sound/core/info.c
      IB/srp: Semaphore to mutex conversion
      Fix boot-time slowdown for measure_migration_cost
      fix uidhash_lock <-> RCU deadlock
      fix deadlock in drivers/pci/msi.c
      rcu_torture_lock deadlock fix
      CONFIG_DOUBLEFAULT Kconfig fix

J. Bruce Fields:
      svcrpc: save and restore the daddr field when request deferred
      nfsd4: fix nfsd4_lock cleanup on failure
      nfsd4: rename lk_stateowner
      nfsd4: remove release_state_owner()
      nfsd4: fix check_for_locks
      nfsd4: operation debugging
      svcrpc: gss: svc context creation error handling
      nfsd4: fix open of recovery directory
      nfsd4: recovery lookup dir check
      nfsd4: handle replays of failed open reclaims
      nfsd4: no replays on unconfirmed owners
      nfsd4: nfs4state.c miscellaneous goto removals
      nfsd4: simplify process-open1 logic
      nfsd4: don't create on open that fails due to ERR_GRACE
      nfsd4: fix open_downgrade

Jack Hammer:
      [SCSI] ips soft lockup during reset/initialization
      [SCSI] ServeRAID: prevent seeing DADSI devices

Jack Steiner:
      [IA64] Zonelists for nodes without cpus
      [IA64] Scaling fix for simultaneous unaligned accesses
      sys_sched_getaffinity() & hotplug

James Bottomley:
      [SCSI] fusion: fix compile

James Courtier-Dutton:
      [ALSA] snd-ca0106: Fixed ALSA bug#1600

Jan Beulich:
      x86_64: Fix MCE exception stack for boot CPU

Jan Glauber:
      s390: overflow in sched_clock
      s390: monotonic_clock interface
      s390: hangcheck timer support

Jan Kara:
      jbd: log_do_checkpoint fix
      jbd: remove_transaction fix

Janosch Machowinski:
      [ACPI] handle BIOS with implicit C1 in _CST

Jaroslav Kysela:
      [ALSA] bt87x - fix detection of unknown card
      [ALSA] cs4232/cs4236 - moved CS423X_DRIVER define outside CONFIG_PNP

Jason Baron:
      fix sched_setscheduler semantics

Jason Gaston:
      ahci: AHCI mode SATA patch for Intel ICH8
      Intel ICH8 SATA: add PCI device IDs
      [ALSA] hda-intel - patch for Intel ICH8
      PCI: irq and pci_ids: patch for Intel ICH8

Javier Achirica:
      airo: Off-by-one channel fix

Jeff Dike:
      uml: add __raw_writel definition
      uml: eliminate some globals
      uml: implement soft interrupts
      uml: use setjmp/longjmp instead of sigsetjmp/siglongjmp
      uml: add TIF_RESTORE_SIGMASK support
      uml: use generic sys_rt_sigsuspend
      uml: add a build dependency
      uml: fix some typos

Jeff Garzik:
      [libata ahci] Isolate Intel-ism, add JMicron JMB360 support
      [libata ahci] add another JMicron pci id

Jeff Kirsher:
      e1000: Fix jumbo frame performance
      e1000: Fix TSO
      e1000: General Fixes
      e1000: Fix SoL/IDER link and loopback
      e1000: Fix ASF/AMT for 8257{1|2|3} controllers
      e1000: Fix PHY config for 82573 controller
      Fix e1000 stats
      e1000: Fix LED functionality for 82573
      e1000: Fix adapter structure and prepare for multique fix
      e1000: Fix mulitple queues
      e1000: Fix loopback logic
      e1000: Fix PHY reset when blocked
      e1000: Fix EEPROM read logic
      e1000: Fix flow control water marks
      e1000: Fix TX queue length based on link speed
      e1000: Fix Desc. Rings and Jumbo Frames
      e1000: Fix TX timeout logic
      e1000: Fix desc. clean up
      e1000: Fix bit 22 (TXDCTL) for 82571 & 82572 controllers
      e1000: Fix collision distance
      e1000: Fix __pskb_pull_tail
      e1000: Fix VLAN support
      e1000: Fixed frame size logic
      e1000: Fix Netpoll issue
      e1000: Added interrupt auto mask support
      e1000: Added cleaned_count to RX buffer allocation
      e1000: Added hardware support for PCI express, 82546GB, and 82571 Fiber
      e1000: Added firmware version reporting for 8257{1|2|3} controllers
      e1000: Added PCIe bus information
      e1000: Added variable to handle return values for pci_enable_* functions
      e1000: Added copy break code
      e1000: Cleaned up code and removed hard coded numbers
      e1000: Removed unused variables and initialized variables

Jeff Mahoney:
      reiserfs: reiserfs: check for files > 2GB on 3.5.x disks

Jens Axboe:
      [BLOCK] ll_rw_blk: make max_sectors and max_hw_sectors unsigned ints
      [BLOCK] ll_rw_blk: use preempt-disabling disk_stat_add() in completion
      [LIBATA] Blacklist certain Maxtor firmware revisions for FUA support
      [BLOCK] A few kerneldoc fixups

Jeremy Higdon:
      Fix sgiioc4 DMA timeout problem with 64KiB s/g elements.

Jerome Borsboom:
      [AF_KEY]: no message type set

Jes Sorensen:
      [IA64-SGI] sn2 mutex conversion
      [IA64-SGI] sn_console.c minor cleanup
      [IA64] sem2mutex: arch/ia64/ia32/sys_ia32.c
      [IA64] sem2mutex: arch/ia64/kernel/perfmon.c
      [IA64-SGI] XPC remove unnecessary GFP_DMA flag
      [SCSI] qla1280: remove < 2.6.0 support

Jesse Brandeburg:
      e100: Fix TX hang and RMCP Ping issue (due to a microcode loading issue)
      e100: Handle the return values from pci_* functions
      e100: e100 whitespace fixes
      e1000: Added disable packet split capability
      e1000: Added RX buffer enhancements
      e1000: Added functions to save and restore config
      e1000: Added functions declarations
      e1000: Fix whitespace
      e1000: Added driver comments
      e1000: fix receive breakage
      e1000: fix compile warning

John Hawkes:
      [IA64] eliminate softlockup warning

john stultz:
      disable lost tick compensation before TSCs are synced

John W. Linville:
      [MAINTAINERS]: correct location for net-2.6.git
      [MAINTAINERS]: add entry for wireless networking

Jon Maloy:
      [TIPC] Minor changes to #includes

Jon Mason:
      Prevent trident driver from grabbing pcnet32 hardware
      [ALSA] Prevent ALSA trident driver from grabbing pcnet32 hardware
      [ALSA] ali5451: Add PCI_DEVICE and #defines in snd_ali_ids

Jonathan Woithe:
      [ALSA] hda-codec - Fix init verb of ALC260

Juergen Schindele:
      USB: touchkitusb.c (eGalax driver) fix

Jun'ichi "Nick" Nomura:
      device-mapper disk statistics: timing

KAMEZAWA Hiroyuki:
      [ACPI] acpi_memhotplug.c build fix

Karol Kozimor:
      [ASUS_ACPI] work around Samsung P30s oops
      [ACPI_ASUS] M6R display reading
      [ACPI_ASUS] fix asus module param description

Keck, David:
      PCI Hotplug: shpchp: AMD POGO errata fix

Keith Owens:
      [IA64] Set the correct default OS status in the MCA handler

Kenji Kaneshige:
      [ACPI] build EC driver on IA64

Kevin Coffman:
      svcrpc: gss: server context init failure handling

Kevin Corry:
      device-mapper statistics: basic

Kimball Murray:
      Input: mousedev - fix memory leak

Kris Katterjohn:
      [NET]: Fix whitespace issues in net/core/filter.c
      [NET]: "signed long" -> "long"
      [PKTGEN]: Replacing with (compare|is_zero)_ether_addr() and ETH_ALEN
      [NET]: Use is_zero_ether_addr() in net/core/netpoll.c
      [NET]: more whitespace issues in net/core/filter.c
      [NET]: Fix some whitespace issues in af_packet.c

Kylene Jo Hall:
      tpm: tpm-bios: fix module license issue
      tpm: tpm_bios fix sparse warnings
      tpm: tpm_bios remove unused variable

Larry Finger:
      Typo corrections for ieee80211

Len Brown:
      [ACPI] handle ACPICA 20050916's acpi_resource.type rename
      [ACPI] clean up ACPICA 20050916's rscalc typedef syntax
      [ACPI] 8250_acpi.c buildfix
      [ACPI] Embedded Controller (EC) driver syntax update
      [ACPI] Enable Embedded Controller (EC) interrupt mode by default
      [ACPI] Embedded Controller (EC) driver printk syntax update
      [ACPI] acpi_register_gsi() fix needed for ACPICA 20051021
      [ACPI] fix osl.c build warning
      [ACPI] fix pnpacpi regression resulting from ACPICA 20051117
      Revert "[ACPI] fix pnpacpi regression resulting from ACPICA 20051117"
      [ACPI] better fix for pnpacpi regression resulting from ACPICA 20051117
      [ACPI] delete message "**** SET: Misaligned resource pointer:"
      [ACPI] remove "Resource isn't an IRQ" warning

Linas Vepstas:
      PowerPC/PCI Hotplug build break
      PowerPC/PCI Hotplug build break
      PCI Hotplug/powerpc: module build break
      PCI Hotplug: PCI panic on dlpar add (add pci slot to running partition)
      powerpc/PCI hotplug: remove rpaphp_find_bus()
      powerpc/PCI hotplug: remove rpaphp_fixup_new_pci_devices()
      powerpc/PCI hotplug: merge config_pci_adapter
      powerpc/PCI hotplug: remove remove_bus_device()
      powerpc/PCI hotplug: de-convolute rpaphp_unconfig_pci_adap
      powerpc/PCI hotplug: merge rpaphp_enable_pci_slot()
      powerpc/PCI hotplug: cleanup: add prefix
      powerpc/PCI hotplug: minor cleanup forward decls
      powerpc/PCI hotplug: shuffle error checking to better location.

Linus Torvalds:
      Don't try to "validate" a non-existing timeval.
      Fix ipv4/igmp.c compile with gcc-4 and IP_MULTICAST
      Linux v2.6.16-rc2

Louis Nyffenegger:
      USB: new id for ftdi_sio.c and ftdi_sio.h

Luca Risolia:
      USB: SN9C10x driver updates and bugfixes
      USB: SN9C10x driver updates
      USB: Add ET61X[12]51 Video4Linux2 driver

Lucas Correia Villa Real:
      [ARM] 3266/1: S3C2400 - adds macro S3C24XX

Lukasz Stemach:
      [ALSA] cs4236 - Add PnP ids for Netfinity 3000

Luming Yu:
      [ACPI] Disable EC burst mode w/o disabling EC interrupts

MAEDA Naoaki:
      [ACPI] ia64 build fix

Manfred Spraul:
      slab: distinguish between object and buffer size

Manuel Lauss:
      i810fb: Do not probe the third i2c bus by default

mark gross:
      tlclk driver update

Mark Lord:
      VMSPLIT config options

Mark Rustad:
      PCI: restore 2 missing pci ids

Martin Drab:
      [ALSA] bt87x - Fix the unability of snd-bt87x to recognize AVerMedia Studio

Martin Gingras:
      USB: pl2303: Added support for CA-42 clone cable

Martin Waitz:
      DocBook: allow even longer return types
      DocBook: fix some kernel-doc comments in net/sunrpc
      DocBook: fix some kernel-doc comments in fs and block

Matt Porter:
      [ALSA] hda-codec - add D975XBK support to sigmatel patch
      [ALSA] hda-codec - add sigmatel 927x codec support
      [ALSA] hda: sigmatel fixes

Matthew Dharm:
      USB: usb-storage: Add support for Rio Karma

Matthew Dobson:
      slab: extract slab_destroy_objs()
      slab: extract slab_{put|get}_obj

matthieu castet:
      [PNPACPI] Ignore devices that have no resources
      [PNPACPI] clean excluded_id_list[]
      UEAGLE : add iso support
      UEAGLE : cosmetic
      UEAGLE : cmv name bug (was cosmetic)

Michael Chan:
      [TG3]: Refine nvram locking
      [BNX2]: Fix VLAN on ASF
      [BNX2]: Improve handshake with firmware
      [BNX2]: Misc. fixes
      [BNX2]: Fix UDP checksum verification
      [BNX2]: Workaround hw interrupt bug
      [BNX2]: Fix nvram sizing
      [BNX2]: Use netdev_priv()
      [BNX2]: Add PHY loopback test
      [BNX2]: Update version and copyright year

Michael Reed:
      [SCSI] fusion: FC rport code fixes

Michael S. Tsirkin:
      IPoIB: Make sure path is fully initialized before using it
      IB/uverbs: Flush scheduled work before unloading module
      IB/sa_query: Flush scheduled work before unloading module
      IPoIB: Lock accesses to multicast packet queues
      IB/mthca: Use correct GID in MADs sent on port 2
      IB/mthca: Relax UAR size check
      IB/mthca: Don't cancel commands on a signal

Mikael Pettersson:
      ide-scsi: fix for IDE probe/remove ops changes

Mike Habeck:
      [IA64-SGI] pass segment# on SN_SAL_IOIF_SLOT_{DIS,EN}ABLE calls

Miklos Szeredi:
      fuse: fix async read for legacy filesystems

Moore, Eric:
      [SCSI] scsi_transport_sas.c: display port identifier
      [SCSI] fusion: add support for raid hot add/del support
      [SCSI] fusion: target reset when drive is being removed
      [SCSI] fusion: move sas persistent event handling over to the mptsas module
      [SCSI] fusion: bump version
      [SCSI] fusion: spi bus reset when driver loads
      [SCSI] fusion: mptsas, increase discovery timout to 300 seconds
      [SCSI] fusion: increase reply frame size from 0x40 to 0x50 bytes
      [SCSI] fusion: add verbose messages for RAID actions
      [SCSI] fusion: overrun tape fix
      [SCSI] fusion: add task managment response code info
      [SCSI] fusion: unloading the driver results in panic - fix
      [SCSI] fusion: unloading the driver - only set asyn narrow for configured devices
      [SCSI] fusion: add message sanity check

Nate Diller:
      [BLOCK] elevator: default choice selection
      [BLOCK] elevator: allow default scheduler to potentially be modular

Nathan Scott:
      [XFS] Fix regression in xfs_buf_rele dealing with non-hashed buffers, as

NeilBrown:
      nfsd: remove inline from a couple of large NFS functions
      knfsd: Fix some more errno/nfserr confusion in vfs.c
      md: Fix device-size updates in md
      md: Make sure array geometry changes persist with version-1 superblocks
      md: Don't remove bitmap from md array when switching to read-only
      md: Add sysfs access to raid6 stripe cache size

Nick Piggin:
      [CASSINI]: dont touch page_count
      mm: migration page refcounting fix

Nicolas Pitre:
      [ARM] 3270/1: ARM EABI: fix sigreturn and rt_sigreturn
      [ARM] 3271/1: ARM EABI: fix calling of cmpxchg syscall emulation
      [ARM] 3272/1: fix kernel decompressor crash

Olaf Hering:
      mv643xx_eth: 2.6.16 needs ip.h and in.h
      USB: remove extra newline in hid_init_reports
      CONFIG_ISA does not make sense for CONFIG_PPC_PSERIES
      MODALIAS= for macio

Olaf Kirch:
      ipw2200: do not sleep in ipw_request_direct_scan

Olav Kongas:
      USB: isp116x-hcd: replace mdelay() by msleep()

Oliver Neukum:
      USB: cleanup of usblp
      USB: fix oops in acm disconnect

Oliver Weihe:
      [libata] sata_svw: add pci id

Paolo 'Blaisorblade' Giarrusso:
      uml: remove leftover from patch revertal
      uml: make daemon transport behave properly
      uml: networking - clear transport-specific structure
      uml: fix spinlock recursion and sleep-inside-spinlock in error path
      uml: sigio code - reduce spinlock hold time
      uml: avoid malloc to sleep in atomic sections
      uml: arch Kconfig menu cleanups
      uml: allow again to move backing file and to override saved location
      uml ubd code: fix a bit of whitespace
      uml: typo fixup
      uml: comments about libc-conflict guards
      uml: fix hugest stack users
      uml: fix "apples/bananas" typo
      uml: TT - SYSCALL_DEBUG - fix buglet introduced in cleanup
      uml: skas0-hold-own-ldt fixups for x86-64
      uml: some harmless sparse warning fixes
      uml: avoid "CONFIG_NR_CPUS undeclared" bogus error messages

Paolo Galtieri:
      mv643xx_eth: Fix dma_map/dma_unmap relations
      mv643xx_eth: Fix a NULL pointer dereference
      mv643xx_eth: Update dev->last_rx on packet receive

Pat Gefre:
      Altix ioc3: correct export call

Patrick Caulfield:
      device-mapper log bitset: fix endian

Patrick McHardy:
      [PKT_SCHED]: Handle SCTP/DCCP in sfq_hash
      [EBTABLES]: Handle SCTP/DCCP in ebt_{ip,log}
      [IPV4]: Always set fl.proto in ip_route_newports

Paul E. McKenney:
      RCU documentation fixes (January 2006 update)

Paul Fulghum:
      synclink_gt fix size of register value storage

Paul Janzen:
      mv643xx_eth: Fix handling of small, unaligned fragments

Paul Mundt:
      sh: SH4-202 microdev updates
      sh: Make peripheral clock frequency setting mandatory
      sh: Move TRA/EXPEVT/INTEVT definitions for reuse
      sh: Cleanup struct sh_cpuinfo for clock framework changes
      sh: unknown mach-type updates
      sh: drop maskpos from make_ipr_irq(), remove duplicate irq definitions
      sh: convert voyagergx to platform device, drop sh-bus
      sh: sh-sci clock framework updates
      sh: Add missing timers directory rule to build
      sh: machine_halt()/machine_power_off() cleanups
      sh/sh64: Fix bogus TIOCGICOUNT definitions

Pavel Machek:
      PCI Hotplug: fix up coding style issues
      PCI Hotplug: fix up Kconfig help text

Pavel Roskin:
      hostap: allow flashing firmware

Pekka Enberg:
      uml: compilation fix when MODE_SKAS disabled
      slab: reduce inlining
      slab: extract virt_to_{cache|slab}
      slab: rename ac_data to cpu_cache_get
      slab: replace kmem_cache_t with struct kmem_cache
      slab: fix kzalloc and kstrdup caller report for CONFIG_DEBUG_SLAB
      reiserfs: remove kmalloc wrapper
      reiserfs: use __GFP_NOFAIL instead of yield and retry loop for allocation

Per Liden:
      [TIPC] Updated link priority macros
      [TIPC] Provide real email addresses in MAINTAINERS
      [TIPC] Move ethernet protocol id to linux/if_ether.h
      [TIPC] Remove unused #includes
      [TIPC] Add help text for TIPC configuration option
      [TIPC] Group protocols with sub-options in Kconfig
      [TIPC] Avoid polluting the global namespace

Pete Zaitcev:
      iw_handler.h: SIOCSIWNAME -> SIOCSIWCOMMIT in comment
      USB: ub 03 Oops with CFQ
      USB: ub 04 Loss of timer and a hang
      USB: ub 05 Bulk reset

Peter Oberparleiter:
      s390: ccw_device_probe_console return value
      s390: Add missing memory constraint to stcrw()

Prarit Bhargava:
      [IA64-SGI] Older PROM WAR for device flush code
      [IA64-SGI] Add PROM feature set for device flush list

Rafael J. Wysocki:
      swsusp: use bytes as image size units
      swsusp: do not change log level during suspend/resume

Randy Dunlap:
      USB EHCI: fix gfp_t sparse warning
      tpm_infineon: fix printk format warning
      tpm_bios: needs more securityfs_ functions
      slab: fix sparse warning
      Doc/kernel-doc: add more usage info
      kernel-doc: clean up the script (whitespace)

Randy.Dunlap:
      mm/slab: add kernel-doc for one function

Rene Rebe:
      [ALSA] AMD cs5536 ID for cs5535audio

Richard Knutsson:
      pci: Schedule removal of pci_module_init

Richard Mortimer:
      [SPARC64]: Eliminate race condition reading Hummingbird STICK register

Robert Moore:
      [ACPI] ACPICA 20050916

Rocky Craig:
      IPMI: remove invalid acpi register spacing check

Roland Dreier:
      IB/mthca: Semaphore to mutex conversions

Roman Zippel:
      hfs: cleanup HFS+ prints
      hfs: cleanup HFS prints
      hfs: set correct ctime
      hfs: set correct create date for links
      hfs: set type/creator for symlinks

Rui Santos:
      USB: ftdi: Two new ATIK based USB astronomical CCD cameras

Russell King:
      [SERIAL] Fix serial8250 driver initialisation ordering
      [ARM] Convert request_irq+set_irq_type to request_irq with SA_TRIGGER
      [ARM] Remove CONFIG_BROKEN=y from defconfigs
      [ARM] Fix ioremap.c vfree type warning
      [SERIAL] Don't use ASYNC_ constants with the uart_port structure
      [SERIAL] Remove UPF_AUTOPROBE and UPF_BOOT_ONLYMCA
      [SERIAL] Make port->ops constant
      [SERIAL] Make uart_info flags a bitwise type
      [SERIAL] Fix UPF_ flag usage with uart_info->flags
      [SERIAL] Make uart_port flags a bitwise type
      [ARM] amba-clcd: Allow RGB555 and RGB565 with 16bpp

Sam Ravnborg:
      [NET]: Do not export inet_bind_bucket_create twice.

Sasha Khapyorsky:
      [ALSA] hda-codec - support for Agere's HDA soft modem

Sergei Shtylylov:
      USB: Au1xx0: replace casual readl() with au_readl() in the drivers

Sridhar Samudrala:
      [SCTP]: Fix potential race condition between sctp_close() and sctp_rcv().
      [SCTP]: Fix couple of races between sctp_peeloff() and sctp_rcv().

Stefan Bader:
      device-mapper log bitset: fix big endian find_next_zero_bit

Stelian Pop:
      [ALSA] sound/ppc/pmac.c typo

Stephen Hemminger:
      sky2: receive buffer alignment
      sky2: call pci_set_consistent_dma_mask
      sky2: version 0.12
      sky2: fix ram buffer for Yukon FE rev 2
      sky2: write barrier's
      sky2: don't bother clearing status ring elements
      sky2: optimize for 32 bit dma
      sky2: ratelimit error messages
      sky2: use kzalloc
      sky2: don't inline so much
      sky2: more conservative transmit locking
      sky2: 0.13 version
      skge: fix dma mask setup.
      [IRDA]: maintainer status
      b44: fix laptop carrier detect
      [BRIDGE]: Fix device delete race.

Stephen Rothwell:
      compat: fix compat_sys_openat and friends

Stephen Smalley:
      selinux: fix and cleanup mprotect checks
      selinux: change file_alloc_security to use GFP_KERNEL
      selinux: remove security struct magic number fields and tests

Steve French:
      [CIFS] Use fsuid (fsgid) more consistently instead of uid/gid in
      [CIFS] Kerberos and CIFS ACL support part 1
      [CIFS] Readpages and readir performance improvements - eliminate extra
      [CIFS] Add extended stats (STATS2) for total buffer allocations for
      [CIFS] Display large/small total buffer allocations in /proc/fs/cifs/Stats
      [CIFS] Avoid extra large buffer allocation (and memcpy) in cifs_readpages
      [CIFS] Fix typos in rfc1002pdu.h
      [CIFS] Minor cleanup to new cifs acl header.
      [CIFS] Fix cifs trying to write to f_ops
      [CIFS] Allow local filesize for file that is open for write to be updated
      [CIFS] Add worker function for Get ACL cifs style
      [CIFS] Fix typo
      [CIFS] Fix CIFS to recognize share mode security
      [CIFS] Remove compiler warning
      [CIFS] Fix oops in cifs_readpages caused by not checking buf_type in an
      [CIFS] Do not zero non-existent iovec in SendReceive response processing.
      [CIFS] Make cifs default wsize match what we actually want to send (52K
      Signed-off-by: Steve French <sfrench@us.ibm.com>
      [CIFS] Remove compiler warning

Steven Rostedt:
      slab: have index_of bug at compile time
      slab: cache_estimate cleanup

Sumant Patro:
      [SCSI] megaraid_sas: cleanup queue command path
      [SCSI] megaraid_sas: new template defined to represent each type of controllers

Takashi Iwai:
      [ALSA] via82xx - Add dxs_support for ASUS mobo
      [ALSA] Fix compilation without CONFIG_PNP
      [ALSA] emu10k1 - Fix silence problems after suspend
      [ALSA] emu10k1 - Fix the confliction of 'Front' control
      [ALSA] via82xx - Add dxs_support entry
      [ALSA] pcxhr - Fix the sample rate changes
      [ALSA] hda-codec - Add model entry for Sony VAIO
      [ALSA] ac97 - Suppress jack sense controls for Thinkpads
      [ALSA] ac97 - Fix CLFE channel setting of ALC850
      [ALSA] hda-codec - Fix capture on Sigmatel STAC92xx codecs
      [ALSA] via82xx - Add dxs_support entry for EpoX 9HEAI
      [ALSA] au88x0 - Fix a compile warning
      [ALSA] opl3sa2 - Fix conflict of driver name on sysfs
      [ALSA] sb16 - Fix duplicated PnP entry
      [IA64-SGI] sn_dma_alloc_coherent should use gfp flags
      [ALSA] via82xx - Add dxs entry for a FSC board
      [ALSA] wavefront - Fix a compile warning
      [ALSA] opti93x - Fix a compile warning
      [ALSA] serial-uart16550 - Fix a compile warning
      [ALSA] via82xx - Add dxs entry for P4M800/VIA8237R
      [ALSA] hda-codec - Fix max_channels computation for STAC92xx codecs
      [ALSA] intel8x0 - Add MCP51 PCI ID
      [ALSA] hda-codec - Fix typos in alc882 model table

Tetsuo Takata:
      [BLOCK] ll_rw_blk: fix setting of ->ordered on init
      [SCSI] Remove host template ordered_flush variable

Thomas Gleixner:
      hrtimers: fixup itimer conversion
      hrtimers: fix possible use of NULL pointer in posix-timers
      hrtimers: fix oldvalue return in setitimer
      hrtimers: add back lost credit lines
      hrtimers: set correct initial expiry time for relative SIGEV_NONE timers

Thomas Graf:
      [BONDING]: Remove CAP_NET_ADMIN requirement for INFOQUERY ioctl

Thomas Renninger:
      [CPUFREQ] _PPC frequency change issues
      [CPUFREQ] Get rid of userspace policy struct, make userspace gov _PPC safe.

Thomas Rosner:
      [ACPI] Disable C2/C3 for _all_ IBM R40e Laptops

Timothy Charles McGrath:
      [SERIAL] 8250 Documentation fix

Tony Lindgren:
      ARM: OMAP: 1/4 Fix clock framework to use clk_enable/disable
      ARM: OMAP: 2/4 Fix clock framework to use clk_enable/disable for omap1
      ARM: OMAP: 3/4 Fix clock framework to use clk_enable/disable for omap2
      ARM: OMAP: 4/4 Fix clock framework to use clk_enable/disable misc

Trond Myklebust:
      NLM: Fix arguments to NLM_CANCEL call
      NLM: Ensure that nlmclnt_cancel_callback() doesn't loop forever
      SUNRPC: Fix a lock recursion in the auth_gss downcall
      SUNRPC: rpc_timeout_upcall_queue should not sleep
      SUNRPC: Remove the deprecated function lookup_hash() from rpc_pipefs code
      SUNRPC: Move upcall out of auth->au_ops->crcreate()
      SUNRPC: Remove obsolete rpcauth #defines

Tsutomu Fujii:
      [SCTP]: Fix sctp_rcv_ootb() to handle the last chunk of a packet correctly.

Ulrich Drepper:
      vfs: *at functions: core
      vfs: *at functions: i386
      vfs: *at functions: x86_64
      prototypes for *at functions & typo fix

Ulrich Mueller:
      [ALSA] intel8x0 - Fix duplicate ac97_quirks entry

V. Ananda Krishnan:
      jsm: fix for high baud rates problem

Valdis.Kletnieks@vt.edu:
      orinoco_cs: tweak Vcc debugging messages

Venkatesh Pallipadi:
      [ACPI] Avoid BIOS inflicted crashes by evaluating _PDC only once
      [ACPI] IA64 ZX1 buildfix for _PDC patch

Vlad Yasevich:
      [SCTP]: Fix sctp_cookie alignment in the packet.
      [SCTP]: sctp doesn't show all associations/endpoints in /proc
      [SCTP]: Fix sctp_assoc_seq_show() panics on big-endian systems.
      [SCTP]: Fix bad sysctl formatting of SCTP timeout values on 64-bit m/cs.
      [SCTP]: Fix machine check/connection hang on IA64.
      [SCTP]: correct the number of INIT retransmissions
      [SCTP]: heartbeats exceed maximum retransmssion limit

Vojtech Pavlik:
      USB HID: add blacklist entry for HP keyboard

Wolfram Joost:
      mv643xx_eth: Request HW checksum generation only for IPv4

Wouter Paesen:
      USB: ftdi_sio: new PID for PCDJ DAC2

YAMAMOTO Takashi:
      nfsd: check error status from nfsd_sync_dir

Yasuyuki Kozakai:
      [NETFILTER] Makefile cleanup
      [NETFILTER] ip6tables: remove unused definitions
      [NETFILTER] ip6tables: whitespace and indent cosmetic cleanup

Yingping Lu:
      [XFS] Interim solution for attribute insertion failure during file

YOSHIFUJI Hideaki:
      [IPV6]: Preserve procfs IPV6 address output format

Yu Luming:
      [ACPI] fix acpi_os_wait_sempahore() finite timeout case (AE_TIME warning)

Yusuf Iskenderoglu:
      [libata] sata_promise: add pci id

Zhu Yi:
      ieee80211: Fix problem with not decrypting broadcast packets
      ieee80211: Fix iwlist scan can only show about 20 APs
      ieee80211: Fix A band min and max channel definitions
      ipw2100: Fix a gcc compile warning
      ipw2100: Fix setting txpower failed problem
      ipw2200: Fix "iwspy ethx off" causes kernel panic
      ipw2200: Fix sw_reset doesn't clear the static essid problem
      ipw2200: Fix a variable referenced after kfree() bug

Zinx Verituse:
      Input: sidewinder - fix an oops

Zoltan Menyhart:
      [IA64] Fix bug in ia64 specific down() function

