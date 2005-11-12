Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751274AbVKLE3F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751274AbVKLE3F (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Nov 2005 23:29:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751283AbVKLE3F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Nov 2005 23:29:05 -0500
Received: from avenger.apcoh.org ([62.121.68.209]:5380 "EHLO chmurka.net")
	by vger.kernel.org with ESMTP id S1751274AbVKLE3E (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Nov 2005 23:29:04 -0500
Date: Sat, 12 Nov 2005 05:28:48 +0100 (CET)
From: Adam Wysocki <gophi@chmurka.net>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] Minor warning when building ext3 without quota
Message-ID: <Pine.LNX.4.64.0511120528440.21516@news.chmurka.net>
X-Tree: ;>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Adam Wysocki <gophi@nospam.chmurka.net>

This tiny patch eliminates a warning message about unused variable 
sbi, when compiling ext3 support without quota support enabled.

Signed-off-by: Adam Wysocki <gophi@nospam.chmurka.net>

---

--- linux-2.6.14.2/fs/ext3/super.c.orig Sat Nov 12 05:17:24 2005
+++ linux-2.6.14.2/fs/ext3/super.c      Sat Nov 12 05:17:44 2005
@@ -513,7 +513,9 @@ static void ext3_clear_inode(struct inod
 static int ext3_show_options(struct seq_file *seq, struct vfsmount *vfs)
 {
 	struct super_block *sb = vfs->mnt_sb;
+#if defined(CONFIG_QUOTA)
 	struct ext3_sb_info *sbi = EXT3_SB(sb);
+#endif

 	if (test_opt(sb, DATA_FLAGS) == EXT3_MOUNT_JOURNAL_DATA)
 		seq_puts(seq, ",data=journal");

-- 
Adam Wysocki :: www.gophi.rotfl.pl :: GG: 1234 :: Fidonet: 2:480/138
