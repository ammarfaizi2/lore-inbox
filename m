Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268964AbUIXR2n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268964AbUIXR2n (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Sep 2004 13:28:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268881AbUIXR2m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Sep 2004 13:28:42 -0400
Received: from moutng.kundenserver.de ([212.227.126.191]:58332 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S268959AbUIXR1y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Sep 2004 13:27:54 -0400
From: Christian Borntraeger <linux-kernel@borntraeger.net>
To: Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org
Subject: [trivial PATCH] correct the comment of the panic function. There is no cache flush
Date: Fri, 24 Sep 2004 19:27:45 +0200
User-Agent: KMail/1.7
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200409241927.45341.linux-kernel@borntraeger.net>
X-Provags-ID: kundenserver.de abuse@kundenserver.de auth:5a8b66f42810086ecd21595c2d6103b9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

this patch fixes the comment of the panic function. After my last patch panic
no longer calls sync to prevent panic from failing on SMP systems. 


cheers

Christian

--- 1.16/kernel/panic.c 2004-08-23 10:14:57 +02:00
+++ edited/kernel/panic.c 2004-09-24 19:22:14 +02:00
@@ -42,7 +42,7 @@
  * @fmt: The text string to print
  *
  * Display a message, then perform cleanups. Functions in the panic
- * notifier list are called after the filesystem cache is flushed (when possible).
+ * notifier list are called without flushing the filesystem cache.
  *
  * This function never returns.
  */


