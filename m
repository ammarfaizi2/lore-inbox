Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264116AbTDWQai (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Apr 2003 12:30:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264118AbTDWQai
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Apr 2003 12:30:38 -0400
Received: from covert.black-ring.iadfw.net ([209.196.123.142]:6927 "EHLO
	covert.brown-ring.iadfw.net") by vger.kernel.org with ESMTP
	id S264116AbTDWQag (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Apr 2003 12:30:36 -0400
Date: Wed, 23 Apr 2003 10:17:42 -0500
From: Art Haas <ahaas@airmail.net>
To: linux-kernel@vger.kernel.org, Kendrick Smith <kmsmith@umich.edu>,
       Andy Adamson <andros@umich.edu>, nfs@lists.sourceforge.net
Cc: Linus Torvalds <torvalds@transmeta.com>
Subject: [PATCH] Fix C99 initializers in fs/nfs/nfs4proc.c
Message-ID: <20030423151742.GA5681@debian>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

Here's a small patch that fixes missing '=' characters from the
initializers. The patch is against the current BK.

Art Haas

===== fs/nfs/nfs4proc.c 1.20 vs edited =====
--- 1.20/fs/nfs/nfs4proc.c	Mon Apr  7 17:47:19 2003
+++ edited/fs/nfs/nfs4proc.c	Wed Apr 23 10:11:43 2003
@@ -572,10 +572,10 @@
 	u32                     f_bmres[2];
 	u32                     d_bmres[2];
 	struct nfs_fattr        d_attr = {
-		.valid          0,
+		.valid          = 0,
 	};
 	struct nfs_fattr        f_attr = {
-		.valid          0,
+		.valid          = 0,
 	};
 	struct nfs4_getattr     f_getattr = {
 		.gt_bmval       = nfs4_fattr_bitmap,
-- 
To announce that there must be no criticism of the President, or that we
are to stand by the President, right or wrong, is not only unpatriotic
and servile, but is morally treasonable to the American public.
 -- Theodore Roosevelt, Kansas City Star, 1918
