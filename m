Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262813AbTJASJp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Oct 2003 14:09:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263205AbTJASJJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Oct 2003 14:09:09 -0400
Received: from intra.cyclades.com ([64.186.161.6]:12778 "EHLO
	intra.cyclades.com") by vger.kernel.org with ESMTP id S263171AbTJASH6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Oct 2003 14:07:58 -0400
Date: Wed, 1 Oct 2003 14:44:18 -0300 (BRT)
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
X-X-Sender: marcelo@dmt.cyclades
To: linux-kernel@vger.kernel.org
Subject: Linux 2.4.23-pre6
Message-ID: <Pine.LNX.4.44.0310011434400.6488-100000@dmt.cyclades>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

Here goes -pre6. 

It contains several ACPI fixes (the USB "not working anymore" problems in
-pre5 should be gone), support for the SCTP protocol, x86-64/PPC/SH
merges, network drivers update (EMAC, e1000, sk98lin), megaraid update,
amongst others.

Enjoy :) 

Summary of changes from v2.4.23-pre5 to v2.4.23-pre6
============================================

<dfages:arkoon.net>:
  o [NET]: Fix HW_FLOWCONTROL on SMP

<galak:blarg.somerset.sps.mot.com>:
  o Added "user64" versions of the user access functions that allow modification of 64-bit data.
  o PPC32: Added "user64" versions of the user acess functions that allow modification of 64-bit data.
  o PPC32: Added big-endian cfg_addr access
  o PPC32: Simplified handling of big/little endian pci indirect access

<marcelo:dmt.cyclades>:
  o Dave Jones: Fix cache size of Centrino CPU
  o Changed EXTRAVERSION to -pre6

<moilanen:austin.ibm.com>:
  o Workaround PPC64 PCI scan issue

<mpm:selenic.com>:
  o netif_carrier_* support for tlan

Alexander Viro:
  o Convert /proc/<pid>/maps to seqfile

Andi Kleen:
  o x86-64 merge
  o AGP Updates for K8
  o /proc/kcore  fixes for x86-64
  o Add 3GB personality for x86-64
  o Use MTRR in vesafb by default on x86-64
  o Support 32bit uids on x86-64
  o Remove IORR manipulation in agpgart nvidia drivers

Atul Mukker:
  o Update megaraid driver to 1.18k

Chas Williams:
  o [ATM]: [clip] Fix race between modifying entry->vccs and clip_start_xmit()
  o [ATM]: Split atm_ioctl into vcc_ioctl and atm_dev_ioctl
  o [ATM]: Cleanup atm_dev_ioctl a bit (from mitch@sfgoth.com)
  o [ATM]: Implement pppoatm_ioctl_hook for pppoatm
  o [ATM]: Implement br2684_ioctl_hook for br2684
  o [ATM]: [he] Possibly using corrupted structure (from felipewd@terra.com.br)
  o [ATM]: Update link in documentation

Damien Morange:
  o [SCTP] LKSCTP 0.6.9 backport on kernel 2.4 patch #1
  o [SCTP] LKSCTP 0.6.9 backport on kernel 2.4 patch #2
  o [SCTP] LKSCTP 0.6.9 backport on kernel 2.4 patch #3

David S. Miller:
  o [NET]: Increase ethernet tx_queue_len to 1000
  o [IPV4]: Fix route leak in igmp.c
  o [SCTP]: Do not redefine SMTP stat inc macros
  o [SCTP]: Include linux/crypto.h as needed
  o [NET]: Unlink qdiscs in qdisc_destroy even when CONFIG_NET_SCHED is not enabled
  o [IPV4]: In arp_rcv() do not inspect ARP header until packet length and linearity is verified

Harald Welte:
  o [NETFILTER]: Fix ipt_REJECT when used in OUTPUT
  o [NETFILTER]: In ipt_REJECT handle various hooks correctly in route_reverse()

Ivan Kokshaysky:
  o Alpha update

