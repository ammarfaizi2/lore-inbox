Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933003AbWJIT1I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933003AbWJIT1I (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Oct 2006 15:27:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932956AbWJIT1H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Oct 2006 15:27:07 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:35775 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S933003AbWJIT1F
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Oct 2006 15:27:05 -0400
Date: Mon, 9 Oct 2006 20:26:58 +0100
From: Al Viro <viro@ftp.linux.org.uk>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Jeff Dike <jdike@addtoit.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] hppfs: readdir callback missed in prototype change
Message-ID: <20061009192658.GT29920@ftp.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/hppfs/hppfs_kern.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/fs/hppfs/hppfs_kern.c b/fs/hppfs/hppfs_kern.c
index dcb6d2e..642675f 100644
--- a/fs/hppfs/hppfs_kern.c
+++ b/fs/hppfs/hppfs_kern.c
@@ -572,7 +572,7 @@ struct hppfs_dirent {
 };
 
 static int hppfs_filldir(void *d, const char *name, int size,
-			 loff_t offset, ino_t inode, unsigned int type)
+			 loff_t offset, u64 inode, unsigned int type)
 {
 	struct hppfs_dirent *dirent = d;
 
-- 
1.4.2.GIT

