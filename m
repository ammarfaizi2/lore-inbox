Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263001AbUFNNcU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263001AbUFNNcU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jun 2004 09:32:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263003AbUFNNcU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jun 2004 09:32:20 -0400
Received: from web41013.mail.yahoo.com ([66.218.93.12]:43886 "HELO
	web41013.mail.yahoo.com") by vger.kernel.org with SMTP
	id S263001AbUFNNcT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jun 2004 09:32:19 -0400
Message-ID: <20040614133218.53174.qmail@web41013.mail.yahoo.com>
Date: Mon, 14 Jun 2004 06:32:18 -0700 (PDT)
From: John Carlson <carlsj@yahoo.com>
Subject: [PATCH] Usb gadget drivers 2.4 kernel
To: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

While developing a gadget driver for the 2.4 kernel, I
discovered this error in the gadget driver.  This bug
has been present since the gadget driver was back
ported from the 2.6 kernel.

diff -urN
linux-2.4.27-pre5/drivers/usb/gadget/config.c
linux-2.4.27-test/drivers/usb/gadget/config.c
--- linux-2.4.27-pre5/drivers/usb/gadget/config.c     
 2004-06-14 09:06:48.000000000
-0400
+++ linux-2.4.27-test/drivers/usb/gadget/config.c     
 2004-06-14 09:13:02.000000000
-0400
@@ -51,7 +51,7 @@
        for (; 0 != *src; src++) {
                unsigned                len =
(*src)->bLength;
  
-               if (len > buflen);
+               if (len > buflen)
                        return -EINVAL;
                memcpy(dest, *src, len);
                buflen -= len;


John Carlson <carlsonj@lexmark.com>



	
		
__________________________________
Do you Yahoo!?
Friends.  Fun.  Try the all-new Yahoo! Messenger.
http://messenger.yahoo.com/ 
