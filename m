Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318447AbSIBUGv>; Mon, 2 Sep 2002 16:06:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318455AbSIBUGv>; Mon, 2 Sep 2002 16:06:51 -0400
Received: from inet-mail4.oracle.com ([148.87.2.204]:19594 "EHLO
	inet-mail4.oracle.com") by vger.kernel.org with ESMTP
	id <S318447AbSIBUGt>; Mon, 2 Sep 2002 16:06:49 -0400
Message-ID: <3D73C562.3040101@oracle.com>
Date: Mon, 02 Sep 2002 22:09:06 +0200
From: Alessandro Suardi <alessandro.suardi@oracle.com>
Organization: Oracle Consulting Premium Services
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020606
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: johannes@erdfelt.com
CC: linux-kernel@vger.kernel.org
Subject: [PATCH] 2.5.33 cpia.c __FUNCTION__ compile fix
Content-Type: multipart/mixed;
 boundary="------------050006000502020104050306"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This is a multi-part message in MIME format.
--------------050006000502020104050306
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

(attached, since mozilla-mail mangles whitespace in copy-paste
  from gnome-terminal :/ )

Compiles for me (TM).


Ciao,

--alessandro

  "everything dies, baby that's a fact
    but maybe everything that dies someday comes back"
        (Bruce Springsteen, "Atlantic City")

--------------050006000502020104050306
Content-Type: text/plain;
 name="cpia-2.5.33.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="cpia-2.5.33.diff"

--- drivers/media/video/cpia_usb.c-2.5.33	Sat May 25 22:50:00 2002
+++ drivers/media/video/cpia_usb.c	Sun Sep  1 02:57:14 2002
@@ -167,7 +167,7 @@
 	/* resubmit */
 	urb->dev = ucpia->dev;
 	if ((i = usb_submit_urb(urb, GFP_ATOMIC)) != 0)
-		printk(KERN_ERR __FUNCTION__ ": usb_submit_urb ret %d\n", i);
+		printk(KERN_ERR "%s: usb_submit_urb ret %d\n", __FUNCTION__,  i);
 }
 
 static int cpia_usb_open(void *privdata)
--- drivers/media/video/cpia.h-2.5.33	Thu Oct 25 22:53:47 2001
+++ drivers/media/video/cpia.h	Sun Sep  1 02:55:55 2002
@@ -379,7 +379,7 @@
 #define ERROR_FLICKER_BELOW_MIN_EXP     0x01 /*flicker exposure got below minimum exposure */
 
 #define ALOG(lineno,fmt,args...) printk(fmt,lineno,##args)
-#define LOG(fmt,args...) ALOG((__LINE__),KERN_INFO __FILE__":"__FUNCTION__"(%d):"fmt,##args)
+#define LOG(fmt,args...) ALOG((__LINE__),KERN_INFO __FILE__":%s(%d):"fmt, __FUNCTION__, ##args)
 
 #ifdef _CPIA_DEBUG_
 #define ADBG(lineno,fmt,args...) printk(fmt, jiffies, lineno, ##args)

--------------050006000502020104050306--

