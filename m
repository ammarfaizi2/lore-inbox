Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933881AbWKTCYT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933881AbWKTCYT (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Nov 2006 21:24:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933886AbWKTCYQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Nov 2006 21:24:16 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:42513 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S933876AbWKTCYB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Nov 2006 21:24:01 -0500
Date: Mon, 20 Nov 2006 03:24:00 +0100
From: Adrian Bunk <bunk@stusta.de>
To: joel.becker@oracle.com
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] make configfs_dirent_exists() static
Message-ID: <20061120022400.GK31879@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch makes the needlessly global configfs_dirent_exists() static.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.19-rc5-mm2/fs/configfs/dir.c.old	2006-11-20 01:12:59.000000000 +0100
+++ linux-2.6.19-rc5-mm2/fs/configfs/dir.c	2006-11-20 01:13:09.000000000 +0100
@@ -93,8 +93,8 @@
  *
  * called with parent inode's i_mutex held
  */
-int configfs_dirent_exists(struct configfs_dirent *parent_sd,
-			   const unsigned char *new)
+static int configfs_dirent_exists(struct configfs_dirent *parent_sd,
+				  const unsigned char *new)
 {
 	struct configfs_dirent * sd;
 

