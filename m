Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261701AbUK2Mkw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261701AbUK2Mkw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Nov 2004 07:40:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261706AbUK2Mit
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Nov 2004 07:38:49 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:25107 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261701AbUK2Mhc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Nov 2004 07:37:32 -0500
Date: Mon, 29 Nov 2004 13:37:29 +0100
From: Adrian Bunk <bunk@stusta.de>
To: zaitcev@yahoo.com, linux-kernel@vger.kernel.org
Subject: [2.6 patch] drivers/block/ub.c: make a struct static
Message-ID: <20041129123729.GQ9722@stusta.de>
References: <20041124231055.GN19873@stusta.de> <20041125101220.GC29539@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041125101220.GC29539@infradead.org>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch below make a needlessly global struct static.


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.10-rc1-mm3-full/drivers/block/ub.c.old	2004-11-06 20:19:32.000000000 +0100
+++ linux-2.6.10-rc1-mm3-full/drivers/block/ub.c	2004-11-06 20:19:45.000000000 +0100
@@ -2097,7 +2097,7 @@
 	spin_unlock_irqrestore(&ub_lock, flags);
 }
 
-struct usb_driver ub_driver = {
+static struct usb_driver ub_driver = {
 	.owner =	THIS_MODULE,
 	.name =		"ub",
 	.probe =	ub_probe,

