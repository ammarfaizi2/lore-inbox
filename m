Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267274AbTAGAX2>; Mon, 6 Jan 2003 19:23:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267275AbTAGAX2>; Mon, 6 Jan 2003 19:23:28 -0500
Received: from perninha.conectiva.com.br ([200.250.58.156]:45013 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id <S267274AbTAGAXW>; Mon, 6 Jan 2003 19:23:22 -0500
Date: Mon, 6 Jan 2003 19:32:37 -0200 (BRST)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
X-X-Sender: marcelo@freak.distro.conectiva
To: lkml <linux-kernel@vger.kernel.org>
Subject: Linux 2.4.21-pre3
Message-ID: <Pine.LNX.4.50L.0301061932140.8257-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


So here goes -pre3...


Summary of changes from v2.4.21-pre2 to v2.4.21-pre3
============================================

<bdschuym@pandora.be>:
  o [BRIDGE]: new_nbp runs under rwlock so needs to use GFP_ATOMIC

<bero@arklinux.org>:
  o AGP support for VIA P4X333 boards

<ganesh@tuxtop.vxindia.veritas.com>:
  o USB ipaq driver update

<greearb@candelatech.com>:
  o [VLAN]: Quiet some printks and free devices/groups correctly

<hadi@cyberus.ca>:
  o [SCH_GRED]: Array overflow fixes, found by Stanford checker

<henning@meier-geinitz.de>:
  o scanner.h: add/fix vendor/product ids
  o scanner.c: silence noisy debug message
  o scanner.c: Support for devices with only one bulk-in endpoint
  o scanner.c: Accept scanners with more than one interface
  o [PATCH 2.4.21-pre1] scanner.c: Use first altsetting in probe_scanner()
  o scanner.c: fix race in ioctl_scanner()
  o USB scanner driver: updated documentation

<joergprante@netcologne.de>:
  o [2.4.21-pre2] scx200 build fix

<krkumar@us.ibm.com>:
  o [IPV6]: Missing in6_dev_put in router discovery

<mark@hal9000.dyndns.org>:
  o Update ov511 to version 1.63. This is a backport of the 2.5 driver,

<oliver@oenone.homelinux.org>:
  o USB kaweth bugfix

<petkan@rakia.hell.org>:
  o a new device added and assign proper vendor id to the Netgear adapter
  o USB pegasus update
  o USB rtl8150 update
  o Petkan's email address change

Alan Cox <alan@lxorguk.ukuu.org.uk>:
  o fix legacy hd
  o various minor noise merges
  o update Pavel credits
  o via audio updates to add 8233/8235 support
  o motorola timeport is comms class but doesnt use comms class
  o support 24bit and multichannel audio stuff in usb-audio
  o use MUX ident for pdc console
  o bring wan drivers into line with 2.5
  o matroxfb updates
  o documentation only merge - add docbook documentation to jbd
  o fix suprises in arm defines
  o defines/protection oddments for x86
  o add CON_BOOT flaga
  o kstat changes for PA risc
  o matroxfb update header
  o update iphase ATM driver
  o 3964 trivial optimisation
  o arcnet pci updates
  o eepro100: more boxes care about alignment
  o scsi dup id bug
  o isd200 to new style IDE
  o USB workaround for ALi OHCI oddments
  o Fix memory leak in fs layer
  o DRM must enable device to get its IRQ
  o drm ensure memory initialized
  o another DRM backport of a memory clear
  o x86-64 needs the same page twiddles as x86-32 for DRM AGP
  o email change in DRM
  o email change in drm - 2
  o journalling header changes (docs only)
  o removepage callback
  o wrong include order
  o fix i810 oops
  o fix mplayer. realplayer and friends on via8233/8235
  o IDE driver for Compaq Triflex IDE
  o fix ALi audio handling for 6 channel, fixes audio in RadeonIGP
  o config entry for triflex ide
  o corename patch from -ac
  o bring APM up to date
  o Fix the "controller but no drives" IDE problem
  o trivial ide oddments

Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>:
  o [IPV6]: Check for NULL return from __in6_dev_get

Andreas Dilger <adilger@clusterfs.com>:
  o 2.4 ext3 ino_t removal

Andrew Morton <akpm@digeo.com>:
  o remove dead function swap_count()
  o fix buffer_head.b_state race

Arnaldo Carvalho de Melo <acme@conectiva.com.br>:
  o Fix token ring SMP lockups

Bart De Schuymer <bart.de.schuymer@pandora.be>:
  o [IP_TABLES]: Fix locking comments

Bjorn Helgaas <bjorn_helgaas@hp.com>:
  o Fix CPU bitmask truncation (1 of 2)
  o Fix CPU bitmask truncation (2 of 2)

Chad N. Tindel <ctindel@cup.hp.com>:
  o [BONDING]: Update to version 2.4.20-20021210

Dave Jones <davej@codemonkey.org.uk>:
  o Work around BIOS problem with recent Athlons

David Brownell <david-b@pacbell.net>:
  o ehci updates

David S. Miller <davem@nuts.ninka.net>:
  o net/ipv6/netfilter/ip6table_mangle.c: Fix bogus cast
  o [ip-sysctl.txt]: Clarify conf/*/ behavior
  o [IPV4]: Report zero route advmss properly
  o [NET]: Copy msg_namelen back to user in recv{from,msg} even if it is zero
  o [VLAN]: remove vlan_devices[] entries properly
  o [IPV6]: Fix merge error
  o [IPV6]: Kill unused variable in igmp6_leave_group
  o [TCP]: Add FRTO sysctl entry

Greg Kroah-Hartman <greg@kroah.com>:
  o USB scanner: stop managing our module reference count, and let the VFS do it

Harald Welte <laforge@gnumonks.org>:
  o [NETFILTER] Add IP unused bit check to ipt_unclean.c, from Maciej Soltysiak

Hideaki Yoshifuji <yoshfuji@linux-ipv6.org>:
  o net/ipv6/addrconf.c: Use prefix of 64 for link-local addresses
  o net/ipv6/mcast.c: Several MLD fixes
  o [IPV6]: Add IPV6_V6ONLY socket option support
  o [IPV6]: Add ICMP6 rate limit sysctl
  o [IPV6]: Split ndisc_rcv into helper functions
  o [IPV6]: Avoid garbage sin6_scope_id for MSG_ERRQUEUE messages
  o [IPV6]: Fix for refined IPV6 address validation timer
  o [IPV6]: Fix Length of Authentication Extension Header

Hugh Dickins <hugh@veritas.com>:
  o tmpfs read hang

Jean Tourrilhes <jt@bougret.hpl.hp.com>:
  o IrLMP basic socket scheduler
  o donauboe IrDA driver

Jeff Garzik <jgarzik@redhat.com>:
  o [netdrvr mii] fix ugly lack of useful bit masking
  o [netdrvr] add AMD-8111 ethernet driver (yet another PCI lance)
  o [netdrvr eepro100] new pci id
  o [netdrvr de4x5] fix uninitializer timer
  o [netdrvr e1000] sync up with 2.5.x e1000 driver
  o [netdrver e1000] wol updates
  o [netdrvr e1000] restore VLAN settings after resume
  o [netdrvr e1000] small cleanups and fixes
  o [netdrvr e100] sync up with 2.5.x e100 driver
  o [netdrvr e100] Bug fix: system panic in watchdog when repeating ifdown, rmmod, insmod
  o [netdrvr e100] Bug fix: enable/disable WOL based on EEPROM settings
  o [netdrvr e100] fix ethtool/mii interface up/down issues
  o [netdrvr e100] better debugging for command failures/timeouts
  o [netdrvr e100] changelog/whitespace updates, small fixes

Maksim Krasnyanskiy <maxk@qualcomm.com>:
  o Remove old BNEP ioctls. These are internal. Only one app is supposed to use them, so there is no compatibility problem.
  o Move Bluetooth ioctls after USB and other stuff in sparc64/ioctl32.c

Marcel Holtmann <marcel@holtmann.org>:
  o [Bluetooth] Convert dlci and channel variables to u8
  o [Bluetooth] Add some COMPATIBLE_IOCTL for SPARC64

Marcelo Tosatti <marcelo@conectiva.com.br>:
  o Fix ide-tape unload issue

Marcelo Tosatti <marcelo@freak.distro.conectiva>:
  o Add removepage callback
  o Cset exclude: alan@lxorguk.ukuu.org.uk|ChangeSet|20030102230329|26122 "add hwclock ioctls"
  o Changed EXTRAVERSION to -pre3
  o Fix typo in Apollo P4X400 support patch
  o Revert broken drivers/ieee1394/Makefile changes

Mark W. McClelland <mark@alpha.dyndns.org>:
  o USB ov511: Convert to new V4L 1 interface

Mikael Pettersson <mikpe@csd.uu.se>:
  o Fix ide-scsi ref count bug in 2.4.20-pre2

Neil Brown <neilb@cse.unsw.edu.au>:
  o Remove irrelevant warning in sunrpc code
  o Avoid oops when NFSD decodes enourmous filehandle
  o Set BH_Locked when accessing MD superblocks

Pasi Sarolahti <sarolaht@cs.helsinki.fi>:
  o [TCP]: Add F-RTO support

Paul Mackerras <paulus@samba.org>:
  o PPC32: More OpenPIC updates, to openpic_init and openpic_init_nmi_irq
  o PPC32: fix the compile with IDE
  o PPC32: Provide a more general way to handle cascaded interrupts
  o PPC32: Provide finer control over IRQ sense and polarity for OpenPIC interrupts.
  o PPC32: Evaluate physical addresses correctly from Open Firmware device tree when we have non-transparent PCI bridges.
  o PPC32: remove the unimplemented iopl, vm86 and modify_ldt syscalls
  o PPC32: Update all the defconfigs

Randy Dunlap <rddunlap@osdl.org>:
  o usb semaphore lock in 2.4.20-rc1 (since 2.4.13)

Simon Evans <spse@secret.org.uk>:
  o 2.4.20 usbvideo cleanups 1/4
  o 2.4.20 usbvideo cleanups 2/4
  o 2.4.20 usbvideo cleanups 3/4
  o 2.4.20 usbvideo cleanups 4/4
  o 2.4.20 usbvideo fixes from 2.5  1/5
  o 2.4.20 usbvideo fixes from 2.5  2/5
  o 2.4.20 usbvideo fixes from 2.5  3/5
  o 2.4.20 usbvideo fixes from 2.5  4/5
  o 2.4.20 usbvideo fixes from 2.5  5/5

Thomas Sailer <sailer@scs.ch>:
  o Fix oopsable bug in OSS PCI sound drivers

Tom Rini <trini@kernel.crashing.org>:
  o PPC32: Add support to the OpenPIC code to allow the controller to be in serial mode.
  o PPC32: Change the OpenPIC initalization logic so that it no longer needs to know where the NMI irq is.
  o PPC32: Remove an unused parameter to openpic_init()
  o PPC32: Make progress messages for OpenPIC matters consistent
  o PPC32: Merge i8259_irq() (using the int-ack feature) and i8259_poll() (poll for IRQ) into one function, i8259_irq().
  o PPC32: Remove a special case for hardware with an OpenPIC and i8259 where we must call use the int-ack for cascaded IRQs and not poll.
  o PPC32: Remove extra __KERNEL__ checks in some headers, as well as adding /* __KERNEL__ */ to the #endif of others.
  o PPC32: Fix a problem in the bootloader/wrapper where we might
  o PPC32: Fix some 'prep' machines which are not true PRePs, and can safely poll for interrupts on the i8259.
  o PPC32: Add explicit parens around arguments used in macros in include/asm-ppc/page.h
  o PPC32: Fix a delay which could occur when booting on machines without an RTC.
  o PPC32: Move IRQ sense and polarity masks to <asm/irq.h>

Vojtech Pavlik <vojtech@suse.cz>:
  o Workaround (ide-timing.h) for many ATAPI CD/DVD-ROMs and burners

