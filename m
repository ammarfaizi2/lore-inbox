Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262618AbVCJBKo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262618AbVCJBKo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Mar 2005 20:10:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262641AbVCJBG4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Mar 2005 20:06:56 -0500
Received: from mail.kroah.org ([69.55.234.183]:46751 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262613AbVCJAmZ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Mar 2005 19:42:25 -0500
Cc: gregkh@suse.de
Subject: [PATCH] debufs: make built in types add a \n to their output
In-Reply-To: <20050310002444.GA32153@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Wed, 9 Mar 2005 16:26:22 -0800
Message-Id: <1110414382208@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.2033, 2005/03/09 15:24:07-08:00, gregkh@suse.de

[PATCH] debufs: make built in types add a \n to their output

Thanks to Alessandro Rubini <rubini@gnudd.com> for pointing this out.

Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>


 fs/debugfs/file.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)


diff -Nru a/fs/debugfs/file.c b/fs/debugfs/file.c
--- a/fs/debugfs/file.c	2005-03-09 16:23:09 -08:00
+++ b/fs/debugfs/file.c	2005-03-09 16:23:09 -08:00
@@ -52,7 +52,7 @@
 	char buf[32];								\
 	type *val = file->private_data;						\
 										\
-	snprintf(buf, sizeof(buf), format, *val);				\
+	snprintf(buf, sizeof(buf), format "\n", *val);				\
 	return simple_read_from_buffer(user_buf, count, ppos, buf, strlen(buf));\
 }										\
 static ssize_t write_file_##type(struct file *file, const char __user *user_buf,\

