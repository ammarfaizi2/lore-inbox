Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965064AbVKAIVM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965064AbVKAIVM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Nov 2005 03:21:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964984AbVKAIPo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Nov 2005 03:15:44 -0500
Received: from hulk.hostingexpert.com ([69.57.134.39]:11072 "EHLO
	hulk.hostingexpert.com") by vger.kernel.org with ESMTP
	id S964981AbVKAIPb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Nov 2005 03:15:31 -0500
Message-ID: <436723FF.4030803@m1k.net>
Date: Tue, 01 Nov 2005 03:14:55 -0500
From: Michael Krufky <mkrufky@m1k.net>
User-Agent: Debian Thunderbird 1.0.2 (X11/20050602)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org, linux-dvb-maintainer@linuxtv.org
Subject: [PATCH 22/37] dvb: Updated Documentation
Content-Type: multipart/mixed;
 boundary="------------040706080605050502010407"
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - hulk.hostingexpert.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - m1k.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------040706080605050502010407
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit




--------------040706080605050502010407
Content-Type: text/x-patch;
 name="2392.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="2392.patch"

From: Manu Abraham <manu@linuxtv.org>

Updated Documentation

Signed-off-by: Manu Abraham <manu@linuxtv.org>
Signed-off-by: Michael Krufky <mkrufky@m1k.net>

 Documentation/dvb/bt8xx.txt |   43 +++++++++++++++++++++++++++++++++++++++----
 1 file changed, 39 insertions(+), 4 deletions(-)

--- linux-2.6.14-git3.orig/Documentation/dvb/bt8xx.txt
+++ linux-2.6.14-git3/Documentation/dvb/bt8xx.txt
@@ -33,20 +33,23 @@
 --------------------------
 
    $ modprobe bttv (normally bttv is being loaded automatically by kmod)
-   $ modprobe dvb-bt8xx (or just place dvb-bt8xx in /etc/modules for automatic loading)
+   $ modprobe dvb-bt8xx
+
+(or just place dvb-bt8xx in /etc/modules for automatic loading)
 
 
 3b) TwinHan and Clones
 --------------------------
 
-   $ modprobe bttv i2c_hw=1 card=0x71
+   $ modprobe bttv card=0x71
    $ modprobe dvb-bt8xx
    $ modprobe dst
 
 The value 0x71 will override the PCI type detection for dvb-bt8xx,
-which  is necessary for TwinHan cards.
+which  is necessary for TwinHan cards. Omission of this parameter might result
+in a system lockup.
 
-If you're having an older card (blue color circuit) and card=0x71 locks
+If you're having an older card (blue color PCB) and card=0x71 locks up
 your machine, try using 0x68, too. If that does not work, ask on the
 mailing list.
 
@@ -69,6 +72,38 @@
 
 dst_get_device_id: Recognise [DSTMCI]
 
+If you need to sent in bug reports on the dst, please do send in a complete
+log with the verbose=4 module parameter. For general usage, the default setting
+of verbose=1 is ideal.
+
+
+4) Multiple cards
+--------------------------
+
+If you happen to be running multiple cards, it would be advisable to load
+the bttv module with the card id. This would help to solve any module loading
+problems that you might face.
+
+for example, if you happen to have a Twinhan and clones alongwith a FusionHDTV5
+card
+
+	$ modprobe bttv card=0x71 card=0x87
+
+Here the order of the card id is important and should be the same as that of the
+physical order of the cards. Here card=0x71 represents the Twinhan and clones
+and card=0x87 represents Fusion HDTV5.
+
+Some examples of card-id's
+
+Pinnacle Sat		0x5e
+Nebula Digi TV		0x68
+PC HDTV			0x70
+Twinhan			0x71
+Fusion HDTV5		0x87
+
+For a full list of card-id's, you can see the exported card-id's from
+bttv-cards.c in linux-2.6.x/drivers/media/video/bttv.h
+If you have problems with this please do ask on the mailing list.
 
 --
 Authors: Richard Walker, Jamie Honan, Michael Hunold, Manu Abraham



--------------040706080605050502010407--
