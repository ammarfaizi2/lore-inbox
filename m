Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266524AbUAWGow (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jan 2004 01:44:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266529AbUAWGow
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jan 2004 01:44:52 -0500
Received: from mx1.redhat.com ([66.187.233.31]:26066 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S266524AbUAWGgq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jan 2004 01:36:46 -0500
To: linux-kernel@vger.kernel.org
Cc: torvalds@osdl.org, akpm@osdl.org, nathans@sgi.com
From: davej@redhat.com
Subject: logic error in XFS
Message-Id: <E1Ajuub-0000xw-00@hardwired>
Date: Fri, 23 Jan 2004 06:35:25 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Yet another misplaced ! by the looks..

    Dave

diff -urpN --exclude-from=/home/davej/.exclude bk-linus/fs/xfs/xfs_log_recover.c linux-2.5/fs/xfs/xfs_log_recover.c
--- bk-linus/fs/xfs/xfs_log_recover.c	2003-10-09 01:01:24.000000000 +0100
+++ linux-2.5/fs/xfs/xfs_log_recover.c	2004-01-14 07:06:40.000000000 +0000
@@ -1553,7 +1553,7 @@ xlog_recover_reorder_trans(
 		case XFS_LI_BUF:
 		case XFS_LI_6_1_BUF:
 		case XFS_LI_5_3_BUF:
-			if ((!flags & XFS_BLI_CANCEL)) {
+			if (!(flags & XFS_BLI_CANCEL)) {
 				xlog_recover_insert_item_frontq(&trans->r_itemq,
 								itemq);
 				break;
