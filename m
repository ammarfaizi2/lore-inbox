Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262599AbUKBCT6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262599AbUKBCT6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Nov 2004 21:19:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266548AbUKAXT1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Nov 2004 18:19:27 -0500
Received: from mail.kroah.org ([69.55.234.183]:11428 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S284917AbUKAV7Z convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Nov 2004 16:59:25 -0500
X-Donotread: and you are reading this why?
Subject: Re: [PATCH] Driver Core patches for 2.6.10-rc1
In-Reply-To: <10993462752326@kroah.com>
X-Patch: quite boring stuff, it's just source code...
Date: Mon, 1 Nov 2004 13:57:55 -0800
Message-Id: <10993462752309@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.2440, 2004/11/01 13:02:55-08:00, akpm@osdl.org

[PATCH] fix oops with firmware loading

From: Maneesh Soni <maneesh@in.ibm.com>

My fault, a bad typo in fs/sysfs/bin.c.

Signed-off-by: Andrew Morton <akpm@osdl.org>
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 fs/sysfs/bin.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)


diff -Nru a/fs/sysfs/bin.c b/fs/sysfs/bin.c
--- a/fs/sysfs/bin.c	2004-11-01 13:37:25 -08:00
+++ b/fs/sysfs/bin.c	2004-11-01 13:37:25 -08:00
@@ -60,8 +60,8 @@
 static int
 flush_write(struct dentry *dentry, char *buffer, loff_t offset, size_t count)
 {
-	struct bin_attribute *attr = to_bin_attr(dentry->d_parent);
-	struct kobject *kobj = to_kobj(dentry);
+	struct bin_attribute *attr = to_bin_attr(dentry);
+	struct kobject *kobj = to_kobj(dentry->d_parent);
 
 	return attr->write(kobj, buffer, offset, count);
 }

