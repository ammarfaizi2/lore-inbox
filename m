Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313317AbSDYS5o>; Thu, 25 Apr 2002 14:57:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313319AbSDYS5o>; Thu, 25 Apr 2002 14:57:44 -0400
Received: from barrichello.cs.ucr.edu ([138.23.169.5]:20714 "HELO
	barrichello.cs.ucr.edu") by vger.kernel.org with SMTP
	id <S313317AbSDYS5n>; Thu, 25 Apr 2002 14:57:43 -0400
Date: Thu, 25 Apr 2002 11:57:38 -0700 (PDT)
From: John Tyner <jtyner@cs.ucr.edu>
To: <dwmw2@redhat.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: [PATCH] Add AM29F040B Support
Message-ID: <Pine.LNX.4.30.0204251151340.17102-100000@hill.cs.ucr.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-AntiVirus: scanned for viruses by AMaViS perl-6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Below is a patch that adds support for the AMD AM29F040B flash chip.
Hopefully, pine doesn't destory it.

diff -urN linux_2_4_devel/drivers/mtd/chips/jedec_probe.c linux-new/drivers/mtd/chips/jedec_probe.c
--- linux_2_4_devel/drivers/mtd/chips/jedec_probe.c     Wed Apr 24 10:49:08 2002
+++ linux-new/drivers/mtd/chips/jedec_probe.c   Tue Apr  9 15:43:38 2002
@@ -34,6 +34,7 @@
 #define AM29LV800BT    0x22DA
 #define AM29LV160DT    0x22C4
 #define AM29LV160DB    0x2249
+#define AM29F040B       0x00A4

 /* Atmel */
 #define AT49BV16X4     0x00c0
@@ -183,6 +184,15 @@
                          ERASEINFO(0x08000,1),
                          ERASEINFO(0x02000,2),
                          ERASEINFO(0x04000,1)
+               }
+       }, {
+               mfr_id: MANUFACTURER_AMD,
+               dev_id: AM29F040B,
+               name: "AMD AM29F040B",
+               DevSize: 19,
+               NumEraseRegions: 1,
+               regions: {
+                       ERASEINFO( 0x010000, 8 )
                }
        }, {
                mfr_id: MANUFACTURER_AMD,



