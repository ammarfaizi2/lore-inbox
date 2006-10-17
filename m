Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423155AbWJQGkl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423155AbWJQGkl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Oct 2006 02:40:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423154AbWJQGkl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Oct 2006 02:40:41 -0400
Received: from fmmailgate03.web.de ([217.72.192.234]:23284 "EHLO
	fmmailgate03.web.de") by vger.kernel.org with ESMTP
	id S1423152AbWJQGkk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Oct 2006 02:40:40 -0400
Subject: [PATCH] [RESEND]  Remove logic error in /Documentation/devices.txt
From: Marcus Fischer <marcus-fischer@web.de>
Reply-To: marcus-fischer@web.de
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Date: Tue, 17 Oct 2006 08:40:51 +0200
Message-Id: <1161067251.11179.1.camel@mflaptop>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.0-1mdv2007.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

commit 51f3fe947923f6e775031cc1d538de6cf06ec77d
Author: Marcus Fischer <linux@marcusfischer.com>
Date:   Fri Sep 29 23:50:01 2006 +0200

    I found an logic error in the following commit:
    
        author    Steven Haigh <netwiz@crc.id.au>
                  Tue, 8 Aug 2006 21:42:06 +0000 (07:42 +1000)
        committer Greg Kroah-Hartman <gregkh@suse.de>
                  Wed, 27 Sep 2006 18:58:59 +0000 (11:58 -0700)
        commit    03270634e242dd10cc8569d31a00659d25b2b8e7
        tree      8f4665eb7b17386e733fcdc7d02e87c4a1592550
        parent    8ac283ad415358f022498887811c35ac656b5222
    
Documentation/devices.txt may either say 
../adutux10 11th OntrackADU device    or 
../adutux9 10th Ontrack ADU device.

Anyway, the original one makes no sense.
   
+ 67 = /dev/usb/adutux0 1st Ontrak ADU device
+ ...
+ 76 = /dev/usb/adutux10 10th Ontrak ADU device

This patch removes the logic error.

However, I saw that MAX_DEVICES is 16.
Thus, shouldn't this docu then say:
"81 = /dev/usb/adutux15 16th Ontrack ADU device" ?

Best,
Marcus

PS: Please CC me, I'm not on this list.



Signed-off-by: Marcus Fischer <linux@marcusfischer.com>
---

diff --git a/Documentation/devices.txt b/Documentation/devices.txt
index addc67b..37efae8 100644
--- a/Documentation/devices.txt
+++ b/Documentation/devices.txt
@@ -2545,7 +2545,7 @@ Your cooperation is appreciated.
66 = /dev/usb/cpad0 Synaptics cPad (mouse/LCD)
67 = /dev/usb/adutux0 1st Ontrak ADU device
    ...
- 76 = /dev/usb/adutux10 10th Ontrak ADU device
+ 76 = /dev/usb/adutux9 10th Ontrak ADU device
96 = /dev/usb/hiddev0 1st USB HID device
    ...
111 = /dev/usb/hiddev15 16th USB HID device



