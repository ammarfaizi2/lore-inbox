Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270517AbTGNDo2 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Jul 2003 23:44:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270518AbTGNDo2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Jul 2003 23:44:28 -0400
Received: from air-2.osdl.org ([65.172.181.6]:12500 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S270517AbTGNDoV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Jul 2003 23:44:21 -0400
Date: Sun, 13 Jul 2003 20:59:07 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Linux v2.6.0-test1
Message-ID: <Pine.LNX.4.44.0307132055080.2096-100000@home.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Ok,
 the naming should be familiar - it's the same deal as with 2.4.0.

One difference is that while 2.4.0 took about 7 months from the pre1 to 
the final release, I hope (and believe) that we have fewer issues facing 
us in the current 2.6.0. But very obviously there are going to be a
few test-releases before the real thing.

The point of the test versions is to make more people realize that they
need testing and get some straggling developers realizing that it's too
late to worry about the next big feature. I'm hoping that Linux vendors
will start offering the test kernels as installation alternatives, and
do things like make upgrade internal machines, so that when the real
2.6.0 does happen, we're all set.

		Linus

---

Summary of changes from v2.5.75 to v2.6.0-test1
============================================

<jcchen:icplus.com.tw>:
  o [netdrvr sundance] increase eeprom read timeout

<taowenhwa:intel.com>:
  o [e100] cu_start: timeout waiting for cu
  o [e100] misc

Alan Cox:
  o genrtc sets owner fields so
  o Remove bogus printk in microcode.c
  o clean up floppy98 a bit
  o dtlk comment fix
  o isurf compile fix
  o axnet can unload with timers live
  o ibmtr can unload with timers live
  o fix up nmclan locking and hang on eject at wrong moment
  o fix further timer in pcmcia stuff
  o Fix remaining g_NCR5380 use of check_region
  o not sure what the author was on
  o AC97 updates from 2.4
  o Add the au1000 driver
  o demo plugin for switching ad1980 ports Dell style
  o Fix security leaks in btaudio
  o Add the ALI5455 driver from 2.4
  o fix security leaks in cmpci
  o Update cs46xx in 2.5 to the newer 2.4 release
  o fix the security leak in dmasound
  o Switch the SB Live! to the new ac97 api
  o fix security leaks and a crash in es1370
  o bring es1371 in line with 2.4
  o fix security leak and crash in esssolo
  o Add Forte Media OSS driver
  o update ITE audio
  o update the i810 audio driver
  o switch maestro3 to new ac97
  o fix security leak in maestro.c
  o fix security leak in msnd_pinnacle.c
  o Add swarm driver for broadcom boards
  o update nec driver to new ac97
  o update trident driver for new ac97 etc
  o fix wrong printk in nm256 audio
  o update via audio driver, make it work on esd add new chips
  o more wrong strlcpy's
  o update ymfpci for new ac97
  o Merge AD1889 driver from 2.4

Alan Stern:
  o USB: Small correction to usb-skeleton.c
  o USB: Updates for unusual_devs.h

Andi Kleen:
  o Deprecate numerical sysctl
  o x86-64 fixes for 2.5.75

Andrew Morton:
  o fix return of compat_sys_sched_getaffinity
  o remove proc_mknod()
  o reiserfs dirty memory accounting fix
  o fix reiserfs for 64bit arches
  o wall_to_monotonic initialization fixes for
  o i_size atomic access: infrastructure
  o i_size atomic access
  o kmap() -> kmap_atomic() in fs/exec.c
  o make CONFIG_KALLSYMS default to "on"
  o misc fixes
  o Set umask correctly for nfsd kernel threads
  o Bug fix in AIO initialization
  o Fix race condition between aio_complete and
  o separate locking for vfsmounts
  o fix for CPU scheduler load distribution
  o NBD: cosmetic cleanups
  o nbd: enhanced diagnostics support
  o nbd: remove unneeded blksize_bits field
  o nbd: initialise the embedded kobject
  o nbd: cleanup PARANOIA usage & code
  o NBD documentation update
  o nbd: remove unneeded nbd_open/nbd_release and refcnt
  o nbd: make nbd and block layer agree about device and
  o JBD: checkpointing optimisations
  o JBD: transaction buffer accounting fix
  o ext3: sync_fs() fix
  o oom killer fixes
  o yenta-socket initialisation fix
  o Fix yenta-socket oops
  o devfs oops fix
  o devfs deadlock fix
  o epoll-per-fd fix

Andries E. Brouwer:
  o cryptoloop

Bernardo Innocenti:
  o asm-generic/div64.h breakage

Brian Gerst:
  o c99 initializers for init/version.c

Daniel Ritz:
  o more net driver timer fixes
  o net/pcmcia fix fast_poll timers (HZ > 100)

Dave Jones:
  o [AGPGART] Remove unneeded assignment
  o [AGPGART] Use defines for register bits in AMD K8 GART driver
  o [AGPGART] K8 GART driver doesn't need masks
  o [AGPGART] Ignore multiple K8 GARTS on UP
  o [AGPGART] Optimise PCI searching in K8 GART driver
  o [AGPGART] K8 Device 0x1103 is always at PCI_FUNC 3
  o [AGPGART] K8 North bridge bus position is no longer relevant
  o [AGPGART] HP AGP update
  o [AGPGART] Sort SiS device IDs
  o [AGPGART] SiS 746 support This (and a few other SiS chipsets) are
    AGP 3 compliant. AFAIK, none of these have been tested in AGP3
    mode, but they should work just fine in AGP2.x mode at least.
  o [AGPGART] SiS 648 support
  o [AGPGART] Make frontend sparse clean

David Brownell:
  o USB: usb_get_string(), don't use bogus ids
  o USB: usbnet, don't NET_XMIT_DROP

David S. Miller:
  o [SPARC]: SEMTIMEDOP for both Sparc ports
  o [SPARC64]: Port over IPC msg{snd,rcv} compat32 fixes from ia64
  o [TCP]: When in SYN-SENT, initialize metrics after move to
    established state
  o [NET]: Ok, sunhme is VLAN challenged after all
  o [IPV6]: Build and send redirect packet using "buff" not "skb",
    fixes OOPS
  o [IPV6]: Fix dst reference counting in ndisc_send_redirect()
  o [NET,COMPAT]: Delete bogus icmpv6 filter translation code
  o [IPV6]: Fix leaks of ndisc DST entries
  o [SPARC64]: Ditch local KALLSYMS from Kconfig, update defconfig
  o [SPARC64]: Implement force_successful_syscall()
  o [SPARC64]: Use mm->free_area_cache
  o [IPV4]: Do not redefine config macros in net/ip_vs.h
  o [IPV4]: Always use Jenkins hash in ipvs conn table, use
    get_random_bytes() to init key
  o [IPV4]: Kill slow timers from IPVS, they are superfluous and
    inefficient these days

David Stevens:
  o [IPV4]: Do not sent IGMP leave messages unless IFF_UP

Dominik Brodowski:
  o [PCMCIA] don't hide calls to socket drivers
  o [PCMCIA] rename ss_entry to ops

François Romieu:
  o Fix AD1889 driver 2.4 merge
  o Fix error path in AD1889 driver

Greg Kroah-Hartman:
  o USB: fix up my USB Bluetooth entry to help prevent confusion in the
    future
  o USB: remove pointless warning about using usbdevfs

Herbert Xu:
  o [IPSEC]: Missing reqid check in xfrm_state_ok

Hideaki Yoshifuji:
  o [IPV6]: Fix offset of payload with extension header

Ian Abbott:
  o USB: ftdi_sio update

James Morris:
  o [NETLINK]: Just drop packets for kernel netlink socket with no
    data_ready handler

Jean Tourrilhes:
  o [IrDA] include cleanup
  o [IrDA] struct check
  o [IrDA] irtty leaks
  o [IrDA] irnet cast
  o [IrDA] IrCOMM devfs
  o [IrDA] setup dma fix
  o [IrDA] irda-usb endian
  o [IrDA] nsc 39x support

Jeff Garzik:
  o [netdrvr tg3] more ULL suffixes to make gcc 3.3 happy
  o [netdrvr] fix compiler warnings in 3c359, proteon, skisa tokenring
    drivers.
  o [netdrvr wavelan] remove check_region usage
  o [netdrvr atmel_cs] kill compiler warning (jumping to "empty" label)

Jens Axboe:
  o disk stats accounting fix
  o Fix IDE-CD command failure re-play
  o fs accounting, part 2

Kay Sievers:
  o usblp: usb_buffer_free() not called Here is the blind flight :-)
    === drivers/usb/class/usblp.c usblp->dev was set to NULL to
    indicate a device disconnect but we need this value for
    usb_buffer_free() when device is still opened and cleanup is
    delayed until usblp_release().

