Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932200AbWIQBtO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932200AbWIQBtO (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Sep 2006 21:49:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932190AbWIQBst
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Sep 2006 21:48:49 -0400
Received: from mrs.stonybrook.edu ([129.49.1.206]:48774 "EHLO
	mrs.stonybrook.edu") by vger.kernel.org with ESMTP id S932165AbWIQBsG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Sep 2006 21:48:06 -0400
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [PATCH 5 of 11] XFS: Use SEEK_{SET, CUR,
	END} instead of hardcoded values
X-Mercurial-Node: 4cdee5980dad9980ec8ff8d806b6472c696900ae
Message-Id: <4cdee5980dad9980ec8f.1158455371@turing.ams.sunysb.edu>
In-Reply-To: <patchbomb.1158455366@turing.ams.sunysb.edu>
Date: Sat, 16 Sep 2006 21:09:31 -0400
From: "Josef 'Jeff' Sipek" <jeffpc@josefsipek.net>
To: linux-kernel@vger.kernel.org
Cc: xfs-masters@oss.sgi.com, akpm@osdl.org, dhowells@redhat.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

XFS: Use SEEK_{SET,CUR,END} instead of hardcoded values

Signed-off-by: Josef 'Jeff' Sipek <jeffpc@josefsipek.net>

--

diff -r e2fae9fe7a30 -r 4cdee5980dad fs/xfs/xfs_vnodeops.c
--- a/fs/xfs/xfs_vnodeops.c	Sat Sep 16 21:00:45 2006 -0400
+++ b/fs/xfs/xfs_vnodeops.c	Sat Sep 16 21:00:45 2006 -0400
@@ -4510,12 +4510,12 @@ xfs_change_file_space(
 	xfs_iunlock(ip, XFS_ILOCK_SHARED);
 
 	switch (bf->l_whence) {
-	case 0: /*SEEK_SET*/
+	case SEEK_SET:
 		break;
-	case 1: /*SEEK_CUR*/
+	case SEEK_CUR:
 		bf->l_start += offset;
 		break;
-	case 2: /*SEEK_END*/
+	case SEEK_END:
 		bf->l_start += ip->i_d.di_size;
 		break;
 	default:


