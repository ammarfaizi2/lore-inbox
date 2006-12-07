Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1032100AbWLGMPJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1032100AbWLGMPJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Dec 2006 07:15:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1032103AbWLGMPI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Dec 2006 07:15:08 -0500
Received: from mx1.redhat.com ([66.187.233.31]:48599 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1032100AbWLGMPF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Dec 2006 07:15:05 -0500
Subject: [GFS2 & DLM] Pull request
From: Steven Whitehouse <swhiteho@redhat.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: cluster-devel@redhat.com, linux-kernel@vger.kernel.org
In-Reply-To: <20061201110927.ec6ee073.akpm@osdl.org>
References: <1164889448.3752.449.camel@quoit.chygwyn.com>
	 <20061130230158.174e995c.akpm@osdl.org>
	 <1164970738.3752.508.camel@quoit.chygwyn.com>
	 <20061201110927.ec6ee073.akpm@osdl.org>
Content-Type: text/plain
Organization: Red Hat (UK) Ltd
Date: Thu, 07 Dec 2006 12:17:49 +0000
Message-Id: <1165493869.3752.848.camel@quoit.chygwyn.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

All the outstanding issues have now been resolved. Please consider
pulling the following GFS2 & DLM patches,

Steve.

---------------------------------------------------------------------------------------

The following changes since commit 0215ffb08ce99e2bb59eca114a99499a4d06e704:
  Linus Torvalds:
        Linux 2.6.19

are found in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/steve/gfs2-2.6-nmw.git

Al Viro:
      [GFS2] split gfs2_dinode into on-disk and host variants
      [GFS2] gfs2_dinode_host fields are host-endian
      [GFS2] split gfs2_sb
      [GFS2] fields of gfs2_sb_host are host-endian
      [GFS2] split and annotate gfs2_rgrp
      [GFS2] split and annotate gfs2_inum_range
      [GFS2] split and annotate gfs2_log_head
      [GFS2] split and annotate gfs2_meta_header
      [GFS2] split and annotate gfs_rindex
      [GFS2] split and annotate gfs2_inum
      [GFS2] split and annotate gfs2_quota
      [GFS2] split and annotate gfs2_statfs_change
      [GFS2] split and annotate gfs2_quota_change
      [GFS2] gfs2 misc endianness annotations
      [GFS2] gfs2 __user misannotation fix

David Teigland:
      [DLM] res_recover_locks_count not reset when recover_locks is aborted
      [DLM] status messages ping-pong between unmounted nodes
      [DLM] fix requestqueue race
      [DLM] fix aborted recovery during node removal
      [DLM] fix stopping unstarted recovery
      [DLM] do full recover_locks barrier
      [DLM] clear sbflags on lock master
      [DLM] fix add_requestqueue checking nodes list
      [DLM] fix size of STATUS_REPLY message
      [DLM] don't accept replies to old recovery messages

Patrick Caulfield:
      [DLM] Add support for tcp communications
      [DLM] Fix DLM config
      [DLM] Clean up lowcomms

Randy Dunlap:
      [GFS2] lock function parameter

Russell Cattelan:
      [GFS2] Fix race in logging code
      [GFS2] Remove unused zero_readpage from stuffed_readpage

Ryusuke Konishi:
      [GFS2] fs/gfs2/log.c:log_bmap() fix printk format warning
      [DLM] fix format warnings in rcom.c and recoverd.c

Srinivasa Ds:
      [GFS2] Mount problem with the GFS2 code

Steven Whitehouse:
      [GFS2] Fix crc32 calculation in recovery.c
      [GFS2] Change argument of gfs2_dinode_out
      [GFS2] Change argument to gfs2_dinode_in
      [GFS2] Move gfs2_dinode_in to inode.c
      [GFS2] Change argument to gfs2_dinode_print
      [GFS2] Shrink gfs2_inode (1) - di_header/di_num
      [GFS2] Shrink gfs2_inode (2) - di_major/di_minor
      [GFS2] Shrink gfs2_inode (3) - di_mode
      [GFS2] Shrink gfs2_inode (4) - di_uid/di_gid
      [GFS2] Shrink gfs2_inode (5) - di_nlink
      [GFS2] Shrink gfs2_inode (6) - di_atime/di_mtime/di_ctime
      [GFS2] Shrink gfs2_inode (7) - di_payload_format
      [GFS2] Shrink gfs2_inode (8) - i_vn
      [GFS2] Tidy up 0 initialisations in inode.c
      [GFS2] Don't copy meta_header for rgrp in and out
      [GFS2] Remove unused GL_DUMP flag
      [GFS2] Fix page lock/glock deadlock
      [GFS2] Only set inode flags when required
      [GFS2] Inode number is constant
      [GFS2] Remove gfs2_inode_attr_in
      [GFS2] Fix memory allocation in glock.c
      [GFS2] Tidy up bmap & fix boundary bug
      [GFS2] Remove unused sysfs files
      [GFS2] Remove unused function from inode.c
      [GFS2] Make sentinel dirents compatible with gfs1
      [GFS2] Fix Kconfig wrt CRC32
      [GFS2] Simplify glops functions
      [GFS2] Fix glock ordering on inode creation
      [GFS2] mark_inode_dirty after write to stuffed file
      [GFS2] Fix journal flush problem
      [GFS2] Move gfs2_meta_syncfs() into log.c
      [GFS2] Reduce number of arguments to meta_io.c:getbuf()
      [GFS2] Fix recursive locking in gfs2_permission
      [GFS2] Fix recursive locking in gfs2_getattr
      [GFS2] Remove gfs2_check_acl()
      [GFS2] Add a comment about reading the super block
      [GFS2] Don't flush everything on fdatasync
      [GFS2] Fix indent in recovery.c
      [GFS2] Change gfs2_fsync() to use write_inode_now()

 fs/dlm/Kconfig              |   20 +
 fs/dlm/Makefile             |    4 
 fs/dlm/dlm_internal.h       |    4 
 fs/dlm/lock.c               |   16 -
 fs/dlm/lockspace.c          |    4 
 fs/dlm/lowcomms-sctp.c      | 1227 +++++++++++++++++++++++++++++++++++++++++++
 fs/dlm/lowcomms-tcp.c       | 1189 +++++++++++++++++++++++++++++++++++++++++
 fs/dlm/lowcomms.c           | 1239 -------------------------------------------
 fs/dlm/lowcomms.h           |    2 
 fs/dlm/main.c               |   10 
 fs/dlm/member.c             |    8 
 fs/dlm/rcom.c               |   58 ++
 fs/dlm/recover.c            |    1 
 fs/dlm/recoverd.c           |   44 +-
 fs/dlm/requestqueue.c       |   26 +
 fs/dlm/requestqueue.h       |    2 
 fs/gfs2/Kconfig             |    1 
 fs/gfs2/acl.c               |   39 -
 fs/gfs2/acl.h               |    1 
 fs/gfs2/bmap.c              |  179 +++---
 fs/gfs2/daemon.c            |    7 
 fs/gfs2/dir.c               |   93 ++-
 fs/gfs2/dir.h               |    8 
 fs/gfs2/eaops.c             |    2 
 fs/gfs2/eattr.c             |   66 +-
 fs/gfs2/eattr.h             |    6 
 fs/gfs2/glock.c             |   36 -
 fs/gfs2/glock.h             |    3 
 fs/gfs2/glops.c             |  138 +----
 fs/gfs2/incore.h            |   43 +
 fs/gfs2/inode.c             |  406 +++++---------
 fs/gfs2/inode.h             |   20 -
 fs/gfs2/log.c               |   41 +
 fs/gfs2/log.h               |    2 
 fs/gfs2/lops.c              |   40 +
 fs/gfs2/lops.h              |    2 
 fs/gfs2/meta_io.c           |   46 +-
 fs/gfs2/meta_io.h           |    1 
 fs/gfs2/ondisk.c            |  138 +----
 fs/gfs2/ops_address.c       |   52 +-
 fs/gfs2/ops_dentry.c        |    4 
 fs/gfs2/ops_export.c        |   38 +
 fs/gfs2/ops_export.h        |    2 
 fs/gfs2/ops_file.c          |   66 ++
 fs/gfs2/ops_file.h          |    2 
 fs/gfs2/ops_fstype.c        |    4 
 fs/gfs2/ops_inode.c         |  134 ++---
 fs/gfs2/ops_super.c         |   11 
 fs/gfs2/ops_vm.c            |    2 
 fs/gfs2/quota.c             |   15 -
 fs/gfs2/recovery.c          |   29 +
 fs/gfs2/recovery.h          |    2 
 fs/gfs2/rgrp.c              |   13 
 fs/gfs2/super.c             |   50 +-
 fs/gfs2/super.h             |    6 
 fs/gfs2/sys.c               |    8 
 fs/gfs2/util.h              |    6 
 include/linux/gfs2_ondisk.h |  138 ++++-
 58 files changed, 3442 insertions(+), 2312 deletions(-)
 create mode 100644 fs/dlm/lowcomms-sctp.c
 create mode 100644 fs/dlm/lowcomms-tcp.c
 delete mode 100644 fs/dlm/lowcomms.c


