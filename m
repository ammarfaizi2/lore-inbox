Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261753AbTILQQb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Sep 2003 12:16:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261754AbTILQQb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Sep 2003 12:16:31 -0400
Received: from angband.namesys.com ([212.16.7.85]:41088 "EHLO
	angband.namesys.com") by vger.kernel.org with ESMTP id S261753AbTILQPg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Sep 2003 12:15:36 -0400
Date: Fri, 12 Sep 2003 20:15:34 +0400
From: Oleg Drokin <green@namesys.com>
To: reiserfs-dev@namesys.com, reiserfs-list@namesys.com,
       linux-kernel@vger.kernel.org
Subject: New reiser4 snapshot (2003.09.12) is out
Message-ID: <20030912161534.GA8439@namesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

   Another reiser4 snapshot was released today. This time it is against
   2.6.0-test5.
   Please take note that DISK DORMAT IS CHANGED, so you need to recreate
   your reiser4 filesystems (if you have any). This involves getting new
   reiser4progs, too.

   The snapshot is available from http://www.namesys.com/snapshots/2003.09.12

   Full release notes are below:

Reiser4 snapshot for 2003.09.12

WARNING!!! This code is experimental! WE ARE NOT KIDDING! DO NOT PUT
ANY VALUABLE DATA ON REISER4 YET!

Fixed some bugs. Hide some config options that might lead to problems in
compiling/running.
Readonly mounts (and hence - reiser4 as rootfs) are still not supported.
Some OOM problems are still inplace too (involves mmap-dirtying lots of pages).

reiser4progs: You need to get new reiser4progs. Diskformat is changed in backwards
incompatible manner, and so you need to recreate all your reiser4 volumes.
fsck.reiser4 still is not functional

Snapshot is released as a patch against linux-2.6.0-test5
REISER4_NOOPT config option (Disable compiler optimizations for reiser4 code.)
is known to not compile on x86.
Enable CONFIG_REISER4_LARGE_KEY, as reiser4progs are creating filesystems with
large keys by default.
The reiser4-kernelonly.diff file represents only required kernel modifications if you plan to use our reiser4 bk repository.
    It does not contains any reiser4 code
The reiser4.diff is full patch with everything included.

Changelog (extracted by "bk changes"):

ChangeSet@1.1191, 2003-09-11 22:00:25+04:00, zam@crimson.namesys.com
  wrong assertions: grabbed blocks should not be less than @count.

ChangeSet@1.1190, 2003-09-11 21:40:11+04:00, zam@crimson.namesys.com
  add assertions for catching space reservation problems

ChangeSet@1.1187.1.2, 2003-09-11 18:36:37+04:00, zam@crimson.namesys.com
  always relocate if JNODE_REPACK is set

ChangeSet@1.1187.1.1, 2003-09-11 18:35:49+04:00, zam@crimson.namesys.com
  debugging print supoort for JNODE_REPACK.

ChangeSet@1.1186.1.1, 2003-09-10 22:06:39+04:00, edward@theta.namesys.com
  cryptcompress.c:
    Fixed bugs

ChangeSet@1.1187, 2003-09-10 18:49:42+04:00, zam@crimson.namesys.com
  bitmap backward scanning bug fix: it was possible to allocate more blocks than it 
  was allowed by @max_len argument.  

ChangeSet@1.1186, 2003-09-10 12:29:18+04:00, vs@tribesman.namesys.com
  handle_pos_on_formatted: wrong assertion removed

ChangeSet@1.1181.1.4, 2003-09-09 18:45:22+04:00, god@laputa.namesys.com
  clean up.
  respect queue congestion.

ChangeSet@1.1181.1.3, 2003-09-09 18:44:49+04:00, god@laputa.namesys.com
  cleanup.

ChangeSet@1.1181.1.2, 2003-09-09 18:44:33+04:00, god@laputa.namesys.com
  mark error returns as such.

ChangeSet@1.1181.1.1, 2003-09-09 18:44:07+04:00, god@laputa.namesys.com
  avoid race between ->releasepage() and znode allocation:
  remove page from radix tree manually.

ChangeSet@1.1182.1.1, 2003-09-08 19:38:13+04:00, green@angband.namesys.com
  Merge thebsh:/home/bk/reiser4
  into angband.namesys.com:/home/green/bk_work/reiser4-linux-2.5/fs/reiser4

ChangeSet@1.1175.2.1, 2003-09-08 19:38:01+04:00, green@angband.namesys.com
  plugin.h, object.c, static_stat.c, page_cache.c, inode.c:
    get rid of kdev_t stuff

ChangeSet@1.1183, 2003-09-08 19:22:49+04:00, vs@tribesman.namesys.com
  for a while

ChangeSet@1.1182, 2003-09-08 18:55:22+04:00, edward@theta.namesys.com
  static_stat.c:
    Fixed bug: set inode flag REISER4_CLUSTER_KNOWN
    in cluster_sd_save()      
  cryptcompress.h:
    More comments
  cryptcompress.c:
    Fixed bug: do not read new cluster from disk.

ChangeSet@1.1181, 2003-09-08 17:16:03+04:00, god@laputa.namesys.com
  sync with VM changes

ChangeSet@1.1178.1.1, 2003-09-08 17:06:47+04:00, god@laputa.namesys.com
  fix error in last commit

ChangeSet@1.1179, 2003-09-08 16:22:41+04:00, god@laputa.namesys.com
  Merge god@thebsh:/home/bk/reiser4
  into laputa.namesys.com:/home/god/projects/2.5/fs/reiser4

ChangeSet@1.1178, 2003-09-08 16:18:21+04:00, god@laputa.namesys.com
  check for concurrent node insertion in link_left_and_right()

ChangeSet@1.1177, 2003-09-08 16:17:50+04:00, god@laputa.namesys.com
  don't block ktxnmgrd on atom fusion.

ChangeSet@1.1175.1.6, 2003-09-08 16:09:28+04:00, umka@haron.namesys.com

ChangeSet@1.1175.1.5, 2003-09-08 15:21:22+04:00, edward@theta.namesys.com
  cryptcompress.c:
    Check value returned by scint_pack	

ChangeSet@1.1175.1.4, 2003-09-08 14:45:19+04:00, zam@crimson.namesys.com
  unnecessary function call removed

ChangeSet@1.1175.1.3, 2003-09-08 14:25:12+04:00, zam@crimson.namesys.com
  comments

ChangeSet@1.1175.1.2, 2003-09-08 14:23:19+04:00, zam@crimson.namesys.com
  remove inline from shared not inline function.

ChangeSet@1.1175.1.1, 2003-09-05 21:05:59+04:00, edward@theta.namesys.com
  flush.c:
    Handling of empty nodes after squeeze_node() on leaf level

ChangeSet@1.1176, 2003-09-05 19:43:59+04:00, god@laputa.namesys.com
  Merge laputa.namesys.com:/home/god/projects/2.5/fs/reiser4
  into laputa.namesys.com:/home/god/projects/i386/fs/reiser4

ChangeSet@1.1169.1.3, 2003-09-05 19:43:31+04:00, god@laputa.namesys.com
  move init_context() out of &inode_lock

ChangeSet@1.1169.1.2, 2003-09-05 19:43:06+04:00, god@laputa.namesys.com
  fix race

ChangeSet@1.1169.1.1, 2003-09-05 19:42:52+04:00, god@laputa.namesys.com
  remove assertion

ChangeSet@1.1175, 2003-09-05 16:49:27+04:00, vs@tribesman.namesys.com
  read_extent: bug fix

ChangeSet@1.1174, 2003-09-05 15:23:28+04:00, vs@tribesman.namesys.com
  Merge

ChangeSet@1.1164.1.5, 2003-09-05 15:12:01+04:00, vs@tribesman.namesys.com
  Merge tribesman.namesys.com:/home/vs/bk/reiser4
  into tribesman.namesys.com:/home/vs/tmp-bk/UML/fs/reiser4

ChangeSet@1.1164.4.1, 2003-09-05 15:11:36+04:00, vs@tribesman.namesys.com
  cleanup

ChangeSet@1.1173, 2003-09-05 13:08:39+04:00, zam@crimson.namesys.com
  Merge zam@bk.namesys.com:/home/bk/reiser4
  into crimson.namesys.com:/mnt/store/src/reiser4-linux-2.5/fs/reiser4

ChangeSet@1.1119.56.1, 2003-09-05 10:04:03+04:00, zam@crimson.namesys.com
  reiser4 sysfs interface: device attr. output change.

ChangeSet@1.1171, 2003-09-04 22:08:15+04:00, edward@theta.namesys.com
  ctail.c:
    Added cut_ctail()

ChangeSet@1.1164.3.1, 2003-09-04 21:50:51+04:00, demidov@herb.namesys.com
  option for use yacc

ChangeSet@1.1164.2.1, 2003-09-04 19:11:57+04:00, edward@theta.namesys.com
  item.h, ctail.h:
    cleanups
  ctail.c, flush.c:
    attach/detach squeeze item data was moved from squeeze_node()
    to squeeze() flush item plugin 

ChangeSet@1.1164.1.3, 2003-09-04 19:11:26+04:00, vs@tribesman.namesys.com
  cleanup

ChangeSet@1.1169, 2003-09-04 19:07:34+04:00, god@laputa.namesys.com
  add mmap support to nfs_fh_stale.c

ChangeSet@1.1168, 2003-09-04 19:07:15+04:00, god@laputa.namesys.com
  disable these noisy debugging messages.

ChangeSet@1.1167, 2003-09-04 19:06:57+04:00, god@laputa.namesys.com
  fix typo.

ChangeSet@1.1164.1.2, 2003-09-04 18:47:24+04:00, vs@tribesman.namesys.com
  cleanup

ChangeSet@1.1164.1.1, 2003-09-04 18:28:30+04:00, vs@tribesman.namesys.com
  cleanup

ChangeSet@1.1165, 2003-09-04 18:19:05+04:00, god@laputa.namesys.com
  Merge laputa.namesys.com:/home/god/projects/2.5/fs/reiser4
  into laputa.namesys.com:/home/god/projects/i386/fs/reiser4

ChangeSet@1.1164, 2003-09-04 18:01:57+04:00, vs@tribesman.namesys.com
  conflict resolved

ChangeSet@1.1163, 2003-09-04 18:01:02+04:00, vs@tribesman.namesys.com
  manual pull

ChangeSet@1.1119.9.128, 2003-09-04 17:15:22+04:00, god@laputa.namesys.com
  kill dead debugging code

ChangeSet@1.1151.1.6, 2003-09-04 17:03:04+04:00, vs@tribesman.namesys.com
  conflict resolved

ChangeSet@1.1162, 2003-09-04 15:59:01+04:00, vs@tribesman.namesys.com
  find_extent_slum_size: corrected assertions

ChangeSet@1.1119.9.127, 2003-09-04 15:21:38+04:00, god@laputa.namesys.com
  Merge god@thebsh:/home/bk/reiser4
  into laputa.namesys.com:/home/god/projects/2.5/fs/reiser4

ChangeSet@1.1119.9.126, 2003-09-04 15:19:33+04:00, god@laputa.namesys.com
  add more consistency checks for jnode

ChangeSet@1.1119.9.125, 2003-09-04 15:17:33+04:00, god@laputa.namesys.com
  add functions to print most wanted znodes

ChangeSet@1.1119.9.124, 2003-09-04 15:17:04+04:00, god@laputa.namesys.com
  fix typo.

ChangeSet@1.1119.9.123, 2003-09-04 15:16:49+04:00, god@laputa.namesys.com
  add /sys/fs/reiser4/*/contexts

ChangeSet@1.1119.9.122, 2003-09-04 15:14:54+04:00, god@laputa.namesys.com
  remove obsolete ->zgen statistics

ChangeSet@1.1161, 2003-09-04 11:57:58+04:00, vs@tribesman.namesys.com
  Merge tribesman.namesys.com:/home/vs/bk/reiser4
  into tribesman.namesys.com:/home/vs/tmp-bk/UML/fs/reiser4

ChangeSet@1.1160, 2003-09-04 11:57:47+04:00, vs@tribesman.namesys.com
  shorten_file: use current file size

ChangeSet@1.1151.1.5, 2003-09-04 11:54:36+04:00, vs@tribesman.namesys.com
  conflict resolved

ChangeSet@1.1151.1.4, 2003-09-04 11:43:09+04:00, vs@tribesman.namesys.com
  conflict resolution

ChangeSet@1.1119.53.9, 2003-09-03 20:10:46+04:00, edward@theta.namesys.com
  ctail.c, flush.c:
    fixed

ChangeSet@1.1119.9.121, 2003-09-03 19:19:07+04:00, god@laputa.namesys.com
  cleanup

ChangeSet@1.1119.9.120, 2003-09-03 19:17:18+04:00, god@laputa.namesys.com
  remove ->zgen

ChangeSet@1.1119.9.119, 2003-09-03 19:16:39+04:00, god@laputa.namesys.com
  remove dead code

ChangeSet@1.1119.53.8, 2003-09-03 17:41:58+04:00, edward@theta.namesys.com
  flush.c:
    comments

ChangeSet@1.1119.53.7, 2003-09-03 14:55:24+04:00, edward@theta.namesys.com
  ctail.c, cryptcompress.c:
    cleanups
  cryptcompress.h:
    comments, cleanups

ChangeSet@1.1119.9.118, 2003-09-03 14:44:45+04:00, god@laputa.namesys.com
  Merge laputa.namesys.com:/home/god/projects/2.5/fs/reiser4
  into laputa.namesys.com:/home/god/projects/i386/fs/reiser4

ChangeSet@1.1119.9.117, 2003-09-03 14:44:29+04:00, god@laputa.namesys.com
  lock neighboring formatted nodes and pass them down to the extent deletion code

ChangeSet@1.1119.53.6, 2003-09-03 13:29:38+04:00, umka@haron.namesys.com
  cde.c:
    Removed dead code.

ChangeSet@1.1119.55.1, 2003-09-02 19:24:55+04:00, umka@haron.namesys.com
  tail.c:
    Removed redundant stuff in lookup_tail().
  extent.c:
    Removed redundant stuff in lookup_extent().

ChangeSet@1.1119.53.4, 2003-09-02 18:34:24+04:00, edward@theta.namesys.com
  object.c, item.c, ctail.h, ctail.c, cryptcompress.h:
    cleanups
  cryptcompress.c:
    Added capture(), delete() methods for cryptcompress object plugin.

ChangeSet@1.1159, 2003-09-02 14:23:49+04:00, vs@tribesman.namesys.com
  bug fixes, debugging code

ChangeSet@1.1119.53.3, 2003-09-02 13:18:32+04:00, vs@tribesman.namesys.com
  cut_or_kill_units: bug fix

ChangeSet@1.1119.54.1, 2003-09-01 22:48:04+04:00, zam@crimson.namesys.com
  add "device" sysfs attribute for reiser4 kobject.

ChangeSet@1.1119.53.1, 2003-09-01 21:41:00+04:00, edward@theta.namesys.com
  object.c:
    added mmap() for cryptcompress objects
  item.c:
    init_coord_extension for ctails
  cryptcompress.c:
    added get_block() for cryptcompress objects

ChangeSet@1.1158, 2003-09-01 18:28:10+04:00, vs@tribesman.namesys.com
  Merge tribesman.namesys.com:/home/vs/bk/reiser4
  into tribesman.namesys.com:/home/vs/tmp-bk/UML/fs/reiser4

ChangeSet@1.1157, 2003-09-01 18:28:02+04:00, vs@tribesman.namesys.com
  cleanups, fixes

ChangeSet@1.1119.52.3, 2003-09-01 14:12:37+04:00, god@laputa.namesys.com
  sync with changes in prepare_twig_cut()

ChangeSet@1.1119.52.2, 2003-09-01 14:12:10+04:00, god@laputa.namesys.com
  set JNODE_DKSET bit

ChangeSet@1.1119.52.1, 2003-09-01 14:11:39+04:00, god@laputa.namesys.com
  assertion was rendered invalid by recent chamges in prepare_twig_cut()

ChangeSet@1.1151.1.3, 2003-09-01 11:34:02+04:00, vs@tribesman.namesys.com
  Merge thebsh:/home/bk/reiser4
  into tribesman.namesys.com:/home/vs/bk/reiser4

ChangeSet@1.1119.9.115, 2003-08-30 21:21:18+04:00, edward@theta.namesys.com
  plugin.h:
    Split cryptcompress specific info in reiser4_object_create data
    into crypto/compression/cluster info to enable unspecified ones.
  static_stat.c:
    Allocating space for crypto_stat moved from save_crypto_sd() to create_cryptcompress()  
  item.c:
    init kill_hook method for ctail items. 
  ctail.h:
    cleanup
  cryptcompress.c:
    Create method for cryptcompression objects was changed to enable
    creation with unspecified crypto/compression info (the create method
    instals zero plugins). 	

ChangeSet@1.1156, 2003-08-30 18:26:50+04:00, vs@tribesman.namesys.com
  Merge tribesman.namesys.com:/home/vs/bk/reiser4
  into tribesman.namesys.com:/home/vs/tmp-bk/UML/fs/reiser4

ChangeSet@1.1155, 2003-08-30 18:26:35+04:00, vs@tribesman.namesys.com
  set_hint: hint is extended by lock mode. This is to distinguish hint set by read and write

ChangeSet@1.1151.1.2, 2003-08-30 18:22:28+04:00, vs@tribesman.namesys.com
  Merge thebsh:/home/bk/reiser4
  into tribesman.namesys.com:/home/vs/bk/reiser4

ChangeSet@1.1119.51.3, 2003-08-29 22:53:49+04:00, zam@crimson.namesys.com
  the repacker: one more extent scanning loop fix.

ChangeSet@1.1119.51.2, 2003-08-29 22:51:51+04:00, zam@crimson.namesys.com
  the repacker: blocknr hint update after extent relocation, extent scan loop fix.

ChangeSet@1.1119.9.113, 2003-08-29 19:42:55+04:00, green@angband.namesys.com
  vfs_ops.c:
    Do not assign any inode stats in reiser4_statfs. Big numbers seems to confurse all df implementations out there.

ChangeSet@1.1119.51.1, 2003-08-29 18:56:58+04:00, zam@crimson.namesys.com
  the repacker: update blocknr_hint after successful block allocation

ChangeSet@1.1119.9.112, 2003-08-29 18:23:25+04:00, green@angband.namesys.com
  page_cache.c:
    We need jprivate in there, because zero private field is completely legal and even handled

ChangeSet@1.1119.9.111, 2003-08-29 17:26:28+04:00, green@angband.namesys.com
  dir.h, dir.c, hashed_dir.c:
    Make rename properly update times of parent directories, export update_times->reiser4_update_times

ChangeSet@1.1119.9.110, 2003-08-29 15:27:30+04:00, green@angband.namesys.com
  file.c:
    Do not update anything other than atime when file is unpacked.

ChangeSet@1.1154, 2003-08-29 12:52:00+04:00, vs@tribesman.namesys.com
  Merge tribesman.namesys.com:/home/vs/bk/reiser4
  into tribesman.namesys.com:/home/vs/tmp-bk/UML/fs/reiser4

ChangeSet@1.1153, 2003-08-29 12:51:48+04:00, vs@tribesman.namesys.com
  fixes, cleanups

ChangeSet@1.1151.1.1, 2003-08-29 12:44:55+04:00, vs@tribesman.namesys.com
  conflict resolved

ChangeSet@1.1119.9.109, 2003-08-29 11:26:47+04:00, green@angband.namesys.com
  static_stat.c:
    Fixed compile. Actually now that we can have either rdev or bytes field, we probably may need to print only one of those, too

ChangeSet@1.1119.9.108, 2003-08-28 19:40:16+04:00, god@laputa.namesys.com
  fix precedence.

ChangeSet@1.1119.9.107, 2003-08-28 19:34:44+04:00, god@laputa.namesys.com
  fix read ahead code

ChangeSet@1.1119.9.106, 2003-08-28 19:34:29+04:00, god@laputa.namesys.com
  limit atom size

ChangeSet@1.1119.9.105, 2003-08-28 19:34:06+04:00, god@laputa.namesys.com
  add more checks for jnode consistency

ChangeSet@1.1119.9.104, 2003-08-28 19:33:36+04:00, god@laputa.namesys.com
  fix compilation errors

ChangeSet@1.1119.9.103, 2003-08-28 19:30:39+04:00, god@laputa.namesys.com
  remove noisy compiler options

ChangeSet@1.1119.49.2, 2003-08-28 19:20:40+04:00, god@laputa.namesys.com
  rearrange fields

ChangeSet@1.1119.9.101, 2003-08-28 19:06:57+04:00, edward@theta.namesys.com
  ctail.h:
    Added prototypes
  ctail.c, cryptcompress.h, cryptcompress.c:
    Audited read_some_cluster_pages(), do_readpage_ctail()

ChangeSet@1.1119.9.100, 2003-08-28 18:14:06+04:00, vs@strelka.namesys.com
  rdev fix?

ChangeSet@1.1119.9.99, 2003-08-28 14:34:37+04:00, edward@theta.namesys.com
  cryptcompress.c:
    helper init operation for cluster handle

ChangeSet@1.1119.9.98, 2003-08-28 12:19:11+04:00, vs@tribesman.namesys.com
  calculate stat->blocks right

ChangeSet@1.1152, 2003-08-28 12:13:03+04:00, vs@tribesman.namesys.com
  Merge tribesman.namesys.com:/home/vs/bk/reiser4
  into tribesman.namesys.com:/home/vs/tmp-bk/UML/fs/reiser4

ChangeSet@1.1150.1.1, 2003-08-28 12:12:57+04:00, vs@tribesman.namesys.com
  fixes, cleanups

ChangeSet@1.1151, 2003-08-28 12:11:41+04:00, vs@tribesman.namesys.com
  conflict resolved

ChangeSet@1.1119.9.97, 2003-08-28 08:36:43+04:00, zam@crimson.namesys.com
  the repacker: add missing deadllocation of relocatable blocks.

ChangeSet@1.1119.9.96, 2003-08-28 07:42:03+04:00, zam@crimson.namesys.com
  missing JF_SET(, JNODE_RELOC) caused space reservation problems (zam-940).

ChangeSet@1.1119.50.1, 2003-08-27 22:50:08+04:00, zam@crimson.namesys.com
  the repacker: extent relocation is rewritten to fix space reservation problems.

ChangeSet@1.1119.9.94, 2003-08-27 21:23:29+04:00, edward@theta.namesys.com
  ctail.h:
    Added prototypes 
  ctail.c:
    Added kill_hook method for ctail items 
  cryptcompress.c:
    Added shorten_cryptcompress()

ChangeSet@1.1119.9.93, 2003-08-27 16:36:36+04:00, edward@theta.namesys.com
  ctail.c:
    Fixed bugs

ChangeSet@1.1119.49.1, 2003-08-26 17:17:32+04:00, god@laputa.namesys.com
  change interface of flush_some_atom(): pass writeback_control so that
  pdflush can be distinguised from balance_dirty_pages()

ChangeSet@1.1150, 2003-08-26 16:31:58+04:00, vs@tribesman.namesys.com
  Merge thebsh:/home/bk/reiser4
  into tribesman.namesys.com:/home/vs/bk/reiser4

ChangeSet@1.1119.48.1, 2003-08-26 14:59:32+04:00, zam@crimson.namesys.com
  fix of wrong result block calculation from bmap number and offset in bitmap_alloc_forward()

Bye,
    Oleg
