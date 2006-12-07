Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1032037AbWLGLIm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1032037AbWLGLIm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Dec 2006 06:08:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1032038AbWLGLIm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Dec 2006 06:08:42 -0500
Received: from tmailer.gwdg.de ([134.76.10.23]:38121 "EHLO tmailer.gwdg.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1032037AbWLGLIk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Dec 2006 06:08:40 -0500
Date: Thu, 7 Dec 2006 12:01:38 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: "Josef 'Jeff' Sipek" <jsipek@cs.sunysb.edu>
cc: linux-kernel@vger.kernel.org, torvalds@osdl.org, akpm@osdl.org,
       hch@infradead.org, viro@ftp.linux.org.uk, linux-fsdevel@vger.kernel.org,
       mhalcrow@us.ibm.com
Subject: Re: [PATCH 32/35] Unionfs: Include file
In-Reply-To: <1165235472347-git-send-email-jsipek@cs.sunysb.edu>
Message-ID: <Pine.LNX.4.61.0612071200580.2863@yvahk01.tjqt.qr>
References: <1165235468365-git-send-email-jsipek@cs.sunysb.edu>
 <1165235472347-git-send-email-jsipek@cs.sunysb.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Dec 4 2006 07:31, Josef 'Jeff' Sipek wrote:

>Date: Mon,  4 Dec 2006 07:31:05 -0500
>From: Josef 'Jeff' Sipek <jsipek@cs.sunysb.edu>
>To: linux-kernel@vger.kernel.org
>Cc: torvalds@osdl.org, akpm@osdl.org, hch@infradead.org, viro@ftp.linux.org.uk,
>    linux-fsdevel@vger.kernel.org, mhalcrow@us.ibm.com,
>    Josef Jeff Sipek <jsipek@cs.sunysb.edu>
>Subject: [PATCH 32/35] Unionfs: Include file
>
>From: Josef "Jeff" Sipek <jsipek@cs.sunysb.edu>
>
>Global include file - can be included from userspace by utilities.
>
>Signed-off-by: Josef "Jeff" Sipek <jsipek@cs.sunysb.edu>
>Signed-off-by: David Quigley <dquigley@fsl.cs.sunysb.edu>
>Signed-off-by: Erez Zadok <ezk@cs.sunysb.edu>
>---
> include/linux/union_fs.h |   20 ++++++++++++++++++++
> 1 files changed, 20 insertions(+), 0 deletions(-)
>
>diff --git a/include/linux/union_fs.h b/include/linux/union_fs.h
>new file mode 100644
>index 0000000..e76d3cf
>--- /dev/null
>+++ b/include/linux/union_fs.h
>@@ -0,0 +1,20 @@
>+#ifndef _LINUX_UNION_FS_H
>+#define _LINUX_UNION_FS_H
>+
>+#define UNIONFS_VERSION  "2.0"
>+/*
>+ * DEFINITIONS FOR USER AND KERNEL CODE:
>+ * (Note: ioctl numbers 1--9 are reserved for fistgen, the rest
>+ *  are auto-generated automatically based on the user's .fist file.)
>+ */

FIST is not used here so is this comment still appropriate?


>+# define UNIONFS_IOCTL_INCGEN		_IOR(0x15, 11, int)
>+# define UNIONFS_IOCTL_QUERYFILE	_IOR(0x15, 15, int)
>+
>+/* We don't support normal remount, but unionctl uses it. */
>+# define UNIONFS_REMOUNT_MAGIC		0x4a5a4380
>+
>+/* should be at least LAST_USED_UNIONFS_PERMISSION<<1 */
>+#define MAY_NFSRO			16
>+
>+#endif /* _LINUX_UNIONFS_H */
>+

	-`J'
-- 
