Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263574AbUDFBPY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Apr 2004 21:15:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262750AbUDFBPY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Apr 2004 21:15:24 -0400
Received: from mail.cyclades.com ([64.186.161.6]:47536 "EHLO
	intra.cyclades.com") by vger.kernel.org with ESMTP id S263574AbUDFBPJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Apr 2004 21:15:09 -0400
Date: Mon, 5 Apr 2004 21:42:51 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: linux-kernel@vger.kernel.org
Subject: Linux 2.4.26-rc2
Message-ID: <20040406004251.GA24918@logos.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.5.1i
X-Cyclades-MailScanner-Information: Please contact the ISP for more information
X-Cyclades-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here goes the second release candidate. It contains an ACPI update,
networking updates, IDE updates, XFS update, etc.

Detailed changelog follows

Summary of changes from v2.4.26-rc1 to v2.4.26-rc2
============================================

<uaca:alumni.uv.es>:
  o [AF_PACKET]: Fix packet_set_ring memleak and remove num frame limit
  o [AF_PACKET]: Add PACKET_MMAP documentation

Andi Kleen:
  o Use correct optimization flag for Nocona on x86-64

Bartlomiej Zolnierkiewicz:
  o ATI IXP IDE support
  o hpt366.c: DMA timeout fix for HPT374

Chas Williams:
  o [ATM]: mpoa_proc warning cleanup (from Willy TARREAU <willy@w.ods.org>)

Christoph Hellwig:
  o [XFS] fix for read/write buffers larger than 2GB on 64 bit platforms
  o [XFS] Fix r/o check in xfs_ioc_space, fix checks on xfs_swapext validity

David S. Miller:
  o [IPV6]: Fix ipv6_skip_exthdr prototype in net/ipv6.h

David Stevens:
  o [IPV4]: Fix IGMPv3 timer initialization when device not 'upped'

Glen Overby:
  o [XFS] Add space for inode and allocation btrees to ITRUNCATE log reservation

Harald Welte:
  o [NETFILTER]: Fix DEBUG compile in ipt_MASQUERADE
  o [NETFILTER]: Fix DELETE_LIST oopses
  o [NETFILTER]: Fix circular conntrack header file dependency

Hideaki Yoshifuji:
  o [CREDITS]: Update my affiliation

Ivan Kokshaysky:
  o Workaround Alpha "gcc3 < 3.3.3" raid1 miscompilation problem

Len Brown:
  o [ACPI] allow building ACPI w/ CMPXCHG when CONFIG_M386=y http://bugzilla.kernel.org/show_bug.cgi?id=2391
  o [ACPI] delete extraneous IRQ->pin mappings below IRQ 16 http://bugzilla.kernel.org/show_bug.cgi?id=2408
  o [ACPI] PCI bridge interrupt fix (David Shaohua Li) http://bugzilla.kernel.org/show_bug.cgi?id=2409
  o [ACPI] Restore PIC-mode SCI default to Level Trigger (David Shaohua Li) http://bugme.osdl.org/show_bug.cgi?id=2382

Marcelo Tosatti:
  o Changed EXTRAVERSION to -rc2

Matt Porter:
  o PPC32: PPC44x updates (fixes and 440GX machine check support)
  o PPC32: Add new PPC44x PVRs

Meelis Roos:
  o SanDisk is flash

Mike Miller:
  o cciss update: support the new MSA30 storage enclosure
  o cciss update: If no device attached we return -ENXIO instead of some bogus numbers

Nathan Scott:
  o [XFS] Remove dup fdatasync/fdatawait call on fsync.  Means we no longer take the iolock here, and readers no longer conflict with concurrent fsync activity.  Kudos to Steve!
  o [XFS] Reinstate some accidentally dropped log IO error injection code
  o [XFS] Fix shortform attr flags botch affecting listxattr - from Andreas Gruenbacher
  o [XFS] Disallow logbufs=0 unless correct config options used, else we panic
  o [XFS] Ensure sb not flushed async on a SYNC_WAIT sync.  Fixed by Bart Samwel

Nathan Straz:
  o [XFS] Fix signed offset overflow when checking writes at end of file

Nivedita Singhvi:
  o [TCP]: Use tcp_tw_put on time-wait sockets
  o [TCP]: IPV6, do not use sock_put() on timewait sockets

Paul Mackerras:
  o [PPC64] Fix && vs. & error noticed by Julie DeWandel

Russell Cattelan:
  o [XFS] Use refile_buffer to not leave clean buffers on the dirty list

Sridhar Samudrala:
  o [SCTP]: Fix xconfig, from Vladislav Yasevich

Timothy Shimmin:
  o [XFS] Modify xfs_iaccess() for CAP_DAC_OVERRIDE and CAP_DAC_READ_SEARCH
  o [XFS] Be explicit in adding in the non-transactional data to the reservation estimate.  We must add in for the worst case of a log stripe taking us the full distance for a log stripe boundary.

Urban Widmark:
  o smbfs transact2 with win9x

Willy Tarreau:
  o [IPV6]: Make skb arg to ipv6_skip_exthdr const

