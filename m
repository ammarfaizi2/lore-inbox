Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263019AbTCSMXJ>; Wed, 19 Mar 2003 07:23:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263003AbTCSMVB>; Wed, 19 Mar 2003 07:21:01 -0500
Received: from mail2.sonytel.be ([195.0.45.172]:53128 "EHLO mail.sonytel.be")
	by vger.kernel.org with ESMTP id <S263005AbTCSMSk>;
	Wed, 19 Mar 2003 07:18:40 -0500
Date: Wed, 19 Mar 2003 13:29:40 +0100 (MET)
Message-Id: <200303191229.h2JCTeG01024@vervain.sonytel.be>
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] Affs sizeof()
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Affs: Make sure the sizeof() is always correct (from Roman Zippel)

--- linux-2.5.x/fs/affs/super.c	Tue Mar 18 11:27:51 2003
+++ linux-m68k-2.5.x/fs/affs/super.c	Tue Mar 18 13:15:12 2003
@@ -298,8 +298,7 @@
 	if (!sbi)
 		return -ENOMEM;
 	sb->s_fs_info = sbi;
-	memset(sbi, 0, sizeof(struct affs_sb_info));
-
+	memset(sbi, 0, sizeof(*sbi));
 	init_MUTEX(&sbi->s_bmlock);
 
 	if (!parse_options(data,&uid,&gid,&i,&reserved,&root_block,

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
