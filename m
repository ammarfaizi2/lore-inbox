Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265144AbSJaDNV>; Wed, 30 Oct 2002 22:13:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265145AbSJaDNV>; Wed, 30 Oct 2002 22:13:21 -0500
Received: from 653277hfc248.tampabay.rr.com ([65.32.77.248]:49421 "EHLO
	bender.davehollis.com") by vger.kernel.org with ESMTP
	id <S265144AbSJaDNT>; Wed, 30 Oct 2002 22:13:19 -0500
Message-ID: <3DC0A143.2000304@davehollis.com>
Date: Wed, 30 Oct 2002 22:19:31 -0500
From: David T Hollis <dhollis@davehollis.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20021020
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [PATCH] 2.5.45 drivers/net/irda/irda-usb.c Compile Fix
Content-Type: multipart/mixed;
 boundary="------------070409080202020106030601"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------070409080202020106030601
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Fixes an apparent typo in irda-usb.c that prevented it from compiling.

--------------070409080202020106030601
Content-Type: text/plain;
 name="linux-2.4.45-irda-usb.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="linux-2.4.45-irda-usb.patch"

--- drivers/net/irda/irda-usb.c.orig	2002-10-30 22:16:48.000000000 -0500
+++ drivers/net/irda/irda-usb.c	2002-10-30 22:17:03.000000000 -0500
@@ -1487,7 +1487,7 @@
 	 * specify an alternate, but very few driver do like this.
 	 * Jean II */
 	ret = usb_set_interface(dev, intf->altsetting->desc.bInterfaceNumber, 0);
-	IRDA_DEBUG(1, "usb-irda: set interface %d result %d\n", intf->altsetting->bInterfaceNumber, ret);
+	IRDA_DEBUG(1, "usb-irda: set interface %d result %d\n", intf->altsetting->desc.bInterfaceNumber, ret);
 	switch (ret) {
 		case 0:
 			break;

--------------070409080202020106030601--

