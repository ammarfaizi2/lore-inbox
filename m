Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314274AbSDVQyb>; Mon, 22 Apr 2002 12:54:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314275AbSDVQya>; Mon, 22 Apr 2002 12:54:30 -0400
Received: from mailout05.sul.t-online.com ([194.25.134.82]:40107 "EHLO
	mailout05.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S314274AbSDVQy2>; Mon, 22 Apr 2002 12:54:28 -0400
Date: Mon, 22 Apr 2002 18:16:51 +0200
From: Gert Menke <gert@menke.za.net>
To: mdharm-usb@one-eyed-alien.net
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] GL641USB based CF-Reader
Message-ID: <20020422161651.GA7150@DeepThought.mydomain>
Mail-Followup-To: mdharm-usb@one-eyed-alien.net,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="wac7ysb48OaltWcw"
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--wac7ysb48OaltWcw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi!

I spent some time today to find this patch, and I would really like to see
it go into one of the next 2.4 kernels. Since it is quite trivial, I hope
that should not be a problem, right?

I changed the description fields for vendor and model because it seems to
work for different devices from different vendors.

It works with my "PQI TravelFlash Single Slot" CF Card reader.

Thank you!

Greetings
Gert

--wac7ysb48OaltWcw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="linux-2.4.18-GL641USB.patch"

diff -r -u3 linux-2.4.18-orig/drivers/usb/storage/unusual_devs.h linux-2.4.18-patched/drivers/usb/storage/unusual_devs.h
--- linux-2.4.18-orig/drivers/usb/storage/unusual_devs.h	Mon Feb 25 20:38:07 2002
+++ linux-2.4.18-patched/drivers/usb/storage/unusual_devs.h	Mon Apr 22 17:37:35 2002
@@ -292,6 +292,12 @@
 		US_FL_MODE_XLATE | US_FL_START_STOP ),
 #endif
 
+UNUSUAL_DEV(  0x05e3, 0x0700, 0x0000, 0x9999,
+               "Unknown",
+		"GL641USB based CF Card reader",
+		US_SC_SCSI, US_PR_BULK, NULL,
+		US_FL_FIX_INQUIRY | US_FL_MODE_XLATE),
+
 UNUSUAL_DEV(  0x0644, 0x0000, 0x0100, 0x0100, 
 		"TEAC",
 		"Floppy Drive",

--wac7ysb48OaltWcw--
