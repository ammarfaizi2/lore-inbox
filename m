Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264337AbUENXSN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264337AbUENXSN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 May 2004 19:18:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264560AbUENXQj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 May 2004 19:16:39 -0400
Received: from mail.kroah.org ([65.200.24.183]:60636 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S264337AbUENXIS convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 May 2004 19:08:18 -0400
X-Donotread: and you are reading this why?
Subject: Re: [PATCH] Driver Core patches for 2.6.6
In-Reply-To: <10845760434173@kroah.com>
X-Patch: quite boring stuff, it's just source code...
Date: Fri, 14 May 2004 16:07:23 -0700
Message-Id: <10845760433419@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1587.5.26, 2004/05/11 16:35:42-07:00, James.Bottomley@steeleye.com

[PATCH] fix dev_printk to work even in the absence of an attached driver


 include/linux/device.h |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)


diff -Nru a/include/linux/device.h b/include/linux/device.h
--- a/include/linux/device.h	Fri May 14 15:56:26 2004
+++ b/include/linux/device.h	Fri May 14 15:56:26 2004
@@ -400,7 +400,7 @@
 
 /* debugging and troubleshooting/diagnostic helpers. */
 #define dev_printk(level, dev, format, arg...)	\
-	printk(level "%s %s: " format , (dev)->driver->name , (dev)->bus_id , ## arg)
+	printk(level "%s %s: " format , (dev)->driver ? (dev)->driver->name : "" , (dev)->bus_id , ## arg)
 
 #ifdef DEBUG
 #define dev_dbg(dev, format, arg...)		\

