Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131758AbQKRNCv>; Sat, 18 Nov 2000 08:02:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131748AbQKRNCm>; Sat, 18 Nov 2000 08:02:42 -0500
Received: from smtp2.Mountain.Net ([198.77.1.5]:3228 "EHLO nabiki.mountain.net")
	by vger.kernel.org with ESMTP id <S131578AbQKRNC3>;
	Sat, 18 Nov 2000 08:02:29 -0500
Message-ID: <3A1674AF.B6127451@mountain.net>
Date: Sat, 18 Nov 2000 07:23:11 -0500
From: Tom Leete <tleete@mountain.net>
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.4.0-test11 i486)
X-Accept-Language: en-US,en-GB,en,fr,es,it,de,ru
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: linux-kernel@vger.kernel.org
Subject: [PATCH] Typo in test11-pre7 isofs/namei.c
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The second and third arguments of get_joliet_filename() are swapped.

Tom


--- linux-2.4.0-test11/fs/isofs/namei.c.orig	Sat Nov 18 01:55:55 2000
+++ linux-2.4.0-test11/fs/isofs/namei.c	Sat Nov 18 07:08:05 2000
@@ -127,7 +127,7 @@
 			dpnt = tmpname;
 #ifdef CONFIG_JOLIET
 		} else if (dir->i_sb->u.isofs_sb.s_joliet_level) {
-			dlen = get_joliet_filename(de, dir, tmpname);
+			dlen = get_joliet_filename(de, tmpname, dir);
 			dpnt = tmpname;
 #endif
 		} else if (dir->i_sb->u.isofs_sb.s_mapping == 'a') {
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
