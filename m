Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313985AbSDKFRO>; Thu, 11 Apr 2002 01:17:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313988AbSDKFRN>; Thu, 11 Apr 2002 01:17:13 -0400
Received: from [210.77.38.126] ([210.77.38.126]:27401 "EHLO
	ns.turbolinux.com.cn") by vger.kernel.org with ESMTP
	id <S313985AbSDKFRM>; Thu, 11 Apr 2002 01:17:12 -0400
Message-ID: <3CB51B07.2080505@turbolinux.com.cn>
Date: Thu, 11 Apr 2002 13:11:35 +0800
From: Wang Jun <junw@turbolinux.com.cn>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.4) Gecko/20011011
X-Accept-Language: en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [PATCH] Intel ICH4 for 2.4.18
Content-Type: multipart/mixed;
 boundary="------------040506070202090201020705"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------040506070202090201020705
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

I made a patch for add Intel ICH4 support for linux 2.4.18

-- 
Turbolinux Inc.,China
R & D Team Programmer
Wang Jun
Tel: +8610 65054020 Ext. 205
Mail: junw@turbolinux.com.cn


--------------040506070202090201020705
Content-Type: text/plain;
 name="linux-2.4.18-ICH4.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="linux-2.4.18-ICH4.patch"

diff -urN linux/drivers/sound/i810_audio.c linux.new/drivers/sound/i810_audio.c
--- linux/drivers/sound/i810_audio.c	Wed Apr 10 16:04:55 2002
+++ linux.new/drivers/sound/i810_audio.c	Wed Apr 10 16:06:22 2002
@@ -101,6 +101,9 @@
 #ifndef PCI_DEVICE_ID_INTEL_ICH3
 #define PCI_DEVICE_ID_INTEL_ICH3	0x2485
 #endif
+#ifndef PCI_DEVICE_ID_INTEL_ICH4
+#define PCI_DEVICE_ID_INTEL_ICH4	0x24c5
+#endif
 #ifndef PCI_DEVICE_ID_INTEL_440MX
 #define PCI_DEVICE_ID_INTEL_440MX	0x7195
 #endif
@@ -233,6 +236,7 @@
 	INTEL440MX,
 	INTELICH2,
 	INTELICH3,
+	INTELICH4,
 	SI7012,
 	NVIDIA_NFORCE,
 	AMD768
@@ -244,6 +248,7 @@
 	"Intel 440MX",
 	"Intel ICH2",
 	"Intel ICH3",
+	"Intel ICH4",
 	"SiS 7012",
 	"NVIDIA nForce Audio",
 	"AMD 768"
@@ -260,6 +265,8 @@
 	 PCI_ANY_ID, PCI_ANY_ID, 0, 0, INTELICH2},
 	{PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_ICH3,
 	 PCI_ANY_ID, PCI_ANY_ID, 0, 0, INTELICH3},
+	{PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_ICH4,
+	 PCI_ANY_ID, PCI_ANY_ID, 0, 0, INTELICH4},
 	{PCI_VENDOR_ID_SI, PCI_DEVICE_ID_SI_7012,
 	 PCI_ANY_ID, PCI_ANY_ID, 0, 0, SI7012},
 	{PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_MCP1_AUDIO,

--------------040506070202090201020705--

