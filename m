Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319685AbSH3Vi1>; Fri, 30 Aug 2002 17:38:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319675AbSH3Vgu>; Fri, 30 Aug 2002 17:36:50 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:46603 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S319667AbSH3VfW>; Fri, 30 Aug 2002 17:35:22 -0400
To: James Simmons <jsimmons@transvirtual.com>
CC: LKML <linux-kernel@vger.kernel.org>
From: Russell King <rmk@arm.linux.org.uk>
Subject: [PATCH] 2.5.29-keyboard
Message-Id: <E17ktTu-00034p-00@flint.arm.linux.org.uk>
Date: Fri, 30 Aug 2002 22:39:06 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch appears not to be in 2.5.32, but applies cleanly.

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

