Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261319AbSJQKja>; Thu, 17 Oct 2002 06:39:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261340AbSJQKj3>; Thu, 17 Oct 2002 06:39:29 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:28167 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S261319AbSJQKj2>; Thu, 17 Oct 2002 06:39:28 -0400
To: James Simmons <jsimmons@infradead.org>
CC: LKML <linux-kernel@vger.kernel.org>
From: Russell King <rmk@arm.linux.org.uk>
Subject: [PATCH] 2.5.29-keyboard
Message-Id: <E18289a-0007tP-00@flint.arm.linux.org.uk>
Date: Thu, 17 Oct 2002 11:45:22 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch appears not to be in 2.5.43, but applies cleanly.

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

