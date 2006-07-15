Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1945986AbWGODEA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945986AbWGODEA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jul 2006 23:04:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1945985AbWGODDi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jul 2006 23:03:38 -0400
Received: from tomts45.bellnexxia.net ([209.226.175.112]:45449 "EHLO
	tomts45-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id S1945984AbWGODDe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jul 2006 23:03:34 -0400
Date: Fri, 14 Jul 2006 19:59:34 -0700
From: Greg KH <gregkh@suse.de>
To: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       torvalds@osdl.org, stable@kernel.org
Subject: Re: Linux 2.6.16.25
Message-ID: <20060715025934.GB11167@kroah.com>
References: <20060715025906.GA11167@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060715025906.GA11167@kroah.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff --git a/Makefile b/Makefile
index 9b1622f..84166a1 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 VERSION = 2
 PATCHLEVEL = 6
 SUBLEVEL = 16
-EXTRAVERSION = .24
+EXTRAVERSION = .25
 NAME=Sliding Snow Leopard
 
 # *DOCUMENTATION*
diff --git a/fs/proc/base.c b/fs/proc/base.c
index c192cb2..9d99674 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -1366,6 +1366,7 @@ static int pid_revalidate(struct dentry 
 		} else {
 			inode->i_uid = 0;
 			inode->i_gid = 0;
+			inode->i_mode = 0;
 		}
 		security_task_to_inode(task, inode);
 		return 1;
