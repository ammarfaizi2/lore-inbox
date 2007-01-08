Return-Path: <linux-kernel-owner+w=401wt.eu-S1030500AbXAHERC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030500AbXAHERC (ORCPT <rfc822;w@1wt.eu>);
	Sun, 7 Jan 2007 23:17:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030496AbXAHEQk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Jan 2007 23:16:40 -0500
Received: from filer.fsl.cs.sunysb.edu ([130.245.126.2]:50266 "EHLO
	filer.fsl.cs.sunysb.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030490AbXAHEQd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Jan 2007 23:16:33 -0500
From: "Josef 'Jeff' Sipek" <jsipek@cs.sunysb.edu>
To: linux-kernel@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org, hch@infradead.org, viro@ftp.linux.org.uk,
       torvalds@osdl.org, akpm@osdl.org, mhalcrow@us.ibm.com,
       Josef "Jeff" Sipek <jsipek@cs.sunysb.edu>,
       David Quigley <dquigley@fsl.cs.sunysb.edu>,
       Erez Zadok <ezk@cs.sunysb.edu>
Subject: [PATCH 21/24] Unionfs: Include file
Date: Sun,  7 Jan 2007 23:13:13 -0500
Message-Id: <11682295992855-git-send-email-jsipek@cs.sunysb.edu>
X-Mailer: git-send-email 1.4.4.2
In-Reply-To: <1168229596580-git-send-email-jsipek@cs.sunysb.edu>
References: <1168229596580-git-send-email-jsipek@cs.sunysb.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Josef "Jeff" Sipek <jsipek@cs.sunysb.edu>

Global include file - can be included from userspace by utilities.

Signed-off-by: Josef "Jeff" Sipek <jsipek@cs.sunysb.edu>
Signed-off-by: David Quigley <dquigley@fsl.cs.sunysb.edu>
Signed-off-by: Erez Zadok <ezk@cs.sunysb.edu>
---
 include/linux/magic.h    |    2 ++
 include/linux/union_fs.h |   18 ++++++++++++++++++
 2 files changed, 20 insertions(+), 0 deletions(-)

diff --git a/include/linux/magic.h b/include/linux/magic.h
index b78bbf4..ab4261c 100644
--- a/include/linux/magic.h
+++ b/include/linux/magic.h
@@ -33,6 +33,8 @@
 #define REISER2FS_SUPER_MAGIC_STRING	"ReIsEr2Fs"
 #define REISER2FS_JR_SUPER_MAGIC_STRING	"ReIsEr3Fs"
 
+#define UNIONFS_SUPER_MAGIC 0xf15f083d
+
 #define SMB_SUPER_MAGIC		0x517B
 #define USBDEVICE_SUPER_MAGIC	0x9fa2
 
diff --git a/include/linux/union_fs.h b/include/linux/union_fs.h
new file mode 100644
index 0000000..b724031
--- /dev/null
+++ b/include/linux/union_fs.h
@@ -0,0 +1,18 @@
+#ifndef _LINUX_UNION_FS_H
+#define _LINUX_UNION_FS_H
+
+#define UNIONFS_VERSION  "2.0"
+/*
+ * DEFINITIONS FOR USER AND KERNEL CODE:
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
1.4.4.2

