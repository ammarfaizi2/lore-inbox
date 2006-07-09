Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932525AbWGIXcx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932525AbWGIXcx (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Jul 2006 19:32:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932524AbWGIXcx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Jul 2006 19:32:53 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:7953 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932330AbWGIXcx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Jul 2006 19:32:53 -0400
Date: Mon, 10 Jul 2006 01:32:51 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>, mark.fasheh@oracle.com,
       kurt.hackel@oracle.com
Cc: linux-kernel@vger.kernel.org, ocfs2-devel@oss.oracle.com
Subject: [-mm patch] fs/ocfs2/ioctl.c should #include "ioctl.h"
Message-ID: <20060709233251.GW13938@stusta.de>
References: <20060709021106.9310d4d1.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060709021106.9310d4d1.akpm@osdl.org>
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 09, 2006 at 02:11:06AM -0700, Andrew Morton wrote:
>...
> Changes since 2.6.17-mm6:
>...
>  git-ocfs2.patch
>...
>  git trees
>...

Every file should #include the headers containing the prototypes for its 
global functions.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.18-rc1-mm1-full/fs/ocfs2/ioctl.c.old	2006-07-09 20:04:41.000000000 +0200
+++ linux-2.6.18-rc1-mm1-full/fs/ocfs2/ioctl.c	2006-07-09 20:07:00.000000000 +0200
@@ -18,6 +18,8 @@
 #include "journal.h"
 
 #include "ocfs2_fs.h"
+#include "ioctl.h"
+
 #include <linux/ext2_fs.h>
 
 static int ocfs2_get_inode_attr(struct inode *inode, unsigned *flags)

