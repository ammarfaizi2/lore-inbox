Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750864AbVKKQk6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750864AbVKKQk6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Nov 2005 11:40:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750865AbVKKQk6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Nov 2005 11:40:58 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:15378 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1750863AbVKKQk5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Nov 2005 11:40:57 -0500
Date: Fri, 11 Nov 2005 17:40:53 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>, Joel Becker <joel.becker@oracle.com>,
       Mark Fasheh <mark.fasheh@oracle.com>,
       Kurt Hackel <kurt.hackel@oracle.com>
Cc: linux-kernel@vger.kernel.org
Subject: [-mm patch] fs/ocfs2/file.c: make ocfs2_extend_allocation() static
Message-ID: <20051111164053.GM5376@stusta.de>
References: <20051110203544.027e992c.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051110203544.027e992c.akpm@osdl.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 10, 2005 at 08:35:44PM -0800, Andrew Morton wrote:
>...
> Changes since 2.6.14-mm1:
>...
>  git-ocfs2.patch
>...
>  Subsystem trees
>...


<--  snip  -->


This patch makes the needlessly  global function 
ocfs2_extend_allocation() static.


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.14-mm2-full/fs/ocfs2/file.c.old	2005-11-11 16:55:01.000000000 +0100
+++ linux-2.6.14-mm2-full/fs/ocfs2/file.c	2005-11-11 16:55:19.000000000 +0100
@@ -413,8 +413,8 @@
 	return status;
 }
 
-int ocfs2_extend_allocation(struct inode *inode,
-			    u32 clusters_to_add)
+static int ocfs2_extend_allocation(struct inode *inode,
+				   u32 clusters_to_add)
 {
 	int status = 0;
 	int restart_func = 0;

