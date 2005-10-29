Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751419AbVJ2GHB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751419AbVJ2GHB (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Oct 2005 02:07:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751420AbVJ2GHA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Oct 2005 02:07:00 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:12712 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1751419AbVJ2GHA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Oct 2005 02:07:00 -0400
Date: Sat, 29 Oct 2005 07:06:59 +0100
From: Al Viro <viro@ftp.linux.org.uk>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Greg Kroah-Hartman <gregkh@suse.de>, linux-kernel@vger.kernel.org
Subject: [PATCH] arguments out of order in class_device_create() call (s390)
Message-ID: <20051029060659.GC7992@ftp.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
----
diff -urN RC14-base/drivers/s390/char/vmlogrdr.c current/drivers/s390/char/vmlogrdr.c
--- RC14-base/drivers/s390/char/vmlogrdr.c	2005-10-28 22:35:58.000000000 -0400
+++ current/drivers/s390/char/vmlogrdr.c	2005-10-29 01:59:36.000000000 -0400
@@ -787,8 +787,8 @@
 		return ret;
 	}
 	priv->class_device = class_device_create(
-				NULL,
 				vmlogrdr_class,
+				NULL,
 				MKDEV(vmlogrdr_major, priv->minor_num),
 				dev,
 				"%s", dev->bus_id );
