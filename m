Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423740AbWKFKFz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423740AbWKFKFz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Nov 2006 05:05:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423697AbWKFKFz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Nov 2006 05:05:55 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:4877 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1423740AbWKFKFy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Nov 2006 05:05:54 -0500
Date: Mon, 6 Nov 2006 11:05:54 +0100
From: Adrian Bunk <bunk@stusta.de>
To: ext2-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] ext4_ext_split(): remove dead code
Message-ID: <20061106100554.GH5778@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The Coverity checker noted that this was dead code, since in all places 
above in this function, "err" is immediately checked.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6/fs/ext4/extents.c.old	2006-11-06 11:02:09.000000000 +0100
+++ linux-2.6/fs/ext4/extents.c	2006-11-06 11:02:29.000000000 +0100
@@ -800,9 +800,6 @@ static int ext4_ext_split(handle_t *hand
 	}
 
 	/* insert new index */
-	if (err)
-		goto cleanup;
-
 	err = ext4_ext_insert_index(handle, inode, path + at,
 				    le32_to_cpu(border), newblock);
 

