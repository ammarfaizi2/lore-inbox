Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261196AbVALSiF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261196AbVALSiF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jan 2005 13:38:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261209AbVALSiF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jan 2005 13:38:05 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:22431 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261196AbVALSiA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jan 2005 13:38:00 -0500
Date: Wed, 12 Jan 2005 13:13:34 -0200
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: linux-kernel@vger.kernel.org
Subject: Linux 2.4.29-rc2
Message-ID: <20050112151334.GC32024@logos.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, 

Here goes the second release candidate of v2.4.29.

It contains mainly security fixes, including backports from 2.6-ac Coverity
fixes, rework of the do_brk() fixes as suggested by Linus, and a fix for the
pagefault SMP race disclosed today: 

CAN-2005-0001
http://www.isec.pl/vulnerabilities/isec-0022-pagefault.txt


Summary of changes from v2.4.29-rc1 to v2.4.29-rc2
============================================

Christoph Hellwig:
  o [XFS] make sure to always reclaim inodes in xfs_finish_reclaim
  o [XFS] Fix NFS inode data corruption
  o [XFS] Disable variable sized transfers on loop devices
  o [XFS] Fix compilations for parisc

Geert Uytterhoeven:
  o Kill unused variables in the tty code
  o Kill unused variables in the net code

Jan Harkes:
  o Fix Coda bugs found by Coverity checker

Marcelo Tosatti:
  o Update Dave Jones email address in MAINTAINERS file
  o Linus Torvalds: Warn if mmap_sem is not locked in do_brk
  o Change do_uselib() fix to match v2.6, rip do_brk_locked()
  o Brad Spengler: Fix random poolsize sysctl (from 2.6.10-ac)
  o Alan Cox: Fix moxa serial bound checking issue (from 2.6.10-ac)
  o Brad Spengler: Fix RLIMIT_MEMLOCK issue
  o get_user_pages: Change BUG_ON to WARN_ON
  o Alan Cox: rose_rt_ioctl lack of bounds checking, reported by Coverity (from 2.6.10-ac)
  o Alan Cox: sdla_xfer lack of bounds checking, reported by Coverity (from 2.6.10-ac)
  o Makefile
  o Revert dubious get_user_pages() bug checking
  o Olaf Kirch: sendmsg compat wrapper fixes
  o Cset exclude: marcelo@logos.cnet|ChangeSet|20050110190211|08215
  o Fix expand_stack() SMP race
  o Add missing Documentation/tty.txt from tty/ldisc locking updates
  o Completly remove old do_brk() fix
  o Linus Torvalds: Create helper for mmap_sem write-lock check in do_brk()
  o Fix mmap.c typo

Mikael Pettersson:
  o sungem UniNorth 2 GMAC support

Nathan Scott:
  o [XFS] Add sanity checks before use of attr_multi opcount parameter

Pete Zaitcev:
  o EHCI race fix

