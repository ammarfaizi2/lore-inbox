Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750860AbVHXLRn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750860AbVHXLRn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Aug 2005 07:17:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750870AbVHXLRm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Aug 2005 07:17:42 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:32273 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1750869AbVHXLRm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Aug 2005 07:17:42 -0400
Date: Wed, 24 Aug 2005 13:17:40 +0200
From: Adrian Bunk <bunk@stusta.de>
To: linux-kernel@vger.kernel.org
Subject: [2.6 patch] fs/cramfs/uncompress.c should #include <linux/cramfs_fs.h>
Message-ID: <20050824111740.GN5603@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Every file should #include the header with the prototypes of the global 
functions it is offering.


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.13-rc6-mm1-full/fs/cramfs/uncompress.c.old	2005-08-23 01:56:47.000000000 +0200
+++ linux-2.6.13-rc6-mm1-full/fs/cramfs/uncompress.c	2005-08-23 01:57:09.000000000 +0200
@@ -19,6 +19,7 @@
 #include <linux/errno.h>
 #include <linux/vmalloc.h>
 #include <linux/zlib.h>
+#include <linux/cramfs_fs.h>
 
 static z_stream stream;
 static int initialized;

