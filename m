Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262213AbUFZDr0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262213AbUFZDr0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Jun 2004 23:47:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265470AbUFZDrZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Jun 2004 23:47:25 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:60893 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262213AbUFZDrU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Jun 2004 23:47:20 -0400
Date: Sat, 26 Jun 2004 00:03:35 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: linux-kernel@vger.kernel.org
Subject: Linux 2.4.27-rc2
Message-ID: <20040626030335.GA30096@logos.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, 

Here goes the second release. 

It contains an XFS update, network update (bluetooth, bridge, netfilter),
usb gadget update, amongst others.

Fixes "clock time running twice as fast" issue which appeared in -rc1.



Summary of changes from v2.4.27-rc1 to v2.4.27-rc2
============================================

<glen:imodulo.com>:
  o Fix comment typo in nForce2 C1halt fixup

<skraw:ithnet.com>:
  o orinoco_pci.c new device 0x3872

Adrian Bunk:
  o add ATM_FORE200E_USE_TASKLET Configure.help entry
  o add missing E1000_NAPI Configure.help text
  o add SATA Configure.help texts

Christoph Hellwig:
  o [XFS] Don't leak locked pages on readahead failure

Dave Kleikamp:
  o jfs warning fix

David Brownell:
  o usb gadget API updates (1/5)
  o usb gadget zero updates (2/5)
  o usb file storage gadget updates (3/5)
  o usb ethernet+RNDIS gadget updates (4/5)
  o usb gadget build updates (5/5)

David S. Miller:
  o [PKT_SCHED]: Do not check netif_queue_stopped() in dequeue ops, races with driver
  o [NET]: Check __dev_get_by_name() return value in eql.c

David Stevens:
  o [IPV6]: Handle user asking for any device in mcast calls

Dean Roehrich:
  o [XFS] Change things to use new version of xfs_dm_init/xfs_dm_exit
  o [XFS] Fix non-dmapi build

Eric Sandeen:
  o [XFS] Fix overflow in mapping test at offsets of 2^63-1 bytes

Geert Uytterhoeven:
  o affs remount
  o Mac Sonic Ethernet fixes
  o Mac IOP: Fix bug found by Opera

Harald Welte:
  o [NETFILTER]: Fix non-existant config option
  o [NETFILTER]: Complain when broken ipt_owner options are used on SMP
  o [NETFILTER]: Change permissions of /proc/net/ip_conntrack to 0440
  o [NETFILTER]: skip internal targets in iptables proc listing
  o [NETFILTER]: Fix inverted matching in ipt_helper
  o [NETFILTER]: 'any' matching in ipt_helper
  o [NETFILTER]: Don't reroute on nfmark change in mangle table when routing by nfmark is not enabled
  o [NETFILTER]: Fix truncated fragment check in ipt_unclean
  o [NETFILTER]: Remove broken check for cleared IP_DF flag on fragments in ipt_unclean
  o [NETFILTER]: Add new function 'nf_reset' to reset netfilter related skb-fields

Hideaki Yoshifuji:
  o [IPV6]: Fix autoconf description in ip-sysctl.txt

Jeb J. Cramer:
  o e1000 management reset fix

Jeff Garzik:
  o [netdrvr] fix ethtool_ops design bug, sync with 2.6.x ethtool_ops code
  o Rename 'carmel' block driver to 'sx8'

Manfred Spraul:
  o yenta: Add override_bios flag to ignore BIOS resource allocation

Marcel Holtmann:
  o [Bluetooth] Kill duplicate includes
  o [Bluetooth] Update help entries
  o [Bluetooth] Allocate protocol number for HIDP support
  o [Bluetooth] Add quirk for broken RTX Telecom based dongles
  o [Bluetooth] Fix connection creation error handling

Marcelo Tosatti:
  o Geert Uytterhoeven: Fix warnings and cleanup debug_page() addded in -rc1
  o Al Viro sparse fixes: decnet user pointer dereference
  o Al Viro sparse fixes: mpu401 user pointer dereference
  o Al Viro sparse fixes: msnd user pointer dereference & assorted fixes
  o Al Viro sparse fixes: pss user pointer dereference
  o Al Viro sparse fixes: aironet
  o Al Viro sparse fixes: asus_acpi user pointer dereference
  o Changed EXTRAVERSION to -rc2

Matt Domsch:
  o edd.c display %u, remove REPORT_URL

Mikael Pettersson:
  o i386 and x86_64 ACPI mpparse timer bug

Nathan Scott:
  o [XFS] No longer hold the BKL for the entire ioctl operation, its not needed here.
  o [XFS] Remove a couple of redundant NULL parent inode pointer checks
  o [XFS] Fix xfs_lowbit64, it mishandled zero in the high bits
  o [XFS] sparse: fix uses of macros before their definitions, etc
  o [XFS] Ensure buffers that map to unwritten extents are only submitted when properly setup.
  o [XFS] Sanitise the ACL initialisation macros
  o [XFS] Remove unused MAC macros, never needed on Linux
  o [XFS] Remove the one remaining, broken use of XFS_WRITEIO_LOG and sanitize direct IO map blocks call.
  o [XFS] Fix flags argument to xfs_incore call on attr removal
  o [XFS] Fix a race condition in the undo-delayed-write buffer routine
  o [XFS] Fix up memory allocators to be more resilient
  o [XFS] Fix up error handling on inode shrink register
  o [XFS] Fix up memory reclaim interfaces for 2.4 kernels

Pete Zaitcev:
  o Lonnie Mendez: Remove USB extra #include

Russell Cattelan:
  o [XFS] Fix for NFS+XFS data corruption problem

Scott Feldman:
  o e1000: fix napi crash on ifdown during traffic

Stephen Hemminger:
  o [PKT_SCHED]: Delay scheduler enqueue always succeeds
  o [PKT_SCHED]: Delay scheduler should retry if requeue fails
  o [PKT_SCHED]: Add loss option to network delay scheduler
  o [BRIDGE]: Backport of API checking
  o [BRIDGE]: Elimintate br_ioctl_mutex

