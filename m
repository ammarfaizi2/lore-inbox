Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964830AbVINSJE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964830AbVINSJE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Sep 2005 14:09:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932575AbVINSJE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Sep 2005 14:09:04 -0400
Received: from zproxy.gmail.com ([64.233.162.200]:25647 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932564AbVINSJC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Sep 2005 14:09:02 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:mime-version:content-type:content-disposition:user-agent;
        b=ARtesNf7iypFYLKe6ofpJIwze6No1tsDvL77IAubhO0YntvmgVTRM/Ea8D4mErlWZGOmUqcC6loISRRHFTObjS/waAB9vzBTrBu3tL/1e/tMb3ryrbMDvxllYAF4le64rjx1DSLk7RtXl5HaCnb6t0D6xNChOFWDlhXRo6VmdBA=
Date: Wed, 14 Sep 2005 22:19:00 +0400
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Clemens Buchacher <drizzd@aon.at>, linux-kernel@vger.kernel.org
Subject: [PATCH] oss: don't concatenate __FUNCTION__ with strings
Message-ID: <20050914181900.GB19491@mipter.zuzino.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Clemens Buchacher <drizzd@aon.at>

It's deprecated. Use "%s", __FUNCTION__ instead.

Signed-off-by: Clemens Buchacher <drizzd@aon.at>
Signed-off-by: Maximilian Attems <janitor@sternwelten.at>
Signed-off-by: Domen Puncer <domen@coderock.org>
Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 sound/oss/au1000.c  |    2 +-
 sound/oss/ite8172.c |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

--- a/sound/oss/au1000.c
+++ b/sound/oss/au1000.c
@@ -1295,7 +1295,7 @@ static int au1000_mmap(struct file *file
 	unsigned long   size;
 	int ret = 0;
 
-	dbg(__FUNCTION__);
+	dbg("%s", __FUNCTION__);
     
 	lock_kernel();
 	down(&s->sem);
--- a/sound/oss/ite8172.c
+++ b/sound/oss/ite8172.c
@@ -1859,7 +1859,7 @@ static int it8172_release(struct inode *
 	struct it8172_state *s = (struct it8172_state *)file->private_data;
 
 #ifdef IT8172_VERBOSE_DEBUG
-	dbg(__FUNCTION__);
+	dbg("%s", __FUNCTION__);
 #endif
 	lock_kernel();
 	if (file->f_mode & FMODE_WRITE)

