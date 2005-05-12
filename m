Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261922AbVELNIM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261922AbVELNIM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 May 2005 09:08:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261931AbVELNIL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 May 2005 09:08:11 -0400
Received: from hulk.hostingexpert.com ([69.57.134.39]:52807 "EHLO
	hulk.hostingexpert.com") by vger.kernel.org with ESMTP
	id S261922AbVELNH5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 May 2005 09:07:57 -0400
Message-ID: <4283552F.6050003@m1k.net>
Date: Thu, 12 May 2005 09:07:59 -0400
From: Michael Krufky <mkrufky@m1k.net>
Reply-To: mkrufky@m1k.net
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, video4linux-list@redhat.com
CC: kraxel@bytesex.org, akpm@osdl.org
Subject: Patch for cx88-cards.c for DVICO-FusionHDTV 3 GOLD Q
Content-Type: multipart/mixed;
 boundary="------------080707090309090800080000"
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - hulk.hostingexpert.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - m1k.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------080707090309090800080000
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hello,

I haven't submitted a kernel patch before, so please forgive me if this 
isn't the proper protocol.  I have the DVICO-FusionHDTV 3 GOLD Q, and I 
got it to autodetect and tune into some NTSC cable channels (in 
less-than perfect quality) after making the following change:

--- a/cx88-cards.c    2005-05-10 19:30:47.000000000 -0400
+++ b/cx88-cards.c    2005-05-11 21:09:26.000000000 -0400
@@ -524,6 +524,10 @@
         .subdevice = 0xd810,
         .card      = CX88_BOARD_DVICO_FUSIONHDTV_3_GOLD,
     },{
+        .subvendor = 0x18ac,
+        .subdevice = 0xd820,
+        .card      = CX88_BOARD_DVICO_FUSIONHDTV_3_GOLD,
+    },{
         .subvendor = 0x18AC,
         .subdevice = 0xDB00,
         .card      = CX88_BOARD_DVICO_FUSIONHDTV_DVB_T1,

I've been told that the whitespace gets mangled in the body of the 
email, so I've included the .diff as an email attachment as well.  
Please incorporate this into the next version of the driver.

Thank you,

Michael Krufky
mkrufky@m1k.net


--------------080707090309090800080000
Content-Type: text/plain;
 name="cx88-cards.c.FusionHDTV3GoldQ.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="cx88-cards.c.FusionHDTV3GoldQ.diff"

--- a/cx88-cards.c	2005-05-10 19:30:47.000000000 -0400
+++ b/cx88-cards.c	2005-05-11 21:09:26.000000000 -0400
@@ -524,6 +524,10 @@
 		.subdevice = 0xd810,
 		.card      = CX88_BOARD_DVICO_FUSIONHDTV_3_GOLD,
 	},{
+		.subvendor = 0x18ac,
+		.subdevice = 0xd820,
+		.card      = CX88_BOARD_DVICO_FUSIONHDTV_3_GOLD,
+	},{
 		.subvendor = 0x18AC,
 		.subdevice = 0xDB00,
 		.card      = CX88_BOARD_DVICO_FUSIONHDTV_DVB_T1,

--------------080707090309090800080000--
