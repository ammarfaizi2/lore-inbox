Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751191AbVJXRhT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751191AbVJXRhT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Oct 2005 13:37:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751192AbVJXRhT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Oct 2005 13:37:19 -0400
Received: from elvira.ekonomikum.uu.se ([130.238.164.5]:44511 "EHLO
	elvira.ekonomikum.uu.se") by vger.kernel.org with ESMTP
	id S1751191AbVJXRhS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Oct 2005 13:37:18 -0400
Message-ID: <435D1D67.9000301@it.uu.se>
Date: Mon, 24 Oct 2005 19:44:07 +0200
From: Johann Deneux <johann.deneux@it.uu.se>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: vojtech@suse.cz
CC: linux-joystick@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org
Subject: [PATCH] Added LMP Destiny Force feedback to iforce driver
Content-Type: multipart/mixed;
 boundary="------------080308020703090006020201"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------080308020703090006020201
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Adds support for "LMP Destiny Force feedback" to the iforce driver.

Signed-off-by: Johann Deneux <johann.deneux@it.uu.se>


diff -uprN -X linux-2.6.13.4-vanilla/Documentation/dontdiff 
linux-2.6.13.4-vanilla/drivers/input/joystick/iforce/iforce-main.c 
linux-2.6.13.4-ff/drivers/input/joystick/iforce/iforce-main.c
--- 
linux-2.6.13.4-vanilla/drivers/input/joystick/iforce/iforce-main.c    
2005-10-10 20:54:29.000000000 +0200
+++ linux-2.6.13.4-ff/drivers/input/joystick/iforce/iforce-main.c    
2005-10-24 18:38:45.000000000 +0200
@@ -79,6 +79,7 @@ static struct iforce_device iforce_devic
     { 0x06f8, 0x0001, "Guillemot Race Leader Force Feedback",    
btn_wheel, abs_wheel, ff_iforce }, //?
     { 0x06f8, 0x0004, "Guillemot Force Feedback Racing Wheel",    
btn_wheel, abs_wheel, ff_iforce }, //?
     { 0x06f8, 0x0004, "Gullemot Jet Leader 3D",            
btn_joystick, abs_joystick, ff_iforce }, //?
+    { 0x06b6, 0x0001, "LMP Destiny Force Feedback Wheel",           
btn_wheel, abs_wheel, ff_iforce },
     { 0x0000, 0x0000, "Unknown I-Force Device [%04x:%04x]",        
btn_joystick, abs_joystick, ff_iforce }
 };
 
diff -uprN -X linux-2.6.13.4-vanilla/Documentation/dontdiff 
linux-2.6.13.4-vanilla/drivers/input/joystick/iforce/iforce-usb.c 
linux-2.6.13.4-ff/drivers/input/joystick/iforce/iforce-usb.c
--- linux-2.6.13.4-vanilla/drivers/input/joystick/iforce/iforce-usb.c    
2005-10-10 20:54:29.000000000 +0200
+++ linux-2.6.13.4-ff/drivers/input/joystick/iforce/iforce-usb.c    
2005-10-24 18:39:29.000000000 +0200
@@ -230,6 +230,7 @@ static struct usb_device_id iforce_usb_i
     { USB_DEVICE(0x06f8, 0x0001) },        /* Guillemot Race Leader 
Force Feedback */
     { USB_DEVICE(0x06f8, 0x0004) },        /* Guillemot Force Feedback 
Racing Wheel */
     { USB_DEVICE(0x06f8, 0xa302) },        /* Guillemot Jet Leader 3D */
+    { USB_DEVICE(0x06b6, 0x0001) },         /* LMP Destiny Force 
Feedback Wheel */
     { }                    /* Terminating entry */
 };
 


--------------080308020703090006020201
Content-Type: text/plain;
 name="patch-iforce-2.6.13.4"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch-iforce-2.6.13.4"

diff -uprN -X linux-2.6.13.4-vanilla/Documentation/dontdiff linux-2.6.13.4-vanilla/drivers/input/joystick/iforce/iforce-main.c linux-2.6.13.4-ff/drivers/input/joystick/iforce/iforce-main.c
--- linux-2.6.13.4-vanilla/drivers/input/joystick/iforce/iforce-main.c	2005-10-10 20:54:29.000000000 +0200
+++ linux-2.6.13.4-ff/drivers/input/joystick/iforce/iforce-main.c	2005-10-24 18:38:45.000000000 +0200
@@ -79,6 +79,7 @@ static struct iforce_device iforce_devic
 	{ 0x06f8, 0x0001, "Guillemot Race Leader Force Feedback",	btn_wheel, abs_wheel, ff_iforce }, //?
 	{ 0x06f8, 0x0004, "Guillemot Force Feedback Racing Wheel",	btn_wheel, abs_wheel, ff_iforce }, //?
 	{ 0x06f8, 0x0004, "Gullemot Jet Leader 3D",			btn_joystick, abs_joystick, ff_iforce }, //?
+	{ 0x06b6, 0x0001, "LMP Destiny Force Feedback Wheel",           btn_wheel, abs_wheel, ff_iforce },
 	{ 0x0000, 0x0000, "Unknown I-Force Device [%04x:%04x]",		btn_joystick, abs_joystick, ff_iforce }
 };
 
diff -uprN -X linux-2.6.13.4-vanilla/Documentation/dontdiff linux-2.6.13.4-vanilla/drivers/input/joystick/iforce/iforce-usb.c linux-2.6.13.4-ff/drivers/input/joystick/iforce/iforce-usb.c
--- linux-2.6.13.4-vanilla/drivers/input/joystick/iforce/iforce-usb.c	2005-10-10 20:54:29.000000000 +0200
+++ linux-2.6.13.4-ff/drivers/input/joystick/iforce/iforce-usb.c	2005-10-24 18:39:29.000000000 +0200
@@ -230,6 +230,7 @@ static struct usb_device_id iforce_usb_i
 	{ USB_DEVICE(0x06f8, 0x0001) },		/* Guillemot Race Leader Force Feedback */
 	{ USB_DEVICE(0x06f8, 0x0004) },		/* Guillemot Force Feedback Racing Wheel */
 	{ USB_DEVICE(0x06f8, 0xa302) },		/* Guillemot Jet Leader 3D */
+	{ USB_DEVICE(0x06b6, 0x0001) },         /* LMP Destiny Force Feedback Wheel */
 	{ }					/* Terminating entry */
 };
 

--------------080308020703090006020201--
