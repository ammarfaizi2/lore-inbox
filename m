Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276018AbRJGCCs>; Sat, 6 Oct 2001 22:02:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275973AbRJGCCj>; Sat, 6 Oct 2001 22:02:39 -0400
Received: from nycsmtp2fb.rdc-nyc.rr.com ([24.29.99.78]:1809 "EHLO si.rr.com")
	by vger.kernel.org with ESMTP id <S276018AbRJGCCU>;
	Sat, 6 Oct 2001 22:02:20 -0400
Message-ID: <3BBFB80E.9060308@si.rr.com>
Date: Sat, 06 Oct 2001 22:03:58 -0400
From: Frank Davis <fdavis@si.rr.com>
Reply-To: fdavis@si.rr.com
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:0.9.2) Gecko/20010726 Netscape6/6.1
X-Accept-Language: en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: alan@lxorguk.ukuu.org.uk
Subject: [PATCH] 2.4.10-ac7: More MODULE_LICENSE additions
Content-Type: multipart/mixed;
 boundary="------------060509050809010207020209"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------060509050809010207020209
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hello,
      I have attached more MODULE_LICENSE additions against 2.4.10-ac7 . 
Please review.
Regards,
Frank

--------------060509050809010207020209
Content-Type: text/plain;
 name="IDE-DISK"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="IDE-DISK"

--- drivers/ide/ide-disk.c.old	Mon Aug 27 11:53:01 2001
+++ drivers/ide/ide-disk.c	Sat Oct  6 20:07:07 2001
@@ -890,3 +890,4 @@
 
 module_init(idedisk_init);
 module_exit(idedisk_exit);
+MODULE_LICENSE("GPL");

--------------060509050809010207020209
Content-Type: text/plain;
 name="NETIUCV"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="NETIUCV"

--- drivers/s390/net/netiucv.c.old	Fri Oct  5 23:04:30 2001
+++ drivers/s390/net/netiucv.c	Sat Oct  6 20:50:37 2001
@@ -2115,7 +2115,8 @@
 	return 0;
 }
 
-module_init(netiucv_init);
 #ifdef MODULE
+module_init(netiucv_init);
 module_exit(netiucv_exit);
+MODULE_LICENSE("GPL");
 #endif

--------------060509050809010207020209
Content-Type: text/plain;
 name="PNP_BIOS"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="PNP_BIOS"

--- drivers/pnp/pnp_bios.c.old	Fri Oct  5 23:04:27 2001
+++ drivers/pnp/pnp_bios.c	Sat Oct  6 20:43:18 2001
@@ -1093,6 +1093,9 @@
 }
 
 #ifdef MODULE
+
+MODULE_LICENSE("GPL");
+
 /* We have to run it early and specifically in non modular.. */
 module_init(pnp_bios_init);
 
@@ -1104,5 +1107,6 @@
 }
 
 module_exit(pnp_bios_exit);
+
 #endif
 #endif

--------------060509050809010207020209
Content-Type: text/plain;
 name="TC"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="TC"

--- drivers/tc/tc.c.old	Sun Sep 30 20:39:33 2001
+++ drivers/tc/tc.c	Sat Oct  6 21:00:57 2001
@@ -25,6 +25,7 @@
 
 #define TC_DEBUG
 
+MODULE_LICENSE("GPL");
 slot_info tc_bus[MAX_SLOT];
 static int max_tcslot;
 static tcinfo *info;

--------------060509050809010207020209
Content-Type: text/plain;
 name="GRAPHICS"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="GRAPHICS"

--- drivers/sgi/char/graphics.c.old	Sun Sep 30 20:39:25 2001
+++ drivers/sgi/char/graphics.c	Sat Oct  6 21:05:33 2001
@@ -343,6 +343,8 @@
 }
 
 #ifdef MODULE
