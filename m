Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319033AbSIDDdk>; Tue, 3 Sep 2002 23:33:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319034AbSIDDdk>; Tue, 3 Sep 2002 23:33:40 -0400
Received: from oumail.zero.ou.edu ([129.15.0.75]:2783 "EHLO r2d2")
	by vger.kernel.org with ESMTP id <S319033AbSIDDdj>;
	Tue, 3 Sep 2002 23:33:39 -0400
Date: Tue, 03 Sep 2002 22:22:45 -0500
From: Steve Kenton <skenton@ou.edu>
Subject: [PATCH] redundant stddef.h in wait.h
To: lkml <linux-kernel@vger.kernel.org>, skenton@ou.edu
Message-id: <3D757C84.C8B26470@ou.edu>
MIME-version: 1.0
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.7-10 i586)
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7BIT
X-Accept-Language: en
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In 2.5.32, include/linux/wait.h includes both kernel.h and stddef.h, but
kernel.h already includes stddef.h.  So, should we just delete the
redundant include of stddef.h?  There are others.  If this is OK, I will
sent it and it's kin to trivial.

Patch below for perusal and comments

Steve Kenton

--- include/linux/wait.h.orig Tue Sep  3 21:35:51 2002
+++ include/linux/wait.h Tue Sep  3 21:36:00 2002
@@ -12,7 +12,6 @@

 #include <linux/kernel.h>
 #include <linux/list.h>
-#include <linux/stddef.h>
 #include <linux/spinlock.h>
 #include <linux/config.h>



