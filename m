Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261427AbVFJXXV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261427AbVFJXXV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Jun 2005 19:23:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261389AbVFJXXU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Jun 2005 19:23:20 -0400
Received: from wproxy.gmail.com ([64.233.184.205]:24125 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261427AbVFJXVp convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Jun 2005 19:21:45 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=nFBtfGt2TyCNHqsCbJQk/3mDnHOEm4anQagFU0K6o0yRQA+vKo62n+TBhC3aNRgZguCBGchVzQBBU4ww3qdoPTOCt4g8v1QZZ5JIxTbEjT4Jdlwc4lfpsVrC0VNOVBToU1ZVlm+zQU/MP5nyWd9ilRAw9D6JVOwVP0yUueiUL+E=
Message-ID: <9e47339105061016213195fb86@mail.gmail.com>
Date: Fri, 10 Jun 2005 19:21:44 -0400
From: Jon Smirl <jonsmirl@gmail.com>
Reply-To: Jon Smirl <jonsmirl@gmail.com>
To: fbdev <linux-fbdev-devel@lists.sourceforge.net>,
       "Antonino A. Daplas" <adaplas@hotpop.com>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Typo in fbdev sysfs support, virtual_size
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It prints out x,x instead of x,y.

Signed-off-by: jonsmirl@gmail.com <Jon Smirl>
diff --git a/drivers/video/fbsysfs.c b/drivers/video/fbsysfs.c
--- a/drivers/video/fbsysfs.c
+++ b/drivers/video/fbsysfs.c
@@ -241,7 +241,7 @@ static ssize_t show_virtual(struct class
 	struct fb_info *fb_info =
 		(struct fb_info *)class_get_devdata(class_device);
 	return snprintf(buf, PAGE_SIZE, "%d,%d\n", fb_info->var.xres_virtual,
-			fb_info->var.xres_virtual);
+			fb_info->var.yres_virtual);
 }
 
 static ssize_t store_cmap(struct class_device *class_device, const char * buf,

-- 
Jon Smirl
jonsmirl@gmail.com
