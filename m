Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262080AbUGQW6j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262080AbUGQW6j (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Jul 2004 18:58:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263875AbUGQW62
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Jul 2004 18:58:28 -0400
Received: from digitalimplant.org ([64.62.235.95]:45289 "HELO
	digitalimplant.org") by vger.kernel.org with SMTP id S262114AbUGQWft
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Jul 2004 18:35:49 -0400
Date: Sat, 17 Jul 2004 15:35:39 -0700 (PDT)
From: Patrick Mochel <mochel@digitalimplant.org>
X-X-Sender: mochel@monsoon.he.net
To: linux-kernel@vger.kernel.org
cc: pavel@ucw.cz
Subject: [15/25] Merge pmdisk and swsusp
Message-ID: <Pine.LNX.4.50.0407171530530.22290-100000@monsoon.he.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


ChangeSet 1.1857, 2004/07/17 12:24:57-07:00, mochel@digitalimplant.org

[swsusp] Fix nasty bug in calculating next address to read from.

- The bio code already does this for us..


 kernel/power/swsusp.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)


diff -Nru a/kernel/power/swsusp.c b/kernel/power/swsusp.c
--- a/kernel/power/swsusp.c	2004-07-17 14:51:01 -07:00
+++ b/kernel/power/swsusp.c	2004-07-17 14:51:01 -07:00
@@ -1279,7 +1279,7 @@

 #define PREPARENEXT \
 	{	next = cur->link.next; \
-		next.val = swp_offset(next) * PAGE_SIZE; \
+		next.val = swp_offset(next); \
         }

 	if (bio_read_page(0, cur)) return -EIO;
