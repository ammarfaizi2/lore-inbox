Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270913AbRHNWpH>; Tue, 14 Aug 2001 18:45:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270912AbRHNWo5>; Tue, 14 Aug 2001 18:44:57 -0400
Received: from mailb.telia.com ([194.22.194.6]:14854 "EHLO mailb.telia.com")
	by vger.kernel.org with ESMTP id <S270907AbRHNWov>;
	Tue, 14 Aug 2001 18:44:51 -0400
Message-Id: <200108142242.AAA22621@mailb.telia.com>
Content-Type: text/plain;
  charset="iso-8859-1"
From: Roger Larsson <roger.larsson@norran.net>
To: linux-usb-users@lists.sourceforge.net,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Report: Sony Handycam USB and Linux 2.4.9-pre2
Date: Wed, 15 Aug 2001 00:37:50 +0200
X-Mailer: KMail [version 1.2.3]
In-Reply-To: <200108141108.f7EB8v612177@mailgate3.cinetic.de>
In-Reply-To: <200108141108.f7EB8v612177@mailgate3.cinetic.de>
Cc: "Klaus Mueller" <klmuell@web.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

[Note: I am not subscribed to linux-usb-users, please cc:]

I have a Sony PC110E that has been working with a small patch since 2.4.0
But with 2.4.9-pre2 it does not work anymore...

2.4.7 + my patch
		works

2.4.8
		has lots of new USB stuff (not tested by me, compilation problems)

2.4.9-pre2
		identifies the device correctly - no patch needed
		(similar patch in unusual-devices)
		but is not able to open it "unknown partition table" reported from
		enabled LDM ... (I enabled it in an attempt to enable everything)

I have usb-debug outputs from both - I will try to look into them myself but 
if anyone is interested...

/RogerL

-- 
Roger Larsson
Skellefteå
Sweden


*******************************************
Patch prepared by: roger.larsson@norran.net
 
--- linux/drivers/usb/storage/unusual_devs.h.orig       Mon May 14 23:32:36 
2001+++ linux/drivers/usb/storage/unusual_devs.h    Mon May 14 23:32:46 2001
@@ -138,6 +138,12 @@
                US_SC_UFI, US_PR_CB, NULL,
                US_FL_SINGLE_LUN | US_FL_START_STOP ),
 
+UNUSUAL_DEV(  0x054c, 0x002e, 0x0210, 0x0310,
+               "Sony",
+               "DSR-PC110E",
+               US_SC_SCSI, US_PR_CB, NULL,
+               US_FL_SINGLE_LUN | US_FL_START_STOP | US_FL_MODE_XLATE ),
+
 UNUSUAL_DEV(  0x057b, 0x0000, 0x0000, 0x0299,
                "Y-E Data",
                "Flashbuster-U",
