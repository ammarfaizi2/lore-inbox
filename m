Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264797AbSKNIbY>; Thu, 14 Nov 2002 03:31:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264798AbSKNIbY>; Thu, 14 Nov 2002 03:31:24 -0500
Received: from fmr05.intel.com ([134.134.136.6]:30677 "EHLO
	hermes.jf.intel.com") by vger.kernel.org with ESMTP
	id <S264797AbSKNIbX>; Thu, 14 Nov 2002 03:31:23 -0500
Message-ID: <957BD1C2BF3CD411B6C500A0C944CA2601AA1298@pdsmsx32.pd.intel.com>
From: "Zhuang, Louis" <louis.zhuang@intel.com>
To: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: [PATCH] 2.5.47: Fix e100 driver bug on STL2 motherboard -- 'e100:
	 hw init failed'
Date: Thu, 14 Nov 2002 16:36:11 +0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="gb2312"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It seems e100 device on STL2 board is slower than other siblings. 

Regards,
Louis Zhuang, 
My opinions are my own and NEVER the opinions of Intel Corporation.

diff -Nur -X /root/dontdiff 47-kp/drivers/net/e100/e100.h
47-kp-fi/drivers/net/e100/e100.h
--- 47-kp/drivers/net/e100/e100.h       Mon Nov 11 11:28:07 2002
+++ 47-kp-fi/drivers/net/e100/e100.h    Thu Nov 14 15:57:08 2002
@@ -100,7 +100,7 @@

 #define E100_MAX_NIC 16

-#define E100_MAX_SCB_WAIT      100     /* Max udelays in wait_scb */
+#define E100_MAX_SCB_WAIT      5000    /* Max udelays in wait_scb */
 #define E100_MAX_CU_IDLE_WAIT  50      /* Max udelays in wait_cus_idle */

 /* HWI feature related constant */
