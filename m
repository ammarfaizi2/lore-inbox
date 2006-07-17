Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750823AbWGQPBg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750823AbWGQPBg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Jul 2006 11:01:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750826AbWGQPBg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Jul 2006 11:01:36 -0400
Received: from outbound-kan.frontbridge.com ([63.161.60.23]:27213 "EHLO
	outbound2-kan-R.bigfish.com") by vger.kernel.org with ESMTP
	id S1750823AbWGQPBf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Jul 2006 11:01:35 -0400
X-BigFish: V
X-Server-Uuid: 8C3DB987-180B-4465-9446-45C15473FD3E
Message-ID: <44BBA881.3070700@amd.com>
Date: Mon, 17 Jul 2006 09:10:57 -0600
From: "William Morrow" <William.Morrow@amd.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3)
 Gecko/20041020
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: mdharm-usb@one-eyed-alien.net
cc: linux-kernel@vger.kernel.org, trivial@kernel.org
Subject: patch: extend device_id range to cover new sony camera (
 dsc-w70)
X-OriginalArrivalTime: 17 Jul 2006 14:59:47.0417 (UTC)
 FILETIME=[A54C1490:01C6A9B1]
X-WSS-ID: 68A57A691LW74198-01-01
Content-Type: text/plain;
 charset=iso-8859-1;
 format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

product reports 2 configs.  This change enables usb-storage config 
(other is "still").
I could not test this patch well since I am the only one I know with the 
product.
Almost no risk.  You may have to buy a new camera just to be sure  ;-)

morrow

diff -ur linux-2.6.17.6.orig/drivers/usb/storage/unusual_devs.h 
linux-2.6.17.6/drivers/usb/storage/unusual_devs.h
--- linux-2.6.17.6.orig/drivers/usb/storage/unusual_devs.h      
2006-07-15 13:00:43.000000000 -0600
+++ linux-2.6.17.6/drivers/usb/storage/unusual_devs.h   2006-07-17 
08:36:28.000000000 -0600
@@ -460,9 +460,9 @@
                US_FL_SINGLE_LUN | US_FL_NOT_LOCKABLE | 
US_FL_NO_WP_DETECT ),
 
 /* This entry is needed because the device reports Sub=ff */
-UNUSUAL_DEV(  0x054c, 0x0010, 0x0500, 0x0600,
+UNUSUAL_DEV(  0x054c, 0x0010, 0x0500, 0x0610,
                "Sony",
-               "DSC-T1/T5",
+               "DSC-T1/T5/W70",
                US_SC_8070, US_PR_DEVICE, NULL,
                US_FL_SINGLE_LUN ),
 



