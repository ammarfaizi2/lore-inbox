Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261427AbTCEXGy>; Wed, 5 Mar 2003 18:06:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262821AbTCEXGy>; Wed, 5 Mar 2003 18:06:54 -0500
Received: from as1-4-7.bn.g.bonet.se ([194.236.61.89]:41604 "HELO cucumelo.org")
	by vger.kernel.org with SMTP id <S261427AbTCEXGx>;
	Wed, 5 Mar 2003 18:06:53 -0500
Message-ID: <3E66947F.4040800@hostmobility.com>
Date: Thu, 06 Mar 2003 01:21:19 +0100
From: Benny Sjostrand <benny@hostmobility.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20020918
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [PATCH] 2.4.20 Minolta F300, yet another unusual usb-storage device
 ID
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

i guess this one is easy, just adds another Vendor and Manufacturer ID 
for the usb-storage,  the Minolta F300 digital camera.

--- drivers/usb/storage/unusual_devs.h.orig     Thu Mar  6 01:15:56 2003
+++ drivers/usb/storage/unusual_devs.h  Thu Mar  6 01:16:01 2003
@@ -368,6 +368,12 @@
                US_SC_SCSI, US_PR_BULK, NULL,
                US_FL_START_STOP ),
 
+UNUSUAL_DEV( 0x0686, 0x4011, 0x0001, 0x0001,
+                "Minolta",
+                "Dimage F300",
+                US_SC_SCSI, US_PR_BULK, NULL,
+                US_FL_START_STOP ),
+
 UNUSUAL_DEV(  0x0693, 0x0002, 0x0100, 0x0100,
                "Hagiwara",
                "FlashGate SmartMedia",

