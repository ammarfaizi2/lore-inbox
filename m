Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932615AbWJGFzf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932615AbWJGFzf (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Oct 2006 01:55:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932613AbWJGFzE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Oct 2006 01:55:04 -0400
Received: from filer.fsl.cs.sunysb.edu ([130.245.126.2]:54448 "EHLO
	filer.fsl.cs.sunysb.edu") by vger.kernel.org with ESMTP
	id S932422AbWJGFyy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Oct 2006 01:54:54 -0400
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [PATCH 21 of 23] Unionfs: Include file
Message-Id: <606b1edca92cfb812a4f.1160197660@thor.fsl.cs.sunysb.edu>
In-Reply-To: <patchbomb.1160197639@thor.fsl.cs.sunysb.edu>
Date: Sat, 07 Oct 2006 01:07:40 -0400
From: Josef "Jeff" Sipek <jsipek@cs.sunysb.edu>
To: linux-kernel@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org, torvalds@osdl.org, akpm@osdl.org,
       hch@infradead.org, viro@ftp.linux.org.uk
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Josef "Jeff" Sipek <jsipek@cs.sunysb.edu>

Global include file - can be included from userspace by utilities.

Signed-off-by: Josef "Jeff" Sipek <jsipek@cs.sunysb.edu>
Signed-off-by: David Quigley <dquigley@fsl.cs.sunysb.edu>
Signed-off-by: Erez Zadok <ezk@cs.sunysb.edu>

---

1 file changed, 20 insertions(+)
include/linux/union_fs.h |   20 ++++++++++++++++++++

diff -r 4a0655b52aef -r 606b1edca92c include/linux/union_fs.h
--- /dev/null	Thu Jan 01 00:00:00 1970 +0000
+++ b/include/linux/union_fs.h	Sat Oct 07 00:46:20 2006 -0400
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


