Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287632AbSBGMg5>; Thu, 7 Feb 2002 07:36:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287676AbSBGMgs>; Thu, 7 Feb 2002 07:36:48 -0500
Received: from harpo.it.uu.se ([130.238.12.34]:46465 "EHLO harpo.it.uu.se")
	by vger.kernel.org with ESMTP id <S287632AbSBGMgc>;
	Thu, 7 Feb 2002 07:36:32 -0500
Date: Thu, 7 Feb 2002 13:36:30 +0100 (MET)
From: Mikael Pettersson <mikpe@csd.uu.se>
Message-Id: <200202071236.NAA23606@harpo.it.uu.se>
To: viro@math.psu.edu
Subject: [PATCH] 2.5.4-pre2 PROC_I() compile warnings
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The new PROC_I() and PDE() access functions for /proc
inodes need to have their formal parameters declared "const",
to avoid some compile warnings (in drivers/pci/ and possibly
elsewhere).

/Mikael

--- linux-2.5.4-pre2/include/linux/proc_fs.h.~1~	Thu Feb  7 12:51:22 2002
+++ linux-2.5.4-pre2/include/linux/proc_fs.h	Thu Feb  7 12:53:00 2002
@@ -217,12 +217,12 @@
 	struct inode vfs_inode;
 };
 
-static inline struct proc_inode *PROC_I(struct inode *inode)
+static inline struct proc_inode *PROC_I(const struct inode *inode)
 {
 	return list_entry(inode, struct proc_inode, vfs_inode);
 }
 
-static inline struct proc_dir_entry *PDE(struct inode *inode)
+static inline struct proc_dir_entry *PDE(const struct inode *inode)
 {
 	return PROC_I(inode)->pde;
 }
