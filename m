Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262670AbTCZX6h>; Wed, 26 Mar 2003 18:58:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262685AbTCZX6h>; Wed, 26 Mar 2003 18:58:37 -0500
Received: from perninha.conectiva.com.br ([200.250.58.156]:5602 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id <S262670AbTCZX62>; Wed, 26 Mar 2003 18:58:28 -0500
Date: Wed, 26 Mar 2003 21:08:42 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
X-X-Sender: marcelo@freak.distro.conectiva
To: lkml <linux-kernel@vger.kernel.org>
Subject: Linux 2.4.21-pre6
Message-ID: <Pine.LNX.4.53L.0303262107480.2544@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Here goes -pre6.

We are approaching -rc stage. I plan to release -pre7 shortly which should
fixup the remaining IDE problems (thanks Alan!) and -rc1 later on.



Summary of changes from v2.4.21-pre5 to v2.4.21-pre6
============================================

<andre.breiler@null-mx.org>:
  o io_edgeport.c diff to fix endianess bugs

<bde@bwlink.com>:
  o [SPARC64]: Fix ocndition code handling in do_rt_sigreturn

<bergner@vnet.ibm.com>:
  o add ndelay() for ppc64

<blaschke@blaschke3.austin.ibm.com>:
  o JFS: Code cleanup suggested by static analysis tool

<chas@cmf.nrl.navy.mil>:
  o [ATM]: Add MAINTAINERS entry

<chas@locutus.cmf.nrl.navy.mil>:
  o [ATM]: use sock timestamp
  o [ATM]: Use skb_pull instead of direct skb mangling
  o [ATM]: Get minimum frame size right in lec.c
  o [ATM]: Let upper layer k now lec supports multicast
  o [ATM SUNI]: suni_init should not be __init and remove mod inc/dec
  o [ATM FORE200E]: Fix build

<clemens@ladisch.de>:
  o usb-midi.h: fixes for SC-8820/50
  o usb-midi.h: fixes for SC-8820/50

<coughlan@redhat.com>:
  o Update SCSI whitelist in scsi_scan.c

<dale@farnsworth.org>:
  o PPC32: Make the bootloader start at 0x000c for SMP
  o PPC32: Make it easier to hook into the bootloader code
  o PPC32: Allow the bootloader to pass in a board descripter struct

<hadi@cyberus.ca>:
  o [SCHED GRED]: Another bug found by Stanford Checker

<harald@gnumonks.org>:
  o [NETFILTER]: Fix icmp-type all problem in iptables

<henning@meier-geinitz.de>:
  o USB scanner.h, scanner.c: New vendor/product ids
  o USB: New vendor/product ids for scanner driver

<jakub@redhat.com>:
  o [SPARC64]: Fix typo in sparc64_get_context (G7 register is saved wrongly)

<josh@joshisanerd.com>:
  o USB: add KB Gear USB Tablet Driver

<kernel@jsl.com>:
  o Re: Keyspan USB/Serial Drivers for 2.4.20/2.4.21-pre4

<laforge@netfilter.org>:
  o [NETFILTER]: fix NAT ICMP reply translation of inner packet
  o [NETFILTER]: Fix conntrack bug introduced by list_del change
  o [NETFILTER]: Fix typo in ftp conntrack helper
  o [NETFILTER]: Add new ip6tables matches

<lunz@falooley.org>:
  o fix eepro100 SMP deadlock (uninitialized spinlock)

<sri@us.ibm.com>:
  o [IPV4/IPV6]: Fix to avoid overriding TCP/UDP with a new protocol of same type

<weigand@immd1.informatik.uni-erlangen.de>:
  o Fix race on rpc code

Adam Radford <adam@nmt.edu>:
  o 3ware driver update for 2.4.21-pre6

Adrian Bunk <bunk@fs.tum.de>:
  o USB: fix Auerswald compile

Alan Cox <alan@lxorguk.ukuu.org.uk>:
  o New PCI identifiers for ALi 156x ethernet
  o fix a ; in cris eeprom
  o correct handling of VIA PCI and of IDE legacy irq
  o add another transparent bridghe
  o export ndelay for modular ide stuff
  o Enable XMM on more athlons
  o fix ndelay argument name
  o more usercopy documentation
  o fix wacked formatting in x86-64 code
  o enable newly added docs
  o ide doc update
  o update hp framebuffer docs
  o update ipmi doc
  o Add missing EXPORT_SYMBOL for acpi & ipmi
  o epca sign fix
  o add genrtc driver used by multiple ports
  o ipmp updates
  o build genrtc if asked for
  o sign fix in mwave
  o & v && fix for i2c
  o nforce is now in AMD so delete the option
  o new AMD/Nvidia driver
  o remove dead Nvidia driver
  o bogo semicolon fix in joydev
  o fix hysdn brackets
  o fix some radio typos/oddments
  o more radio oddments
  o cpia update
  o fix w9966 tuner bug
  o mptfusion sign handling
  o missing Makefile slot
  o incorrect bracketing
  o e100 updates
  o fix ethernet pad in example driver
  o fix non x86 8169 build
  o another rogue semicolon
  o bracketing fix
  o ips docs update
  o cpqfc fix for non x86
  o dpt_i2o sign fix
  o fix ide-scsi hang on SMP boxes
  o ; fixes
  o ips update
  o wrong bracketing
  o XpressAudio enabler for Cyrix 5520
  o maestro bracketing bug
  o values cannot be init
  o fix large I/O to nec audio
  o bracketing fix in sscape
  o ali5451 is 31bit audio
  o via8233/8235 audio update
  o & v && in acm usb
  o usb hang fix
  o atafb bug in #if 0 code
  o fix logic error in aty128fb
  o typo fix in video headers
  o logic error in radeonfb
  o fix sisfb build on non x86
  o add intelfb driver
  o fix incorrect bracketing in JFFS
  o fix nfs port option on bigendian
  o fix seq_file problems
  o missing defines for alpha
  o faster x86 byteorder code
  o make __ndelay() argument name sane
  o generic rtc support headers for parisc
  o Fix typo in REPORTING-BUGS

Alan Cox <alan@redhat.com>:
  o Fix kmod/ptrace vulnerability

Alan Stern <stern@rowland.harvard.edu>:
  o USB: Patch for auto-sense cmd_len

Andi Kleen <ak@muc.de>:
  o [NET]: Make skbuff.h -W clean, skb_headlen should return unsigned quantity
  o x86-64 update

Ben Collins <bcollins@debian.org>:
  o [IEEE1394] Sync with repo

Benjamin LaHaise <bcrl@redhat.com>:
  o [NET]: Make sure nr_frags is accurate on paged SKB allocation failure

Christoph Hellwig <hch@lst.de>:
  o [NET]: Remove __NO_VERSION__ from networking code
  o backport sys_sendfile64

Christoph Hellwig <hch@sgi.com>:
  o [SPARC]: Add xattr syscalls

Dave Jones <davej@codemonkey.org.uk>:
  o Enable prefetch on P4
  o add missing intel cache descriptor

Dave Kleikamp <shaggy@shaggy.austin.ibm.com>:
  o JFS: Fix hang while flushing outstanding transactions under heavy load
  o JFS: Avoid deadlock when all tblocks are allocated

David Brownell <david-b@pacbell.net>:
  o USB: rename drivers/usb/hcd --> host
  o USB: call hcd->stop() in task context
  o ehci, sync with 2.5 latest

David S. Miller <davem@nuts.ninka.net>:
  o [SPARC64]: Add TCSBRKP ioctl translation, thanks Anton
  o [TCP]: Do not bump backoff too high during 0-window probes
  o [NET]: Fix length in skb_padlen
  o [RANDOM]: Backport 2.5.x ipv4/ipv6 sequence number generation SMP fixes by manfred@colorfullife.com
  o [SPARC64]: Implement STICK synchronization using ia64 port algorithms
  o [NET]: Export skb_pad to modules
  o [SPARC64]: Update defconfig
  o [NETLINK]: Remove buggy and useless rcv queue wakeup tests
  o [IPV6]: Cure typo in ipv6_addr_prefix
  o [IPV{4,6}]: Make icmp_socket per-cpu and simplify locking
  o [NETFILTER]: Fix typo in ipv6 makefile changes
  o [NET]: Fix mismerge, no need to export skb_pad twice
  o [SPARC64]: Make sure we are in irq_enter atomic section during update_process_times
  o [SPARC64]: Kill SPARC64_USE_STICK and use real timer drivers
  o [SPARC64]: Fix timer quotient calcs
  o [SPARC64]: Do not mark timer_ticks_per_usec_quotient static
  o [SPARC64]: Make gettimeofday assembly match tick quotient fixes
  o [SPARC64]: Add Hummingbird STICK support
  o [SPARC64]: Make TICK comparisons wrap-around safe by using jiffies macros
  o [SPARC64]: Sanitize all TICK privileged bit handling in tick drivers
  o [SPARC64]: Clear tick_cmpr ints properly in bootup assembly
  o [SPARC64]: Kill bogus kernel_thread decl

Ganesh Varadarajan <ganesh@vxindia.veritas.com>:
  o USB ipaq.c: add ids for fujitsu loox

Geert Uytterhoeven <geert@linux-m68k.org>:
  o Amiga PCMCIA Ethernet clean up
  o M68k ISA memory for Amiga PCMCIA
  o M68k Apollo I/O updates
  o M68k ifpsp060 updates
  o M68k incorrect prototype
  o Amiga RTC updates
  o Amifb wrong interrupt
  o Atari NCR5380 SCSI: bitops operate on long
  o Convert m68k cache macros to inline functions
  o Mac/m68k VIA updates
  o Allow to disable macfb
  o M68k net warnings
  o M68k heartbeat update
  o M68k config syntax
  o Sun-3 contact update
  o M68k SCSI warnings
  o M68k PAGE_SIZE warnings
  o M68k: optimize stacked irq check
  o Sun-3 memory zones
  o Sun-3 ioremap()
  o M68k page_to_phys
  o Sun-3 first page
  o M68k iomap cleanup
  o Sun-3 SBUS updates
  o Sun-3 vectored interrupts
  o M68k timekeeping update
  o Amiga Zorro SCSI: use z_ioremap()
  o Sun-3/3x updates
  o M68k core spelling fixes
  o Amiflop out-of-bounds array access
  o Sun-3 VME support
  o M68k warnings

Go Taniguchi <go@turbolinux.co.jp>:
  o USB: Another pegasus ID
  o USB: Another kaweth ID
  o USB: Another sony memorystick
  o USB: Multiple interfaces with usb hotplug
  o USB: Another hid-core worksround

Greg Kroah-Hartman <greg@kroah.com>:
  o USB: added support for radio shack device to pl2303 driver
  o USB: add firmware files for two new keyspan devices
  o USB: merge fixup for the scanner driver
  o USB: move the UHCI drivers into drivers/usb/host
  o USB: move the OHCI driver into drivers/usb/host

Hideaki Yoshifuji <yoshfuji@linux-ipv6.org>:
  o [IPV6]: Export ip6_route_me_harder for netfilter and add ipv6_addr_prefix

James Morris <jmorris@intercode.com.au>:
  o [NET]: Clean up sk_filter and make sure it is called when skb->dev is still valid
  o [IPV4]: Fix skb leak in inet_rtm_getroute
  o [IPV6]: Fix skb leak in inet6_rtm_getroute
  o [NET]: Add myself as co-maintainer
  o [NETLINK]: Un-duplicate rcv wakeup logic

Jay Vosburgh <fubar@us.ibm.com>:
  o [BONDING]: Add MAINTAINERS entry

Jeff Garzik <jgarzik@redhat.com>:
  o Via Nehemiah (C3-2) CPU support

John Levon <levon@movementarian.org>:
  o [SUNHME]: Fix bit testing typo

Leigh Brown <leigh@solinno.co.uk>:
  o Updated S3Triofb driver for PPC32

Lennert Buytenhek <buytenh@gnu.org>:
  o [BRIDGE]: handle out-of-ports corner case

Marcel Holtmann <marcel@holtmann.org>:
  o [SPARC64]: Translate AUTOFS_IOC_EXPIRE_MULTI ioctl

Marcelo Tosatti <marcelo@freak.distro.conectiva>:
  o Changed EXTRAVERSION to -pre6

Mark A. Greer <mgreer@mvista.com>:
  o PPC32: Fix a problem with 'next' and 'step' type KGDB commands

Neil Brown <neilb@cse.unsw.edu.au>:
  o md - 1 of 3 - Fix small bug in md.c
  o md - 3 of 3 - Don't check a device size before bd_get in
  o md - 2 of 3 - Convert /proc/mdstat to use seq_file
  o drivers/block/umem.c - new card
  o Fix compile errors/warnings in md

Oleg Drokin <green@angband.namesys.com>:
  o reiserfs: Make balloc[] tails[] and hash[] in super.c static. (Noticed by Arnd Bergmann <arnd@bergmann-dalldorf.de>)
  o reiserfs: gcc 3.3 compile fix from Hubert Mantel <mantel@suse.de>
  o reiserfs: Fix a warning about mismatching types while doing printk
  o reiserfs: Stricter checks for transactions and fs itself during mount

Oleg Drokin <green@namesys.com>:
  o Reiserfs journal overflow fix on large highly fragmented fs

Oliver Neukum <oliver@neukum.name>:
  o USB: work around for a firmware bug of some scanners

Patrick McHardy <kaber@trash.net>:
  o [IPV{4,6}]: lru queue for ip_fragment evictor

Paul Mackerras <paulus@samba.org>:
  o PPC32: Implement kmap_nonblock, add extra argument to kmap_high call
  o PPC32: Add missing break, without which get_user on 8-byte quantities would fail

Pete Zaitcev <zaitcev@redhat.com>:
  o [SPARC]: Add missing newline to kernel OOPS printk
  o [SPARC32/64]: Expand ioctl size field in backwards-compatible way
  o [SPARC]: RTC driver needs to include linux/pci.h
  o Fix initrd initialization

Petr Vandrovec <vandrove@vc.cvut.cz>:
  o Fix matroxfb build
  o Support for matroxfb on HP Vectra

Rob Radez <rob@osinvestor.com>:
  o [SPARC]: kmap_nonblock changes

Rusty Russell <rusty@rustcorp.com.au>:
  o [AF_UNIX] Cleanup forall_unix_sockets
  o [X25]: Fix improper | precendence, pointed out by Joern Engel
  o [ECONET]: Add comment to point out a bug spotted by Joern Engel

Theodore Ts'o <tytso@mit.edu>:
  o Ext2/3: noatime ignored for newly created inodes

Tom Rini <trini@kernel.crashing.org>:
  o PPC32: Export m8xx_cpm_hostalloc on CONFIG_8xx
  o PPC32: Replace 2 inline functions with their normal macro equivalents
  o PPC32: Fix a problem on MPC8xx when CONFIG_USE_MDIO=n
  o PPC32: Backport the code from 2.5 to make do_div handle 64bit
  o PPC32: KGDB is more useful when -g is in the CFLAGS
  o PPC32: Fix some warnings in the MPC8xx FPU emulation code
  o PPC32: Fix some warnings on MPC8xx
  o PPC32: Change some bootloaders to call load_kernel directly
  o PPC32: Add USE_STANDARD_AS_RULE to boot/lib/Makefile
  o PPC32: Fix some warnings on MPC8xx
  o PPC32: Clarify some of the MPC8xx uart code

Trond Myklebust <trond.myklebust@fys.uio.no>:
  o Fix misleading EIO on NFS client
  o Fix unbalanced kunmap() in NFS symlink code

