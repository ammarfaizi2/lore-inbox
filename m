Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263169AbTDHJFu (for <rfc822;willy@w.ods.org>); Tue, 8 Apr 2003 05:05:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263261AbTDHJFu (for <rfc822;linux-kernel-outgoing>); Tue, 8 Apr 2003 05:05:50 -0400
Received: from hera.cwi.nl ([192.16.191.8]:61860 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id S263169AbTDHJFt (for <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Apr 2003 05:05:49 -0400
From: Andries.Brouwer@cwi.nl
Date: Tue, 8 Apr 2003 11:17:24 +0200 (MEST)
Message-Id: <UTC200304080917.h389HOr02523.aeb@smtp.cwi.nl>
To: torvalds@transmeta.com
Subject: [PATCH] tty_io.c: make redirect static
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -u --recursive --new-file -X /linux/dontdiff a/drivers/char/tty_io.c b/drivers/char/tty_io.c
--- a/drivers/char/tty_io.c	Tue Apr  8 09:36:37 2003
+++ b/drivers/char/tty_io.c	Tue Apr  8 09:37:03 2003
@@ -136,7 +136,7 @@
  * redirect is the pseudo-tty that console output
  * is redirected to if asked by TIOCCONS.
  */
-struct tty_struct * redirect;
+static struct tty_struct *redirect;
 
 static void initialize_tty_struct(struct tty_struct *tty);
 
