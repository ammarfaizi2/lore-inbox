Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261407AbUKGUzX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261407AbUKGUzX (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Nov 2004 15:55:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261637AbUKGUzX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Nov 2004 15:55:23 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:56495 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261407AbUKGUzE convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Nov 2004 15:55:04 -0500
Date: Sun, 7 Nov 2004 15:37:53 -0200
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: linux-kernel@vger.kernel.org
Subject: Linux 2.4.28-rc2
Message-ID: <20041107173753.GB30130@logos.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
User-Agent: Mutt/1.5.5.1i
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here goes the second release canditate of 2.4.28.

It contains a network update (which is composed of several smaller changes 
- IPVS, SCTP, Netfilter), a collection of ACPI bugfixes, a SMBFS client 
buffer overflow fix (which is very hard to exploit - the attacker needs to 
control packets from the server), amongst others.

This is going to be become 2.4.28 if nothing bad shows up.

Please help with testing! 


Summary of changes from v2.4.28-rc1 to v2.4.28-rc2
============================================

<arnouten:bzzt.net>:
  o [TCP]: Add /proc/net/tcp{,6} layout documentation

<lkml:rtr.ca>:
  o delkin_cb: new carbus IDE driver

<ruber:engr.es>:
  o [CRYPTO]: Add Tnepres cipher support

Aaron Grothe:
  o [CRYPTO]: Put khazad back into tcrypt table

Adrian Bunk:
  o add SCSI_SATA_ULI help text
  o Adrian Bunk CREDITS entry

Andrea Arcangeli:
  o [NET]: Accept should return ENFILE not EMFILE

Chris Wright:
  o compile fix for neighbour scalability backport
  o compile fix for neighbour scalability backport

David S. Miller:
  o [PKT_SCHED]: sch_netem.c needs linux/init.h
  o [AF_UNIX]: Remove spurious len test in unix_mkname
  o [CRYPTO]: Fix typo in Kconfig
  o [TG3]: Update driver version and reldate
  o [AF_PACKET]: Set VM_IO for mmap areas
  o [CRYPTO]: Delete MODULE_ALIAS line

Eric Sandeen:
  o fix for large direct I/O

Greg Banks:
  o [NET]: Fix race between neigh-timer_handler and neigh_event_send

Harald Welte:
  o [NET]: Backport neighbour scalability fixes from 2.6.x
  o [NETFILTER]: fix ipt_ULOG bogus error messages

Ivan Kokshaysky:
  o Alpha: fixes for bootp/bootpz targets

James Morris:
  o [CRYPTO]: Add __init and __initdata to aes.c

Keith Owens:
  o Avoid oops in proc_delete_inode

Len Brown:
  o [ACPI] reserve IOPORTS for ACPI (David Shaohua Li) http://bugzilla.kernel.org/show_bug.cgi?id=2641
  o [ACPI] boot option fixes from 2.6 "acpi_serialize" "acpi_wake_gpes_always_on" "acpi_osi=" http://bugzilla.kernel.org/show_bug.cgi?id=2534
  o set acpi_gbl_leave_wake_gpes_disabled to FALSE for 2.4 because it would take a backport of big 2.6 changes to make this code work and 2.4 doesn't support suspend/resume anyway.
  o [ACPI] Enter ACPI mode earlier Fixes two common boot failures due to buggy SMM BIOS code
  o [ACPI] fix build warnings
  o [ACPI] build fix
  o [ACPI] If BIOS disabled the LAPIC, believe it by default

Maciej W. Rozycki:
  o [NET]: Fix fddi_statistics for 64-bit
  o [IPV4]: Set ARP hw type correctly for BOOTP over FDDI
  o [IPV4]: Permit the official ARP hw type in SIOCSARP for FDDI

Marcelo Tosatti:
  o Jakub Bogusz: missing include in farsync WAN driver
  o mcp: Fix proc_delete_inode oops bug correction typo
  o Urban Widmark: Fix smbfs client overflow
  o Changed EXTRAVERSION to -rc2

Patrick Caulfield:
  o [DECNET]: Mark myself as maintainer

Patrick McHardy:
  o [PKT_SCHED]: Fix netem qlen accounting

Paul Fulghum:
  o serial receive lockup fix
  o usb serial write fix

Pete Zaitcev:
  o USB: update unusual_devs.h

Randy Dunlap:
  o [TG3]: tg3_nvram_read_using_eeprom cannot be __init

Sridhar Samudrala:
  o [SCTP] Adaption layer indication support
  o [SCTP] Update cwnd/ssthresh as per the sctpimpguide modifications
  o [SCTP] When an address is deleted, update any transports that are caching it as a source adddress.
  o [SCTP] Fix HEARTBEAT_ACKs being sent to wrong dest. ip address in a multi-homing scenario after a failback.

Stephen Hemminger:
  o [PKT_SCHED]: netem: Use timer to handle packets not rescheduling

Thomas Graf:
  o [PKT_SCHED]: Remove useless line in cbq_dump_class
  o [PKT_SCHED]: Make rate estimator work on all platforms
  o [PKT_SCHED]: CBQ; Destroy filters before destroying classes
  o [PKT_SCHED]: u32: Remove unused hgenerator field in tc_u_hnode
  o [PKT_SCHED]: Avoid duplicated TCA_STATS TLVs for HTB and HFSC
  o [PKT_SCHED]: Rename TCQ_F_INGRES to TCQ_F_INGRESS
  o filemap.c compile fix

Wensong Zhang:
  o [IPVS]: Fix endian problem on sync message size

Özkan Sezer:
  o 2.6 backport: binfmt_elf memleak fix error handling
  o 2.6 backport: tun sign mishandling

