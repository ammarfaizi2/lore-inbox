Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932154AbWH2HOt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932154AbWH2HOt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Aug 2006 03:14:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932159AbWH2HOs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Aug 2006 03:14:48 -0400
Received: from mx02.qsc.de ([213.148.130.14]:12747 "EHLO mx02.qsc.de")
	by vger.kernel.org with ESMTP id S932154AbWH2HOr convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Aug 2006 03:14:47 -0400
From: Rene Rebe <rene@exactcode.de>
Organization: ExactCODE
To: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
Subject: [PATCH] unusual device Sony Ericsson M600i
Date: Tue, 29 Aug 2006 09:13:13 +0200
User-Agent: KMail/1.9.3
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200608290913.13875.rene@exactcode.de>
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
X-Spam-Score: -1.4 (-)
X-Spam-Report: Spam detection software, running on the system "grum.localhost", has
	identified this incoming email as possible spam.  The original message
	has been attached to this so you can view it (if it isn't spam) or label
	similar future email.  If you have any questions, see
	the administrator of that system for details.
	Content preview:  Hi, the Sony Ericsson M600i needs some overwrites to be
	accessed properly: --- git/drivers/usb/storage/unusual_devs.h.vanilla
	2006-08-29 09:02:39.000000000 +0200 +++
	git/drivers/usb/storage/unusual_devs.h 2006-08-29 09:03:22.000000000
	+0200 @@ -1257,6 +1257,13 @@ US_SC_DEVICE, US_PR_DEVICE, NULL,
	US_FL_NO_WP_DETECT ), [...] 
	Content analysis details:   (-1.4 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	-1.4 ALL_TRUSTED            Passed through trusted hosts only via SMTP
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

the Sony Ericsson M600i needs some overwrites to be accessed properly:

--- git/drivers/usb/storage/unusual_devs.h.vanilla	2006-08-29 09:02:39.000000000 +0200
+++ git/drivers/usb/storage/unusual_devs.h	2006-08-29 09:03:22.000000000 +0200
@@ -1257,6 +1257,13 @@
 		US_SC_DEVICE, US_PR_DEVICE, NULL,
 		US_FL_NO_WP_DETECT ),
 
+/* Reported by Rene Rebe <rene@exactcode.de> */
+UNUSUAL_DEV(  0x0fce, 0xe031, 0x0000, 0xffff,
+		"Sony Ericsson Mobile Communications",
+		"M600i",
+		US_SC_DEVICE, US_PR_DEVICE, NULL,
+		US_FL_IGNORE_RESIDUE | US_FL_FIX_CAPACITY ),
+
 /* Reported by Kevin Cernekee <kpc-usbdev@gelato.uiuc.edu>
  * Tested on hardware version 1.10.
  * Entry is needed only for the initializer function override.

Best regards,

-- 
René Rebe - ExactCODE - Berlin (Europe / Germany)
            http://exactcode.de | http://t2-project.org | http://rene.rebe.name
            +49 (0)30 / 255 897 45
