Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261471AbUCAWuS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Mar 2004 17:50:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261472AbUCAWuS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Mar 2004 17:50:18 -0500
Received: from 216-239-45-4.google.com ([216.239.45.4]:41268 "EHLO
	216-239-45-4.google.com") by vger.kernel.org with ESMTP
	id S261471AbUCAWuP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Mar 2004 17:50:15 -0500
Date: Mon, 1 Mar 2004 14:50:09 -0800
From: Frank Cusack <fcusack@fcusack.com>
To: lkml <linux-kernel@vger.kernel.org>
Subject: [PATCH] vicam ioctl VIDIOCSWIN wrong return value
Message-ID: <20040301145008.A24132@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Should this return -EINVAL?  (credit to Paul Menage).

diff -urp linux-2.4.25/drivers/usb/vicam.c linux-2.4.25.1/drivers/usb/vicam.c
--- linux-2.4.25/drivers/usb/vicam.c	2004-02-18 05:36:31.000000000 -0800
+++ linux-2.4.25.1/drivers/usb/vicam.c	2004-03-01 14:47:59.000000000 -0800
@@ -612,7 +612,7 @@ vicam_ioctl(struct video_device *dev, un
 			DBG("VIDIOCSWIN %d x %d\n", vw->width, vw->height);
 			
 			if ( vw.width != 320 || vw.height != 240 )
-				retval = -EFAULT;
+				retval = -EINVAL;
 
 			break;
 		}

/fc
