Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316864AbSE3VDF>; Thu, 30 May 2002 17:03:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316865AbSE3VDE>; Thu, 30 May 2002 17:03:04 -0400
Received: from smtp2.libero.it ([193.70.192.52]:40933 "EHLO smtp2.libero.it")
	by vger.kernel.org with ESMTP id <S316864AbSE3VDD>;
	Thu, 30 May 2002 17:03:03 -0400
Date: Thu, 30 May 2002 23:03:06 +0200
From: Angelo Archie Amoruso <aamoruso@libero.it>
To: linux-kernel@vger.kernel.org
Subject: 3c59x.c Linux driver patch
Message-Id: <20020530230306.7a2caa09.aamoruso@libero.it>
Organization: Archie Dynodns
X-Mailer: Sylpheed version 0.7.6claws (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All

I'm sending you a diff file for a patch to the Linux
3c59x.c driver (from the 2.4.18 vanilla source tree), 
in order to support some strange 3C905-B
cards which map themselves on PCI device 00B7:9055.

Here come's the diff output:
============================

--- 3c59x.c.old Thu May 23 18:22:47 2002
+++ 3c59x.c     Thu May 23 21:23:14 2002
@@ -166,6 +166,10 @@
     - Rename wait_for_completion() to issue_and_wait() to avoid completion.h
       clash.

+    LK1.1.17 23 May 2002 Angelo Archie Amoruso (aamoruso@libero.it)
+    - Added entry on the vortex_pci_tbl[] in order to support 3c905b cards
+      which map to PCI device 00B7:9055
+
     - See http://www.uow.edu.au/~andrewm/linux/#3c59x-2.3 for more details.
     - Also see Documentation/networking/vortex.txt
 */
@@ -181,8 +185,8 @@


 #define DRV_NAME       "3c59x"
-#define DRV_VERSION    "LK1.1.16"
-#define DRV_RELDATE    "19 July 2001"
+#define DRV_VERSION    "LK1.1.17"
+#define DRV_RELDATE    "22 May 2002"



@@ -554,6 +558,7 @@
        { 0x10B7, 0x9050, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CH_3C905_1 },
        { 0x10B7, 0x9051, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CH_3C905_2 },
        { 0x10B7, 0x9055, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CH_3C905B_1 },
+        { 0x00B7, 0x9055, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CH_3C905B_1 },

        { 0x10B7, 0x9058, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CH_3C905B_2 },
        { 0x10B7, 0x905A, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CH_3C905B_FX },


-- 

       /|
      /=|rchie 


