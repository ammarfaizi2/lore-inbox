Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263500AbTHVSQl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Aug 2003 14:16:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263486AbTHVSQk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Aug 2003 14:16:40 -0400
Received: from mail.kroah.org ([65.200.24.183]:30859 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S263703AbTHVSQ0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Aug 2003 14:16:26 -0400
Date: Fri, 22 Aug 2003 11:16:31 -0700
From: Greg KH <greg@kroah.com>
To: kraxel@bytesex.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] v4l: add video_device_remove_file() for 2.6.0-test3-bk
Message-ID: <20030822181631.GA9901@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ah, and here's a patch to add video_device_remove_file() to match the
video_device_create_file() function.  It's nice to be complete :)

Mind if I send this on too?

thanks,

greg k-h


# V4L: add video_device_remove_file() to match video_device_create_file()

diff -Nru a/include/linux/videodev.h b/include/linux/videodev.h
--- a/include/linux/videodev.h	Fri Aug 22 11:14:15 2003
+++ b/include/linux/videodev.h	Fri Aug 22 11:14:15 2003
@@ -63,6 +63,12 @@
 {
 	class_device_create_file(&vfd->class_dev, attr);
 }
+static inline void
+video_device_remove_file(struct video_device *vfd,
+			 struct class_device_attribute *attr)
+{
+	class_device_remove_file(&vfd->class_dev, attr);
+}
 
 /* helper functions to alloc / release struct video_device, the
    later can be used for video_device->release() */
