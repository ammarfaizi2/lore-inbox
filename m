Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262079AbVCZOHa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262079AbVCZOHa (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Mar 2005 09:07:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262092AbVCZOEG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Mar 2005 09:04:06 -0500
Received: from mail.dif.dk ([193.138.115.101]:3989 "EHLO mail.dif.dk")
	by vger.kernel.org with ESMTP id S262079AbVCZOBh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Mar 2005 09:01:37 -0500
Date: Sat, 26 Mar 2005 15:03:36 +0100 (CET)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: Steve French <smfrench@austin.rr.com>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH][5/6] cifs: inode.c cleanup - cast
Message-ID: <Pine.LNX.4.62.0503261502241.2488@dragon.hyggekrogen.localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Remove pointless cast (and fix a single space the previous patches missed).

Signed-off-by: Jesper Juhl <juhl-lkml@dif.dk>


--- linux-2.6.12-rc1-mm3/fs/cifs/inode.c.with_patch4	2005-03-26 14:18:22.000000000 +0100
+++ linux-2.6.12-rc1-mm3/fs/cifs/inode.c	2005-03-26 14:18:32.000000000 +0100
@@ -206,7 +206,7 @@ int cifs_get_inode_info(struct inode **p
 
 	/* if file info not passed in then get it from server */
 	if (pfindData == NULL) {
-		buf = kmalloc(sizeof(FILE_ALL_INFO),GFP_KERNEL);
+		buf = kmalloc(sizeof(FILE_ALL_INFO), GFP_KERNEL);
 		if (buf == NULL)
 			return -ENOMEM;
 		pfindData = (FILE_ALL_INFO *)buf;
@@ -417,8 +417,7 @@ int cifs_unlink(struct inode *inode, str
 		}
 	} else if (rc == -EACCES) {
 		/* try only if r/o attribute set in local lookup data? */
-		pinfo_buf = (FILE_BASIC_INFO *)kmalloc(sizeof(FILE_BASIC_INFO),
-						       GFP_KERNEL);
+		pinfo_buf = kmalloc(sizeof(FILE_BASIC_INFO), GFP_KERNEL);
 		if (pinfo_buf) {
 			memset(pinfo_buf, 0, sizeof(FILE_BASIC_INFO));
 			/* ATTRS set to normal clears r/o bit */

