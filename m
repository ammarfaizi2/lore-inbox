Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262099AbULLUCR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262099AbULLUCR (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Dec 2004 15:02:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262105AbULLUB6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Dec 2004 15:01:58 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:27666 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S262099AbULLT6v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Dec 2004 14:58:51 -0500
Date: Sun, 12 Dec 2004 20:58:37 +0100
From: Adrian Bunk <bunk@stusta.de>
To: linux-kernel@vger.kernel.org
Subject: [2.6 patch] mm/shmem.c: make a struct static
Message-ID: <20041212195837.GN22324@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch below makes a needlessly global struct static.


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.10-rc2-mm4-full/mm/shmem.c.old	2004-12-12 03:53:52.000000000 +0100
+++ linux-2.6.10-rc2-mm4-full/mm/shmem.c	2004-12-12 03:54:00.000000000 +0100
@@ -2163,7 +2163,7 @@
 	return security_inode_setsecurity(inode, name, value, size, flags);
 }
 
-struct xattr_handler shmem_xattr_security_handler = {
+static struct xattr_handler shmem_xattr_security_handler = {
 	.prefix	= XATTR_SECURITY_PREFIX,
 	.list	= shmem_xattr_security_list,
 	.get	= shmem_xattr_security_get,

