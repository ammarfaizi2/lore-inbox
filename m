Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030520AbWJJVsq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030520AbWJJVsq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Oct 2006 17:48:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030526AbWJJVso
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Oct 2006 17:48:44 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:33467 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1030525AbWJJVsi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Oct 2006 17:48:38 -0400
To: torvalds@osdl.org
Subject: [PATCH] em28xx NULL noise removal
Cc: linux-kernel@vger.kernel.org
Message-Id: <E1GXPSn-0007Qa-EX@ZenIV.linux.org.uk>
From: Al Viro <viro@ftp.linux.org.uk>
Date: Tue, 10 Oct 2006 22:48:37 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 drivers/media/video/em28xx/em28xx-video.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/media/video/em28xx/em28xx-video.c b/drivers/media/video/em28xx/em28xx-video.c
index 20df657..2a461dd 100644
--- a/drivers/media/video/em28xx/em28xx-video.c
+++ b/drivers/media/video/em28xx/em28xx-video.c
@@ -174,7 +174,7 @@ static void em28xx_config_i2c(struct em2
 
 	route.input = INPUT(dev->ctl_input)->vmux;
 	route.output = 0;
-	em28xx_i2c_call_clients(dev, VIDIOC_INT_RESET, 0);
+	em28xx_i2c_call_clients(dev, VIDIOC_INT_RESET, NULL);
 	em28xx_i2c_call_clients(dev, VIDIOC_INT_S_VIDEO_ROUTING, &route);
 	em28xx_i2c_call_clients(dev, VIDIOC_STREAMON, NULL);
 
-- 
1.4.2.GIT


