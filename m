Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315300AbSFJNvw>; Mon, 10 Jun 2002 09:51:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314485AbSFJNuc>; Mon, 10 Jun 2002 09:50:32 -0400
Received: from bitshadow.namesys.com ([212.16.7.71]:24704 "EHLO namesys.com")
	by vger.kernel.org with ESMTP id <S314748AbSFJNuN>;
	Mon, 10 Jun 2002 09:50:13 -0400
Date: Mon, 10 Jun 2002 17:42:56 +0400
From: Hans Reiser <reiser@bitshadow.namesys.com>
Message-Id: <200206101342.g5ADgu0S003878@bitshadow.namesys.com>
To: torvalds@transmeta.com, linux-kernel@vger.kernel.org,
        reiserfs-dev@namesys.com
Subject: [BK] [2.5] reiserfs changeset 13 of 15 for 2.5.21
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a changeset 13 out of 15.

You can pull it from bk://namesys.com/bk/reiser3-linux-2.5
Or use plain text patch at the end of this message

    transaction replay status report, using bdevname instead of __bdevname.

Chris Mason spent a lot of efforts in helping to convert this changeset to
Linus-compatible form.

Diffstat:
 journal.c |    2 +-

Plaintext patch:

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.606   -> 1.607  
#	fs/reiserfs/journal.c	1.48    -> 1.49   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/05/30	green@angband.namesys.com	1.607
# journal.c:
#   reiserfs: transaction replay status report, using bdevname instead of __bdevname.
# --------------------------------------------
#
diff -Nru a/fs/reiserfs/journal.c b/fs/reiserfs/journal.c
--- a/fs/reiserfs/journal.c	Thu May 30 18:42:28 2002
+++ b/fs/reiserfs/journal.c	Thu May 30 18:42:28 2002
@@ -1659,7 +1659,7 @@
 
   cur_dblock = SB_ONDISK_JOURNAL_1st_BLOCK(p_s_sb) ;
   printk("reiserfs: checking transaction log (%s) for (%s)\n",
-	 __bdevname(SB_JOURNAL_DEV(p_s_sb)), reiserfs_bdevname(p_s_sb));
+	 bdevname(SB_JOURNAL(p_s_sb)->j_dev_bd), reiserfs_bdevname(p_s_sb));
   start = CURRENT_TIME ;
 
   /* step 1, read in the journal header block.  Check the transaction it says 
