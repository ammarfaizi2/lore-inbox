Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262007AbVDVHW6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262007AbVDVHW6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Apr 2005 03:22:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262006AbVDVHW6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Apr 2005 03:22:58 -0400
Received: from mail.fh-wedel.de ([213.39.232.198]:32902 "EHLO
	moskovskaya.fh-wedel.de") by vger.kernel.org with ESMTP
	id S262007AbVDVHWs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Apr 2005 03:22:48 -0400
Date: Fri, 22 Apr 2005 09:22:51 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Phillip Lougher <phillip@lougher.demon.co.uk>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 6/10] squashfs: remove one cast
Message-ID: <20050422072251.GD10459@wohnheim.fh-wedel.de>
References: <20050420065500.GA24213@wohnheim.fh-wedel.de> <20050421010817.GB29755@wohnheim.fh-wedel.de> <20050421011045.GC29755@wohnheim.fh-wedel.de> <20050421011126.GD29755@wohnheim.fh-wedel.de> <20050422072037.GB10459@wohnheim.fh-wedel.de> <20050422072200.GC10459@wohnheim.fh-wedel.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20050422072200.GC10459@wohnheim.fh-wedel.de>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jörn

-- 
/* Keep these two variables together */
int bar;


Signed-off-by: Jörn Engel <joern@wohnheim.fh-wedel.de>
---

 fs/squashfs/inode.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletion(-)

--- linux-2.6.12-rc3cow/fs/squashfs/inode.c~squashfs_cu7	2005-04-22 07:25:24.146150184 +0200
+++ linux-2.6.12-rc3cow/fs/squashfs/inode.c	2005-04-22 09:17:43.831562264 +0200
@@ -1050,7 +1050,8 @@ failed_mount:
 
 static int squashfs_statfs(struct super_block *s, struct kstatfs *buf)
 {
-	squashfs_super_block *sBlk = &((squashfs_sb_info *)s->s_fs_info)->sBlk;
+	squashfs_sb_info *sb = s->s_fs_info;
+	squashfs_super_block *sBlk = &sb->sBlk;
 
 	TRACE("Entered squashfs_statfs\n");
 
