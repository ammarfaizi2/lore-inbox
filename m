Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318809AbSHWOC2>; Fri, 23 Aug 2002 10:02:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318810AbSHWOC2>; Fri, 23 Aug 2002 10:02:28 -0400
Received: from CPE-203-51-32-20.nsw.bigpond.net.au ([203.51.32.20]:47868 "EHLO
	e4.eyal.emu.id.au") by vger.kernel.org with ESMTP
	id <S318809AbSHWOC1>; Fri, 23 Aug 2002 10:02:27 -0400
Message-ID: <3D664167.44A188CC@eyal.emu.id.au>
Date: Sat, 24 Aug 2002 00:06:31 +1000
From: Eyal Lebedinsky <eyal@eyal.emu.id.au>
Organization: Eyal at Home
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@redhat.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.20-pre4-ac1
References: <200208231046.g7NAk2914276@devserv.devel.redhat.com>
Content-Type: multipart/mixed;
 boundary="------------7EE7CA6FCC6B785DEF784BDD"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------7EE7CA6FCC6B785DEF784BDD
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

linux/drivers/usb/brlvger.c compile error

You would think that gcc, having had the same problem for a while,
would have smarted up by now. And they say computers are our
future...

--
Eyal Lebedinsky (eyal@eyal.emu.id.au) <http://samba.org/eyal/>
--------------7EE7CA6FCC6B785DEF784BDD
Content-Type: text/plain; charset=us-ascii;
 name="2.4.20-pre4-ac1.usb.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="2.4.20-pre4-ac1.usb.patch"

--- linux/drivers/usb/brlvger.c.orig	Fri Aug 23 23:51:46 2002
+++ linux/drivers/usb/brlvger.c	Fri Aug 23 23:52:08 2002
@@ -209,7 +209,7 @@
     ({ printk(KERN_ERR "Voyager: " args); \
        printk("\n"); })
 #define dbgprint(fmt, args...) \
-    ({ printk(KERN_DEBUG "Voyager: %s: " fmt, __FUNCTION__, ##args); \
+    ({ printk(KERN_DEBUG "Voyager: %s: " fmt, __FUNCTION__ , ##args); \
        printk("\n"); })
 #define dbg(args...) \
     ({ if(debug >= 1) dbgprint(args); })

--------------7EE7CA6FCC6B785DEF784BDD--

