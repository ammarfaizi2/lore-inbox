Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262166AbUKDLT3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262166AbUKDLT3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Nov 2004 06:19:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262171AbUKDLSB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Nov 2004 06:18:01 -0500
Received: from sd291.sivit.org ([194.146.225.122]:11737 "EHLO sd291.sivit.org")
	by vger.kernel.org with ESMTP id S262165AbUKDLOO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Nov 2004 06:14:14 -0500
Date: Thu, 4 Nov 2004 12:14:26 +0100
From: Stelian Pop <stelian@popies.net>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Subject: [PATCH 3/12] meye: picture depth is in bits not in bytes
Message-ID: <20041104111425.GI3472@crusoe.alcove-fr>
Reply-To: Stelian Pop <stelian@popies.net>
Mail-Followup-To: Stelian Pop <stelian@popies.net>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
References: <20041104111231.GF3472@crusoe.alcove-fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041104111231.GF3472@crusoe.alcove-fr>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

===================================================================

ChangeSet@1.2342, 2004-11-02 15:41:24+01:00, stelian@popies.net
  meye: picture depth is in bits not in bytes
  
  Signed-off-by: Stelian Pop <stelian@popies.net>

===================================================================

 meye.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

===================================================================

diff -Nru a/drivers/media/video/meye.c b/drivers/media/video/meye.c
--- a/drivers/media/video/meye.c	2004-11-04 11:20:03 +01:00
+++ b/drivers/media/video/meye.c	2004-11-04 11:20:03 +01:00
@@ -904,7 +904,7 @@
 
 	case VIDIOCSPICT: {
 		struct video_picture *p = arg;
-		if (p->depth != 2)
+		if (p->depth != 16)
 			return -EINVAL;
 		if (p->palette != VIDEO_PALETTE_YUV422)
 			return -EINVAL;
@@ -1335,7 +1335,7 @@
 	init_MUTEX(&meye.lock);
 	init_waitqueue_head(&meye.proc_list);
 
-	meye.picture.depth = 2;
+	meye.picture.depth = 16;
 	meye.picture.palette = VIDEO_PALETTE_YUV422;
 	meye.picture.brightness = 32 << 10;
 	meye.picture.hue = 32 << 10;
