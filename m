Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273783AbRJJCCH>; Tue, 9 Oct 2001 22:02:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273818AbRJJCB7>; Tue, 9 Oct 2001 22:01:59 -0400
Received: from nycsmtp3fa.rdc-nyc.rr.com ([24.29.99.79]:16649 "EHLO si.rr.com")
	by vger.kernel.org with ESMTP id <S273783AbRJJCBn>;
	Tue, 9 Oct 2001 22:01:43 -0400
Message-ID: <3BC3AC55.90606@si.rr.com>
Date: Tue, 09 Oct 2001 22:03:01 -0400
From: Frank Davis <fdavis@si.rr.com>
Reply-To: fdavis@si.rr.com
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:0.9.2) Gecko/20010726 Netscape6/6.1
X-Accept-Language: en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: alan <alan@redhat.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH] 2.4.10-ac10: more MODULE_LICENSE patches
Content-Type: multipart/mixed;
 boundary="------------060102090608090101080402"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------060102090608090101080402
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hello,
  I have attached more MODULE_LICENSE patches against 2.4.10-ac10 . 
major directories:
drivers/usb/
drivers/macintosh/
drivers/pcmcia/

Please review.
Regards,
Frank

--------------060102090608090101080402
Content-Type: text/plain;
 name="USBHUB"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="USBHUB"

--- drivers/usb/hub.c.old	Mon Oct  8 18:25:36 2001
+++ drivers/usb/hub.c	Tue Oct  9 21:17:47 2001
@@ -856,7 +856,7 @@
 };
 
 MODULE_DEVICE_TABLE (usb, hub_id_table);
-
+MODULE_LICENSE("GPL");
 static struct usb_driver hub_driver = {
 	name:		"hub",
 	probe:		hub_probe,

--------------060102090608090101080402
Content-Type: text/plain;
 name="USBINODE"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="USBINODE"

--- drivers/usb/inode.c.old	Mon Oct  8 18:25:37 2001
+++ drivers/usb/inode.c	Tue Oct  9 21:15:15 2001
@@ -767,4 +767,5 @@
 #if 0
 module_init(usbdevfs_init);
 module_exit(usbdevfs_cleanup);
+MODULE_LICENSE("GPL");
 #endif

--------------060102090608090101080402
Content-Type: text/plain;
 name="MACSERIA"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="MACSERIA"

--- drivers/macintosh/macserial.c.old	Sun Sep 30 20:38:48 2001
+++ drivers/macintosh/macserial.c	Tue Oct  9 20:36:27 2001
@@ -2730,6 +2730,7 @@
 
 module_init(macserial_init);
 module_exit(macserial_cleanup);
+MODULE_LICENSE("GPL");
 
 #if 0
 /*

--------------060102090608090101080402
Content-Type: text/plain;
 name="CISTPL"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="CISTPL"

--- drivers/pcmcia/cistpl.c.old	Fri Feb 16 19:02:36 2001
+++ drivers/pcmcia/cistpl.c	Tue Oct  9 21:07:12 2001
@@ -85,6 +85,8 @@
 
 INT_MODULE_PARM(cis_width,	0);		/* 16-bit CIS? */
 
+MODULE_LICENSE("GPL");
+
 /*======================================================================
 
     Low-level functions to read and write CIS memory.  I think the

--------------060102090608090101080402
Content-Type: text/plain;
 name="HD64465_"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="HD64465_"

--- drivers/pcmcia/hd64465_ss.c.old	Tue Jul 10 23:16:30 2001
+++ drivers/pcmcia/hd64465_ss.c	Tue Oct  9 21:05:43 2001
@@ -1082,6 +1082,7 @@
 
 module_init(init_hs);
 module_exit(exit_hs);
+MODULE_LICENSE("GPL");
 
 /*============================================================*/
 /*END*/

--------------060102090608090101080402
Content-Type: text/plain;
 name="NVRAM"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="NVRAM"

--- drivers/macintosh/nvram.c.old	Sun Sep 30 20:38:49 2001
+++ drivers/macintosh/nvram.c	Tue Oct  9 20:37:55 2001
@@ -124,3 +124,4 @@
 
 module_init(nvram_init);
 module_exit(nvram_cleanup);
+MODULE_LICENSE("GPL");

--------------060102090608090101080402
Content-Type: text/plain;
 name="SA1100_G"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="SA1100_G"

--- drivers/pcmcia/sa1100_generic.c.old	Mon Oct  8 18:25:00 2001
+++ drivers/pcmcia/sa1100_generic.c	Tue Oct  9 21:00:06 2001
@@ -63,6 +63,7 @@
 
 MODULE_AUTHOR("John Dorsey <john+@cs.cmu.edu>");
 MODULE_DESCRIPTION("Linux PCMCIA Card Services: SA-1100 Socket Controller");
+MODULE_LICENSE("GPL");
 
 /* This structure maintains housekeeping state for each socket, such
  * as the last known values of the card detect pins, or the Card Services

--------------060102090608090101080402
Content-Type: text/plain;
 name="RTC_MAC"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="RTC_MAC"

--- drivers/macintosh/rtc.c.old	Sun Sep 30 20:38:49 2001
+++ drivers/macintosh/rtc.c	Tue Oct  9 20:39:12 2001
@@ -146,3 +146,5 @@
 
 module_init(rtc_init);
 module_exit(rtc_exit);
+MODULE_LICENSE("GPL");
+

--------------060102090608090101080402
Content-Type: text/plain;
 name="RSRC_MGR"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="RSRC_MGR"

--- drivers/pcmcia/rsrc_mgr.c.old	Sun Jul 15 19:22:23 2001
+++ drivers/pcmcia/rsrc_mgr.c	Tue Oct  9 21:02:40 2001
@@ -67,6 +67,8 @@
 INT_MODULE_PARM(mem_limit,	0x10000);
 #endif
 
+MODULE_LICENSE("GPL");
+
 /*======================================================================
 
     The resource_map_t structures are used to track what resources are

--------------060102090608090101080402
Content-Type: text/plain;
 name="PCI_SOCK"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="PCI_SOCK"

--- drivers/pcmcia/pci_socket.c.old	Tue Jun 12 19:52:14 2001
+++ drivers/pcmcia/pci_socket.c	Tue Oct  9 21:04:08 2001
@@ -266,3 +266,4 @@
 
 module_init(pci_socket_init);
 module_exit(pci_socket_exit);
+MODULE_LICENSE("GPL");

--------------060102090608090101080402--

