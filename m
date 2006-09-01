Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751187AbWIACCe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751187AbWIACCe (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Aug 2006 22:02:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751165AbWIACCe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Aug 2006 22:02:34 -0400
Received: from filer.fsl.cs.sunysb.edu ([130.245.126.2]:52616 "EHLO
	filer.fsl.cs.sunysb.edu") by vger.kernel.org with ESMTP
	id S1751128AbWIACCc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Aug 2006 22:02:32 -0400
Date: Thu, 31 Aug 2006 22:02:22 -0400
From: Josef Sipek <jsipek@cs.sunysb.edu>
To: linux-kernel@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org, hch@infradead.org, akpm@osdl.org,
       viro@ftp.linux.org.uk
Subject: [PATCH 22/22][RFC] Unionfs: Include file
Message-ID: <20060901020222.GW5788@fsl.cs.sunysb.edu>
References: <20060901013512.GA5788@fsl.cs.sunysb.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060901013512.GA5788@fsl.cs.sunysb.edu>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Josef "Jeff" Sipek <jsipek@cs.sunysb.edu>

Global include file - can be included from userspace by utilities.

Signed-off-by: Josef "Jeff" Sipek <jsipek@cs.sunysb.edu>
Signed-off-by: David Quigley <dquigley@fsl.cs.sunysb.edu>
Signed-off-by: Erez Zadok <ezk@cs.sunysb.edu>

---

 include/linux/union_fs.h |   20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff -Nur -x linux-2.6-git/Documentation/dontdiff linux-2.6-git/include/linux/union_fs.h linux-2.6-git-unionfs/include/linux/union_fs.h
--- linux-2.6-git/include/linux/union_fs.h	1969-12-31 19:00:00.000000000 -0500
+++ linux-2.6-git-unionfs/include/linux/union_fs.h	2006-08-31 19:04:04.000000000 -0400
@@ -0,0 +1,20 @@
+#ifndef _LINUX_UNION_FS_H
+#define _LINUX_UNION_FS_H
+
+#define UNIONFS_VERSION  "2.0"
+/*
+ * DEFINITIONS FOR USER AND KERNEL CODE:
+ * (Note: ioctl numbers 1--9 are reserved for fistgen, the rest
+ *  are auto-generated automatically based on the user's .fist file.)
+ */
+# define UNIONFS_IOCTL_INCGEN		_IOR(0x15, 11, int)
+# define UNIONFS_IOCTL_QUERYFILE	_IOR(0x15, 15, int)
+
+/* We don't support normal remount, but unionctl uses it. */
+# define UNIONFS_REMOUNT_MAGIC		0x4a5a4380
+
+/* should be at least LAST_USED_UNIONFS_PERMISSION<<1 */
+#define MAY_NFSRO			16
+
+#endif /* _LINUX_UNIONFS_H */
+
