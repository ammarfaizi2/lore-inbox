Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132145AbRCVSnR>; Thu, 22 Mar 2001 13:43:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132146AbRCVSnI>; Thu, 22 Mar 2001 13:43:08 -0500
Received: from RAVEL.CODA.CS.CMU.EDU ([128.2.222.215]:1673 "EHLO
	ravel.coda.cs.cmu.edu") by vger.kernel.org with ESMTP
	id <S132145AbRCVSm4>; Thu, 22 Mar 2001 13:42:56 -0500
Date: Thu, 22 Mar 2001 13:42:15 -0500
To: linux-kernel@vger.kernel.org
Cc: torvalds@transmeta.com, alan@lxorguk.ukuu.org.uk,
        Alexander Viro <viro@math.psu.edu>,
        "Stephen C. Tweedie" <sct@redhat.com>
Subject: 2.4.2 fs/inode.c
Message-ID: <20010322134215.A25508@cs.cmu.edu>
Mail-Followup-To: linux-kernel@vger.kernel.org, torvalds@transmeta.com,
	alan@lxorguk.ukuu.org.uk, Alexander Viro <viro@math.psu.edu>,
	"Stephen C. Tweedie" <sct@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.15i
From: Jan Harkes <jaharkes@cs.cmu.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I found some code that seems wrong and didn't even match it's comment.
Patch is against 2.4.2, but should go cleanly against 2.4.3-pre6 as well.

Jan


--- linux/fs/inode.c.orig	Thu Mar 22 13:20:55 2001
+++ linux/fs/inode.c	Thu Mar 22 13:21:32 2001
@@ -133,7 +133,7 @@
 
 	if (sb) {
 		/* Don't do this for I_DIRTY_PAGES - that doesn't actually dirty the inode itself */
-		if (flags & (I_DIRTY | I_DIRTY_SYNC)) {
+		if (flags & (I_DIRTY_SYNC | I_DIRTY_DATASYNC)) {
 			if (sb->s_op && sb->s_op->dirty_inode)
 				sb->s_op->dirty_inode(inode);
 		}
