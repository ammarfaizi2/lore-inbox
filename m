Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268510AbTBOBFy>; Fri, 14 Feb 2003 20:05:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268514AbTBOBFx>; Fri, 14 Feb 2003 20:05:53 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:55570 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S268510AbTBOBFW>; Fri, 14 Feb 2003 20:05:22 -0500
Date: Fri, 14 Feb 2003 17:11:43 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Linux v2.5.61
Message-ID: <Pine.LNX.4.44.0302141709410.1376-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hmm.. Mostly a lot of smallish things all over. Network drivers from Jeff,
updates from Andrew, Alan and Dave, and acpi/sparc/networking updates.

		Linus


Summary of changes from v2.5.60 to v2.5.61
============================================

<bbosch@iphase.com>:
  o [netdrvr ns83820] big endian fixes

<dave@thedillows.org>:
  o The initial release of the driver for the 3Com 3cr990 "Typhoon"
    series of network interface cards.

<ionut@badula.org>:
  o starfire driver update for 2.5.60

<jochen@scram.de>:
  o [tokenring smctr] fix MAC address input
  o [tokenring madgemc] fix mem leaks, add proper refcounting
  o Update several token ring drivers

<kare.sars@lmf.ericsson.se>:
  o [atm nicstar] fix incorrect traffic class assumption

<latten@austin.ibm.com>:
  o [IPSEC]: Make AF_KEY allow NULL encryption

<meissner@suse.de>:
  o [netdrvr pcnet32] fix multicast on big endian

Roland McGrath <roland@frob.com>:
  o Ctrl-C-ing strace

<toml@us.ibm.com>:
  o [IPSEC]: Make sure to clear sin_zero in AF_KEY
  o [IPSEC] Make sure SADB_X_SPDADD messages have proper spid

<zinx@epicsol.org>:
  o input: Add support for ThrustMaster ForceFeedback USB HID devices

Alan Cox <alan@lxorguk.ukuu.org.uk>:
  o Remove i2o-lan
  o Make mca-legacy bitch at users
  o Fix cciss scsi breakage
  o Fix 3036 tuner
  o Fix i2o_scsi (submission from Randy)
  o Fix scsi parts of iph5526
  o Make starfire compile
  o Fix aha1740
  o Fix fd_mcs build for scsi changes, mca compt
  o Fix ibm MCA adapter for new scsi, use mca_legacy for now
  o Fix ppa for new scsi
  o Fix NCR53c406a for new scsi
  o Fix seagate for new scsi
  o Fix sym53c416 for new scsi
  o Fix ultrastor for new scsi
  o Fix wd7000 for new scsi
  o New drivers needing mca-legacy for now

Andi Kleen <ak@muc.de>:
  o x86-64 merge

Andrew Morton <akpm@digeo.com>:
  o Fix synchronous writers to wait properly for the result
  o ncpfs compile fix
  o de4x5 compile fix
  o uninline get_jiffies_64() for 32-bit architectures
  o use per-cpu data for ia32 profiler
  o NUMAQ io_apic programming fix
  o ext3: Remove journal_try_start()
  o DAC960 Stanford Checker fix
  o Add David Olien MAINTAINERs for DAC960
  o nforce2 IDE support for the amd74xx driver
  o hugetlbpage MAP_FIXED fix
  o remove unneeded test from radix_tree_extend()
  o ext3 commenting cleanup
  o Don't run unlock_super() in ext3_fill_super()
  o remove the buffer_head mempool
  o fix current->user->processes leak
  o 3c509 compile fix
  o Get 3c59x to compile on non-PCI systems
  o sched_init enables interrupts too early
  o genhd warnings fix
  o kill warning in vmscan.c
  o kill some ppc64 warnings in knfsd
  o fix ppc64 wanings in fs/partitions/check.c
  o fix ppc64 nfs warning
  o fs/reiserfs/hashes.c warning fix
  o fix drivers/scsi/st.c warning
  o provide uniproc write_trylock()
  o disassociate_ctty SMP fix
  o make the adaptec driver compile
  o sunrpc dcache cleanup
  o jiffies wrap fixes
  o EATA driver fix
  o make drivers/net/arlan.c compile again
  o Allow summit kernels to boot on normal systems
  o Make drivers/media/video/saa7110.c compile
  o drivers/media/video/saa5249.c compile fix
  o fix fadvise64() return type
  o OSS CS4232 locking fixes
  o epoll timeout and syscall return types
  o MAP_FIXED|MAP_ANON crash fix
  o u14-34f fix
  o fix adaptec diagnostics for ppc64
  o printk size_t qualifier confusion
  o set unplug_timer.function inside blk_queue_make_request
  o make imm.c build
  o fix hugetlbfs_forget_inode() oddity
  o sysfs error handling fix
  o ia32 TSC timer cleanup
  o Cyclone timer fixes
  o Enable timer_cyclone code
  o hugetlbfs i_size fix
  o xattr: lock_kernel() balancing fix
  o ACPI sleep build fix

