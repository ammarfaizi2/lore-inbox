Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262890AbUJ1XQc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262890AbUJ1XQc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Oct 2004 19:16:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263027AbUJ1XOk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Oct 2004 19:14:40 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:18194 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S263028AbUJ1XLo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Oct 2004 19:11:44 -0400
Date: Fri, 29 Oct 2004 01:11:12 +0200
From: Adrian Bunk <bunk@stusta.de>
To: aia21@cantab.net
Cc: linux-ntfs-dev@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [2.6 patch] NTFS: remove an unused function
Message-ID: <20041028231112.GB3207@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; x-action=pgp-signed
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

The patch below removes an unused function from fs/ntfs/runlist.c


diffstat output:
 fs/ntfs/runlist.c |   24 ------------------------
 1 files changed, 24 deletions(-)


Signed-off-by: Adrian Bunk <bunk@stusta.de>

- --- linux-2.6.10-rc1-mm1-full/fs/ntfs/runlist.c.old	2004-10-28 22:46:08.000000000 +0200
+++ linux-2.6.10-rc1-mm1-full/fs/ntfs/runlist.c	2004-10-28 22:46:38.000000000 +0200
@@ -140,30 +140,6 @@
 }
 
 /**
- - * ntfs_rl_merge - test if two runlists can be joined together and merge them
- - * @dst:	original, destination runlist
- - * @src:	new runlist to merge with @dst
- - *
- - * Test if two runlists can be joined together. For this, their VCNs and LCNs
- - * must be adjacent. If they can be merged, perform the merge, writing into
- - * the destination runlist @dst.
- - *
- - * It is up to the caller to serialize access to the runlists @dst and @src.
- - *
- - * Return: TRUE   Success, the runlists have been merged.
- - *	   FALSE  Failure, the runlists cannot be merged and have not been
- - *		  modified.
- - */
- -static inline BOOL ntfs_rl_merge(runlist_element *dst, runlist_element *src)
- -{
- -	BOOL merge = ntfs_are_rl_mergeable(dst, src);
- -
- -	if (merge)
- -		__ntfs_rl_merge(dst, src);
- -	return merge;
- -}
- -
- -/**
  * ntfs_rl_append - append a runlist after a given element
  * @dst:	original runlist to be worked on
  * @dsize:	number of elements in @dst (including end marker)

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQFBgXyQmfzqmE8StAARAoczAJ44uT1R+YHBkY4QN3x/a041a+M35ACgg+Gp
3J6gsMxiK1Nv330VE3d+C/8=
=/T69
-----END PGP SIGNATURE-----
