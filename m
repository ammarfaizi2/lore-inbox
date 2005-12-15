Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422660AbVLOJYV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422660AbVLOJYV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Dec 2005 04:24:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422637AbVLOJYT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Dec 2005 04:24:19 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:15018 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1422647AbVLOJSP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Dec 2005 04:18:15 -0500
To: torvalds@osdl.org
Subject: [PATCH] arcfb __user annotations
Cc: linux-kernel@vger.kernel.org
Message-Id: <E1EmpFf-0007zf-1H@ZenIV.linux.org.uk>
From: Al Viro <viro@ftp.linux.org.uk>
Date: Thu, 15 Dec 2005 09:18:15 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>


---

 drivers/video/arcfb.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

b636580a10697a261fb1c575b75f57078aa9a29f
diff --git a/drivers/video/arcfb.c b/drivers/video/arcfb.c
index 080db81..2784f0a 100644
--- a/drivers/video/arcfb.c
+++ b/drivers/video/arcfb.c
@@ -441,7 +441,7 @@ static int arcfb_ioctl(struct inode *ino
  * the fb. it's inefficient for them to do anything less than 64*8
  * writes since we update the lcd in each write() anyway.
  */
-static ssize_t arcfb_write(struct file *file, const char *buf, size_t count,
+static ssize_t arcfb_write(struct file *file, const char __user *buf, size_t count,
 				loff_t *ppos)
 {
 	/* modded from epson 1355 */
-- 
0.99.9.GIT

