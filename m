Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263727AbTCUSYo>; Fri, 21 Mar 2003 13:24:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263713AbTCUSXv>; Fri, 21 Mar 2003 13:23:51 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:51331
	"EHLO hraefn.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S263721AbTCUSXZ>; Fri, 21 Mar 2003 13:23:25 -0500
Date: Fri, 21 Mar 2003 19:38:40 GMT
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Message-Id: <200303211938.h2LJce4U025857@hraefn.swansea.linux.org.uk>
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: PATCH: fix GTUNER on w9966
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.65/drivers/media/video/w9966.c linux-2.5.65-ac2/drivers/media/video/w9966.c
--- linux-2.5.65/drivers/media/video/w9966.c	2003-02-10 18:38:04.000000000 +0000
+++ linux-2.5.65-ac2/drivers/media/video/w9966.c	2003-03-06 21:58:28.000000000 +0000
@@ -742,7 +742,7 @@
 	case VIDIOCGTUNER:
 	{
 		struct video_tuner *vtune = arg;
-		if(vtune->tuner != 0);
+		if(vtune->tuner != 0)
 			return -EINVAL;
 		strcpy(vtune->name, "no tuner");
 		vtune->rangelow = 0;
