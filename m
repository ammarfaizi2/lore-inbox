Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030279AbWAaDk2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030279AbWAaDk2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Jan 2006 22:40:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030304AbWAaDk2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Jan 2006 22:40:28 -0500
Received: from spooner.celestial.com ([192.136.111.35]:47583 "EHLO
	spooner.celestial.com") by vger.kernel.org with ESMTP
	id S1030279AbWAaDk1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Jan 2006 22:40:27 -0500
Date: Mon, 30 Jan 2006 22:46:34 -0500
From: Kurt Wall <kwall@kurtwerks.com>
To: LKML <linux-kernel@vger.kernel.org>, viro@zeniv.linux.org.uk
Subject: Fix "make mandocs" for fs/inode.c
Message-ID: <20060131034634.GT1501@kurtwerks.com>
Mail-Followup-To: LKML <linux-kernel@vger.kernel.org>,
	viro@zeniv.linux.org.uk
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
X-Operating-System: Linux 2.6.16-rc1krw
X-Woot: Woot!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"make mandocs" complains on fs/inode.c because touch_atime() has an undescribed paramter. This patch silences the complaint by describing the param. Also update the kernel-doc entry to reflect dentry usage over raw inode access.

Signed-off-by: Kurt Wall <kwall@kurtwerks.com>


--- ./linux-2.6.16-rc1/fs/inode.c.orig	2006-01-21 09:30:59.000000000 -0500
+++ ./linux-2.6.16-rc1/fs/inode.c	2006-01-30 22:45:38.000000000 -0500
@@ -1179,7 +1179,7 @@
 /**
  *	touch_atime	-	update the access time
  *	@mnt: mount the inode is accessed on
- *	@inode: inode accessed
+ *	@dentry: dentry containing the inode to update
  *
  *	Update the accessed time on an inode and mark it for writeback.
  *	This function automatically handles read only file systems and media,
-- 
Tact, n.:
	The unsaid part of what you're thinking.
