Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268618AbTGIWNI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jul 2003 18:13:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268615AbTGIWNH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jul 2003 18:13:07 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:21148 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id S268619AbTGIWM0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Jul 2003 18:12:26 -0400
Date: Wed, 9 Jul 2003 19:24:40 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
X-X-Sender: marcelo@freak.distro.conectiva
To: lkml <linux-kernel@vger.kernel.org>
Subject: Linux 2.4.22-pre4
Message-ID: <Pine.LNX.4.55L.0307091918400.5325@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

Here goes -pre4. It contains a lot of updates and fixes.

We decided to include this new code quota code which allows usage of
quotas with 32bit UID/GIDs.

Most Toshibas should work now due to an important ACPI fix.

Please help and test.


Summary of changes from v2.4.22-pre3 to v2.4.22-pre4
============================================

<dtor_core@ameritech.net>:
  o [NET] Attach inner qdiscs to TBF

<lethal@linux-sh.org>:
  o sh64: Add FIOQSIZE definition
  o sh64: Fixup Cayman IRQ reporting
  o sh64: SH-5 PCI updates
  o sh64: Fix privileged insn handling
  o sh64: IDE support

<lode_leroy@hotmail.com>:
  o [IPV4] display bootserver in /proc/net/pnp

<lunz@falooley.org>:
  o [NET] Fix refcounting of dev->promiscuity for af_packet

<m.c.p@wolk-project.de>:
  o [RESEND 5th] Fix oom killer braindamage

<stelian@popies.net>:
  o Export 'acpi_disabled' symbol to modules

Alan Cox <alan@lxorguk.ukuu.org.uk>:
  o Make ACPI work on lots more boxes
  o config for new Nvidia AGP
  o parisc sync up (resend of resend of resend ... 8))
  o AGP update - new intel, add nvidia
  o ebda check in ibm hotplug is insufficient
  o update mpt fusion driver
  o fix the eexpress
  o move sdla to mod_timer
  o add code for missing c7000 driver
  o resend - fix security bits in binfmt_exec/som
  o re-fix printk level for buffer cachehash
  o exec part of security fix
  o fix inverted dnotify
  o fix definition of boot_DT
  o add the new agp modes to the headers
  o kernel/fork helper for exec security fix
  o S/390 CLAW bits
  o fix up z85230 queue wake logic

Benjamin Herrenschmidt <benh@kernel.crashing.org>:
  o ppc32: Fix races in low level adb drivers

Christoph Hellwig <hch@infradead.org>:
  o quota patch breaks kernel build

Christoph Hellwig <hch@lst.de>:
  o new quota code
  o fix Q_SYNC for dev == 0

David S. Miller <davem@nuts.ninka.net>:
  o [SPARC64]: sys_sparc32.c needs linux/quotacompat.h
  o [FS]: Provide unshare_files() declaration and export to modules
  o [SPARC]: SEMTIMEDOP for both Sparc ports

Marcelo Tosatti <marcelo@freak.distro.conectiva>:
  o Cset exclude: rusty@rustcorp.com.au|ChangeSet|20030707182325|08049
  o Remove bogus diff from drivers/char/Config.in
  o Changed EXTRAVERSION to -pre4
  o Cset exclude: hannal@us.ibm.com|ChangeSet|20030707180059|08076
  o Fixes ext3 quota/truncate oops
  o CRIS architecture update
  o Cset exclude: Remove NFS direct IO patches Cset exclude: trond.myklebust@fys.uio.no|ChangeSet|20030708095239|55752
  o Cset exclude: remove NFS direct IO patches Cset exclude: trond.myklebust@fys.uio.no|ChangeSet|20030706143259|16957
  o Add missing fs/quota_v2.c file
  o Comment out VIA_APOLLO_P4X400 handling in drm_agpsupport.h: Alan will fix that up later

Matthew Wilcox <willy@debian.org>:
  o pci_name()

Mikael Pettersson <mikpe@csd.uu.se>:
  o i386 cpufeature.h cleanup + comment

Paul Mackerras <paulus@samba.org>:
  o PPC32: Minor updates to comments and processor register definitions
  o PPC32: Minor boot wrapper cleanups
  o PPC32: Define screen_info if CONFIG_FB is set for the sake of vesafb
  o PPC32: Make __kernel_ino_t be unsigned long like on other architectures

Randy Dunlap <rddunlap@osdl.org>:
  o make profile= doc. clearer

Rusty Russell <rusty@rustcorp.com.au>:
  o Configure.help Polish translation location update
  o unreachable code in drivers_media_video_cpia_pp.c
  o 2.4 drivers_char_random.c fix sample shellscripts
  o trivial patch
  o fix sound doc typos
  o fs_bfs_dir.c unused variables
  o Decision PCCOM4_PCCOM8 serial support for 2.4.19
  o Re: setrlimit incorrectly allows hard limits to exceed
  o fix linewrap in Documentation_ia64_efirtc.txt
  o fix linewrap in Documentation_arm_SA1100_CERF
  o fix linewrap in Documentation_filesystems_befs.txt
  o [2.5 patch] two small MTD fixes
  o 2.4 patch for more debug safety
  o esssolo1.c doesn't free resources correctly

Trond Myklebust <trond.myklebust@fys.uio.no>:
  o Back out some congestion control changes that were causing trouble among other things for the "soft" mount option.

