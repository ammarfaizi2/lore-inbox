Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932908AbWKQOVR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932908AbWKQOVR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Nov 2006 09:21:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932909AbWKQOVR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Nov 2006 09:21:17 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:60943 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932908AbWKQOVR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Nov 2006 09:21:17 -0500
Date: Fri, 17 Nov 2006 15:21:15 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>, corbet@lwn.net,
       v4l-dvb-maintainer@linuxtv.org
Cc: linux-kernel@vger.kernel.org
Subject: [-mm patch] drivers/media/video/cafe_ccic.c: make a function static
Message-ID: <20061117142115.GW31879@stusta.de>
References: <20061114014125.dd315fff.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061114014125.dd315fff.akpm@osdl.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 14, 2006 at 01:41:25AM -0800, Andrew Morton wrote:
>...
> Changes since 2.6.19-rc5-mm2:
>...
>  git-dvb.patch
>...
>  git trees
>...

This patch makes the needlessly global cafe_v4l_dev_release() static.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.19-rc5-mm2/drivers/media/video/cafe_ccic.c.old	2006-11-17 13:13:44.000000000 +0100
+++ linux-2.6.19-rc5-mm2/drivers/media/video/cafe_ccic.c	2006-11-17 13:13:57.000000000 +0100
@@ -1688,7 +1688,7 @@
 };
 
 
-void cafe_v4l_dev_release(struct video_device *vd)
+static void cafe_v4l_dev_release(struct video_device *vd)
 {
 	struct cafe_camera *cam = container_of(vd, struct cafe_camera, v4ldev);
 

