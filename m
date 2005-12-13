Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932451AbVLMR6H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932451AbVLMR6H (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Dec 2005 12:58:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932460AbVLMR6G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Dec 2005 12:58:06 -0500
Received: from verein.lst.de ([213.95.11.210]:44755 "EHLO mail.lst.de")
	by vger.kernel.org with ESMTP id S932451AbVLMR6D (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Dec 2005 12:58:03 -0500
Date: Tue, 13 Dec 2005 18:56:36 +0100
From: Christoph Hellwig <hch@lst.de>
To: akpm@osdl.org, ericvh@gmail.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 2/6] 9p: remove superflous MS_NODIRATIME assignment
Message-ID: <20051213175636.GB17130@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Spam-Score: -4.901 () BAYES_00,UPPERCASE_25_50
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

MS_NOATIME implies MS_NODIRATIME


Signed-off-by: Christoph Hellwig <hch@lst.de>

Index: linux-2.6.15-rc5/fs/9p/vfs_super.c
===================================================================
--- linux-2.6.15-rc5.orig/fs/9p/vfs_super.c	2005-12-12 18:31:41.000000000 +0100
+++ linux-2.6.15-rc5/fs/9p/vfs_super.c	2005-12-12 22:40:45.000000000 +0100
@@ -92,7 +92,7 @@
 	sb->s_op = &v9fs_super_ops;
 
 	sb->s_flags = flags | MS_ACTIVE | MS_SYNCHRONOUS | MS_DIRSYNC |
-	    MS_NODIRATIME | MS_NOATIME;
+	    MS_NOATIME;
 }
 
 /**
