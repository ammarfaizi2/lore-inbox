Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269047AbRHBPvk>; Thu, 2 Aug 2001 11:51:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269070AbRHBPva>; Thu, 2 Aug 2001 11:51:30 -0400
Received: from thebsh.namesys.com ([212.16.0.238]:2064 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP
	id <S269047AbRHBPvY>; Thu, 2 Aug 2001 11:51:24 -0400
From: Nikita Danilov <NikitaDanilov@Yahoo.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15209.30415.639463.761819@beta.namesys.com>
Date: Thu, 2 Aug 2001 19:50:39 +0400
To: Linus Torvalds <Torvalds@Transmeta.COM>
CC: Reiserfs developers mail-list <Reiserfs-Dev@Namesys.COM>,
        linux-kernel@vger.kernel.org
Subject: [PATCH]: reiserfs: E-extern-inline-copy_key.patch
X-Mailer: VM 6.89 under 21.1 (patch 8) "Bryce Canyon" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Linus,

this patch suppresses warnings during reiserfs compilation in
2.4.8-pre3: include/linux/reiserfs_fs.h contains both definition and
declaration of copy_key(). 2.4.8-pre3 changed "extern inline" to "static
inline" in definition, and so it mismatches declaration. Patch just
removes declaration.

Please apply.

[lkml: please CC me, I am not subscribed.]

Nikita.
diff -rup linux-2.4.8-pre3/include/linux/reiserfs_fs.h linux-2.4.8-pre3.patched/include/linux/reiserfs_fs.h
--- linux-2.4.8-pre3/include/linux/reiserfs_fs.h	Wed Aug  1 21:07:39 2001
+++ linux-2.4.8-pre3.patched/include/linux/reiserfs_fs.h	Wed Aug  1 22:32:54 2001
@@ -1652,7 +1652,6 @@ int reiserfs_convert_objectid_map_v1(str
 
 /* stree.c */
 int B_IS_IN_TREE(struct buffer_head *);
-extern inline void copy_key (void * to, void * from);
 extern inline void copy_short_key (void * to, void * from);
 extern inline void copy_item_head(void * p_v_to, void * p_v_from);
 
