Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263303AbUAFOXn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jan 2004 09:23:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263544AbUAFOXn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jan 2004 09:23:43 -0500
Received: from intra.cyclades.com ([64.186.161.6]:41404 "EHLO
	intra.cyclades.com") by vger.kernel.org with ESMTP id S263303AbUAFOXk convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jan 2004 09:23:40 -0500
Date: Tue, 6 Jan 2004 12:14:23 -0200 (BRST)
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
X-X-Sender: marcelo@logos.cnet
To: linux-kernel@vger.kernel.org
Subject: Linux 2.4.25-pre4
Message-ID: <Pine.LNX.4.58L.0401061159090.1207@logos.cnet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
X-Cyclades-MailScanner-Information: Please contact the ISP for more information
X-Cyclades-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

Moving on with the 2.4.24-pre tree, here is 2.4.25-pre4.

It contains an ext2/3 update (mostly forward compatibility related), the
usual architecture updates (this time S390, PPC64/32, SH), osst update,
TG3 bugfixes, amongst others.

Some of the fixes listed in this changelog (the rtc fixes, the IrDA "log
buster" fix and the netfilter MASQUERADE oops) were already in other
-pre's, they got removed and re added for technical BK reasons.

Summary of changes from v2.4.24-pre3 to v2.4.25-pre4
============================================

<bjorn.helgaas:hp.com>:
  o Fix 2.4 EFI RTC oops

<lethal:unusual.internal.linux-sh.org>:
  o sh/sh64: Add CONFIG_OOM_KILLER entries
  o sh: Add EXPEVT to pt_regs
  o sh64: Add dma.o to export-objs
  o sh64: shwdt updates

<marcelo.tosatti:cyclades.com>:
  o Andrea Arcangeli: malicious users of mremap() syscall can gain priviledges

<marcelo:logos.cnet>:
  o Harald Welte: Fix ipchains MASQUERADE oops
  o Change EXTRAVERSION to 2.4.24-rc1
  o Cset exclude: bjorn.helgaas@hp.com|ChangeSet|20031218183339|13120
  o Cset exclude: trini@mvista.com|ChangeSet|20031210203050|36304
  o Cset exclude: jt@bougret.hpl.hp.com|ChangeSet|20031213132008|01226
  o Cset exclude: laforge@netfilter.org|ChangeSet|20031204183256|31723
  o Change Makefile to 2.4.24-rc1

<trini:mvista.com>:
  o /dev/rtc can leak parts of kernel memory to unpriviledged users

David Engebretsen:
  o [PPC64] Store and use the ibm,phandle device-tree property from OF
  o [PPC64] Export Logical Partitioning config data to userspace

David S. Miller:
  o [TG3]: Update version and reldate

Erik Andersen:
  o fix broken 2.4.x rt_sigprocmask error handling

François Romieu:
  o [TG3]: Fix bogus return value in tg3_init_one()

Herbert Xu:
  o Handle j_commit_interval == 0

Hollis Blanchard:
  o [PPC64] Recognize new-style device-tree nodes for virtual terminals

Jean Tourrilhes:
  o IrDA kernel log buster

Kai Makisara:
  o SCSI tape bug fix (variable block mode,

Linus Torvalds:
  o Daniel Tram Lux: IDE timeout race fix

Martin Schwidefsky:
  o S390 base fixes
  o S390 common i/o layer fixes
  o S390: 31 bit compat bug fixes
  o S390: ctc network driver update
  o S390: xpram device driver
  o S390: DASD update

Oleg Drokin:
  o Fix megaraid leak survived by latest update

Olof Johansson:
  o [PPC64] Rename some RTAS-specific constants to avoid name clashes

Paul Mackerras:
  o [PPC64] Remove references to KDB since it isn't in the official tree
  o [PPC64] Fix compilation with CONFIG_SMP=n
  o [PPC64] Add include/asm-ppc64/iSeries/vio.h which was missed before
  o [PPC64] Add support for the VMX (aka Altivec) unit on the PPC970
  o [PPC64] Add CPU feature bits to indicate presence of breakpoint registers
  o [PPC64] Fix a few compile warnings and remove some dead code
  o [PPC64] Fix a bug in starting kernel threads
  o [PPC64] Set ELF_HWCAP to something useful: a bitmap of CPU features
  o [PPC64] Fix for periodic interrupts on iSeries with shared processors
  o [PPC64] Cope with slow RTC chips
  o [PPC64] Better handling of machine checks
  o [PPC64] Don't create /proc/rtas files for unimplemented services
  o [PPC64] Fix up bug in setting up the firmware features bitmap
  o [PPC64] Fix a compile error introduced with some recent changes

Theodore Y. T'so:
  o EXT2/3 Updates: Reclaim pages in truncate
  o EXT2/3 Updates: 2.6 EA symlink compatibility
  o EXT2/3 Updates: forward-compatibility: online resizing
  o EXT2/3 Updates: Allow filesystems with expanded inodes to be mounted

Tom Rini:
  o PPC32: Add support for the OpenPIC register set to be in BE mode
  o PPC32: Fix the floppy driver, on CONFIG_NOT_COHERENT_CACHE
  o PPC32: Fix a typo in two files
  o PPC32: Fix memory detection of PReP machines with OF

Willem Riede:
  o OnStream tape driver update

