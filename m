Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264825AbTFVRof (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Jun 2003 13:44:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264839AbTFVRof
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Jun 2003 13:44:35 -0400
Received: from smtp-out.comcast.net ([24.153.64.116]:1112 "EHLO
	smtp-out.comcast.net") by vger.kernel.org with ESMTP
	id S264825AbTFVRob (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Jun 2003 13:44:31 -0400
Date: Sun, 22 Jun 2003 13:55:17 -0400
From: Chris Heath <chris@heathens.co.nz>
Subject: [PATCH][Trivial] Columns in n_tty.c
To: linux-kernel@vger.kernel.org
Message-id: <20030622133048.801E.CHRIS@heathens.co.nz>
MIME-version: 1.0
X-Mailer: Becky! ver. 2.06.02
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
X-Antirelay: Good relay from local net1 127.0.0.1/32
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here's a column counting bug that was lurking in a corner of n_tty.c.

The patch is against 2.5.72, but it applies to 2.4.21 too (with an
offset). 

Chris


--- a/drivers/char/n_tty.c	2003-06-19 21:51:27.000000000 -0400
+++ b/drivers/char/n_tty.c	2003-06-22 12:30:32.000000000 -0400
@@ -325,7 +325,7 @@
 {
 	if (tty->erasing) {
 		put_char('/', tty);
-		tty->column += 2;
+		tty->column++;
 		tty->erasing = 0;
 	}
 }