Andrey Panin <pazke@orbita1.ru>:
  o [netdrvr eepro100] add PIO config option

Andries E. Brouwer <andries.brouwer@cwi.nl>:
  o signal error return fix
  o genhd device unregistration fix
  o nfs fix

Andy Grover <agrover@groveronline.com>:
  o ACPI: fix compile on IA64 (Matthew Wilcox)
  o ACPI: Lower errorlevel of a debug message (Matthew Wilcox)
  o ACPI: Fix whitespace (Pavel Machek)
  o ACPI: Fix some compilation issues

Arnaldo Carvalho de Melo <acme@conectiva.com.br>:
  o [SUNZILOG]: fix DEVFS device name

Art Haas <ahaas@airmail.net>:
  o [NETFILTER]: C99 initializers for net_ipv4_netfilter
  o [NETFILTER]: C99 initializers for net_ipv6_netfilter
  o C99 initializers for net/ipv6/sysctl_net_ipv6.c
  o C99 initializers for net/core/sysctl_net_core.c
  o C99 initializers for net/ipv4/sysctl_net_ipv4.c
  o C99 initializers for net/sunrpc/sysctl.c
  o C99 initializers for net/unix/sysctl_net_unix.c
  o C99 initializers for net/ipv4/netfilter files
  o C99 initializers for net/sctp/sysctl.c
  o C99 initializers for net/ipv6/netfilter/ip6_queue.c
  o C99 initializers for net/ax25/sysctl_net_ax25.c
  o C99 initializers for net/irda/irsysctl.c

