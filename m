Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263126AbUDOSJM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Apr 2004 14:09:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264352AbUDORrG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Apr 2004 13:47:06 -0400
Received: from mail.kroah.org ([65.200.24.183]:23478 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S263117AbUDORmJ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Apr 2004 13:42:09 -0400
X-Donotread: and you are reading this why?
Subject: Re: [PATCH] Driver Core update for 2.6.6-rc1
In-Reply-To: <10820509131756@kroah.com>
X-Patch: quite boring stuff, it's just source code...
Date: Thu, 15 Apr 2004 10:41:53 -0700
Message-Id: <10820509131538@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1643.36.16, 2004/04/09 11:50:55-07:00, hannal@us.ibm.com

[PATCH] Fix for patch to add class support to stallion.c

Oops. Realized I had a / in the file name in this patch too.

Please apply to correct it:


 drivers/char/stallion.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)


diff -Nru a/drivers/char/stallion.c b/drivers/char/stallion.c
--- a/drivers/char/stallion.c	Thu Apr 15 10:20:17 2004
+++ b/drivers/char/stallion.c	Thu Apr 15 10:20:17 2004
@@ -3192,7 +3192,7 @@
 		devfs_mk_cdev(MKDEV(STL_SIOMEMMAJOR, i),
 				S_IFCHR|S_IRUSR|S_IWUSR,
 				"staliomem/%d", i);
-		class_simple_device_add(stallion_class, MKDEV(STL_SIOMEMMAJOR, i), NULL, "staliomem/%d", i);
+		class_simple_device_add(stallion_class, MKDEV(STL_SIOMEMMAJOR, i), NULL, "staliomem%d", i);
 	}
 
 	stl_serial->owner = THIS_MODULE;

