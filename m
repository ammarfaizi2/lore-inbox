Return-Path: <linux-kernel-owner+w=401wt.eu-S1755032AbWL2CKP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755032AbWL2CKP (ORCPT <rfc822;w@1wt.eu>);
	Thu, 28 Dec 2006 21:10:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755035AbWL2CKP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Dec 2006 21:10:15 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:1804 "HELO
	mailout.stusta.mhn.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1755032AbWL2CKN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Dec 2006 21:10:13 -0500
Date: Fri, 29 Dec 2006 03:10:16 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>, mchehab@infradead.org
Cc: linux-kernel@vger.kernel.org, v4l-dvb-maintainer@linuxtv.org
Subject: [-mm patch] make usbvision_rvfree() static
Message-ID: <20061229021016.GO20714@stusta.de>
References: <20061228024237.375a482f.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061228024237.375a482f.akpm@osdl.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 28, 2006 at 02:42:37AM -0800, Andrew Morton wrote:
>...
> Changes since 2.6.20-rc1-mm1:
>...
>  git-dvb.patch
>...
>  git trees
>...


usbvision_rvfree() can now become static.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.20-rc2-mm1/drivers/media/video/usbvision/usbvision.h.old	2006-12-29 01:44:37.000000000 +0100
+++ linux-2.6.20-rc2-mm1/drivers/media/video/usbvision/usbvision.h	2006-12-29 01:44:43.000000000 +0100
@@ -486,7 +486,6 @@
 void call_i2c_clients(struct usb_usbvision *usbvision, unsigned int cmd,void *arg);
 
 /* defined in usbvision-core.c                                      */
-void usbvision_rvfree(void *mem, unsigned long size);
 int usbvision_read_reg(struct usb_usbvision *usbvision, unsigned char reg);
 int usbvision_write_reg(struct usb_usbvision *usbvision, unsigned char reg,
 			unsigned char value);
--- linux-2.6.20-rc2-mm1/drivers/media/video/usbvision/usbvision-core.c.old	2006-12-29 01:44:50.000000000 +0100
+++ linux-2.6.20-rc2-mm1/drivers/media/video/usbvision/usbvision-core.c	2006-12-29 01:44:59.000000000 +0100
@@ -139,7 +139,7 @@
 	return mem;
 }
 
-void usbvision_rvfree(void *mem, unsigned long size)
+static void usbvision_rvfree(void *mem, unsigned long size)
 {
 	unsigned long adr;
 

