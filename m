Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261513AbUBYS0f (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Feb 2004 13:26:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261516AbUBYS0f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Feb 2004 13:26:35 -0500
Received: from intra.cyclades.com ([64.186.161.6]:57233 "EHLO
	intra.cyclades.com") by vger.kernel.org with ESMTP id S261513AbUBYSZp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Feb 2004 13:25:45 -0500
Date: Wed, 25 Feb 2004 16:09:20 -0300 (BRT)
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
X-X-Sender: marcelo@logos.cnet
To: linux-kernel@vger.kernel.org
Subject: Linux 2.4.26-pre1
Message-ID: <Pine.LNX.4.58L.0402251605360.5003@logos.cnet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Cyclades-MailScanner-Information: Please contact the ISP for more information
X-Cyclades-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

Here goes -pre1.

It contains a big SCTP merge (to match 2.6 API), networking updates,
network driver updates (including the addition of nVidia Force driver).

Also includes ACPI upstream merge, amongst others.

Enjoy

Summary of changes from v2.4.25 to v2.4.26-pre1
============================================

<amir.noam:intel.com>:
  o bonding cleanup 2.4 - Re-org struct bonding members
  o bonding cleanup 2.4 - Consolidate conditions & statements
  o bonding cleanup 2.4 - Consolidate error handling in all xmit functions
  o bonding cleanup 2.4 - Whitespace cleanup
  o bonding cleanup 2.4 - empty lines cleanup
  o bonding cleanup 2.4 - fix indentations
  o bonding cleanup 2.4 - Code re-org
  o bonding cleanup 2.4 - Fix rejects from previous patches
  o [netdrvr bonding] Cannot remove and re-enslave the original active slave
  o [netdrvr bonding] Releasing the original active slave causes mac address duplication
  o [netdrvr bonding] Add support for slaves that use ethtool_ops
  o [netdrvr bonding] fix build breakage
  o [bonding 2.4] Fix compilation warning in bond_alb.c
  o [bonding 2.4] Use the per-bond value of the bond_mode parameter
  o [bonding 2.4] Save parameters in a per-bond data structure
  o [bonding 2.4] Use the per-bond values of all remaining parameters

<bengen:hilluzination.de>:
  o HiSax I-Talk/I-Surf doesn't work together with kernel isapnp

<buffer:antifork.org>:
  o [TCP]: Add Westwood+ support, off by default

<c-d.hailfinger.kernel.2004:gmx.net>:
  o [2.4] forcedeth network driver

<davem:nuts.davemloft.net>:
  o [TCP]: Put tcp_ prefix on global westwood symbols
  o [TCP]: Coding style fixes to westwood code
  o [TCP]: Kill westwood specific lock, unneeded
  o [TCP]: Kill bogus reference to CONFIG_TCP_WESTWOOD
  o [IPV4]: Pass new forwarding setting to inet_forward_change()
  o [TG3]: Two more PHY bug workaround, plus fix DMA test on big-endian
  o [TG3]: Fix early chip programming in tg3_setup_copper_phy()
  o [TG3]: Bump driver version and reldate
  o [IPVS]: Use '%Z' for size_t types
  o [IPV6]: Fix data type range warning in ndisc.c
  o [TIGON3]: Comment out card RAM validation in tg3_test_dma() for now
  o [TIGON3]: Bump version and reldate

<giuseppe.furlan:systeam.it>:
  o Add Hitachi 9960 storage to SCSI dev list as SPARSELUN|LARGELUN

<grundler:parisc-linux.org>:
  o [TG3]: Reset GRC, if necessary, before DMA test
  o [TG3]: Abstract out mailbox workarounds into tw32_{rx,tw}_mbox()
  o [TG3]: Define MBOX_WRITE_REORDER flag to zero on non-x86

<ja:ssi.bg>:
  o [IPV4]: Add configurable restriction of local IP announcements in ARP requests
  o [IPV4]: Add sophistacated ARP reply control via arp_ignore sysctl

<jhf:rivenstone.net>:
  o [netdrvr sis900] fix multicast

<ken:miriam.com>:
  o [TIGON3]: Add Apple tigon3 PCI device id

<khali:linux-fr.org>:
  o Incorrect SCx200 dependency

<leachbj:bouncycastle.org>:
  o hfsplus alignment fix

<len.brown:intel.com>:
  o [ACPI] CONFIG_ACPI_NUMA depends on CONFIG_IA64
  o [ACPI] revert previous AML param patch for ACPICA update
  o [ACPI] ACPICA 20040211 udpate from Bob Moore

<marcelo:logos.cnet>:
  o Update i386 defconfig
  o Changed EXTRAVERSION to -pre1

<mporter:kernel.crashing.org>:
  o 2.4 ibm_emac driver fixes

<phil.el:wanadoo.fr>:
  o export smp_num_siblings cpu_sibling_map

<tigran:veritas.com>:
  o microcode: fix devfs breakage caused by last updated

<wang:ai.mit.edu>:
  o [wireless] add atmel driver

<wensong:linux-vs.org>:
  o [IPVS]: Remove the superfluous call of waitpid in sync code
  o [IPVS]: Fix to retry to fork kernel_thread when memory is temporarily exhausted
  o [IPVS] tidy up the header files to include

Adrian Bunk:
  o fix two IDE warnings
  o typo: HOSTCCFLAGS instead of HOSTCFLAGS in lib/Makefile

Bartlomiej Zolnierkiewicz:
  o kill recreate_proc_ide_device(),

Ben Collins:
  o IEEE1394/Video1394(r1152): Init d->link list head so failurs are handled properly
  o IEEE1394(r1153): Use vmalloc to allocate sglist array for larger cases

Benjamin Herrenschmidt:
  o [SUNGEM]: Be careful about memory ordering

David Dillow:
  o Support the new 3CR990B cards that require authentication of the runtime firmware image.

Geert Uytterhoeven:
  o Amifb modedb bug

Jeff Garzik:
  o [wireless airo] backport 2.6.x cleanups/minor fixes
  o [wireless airo] fix build breakage
  o [netdrvr sk98lin 1/2] Remove CVS substitution keywords/spam
  o [netdrvr sk98lin 2/2] Remove CVS substitution keywords/spam

Keith Owens:
  o Remove generated files

Manfred Spraul:
  o shrink address space reserved for kmap

Marcel Holtmann:
  o Fix for I4L over CAPI and CMTP

Matt Domsch:
  o fix lib/crc32.c copyright notice

Scott Feldman:
  o e1000 stable sync with 2.6

Shmulik Hen:
  o bonding cleanup 2.4 - Simplify ifenslave
  o bonding cleanup 2.4 - Consolidate prints
  o bonding cleanup 2.4 - death of typedefs
  o bonding cleanup 2.4 - remove dead code
  o bonding cleanup 2.4 - Consolidate timer handling
  o bonding cleanup 2.4 - Fix handling of bond->primary
  o bonding cleanup 2.4 - Remove multicast_mode module param
  o bonding cleanup 2.4 - Fix slave list iteration
  o bonding cleanup 2.4 - Consolidate function declarations
  o bonding cleanup 2.4 - consolidate param names of function params and variables
  o bonding cleanup 2.4 - consolidate return values of functions
  o [netdrvr bonding] trivial - Update comment blocks and version field
  o [IPV4]: Split arp_send into arp_create and arp_xmit
  o [VLAN]: Export VLAN tag get/set functionality
  o [VLAN]: Use VLAN tag set functionality in 8021q module

Sridhar Samudrala:
  o [SCTP] Sync with 2.6.2 SCTP
  o [SCTP] Use __get_free_pages() to allocate ssnmap
  o [SCTP] Fix SCTP_INITMSG set socket option so that a parameter with 0 value will not change its current value.
  o [SCTP] Fix sctp_getladdrs()/sctp_getpaddrs() API so that the port value in the returned addresses is in network byte order.
  o [SCTP] Revert back to use kmalloc() for ssnmap allocs of sizes < 128K
  o Cset exclude: sri@us.ibm.com|ChangeSet|20040216054112|09098
  o Cset include: sri@us.ibm.com|ChangeSet|20040216054112|09098 Cset include: sri@us.ibm.com|ChangeSet|20040213195328|09088 Cset include: sri@us.ibm.com|ChangeSet|20040213011231|09074 Cset include: sri@us.ibm.com|ChangeSet|20040213005510|09081 Cset include: sri@us.ibm.com|ChangeSet|20040213003759|09793
  o [SCTP] Fix syntax errors in net/sctp Config.in

Stelian Pop:
  o Fix meye compilation when HIGHMEM64G is set

Willy Tarreau:
  o fix ACPI poweroff