Linus Torvalds:
  o Avoid mmap() overflow case if TASK_SIZE is the full range of an
    "unsigned long" (sparc64).
  o Merge comment updates from DRI CVS tree
  o Update i810 DRI driver from CVS to add page flipping
  o Update r128 driver from DRI CVS: add support for ycbcr textures
  o Update radeon driver from DRI CVS: add more commands
  o Merge from DRI CVS tree: avoid zero DRI "handles"
  o Merge with DRI CVS tree - which added a reminder to the DRI people
    not to remove the HAVE_KERNEL_CTX_SWITCH support that the sparc
    drivers require.
  o Fix signedness tests in vsnprintf by making it explicit
  o Mark Bartlomiej as the IDE maintainer, about 3 months late ;)
  o Disable TI cardbus PCI IRQ routing code that was forward-ported
    from 2.4-ac - it seems to cause hangs for people.

Matthew Dharm:
  o USB: fix usb-storage initializers
  o USB: fix datafab and freecom to use I/O buffer

Matthew Wilcox:
  o parisc updates
  o Makefile update for parisc
  o eisa Kconfig update for parisc
  o Add two sysctls for PA-RISC
  o Remove warning from binfmt_elf.c for upwards growing stack
  o gsc-ps2 update

Miles Bader:
  o Use <asm-generic/statsfs.h> on v850
  o More irqreturn_t changes for v850
  o show_stack changes for v850

