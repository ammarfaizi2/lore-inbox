Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265207AbUAYTZv (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jan 2004 14:25:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265209AbUAYTXi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jan 2004 14:23:38 -0500
Received: from [218.5.74.208] ([218.5.74.208]:63147 "EHLO vhost.bizcn.com")
	by vger.kernel.org with ESMTP id S265207AbUAYTXP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jan 2004 14:23:15 -0500
Message-ID: <401417A3.7000206@lovecn.org>
Date: Mon, 26 Jan 2004 03:23:15 +0800
From: Coywolf Qi Hunt <coywolf@lovecn.org>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.5) Gecko/20031007
X-Accept-Language: en-us, en, zh
MIME-Version: 1.0
To: tao@acc.umu.se, linux-kernel@vger.kernel.org
Subject: [PATCH 2.0.39] put_last_free() defined, but not used
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

In 2.0.39, the function put_last_free() in fs/file_table.c is defined, 
but no longer get used.
Should it be removed?

thanks


--- fs/file_table.c.orig    1994-10-21 07:39:36.000000000 +0800
+++ fs/file_table.c    2004-01-26 03:10:38.000000000 +0800
@@ -52,20 +52,6 @@
     prev->f_next = next;
 }
 
-/*
- * Insert a file structure at the end of the list of available ones.
- */
-static inline void put_last_free(struct file *file)
-{
-    struct file *next, *prev;
-
-    next = first_file;
-    file->f_next = next;
-    prev = next->f_prev;
-    next->f_prev = file;
-    file->f_prev = prev;
-    prev->f_next = file;
-}
 
 /*
  * Allocate a new memory page for file structures and

