Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263614AbTHZKWq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Aug 2003 06:22:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263622AbTHZKWq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Aug 2003 06:22:46 -0400
Received: from angband.namesys.com ([212.16.7.85]:17024 "EHLO
	angband.namesys.com") by vger.kernel.org with ESMTP id S263614AbTHZKWf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Aug 2003 06:22:35 -0400
Date: Tue, 26 Aug 2003 14:22:33 +0400
From: Oleg Drokin <green@namesys.com>
To: reiserfs-dev@namesys.com, reiserfs-list@namesys.com,
       linux-kernel@vger.kernel.org
Subject: reiser4 snapshot for August 26th.
Message-ID: <20030826102233.GA14647@namesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

   I have just released another reiser4 snapshot that I hope all interested
   parties will try. It is released against 2.6.0-test4.
   You can find it at http://namesys.com/snapshots/2003.08.26
   I include release notes below.

Reiser4 snapshot for 2003.08.26

WARNING!!! This code is experimental! WE ARE NOT KIDDING! DO NOT PUT
ANY VALUABLE DATA ON REISER4 YET!

Fixed some bugs. And finally reiser4 should compile on 64bit boxes (hm. somebody try it,
as I am unable to build any 2.6 kernel for ia64). Also reiser4 should now build without
debug enabled.
Important SMP bug was fixed (only was in effect for SMP kernels on boxes with less than 3 CPUs).
There are still some OOM problems sometimes that we are working on, but generally
I hope problems reported by various people about compile failures should be fixed now.
Readonly mounts (and hence - reiser4 as rootfs) are not supported too.

reiser4progs update includes some 64 bit fixes too along with other stuff.
fsck still does not work, so don't even try to run it.

Snapshot is released as a patch against linux-2.6.0-test4
REISER4_NOOPT config option (Disable compiler optimizations for reiser4 code.)
is known to not compile on x86.
Enable CONFIG_REISER4_LARGE_KEY, as reiser4progs are creating filesystems with
large keys by default.
The reiser4-kernelonly.diff file represents only required kernel modifications if you plan to use our reiser4 bk repository.
    It does not contains any reiser4 code
The reiser4.diff is full patch with everything included.

Changelog (extracted by "bk changes"):

ChangeSet@1.1218.1.2, 2003-08-26 12:53:59+04:00, god@laputa.namesys.com
  remove assertion (contradicts recent changes in prepare_twig_cut())

ChangeSet@1.1218.1.1, 2003-08-26 12:53:28+04:00, god@laputa.namesys.com
  remove superfluous check

ChangeSet@1.1217.1.3, 2003-08-26 11:19:03+04:00, zam@crimson.namesys.com
  search_one_bitmap_backward() endless loop fix.

ChangeSet@1.1216.1.1, 2003-08-25 22:01:52+04:00, zam@crimson.namesys.com
  backward search bitmap code fixes

ChangeSet@1.1217.1.1, 2003-08-25 21:26:46+04:00, edward@theta.namesys.com
  ctail.c:
    Fixed bug
  file.c:
    shared reserve_cut_iteration
  cryptcompress.c:
    Added cut_items_cryptcompress(), 
    fixed bugs 

ChangeSet@1.1215.1.6, 2003-08-25 21:06:06+04:00, god@laputa.namesys.com
  sync with recent change in prepare_twig_cut()

ChangeSet@1.1215.1.5, 2003-08-25 21:00:04+04:00, god@laputa.namesys.com
  when removing eottl, clear connected bits on formatted neighbors

ChangeSet@1.1215.1.4, 2003-08-25 20:59:26+04:00, god@laputa.namesys.com
  restore old check.

ChangeSet@1.1215.1.3, 2003-08-25 20:59:13+04:00, god@laputa.namesys.com
  fix race in check_jload()

ChangeSet@1.1215.1.2, 2003-08-25 20:58:52+04:00, god@laputa.namesys.com
  add separate inode to keep bitmaps.
  cleanup

ChangeSet@1.1215.1.1, 2003-08-25 20:45:18+04:00, god@laputa.namesys.com
  fix fence error in wake_up_requestor()

ChangeSet@1.1216, 2003-08-25 18:05:17+04:00, green@angband.namesys.com
  bitmap.c:
    Remove erroneous ON_DEBUG()

ChangeSet@1.1215, 2003-08-25 13:58:15+04:00, god@laputa.namesys.com
  use vmalloc instead of kmalloc

ChangeSet@1.1208.1.1, 2003-08-25 08:49:07+04:00, zam@crimson.namesys.com
  bitmap code reorganization

ChangeSet@1.1213, 2003-08-24 15:56:24+04:00, green@angband.namesys.com
  inode.h:
    64bit compile fix

ChangeSet@1.1212, 2003-08-22 21:05:40+04:00, god@laputa.namesys.com
  fix compilation errors

ChangeSet@1.1211, 2003-08-22 21:00:56+04:00, god@laputa.namesys.com
  restore compilability.

ChangeSet@1.1210, 2003-08-22 20:56:38+04:00, god@laputa.namesys.com
  fix problems with BK's handling of symlinks

ChangeSet@1.1209, 2003-08-22 20:55:24+04:00, god@laputa.namesys.com
  Merge laputa.namesys.com:/home/god/projects/2.5/fs/reiser4
  into laputa.namesys.com:/home/god/projects/i386/fs/reiser4

ChangeSet@1.1185.1.17, 2003-08-22 20:45:52+04:00, god@laputa.namesys.com
  cleanup

ChangeSet@1.1185.1.16, 2003-08-22 20:45:32+04:00, god@laputa.namesys.com
  add scripts to perform mongo automatically.

ChangeSet@1.1185.1.15, 2003-08-22 20:44:24+04:00, god@laputa.namesys.com
  fix race in sibling list code.

ChangeSet@1.1185.1.14, 2003-08-22 20:43:54+04:00, god@laputa.namesys.com
  fix debugging checks.

ChangeSet@1.1185.1.13, 2003-08-22 20:43:15+04:00, god@laputa.namesys.com
  don't do read-ahead if low on memory.

ChangeSet@1.1185.1.12, 2003-08-22 20:42:55+04:00, god@laputa.namesys.com
  add assertion.

ChangeSet@1.1185.1.11, 2003-08-22 20:42:39+04:00, god@laputa.namesys.com
  fix assertion: atom lock should be held to avoid races with fusion.

ChangeSet@1.1185.1.10, 2003-08-22 20:42:13+04:00, god@laputa.namesys.com
  use jnode attached to page to avoid hash table lookup when possible

ChangeSet@1.1185.1.9, 2003-08-22 20:41:38+04:00, god@laputa.namesys.com
  add sysfs file with a list of all active atoms.

ChangeSet@1.1185.1.8, 2003-08-22 20:40:59+04:00, god@laputa.namesys.com
  don't set JNODE_DKSET in add_empty_leaf() to avoid races

ChangeSet@1.1185.1.7, 2003-08-22 20:40:23+04:00, god@laputa.namesys.com
  move check.

ChangeSet@1.1185.1.6, 2003-08-22 20:40:08+04:00, god@laputa.namesys.com
  fix race in eflush_del().
  fix hash function.
  make hash table dynamically sized.

ChangeSet@1.1185.1.5, 2003-08-22 20:39:29+04:00, god@laputa.namesys.com
  mark get_current_context() as const.

ChangeSet@1.1185.1.4, 2003-08-22 20:39:06+04:00, god@laputa.namesys.com
  remove noisy compiler options
