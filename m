Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264090AbTEWPxV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 May 2003 11:53:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264094AbTEWPxV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 May 2003 11:53:21 -0400
Received: from smtp5.wanadoo.fr ([193.252.22.27]:52903 "EHLO
	mwinf0404.wanadoo.fr") by vger.kernel.org with ESMTP
	id S264090AbTEWPxT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 May 2003 11:53:19 -0400
From: Duncan Sands <baldrick@wanadoo.fr>
To: linux-usb-devel@lists.sourceforge.net
Subject: [2.5 PATCH] USB speedtouch: set owner fields
Date: Fri, 23 May 2003 18:06:23 +0200
User-Agent: KMail/1.5.1
Cc: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200305231806.23752.baldrick@wanadoo.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I think I'd better work on my plausible deniability...

 speedtch.c |    2 ++
 1 files changed, 2 insertions(+)


diff -Nru a/drivers/usb/misc/speedtch.c b/drivers/usb/misc/speedtch.c
--- a/drivers/usb/misc/speedtch.c	Fri May 23 18:04:51 2003
+++ b/drivers/usb/misc/speedtch.c	Fri May 23 18:04:51 2003
@@ -238,6 +238,7 @@
 	.ioctl =	udsl_atm_ioctl,
 	.send =		udsl_atm_send,
 	.proc_read =	udsl_atm_proc_read,
+	.owner =	THIS_MODULE,
 };
 
 /* USB */
@@ -247,6 +248,7 @@
 static int udsl_usb_ioctl (struct usb_interface *intf, unsigned int code, void *user_data);
 
 static struct usb_driver udsl_usb_driver = {
+	.owner =	THIS_MODULE,
 	.name =		udsl_driver_name,
 	.probe =	udsl_usb_probe,
 	.disconnect =	udsl_usb_disconnect,

