Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261233AbVDSAws@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261233AbVDSAws (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Apr 2005 20:52:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261235AbVDSAuz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Apr 2005 20:50:55 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:39692 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261233AbVDSAtu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Apr 2005 20:49:50 -0400
Date: Tue, 19 Apr 2005 02:49:46 +0200
From: Adrian Bunk <bunk@stusta.de>
To: kraxel@bytesex.org
Cc: video4linux-list@redhat.com, linux-kernel@vger.kernel.org
Subject: [2.6 patch] drivers/media/video/saa7134/saa7134-dvb.c: make a struct static
Message-ID: <20050419004946.GN5489@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch makes a needlessly global struct static.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.12-rc2-mm3-full/drivers/media/video/saa7134/saa7134-dvb.c.old	2005-04-19 01:39:58.000000000 +0200
+++ linux-2.6.12-rc2-mm3-full/drivers/media/video/saa7134/saa7134-dvb.c	2005-04-19 01:40:08.000000000 +0200
@@ -172,7 +172,7 @@
 	return request_firmware(fw, name, &dev->pci->dev);
 }
 
-struct tda1004x_config medion_cardbus = {
+static struct tda1004x_config medion_cardbus = {
 	.demod_address = 0x08,  /* not sure this is correct */
 	.invert        = 0,
         .invert_oclk   = 0,

