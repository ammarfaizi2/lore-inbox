Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261337AbVDBXBZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261337AbVDBXBZ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Apr 2005 18:01:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261341AbVDBW7N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Apr 2005 17:59:13 -0500
Received: from mail.dif.dk ([193.138.115.101]:65186 "EHLO saerimmer.dif.dk")
	by vger.kernel.org with ESMTP id S261337AbVDBWzj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Apr 2005 17:55:39 -0500
Date: Sun, 3 Apr 2005 00:57:58 +0200 (CEST)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: Steve French <smfrench@austin.rr.com>
Cc: Steven French <sfrench@us.ibm.com>, linux-kernel@vger.kernel.org
Subject: [PATCH][6/7] cifs: dir.c cleanup - long lines 1
Message-ID: <Pine.LNX.4.62.0504030056590.2525@dragon.hyggekrogen.localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lines should be <80 chars in length.

Signed-off-by: Jesper Juhl <juhl-lkml@dif.dk>


--- linux-2.6.12-rc1-mm4/fs/cifs/dir.c.with_patch5	2005-04-03 00:06:17.000000000 +0200
+++ linux-2.6.12-rc1-mm4/fs/cifs/dir.c	2005-04-03 00:07:59.000000000 +0200
@@ -193,9 +193,9 @@ int cifs_create(struct inode *inode, str
 	}
 
 	if (nd) {
-		if ((nd->intent.open.flags & O_ACCMODE) == O_RDONLY)
+		if ((nd->intent.open.flags & O_ACCMODE) == O_RDONLY) {
 			desiredAccess = GENERIC_READ;
-		else if ((nd->intent.open.flags & O_ACCMODE) == O_WRONLY) {
+		} else if ((nd->intent.open.flags & O_ACCMODE) == O_WRONLY) {
 			desiredAccess = GENERIC_WRITE;
 			write_only = TRUE;
 		} else if ((nd->intent.open.flags & O_ACCMODE) == O_RDWR) {
@@ -205,15 +205,16 @@ int cifs_create(struct inode *inode, str
 			desiredAccess = GENERIC_READ | GENERIC_WRITE;
 		}
 
-		if ((nd->intent.open.flags & (O_CREAT | O_EXCL)) == (O_CREAT | O_EXCL))
+		if ((nd->intent.open.flags & (O_CREAT | O_EXCL)) ==
+		    (O_CREAT | O_EXCL))
 			disposition = FILE_CREATE;
-		else if ((nd->intent.open.flags & (O_CREAT | O_TRUNC)) == (O_CREAT | O_TRUNC))
+		else if ((nd->intent.open.flags & (O_CREAT | O_TRUNC)) ==
+			 (O_CREAT | O_TRUNC))
 			disposition = FILE_OVERWRITE_IF;
 		else if ((nd->intent.open.flags & O_CREAT) == O_CREAT)
 			disposition = FILE_OPEN_IF;
-		else {
+		else
 			cFYI(1, ("Create flag not set in create function"));
-		}
 	}
 
 	/* BB add processing to set equivalent of mode -
