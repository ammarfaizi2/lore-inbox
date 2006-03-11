Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751208AbWCKX6V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751208AbWCKX6V (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Mar 2006 18:58:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751311AbWCKX6V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Mar 2006 18:58:21 -0500
Received: from smtp.osdl.org ([65.172.181.4]:23002 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751208AbWCKX6U (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Mar 2006 18:58:20 -0500
Date: Sat, 11 Mar 2006 15:58:12 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Linux v2.6.16-rc6
Message-ID: <Pine.LNX.4.64.0603111551330.18022@g5.osdl.org>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="21872808-1374638697-1142121492=:18022"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--21872808-1374638697-1142121492=:18022
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT


Ok, we're getting closer, although the 2.6.16 release certainly seems to 
drag out more than it should have.

Some of the worrisome bootup problems seem to have been resolved to a 
stupid build-time race, where we just generated an empty version string. 
Oops. 

The diffstat shows that the largest changes here are the ia64 defconfig 
updates, much of the rest really is pretty small, but all over the map. 
Some ocfs2 and 9pfs fixes and updates, and various driver and networking 
fixes.

The ShortLog (appended) gives a pretty good picture of it,

		Linus

---

Adam Belay:
      pnp bus type fix

Adrian Bunk:
      V4L/DVB (3337): Drivers/media/dvb/frontends/mt312.c: cleanups
      V4L/DVB (3341): Upstream sync - make 2 structs static
      add missing pm_power_off's
      arch/sh/Kconfig: don't source non-existing Kconfig files
      xtensa must set RWSEM_GENERIC_SPINLOCK=y

Alan Stern:
      USB: unusual_devs entry for Lyra RCA RD1080

Alessandro Zummo:
      [ARM] 3353/1: NAS100d: protect  nas100d_power_exit() with machine_is_nas100d()

Alexey Dobriyan:
      video1394: fix "return E;" typo
      V4L/DVB (3413): Typos grab bag of the month

Andi Kleen:
      i386: port ATI timer fix from x86_64 to i386 II
      block: disable block layer bouncing for most memory on 64bit systems

Andrew Fuller:
      USB: Wisegroup MP-8866 Dual USB Joypad

Andrew Morton:
      nommu: implement vmalloc_node()
      out_of_memory(): use of uninitialised
      out_of_memory() locking fix
      numa_maps-update fix
      percpu_counter_sum()
      3c509: bus registration fix

Andrew Vasquez:
      [SCSI] fc_transport: stop creating duplicate rport entries.

Antonino A. Daplas:
      neofb: Fix uninitialized value
      arcfb: Fix uninitialized value
      kyrofb: Fix uninitialized value
      arcfb: Fix dereference before NULL check
      s1d13xxxfb: Fix resource leak
      imsttfb: Fix resource leak
      savagefb: Fix kfree before use
      intelfb: Fix buffer overrun
      tdfxfb: Fix buffer overrun
      aty128fb: Fix array overrun
      radeonfb: Fix static array overrun

Arjan van de Ven:
      edac: disable a few sysfs files to avoid them becoming an ABI

Arnaldo Carvalho de Melo:
      [REQSK]: Don't reset rskq_defer_accept in reqsk_queue_alloc

Atsushi Nemoto:
      [MIPS] Use generic compat routines for readdir, getdents
      [MIPS] Use USECS_PER_SEC / HZ instead of tick_usec in do_gettimeofday.
      x86: fix potential jiffies overflow in timer_resume()
      time: add barrier after updating jiffies_64
      __get_unaligned() gcc-4 fix
      mtd: 64 bit fixes

Badari Pulavarty:
      ext3: fix nobh mode for chattr +j inodes

Bastian Blank:
      s390: fix match in ccw modalias

Benjamin Herrenschmidt:
      powerpc: vdso 64bits gettimeofday bug
      Add mm->task_size and fix powerpc vdso
      powerpc: Fix old g5 issues with windfarm
      powerpc: Fix windfarm_pm112 not starting all control loops
      powerpc: Expose SMT and L1 icache snoop userland features
      powerpc: incorrect rmo_top handling in prom_init
      windfarm license fix

Bjorn Helgaas:
      [IA64] gensparse_defconfig: turn on PNPACPI
      [IA64] don't report !sn2 or !summit hardware as an error
      [IA64] SGI SN drivers: don't report !sn2 hardware as an error

Brian King:
      [SCSI] sg: Remove aha1542 hack
      [SCSI] scsi: scsi command retries off by one fix

Catalin Marinas:
      [ARM] 3352/1: DSB required for the completion of a TLB maintenance operation

Chas Williams:
      [ATM]: keep atmsvc failure messages quiet

Chris Wright:
      update email address
      LSM mail list has moved

Christian Ehrhardt:
      s390: Increase spinlock retry code performance

Christoph Hellwig:
      [IA64-SGI] revert export sn_pcidev_info_get
      [SCSI] scsi: handle ->slave_configure return value
      [SCSI] megaraid_sas: fix physical disk handling
      remove __put_task_struct_cb export again

Christoph Lameter:
      Fix sys_migrate_pages: Move all pages when invoked from root
      remove_from_swap: fix locking
      time_interpolator: Use readq_relaxed() instead of readq().
      numa_maps: Fix potential crash on non IA64 platforms
      numa_maps update
      [IA64] Fix race in the accessed/dirty bit handlers
      vmscan: no zone_reclaim if PF_MALLOC is set
      slab: Node rotor for freeing alien caches and remote per cpu pages.

Cornelia Huck:
      s390: improve response code handling in chsc_enable_facility()

Daniele Venzano:
      Fix Wake on LAN support in sis900

Darren Jenkins:
      synclink_gt: make ->init_error signed

Dave Johnson:
      cramfs mounts provide corrupted content since 2.6.15

Dave Jones:
      x86 microcode driver vs hotplug CPUs.

David Brownell:
      USB: fix EHCI BIOS handshake
      pcmcia: add another ide-cs CF card id

David Gibson:
      powerpc: Fix incorrect pud_ERROR() message

David S. Miller:
      [TG3]: Fix Sun tg3 variant detection.
      [SUNSU]: Fix locking error in sunsu_stop_rx().
      [SPARC64]: Mark __ex_table section correctly.
      Wrong return value corrupts free object in e1000 driver

David Woodhouse:
      jffs2: avoid divide-by-zero

Dipankar Sarma:
      rcu batch tuning
      fix file counting

Dmitry Torokhov:
      Input: psmouse - disable autoresync

Dominik Brodowski:
      pcmcia: properly handle pseudo multi-function devices

Doug Warzecha:
      dcdbas: dcdbas_pdev referenced after platform_device_unregister on exit

Edgar Hucek:
      EFI: Fix gdt load

Eric Sandeen:
      [XFS] Don't map non-uptodate buffers in xfs_probe_cluster; also fixes

Eric Sesterhenn:
      chelsio: fix kmalloc failure in t1_espi_create

Eric Van Hensbergen:
      v9fs: fix bug in atomic create open fix
      v9fs: simplify fid mapping

Franck Bui-Huu:
      USB: lh7a40x gadget driver: Fixed a dead lock

Francois Romieu:
      via-velocity: fix memory corruption when changing the mtu
      8139cp: fix broken suspend/resume
      de2104x: prevent interrupt before the interrupt handler is registered
      de2104x: fix the TX watchdog

Gerald Schaefer:
      s390: fix strnlen_user return value

GOTO Masanori:
      x86: Fix i386 nmi_watchdog that does not trigger die_nmi

Greg KH:
      fix build breakage in eeh.c in 2.6.16-rc5-git5

Greg Kroah-Hartman:
      USB Serial: fix use-after-free bug in usb-serial core

Hans Verkuil:
      V4L/DVB (3354): Fix maximum for the saturation and contrast controls.

Harald Welte:
      pcmcia: CM4000, CM4040 Driver fixes

Hartmut Hackmann:
      V4L/DVB (3378): Restore power on defaults of tda9887 after tda8290 probe
      V4L/DVB (3395): Fixed Pinnacle 300i DVB-T support

Hendrik Schweppe:
      USB: visor.c id for gspda smartphone

Herbert Xu:
      [IPSEC] esp: Kill unnecessary block and indentation
      [IPSEC]: Kill post_input hook and do NAT-T in esp_input directly

Horms:
      [IA64] Document the "nomca" boot parameter

Horst Hummel:
      s390: dasd partition detection
      s390: dasd proc interface typo

Hugh Dickins:
      page_add_file_rmap(): remove BUG_ON()s
      fix pcmcia_device_probe oops

Ian Abbott:
      USB: ftdi_sio: new microHAM device IDs

Ian McDonald:
      [DCCP] ccid3: Divide by zero fix

Ingo Molnar:
      idle threads should have a sane ->timestamp value

Ivan Kokshaysky:
      alpha: fix IRQ handling lockup

Jack Steiner:
      [IA64-SGI] Make number of TIO nodes configurable
      Increase max kmalloc size for very large systems
      slab: allocate larger cache_cache if order 0 fails

Jan Beulich:
      kbuild: version.h should depend on .kernelrelease

Jan Blunck:
      s390: fix compile with VIRT_CPU_ACCOUNTING=n

Jean Delvare:
      Fix error handling in backlight drivers

Jeff Garzik:
      [libata] Disable FUA
      s2io: set_multicast_list bug

Jeff Kirsher:
      e1000: revert to single descriptor for legacy receive path

Jeff Mahoney:
      ocfs2: fix -Wformat warnings when building UML on x86-64
      ocfs2: complete failure recovery for nodemanager init
      reiserfs: fix unaligned bitmap usage

Jens Axboe:
      cfq-iosched: slice expiry fixups

Jes Sorensen:
      [IA64] show "SN Devices" menu only if CONFIG_SGI_SN
      [IA64] sysctl option to silence unaligned trap warnings

Jesper Juhl:
      NE2000 Kconfig help entry improvement

Jesse Allen:
      pcmcia: add id for AMB8110 PC Card

Joel Becker:
      ocfs2: Set .owner on masklog sysfs attributes.
      ocfs2: Respond to on-disk corruption in the extent map code.

Johannes Stezenbach:
      V4L/DVB (3385): Dvb: fix __init/__exit section references in av7110 driver

John Bowler:
      drivers/mtd/redboot.c: recognise a foreign byte sex partition table
      "drivers/mtd/redboot.c: recognise a foreign byte sex partition table" update

John Rose:
      powerpc: fix dynamic PCI probe regression

Jon Mason:
      dl2k: DMA freeing error

Jürgen E. Fischer:
      [SCSI] aha152x: fix variable use before initialisation and other bugs

KAMEZAWA Hiroyuki:
      memory-hotplug compile fix

Karsten Keil:
      i4l: add new PCI IDs for HFC-S PCI
      i4l: fix refcounting problem with ttyIx devices
      i4l: fix compatiblity issue with big endian systems

Karsten Suehring:
      V4L/DVB (3347): Pinnacle PCTV 40i: add filtered Composite2 input

Ken Chen:
      [IA64] cleanup in fsys.S

Kirill Korotaev:
      ext3: ext3_symlink should use GFP_NOFS allocations inside

Latchesar Ionkov:
      v9fs: fix atomic create open
      v9fs: fix for access to unitialized variables or freed memory

Linus Torvalds:
      Revert "x86_64: Only do the clustered systems have unsynchronized TSC assumption on IBM systems"
      ppc64: make sure to align stack pointer to 16 bytes at boot
      Fix "check_slabp" printout size calculation
      Add early-boot-safety check to cond_resched()
      Allocate 96 bytes for SCSI sense data reply
      slab: clarify and fix calculate_slab_order()
      Simplify fifo_open() locking logic
      slab: fix calculate_slab_order() for SLAB_RECLAIM_ACCOUNT
      Mark the pipe file operations static
      Linux 2.6.16-rc6

Manu Abraham:
      V4L/DVB (3340): Make a struct static

Marc Zyngier:
      Fix Specialix SX corruption

Marco Schluessler:
      V4L/DVB (3403): Workaround to fix initialization for Nexus CA

Mark Brown:
      Add missing ifdef for VIA RNG code

Mark Fasheh:
      ocfs2: remove pointless max journal size limit
      ocfs2: remove unused code
      ocfs2: remove non existing function prototypes
      ocfs2: fix orphan recovery deadlock
      ocfs2: use hlists for lockres hash
      powerpc: restore eeh_add_device_late() prototype stub

Martin Michlmayr:
      [MMC] au1xmmc: Fix compilation error by using platform_driver
      [MMC] au1xmmc: Fix linking error because mmc_rsp_type doesn't exist
      [MMC] au1xmmc: Fix a compilation warning ('status' is not used)
      [SERIAL] ip22zilog: Fix oops on runlevel change with serial console

Martin Schwidefsky:
      s390: iucv message limit for smsg

Matt Mackall:
      dac960: add disk entropy in request completions

Matthew Wilcox:
      [IA64] Fix pcibios_setup
      [SCSI] Fix uninitialised width and speed in sym2

Mattias Nordstrom:
      V4L/DVB (3382): Fix stv0297 for qam128 on tt c1500 (saa7146)

Mauro Carvalho Chehab:
      V4L/DVB (3300a): Removing personal email from DVB maintainers

Max Asbock:
      ibmasm: use after free fix

Michael Chan:
      [TG3]: Add DMA address workaround

Michael Ellerman:
      powerpc/iseries: Fix double phys_to_abs bug in htab_bolt_mapping

Michael Krufky:
      V4L/DVB (3336): Bt8xx documentation authors fix
      V4L/DVB (3352): Cxusb: fix lgdt3303 naming
      V4L/DVB (3399): ELSA EX-VISION 500TV: fix incorrect PCI subsystem ID

Michael Matz:
      fix kexec asm

Miklos Szeredi:
      fuse: fix bug in negative lookup

Nathan Scott:
      [XFS] Fix a realtime allocator regression introduced by an old iget race
      [XFS] Reduce stack use during quota mounts (caused a panic).  This

NeilBrown:
      md: Fix several raid1 bugs which cause a memory leak

Nick Piggin:
      smaps: hugepages fix
      smaps: shared fix

Olaf Hering:
      powerpc: fix NULL pointer in handle_eeh_events

Pat Gefre:
      Altix: more ioc3 cleanups and locking fixes
      Altix: small ioc4 oversight

Patrick McHardy:
      [NETFILTER]: nf_queue: don't copy registered rerouter data
      [NETFILTER]: nf_queue: check if rerouter is present before using it
      [NETFILTER]: nf_queue: fix rerouting after packet mangling
      [NETFILTER]: nf_queue: remove unnecessary check for outfn
      [NETFILTER]: nf_queue: fix end-of-list check
      [NETFILTER]: Restore {ipt,ip6t,ebt}_LOG compatibility

Paul Fulghum:
      tty buffering: comment out debug code

Paul Mackerras:
      powerpc: Fix might-sleep warning in program check exception handler
      powerpc: Turn off verbose debug output in powermac platform functions
      powerpc32: Fix timebase synchronization on 32-bit powermacs
      powerpc: Fix various syscall/signal/swapcontext bugs

Pavel Machek:
      serial core: work around sub-driver bugs

Pavel Roskin:
      pcmcia: Add macro to match PCMCIA cards by numeric ID and first vendor string
      pcmcia: avoid binding hostap_cs to Orinoco cards

Pete Zaitcev:
      ieee80211_rx.c: is_beacon

Peter Staubach:
      ramfs needs to update directory m/ctime on symlink

Phillip Susi:
      udf: fix uid/gid options and add uid/gid=ignore and forget options

Ralf Baechle:
      [MIPS] Use "=R" constraint to avoid compiler errors in cmpxchg().
      [MIPS] SMP: Fix initialization order bug.
      [MIPS] Fix atomic*_sub_if_positive return value.
      [SCSI] Delete duplicate driver template.
      [MIPS] Initialize S-cache function pointers even on S-cache-less CPUs.
      [MIPS] Fix build error on processors that don's support copy-on-write.
      [MIPS] Threaten removal of code for NEC DDB5074 and DDB5476 evaluation boards.
      [MIPS] A struct console.setup function may not be __init.
      [MIPS] Enable highmem for all MIPS32 and MIPS64 processors.
      [MIPS] Discard .exit.text at runtime.
      [MIPS] Momentum: Resurrect after things were moved around a while ago.
      [MIPS] Scatter a bunch of __init over tlbex.c.
      [MIPS] Undefine scr_writew and scr_readw in <asm/vga.h>.
      [MIPS] Always pass -msoft-float.

Randy Dunlap:
      [NET] compat ifconf: fix limits

Ricardo Cerqueira:
      V4L/DVB (3348): Fixed saa7134 ALSA initialization with multiple cards

Roland Dreier:
      IB/srp: Don't send task management commands after target removal

Roman Zippel:
      m68k: fix cmpxchg compile errors if CONFIG_RMW_INSNS=n

Russ Anderson:
      [IA64] Increase severity of MCA recovery messages
      [IA64] mca recovery return value when no bus check

Russell King:
      [SERIAL] Fix two bugs in parport_serial

Sam Ravnborg:
      [ATM]: [fore200e] fix section mismatch warnings
      de620: fix section mismatch warning

Shaohua Li:
      x86: cpu model calculation for family 6 cpu

Shaun Tancheff:
      USB: Gadget RNDIS fix alloc bug. (buffer overflow)

Stefan Seyfried:
      fix acpi_video_flags on x86-64

Stephen Hemminger:
      sky2: remove MSI support
      [BRIDGE]: fix crash in STP
      [BRIDGE]: port timer initialization
      [BRIDGE]: generate kobject remove event
      sky2: not random enough
      sky2: force early transmit interrupts
      sky2: truncate oversize packets

Stephen Smalley:
      selinux: tracer SID fix

Steve French:
      [CIFS] Always match oplock break (cache notification) to the right tcp

Sunil Mushran:
      ocfs2: added source addr to bind() in o2net_start_connect()

Takashi Iwai:
      alsa: fix error paths in snd_ctl_elem_add()

Tejun Heo:
      sata_sil: add board ID for 3512
      sata_sil: implement R_ERR on DMA activate FIS errata fix

Thomas Graf:
      [NETFILTER] ip_queue: Fix wrong skb->len == nlmsg_len assumption

Tim Small:
      edac: mark as experimental

Tony Lindgren:
      fix next_timer_interrupt() for hrtimer

Tony Luck:
      [IA64] die_if_kernel() can return
      [IA64] refresh default config files

Vladimir V. Saveliev:
      reiserfs: do not check if unsigned < 0

Yasunori Goto:
      memory hotadd: pgdat->node_present_pages fix

Zhang, Yanmin:
      [IA64] Delete a redundant instruction in unaligned_access

--21872808-1374638697-1142121492=:18022--
