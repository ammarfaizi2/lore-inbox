Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265672AbTGDCPU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Jul 2003 22:15:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265653AbTGDB5E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Jul 2003 21:57:04 -0400
Received: from granite.he.net ([216.218.226.66]:26894 "EHLO granite.he.net")
	by vger.kernel.org with ESMTP id S265665AbTGDByz convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Jul 2003 21:54:55 -0400
Content-Type: text/plain; charset=US-ASCII
Message-Id: <10572845533715@kroah.com>
Subject: Re: [PATCH] PCI and sysfs fixes for 2.5.74
In-Reply-To: <1057284553312@kroah.com>
From: Greg KH <greg@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Thu, 3 Jul 2003 19:09:14 -0700
Content-Transfer-Encoding: 7BIT
To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1370, 2003/07/03 15:52:29-07:00, willy@debian.org

[PATCH] Driver Core: fix firmware binary files
Fixes the sysfs binary file bug.


 drivers/base/firmware_class.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)


diff -Nru a/drivers/base/firmware_class.c b/drivers/base/firmware_class.c
--- a/drivers/base/firmware_class.c	Thu Jul  3 18:16:20 2003
+++ b/drivers/base/firmware_class.c	Thu Jul  3 18:16:20 2003
@@ -149,7 +149,7 @@
 	if (offset + count > fw->size)
 		count = fw->size - offset;
 
-	memcpy(buffer, fw->data + offset, count);
+	memcpy(buffer + offset, fw->data + offset, count);
 	return count;
 }
 static int
@@ -198,7 +198,7 @@
 	if (retval)
 		return retval;
 
-	memcpy(fw->data + offset, buffer, count);
+	memcpy(fw->data + offset, buffer + offset, count);
 
 	fw->size = max_t(size_t, offset + count, fw->size);
 

