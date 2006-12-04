Return-Path: <linux-kernel-owner+willy=40w.ods.org-S936410AbWLDMkR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936410AbWLDMkR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Dec 2006 07:40:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936352AbWLDMf7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Dec 2006 07:35:59 -0500
Received: from filer.fsl.cs.sunysb.edu ([130.245.126.2]:6879 "EHLO
	filer.fsl.cs.sunysb.edu") by vger.kernel.org with ESMTP
	id S936343AbWLDMfb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Dec 2006 07:35:31 -0500
From: "Josef 'Jeff' Sipek" <jsipek@cs.sunysb.edu>
To: linux-kernel@vger.kernel.org
Cc: torvalds@osdl.org, akpm@osdl.org, hch@infradead.org, viro@ftp.linux.org.uk,
       linux-fsdevel@vger.kernel.org, mhalcrow@us.ibm.com,
       Josef "Jeff" Sipek <jsipek@cs.sunysb.edu>
Subject: [PATCH 32/35] Unionfs: Include file
Date: Mon,  4 Dec 2006 07:31:05 -0500
Message-Id: <1165235472347-git-send-email-jsipek@cs.sunysb.edu>
X-Mailer: git-send-email 1.4.3.3
In-Reply-To: <1165235468365-git-send-email-jsipek@cs.sunysb.edu>
References: <1165235468365-git-send-email-jsipek@cs.sunysb.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Josef "Jeff" Sipek <jsipek@cs.sunysb.edu>

Global include file - can be included from userspace by utilities.

Signed-off-by: Josef "Jeff" Sipek <jsipek@cs.sunysb.edu>
Signed-off-by: David Quigley <dquigley@fsl.cs.sunysb.edu>
Signed-off-by: Erez Zadok <ezk@cs.sunysb.edu>
---
 include/linux/union_fs.h |   20 ++++++++++++++++++++
 1 files changed, 20 insertions(+), 0 deletions(-)

diff --git a/include/linux/union_fs.h b/include/linux/union_fs.h
new file mode 100644
index 0000000..e76d3cf
--- /dev/null
+++ b/include/linux/union_fs.h
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
-- 
1.4.3.3