Nivedita Singhvi:
  o [NET]: Fix typo in net-sysfs.c copyright

Pete Zaitcev:
  o [SPARC]: Clean secondary System.map
  o [SPARC]: defconfig for willy's scsi
  o [SPARC]: hch's cond_syscall() for PCI syscalls, Alpha/PPC/etc. can
    use this too
  o [SPARC]: Redo show_stack()
  o [SPARC]: Trap table alignment for Hyperspace (Keith Weselowsky)

Petr Sebor:
  o via-agp.c - agp_try_unsupported typo

Petr Vandrovec:
  o new sysctl checking accesses userspace directly

Ralf Bächle:
  o mkiss

Richard Henderson:
  o [ALPHA] Add tgkill syscall
  o [ALPHA] Set correct CLOCK_TICK_RATE for the RTC
  o [ALPHA] Remove SBUS & MCA from alpha Kconfig

Robert Zwerus:
  o Documentation/CodingStyle spelling fixes

Russell King:
  o [PCMCIA] Prevent PCMCIA oops during socket driver initialisation
  o [PCMCIA] Fix hangs when PCMCIA modules loaded

Samuel Thibault:
  o [2.5] maestro volume tuning

Stephen Hemminger:
  o convert plip to alloc_netdev
  o [netdrvr dgrs] convert to using alloc_etherdev

Steve French:
  o NTLMv2 password support and NTLMSSP signing part 1
  o ntlmssp signing
  o More NTLMv2
  o Open / Create lookup intents part one
  o Add mknod support
  o fix cifs distributed caching - send oplock release immediately
    after flush of writebehind data on oplock break from server

Thomas Graf:
  o [NET]: Return EDESTADDRREQ as appropriate in sendmsg
    implementations

Ulrich Drepper:
  o Re: utimes/futimes/lutimes syscalls

Wensong Zhang:
  o [NET]: Merge in IPVS layer


