Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265063AbUFVSHO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265063AbUFVSHO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jun 2004 14:07:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265065AbUFVSGk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jun 2004 14:06:40 -0400
Received: from mail.kroah.org ([65.200.24.183]:37813 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S265056AbUFVRnW convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Jun 2004 13:43:22 -0400
X-Donotread: and you are reading this why?
Subject: Re: [PATCH] Driver Core patches for 2.6.7
In-Reply-To: <10879261083581@kroah.com>
X-Patch: quite boring stuff, it's just source code...
Date: Tue, 22 Jun 2004 10:41:48 -0700
Message-Id: <10879261083437@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1722.85.2, 2004/06/03 08:44:34-07:00, mochel@digitalimplant.org

[Driver Model] Fix up silly scsi usage of DEVICE_ATTR() macros. 

- Hey, just because the macro incorrectly included a ';' doesn't mean
  one shouldn't add one on their own.. (Or at least be consistent.)

Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 drivers/scsi/scsi_sysfs.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)


diff -Nru a/drivers/scsi/scsi_sysfs.c b/drivers/scsi/scsi_sysfs.c
--- a/drivers/scsi/scsi_sysfs.c	Tue Jun 22 09:49:15 2004
+++ b/drivers/scsi/scsi_sysfs.c	Tue Jun 22 09:49:15 2004
@@ -320,7 +320,7 @@
 	sdev->timeout = timeout * HZ;
 	return count;
 }
-static DEVICE_ATTR(timeout, S_IRUGO | S_IWUSR, sdev_show_timeout, sdev_store_timeout)
+static DEVICE_ATTR(timeout, S_IRUGO | S_IWUSR, sdev_show_timeout, sdev_store_timeout);
 
 static ssize_t
 store_rescan_field (struct device *dev, const char *buf, size_t count) 
@@ -328,7 +328,7 @@
 	scsi_rescan_device(dev);
 	return count;
 }
-static DEVICE_ATTR(rescan, S_IWUSR, NULL, store_rescan_field)
+static DEVICE_ATTR(rescan, S_IWUSR, NULL, store_rescan_field);
 
 static ssize_t sdev_store_delete(struct device *dev, const char *buf,
 				 size_t count)

