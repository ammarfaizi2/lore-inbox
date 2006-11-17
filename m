Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1756048AbWKQX6n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756048AbWKQX6n (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Nov 2006 18:58:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756047AbWKQX6m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Nov 2006 18:58:42 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:36102 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1756046AbWKQX63 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Nov 2006 18:58:29 -0500
Date: Sat, 18 Nov 2006 00:58:27 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andreas Gruenbacher <agruen@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] make mm/shmem.c:shmem_xattr_security_handler static
Message-ID: <20061117235827.GN31879@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch makes the needlessly global struct 
shmem_xattr_security_handler static.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.19-rc5-mm2/mm/shmem.c.old	2006-11-17 18:50:05.000000000 +0100
+++ linux-2.6.19-rc5-mm2/mm/shmem.c	2006-11-17 18:50:13.000000000 +0100
@@ -1943,7 +1943,7 @@
 	return security_inode_setsecurity(inode, name, value, size, flags);
 }
 
-struct xattr_handler shmem_xattr_security_handler = {
+static struct xattr_handler shmem_xattr_security_handler = {
 	.prefix = XATTR_SECURITY_PREFIX,
 	.list   = shmem_xattr_security_list,
 	.get    = shmem_xattr_security_get,

