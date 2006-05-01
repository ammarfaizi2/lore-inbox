Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932261AbWEAVCK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932261AbWEAVCK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 May 2006 17:02:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932260AbWEAVCK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 May 2006 17:02:10 -0400
Received: from mail.fuug.fi ([83.145.198.117]:9425 "EHLO mail.fuug.fi")
	by vger.kernel.org with ESMTP id S932259AbWEAVCI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 May 2006 17:02:08 -0400
Date: Tue, 2 May 2006 00:01:51 +0300 (EEST)
From: "Petri T. Koistinen" <petri.koistinen@iki.fi>
To: Davide Libenzi <davidel@xmailserver.org>, Andrew Morton <akpm@osdl.org>
cc: trivial@kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] fs/eventpoll.c: initialize variable, remove warning
Message-ID: <Pine.LNX.4.64.0605020000050.5245@joo>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Petri T. Koistinen <petri.koistinen@iki.fi>

Remove compiler warning by initializing uninitialized variable.

Signed-off-by: Petri T. Koistinen <petri.koistinen@iki.fi>
---
 fs/eventpoll.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)
---
diff --git a/fs/eventpoll.c b/fs/eventpoll.c
index 1b4491c..243c254 100644
--- a/fs/eventpoll.c
+++ b/fs/eventpoll.c
@@ -497,7 +497,7 @@ void eventpoll_release_file(struct file
  */
 asmlinkage long sys_epoll_create(int size)
 {
-	int error, fd;
+	int error, fd = 0;
 	struct eventpoll *ep;
 	struct inode *inode;
 	struct file *file;


