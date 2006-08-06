Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750726AbWHFSgA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750726AbWHFSgA (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Aug 2006 14:36:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750796AbWHFSgA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Aug 2006 14:36:00 -0400
Received: from smtp.osdl.org ([65.172.181.4]:20119 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750726AbWHFSf7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Aug 2006 14:35:59 -0400
Date: Sun, 6 Aug 2006 11:35:52 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Linux v2.6.18-rc4
Message-ID: <Pine.LNX.4.64.0608061127070.5167@g5.osdl.org>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="21872808-487456943-1154889352=:5167"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--21872808-487456943-1154889352=:5167
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT


It's been a week since -rc3, so now we have a -rc4.

The diffstat (and the appended shortlog) tells the story: a lot of small 
fixes in various areas, mostly drivers. Input layer, infiniband, usb, net, 
sound, vlb. Some cpufreq and architecture updates. Also some audit rule 
improvements from Al & Amy.

Anyway, I'll be effectively offline for most of the following three weeks 
(vacations and a funeral), and while I hope to be able to update my tree 
every once in a while, I also asked Greg KH to maintain a git tree for any 
worthwhile fixes.

We're pretty far into the 2.6.18 release cycle, and things seem to be in 
reasonable shape, and Greg obviously is one of the stable kernel 
maintainers anyway, so this should not be all that intrusive. The biggest 
impact may be that the next few -rc's may be a bit sporadic.

Anyway, have fun, and if somebody sees a serious regression, keep Greg, 
Andrew and obviously the kernel mailing list informed,

		Linus

---
Adrian Bunk:
      V4L/DVB (4310): Saa7134: rename dmasound_{init, exit}
      drivers/char/pc8736x_gpio.c: unexport a static struct
      [CPUFREQ] X86_GX_SUSPMOD must depend on PCI
      [CPUFREQ] Make longhaul_walk_callback() static
      [NET]: skb_queue_lock_key() is no longer used.
      USB: fix the USB_GADGET_DUMMY_HCD dependencies
      NFS: make 2 functions static
      drivers/edac/edac_mc.h must #include <linux/platform_device.h>

Al Viro:
      introduce audit rules counter
      mark context of syscall entered with no rules as dummy
      don't bother with aux entires for dummy context
      take filling ->pid, etc. out of audit_get_context()

Alan Stern:
      USB: dummy-hcd: disable interrupts during req->complete
      USB: unusual_devs entry for Nokia 3250
      USB: UHCI: Don't test the Short Packet Detect bit

Alexander Zarochentsev:
      i_mutex does not need to be locked in reiserfs_delete_inode()

Alexey Dobriyan:
      [NETFILTER]: include/linux/netfilter_bridge.h: header cleanup
      [NET]: Fix more per-cpu typos
      debug_locks.h: add "struct task_struct;"
      Fix more per-cpu typos
      eicon: fix define conflict with ptrace

Amy Griffis:
      fix faulty inode data collection for open() with O_CREAT
      fix missed create event for directory audit
      fix oops with CONFIG_AUDIT and !CONFIG_AUDITSYSCALL
      fix audit oops with invalid operator

Ananda Raju:
      s2io driver bug fixes #1
      s2io driver bug fixes #2

Andi Kleen:
      x86_64: Fix backtracing for interrupt stacks

Andrew de Quincey:
      V4L/DVB (4291): Add dvbpll i2c device check.
      V4L/DVB (4292): Fix DISEQC regression
      V4L/DVB (4293): Fix unstable DISEQC behaviour on budget cards.
      V4L/DVB (4294): Fix broken tda665x PLL definition.
      V4L/DVB (4296): Remove stradis MODULE_DEVICE_INFO definition
      V4L/DVB (4311): Fix possible dvb-pll oops
      V4L/DVB (4322): Fix dvb-pll autoprobing

Andrew Morton:
      Input: wistron - fix section reference mismatches
      Input: fix list iteration in input_release_device()
      mce section fix
      synchronize_tsc() fixes
      invalidate_bdev() speedup
      disable debugging version of write_lock()
      fadvise() make POSIX_FADV_NOREUSE a no-op

Antonino A. Daplas:
      fbdev: statically link the framebuffer notification functions
      vt: printk: Fix framebuffer console triggering might_sleep assertion

Arjan van de Ven:
      lockdep: annotate pktcdvd natural device hierarchy
      inotify: fix deadlock found by lockdep
      [NET]: Remove lockdep_set_class() call from skb_queue_head_init().

Arthur Othieno:
      i386: fix CONFIG_EFI help
      nvidiafb: remove redundant CONFIG_PCI check

Badari Pulavarty:
      ext3 -nobh option causes oops

Benjamin Herrenschmidt:
      [POWERPC] Workaround Pegasos incorrect ISA "ranges"
      [POWERPC] Fix 32 bits warning in prom_init.c
      [POWERPC] Fix non-MPIC CHRPs with CONFIG_SMP set
      [POWERPC] Fix default clock for udbg_16550
      [POWERPC] Fix legacy_serial.c error handling on 32 bits
      [POWERPC] More offb/bootx fixes
      [POWERPC] Xserve G5 thermal control fixes
      [POWERPC] Add cpufreq support for Xserve G5

bert hubert:
      [CPUFREQ] Propagate acpi_processor_preregister_performance return value.

bibo, mao:
      IA64: kprobe invalidate icache of jump buffer

Bob Picco:
      [IA64] align high endpoint of VIRTUAL_MEM_MAP
      [IA64] fix show_mem for VIRTUAL_MEM_MAP+FLATMEM

Brent Casavant:
      sgiioc4: Always share IRQ

Brice Goglin:
      myri10ge - Write the firmware in 256-bytes chunks
      myri10ge - Fix spurious invokations of the watchdog reset handler

Catherine Zhang:
      [AF_UNIX]: Kernel memory leak fix for af_unix datagram getpeersec patch

Chandra Seetharaman:
      Process Events: Fix biarch compatibility issue. use __u64 timestamp
      cpu hotplug: replace __devinit* with __cpuinit* for cpu notifications
      cpu hotplug: fix hotplug cpu documentation for proper usage
      cpu hotplug: use hotplug version of registration in late inits

Chris Leech:
      [I/OAT]: Remove CPU hotplug lock from net_dma_rebalance

Chris Mason:
      fix reiserfs lock inversion of bkl vs inode semaphore
      reiserfs_write_full_page() should not get_block past eof

Christian Borntraeger:
      bug in futex unqueue_me

Christoph Hellwig:
      [NET]: Add netdev_alloc_skb().

Chuck Ebbert:
      ptrace: make pid of child process available for PTRACE_EVENT_VFORK_DONE

Daniel Drake:
      zd1211rw: Pass more management frame types up to host
      zd1211rw: Fix software encryption/decryption
      zd1211rw: Remove bogus assert
      usb-storage: Add US_FL_IGNORE_DEVICE flag; ignore ZyXEL G220F

Daniel Ritz:
      pcmcia: fix ioctl for GET_STATUS and GET_CONFIGURATION_INFO
      pcmcia: fix ioctl GET_CONFIGURATION_INFO for pcmcia_cards

Danny van Dyk:
      [POWERPC] PMAC_APM_EMU should depend on ADB_PMU

Darrel Goeddel:
      selinux: fix memory leak

Dave Jones:
      kbuild: fix typo in modpost

Dave Platt:
      USB: Additional PID for the ftdi_sio driver

David Brownell:
      genirq: {en,dis}able_irq_wake() need refcounting too
      [ARM] 3739/1: genirq updates:  irq_chip, add and use irq_chip.name
      USB: AT91 UDC updates, mostly power management
      USB: AT91 OHCI updates, mostly power management
      omap-rng build fix

David S. Miller:
      [ATALK]: Make CONFIG_DEV_APPLETALK a tristate.
      [TCP]: Process linger2 timeout consistently.
      [TG3]: Convert to netdev_alloc_skb
      [E1000]: Convert to netdev_alloc_skb
      [NET]: Kill the WARN_ON() calls for checksum fixups.
      [SECURITY]: Fix build with CONFIG_SECURITY disabled.

David Woodhouse:
      SCX200_ACB: eliminate spurious timeout errors

Dean Nelson:
      [IA64] make uncached allocator more node aware

Diego Calleja:
      [LAPB]: Fix windowsize check
      Fix BeFS slab corruption

Dmitry Torokhov:
      Input: remove accept method from input_dev
      Input: add start() method to input handlers
      Input: introduce input_inject_event() function
      Input: fm801-gp - fix use after free
      Input: libps2 - warn instead of oopsing when passed bad arguments
      Input: iforce - check array bounds before accessing elements
      Input: HID - fix potential out-of-bound array access
      Input: add missing handler->start() call
      Input: hiddev - use standard list implementation
      Input: keyboard - remove static variable and clean up initialization
      Input: keyboard - simplify emulate_raw() implementation
      Input: keyboard - change to use kzalloc
      Input: trackpoint - activate protocol when resuming
      Input: atkbd - restore repeat rate when resuming
      Input: ati_remote - relax permissions sysfs module parameters
      Input: ati_remote - add missing input_sync()
      Input: ati_remote - use msec instead of jiffies

Edwin Huffstutler:
      Input: ati_remote - make filter time a module parameter

Eric Sandeen:
      udf: initialize parts of inode earlier in create

Eric Van Hensbergen:
      9p: fix fid behavior on failed remove

Eric W. Biederman:
      machine_kexec.c: Fix the description of segment handling

Evgeniy Dushistov:
      ufs: ufs_get_locked_page() race fix
      ufs: handle truncated pages

Frederik Deweerdt:
      mdacon: fix __init section warnings

Geoff Levand:
      [POWERPC] Minor comment fix for misc_64.S

Greg Edwards:
      [IA64] add platform check to snsc driver init

Greg Kroah-Hartman:
      Revert "USB: convert usb class devices to real devices"
      Revert "USB: move usb_device_class class devices to be real devices"

Guido Guenther:
      rivafb/nvidiafb: race between register_framebuffer and *_bl_init

Hartmut Hackmann:
      V4L/DVB (4306): Support non interlaced capture by default for saa713x

Heiko Carstens:
      pi-futex: missing pi_waiters plist initialization

Henrik Kretzschmar:
      pcie: fix warnings when CONFIG_PM=n

Herbert Xu:
      [IPV6]: Audit all ip6_dst_lookup/ip6_dst_store calls
      [NET]: Fix ___pskb_trim when entire frag_list needs dropping

Horms:
      panic_on_oops: remove ssleep()

Ilpo JÃ¤rvinen:
      [PKT_SCHED] RED: Fix overflow in calculation of queue average
      [TCP]: Fixes IW > 2 cases when TCP is application limited

Ingo Molnar:
      ipc/msg.c: clean up coding style

Ishai Rabinovitz:
      IB/srp: Fix crash in srp_reconnect_target
      IB/srp: Work around data corruption bug on Mellanox targets

J. Bruce Fields:
      NLM/lockd: remove b_done

Jack Morgenstein:
      IB/uverbs: Avoid a crash on device hot remove

Jake Moilanen:
      [POWERPC] Use H_CEDE on non-SMT

Jamal Hadi Salim:
      [PKT_SCHED]: Return ENOENT if qdisc module is unavailable

James Courtier-Dutton:
      [ALSA] snd-emu10k1: Fixes ALSA bug#2190
      [ALSA] snd-emu10k1: Implement support for Audigy 2 ZS [SB0353]

James Morris:
      [TCP]: fix memory leak in net/ipv4/tcp_probe.c::tcpprobe_read()
      [SECURITY] secmark: nul-terminate secdata

Jan Blunck:
      fix vmstat per cpu usage

Jean Delvare:
      PCI: Unhide the SMBus on Asus PU-DLS

Jeremy Fitzhardinge:
      [CPUFREQ] [1/2] add __find_governor helper and clean up some error handling.
      [CPUFREQ] [2/2] demand load governor modules.

Jim Houston:
      fix cond_resched() fix

Johannes Berg:
      [POWERPC] fix up front-LED Kconfig
      [ALSA] aoa: feature gpio layer: fix IRQ access
      [ALSA] aoa: fix toonie codec
      [ALSA] make snd-powermac load even when it can't bind the device
      [ALSA] aoa: platform function gpio: ignore errors from functions that don't exist
      [ALSA] add MAINTAINERS entry for snd-aoa

Josh Triplett:
      Remove incorrect unlock_kernel from allocation failure path in coda_open()
      efs: Remove incorrect unlock_kernel from failure path in efs_symlink_readpage()
      efs: add entry for EFS filesystem to MAINTAINERS as Orphan
      ufs: remove incorrect unlock_kernel from failure path in ufs_symlink()
      Fix typo in MAINTAINERS: s/DEVICS/DEVICES/
      freevxfs: Add missing lock_kernel() to vxfs_readdir
      timer: Fix tvec_bases initializer
      NFS: Release dcache_lock in an error path of nfs_path

KAMEZAWA Hiroyuki:
      memory hotadd fixes: not-aligned memory hotadd handling fix
      memory hotadd fixes: change find_next_system_ram's return value manner
      memory hotadd fixes: find_next_system_ram catch range fix
      memory hotadd fixes: avoid check in acpi
      memory hotadd fixes: avoid registering res twice
      memory hotadd fixes: enhance collision check

Keith Owens:
      [IA64] sparse cleanups

Kim Oldfield:
      USB: New USB ID for Belkin Serial Adapter

Kristen Carlson Accardi:
      PCI Hotplug: add acpiphp to MAINTAINERS
      PCI: docking station: remove dock uevents

Li Yang:
      USB: Fix Freescale high-speed USB host dependency

Linas Vepstas:
      pSeries hvsi char driver null pointer deref
      pSeries: hvsi char driver janitorial cleanup

Linus Torvalds:
      Fix force_sig_info() semantics after cleanups
      Linux v2.6.18-rc4

Luiz Fernando N. Capitulino:
      USB: doc: usb-help.txt update.
      USB: doc: fixes devio.c location in proc_usb_info.txt.

Marco Schluessler:
      V4L/DVB (4295): Fix typo in comment for TDA9819

Marko Macek:
      USB: ati_remote.c: autorepeat fix

Markus Armbruster:
      Fix trivial unwind info bug

Masami Hiramatsu:
      kprobe-booster: disable in preemptible kernel

Matthew Wilcox:
      [IA64] Format /proc/pal/*/version_info correctly

Matthias Urlichs:
      USB: Option driver: removed change history and linux/version.h include
      USB: Option driver: Short driver names were identical
      USB: Let option driver handle Anydata CDMA modems. Remove anydata driver.
      USB: Drop Sierra Wireless MC8755 from the Option driver
      USB: Removed 3-port device handler from Option driver

matthieu castet:
      pnpacpi: reject ACPI_PRODUCER resources

Mattia Dongili:
      [CPUFREQ] return error when failing to set minfreq

Mauro Carvalho Chehab:
      V4L/DVB (4341): VIDIOCSMICROCODE were missing on compat_ioctl32
      V4L/DVB (4342): Fix ext_controls align on 64 bit architectures
      V4L/DVB (4343): Fix for compilation without V4L1 or V4L1_COMPAT
      V4L/DVB (4344): Fix broken dependencies on media Kconfig
      V4L/DVB (4365): OVERLAY flag were enabled by mistake

Maxime Bizon:
      doc: update panic_on_oops documentation

Michael Buesch:
      hwrng: fix intel probe error unwind
      hwrng: fix geode probe error unwind

Michael Ellerman:
      [POWERPC] Fix mem= handling when the memory limit is > RMO size

Michael Hanselmann:
      powermac: More powermac backlight fixes

Michael Krufky:
      V4L/DVB (4314): Set the Auxiliary Byte when tuning LG H06xF in analog mode
      V4L/DVB (4316): Check __must_check warnings

Michael S. Tsirkin:
      IB/mthca: Fix mthca_array_clear() thinko

Michal Feix:
      nbd: Check magic before doing anything else
      nbd: Abort request on data reception failure

Michal Schmidt:
      IDE: Touch NMI watchdog during resume from STR

Mike Isely:
      V4L/DVB (4337): Refine dead code elimination in pvrusb2
      V4L/DVB (4373): Correctly handle sysfs error leg file removal in pvrusb2

Miklos Szeredi:
      fuse: fix zero timeout
      fuse: use jiffies_64
      fuse: fix typo

Miles Bader:
      v850: Remove symbol exports which duplicate global ones
      v850: call init_page_count() instead of set_page_count()

Muli Ben-Yehuda:
      x86_64: Fix CONFIG_IOMMU_DEBUG

Neil Brown:
      ext3: avoid triggering ext3_error on bad NFS file handle
      knfsd: fix race related problem when adding items to and svcrpc auth cache

Neil Horman:
      sh: fix proc file removal for superh store queue module

NeilBrown:
      knfsd: Fix stale file handle problem with subtree_checking.
      md: Fix a bug that recently crept into md/linear

Nick Martin:
      Input: spaceball - make 4000FLX Lefty work

Noriaki TAKAMIYA:
      [IPV6] ADDRCONF: Allow user-space to specify address lifetime
      [IPV6] ADDRCONF: Support get operation of single address
      [IPV6] ADDRCONF: NLM_F_REPLACE support for RTM_NEWADDR

Norihiko Tomiyama:
      USB: adding support for SHARP WS003SH to ipaq.c

Olaf Hering:
      [POWERPC] force 64bit mode in fwnmi handlers to workaround firmware bugs
      enable mac partition label per default on pmac
      hide onboard graphics drivers on G5
      crash in aty128_set_lcd_enable() on PowerBook

Oliver Bock:
      USB: cypress driver comment updates

Oliver Endriss:
      V4L/DVB (4323): [budget/budget-av/budget-ci/budget-patch drivers] fixed DMA start/stop code

Ondrej Zary:
      Fix swsusp with PNP BIOS

Or Gerlitz:
      IB/ipoib: Remove broken link from Kconfig and documentation

Panagiotis Issaris:
      [ALSA] Conversions from kmalloc+memset to k(z|c)alloc

Patrick Caulfield:
      [DECNET]: Fix for routing bug

Patrick McHardy:
      [XFRM]: Fix protocol field value for outgoing IPv6 GSO packets
      [NETFILTER]: SIP helper: expect RTP streams in both directions
      [NETFILTER]: xt_hashlimit/xt_string: missing string validation

Pete Zaitcev:
      Typo in ub clause of devices.txt

Peter Chubb:
      USB: Patch for rtl8150 to fix unplug problems

Peter Korsgaard:
      Fix ppc32 zImage inflate

Phil Dibowitz:
      USB: unusual_devs device removal

Pierre Ossman:
      PNP: Add missing casts in printk() arguments

Prarit Bhargava:
      Fix RAID5 + IA64 compile

Przemek Iskra:
      Input: iforce - add Trust Force Feedback Race Master support

Qi Yong:
      gitignore: gitignore quilt's files

Rafael J. Wysocki:
      Make suspend possible with a traced process at a breakpoint

Rafa³ Bilski:
      [CPUFREQ] Longhaul - Hook into ACPI C states.
      [CPUFREQ] Longhaul - Workaround issues with APIC.
      [CPUFREQ] Longhaul - Initialise later.
      [CPUFREQ] Longhaul - Readd accidentally dropped line
      [CPUFREQ] Longhaul - Fix power state test to do something more useful
      [CPUFREQ] Longhaul - Rename & fix multipliers table

Randy Dunlap:
      Input: serio/gameport - check whether driver core calls succeeded
      V4L/DVB (4298): Check all __must_check warnings in bttv.
      fix kernel-api doc for kernel/resource.c
      kernel-doc: ignore __devinit
      pci/search: cleanups, add to kernel-api.tmpl
      Doc/SubmittingPatches cleanups
      update KJ details
      PCIE: cleanup on probe error
      PCI: pci/search: EXPORTs cannot be __devinit

Ricardo Cerqueira:
      V4L/DVB (4313): Bugfix for keycode calculation on NPG remotes

Roberto Castagnola:
      Input: logips2pp - fix button mapping for MX300

Rodolfo Giometti:
      au1100fb: info->var.rotate fix
      au1100fb: Fix startup sequence

Roland Dreier:
      IB/mthca: Clean up mthca array index mask

Roland McGrath:
      vDSO hash-style fix

Rolf Eike Beer:
      Add DocBook documentation for workqueue functions
      Fix kmem_cache_alloc() been documented twice

Roman Zippel:
      kconfig: correct oldconfig for unset choice options

Russ Ross:
      9p: fix marshalling bug in tcreate with empty extension field

Sam Ravnborg:
      kbuild: hardcode value of YACC&LEX for aic7-triple-x
      kbuild: version.h and new headers_* targets does not require a kernel config
      kbuild: .gitignore utsrelease.h
      kbuild: improve error from file2alias
      kbuild: -fno-stack-protector is not good
      kbuild: always use $(CC) for $(call cc-version)

Sean Hefty:
      IB/cm: Fix error handling in ib_send_cm_req

Segher Boessenkool:
      [POWERPC] Fix new interrupt code (MPIC endianness)
      [POWERPC] Fix new interrupt code (MPIC detection)

Sergei Shtylylov:
      Stop calling phy_stop_interrupts() twice

Shailabh Nagar:
      make taskstats sending completely independent of delay accounting on/off status
      taskstats: free skb, avoid returns in send_cpu_listeners
      delay accounting: temporarily enable by default

Siddha, Suresh B:
      sched: build_sched_domains() fix

Stefan Richter:
      ieee1394: sbp2: enable auto spin-up for Maxtor disks

Stephen Hemminger:
      [BRIDGE]: netlink status fix
      [LLX]: SOCK_DGRAM interface fixes

Steven Rostedt:
      fix bad macro param in timer.c
      Add linux-mm mailing list for memory management in MAINTAINERS file
      reference rt-mutex-design in rtmutex.c
      Add stable branch to maintainers file

Takashi Iwai:
      [ALSA] Don't reject O_RDWR at opening PCM OSS with read/write-only device

Thomas Gleixner:
      futex: Apply recent futex fixes to futex_compat

Thomas Horsley:
      documentation: Documentation/initrd.txt

Tim Chen:
      Reducing local_bh_enable/disable overhead in irqtrace

Tobias Klauser:
      arch/alpha: Use ARRAY_SIZE macro

Tom Tucker:
      [NET]: Network Event Notifier Mechanism.
      [NET]: Core net changes to generate netevents
      [NET] infiniband: Cleanup ib_addr module to use the netevents

Tony Lindgren:
      [ARM] 3743/1: ARM: OMAP: Fix compile for OMAP

Tony Luck:
      [IA64] Fix breakage in simscsi.c

Trent Piepho:
      V4L/DVB (4367): Videodev: Handle class_device related errors
      V4L/DVB (4368): Bttv: use class_device_create_file and handle errors
      V4L/DVB (4379): Videodev: Check return value of class_device_register() correctly
      V4L/DVB (4380): Bttv: Revert VBI_OFFSET to previous value, it works better

Trond Myklebust:
      RPC: Ensure that we disconnect TCP socket when client requests error out
      SUNRPC: Fix obvious refcounting bugs in rpc_pipefs.

Ulrich Kunitz:
      zd1211rw: Fixes radiotap header
      zd1211rw: Fixed endianess issue with length info tag detection
      zd1211rw: Packet filter fix for managed (STA) mode

Unicorn Chang:
      ahci: skip protocol test altogether in spurious interrupt code

Uwe Zeisberger:
      Add parentheses around arguments in the SH_DIV macro.

Venkat Yekkirala:
      selinux: fix bug in security_compute_sid

Volker Braun:
      radeonfb sleep fixes

Wei Dong:
      [IPV6]: SNMPv2 "ipv6IfStatsInHdrErrors" counter error
      [IPV6]: SNMPv2 "ipv6IfStatsOutFragCreates" counter error

Wei Yongjun:
      [TCP]: SNMPv2 tcpAttemptFails counter error

Yoichi Yuasa:
      always define IRQ_PER_CPU

YOSHIFUJI Hideaki:
      [IPV6] ADDRCONF: Check payload length for IFA_LOCAL attribute in RTM_{ADD,DEL}MSG message
      [IPV6] ADDRCONF: Do not verify an address with infinity lifetime

Zou Nan hai:
      [IA64] Do not assume output registers be reservered.
      [IA64] Don't alloc empty frame in ia64_switch_mode_phys

--21872808-487456943-1154889352=:5167--
