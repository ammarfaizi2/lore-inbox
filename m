Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261576AbUCFTWQ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Mar 2004 14:22:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261635AbUCFTWQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Mar 2004 14:22:16 -0500
Received: from mikonos.cyclades.com.br ([200.230.227.67]:59153 "EHLO
	firewall.cyclades.com.br") by vger.kernel.org with ESMTP
	id S261576AbUCFTWL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Mar 2004 14:22:11 -0500
Date: Sat, 6 Mar 2004 16:20:55 -0300 (BRT)
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
X-X-Sender: marcelo@dmt.cyclades
To: linux-kernel@vger.kernel.org
Subject: Linux 2.4.26-pre2
Message-ID: <Pine.LNX.4.44.0403061618420.4428-100000@dmt.cyclades>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Hi, 

Here goes -pre2 -- it contains networking updates, network drivers 
updates, an XFS update, amongst others.

Detailed changelog follows

Summary of changes from v2.4.26-pre1 to v2.4.26-pre2
============================================

<dolbeau:irisa.fr>:
  o Small fix to pm3fb & MAINTAINERS

<i.palsenberg:jdirmedia.nl>:
  o [QLOGIC]: Mark mbox_param[] as static to avoid namespace pollution

<jon:focalhost.com>:
  o [CRYPTO]: Add ARC4 module

<jpk:sgi.com>:
  o [XFS] Merge missing mount stripe-unit/width-alignment check over from IRIX

<mlord:pobox.com>:
  o Fix vmalloc() error handling

Chas Williams:
  o [ATM]: [lec] timer cleanup
  o [ATM]: [lec] send queued packets immediately after path switch

Christoph Hellwig:
  o [XFS] Simplify pagebuf_rele / pagebuf_free
  o [XFS] Stop using sleep_on
  o [XFS] Plug a pagebuf race that got bigger with the recent cleanup
  o [XFS] Fix gcc 3.5 compilation for real
  o [XFS] Fix buffer teardown on _pagebuf_lookup_pages failure
  o [XFS] Remove the lockable/not lockable buffer distinction.  All metada buffers are lockable these days.
  o [XFS] Remove PBF_MAPPABLE
  o [XFS] plug a pagebuf leak
  o [XFS] "backport" d_alloc_anon (this time for real)
  o [XFS] Avoid NULL returns from pagebuf_get
  o [XFS] use generic XFS stats and sysctl infrastructure in pagebuf
  o [XFS] Fix up daemon names
  o [XFS] only lock pagecache pages
  o [XFS] plug race in pagebuf freeing
  o [XFS] kill some dead constants from pagebuf

David S. Miller:
  o [SUNGEM]: At end of RX completion chain, double check OWN bit with completion register
  o [IPV4]: Do not return -EAGAIN on blocking UDP socket, noticed by Olaf Kirch
  o [NET]: Set default socket rmem/wmem values more sanely and consistently
  o [IPV6]: UDPv6 needs recvmsg csum error path fix too, thanks Olaf
  o [SCTP]: Ranem MSECS_TO_JIFFIES to avoid conflict with IRDA
  o [SCTP]: Comment out buggy ipv6 debugging printk
  o [SPARC64]: Update defconfig
  o [SPARC]: Pass a real page into do_mount() a final arg
  o [SPARC]: Update defconfig

David Stevens:
  o [IGMP/MLD]: Verify MSFILTER option length
  o [IGMP/MLD]: Check for numsrc overflow, plus temp buffer tweaks

David Woodhouse:
  o [IPV6]: Init ipv6 before ipv4 if built statically into kernel

Dean Roehrich:
  o [XFS] Change DM_SEM_FLAG to DM_SEM_FLAG_RD

Don Fry:
  o 2.4.25 pcnet32.c SLAB_DEBUG length error fix
  o 2.4.25 pcnet32.c transmit hang fix
  o 2.4.25 pcnet32.c wrong vendor ID fix
  o 2.4.25 pcnet32.c oops in rmmod
  o 2.4.25 pcnet32.c bus master arbitration failure fix
  o 2.4.25 pcnet32.c convert to use netif_msg_*
  o 2.4.25 pcnet32.c change to use ethtool_ops
  o pcnet32.c handle failures in open
  o pcnet32.c another diff error fix
  o pcnet32.c non-mii errors with ethtool
  o pcnet32.c add .remove to pci_driver
  o pcnet32.c adds loopback test
  o pcnet32.c avoid transmit hang for 79C791
  o pcnet32 non-mii link state fix

Eric Sandeen:
  o [XFS] Add switches to make xfs compile when the nptl patch is present
  o [XFS] Remove some dead debug code
  o [XFS] Make more xfs errors trappable with panic_mask
  o [XFS] zero log buffer during initialization at mount time

François Romieu:
  o [netdrvr r8169] fix TX descriptor overflow

Geert Uytterhoeven:
  o [netdrvr tulip] fix up 21041 media selection

Harald Welte:
  o [NETFILTER]: Kill bogus const in list helpers
  o [NETFILTER]: Fix ECN target cloned skb problem
  o [NETFILTER]: Remove unused structure member in NAT, from Patrick McHardy

James Morris:
  o [CRYPTO]: Backport Christophe Saout's 2.6.x scatterlist code extraction

Jean Delvare:
  o Identify Radeon Ya and Yd in radeonfb

Len Brown:
  o ACPI URL update
  o [ACPI] interrupt over-ride for nforce from Maciej W. Rozycki
  o [ACPI] delete unnecessary dmesg lines, fix spelling
  o [ACPI] include CONFIG_ACPI_RELAXED_AML code always add acpi=strict option to disable platform workarounds
  o [ACPI] ACPICA 20040220 from Bob Moore
  o [ACPI] fix ia64 build error (Bjorn Helgaas)

Marcelo Tosatti:
  o devfs: Fix truncation of mount data as 2.6
  o Changed EXTRAVERSION to -pre2

Matthias Andree:
  o [NET]: Export sysctl_optmem_max to modules

Nathan Scott:
  o [XFS] Fix a trivial compiler warning, remove some no-longer-used macros
  o [XFS] Use list_move for moving pagebufs between lists, not list_add/list_del
  o [XFS] Fix compile warning, ensure _pagebuf_lookup_pages return value is inited
  o [XFS] Fix data loss when writing into unwritten extents while memory is being reclaimed
  o [XFS] Remove bogus assert I added during testing of previous unwritten fix
  o [XFS] Add I/O path tracing code, twas useful in diagnosing that last unwritten extent problem
  o [XFS] Use a naming convention here thats more consistent with everything else
  o [XFS] Fix BUG in debug trace code, it was plain wrong for the unmapped page case
  o [XFS] Fix the by-handle attr list interface (used by xfsdump) for security attrs
  o [XFS] Fix length of mount argument path strings, off by one
  o [XFS] release i_sem before going into dmapi queues
  o [XFS] Remove PBF_SYNC buffer flag, unused for some time now
  o [XFS] Sort out some minor differences between trees
  o [XFS] Fix a compiler warning from a redefined symbol

Shmulik Hen:
  o bonding: Add support for HW accel. slaves
  o bonding: Add VLAN support in TLB mode
  o bonding: Add VLAN support in ALB mode

Simon Barber:
  o [NET]: Capture skb->protocol after invoking bridge

Simon Horman:
  o [JHASH]: Make key arg const in jhash()

Sridhar Samudrala:
  o [SCTP] Fix packed attribute usage
  o [SCTP] Fix NIP6 macro to take a ptr to struct in6_addr
  o [SCTP] Fix incorrect INIT process termination with sinit_max_init_timeo

Timothy Shimmin:
  o [XFS] Add XFS_FS_GOINGDOWN interface to xfs
  o [XFS] Fix log recovery case when have v2 log with size >32K and we have a Log Record wrapping around the physical log end. Need to reset the pb size back to what we were using and NOT just 32K.
  o [XFS] Version 2 log fixes - remove l_stripemask and add v2 log stripe padding to ic_roundoff to cater for pad in reservation cursor updates.
  o [XFS] fix up some log debug code for when XFS_LOUD_RECOVERY is turned on

Xose Vazquez Perez:
  o more RTL-8139 clone boards
  o more ne2k-pci clone boards

Yasuyuki Kozakai:
  o [IPV6]: Fix frag hdr parsing in ipv6_skip_exthdr()
  o [IPV6]: Fix ip6_tables TCP/UDP matching when ipv6 ext hdr exists