Dave Jones <davej@codemonkey.org.uk>:
  o [AGPGART] Merge VIA KT400 AGP3 support into main via-agp module
  o [WATCHDOG] PNP API conversion
  o [AGPGART] Remove unneeded AMD8151 shadowing in the K8 GART driver
  o [AGPGART] Cache K8 northbridges pci_devs instead of scanning whole
    PCI bus
  o [CPUFREQ] Properly set memory allocated by x86 cpufreq drivers to
    zero
  o [CPUFREQ] add support for cpufreq governors
  o [CPUFREQ] fix longrun min/max confusion
  o [WATCHDOG] pcwd.c: if cpu has overheated, we want to shutdown, not
    panic
  o [WATCHDOG] printk levels for pcwd.c
  o [WATCHDOG] More panic -> shutdown replacements in pcwd.c
  o [WATCHDOG] missing printk level in acquirewdt
  o [WATCHDOG] printk levels for alim7101_wdt.c
  o [WATCHDOG] C99 struct initialisers for sc1200wdt
  o [WATCHDOG] fix sc1200wdt for CONFIG_PNP=n
  o [WATCHDOG] C99 struct intiialisers for remaining drivers
  o [WATCHDOG] Remove unneeded EXPORT_NO_SYMBOLS from sc1200wdt
  o [CPUFREQ] Add powernow-k7 driver for AMD mobile Athlon/Duron CPUs
  o [WATCHDOG] Merge sma cpu5 watchdog driver
  o [WATCHDOG] Remove unneeded includes & EXPORT_NO_SYMBOLS from
    cpu5wdt
  o [AGPGART] Export needed symbols for AMD K8 GART
  o [CPUFREQ] powernow-k7.c: Zeropad the VID or we get 1.50V instead of
    1.050V
  o ES1370 OSS fix
  o ES1371 OSS fix
  o improve K7 SMP tainting
  o VIA C3 Nehemiah cachesize errata fix
  o fix sigio on tty drivers outgoing
  o nvram driver uses incorrect types in llseek method
  o i2c namespace pollution
  o nwflash driver uses wrong types in llseek methods
  o proc_file_read documentation/buffer overflow detection
  o nec vrc5477 oss driver update
  o Missing maintainer
  o VIA C3 Nehemiah support
  o OSS rme96xx update
  o [CPUFREQ] powernow-k7.c: Fix incorrect multiplier
  o [AGPGART] remove panic() from intel-agp, replace with no setup, and
    failure propagate
  o [netdrvr sunqe] remove incorrect kfree()
  o [netdrvr sungem] be verbose about RX MAC fifo overflow
  o [netdrvr sunbmac] probe path cleanup
  o [AGPGART] Fix up lots of 'comparison between signed and unsigned'
    warnings
  o [AGPGART] Fix same logic bug in KT400 mode determination
  o [AGPGART] Don't oops when deregistering failed to init agp modules
  o [AGPGART] Handle the "KT400 in disguise as a KT266" case
  o [AGPGART] Handle failure during initialisation more gracefully
  o [AGPGART] Add ident for VIA KT400 in disguise as a KT266
  o [AGPGART] More failure path sanity checking
  o [AGPGART] VIA KT400 Aperture size is 12 bit in AGP3 mode
  o [AGPGART] kt400's enable routine can't be __init
  o [AGPGART] alpha agp infrastructure
  o [AGPGART] First step towards multiple AGP buses
  o [AGPGART] Add extra VIA GART IDs
  o [AGPGART] Additional VIA ids
  o [AGPGART] Fix missed agp_bridge conversion that caused oops
  o [AGPGART] Remove pointless enums from VIA GART driver
  o [AGPGART] Enable support for VIA PLE133 chipset

David Jeffery <david_jeffery@adaptec.com>:
  o ips: missing reboot notifier and Mode Sense P8
  o ips: 2.4 compatability code
  o ips: remove LinuxVersionCode
  o ips: use scsi_add_host

David S. Miller <davem@nuts.ninka.net>:
  o [IPV4]: Fix cut&paste error in fold_field
  o [SPARC64]: Add TCSBRKP ioctl translation, thanks Anton
  o [TULIP DE4X5]: Cannot use initdata before including linux/init.h
  o [TCP]: Do not bump backoff too high during 0-window probes
  o [SIGNAL]: Allow more platforms to use generic get_signal_to_deliver
  o [IPSEC]: Add missed bit of sin_zero fix
  o [IPSEC]: Fix mis-patch of previous changes
  o [IPSEC]: ipv6_syms needs net/xfrm.h
  o [IPSEC]: Fix af_key.c build
  o [IPSEC]: Mark pfkey_sadb_addr2xfrm_addr static again

David Woodhouse <dwmw2@infradead.org>:
  o Restore SYSENTER setup on swsusp resume

Ivan Kokshaysky <ink@jurassic.park.msu.ru>:
  o alpha: Add missing sighand bits

Jamal Hadi Salim <hadi@cyberus.ca>:
  o [SCHED GRED]: Another bug found by Stanford Checker

James Simmons <jsimmons@maxwell.earthlink.net>:
  o input: Remove include/linux/pc_keyb.h and old PS/2 code from
    drivers/char/misc.c

Jay Vosburgh <fubar@us.ibm.com>:
  o [netdrvr 3c59x] move netif_carrier_off() call outside vortex_debug
    test

