Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264288AbTEZGfv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 May 2003 02:35:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264301AbTEZGfv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 May 2003 02:35:51 -0400
Received: from dp.samba.org ([66.70.73.150]:63376 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S264288AbTEZGft (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 May 2003 02:35:49 -0400
From: Rusty Trivial Russell <rusty@rustcorp.com.au>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Subject: [TRIVIAL] const char* to char* update in console.h
Date: Mon, 26 May 2003 16:32:58 +1000
Message-Id: <20030526064900.F372D2C0B2@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From:  Amit Shah <shahamit@gmx.net>

  Hi all,
  
  (resending updated version for 2.5.69)
  
  The read function for consoles in include/linux/console.h contains const 
  char* for a pointer that it will actually modify. Although no one seems 
  to be using this as of now, it should be corrected.
  

--- trivial-2.5.69-bk18/include/linux/console.h.orig	2003-05-26 16:17:30.000000000 +1000
+++ trivial-2.5.69-bk18/include/linux/console.h	2003-05-26 16:17:30.000000000 +1000
@@ -96,7 +96,7 @@
 {
 	char	name[8];
 	void	(*write)(struct console *, const char *, unsigned);
-	int	(*read)(struct console *, const char *, unsigned);
+	int	(*read)(struct console *, char *, unsigned);
 	struct tty_driver *(*device)(struct console *, int *);
 	void	(*unblank)(void);
 	int	(*setup)(struct console *, char *);
-- 
  What is this? http://www.kernel.org/pub/linux/kernel/people/rusty/trivial/
  Don't blame me: the Monkey is driving
  File: Amit Shah <shahamit@gmx.net>: [PATCH][2.5] const char_ to char_ update in console.h
