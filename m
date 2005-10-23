Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750778AbVJWRus@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750778AbVJWRus (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Oct 2005 13:50:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750783AbVJWRus
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Oct 2005 13:50:48 -0400
Received: from wproxy.gmail.com ([64.233.184.199]:29328 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750778AbVJWRur (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Oct 2005 13:50:47 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:mime-version:content-type:content-disposition:user-agent;
        b=EScq52oMmLPnywoWhJQGhFx+ZJ6LrKN4s053PyXm79wII3NiSbXUP3Unof/G68ZBcRSkwYqLkWcysBXKl7h7lJ8cnOStxuWOAgwBPN2Z3+0aCGFqSJggcuDjt7P2SPdGry16rQt7ZANf7dK9iD7jL/XR7FCdQkwmTHpN/O7/F8I=
Date: Sun, 23 Oct 2005 22:03:03 +0400
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] fs/attr.c: remove BUG()
Message-ID: <20051023180303.GA13144@mipter.zuzino.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 fs/attr.c |    3 ---
 1 file changed, 3 deletions(-)

--- a/fs/attr.c
+++ b/fs/attr.c
@@ -117,9 +117,6 @@ int notify_change(struct dentry * dentry
 	struct timespec now;
 	unsigned int ia_valid = attr->ia_valid;
 
-	if (!inode)
-		BUG();
-
 	mode = inode->i_mode;
 	now = current_fs_time(inode->i_sb);
 