Jean Tourrilhes <jt@hpl.hp.com>:
  o [irda][CORRECT] Properly initialise IrCOMM status line (DCE
    settings) <Patch from Jan Kiszka>
  o [irda] better poll bit handling during times of packet loss
  o [irda] rx/tx wrapper path rewrites and cleanup

Jeff Garzik <jgarzik@redhat.com>:
  o [netdrvr fc/iphase] correct PCI probe loop-end test logic [#323]
  o [tokenring smctr] remove stray ';' that prevented a loop from
    working [#312]
  o [netdrvr amd8111e] remove stray ';', fixing register dump [#311]
  o [netdrvr tg3] DMA MRM bit only exists on 5700, 5701
  o [netdrvr arlan] fix the fixed fix. really
  o [netdrvr bmac] Remove unneeded memset()

John Levon <levon@movementarian.org>:
  o oprofile: Pentium IV support
  o oprofile: CPU type as string
  o oprofile: fix oprofilefs integer files base
  o oprofile: kernel/user addresses fix

Jon Grimm <jgrimm@touki.austin.ibm.com>:
  o [SCTP] Don't retransmit Gap-Acked TSNs
  o [SCTP] Add get_paddrs/get_laddrs support.  (ardelle.fan)
  o [SCTP] Fix hardcoded stream counts
  o [SCTP] Add jitter to the heartbeat interval.  (ardelle.fan)
  o [SCTP] Turn off hearbeat timers earlier in shutdown
  o [SCTP] Fix merge conflicts
  o [SCTP] Mark as "unsafe" module.  Some dead code removal
  o [SCTP] Overlapping INIT check not right for case 'B'
  o [SCTP] Handle requests of 0 streams & missing state cookie
  o [SCTP] Remove __exit from sctp_proc_exit
  o [SCTP] Fix large message sends
  o [SCTP] IPV6_SCTP__ should be a tristate

Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>:
  o kbuild: sed compatibility fixes
  o kbuild: Handle the "no modules" case
  o kbuild: cosmetics
  o kbuild: Customflags for cmd_objcopy
  o kbuild: Allow for ',$ in commands
  o kbuild: scripts/fixdep.c doesn't close files when finished

Kunihiro Ishiguro <kunihiro@ipinfusion.com>:
  o [IPSEC]: Add ipv6 support infrastructure

Linus Torvalds <torvalds@home.transmeta.com>:
  o If we set TIF_SIGPENDING for SIGCONT, we have to wake up any
    sleeping tasks (even if we don't otherwise need to wake anything
    up), since
  o Missed initialization of "curr_target" in execve() dethreading case
  o Make dequeue_signal() take the process as an argument
  o Fix acl_set_handle() compile that got broken by the xattr updates.
  o Report shared pending signals in /proc/<pid>/status
  o Sanitize kernel daemon signal handling and process naming
  o Add macthing 'va_end()' to the 'va_start()' in daemonize()
  o Don't wake up processes unnecessarily for ignored signals
  o Linux 2.5.61

Oleg Drokin <green@angband.namesys.com>:
  o reiserfs: Move mark_buffer_uptodate in front of mark_buffer_dirty
    in resizer

Osamu Tomita <tomita@cinet.co.jp>:
  o input: Support for NEC PC-9800 beeper and support for Kana Lock LED

Patrick Mochel <mochel@osdl.org>:
  o sleep: fix /proc/acpi/sleep write handling
  o acpi sleep: move sleep support into own subdirectory
  o acpi: make source files look for headers in <acpi/ (top level
    files)
  o acpi: make source files look in <acpi/ (dispatcher files)
  o acpi: make source files look for headers in <acpi/...> (event
    files)
  o acpi: make source files look for headers in <acpi...> (executor
    files)
  o acpi: make source files look for headers in <acpi/...> (hardware
    files)
  o acpi: make source files look in <acpi/...> for headers (namespace
    files)
  o acpi: make source files look in <acpi/...> for headers. (parser
    files)
  o acpi: make source files look in <acpi/...> for headers (resources
    files)
  o acpi: make source files look in <acpi/...> for headers (tables
    files)
  o acpi: make source files look for headers in <acpi/...>
  o acpi: make headers look in <acpi/...> for other headers
  o acpi: make source files look in <acpi/...> for headers. (other
    top-level files)
  o acpi: remove some acpi-specific compiler definitions in favor of
    standard ones
  o acpi: fix recently introduced proc-related bugs
  o acpi: split sleep support into generic portion, and procfs-handlers
  o Consolidate ACPI and APM sysrq implementations
  o acpi sleep: divorce sleep functionality from power off
    functionality
  o acpi: Split i386 support up
  o acpi: Only build sleep directory if we have rest of bus support
  o acpi sleep: demote sleep proc file creation
  o acpi sleep: demote acpi_sleep_init() to a late_initcall
  o Fix up ACPI build issues

Pavel Machek <pavel@ucw.cz>:
  o Fix stack handling in acpi_wakeup.S

Pete Zaitcev <zaitcev@redhat.com>:
  o [SUNZILOG]: Fix TX and interrupt bugs
  o input: Let newly connected keyboards pickup the LED state
  o [SUNZILOG]: Fix off-by-1 in spinlock initialization loop

Randy Dunlap <randy.dunlap@verizon.net>:
  o ftape divide-by-zero found by Stanford Checker
  o bounds/limits fixes (Stanford Checker)

Randy Dunlap <rddunlap@osdl.org>:
  o checker bounds/limits fixes

Rob Radez <rob@osinvestor.com>:
  o [SPARC]: Move away from flush_page_to_ram
  o [SPARC]: HEAD --> HEAD_Y
  o [SPARC]: ADd init_sighand

Rusty Russell <rusty@rustcorp.com.au>:
  o [AF_UNIX] Cleanup forall_unix_sockets
  o [X25]: Fix improper | precendence, pointed out by Joern Engel
  o [ECONET]: Add comment to point out a bug spotted by Joern Engel

Sridhar Samudrala <sri@us.ibm.com>:
  o [SCTP] Changed 'bug' to a static variable. (Arnd Bergmann)
  o [SCTP] Handle non-linear ip re-assembled skb's in sctp_rcv()
  o [SCTP] Fix to correctly update rwnd for non-linear skbs
  o [SCTP] SCTP path mtu discovery support for v4 addresses
  o [SCTP] Free chunks in retransmit and control queues on
    outq_teardown()
  o [SCTP] Minor fixes to icmp error handler
  o [SCTP] Fix to update rwnd on partial reads
  o [SCTP] Cleanup of association bind address list initialization
  o [SCTP] Fix af->dst_saddr() to fill in the port
  o [SCTP] sctp v6 source address selection support

Stephen Rothwell <sfr@canb.auug.org.au>:
  o apm daemonize
  o [SPARC64]: sigprocmask/sigpending compat layer conversion
  o parisc compatibility layer update
  o x86_64 compatibility layer update

Tomas Szepe <szepe@pinerecords.com>:
  o export allow_signal()

Trond Myklebust <trond.myklebust@fys.uio.no>:
  o further rpc_pipefs cleanups
  o Clean up and fix SMP issue w.r.t. XID allocation

Vojtech Pavlik <vojtech@suse.cz>:
  o input: Update AT+PS/2 mouse and keyboard drivers
  o input: Only generate rawmode warnings if the event we cannot handle
    is a real key and not just a button or something.
  o input: Get rid of the kbd_pt_regs variable, and instead pass the
    value all the way from an interrupt handler to keyboard.c that can
    display it.
  o input: HID update
  o input.c: joydev/mousedev update
  o input: Give preferential treatment to gameport at 0x201, and use
    the odd addresses for access.
  o input: Resurrect usb_set_report for Aiptek and Wacom tablets
  o input: Add two new serio type #defines
  o input: sunkbd.c - fix reading beyond end of keycode array

William R. Sowerbutts <will@sowerbutts.com>:
  o input: PowerMate driver update


