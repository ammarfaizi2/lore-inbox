Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264377AbTFWAE7 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Jun 2003 20:04:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264469AbTFWAE7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Jun 2003 20:04:59 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:2765 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S264377AbTFWAE6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Jun 2003 20:04:58 -0400
Date: Mon, 23 Jun 2003 02:19:02 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Steve French <sfrench@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, trivial@rustcorp.com.au
Subject: [2.5 patch] postfix three CIFS u64 constants with ULL
Message-ID: <20030623001902.GE3710@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch below postfixes three CIFS u64 constants with ULL.

Please apply
Adrian

--- linux-2.5.73-not-full/fs/cifs/inode.c.old	2003-06-23 02:15:06.000000000 +0200
+++ linux-2.5.73-not-full/fs/cifs/inode.c	2003-06-23 02:16:17.000000000 +0200
@@ -635,9 +635,9 @@
 	struct cifsFileInfo *open_file = NULL;
 	FILE_BASIC_INFO time_buf;
 	int set_time = FALSE;
-	__u64 mode = 0xFFFFFFFFFFFFFFFF;
-	__u64 uid = 0xFFFFFFFFFFFFFFFF;
-	__u64 gid = 0xFFFFFFFFFFFFFFFF;
+	__u64 mode = 0xFFFFFFFFFFFFFFFFULL;
+	__u64 uid = 0xFFFFFFFFFFFFFFFFULL;
+	__u64 gid = 0xFFFFFFFFFFFFFFFFULL;
 	struct cifsInodeInfo *cifsInode;
 
 	xid = GetXid();

