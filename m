Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262106AbVBJMZX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262106AbVBJMZX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Feb 2005 07:25:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262107AbVBJMZX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Feb 2005 07:25:23 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:40838 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S262106AbVBJMY7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Feb 2005 07:24:59 -0500
Date: Thu, 10 Feb 2005 06:40:28 -0200
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: linux-kernel@vger.kernel.org
Subject: Linux 2.4.30-pre1
Message-ID: <20050210084028.GF15888@logos.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here goes v2.4.30-pre1.

It contains, amongst others, a SATA update, series of networking bug fixes, 
and v2.6 hardening backports.


Please read the changelog for detailed information.

(this is the second announcement I'm sending because I haven't seen the first one 
hit LKML).


Summary of changes from v2.4.29 to v2.4.30-pre1
============================================

<akeptner:sgi.com>:
  o [TG3]: Always copy receive packets when 5701 PCIX workaround enabled

<albertcc:tw.ibm.com>:
  o [libata] SCSI-to-ATA translation fixes

<fli:ati.com>:
  o [libata sata_sil] support ATI IXP300/IXP400 SATA

<james4765:cwazy.co.uk>:
  o lcd: Add checks to CAP_SYS_ADMIN to potentially dangerous ioctl's
  o lcd: fix memory leak in lcd_ioctl()

<jason.d.gaston:intel.com>:
  o SATA AHCI support for Intel ICH7R

<jpaana:s2.org>:
  o [libata sata_promise] add PCI ID for new SATAII TX2 card

<krzysztof.h1:wp.pl>:
  o [SPARC]: Fix asm constraints in muldiv.c

<mark.haigh:spirentcom.com>:
  o sym53c8xx.c: Add ULL suffix to fix warning
  o arch/i386/kernel/pci-irq.c: Wrong message output

<mkrikis:yahoo.com>:
  o fix an oops in ata_to_sense_error
  o libata: fix ata_piix on ICH6R in RAID mode

<npollitt:mvista.com>:
  o Configure mangles hex values

<syntax:pa.net>:
  o [libata sata_sil] add another Seagate drive to blacklist

Adrian Bunk:
  o scsi/ahci.c: remove an unused function

Andrew Chew:
  o sata_nv: enable generic class support for future NVIDIA SATA

Brett Russ:
  o [libata scsi] verify cmd bug fixes/support

Chris Wright:
  o Fix potential leak of kernel data to user space in wireless private handler helper

David S. Miller:
  o [TG3]: Update driver version and reldate
  o [TG3]: Update driver version and reldate
  o [TG3]: Update driver version and reldate
  o [TG3]: Update driver version and reldate
  o [SPARC64]: __atomic_{add,sub}() must sign-extend return value
  o [TG3]: Update driver version and reldate
  o [SPARC64]: atomic and bitop fixes
  o [SPARC64]: Add missing membars for xchg() and cmpxchg()
  o [SPARC64]: Add missing membars for xchg() and cmpxchg()
  o [SPARC64]: Mask off stack ptr in alloc_user_space() for 32-bit
  o [TG3]: Update driver version and reldate

Ernie Petrides:
  o fix for memory corruption from /proc/kcore access

Grant Grundler:
  o [TG3]: Clean up grc_local_ctrl usage

Haroldo Gamal:
  o [libata sata_sil] add another Seagate driver to blacklist

Heinz J. Mauelshagen:
  o fix panics while backing up LVM snapshots

Herbert Xu:
  o [NET]: Add missing memory barrier to kfree_skb()
  o [NET]: Add barriers for dst refcnt

Jean Delvare:
  o PCI: Kill duplicate definition of INTEL_82801DB_10
  o I2C updates: The "bit" and "pcf" i2c algorithms should declare themselves fully I2C capable
  o I2C updates: small header cleanups
  o I2C updates: Document that the "id" member of the i2c_client structure was discarded in Linux 2.6

Jeff Garzik:
  o [libata] add DMA blacklist
  o [libata] Remove CDROM drive from PATA DMA blacklist
  o [libata sata_promise] support Promise SATAII TX2/TX4 cards
  o [libata ahci] Add support for ULi M5288

Len Brown:
  o [ACPI] via interrupt quirk fix from 2.6 http://bugzilla.kernel.org/show_bug.cgi?id=3319

Luca Tettamanti:
  o Fix MSF overflow in ide-cd with multisession DVDs

Marcelo Tosatti:
  o Karsten Keil: Eicon Diva PCI 2.02 bugfix
  o Cset exclude: temnota@kmv.ru|ChangeSet|20050119161632|63236
  o Ake Sandgren: Fix RLIMIT_RSS madvise calculation bug
  o Cset exclude: dan@embeddedalley.com|ChangeSet|20050128083257|00819
  o Hugh Dickins: remove rlim_rss and this RLIMIT_RSS code from madvise. Presumably the code crept in by mistake
  o Changed VERSION to 2.4.30-pre1
  o Linus Torvalds: backport 2.6 rw_verify_area() to check against file offset overflows
  o Linus Torvalds: Add extra debugging help for bad user accesses
  o Solar Designer: missing f_maxcount initialization
  o Cset exclude: Mark.Haigh@spirentcom.com|ChangeSet|20050203152306|59941
  o rw_verify_area() cleanup
  o Cset exclude: alanh@fairlite.demon.co.uk|ChangeSet|20050209150113|54411

Matthew Wilcox:
  o [IPV4]: ipconfig should use memmove() instead of strcpy()

Michael Chan:
  o [TG3]: add tg3_set_eeprom()
  o [TG3]: Fix TSO for 5750
  o [TG3]: 5750 fixes
  o [TG3]: 5704 serdes fixes

Michal Ostrowski:
  o [MAINTAINERS]: Fix my email address in PPPOE entry

Patrick McHardy:
  o [IPV4]: Keep fragment queues private to each user
  o [NETFILTER]: Fix ip_fw_compat.c build after IP_DEFRAG_* changes

Paul Clements:
  o nbd: fix ioctl permissions

Pete Zaitcev:
  o USB: Prevent hiddev from looping
  o USB: Workarounds for Genesys Logics
  o [libata] fix probe object allocation bugs

Rogier Wolff:
  o Rogier Wolff: fix nbd ioctl permissions

Stephen Hemminger:
  o [PKT_SCHED]: netem: memory leak

Thomas Graf:
  o [NET]: Set NLM_F_MULTI for neighbour rtnetlink messages to userspace
  o [PKT_SCHED]: Fix ingress qdisc to pick up IPv6 packets when using netfilter hooks
  o [NETLINK]: Use SKB_MAXORDER to calculate NLMSG_GOODSIZE

Tom Rini:
  o ppc32: Fix a problem with the TLB Miss handler

