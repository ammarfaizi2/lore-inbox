Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313113AbSDJOLc>; Wed, 10 Apr 2002 10:11:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313122AbSDJOLb>; Wed, 10 Apr 2002 10:11:31 -0400
Received: from [62.221.7.202] ([62.221.7.202]:48522 "EHLO
	wagner.rustcorp.com.au") by vger.kernel.org with ESMTP
	id <S313113AbSDJOKQ>; Wed, 10 Apr 2002 10:10:16 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: petkan@users.sourceforge.net
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] USB rtl8150 bug
Date: Wed, 10 Apr 2002 23:48:17 +1000
Message-Id: <E16vISP-00031t-00@wagner.rustcorp.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Name: Bitops rtl8150 USB fix.
Author: Rusty Russell
Status: Trivial

D: This changes struct rtl8150's flags element to be an unsigned long,
D: since bitops are done on it.

diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.8-pre3/drivers/usb/net/rtl8150.c tmp/drivers/usb/net/rtl8150.c
--- linux-2.5.8-pre3/drivers/usb/net/rtl8150.c	Wed Apr 10 21:47:51 2002
+++ tmp/drivers/usb/net/rtl8150.c	Wed Apr 10 23:26:37 2002
@@ -83,7 +83,7 @@
 
 
 struct rtl8150 {
-	unsigned int		flags;
+	unsigned long		flags;
 	struct usb_device	*udev;
 	struct usb_interface	*interface;
 	struct semaphore	sem;

--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
