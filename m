Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261944AbVCAPqz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261944AbVCAPqz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Mar 2005 10:46:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261951AbVCAPqz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Mar 2005 10:46:55 -0500
Received: from zeus.kernel.org ([204.152.189.113]:60880 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S261944AbVCAPmh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Mar 2005 10:42:37 -0500
Date: Tue, 1 Mar 2005 10:37:10 -0500
From: Jeffrey Mahoney <jeffm@suse.com>
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Stephen Smalley <sds@epoch.ncsc.mil>, Chris Wright <chrisw@osdl.org>
Subject: [PATCH 0/4] Allow reiserfs to work with selinux
Message-ID: <20050301153710.GA18215@locomotive.unixthugs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Operating-System: Linux 2.6.5-7.111.19-smp (i686)
X-GPG-Fingerprint: A16F A946 6C24 81CC 99BB  85AF 2CF5 B197 2B93 0FB2
X-GPG-Key: http://www.csh.rit.edu/~jeffm/jeffm.gpg
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello all -

I sent out these patches in December, but they were dropped somewhere along the
way. There was only a simple reject from the switch from dentry to inode in
get/set/listsecurity which has been fixed.

I'm posting the following patches against 2.6.11-rc5:
* 01-vfs-private-flag.diff
  - vfs: adds the S_PRIVATE flag and adds use to security
* 02-vfs-private-selinux.diff
  - selinux: internal inode loop needs IS_PRIVATE test
* 03-reiserfs-priv-abstract.diff
  - reiserfs: private inode abstracted to static inline
* 04-vfs-private-reiserfs.diff
  - reiserfs: change reiserfs to use S_PRIVATE

Please apply.

-Jeff

-- 
Jeff Mahoney
SuSE Labs
