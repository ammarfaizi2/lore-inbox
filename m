Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314327AbSEBKYd>; Thu, 2 May 2002 06:24:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314329AbSEBKYc>; Thu, 2 May 2002 06:24:32 -0400
Received: from web10503.mail.yahoo.com ([216.136.130.153]:32320 "HELO
	web10503.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S314327AbSEBKYb>; Thu, 2 May 2002 06:24:31 -0400
Message-ID: <20020502102431.99924.qmail@web10503.mail.yahoo.com>
Date: Thu, 2 May 2002 03:24:31 -0700 (PDT)
From: "Nirranjan.K" <nirranjan@yahoo.com>
Subject: patch for 2.4.18 kernel to work with  grub0.91
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Grub0.91 does'nt work for kernel 2.4.18 if the root
file system is in raid disk, as it looks for below
entries.I have attached the kernel patch for working
of grub.Please contact for futher clarifications ,if
any.

 
Regards,

Nirranjan.K
CDC Linux,
Bangalore,
India.
--- linux-2.4.18/init/main.cTue Feb 26 01:08:13 2002
+++ linux-patch/init/main.cMon Apr 29 12:03:28 2002
@@ -185,6 +185,22 @@ static struct dev_name_struct {
 { "sdn",     0x08d0 },
 { "sdo",     0x08e0 },
 { "sdp",     0x08f0 },
+{ "rd/c0d0p",0x3000 },
+        { "rd/c0d1p",0x3008 },
+        { "rd/c0d2p",0x3010 },
+        { "rd/c0d3p",0x3018 },
+        { "rd/c0d4p",0x3020 },
+        { "rd/c0d5p",0x3028 },
+        { "rd/c0d6p",0x3030 },
+        { "rd/c0d7p",0x3038 },
+        { "rd/c0d8p",0x3040 },
+        { "rd/c0d9p",0x3048 },
+        { "rd/c0d10p",0x3050 },
+        { "rd/c0d11p",0x3058 },
+        { "rd/c0d12p",0x3060 },
+        { "rd/c0d13p",0x3068 },
+        { "rd/c0d14p",0x3070 },
+        { "rd/c0d15p",0x3078 },
 { "ada",     0x1c00 },
 { "adb",     0x1c10 },
 { "adc",     0x1c20 },





__________________________________________________
Do You Yahoo!?
Yahoo! Health - your guide to health and wellness
http://health.yahoo.com
