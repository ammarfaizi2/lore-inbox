Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261334AbVDBXBX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261334AbVDBXBX (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Apr 2005 18:01:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261337AbVDBW70
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Apr 2005 17:59:26 -0500
Received: from mail.dif.dk ([193.138.115.101]:62882 "EHLO saerimmer.dif.dk")
	by vger.kernel.org with ESMTP id S261334AbVDBWyd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Apr 2005 17:54:33 -0500
Date: Sun, 3 Apr 2005 00:56:48 +0200 (CEST)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: Steve French <smfrench@austin.rr.com>
Cc: Steven French <sfrench@us.ibm.com>, linux-kernel@vger.kernel.org
Subject: [PATCH][5/7] cifs: dir.c cleanup - cast
Message-ID: <Pine.LNX.4.62.0504030055540.2525@dragon.hyggekrogen.localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Don't cast the pointer returned from kmalloc()

Signed-off-by: Jesper Juhl <juhl-lkml@dif.dk>


--- linux-2.6.12-rc1-mm4/fs/cifs/dir.c.with_patch4	2005-04-03 00:03:33.000000000 +0200
+++ linux-2.6.12-rc1-mm4/fs/cifs/dir.c	2005-04-03 00:04:58.000000000 +0200
@@ -280,8 +280,8 @@ int cifs_create(struct inode *inode, str
 			/* mknod case - do not leave file open */
 			CIFSSMBClose(xid, pTcon, fileHandle);
 		} else if (newinode) {
-			pCifsFile = (struct cifsFileInfo *)
-			   kmalloc(sizeof (struct cifsFileInfo), GFP_KERNEL);
+			pCifsFile = kmalloc(sizeof(struct cifsFileInfo),
+					    GFP_KERNEL);
 
 			if (pCifsFile) {
 				memset((char *)pCifsFile, 0,
