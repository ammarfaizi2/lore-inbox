Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262469AbTCPHCD>; Sun, 16 Mar 2003 02:02:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262484AbTCPHCD>; Sun, 16 Mar 2003 02:02:03 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:20241 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S262469AbTCPHCC>;
	Sun, 16 Mar 2003 02:02:02 -0500
Date: Sat, 15 Mar 2003 23:01:20 -0800
From: Greg KH <greg@kroah.com>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org, linux-security-module@wirex.com
Subject: [BK PATCH] LSM changes for 2.5.64
Message-ID: <20030316070120.GA15545@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here are the LSM changes that have been posted many times in the past.
They fix a few bugs in some of the existing security hooks, and add a
few more (hooks that is, not bugs :).  All of these patches have been
discussed on lkml with no known outstanding issues remaining about them.

Please pull from:
	bk://lsm.bkbits.net/linus-2.5

I'm only including the diffstat and short log format for these patches,
as they all have been posted to the lists in the past.

thanks,

greg k-h

 fs/dcache.c              |   12 +++
 fs/exportfs/expfs.c      |    5 -
 fs/file_table.c          |   70 +++++++++++++++++------
 fs/namei.c               |   45 ++++----------
 fs/nfsd/vfs.c            |   18 +----
 fs/super.c               |   36 +++++++++--
 include/linux/fs.h       |   25 ++++++--
 include/linux/security.h |  143 ++++++++++++++++++++++++++++++++++++-----------
 kernel/ksyms.c           |   18 +++--
 kernel/printk.c          |    7 +-
 kernel/sys.c             |   63 +++++++++++++++-----
 kernel/sysctl.c          |    5 +
 security/capability.c    |   21 ++++++
 security/dummy.c         |   66 +++++++++++++++++----
 14 files changed, 396 insertions(+), 138 deletions(-)
-----


Greg Kroah-Hartman <greg@kroah.com>:
  o LSM: restore d_instantiate function that got lost in the mege
  o LSM: fix merge where we lost a prototype in security.h

Stephen D. Smalley <sds@epoch.ncsc.mil>:
  o LSM: coding style fixups in sb_kern_mount
  o LSM: Add LSM syslog hook to 2.5.59
  o LSM: Add LSM sysctl hook to 2.5.59
  o Restore LSM hook calls to setpriority and setpgid
  o allocate and free security structures for private files
  o Replace inode_post_lookup hook with d_instantiate hook
  o Add LSM hook to do_kern_mount