Jamal Hadi Salim:
  o [NET]: Make pfifo_fast actually report statistics

Jeff Garzik:
  o [wireless airo] Fix build

Jens Axboe:
  o cdrom memory leak

John Stultz:
  o Fix boot code overflow with more CPUs than CONFIG_NR_CPUS

Krishna Kumar:
  o [IPV6]: Export ipv6_devconf via netlink

Larry McVoy:
  o Add pre-apply.paranoid trigger from the Linux 2.5 tree

Len Brown:
  o [ACPI] For ThinkPad -- carry on in face of ECDT probe failure (Andi Kleen)
  o [ACPI] ACPI Component Architecture 20030918 (Bob Moore)
  o [ACPI] CONFIG_ACPI is no longer necessary to enable HT if (CONFIG_ACPI || CONFIG_SMP) CONFIG_ACPI_BOOT=y
  o [ACPI] acpi_pci_link_allocate() should stick with irq.active if set.  (Andrew de Quincey) Fixes OSDL #1186 "broken USB" and others
  o [ACPI] acpi4asus-0.24a-0.25-2.4 (Karol Kozimor)
  o [ACPI] acpi4asus-0.25-0.26 (Karol Kozimor)
  o [ACPI] build fix: remove 2nd __exit from asus_acpi.c
  o [ACPI] deal with lack of acpi prt entries gracefully (Jesse Barnes)

Marcelo Tosatti:
  o Removed unused label in page_alloc.c

Matt Porter:
  o PPC32: Fix 44x _PMD_PRESENT bug
  o PPC32: Use CONFIG_PTE_64BIT instead of CONFIG_44x where appropriate
  o 2.4 IBM EMAC updates

Matthew Wilcox:
  o [NETFILTER]: Use net/checksum.h instead of asm/checksum.h

Mike Miller:
  o cciss support more than 8 controllers

Mirko Lindner:
  o sk98lin-2.4: Remove useless configure options
  o sk98lin-2.4: Readme version update

Paul Mundt:
  o sh: shmse updates
  o sh: div64 backport and random cleanups
  o sh: Add bzImage support
  o sh: sh-sci updates
  o [sh64] Add a new configure option + support code to provide a /proc/asids file
  o sh64: Fixup unaligned accesses
  o sh: Interim cache coherency fix for 2-way caches
  o sh64: Fix CONFIG_SH64_USER_MISALIGNED_FIXUP compile error

Scott Feldman:
  o [e1000] cleanup error return codes
  o [e1000] Add PHY master/slave #define override
  o [e1000] add ethtool flow control support
  o [e1000] move static to table from .h to .c
  o [e1000] Turn off ASF support on Fiber nics
  o [e1000] make function out of setting media type
  o [e1000] sync w/ 2.6 e1000 driver
  o [e1000] read correct bit from EEPROM for getting WoL settings
  o [e1000] new 82541/5/6/7 hardware support
  o [e1000] misc whitespace cleanup, changelog
  o [e1000] 82544 PCI-X hang fix + TSO updates

Sean McGoogan:
  o bug fix: preserve EXPEVT across nested interrupts
  o bug fix: ensure FPSCR.PR == FPSCR.SZ == 1 never occurs
  o provide support for SH4-202 chip
  o Addition of support for the SuperH SH4-202 MicroDev CPU Board

Tom Rini:
  o PPC32: Add CONFIG_ADVNACED_OPTIONS to make the kernel more flexible
  o PPC32: Make ISA support a question on CONFIG_ALL_PPC
  o PPC32: Add the D-Box2 MPC8xx board
  o PPC32: Misc changes for the D-Box2
  o PPC32: Fix a multiple definition problem in the bootwrapper
  o PPC32: UART support and configuration updates from Gary Thomas
  o PPC32: Add a potential bugfix to the MPC8xx uart driver, by way of Dan Malek
  o PPC32: Update MPC8xx code so that it uses consistent_alloc
  o PPC32: Fix KGDB on MPC8xx targets with one serial port



