Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267142AbSLDXCL>; Wed, 4 Dec 2002 18:02:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267139AbSLDXCL>; Wed, 4 Dec 2002 18:02:11 -0500
Received: from mailout08.sul.t-online.com ([194.25.134.20]:12716 "EHLO
	mailout08.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S267142AbSLDXCL>; Wed, 4 Dec 2002 18:02:11 -0500
From: Olaf Dietsche <olaf.dietsche#list.linux-kernel@t-online.de>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] 2.5.50: unused code in link_path_walk()
Date: Thu, 05 Dec 2002 00:09:25 +0100
Message-ID: <87y975xty2.fsf@goat.bogus.local>
User-Agent: Gnus/5.090005 (Oort Gnus v0.05) XEmacs/21.4 (Military
 Intelligence, i386-debian-linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch removes one unnecessary line of code.

Regards, Olaf.

diff -urN a/fs/namei.c b/fs/namei.c
--- a/fs/namei.c	Thu Nov 28 20:44:46 2002
+++ b/fs/namei.c	Wed Dec  4 23:04:54 2002
@@ -700,7 +700,6 @@
 				if (this.name[1] != '.')
 					break;
 				follow_dotdot(&nd->mnt, &nd->dentry);
-				inode = nd->dentry->d_inode;
 				/* fallthrough */
 			case 1:
 				goto return_base;
