Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262982AbTI2LIK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Sep 2003 07:08:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262983AbTI2LIK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Sep 2003 07:08:10 -0400
Received: from hirsch.in-berlin.de ([192.109.42.6]:47002 "EHLO
	hirsch.in-berlin.de") by vger.kernel.org with ESMTP id S262982AbTI2LIH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Sep 2003 07:08:07 -0400
X-Envelope-From: kraxel@bytesex.org
Date: Mon, 29 Sep 2003 13:06:37 +0200
From: Gerd Knorr <kraxel@bytesex.org>
To: Linus Torvalds <torvalds@transmeta.com>,
       Kernel List <linux-kernel@vger.kernel.org>
Subject: [patch] use print_dev_t() for sysfs dev file in videodev.c
Message-ID: <20030929110637.GA8500@bytesex.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Trivial one-liner, $subject says all.

please apply,

  Gerd

--- drivers/media/video/videodev.c.sysfs	2003-09-29 12:39:08.243219904 +0200
+++ drivers/media/video/videodev.c	2003-09-29 12:39:23.531895672 +0200
@@ -52,7 +52,7 @@
 {
 	struct video_device *vfd = container_of(cd, struct video_device, class_dev);
 	dev_t dev = MKDEV(VIDEO_MAJOR, vfd->minor);
-	return sprintf(buf,"%04x\n",old_encode_dev(dev));
+	return print_dev_t(buf,dev);
 }
 
 static CLASS_DEVICE_ATTR(name, S_IRUGO, show_name, NULL);

