Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261626AbUKUAPH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261626AbUKUAPH (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Nov 2004 19:15:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263203AbUKUAN4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Nov 2004 19:13:56 -0500
Received: from locomotive.csh.rit.edu ([129.21.60.149]:41744 "EHLO
	locomotive.unixthugs.org") by vger.kernel.org with ESMTP
	id S261683AbUKUANK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Nov 2004 19:13:10 -0500
Date: Sat, 20 Nov 2004 19:13:05 -0500
From: Jeffrey Mahoney <jeffm@novell.com>
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: ReiserFS List <reiserfs-list@namesys.com>
Subject: [PATCH 0/5] reiserfs/selinux: patches to allow reiserfs and selinux to work together
Message-ID: <20041121001305.GA979@locomotive.unixthugs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Operating-System: Linux 2.6.5-7.111-smp (i686)
X-GPG-Fingerprint: A16F A946 6C24 81CC 99BB  85AF 2CF5 B197 2B93 0FB2
X-GPG-Key: http://www.csh.rit.edu/~jeffm/jeffm.gpg
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hey all -

The following 5 patches allow reiserfs and selinux to work together.

01-selinux-load_policy.diff
  - Allows load_policy to fail and to not BUG on the second attempt.

02-selinux-private-inode.diff
  - Allows "private" inodes that aren't tracked by selinux xattrs

03-reiserfs-private-inode.diff
  - Abstracts the private inode implementation in reiserfs to a static inline

04-reiserfs-selinux.diff
  - Uses the selinux private inode implementation to allow reiserfs to mark
    inodes as private. Also works around the checks in vfs_rmdir.

05-reiserfs-const-fixes.diff
  - Cleans up warnings introduced by 04-reiserfs-selinux.diff


Take a look, I'm interested in feedback. 

-Jeff

-- 
Jeff Mahoney
SuSE Labs
