Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1945981AbWGODDg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945981AbWGODDg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jul 2006 23:03:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1945986AbWGODDg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jul 2006 23:03:36 -0400
Received: from tomts31.bellnexxia.net ([209.226.175.105]:39901 "EHLO
	tomts31-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id S1945981AbWGODDe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jul 2006 23:03:34 -0400
Date: Fri, 14 Jul 2006 20:01:12 -0700
From: Greg KH <gregkh@suse.de>
To: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       torvalds@osdl.org, stable@kernel.org
Subject: Re: Linux 2.6.17.5
Message-ID: <20060715030112.GD11167@kroah.com>
References: <20060715030047.GC11167@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060715030047.GC11167@kroah.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff --git a/Makefile b/Makefile
index abcf2d7..cb8b93c 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 VERSION = 2
 PATCHLEVEL = 6
 SUBLEVEL = 17
-EXTRAVERSION = .4
+EXTRAVERSION = .5
 NAME=Crazed Snow-Weasel
 
 # *DOCUMENTATION*
diff --git a/fs/proc/base.c b/fs/proc/base.c
index 6cc77dc..5a8b89a 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -1404,6 +1404,7 @@ static int pid_revalidate(struct dentry 
 		} else {
 			inode->i_uid = 0;
 			inode->i_gid = 0;
+			inode->i_mode = 0;
 		}
 		security_task_to_inode(task, inode);
 		return 1;
