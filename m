Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313190AbSEZW55>; Sun, 26 May 2002 18:57:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314280AbSEZW55>; Sun, 26 May 2002 18:57:57 -0400
Received: from hera.cwi.nl ([192.16.191.8]:43156 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S313190AbSEZW54>;
	Sun, 26 May 2002 18:57:56 -0400
From: Andries.Brouwer@cwi.nl
Date: Mon, 27 May 2002 00:57:56 +0200 (MEST)
Message-Id: <UTC200205262257.g4QMvuX27169.aeb@smtp.cwi.nl>
To: jbeatty@optonline.net, linux-kernel@vger.kernel.org
Subject: [PATCH] Re: usb mass storage fails in 2.5.18
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In 2.5.16 - 2.5.18 there is one bad bug in usb-storage
fixed by the 1-char patch below. Other things are wrong,
but try this first.

Andries

--- /linux/2.5/linux-2.5.18/linux/drivers/usb/storage/transport.c       Tue May 
21 07:07:37 2002
+++ /linux/2.5/linux-2.5.18a/linux/drivers/usb/storage/transport.c      Sun May 
26 00:32:48 2002
@@ -430,7 +430,7 @@
 
        /* fill the URB */
        FILL_CONTROL_URB(us->current_urb, us->pusb_dev, pipe, 
-                        (unsigned char*) &dr, data, size, 
+                        (unsigned char*) dr, data, size, 
                         usb_stor_blocking_completion, NULL);
 
        /* submit the URB */
