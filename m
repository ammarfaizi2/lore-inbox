Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270571AbTGNOEd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jul 2003 10:04:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270593AbTGNMbQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jul 2003 08:31:16 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:48260
	"EHLO hraefn.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id S270591AbTGNMNL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jul 2003 08:13:11 -0400
Date: Mon, 14 Jul 2003 13:27:12 +0100
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Message-Id: <200307141227.h6ECRCph030941@hraefn.swansea.linux.org.uk>
To: linux-kernel@vger.kernel.org, marcelo@conectiva.com
Subject: PATCH: fix vicam with old gcc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.22-pre5/drivers/usb/vicam.c linux.22-pre5-ac1/drivers/usb/vicam.c
--- linux.22-pre5/drivers/usb/vicam.c	2003-07-14 12:27:39.000000000 +0100
+++ linux.22-pre5-ac1/drivers/usb/vicam.c	2003-07-07 15:54:03.000000000 +0100
@@ -763,8 +763,8 @@
 static void
 vicam_close(struct video_device *dev)
 {
-	DBG("close\n");
 	struct vicam_camera *cam = (struct vicam_camera *) dev->priv;
+	DBG("close\n");
 
 
 	if (cam->is_removed) {
