Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269495AbUJSQp6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269495AbUJSQp6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Oct 2004 12:45:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269841AbUJSQof
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Oct 2004 12:44:35 -0400
Received: from mail.kroah.org ([69.55.234.183]:58564 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S269804AbUJSQiv convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Oct 2004 12:38:51 -0400
X-Donotread: and you are reading this why?
Subject: Re: [PATCH] Driver Core patches for 2.6.9
In-Reply-To: <10982038221929@kroah.com>
X-Patch: quite boring stuff, it's just source code...
Date: Tue, 19 Oct 2004 09:37:04 -0700
Message-Id: <10982038243480@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1992, 2004/09/29 16:28:06-07:00, hare@suse.de

[PATCH] Driver Core: Handle NULL arg for put_device()

Since get_device() accepts a NULL argument, put_device() should do so, too.

Signed-off-by: Hannes Reinecke <hare@suse.de>
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 drivers/base/core.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletion(-)


diff -Nru a/drivers/base/core.c b/drivers/base/core.c
--- a/drivers/base/core.c	2004-10-19 09:20:41 -07:00
+++ b/drivers/base/core.c	2004-10-19 09:20:41 -07:00
@@ -293,7 +293,8 @@
  */
 void put_device(struct device * dev)
 {
-	kobject_put(&dev->kobj);
+	if (dev)
+		kobject_put(&dev->kobj);
 }
 
 

