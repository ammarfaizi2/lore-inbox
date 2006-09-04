Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932479AbWIDH7f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932479AbWIDH7f (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Sep 2006 03:59:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932481AbWIDH7f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Sep 2006 03:59:35 -0400
Received: from emailer.gwdg.de ([134.76.10.24]:19410 "EHLO emailer.gwdg.de")
	by vger.kernel.org with ESMTP id S932477AbWIDH7d (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Sep 2006 03:59:33 -0400
Date: Mon, 4 Sep 2006 09:55:34 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Josef Sipek <jsipek@cs.sunysb.edu>
cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       hch@infradead.org, akpm@osdl.org, viro@ftp.linux.org.uk
Subject: Re: [PATCH 22/22][RFC] Unionfs: Include file
In-Reply-To: <20060901020222.GW5788@fsl.cs.sunysb.edu>
Message-ID: <Pine.LNX.4.61.0609040954490.22518@yvahk01.tjqt.qr>
References: <20060901013512.GA5788@fsl.cs.sunysb.edu> <20060901020222.GW5788@fsl.cs.sunysb.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Aug 31 2006 22:02, Josef Sipek wrote:

>Date: Thu, 31 Aug 2006 22:02:22 -0400
>From: Josef Sipek <jsipek@cs.sunysb.edu>
>To: linux-kernel@vger.kernel.org
>Cc: linux-fsdevel@vger.kernel.org, hch@infradead.org, akpm@osdl.org,
>    viro@ftp.linux.org.uk
>Subject: [PATCH 22/22][RFC] Unionfs: Include file
>
>From: Josef "Jeff" Sipek <jsipek@cs.sunysb.edu>
>
>Global include file - can be included from userspace by utilities.
>
>Signed-off-by: Josef "Jeff" Sipek <jsipek@cs.sunysb.edu>
>Signed-off-by: David Quigley <dquigley@fsl.cs.sunysb.edu>
>Signed-off-by: Erez Zadok <ezk@cs.sunysb.edu>
>
>---
>
> include/linux/union_fs.h |   20 ++++++++++++++++++++
> 1 file changed, 20 insertions(+)
>
>diff -Nur -x linux-2.6-git/Documentation/dontdiff linux-2.6-git/include/linux/union_fs.h linux-2.6-git-unionfs/include/linux/union_fs.h
>--- linux-2.6-git/include/linux/union_fs.h	1969-12-31 19:00:00.000000000 -0500
>+++ linux-2.6-git-unionfs/include/linux/union_fs.h	2006-08-31 19:04:04.000000000 -0400
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
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>

Jan Engelhardt
-- 

-- 
VGER BF report: U 0.495265
