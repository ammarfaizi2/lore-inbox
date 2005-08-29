Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751313AbVH2VYh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751313AbVH2VYh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Aug 2005 17:24:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751306AbVH2VYh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Aug 2005 17:24:37 -0400
Received: from rproxy.gmail.com ([64.233.170.205]:45953 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751322AbVH2VYR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Aug 2005 17:24:17 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=t+qrdokrwSbeM5QOwFh0hX9JBTZHKPeWmC1pYHhzX9ufTq4jAWwWJ/hWyt6AZfoa2Dx1gnDb7DM3OHoKZPHQp4r9QBUtK3e9KrUyOrm7VoPBR83hk1KDDb9DSCeMN5KiIqFyOp8RI++Md9nVXe5w+uKng6WNk7WJEY8Jb2w8J2Q=
From: Jesper Juhl <jesper.juhl@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Subject: [PATCH 3/3] remove verify_area() - remove fs/umsdos/notes as it only contain a verify_area related note
Date: Mon, 29 Aug 2005 23:25:20 +0200
User-Agent: KMail/1.8.2
Cc: "linux-kernel" <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200508292325.20368.jesper.juhl@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The file `fs/umsdos/notes' contains only a small note about a possible bug
involving verify_area(). Since umsdos is no longer in the kernel and 
verify_area() is also gone, it seems to make sense that this file goes the 
way of the Dodo.
After applying this patch the `fs/umsdos/' directory will be empty and can
be removed entirely.

Signed-off-by: Jesper Juhl <jesper.juhl@gmail.com>
---

 fs/umsdos/notes |   17 -----------------
 1 files changed, 17 deletions(-)

--- linux-2.6.13-orig/fs/umsdos/notes	2005-08-29 01:41:01.000000000 +0200
+++ /dev/null	2005-08-29 03:16:53.000000000 +0200
@@ -1,17 +0,0 @@
-This file contain idea and things I don't want to forget
-
-Possible bug in fs/read_write.c
-Function sys_readdir()
-
-	There is a call the verify_area that does not take in account
-	the count parameter. I guess it should read
-
-	error = verify_area(VERIFY_WRITE, dirent, count*sizeof (*dirent));
-
-	instead of
-
-	error = verify_area(VERIFY_WRITE, dirent, sizeof (*dirent));
-
-	Of course, now , count is always 1
-
-



