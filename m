Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313150AbSC1NOJ>; Thu, 28 Mar 2002 08:14:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313151AbSC1NN7>; Thu, 28 Mar 2002 08:13:59 -0500
Received: from plintus.lcm.msu.ru ([193.232.113.219]:10254 "EHLO
	plintus.lcm.msu.ru") by vger.kernel.org with ESMTP
	id <S313150AbSC1NNn>; Thu, 28 Mar 2002 08:13:43 -0500
Message-Id: <200203281313.g2SDDdB16981@gw.dorms.msu.ru>
Content-Type: text/plain; charset=US-ASCII
From: "Alexander V. Inyukhin" <shurick@pisem.net>
Reply-To: shurick@pisem.net
Organization: MSU
To: linux-kernel@vger.kernel.org
Subject: [PATCH] IBM USB Memory Key support
Date: Thu, 28 Mar 2002 16:16:56 +0300
X-Mailer: KMail [version 1.3.1]
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patch against 2.4.18 for IBM USB Memory Key support.

--- linux-2.4.18/drivers/usb/storage/unusual_devs.h	Thu Mar 28 16:14:22 2002
+++ linux/drivers/usb/storage/unusual_devs.h	Thu Mar 28 16:03:46 2002
@@ -451,6 +451,12 @@
  		US_SC_SCSI, US_PR_CB, NULL,
 		US_FL_MODE_XLATE ),
 
+UNUSUAL_DEV(  0x0a16, 0x8888, 0x0100, 0x0100,
+		"IBM",
+		"IBM USB Memory Key",
+		US_SC_SCSI, US_PR_BULK, NULL,
+		US_FL_FIX_INQUIRY ),
+		
 #ifdef CONFIG_USB_STORAGE_ISD200
 UNUSUAL_DEV(  0x0bf6, 0xa001, 0x0100, 0x0110,
                 "ATI",
