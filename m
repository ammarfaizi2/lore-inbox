Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964843AbVKLXDO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964843AbVKLXDO (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Nov 2005 18:03:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932508AbVKLXDO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Nov 2005 18:03:14 -0500
Received: from tim.rpsys.net ([194.106.48.114]:43756 "EHLO tim.rpsys.net")
	by vger.kernel.org with ESMTP id S932507AbVKLXDN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Nov 2005 18:03:13 -0500
Subject: [patch] w100fb platform device conversion fixup
From: Richard Purdie <rpurdie@rpsys.net>
To: Andrew Morton <akpm@osdl.org>
Cc: "Antonino A. Daplas" <adaplas@gmail.com>,
       LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Date: Sat, 12 Nov 2005 23:03:04 +0000
Message-Id: <1131836584.7597.34.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fix an error in w100fb after the platform device conversion.

Signed-off-by: Richard Purdie <rpurdie@rpsys.net>

Index: linux-2.6.14/drivers/video/w100fb.c
===================================================================
--- linux-2.6.14.orig/drivers/video/w100fb.c	2005-11-12 12:54:42.000000000 +0000
+++ linux-2.6.14/drivers/video/w100fb.c	2005-11-12 22:48:27.000000000 +0000
@@ -514,7 +514,7 @@
 	if (remapped_fbuf == NULL)
 		goto out;
 
-	info=framebuffer_alloc(sizeof(struct w100fb_par), dev);
+	info=framebuffer_alloc(sizeof(struct w100fb_par), &pdev->dev);
 	if (!info) {
 		err = -ENOMEM;
 		goto out;

