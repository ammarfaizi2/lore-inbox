Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261882AbVAHIvW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261882AbVAHIvW (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jan 2005 03:51:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261883AbVAHIu0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jan 2005 03:50:26 -0500
Received: from mail.kroah.org ([69.55.234.183]:53381 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261882AbVAHFsY convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jan 2005 00:48:24 -0500
Subject: Re: [PATCH] USB and Driver Core patches for 2.6.10
In-Reply-To: <11051632574046@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Fri, 7 Jan 2005 21:47:37 -0800
Message-Id: <11051632573855@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1938.439.50, 2005/01/06 17:28:51-08:00, jlamanna@gmail.com

[PATCH] USB: ov511.c - vfree() checking cleanups

ov511.c vfree() checking cleanups.

Signed-off by: James Lamanna <jlamanna@gmail.com>
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 drivers/usb/media/ov511.c |   12 ++++--------
 1 files changed, 4 insertions(+), 8 deletions(-)


diff -Nru a/drivers/usb/media/ov511.c b/drivers/usb/media/ov511.c
--- a/drivers/usb/media/ov511.c	2005-01-07 15:37:39 -08:00
+++ b/drivers/usb/media/ov511.c	2005-01-07 15:37:39 -08:00
@@ -3908,15 +3908,11 @@
 		ov->fbuf = NULL;
 	}
 
-	if (ov->rawfbuf) {
-		vfree(ov->rawfbuf);
-		ov->rawfbuf = NULL;
-	}
+	vfree(ov->rawfbuf);
+	ov->rawfbuf = NULL;
 
-	if (ov->tempfbuf) {
-		vfree(ov->tempfbuf);
-		ov->tempfbuf = NULL;
-	}
+	vfree(ov->tempfbuf);
+	ov->tempfbuf = NULL;
 
 	for (i = 0; i < OV511_NUMSBUF; i++) {
 		if (ov->sbuf[i].data) {

