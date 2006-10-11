Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030681AbWJKQZr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030681AbWJKQZr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Oct 2006 12:25:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030680AbWJKQZr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Oct 2006 12:25:47 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:57276 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1030681AbWJKQZq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Oct 2006 12:25:46 -0400
Date: Wed, 11 Oct 2006 17:25:45 +0100
From: Al Viro <viro@ftp.linux.org.uk>
To: torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] misuse of strstr
Message-ID: <20061011162545.GC29920@ftp.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/gfs2/locking/dlm/mount.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/fs/gfs2/locking/dlm/mount.c b/fs/gfs2/locking/dlm/mount.c
index 1f94dd3..cdd1694 100644
--- a/fs/gfs2/locking/dlm/mount.c
+++ b/fs/gfs2/locking/dlm/mount.c
@@ -45,7 +45,7 @@ static struct gdlm_ls *init_gdlm(lm_call
 	strncpy(buf, table_name, 256);
 	buf[255] = '\0';
 
-	p = strstr(buf, ":");
+	p = strchr(buf, ':');
 	if (!p) {
 		log_info("invalid table_name \"%s\"", table_name);
 		kfree(ls);
-- 
1.4.2.GIT

