Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270512AbRHHPbY>; Wed, 8 Aug 2001 11:31:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270514AbRHHPbO>; Wed, 8 Aug 2001 11:31:14 -0400
Received: from mail.parknet.co.jp ([210.134.213.6]:49929 "EHLO
	mail.parknet.co.jp") by vger.kernel.org with ESMTP
	id <S270512AbRHHPbL>; Wed, 8 Aug 2001 11:31:11 -0400
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] vfat write wrong value into lcase flag
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: 09 Aug 2001 00:30:58 +0900
Message-ID: <87wv4er2kt.fsf@devron.myhome.or.jp>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.0.104
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The current vfat is writeing wrong value into lcase flag.  It is
writing the lowercase flag, although filename is uppercase.

Please apply.
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>

diff -urN linux-2.4.8-pre6/fs/vfat/namei.c vfat_lcase-2.4.8-pre6/fs/vfat/namei.c
--- linux-2.4.8-pre6/fs/vfat/namei.c	Sat Apr  7 02:51:19 2001
+++ vfat_lcase-2.4.8-pre6/fs/vfat/namei.c	Thu Aug  9 00:07:39 2001
@@ -1056,7 +1056,7 @@
 	(*de)->starthi = 0;
 	(*de)->size = 0;
 	(*de)->attr = is_dir ? ATTR_DIR : ATTR_ARCH;
-	(*de)->lcase = CASE_LOWER_BASE | CASE_LOWER_EXT;
+	(*de)->lcase = 0;
 
 
 	fat_mark_buffer_dirty(sb, *bh);

