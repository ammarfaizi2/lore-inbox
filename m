Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262173AbVBQAuv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262173AbVBQAuv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Feb 2005 19:50:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262174AbVBQAuv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Feb 2005 19:50:51 -0500
Received: from fire.osdl.org ([65.172.181.4]:35226 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262173AbVBQAul (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Feb 2005 19:50:41 -0500
Date: Wed, 16 Feb 2005 16:50:31 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: viro <viro@parcelfarce.linux.theplanet.co.uk>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: [PATCH] procfs: use C99 struct inits
Message-Id: <20050216165031.25880e41.rddunlap@osdl.org>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Al,
Please add this to your patch queue if you don't already have it.


Use C99 struct inits as requested by sparse:
fs/proc/base.c:738:2: warning: obsolete struct initializer, use C99 syntax
fs/proc/base.c:739:2: warning: obsolete struct initializer, use C99 syntax

Signed-off-by: Randy Dunlap <rddunlap@osdl.org>

diffstat:=
 fs/proc/base.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff -Naurp ./fs/proc/base.c~proc_c99_inits ./fs/proc/base.c
--- ./fs/proc/base.c~proc_c99_inits	2005-02-15 13:48:46.310312808 -0800
+++ ./fs/proc/base.c	2005-02-15 20:34:41.335786152 -0800
@@ -735,8 +735,8 @@ static ssize_t oom_adjust_write(struct f
 }
 
 static struct file_operations proc_oom_adjust_operations = {
-	read:		oom_adjust_read,
-	write:		oom_adjust_write,
+	.read		= oom_adjust_read,
+	.write		= oom_adjust_write,
 };
 
 static struct inode_operations proc_mem_inode_operations = {


---
