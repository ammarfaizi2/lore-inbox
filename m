Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262502AbTDAM60>; Tue, 1 Apr 2003 07:58:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262505AbTDAM60>; Tue, 1 Apr 2003 07:58:26 -0500
Received: from [203.199.140.162] ([203.199.140.162]:62733 "EHLO
	calvin.codito.co.in") by vger.kernel.org with ESMTP
	id <S262502AbTDAM6Z>; Tue, 1 Apr 2003 07:58:25 -0500
From: Amit Shah <shahamit@gmx.net>
To: linux-kernel@vger.kernel.org
Subject: [PATCH][2.5] const char* to char* conversion in console.h
Date: Tue, 1 Apr 2003 18:39:17 +0530
User-Agent: KMail/1.5.1
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200304011839.17826.shahamit@gmx.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The read function for consoles in include/linux/console.h contains const 
char* for a pointer that it will actually modify. Although no one seems 
to be using this as of now, it should be corrected.

--- include/linux/console.h.orig        Tue Apr  1 18:32:24 2003
+++ include/linux/console.h     Tue Apr  1 18:32:46 2003
@@ -96,7 +96,7 @@
 {
        char    name[8];
        void    (*write)(struct console *, const char *, unsigned);
-       int     (*read)(struct console *, const char *, unsigned);
+       int     (*read)(struct console *, char *, unsigned);
        kdev_t  (*device)(struct console *);
        void    (*unblank)(void);
        int     (*setup)(struct console *, char *);

-- 
Amit Shah
http://amitshah.nav.to/

A: No.
Q: Should I include quotations after my reply?

