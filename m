Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261950AbSKRKIb>; Mon, 18 Nov 2002 05:08:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261963AbSKRKIb>; Mon, 18 Nov 2002 05:08:31 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:16913 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S261950AbSKRKI3>; Mon, 18 Nov 2002 05:08:29 -0500
To: James Simmons <jsimmons@infradead.org>,
       Linus Torvalds <torvalds@transmeta.com>
CC: LKML <linux-kernel@vger.kernel.org>
From: Russell King <rmk@arm.linux.org.uk>
Subject: [PATCH] 2.5.29-keyboard
Message-Id: <E18Diw5-0000JY-00@raistlin.arm.linux.org.uk>
Date: Mon, 18 Nov 2002 10:15:21 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch appears not to be in 2.5.48, but applies cleanly.

Some ARM-based machines have an extra key (#) on their numeric keypad
that produces the ESC [ S or ESC O S escape sequences.  This patch adds
Linux support for the key.

 drivers/char/keyboard.c |    4 ++--
 1 files changed, 2 insertions, 2 deletions

diff -urN orig/drivers/char/keyboard.c linux/drivers/char/keyboard.c
--- orig/drivers/char/keyboard.c	Wed Jul 17 15:10:39 2002
+++ linux/drivers/char/keyboard.c	Wed Jul 17 15:14:57 2002
@@ -552,8 +552,8 @@
 
 static void k_pad(struct vc_data *vc, unsigned char value, char up_flag)
 {
-	static const char *pad_chars = "0123456789+-*/\015,.?()";
-	static const char *app_map = "pqrstuvwxylSRQMnnmPQ";
+	static const char *pad_chars = "0123456789+-*/\015,.?()#";
+	static const char *app_map = "pqrstuvwxylSRQMnnmPQS";
 
 	if (up_flag)
 		return;		/* no action, if this is a key release */

