Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269417AbRHaWDn>; Fri, 31 Aug 2001 18:03:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269421AbRHaWDX>; Fri, 31 Aug 2001 18:03:23 -0400
Received: from hera.cwi.nl ([192.16.191.8]:52379 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S269417AbRHaWDQ>;
	Fri, 31 Aug 2001 18:03:16 -0400
From: Andries.Brouwer@cwi.nl
Date: Fri, 31 Aug 2001 22:03:27 GMT
Message-Id: <200108312203.WAA15637@vlet.cwi.nl>
To: alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org,
        mdharm-usb@one-eyed-alien.net, torvalds@transmeta.com
Subject: [PATCH] usb fix
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Wondering why my USB Compact Flash cardreader works with 2.4.7
but not with 2.4.9, I noticed that my name was added and some
constant changed. Changing it back revived my CF reader.

Andries

--- ../linux-2.4.9/linux/drivers/usb/storage/unusual_devs.h	Sat Aug 11 03:16:46 2001
+++ ./linux/drivers/usb/storage/unusual_devs.h	Fri Aug 31 23:50:19 2001
@@ -96,7 +96,7 @@
 #endif
 
 /* This entry is from Andries.Brouwer@cwi.nl */
-UNUSUAL_DEV(  0x04e6, 0x0005, 0x0100, 0x0205, 
+UNUSUAL_DEV(  0x04e6, 0x0005, 0x0100, 0x0208,
 		"SCM Microsystems",
 		"eUSB SmartMedia / CompactFlash Adapter",
 		US_SC_SCSI, US_PR_DPCM_USB, NULL, 
