Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932380AbWBQP5x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932380AbWBQP5x (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Feb 2006 10:57:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932385AbWBQP5x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Feb 2006 10:57:53 -0500
Received: from zproxy.gmail.com ([64.233.162.194]:4692 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932384AbWBQP5w convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Feb 2006 10:57:52 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=OFiGAlmS/uiPB0uIAFiEXV+cBGQrg40RvfCxIETruyHsfQJc6bnfNOJQ0PGOxHamyuf3X4IKL/b+FJ4XbrRgPEzZ4AeVDB6ZYQAmTXs8Mb1GLWNYTfVqqorwq9a4XBnoLSIa/LbpJz3l8aA1FE3dfPyLBqDnmYGsEIkQF9scvm8=
Message-ID: <241c7a2b0602170757x3e5259abyea60fb9f479dd53d@mail.gmail.com>
Date: Fri, 17 Feb 2006 15:57:50 +0000
From: Goldwyn Rodrigues <rgoldwyn@gmail.com>
To: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       okir@monad.swb.de, trivial@kernel.org
Subject: [PATCH] [TRIVIAL] Code comments update in NFS
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

read_cache_mtime is no longer used in nfs_inode. This patch removes
references of read_cache_mtime in the code comments.

Signed-off-by: Goldwyn Rodrigues <rgoldwyn@gmail.com>


--- a/include/linux/nfs_fs.h
+++ b/include/linux/nfs_fs.h
@@ -118,8 +118,7 @@ struct nfs_inode {
 	unsigned long		cache_validity;		/* bit mask */

 	/*
-	 * read_cache_jiffies is when we started read-caching this inode,
-	 * and read_cache_mtime is the mtime of the inode at that time.
+	 * read_cache_jiffies is when we started read-caching this inode.
 	 * attrtimeo is for how long the cached information is assumed
 	 * to be valid. A successful attribute revalidation doubles
 	 * attrtimeo (up to acregmax/acdirmax), a failure resets it to
@@ -128,11 +127,6 @@ struct nfs_inode {
 	 * We need to revalidate the cached attrs for this inode if
 	 *
 	 *	jiffies - read_cache_jiffies > attrtimeo
-	 *
-	 * and invalidate any cached data/flush out any dirty pages if
-	 * we find that
-	 *
-	 *	mtime != read_cache_mtime
 	 */
 	unsigned long		read_cache_jiffies;
 	unsigned long		attrtimeo;
