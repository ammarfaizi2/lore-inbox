Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262694AbTJJAyI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Oct 2003 20:54:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262695AbTJJAyH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Oct 2003 20:54:07 -0400
Received: from intra.cyclades.com ([64.186.161.6]:61130 "EHLO
	intra.cyclades.com") by vger.kernel.org with ESMTP id S262694AbTJJAxy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Oct 2003 20:53:54 -0400
Date: Thu, 9 Oct 2003 21:52:15 -0300 (BRT)
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
X-X-Sender: marcelo@logos.cnet
To: linux-kernel@vger.kernel.org
Subject: Linux 2.4.23-pre7
Message-ID: <Pine.LNX.4.44.0310091939100.6403-100000@logos.cnet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

Here goes -pre7... 

It adds the laptop "mode" functionality already present in recent SuSE/RH
kernels, adds the megaraid2 (improved, faster, but not so extensively
tested as the old megaraid) driver, adds BIOS EDD (enhanced disk
detection) support, contains a USB update, network update, amongst other
fixes.

I hope we enter -rc stage in more or less one month.


Summary of changes from v2.4.23-pre6 to v2.4.23-pre7
============================================

<amn3s1a:ono.com>:
  o USB: New unusual_devs.h entry (Minolta DiMAGE E223 Digital Camera)

<baldrick:free.fr>:
  o USB speedtouch: neater sanity check
  o USB: New email address
  o USB speedtouch: bump the version number
  o USB speedtouch: biscuit for Greg
  o USB speedtouch: reduce memory usage
  o USB speedtouch: extra debug messages

<bjorn.helgaas:hp.com>:
  o ia64: Add arch/ia64/drivers subdir, so ski drivers can be under arch/ia64 while still getting their module_inits called late (i.e., simscsi module_init needs to happen after init_scsi).
  o Fix pci_generic_prep_mwi export breakage
  o Backport force_successful_syscall()

<erik:harddisk-recovery.nl>:
  o Change sym53c8xx_2 driver module name

<hunold:linuxtv.org>:
  o Remove bogus Philips SAA7146/DVD decoder info from ioctl-number.txt

<ja:ssi.bg>:
  o [IPV4/IPV6]: Do not modify skb->h.raw until skb is unshared

<jack:ucw.cz>:
  o Fix quota counter overflow

<jan.oravec:6com.sk>:
  o [IPV6]: Deactivate timers properly in ipv6_mc_destroy_dev()

<lucy:innosys.com>:
  o USB: Keyspan USB adapter patches

<marcelo:dmt.cyclades>:
  o Fix missing part of Centrino cache detection change
  o Add TASK_SIZE check to do_brk()

<marcelo:logos.cnet>:
  o Add missing #endif to force_successful_syscall_return change
  o Fix dscc4 net/wan Config.in breakage
  o Fix ACPI config.in breakage
  o Cset exclude: ak@muc.de|ChangeSet|20031005214700|30577
  o Add Megaraid 2 driver
  o Cset exclude: 20030702202648|35018: i82092 update broke existing working setups
  o Fix typo in laptop mode patch
  o Change my mail address in a few places
  o Remove racy optimization from exec_mmap()
  o From -aa tree: Fix potential PPPoE oops
  o Fixup exec_mmap() race fix mess
  o Changed EXTRAVERSION to -pre7
  o Cset exclude: bjorn.helgaas@hp.com|ChangeSet|20031007181555|25551
  o nsp_cs.h: Remove irqreturn_t definition

<mike.miller:hp.com>:
  o cciss update: support new controller

<mirage:kaotik.org>:
  o [NETFILTER]: Add support for mIRC's 'server lookup' DCC address detection to ip_conntrack_irc.c

<pfg:sgi.com>:
  o Altix console driver update

<tommy.christensen:tpack.net>:
  o [VLAN]: Do not modify the data of shared SKBs

<wensong:linux-vs.org>:
  o [IPVS] Fix ip_vs_tunnel_xmit to return NF_DROP when no memory available
  o [IPVS] add strict boundary check in parsing FTP commands

<xose:wanadoo.es>:
  o megaraid2 merge fixes

Adrian Bunk:
  o USB: fix USB_MOUSE help text
  o USB: USB_SERIAL_KEYSPAN_USA49WLC Configure.help entry

Alan Stern:
  o USB: Pad UFI commands to 12 bytes with zeros
  o USB: unusual_devs.h update

Alexander Viro:
  o Cleanup /proc/ioports seqfile conversion
  o attach_mnt() fix

Andi Kleen:
  o x86-64 ACPI compilation fix
  o Disable devfs for x86-64
  o Fix bug on ACPI sysrq poweroff

Andrea Arcangeli:
  o do_proc_readlink failpath

Benjamin Herrenschmidt:
  o kupdated: correctly dequeue SIGSTOP signals

Dave Kleikamp:
  o BUG() in exec_mmap()

David Brownell:
  o USB: usb gadget support for 2.4 (1/5):  api
  o USB: usb gadget support for 2.4 (2/5): net2280
  o USB: usb gadget support for 2.4 (3/5): zero
  o USB: usb gadget support for 2.4 (4/5): ether
  o USB: usb gadget support for 2.4 (5/5): kbuild/kconf

David Hinds:
  o PCMCIA: cleanup i82365 driver

David S. Miller:
  o [NETLINK]: Set socket error on netlink_ack() allocation failure
  o [NET]: Size hh_cache->hh_data[] properly
  o [UDP/TCP]: Fix binding conflict tests wrt. SO_BINDTODEVICE
  o [NET]: Fix userland iproute2 build problems introduced by mcast changes

David T. Hollis:
  o USB: ax8817x support for usbnet and ethtool_ops support

Erik Andersen:
  o fix 2.4.x incorrect argv[0] for init

François Romieu:
  o dscc4: dscc4_init_dummy_skb() returns a pointer
  o dscc4: add comments
  o dscc4: More comments
  o dscc4: Typo, tabs, unneeded include and misc things from 2.6
  o dscc4: misc fixes
  o dscc4: Assorted fixes
  o dscc4: Small fixes
  o dscc4: Workaround for lack of true reset

Geert Uytterhoeven:
  o Minor q40fb fix
  o M68k: Fix asm constraints in switch_to
  o M68K: Q40/Q60 interrupts
  o M68K: Sun-3 SBUS updates
  o Amiga Zorro bus doc updates

Gerd Knorr:
  o v4l i2c modules update
  o bttv driver update
  o bttv documentation update
  o Tuner update
  o videodev update

Greg Kroah-Hartman:
  o USB: unusual device fixup for the Y-E floppy drive
  o USB: add a new pl2303 device id
  o USB: port ipaq fix to 2.4
  o USB: fix up two locking issues in mdc800 and vicam drivers
  o USB: fix up some non-GPL friendly license wording

Harald Welte:
  o [NETFILTER]: Don't call ip_conntrack_put with ip_conntrack_lock held
  o [NETFILTER]: Fix UDP checksum in ip_nat_mangle_udp_packet, remove skb->csum hacks
  o [NETFILTER]: LOCAL_OUT NAT fix
  o [NETFILTER]: Fix SO_ORIGINAL_DST, broken by earlier endianness fixes

Ian Abbott:
  o USB: ftdi_sio - new vid/pid for OCT US101 USB to RS-232 converter

Ivan Kokshaysky:
  o Alpha: backport force_successful_syscall_return()

Jaroslav Kysela:
  o PageReserved memory counting fix

Jens Axboe:
  o laptop mode

Jes Sorensen:
  o Major qla1280 update

Jozsef Kadlecsik:
  o [NETFILTER]: Make conntrack timeouts become sysctls

Matt Domsch:
  o EDD: BIOS Enhanced Disk Drive Services 3.0 support

Oleg Drokin:
  o USB: devio.c memleak on unexpected disconnect
  o fix LVM memleaks

Olof Johansson:
  o Convert /proc/ioports to seqfile

Patrick McHardy:
  o [NETFILTER]: Use pre-built table for TCP flag-check in ipt_unclean

Paul Mackerras:
  o add Configure.help entries

Petr Vandrovec:
  o [IPV4]: Fix deadlock on ip_mc_list->lock

Rik van Riel:
  o page->flags corruption fix
  o page->flags corruption fix documentation

Rusty Russell:
  o [NETFILTER]: LOCAL_OUT NAT fix, part 2

Tom Rini:
  o PPC32: Add a 'uImage' target for U-Boot
  o PPC32: Fix dependancies on uImage
  o PPC32: Fixes to the MPC8xx uart driver, from Joakim Tjernlund <joakim.tjernlund@lumentis.se>
  o PPC32: Always print the processor number in /proc/cpuinfo
  o PPC: Change how we export some Openfirmware device nodes

Yokota Hiroshi:
  o NinjaSCSI driver update