+MODULE_LICENSE("GPL");
+
 int init_module(void) {
 	static int initiated = 0;
 

--------------060509050809010207020209
Content-Type: text/plain;
 name="CTCMAIN"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="CTCMAIN"

--- drivers/s390/net/ctcmain.c.old	Fri Oct  5 23:04:30 2001
+++ drivers/s390/net/ctcmain.c	Sat Oct  6 20:53:42 2001
@@ -96,6 +96,7 @@
 #ifdef MODULE
 MODULE_AUTHOR("(C) 2000 IBM Corp. by Fritz Elfert (felfert@millenux.com)");
 MODULE_DESCRIPTION("Linux for S/390 CTC/Escon Driver");
+MODULE_LICENSE("GPL");
 #ifndef CTC_CHANDEV
 MODULE_PARM(ctc, "s");
 MODULE_PARM_DESC(ctc,

--------------060509050809010207020209
Content-Type: text/plain;
 name="ISAPNP"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ISAPNP"

--- drivers/pnp/isapnp.c.old	Fri Oct  5 23:04:27 2001
+++ drivers/pnp/isapnp.c	Sat Oct  6 20:37:06 2001
@@ -87,6 +87,7 @@
 MODULE_PARM_DESC(isapnp_reserve_io, "ISA Plug & Play - reserve I/O region(s) - port,size");
 MODULE_PARM(isapnp_reserve_mem, "1-16i");
 MODULE_PARM_DESC(isapnp_reserve_mem, "ISA Plug & Play - reserve memory region(s) - address,size");
+MODULE_LICENSE("GPL");
 
 #define _PIDXR		0x279
 #define _PNPWRP		0xa79

--------------060509050809010207020209
Content-Type: text/plain;
 name="ISAPNP_P"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ISAPNP_P"

--- drivers/pnp/isapnp_proc.c.old	Sat Oct  6 20:40:17 2001
+++ drivers/pnp/isapnp_proc.c	Sat Oct  6 20:41:08 2001
@@ -297,6 +297,8 @@
 
 #ifdef MODULE
 
+MODULE_LICENSE("GPL");
+
 static int __exit isapnp_proc_detach_device(struct pci_dev *dev)
 {
 	struct pci_bus *bus = dev->bus;

--------------060509050809010207020209
Content-Type: text/plain;
 name="KEYBDEV"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="KEYBDEV"

--- drivers/input/keybdev.c.old	Sun Sep 30 20:38:43 2001
+++ drivers/input/keybdev.c	Sat Oct  6 20:29:24 2001
@@ -246,3 +246,4 @@
 MODULE_AUTHOR("Vojtech Pavlik <vojtech@suse.cz>");
 MODULE_DESCRIPTION("Input driver to keyboard driver binding");
 MODULE_PARM(jp_kbd_109, "i");
+MODULE_LICENSE("GPL");

--------------060509050809010207020209
Content-Type: text/plain;
 name="NUBUS_SY"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="NUBUS_SY"

--- drivers/nubus/nubus_syms.c.old	Sat Sep  4 16:08:32 1999
+++ drivers/nubus/nubus_syms.c	Sat Oct  6 21:13:09 2001
@@ -12,6 +12,8 @@
 EXPORT_SYMBOL(nubus_proc_detach_device);
 #endif
 
+MODULE_LICENSE("GPL");
+
 EXPORT_SYMBOL(nubus_find_device);
 EXPORT_SYMBOL(nubus_find_type);
 EXPORT_SYMBOL(nubus_find_slot);

--------------060509050809010207020209
Content-Type: text/plain;
 name="I2C-PROC"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="I2C-PROC"

--- drivers/i2c/i2c-proc.c.old	Fri Oct  5 23:03:34 2001
+++ drivers/i2c/i2c-proc.c	Sat Oct  6 19:38:09 2001
@@ -883,6 +883,7 @@
 
 MODULE_AUTHOR("Frodo Looijaard <frodol@dds.nl>");
 MODULE_DESCRIPTION("i2c-proc driver");
+MODULE_LICENSE("GPL");
 
 int i2c_cleanup(void)
 {
@@ -902,5 +903,4 @@
 {
 	return i2c_cleanup();
 }
-
 #endif				/* MODULE */

--------------060509050809010207020209--

