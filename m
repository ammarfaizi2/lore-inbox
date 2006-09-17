Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964900AbWIQBt5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964900AbWIQBt5 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Sep 2006 21:49:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932174AbWIQBry
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Sep 2006 21:47:54 -0400
Received: from mrs.stonybrook.edu ([129.49.1.206]:49861 "EHLO
	mrs.stonybrook.edu") by vger.kernel.org with ESMTP id S932173AbWIQBrs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Sep 2006 21:47:48 -0400
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [PATCH 6 of 11] NFS: Use SEEK_END instead of hardcoded value
X-Mercurial-Node: ca33dbd739b3eb1335851ddef8ed401717e367a8
Message-Id: <ca33dbd739b3eb133585.1158455372@turing.ams.sunysb.edu>
In-Reply-To: <patchbomb.1158455366@turing.ams.sunysb.edu>
Date: Sat, 16 Sep 2006 21:09:32 -0400
From: "Josef 'Jeff' Sipek" <jeffpc@josefsipek.net>
To: linux-kernel@vger.kernel.org
Cc: neilb@cse.unsw.edu.au, trond.myklebust@fys.uio.no, akpm@osdl.org,
       dhowells@redhat.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

NFS: Use SEEK_END instead of hardcoded value

Signed-off-by: Josef 'Jeff' Sipek <jeffpc@josefsipek.net>

--

diff -r 4cdee5980dad -r ca33dbd739b3 fs/nfs/file.c
--- a/fs/nfs/file.c	Sat Sep 16 21:00:45 2006 -0400
+++ b/fs/nfs/file.c	Sat Sep 16 21:00:45 2006 -0400
@@ -157,7 +157,7 @@ static loff_t nfs_file_llseek(struct fil
 static loff_t nfs_file_llseek(struct file *filp, loff_t offset, int origin)
 {
 	/* origin == SEEK_END => we must revalidate the cached file length */
-	if (origin == 2) {
+	if (origin == SEEK_END) {
 		struct inode *inode = filp->f_mapping->host;
 		int retval = nfs_revalidate_file_size(inode, filp);
 		if (retval < 0)


