Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262329AbVAUKLJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262329AbVAUKLJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Jan 2005 05:11:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262322AbVAUKJq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Jan 2005 05:09:46 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:5904 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S262324AbVAUKID (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Jan 2005 05:08:03 -0500
Date: Fri, 21 Jan 2005 11:08:01 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] mm/shmem.c: make a struct static
Message-ID: <20050121100801.GE3209@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch makes a needlessly global struct static.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

This patch was already sent on:
- 12 Dec 2004

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

