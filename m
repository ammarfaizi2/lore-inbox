Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262507AbTDANAZ>; Tue, 1 Apr 2003 08:00:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262508AbTDANAZ>; Tue, 1 Apr 2003 08:00:25 -0500
Received: from [203.199.140.162] ([203.199.140.162]:64013 "EHLO
	calvin.codito.co.in") by vger.kernel.org with ESMTP
	id <S262507AbTDANAY>; Tue, 1 Apr 2003 08:00:24 -0500
From: Amit Shah <shahamit@gmx.net>
To: linux-kernel@vger.kernel.org
Subject: [PATCH][2.4] const char* to char* conversion in console.h
Date: Tue, 1 Apr 2003 18:41:19 +0530
User-Agent: KMail/1.5.1
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200304011841.19404.shahamit@gmx.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The read function for consoles in include/linux/console.h contains const 
char* for a pointer that it will actually modify. Although no one seems 
to be using this as of now, it should be corrected.

--- include/linux/console.h.orig        Tue Apr  1 18:39:34 2003
+++ include/linux/console.h     Tue Apr  1 18:40:05 2003
@@ -95,7 +95,7 @@
 {
        char    name[8];
        void    (*write)(struct console *, const char *, unsigned);
-       int     (*read)(struct console *, const char *, unsigned);
+       int     (*read)(struct console *, char *, unsigned);
        kdev_t  (*device)(struct console *);
        void    (*unblank)(void);
        int     (*setup)(struct console *, char *);

Amit.
-- 
Amit Shah
http://amitshah.nav.to/

A: No.
Q: Should I include quotations after my reply?

