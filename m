Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261438AbULVT0I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261438AbULVT0I (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Dec 2004 14:26:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261445AbULVT0I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Dec 2004 14:26:08 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:7595 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261438AbULVTZ7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Dec 2004 14:25:59 -0500
Date: Wed, 22 Dec 2004 15:02:35 -0200
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: linux-kernel@vger.kernel.org
Subject: Linux 2.4.29-pre3
Message-ID: <20041222170235.GH3088@logos.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here goes the third -pre of 2.4.29.

More importantly this release contains a correction for the "int 0x80 hole" 
security problem in AMD64 port (CAN-2004-1144).

It also contains a few important v2.6 backports (tty/ldisc and pty races), 
some hardening patches from Solar (none of those are exploitable bugs, just 
paranoic/early error detection), and a few networking updates.

This release should also fix the "NFS hang on unlink" issues present in v2.4.28.

It should appear in the kernel.org mirrors in a few minutes.



Summary of changes from v2.4.29-pre2 to v2.4.29-pre3
============================================

<baris:idealteknoloji.com>:
  o Remove msleep() definitions from sx8.c and forcedeth.c: it is generic now

Andi Kleen:
  o x86_64: fix signal restart bug
  o [CAN-2004-1144] Fix int 0x80 hole in 2.4 x86-64 linux kernels

Andries E. Brouwer:
  o do not use CONFIG_BLK_STATS

Chris Wright:
  o a.out: error check on set_brk
  o Backport of 2.6 fix to insert_vm_struct to make it return an error rather than BUG()

David S. Miller:
  o [SPARC]: Adjust 32-bit ELF_ET_DYN_BASE

Geert Uytterhoeven:
  o m68k: fix incorrect config comment in check_bugs()

H. J. Lu:
  o backport v2.6: Fix pty race condition

Ian Abbott:
  o serial closing_wait and close_delay used from wrong data structure

Marcelo Tosatti:
  o Solar Designer: Fix do_follow_link() comment
  o Jason Baron: Backport v2.6 tty/ldisc locking fixes
  o Move msleep() from libata-compat.h to generic headers
  o Cset exclude: akpm@osdl.org|ChangeSet|20041218001750|00972
  o Changed EXTRAVERSION to -pre3
  o Cset exclude: trond.myklebust@fys.uio.no|ChangeSet|20040521160141|29598
  o Fix NFS hang on unlink problems: cset exclude: trond.myklebust@fys.uio.no|ChangeSet|20041110174036|20706

Simon Horman:
  o binfmt_elf force_sig arguments fix

Solar Designer:
  o Fix booting off USB CD-ROMs (do_mounts.c)
  o binfmt_elf fix return error codes and early corrupt binary detection
  o procfs enhanced error reporting
  o sysctl: block bogus argument earlier
  o stronger (paranoic) mremap argument checking

Stephen Hemminger:
  o [TCP]: Missing newline character in printk
  o [PKT_SCHED]: netem: restart device after inserting packets

Thomas Graf:
  o [PKT_SCHED]: Fix double locking in tcindex destroy path

