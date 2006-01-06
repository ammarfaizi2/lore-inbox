Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964831AbWAFSbZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964831AbWAFSbZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jan 2006 13:31:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964835AbWAFSbZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jan 2006 13:31:25 -0500
Received: from mx1.mail.ru ([194.67.23.121]:41524 "EHLO mx1.mail.ru")
	by vger.kernel.org with ESMTP id S964831AbWAFSbY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jan 2006 13:31:24 -0500
Date: Fri, 6 Jan 2006 21:18:01 +0300
From: Evgeniy <dushistov@mail.ru>
To: torvalds@osdl.org, akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH] fs/ufs: debug mode compilation failure
Message-ID: <20060106181801.GA11579@rain.homenetwork>
Mail-Followup-To: torvalds@osdl.org, akpm@osdl.org,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch should fix compilation failure of fs/ufs/dir.c with defined UFS_DIR_DEBUG

Signed-off-by: Evgeniy Dushistov <dushistov@mail.ru>

---

--- linux-2.6.15-rc7/fs/ufs/dir.c.orig	2006-01-02 16:34:41.932673500 +0300
+++ linux-2.6.15-rc7/fs/ufs/dir.c	2006-01-02 16:36:20.090808000 +0300
@@ -491,7 +491,7 @@ int ufs_delete_entry (struct inode * ino
 	
 	UFSD(("ino %u, reclen %u, namlen %u, name %s\n",
 		fs32_to_cpu(sb, de->d_ino),
-		fs16to_cpu(sb, de->d_reclen),
+		fs16_to_cpu(sb, de->d_reclen),
 		ufs_get_de_namlen(sb, de), de->d_name))
 
 	while (i < bh->b_size) {

-- 
/Evgeniy

