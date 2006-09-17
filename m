Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964902AbWIQBvp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964902AbWIQBvp (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Sep 2006 21:51:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964903AbWIQBvp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Sep 2006 21:51:45 -0400
Received: from mrs.stonybrook.edu ([129.49.1.206]:9607 "EHLO
	mrs.stonybrook.edu") by vger.kernel.org with ESMTP id S964902AbWIQBvn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Sep 2006 21:51:43 -0400
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [PATCH 7 of 11] VFS: Use SEEK_{SET, CUR,
	END} instead of hardcoded values
X-Mercurial-Node: 1622a39ffb5442491af603f402d3511b583344d0
Message-Id: <1622a39ffb5442491af6.1158455373@turing.ams.sunysb.edu>
In-Reply-To: <patchbomb.1158455366@turing.ams.sunysb.edu>
Date: Sat, 16 Sep 2006 21:09:33 -0400
From: "Josef 'Jeff' Sipek" <jeffpc@josefsipek.net>
To: linux-kernel@vger.kernel.org
Cc: viro@zeniv.linux.org.uk, hch@infradead.org, akpm@osdl.org,
       dhowells@redhat.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

VFS: Use SEEK_{SET,CUR,END} instead of hardcoded values

Signed-off-by: Josef 'Jeff' Sipek <jeffpc@josefsipek.net>

--

diff -r ca33dbd739b3 -r 1622a39ffb54 fs/locks.c
--- a/fs/locks.c	Sat Sep 16 21:00:45 2006 -0400
+++ b/fs/locks.c	Sat Sep 16 21:00:45 2006 -0400
@@ -314,13 +314,13 @@ static int flock_to_posix_lock(struct fi
 	off_t start, end;
 
 	switch (l->l_whence) {
-	case 0: /*SEEK_SET*/
+	case SEEK_SET:
 		start = 0;
 		break;
-	case 1: /*SEEK_CUR*/
+	case SEEK_CUR:
 		start = filp->f_pos;
 		break;
-	case 2: /*SEEK_END*/
+	case SEEK_END:
 		start = i_size_read(filp->f_dentry->d_inode);
 		break;
 	default:
@@ -364,13 +364,13 @@ static int flock64_to_posix_lock(struct 
 	loff_t start;
 
 	switch (l->l_whence) {
-	case 0: /*SEEK_SET*/
+	case SEEK_SET:
 		start = 0;
 		break;
-	case 1: /*SEEK_CUR*/
+	case SEEK_CUR:
 		start = filp->f_pos;
 		break;
-	case 2: /*SEEK_END*/
+	case SEEK_END:
 		start = i_size_read(filp->f_dentry->d_inode);
 		break;
 	default:


