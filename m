Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262931AbTDRHuK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Apr 2003 03:50:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262934AbTDRHuK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Apr 2003 03:50:10 -0400
Received: from dp.samba.org ([66.70.73.150]:36575 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S262931AbTDRHuI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Apr 2003 03:50:08 -0400
From: Rusty Trivial Russell <rusty@rustcorp.com.au>
To: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: [TRIVIAL] const char* to char* update in console.h
Date: Fri, 18 Apr 2003 17:46:46 +1000
Message-Id: <20030418080205.17A3D2C110@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[ Not sure who is responsible for this, but seems correct -- RR]

From:  Amit Shah <amitshah@gmx.net>

  The read function for consoles in include/linux/console.h contains const 
  char* for a pointer that it will actually modify. Although no one seems 
  to be using this as of now, it should be corrected.
  

--- trivial-2.5.67-bk8/include/linux/console.h.orig	2003-04-18 17:43:45.000000000 +1000
+++ trivial-2.5.67-bk8/include/linux/console.h	2003-04-18 17:43:45.000000000 +1000
@@ -96,7 +96,7 @@
 {
 	char	name[8];
 	void	(*write)(struct console *, const char *, unsigned);
-	int	(*read)(struct console *, const char *, unsigned);
+       int     (*read)(struct console *, char *, unsigned);
 	kdev_t	(*device)(struct console *);
 	void	(*unblank)(void);
 	int	(*setup)(struct console *, char *);
-- 
  Don't blame me: the Monkey is driving
  File: Amit Shah <amitshah@gmx.net>: [TRIVIAL] [PATCH][2.5] const char_ to char_ update in console.h
