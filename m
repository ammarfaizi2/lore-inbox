Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132266AbRAHTUd>; Mon, 8 Jan 2001 14:20:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132002AbRAHTUZ>; Mon, 8 Jan 2001 14:20:25 -0500
Received: from web.sajt.cz ([212.71.160.9]:22281 "EHLO web.sajt.cz")
	by vger.kernel.org with ESMTP id <S129692AbRAHTUO>;
	Mon, 8 Jan 2001 14:20:14 -0500
Date: Mon, 8 Jan 2001 20:14:47 +0100 (CET)
From: Pavel Rabel <pavel@web.sajt.cz>
To: torvalds@transmeta.com
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] pritk.c oneliner
Message-ID: <Pine.LNX.4.21.0101082013440.12187-100000@web.sajt.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

error is initialised twice

Pavel Rabel


--- kernel/printk.c.old	Mon Jan  8 19:16:12 2001
+++ kernel/printk.c	Mon Jan  8 19:17:54 2001
@@ -125,9 +125,8 @@
 	unsigned long i, j, limit, count;
 	int do_clear = 0;
 	char c;
-	int error = -EPERM;
+	int error = 0;
 
-	error = 0;
 	switch (type) {
 	case 0:		/* Close log */
 		break;

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
