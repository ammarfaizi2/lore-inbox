Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266664AbUAWTTU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jan 2004 14:19:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266656AbUAWTTA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jan 2004 14:19:00 -0500
Received: from intra.cyclades.com ([64.186.161.6]:13011 "EHLO
	intra.cyclades.com") by vger.kernel.org with ESMTP id S266659AbUAWTSZ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jan 2004 14:18:25 -0500
Date: Fri, 23 Jan 2004 16:58:24 -0200 (BRST)
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
X-X-Sender: marcelo@logos.cnet
To: linux-kernel@vger.kernel.org
Subject: Linux 2.4.25-pre7
Message-ID: <Pine.LNX.4.58L.0401231652020.19820@logos.cnet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

Here goes -pre number 7 of 2.4.25 series.

It contains a bunch of architecture-specific updates (ia64, ppc, mips),
JFS and XFS updates, bugfix for big (>128GB) FAT filesystem corruption,
amongst others.

About 2.4 freeze:

The planned freeze during 2.4.26 can happen only for 2.4.27.

There are a few bad problems I'm aware of which still need to be fixed
(aic7xxx needs to be updated, modular IDE has some problems, etc). Those
should get fixed during 2.4.26-pre.

Please help testing! :)


Summary of changes from v2.4.25-pre6 to v2.4.25-pre7
============================================

<alex.williamson:hp.com>:
  o ia64: sba_iommu update
  o ia64: sba_iommu: use memparse, long double

<bjorn.helgaas:hp.com>:
  o ia64: work around a menuconfig bug
  o ia64: Fix system type selection to workaround menuconfig bug (select "HP", get "HP-simulator").
  o ia64: Fix broken merge (remove mmu_gathers[] defn)
  o ia64: Skip zero-length resources in PCI root bridge _CRS
  o ia64: sba_iommu: print note about reserving IOVA space for agpgart
  o ia64: Export acpi_hp_csr_space() for modular agpgart
  o ia64: Add acpi_register_irq() interface

<grundler:parisc-linux.org>:
  o obmouse driver for HP OB600 C/CT laptop

<jet:gyve.org>:
  o Fix hfs oops

<marcelo:logos.cnet>:
  o Changed EXTRAVERSION to -pre7

Adrian Bunk:
  o simplify PARPORT_PC_PCMCIA dependencies

Arun Sharma:
  o ia64: ia32 sigaltstack() fix

Atul Mukker:
  o megaraid2 update

Bjorn Helgaas:
  o ia64 HP iommu: add "sx1000" detection (no functional change)

Dave Kleikamp:
  o JFS: Avoid segfault when dirty inodes are written on readonly mount
  o JFS: Creating large xattr lists may cause BUG

Dean Roehrich:
  o [XFS] In xfs_bulkstat, we need to do the readahead loop always

Eric Sandeen:
  o [XFS] Fix for large allocation groups, so that extent sizes will not overflow pagebuf lengths.

Hirofumi Ogawa:
  o FAT: Support large partition (> 128GB)

Jack Steiner:
  o ia64: fix ia64_ctx.lock deadlock

Keith Owens:
  o ia64: fix deadlock in ia64_mca_cmc_int_caller()
  o ia64: Avoid double clear of CMC/CPE records

Manfred Spraul:
  o ldt optimization

Martin Hicks:
  o ia64: Move mmu_gathers[] to local_cpu_data on ia64 (only ia64-specific bits)

Matthew Wilcox:
  o ia64: Add generic RAID xor routines with prefetch

Petr Vandrovec:
  o Deep stack usage in ncpfs

Ralf Bächle:
  o MIPS updates
  o MIPS/DECstation video drivers update
  o Turbochannel driver updates

Rik van Riel:
  o some more fixes for fs/inode.c inode reclaiming changes

Seth Rohit:
  o ia64: hugetlb support (ia64-specific parts)

Stéphane Eranian:
  o ia64: Fix PFM_WRITE_PMCS failure in system-wide mode when PMC12 is zero

Tom Rini:
  o PPC32: Fix finding the MAC address on Motorola MBX860
  o PPC32: Fix the todc definitions for mc146818

Tony Luck:
  o ia64: enable recovery from TLB errors

