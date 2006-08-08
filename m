Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932445AbWHHAJb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932445AbWHHAJb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Aug 2006 20:09:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932450AbWHHAJb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Aug 2006 20:09:31 -0400
Received: from tango.0pointer.de ([217.160.223.3]:39940 "EHLO
	tango.0pointer.de") by vger.kernel.org with ESMTP id S932445AbWHHAJa
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Aug 2006 20:09:30 -0400
Date: Tue, 8 Aug 2006 02:09:25 +0200
From: Lennart Poettering <mzxreary@0pointer.de>
To: dtor_core@ameritech.net
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] input: A few new KEY_xxx definitions
Message-ID: <20060808000925.GA6220@curacao>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Organization: .phi.
X-Campaign-1: ()  ASCII Ribbon Campaign
X-Campaign-2: /  Against HTML Email & vCards - Against Microsoft Attachments
X-Disclaimer-1: Diese Nachricht wurde mit einer elektronischen 
X-Disclaimer-2: Datenverarbeitungsanlage erstellt und bedarf daher 
X-Disclaimer-3: keiner Unterschrift.
User-Agent: Leviathan/19.8.0 [zh] (Cray 3; I; Solaris 4.711; Console)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lennart Poettering <mzxreary@0pointer.de>

The attached patch adds four new KEY_xxx definitions to linux/input.h.

KEY_BLUETOOTH, KEY_WLAN:

    Some laptops have seperate "rfkill"
    buttons for disabling/enabling Bluetooth and WLAN. 

KEY_POWERPLUG, KEY_POWERUNPLUG:

    Some laptops generate a fake key event when the power cord is
    plugged or unplugged. (Notably MSI laptops, such as S270)

Applies to all recent 2.6 kernels.
             
Please merge,
       Lennart

Signed-off-by: Lennart Poettering <mzxreary@0pointer.de>
---

--- include/linux/input.h.orig	2006-08-08 01:25:52.000000000 +0200
+++ include/linux/input.h	2006-08-08 01:43:13.000000000 +0200
@@ -347,8 +347,14 @@ struct input_absinfo {
 
 #define KEY_BATTERY		236
 
+#define KEY_BLUETOOTH		237
+#define KEY_WLAN		238
+
 #define KEY_UNKNOWN		240
 
+#define KEY_POWERPLUG		239
+#define KEY_POWERUNPLUG		241
+
 #define BTN_MISC		0x100
 #define BTN_0			0x100
 #define BTN_1			0x101
