Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261868AbTDUSib (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Apr 2003 14:38:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261877AbTDUSiI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Apr 2003 14:38:08 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:45711 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id S261868AbTDUSg6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Apr 2003 14:36:58 -0400
Date: Mon, 21 Apr 2003 15:47:32 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
X-X-Sender: marcelo@freak.distro.conectiva
To: lkml <linux-kernel@vger.kernel.org>
Subject: Linux 2.4.21-rc1
Message-ID: <Pine.LNX.4.53L.0304211545580.12940@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Here goes the first candidate for 2.4.21.

Please test it extensively.


Summary of changes from v2.4.21-pre7 to v2.4.21-rc1
============================================

<alborchers@steinerpoint.com>:
  o USB: patch for oops in io_edgeport.c

<arndt@lin02384n012.mc.schoenewald.de>:
  o USB: Patch against unusual_devs.h to enable Pontis SP600

<baldrick@wanadoo.fr>:
  o USB: uhci bandaid

<bryder@paradise.net.nz>:
  o USB: ftdi_sio update

<bwa@us.ibm.com>:
  o [SCTP/IPV6]: Move sockaddr storage and in6addr_{any,loopback} to generic places

<chas@cmf.nrl.navy.mil>:
  o [ATM]: Make ia64 include ATM driver config

<chas@locutus.cmf.nrl.navy.mil>:
  o [ATM]: Get lec net_device names correct
  o [ATM]: Obsolete some atm_vcc members
  o [ATM]: Fix idt77252/sch_atm/pppoatm compilation
  o [ATM]: cleanup nicstat, suni and idt77105
  o [ATM] nicstar doesnt count all dropped pdus and powerpc fixup
  o [ATM] s/uni driver overwrites 8-/16-bit mode
  o [ATM]: Fix total_len calculation in IPHASE driver
  o [ATM]: Fix IPHASE build with debugging enabled

<dlstevens@us.ibm.com>:
  o [IPV6]: Add anycast support

<gandalf@netfilter.org>:
  o [NETFILTER]: Fix modify-after-free bug in ip_conntrack

<gandalf@wlug.westbo.se>:
  o [NETFILTER]: Fix ipfwadm_core.c compile failure
  o [NETFILTER IPV6]: Fix Makefile typo

<green@linuxhacker.ru>:
  o [VLAN]: Fix memory leak in procfs handling

<henning@meier-geinitz.de>:
  o USB: scanner.c endpoint detection fix

<laforge@netfilter.org>:
  o [NETFILTER]: iptables iptable_mangle LOCAL_IN bugfix
  o [NETFILTER]: ipt_REJECT bugfix for TCP RST packets + asymm. routing

<legoll@free.fr>:
  o USB: New USB serial device ID: Asus A600 PDA cradle

<mb@ozaba.mine.nu>:
  o [NETFILTER]: Add tftp conntrack + NAT support

<mrr@nexthop.com>:
  o [IPV6]: Allow protocol to percolate up into rt6 routing operations

<netfilter@interlinx.bc.ca>:
  o [NETFILTER]: Add amanda conntrack + NAT support

<niv@us.ibm.com>:
  o [TCP]: Missing SNMP stats

<paulm@routefree.com>:
  o [NETFILTER]: ip_conntrack bugfix for LOCAL_NAT and PPTP

<riel@redhat.com>:
  o Fix kunmap_atomic debugging problem

<riel@surriel.com>:
  o [ATM]: Compile fix for net/atm/br2684.c

<soruk@eridani.co.uk>:
  o USB: enable Motorola cellphone USB modems

<swiergot@intersec.pl>:
  o Fix ac97 incomplete headers

<yoshfuji@nuts.ninka.net>:
  o [IPV6]: Use RFC2553 constant variable

Adrian Bunk <bunk@fs.tum.de>:
  o [NF/IPV6]: Remove all ipv6_ext_hdrs from ip6tables
  o [ATM]: Fix IPHASE driver build
  o Fix aic7xxx compilation

Alan Stern <stern@rowland.harvard.edu>:
  o USB: usb-storage START-STOP under Linux 2.4

Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>:
  o [IPV4]: Fix deadlock in IGMP locking
  o [IPV6]: Correct CHECKSUM_HW handling in tcp_v6_send_check

Andi Kleen <ak@muc.de>:
  o x86-64 update

Andreas Dilger <adilger@clusterfs.com>:
  o don't allocate/free blocks in system areas

Andries E. Brouwer <andries.brouwer@cwi.nl>:
  o compilation fix for 2.4.21-pre7
  o Fix SCSI size reporting

Ben Collins <bcollins@debian.org>:
  o IEEE-1394/Firewire update

Benjamin Herrenschmidt <benh@kernel.crashing.org>:
  o PPC32: Do better cache flushes around L2 cache ctrl register changes
  o PPC32: Factor out common code for saving/restore CPU special-purpose registers, used on SMP and for sleep/wakeup.
  o PPC32: Make sure IPI handlers run with interrupts disabled
  o PPC32: Add proper /proc/ide entry for pmac
  o PPC32: Update ide-pmac driver

Christoph Hellwig <hch@lst.de>:
  o [NETFILTER]: 2.4 firewalling compat code removal
  o [NET]: Backport generic fc_type_trans to 2.4

David Brownell <david-b@pacbell.net>:
  o USB: ehci-hcd, minor hardware tweaks
  o USB: usbcore deadlock paranoia
  o USB: CDC Ether fix notifications

David S. Miller <davem@nuts.ninka.net>:
  o [IPV6]: Undo __constant_{n,h}to{n,h}l from anycast patch
  o [SPARC64]: Fix trap stack allocations so gcc-3.x builds work
  o [SCHED]: Some schedulers forget to flush filter list at destroy
  o [PKTSCHED]: Fix double-define of __inline__ et al
  o [IP TUNNEL]: inet_ecn_decapsulate modifies bits in wrong header
  o [PKT_SCHED]: Remove ugly arch ifdefs from generic code
  o [NETFILTER IPV6]: Fix route leak in ip6_route_me_harder

Geert Uytterhoeven <geert@linux-m68k.org>:
  o Amiflop mod_timer()
  o Duplicate PROC_CONSOLE()
  o 2.4 IDE core code for m68k
  o 2.4 IDE driver code for m68k
  o M68k raw I/O updates
  o Generic RTC driver
  o M68k ndelay()
  o M68k needs WANT_PAGE_VIRTUAL

Hideaki Yoshifuji <yoshfuji@linux-ipv6.org>:
  o [IPV6]: Use "const" qualifier
  o [IPV6]: Use ipv6_addr_any() for testing unspecified address
  o [IPV6]: Don't allow multiple instances of the same IPv6 address on an interface
  o [IPV6]: Set noblock to 1 in NDISC sock_alloc_send_skb calls

James Morris <jmorris@intercode.com.au>:
  o [NET]: dst_clone --> dst_hold where appropriate
  o [PKTSCHED]: Kill redefinition of IPPROTO_ESP in sch_sfq.c

Jens Axboe <axboe@suse.de>:
  o Fix ide request races which resulted in corruption

Marcelo Tosatti <marcelo@freak.distro.conectiva>:
  o Cset exclude: mikpe@csd.uu.se|ChangeSet|20030417235935|56567
  o Add missing HPT366 ID
  o Updated EXTRAVERSION to -rc1

Mark A. Greer <mgreer@mvista.com>:
  o PPC32: Add support for SERIAL_IO_PORT ports to the gen550 backend

Mikael Pettersson <mikpe@csd.uu.se>:
  o fix dmi_scan breakage
  o fix APIC bus errors on SMP K7 boxes in UP mode

Oleg Drokin <green@angband.namesys.com>:
  o reiserfs: Fix recenly introduced journal sanity check that breaks replay on old filesystems
  o reiserfs: Fix for journal replay process, to only replay transactions from last mount. By Chris Mason

Oliver Neukum <oliver@neukum.org>:
  o Honour HFS lock bits

Paul Mackerras <paulus@samba.org>:
  o PPC32: Fix the interrupt entry path for POWER3 processors
  o PPC32: Clean up arch/ppc/mm/Makefile a little
  o PPC32: xmon fixes for CHRP, powerbooks, and SMP systems
  o PPC32: fix indentation in include/asm-ppc/bootinfo.h
  o PPC32: Restructure the top-level interrupt handling loop
  o PPC32: Align boot wrapper data segment on page boundary
  o PPC32: Make readb/w/l completely synchronous

Petko Manolov <petkan@users.sourceforge.net>:
  o USB: pegasus link status detection fix

Randy Dunlap <randy.dunlap@verizon.net>:
  o [NET]: typo and comment fixes

Randy Dunlap <rddunlap@osdl.org>:
  o update unexpected IO APIC detection

Rusty Russell <rusty@rustcorp.com.au>:
  o Fix minor NAT parsing issue

Stephen C. Tweedie <sct@redhat.com>:
  o 2.4: Fix for jbd compiler warnings

Tom Rini <trini@kernel.crashing.org>:
  o PPC32: Actually fix KGDB like Mark Greer mentioned
  o PPC32: Remove an option to partically disable the d-cache

