Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262762AbVEHUD6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262762AbVEHUD6 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 May 2005 16:03:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262965AbVEHUCT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 May 2005 16:02:19 -0400
Received: from ipx10786.ipxserver.de ([80.190.251.108]:2711 "EHLO
	allen.werkleitz.de") by vger.kernel.org with ESMTP id S262936AbVEHTKN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 May 2005 15:10:13 -0400
Message-Id: <20050508184349.607746000@abc>
References: <20050508184229.957247000@abc>
Date: Sun, 08 May 2005 20:43:02 +0200
From: Johannes Stezenbach <js@linuxtv.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Content-Disposition: inline; filename=dvb-bt8xx-readme.patch
X-SA-Exim-Connect-IP: 217.231.45.168
Subject: [DVB patch 33/37] bt8xx: updated documentation
X-SA-Exim-Version: 4.2 (built Thu, 03 Mar 2005 10:44:12 +0100)
X-SA-Exim-Scanned: Yes (on allen.werkleitz.de)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

updated documentation (Manu Abraham)

Signed-off-by: Johannes Stezenbach <js@linuxtv.org>
---

 Documentation/dvb/bt8xx.txt |   42 ++++++++++++++++--------------------------
 1 files changed, 16 insertions(+), 26 deletions(-)

Index: linux-2.6.12-rc4/Documentation/dvb/bt8xx.txt
===================================================================
--- linux-2.6.12-rc4.orig/Documentation/dvb/bt8xx.txt	2005-05-08 18:13:24.000000000 +0200
+++ linux-2.6.12-rc4/Documentation/dvb/bt8xx.txt	2005-05-08 18:13:58.000000000 +0200
@@ -35,45 +35,35 @@ TwinHan (dst) are loaded automatically b
    $ modprobe bttv (normally bttv is being loaded automatically by kmod)
    $ modprobe dvb-bt8xx (or just place dvb-bt8xx in /etc/modules for automatic loading)
 
-3b) TwinHan
------------
+
+3b) TwinHan and Clones
+--------------------------
 
    $ modprobe bttv i2c_hw=1 card=0x71
    $ modprobe dvb-bt8xx
    $ modprobe dst
 
-The value 0x71 will override the PCI type detection for dvb-bt8xx, which 
-is necessary for TwinHan cards.#
-
-If you're having an older card (blue color circuit) and card=0x71 locks your
-machine, try using 0x68, too. If that does not work, ask on the DVB mailing list.
+The value 0x71 will override the PCI type detection for dvb-bt8xx,
+which  is necessary for TwinHan cards.
 
-The DST module takes a couple of useful parameters, in case the
-dst drivers fails to detect your type of card correctly.
+If you're having an older card (blue color circuit) and card=0x71 locks
+your machine, try using 0x68, too. If that does not work, ask on the
+mailing list.
 
-dst_type takes values 0 (satellite), 1 (terrestial TV), 2 (cable).
+The DST module takes a couple of useful parameters.
 
-dst_type_flags takes bit combined values:
-1 = new tuner type packets. You can use this if your card is detected
-    and you have debug and you continually see the tuner packets not
-    working (make sure not a basic problem like dish alignment etc.)
+verbose takes values 0 to 5. These values control the verbosity level.
 
-2 = TS 204. If your card tunes OK, but the picture is terrible, seemingly
-    breaking up in one half continually, and crc fails a lot, then
-    this is worth a try (or trying to turn off)
+debug takes values 0 and 1. You can either disable or enable debugging.
 
-4 = has symdiv. Some cards, mostly without new tuner packets, require
-    a symbol division algorithm. Doesn't apply to terrestial TV.
+dst_addons takes values 0 and 0x20. A value of 0 means it is a FTA card.
+0x20 means it has a Conditional Access slot.
 
-You can also specify a value to have the autodetected values turned off
-(e.g. 0). The autodected values are determined bythe cards 'response
+The autodected values are determined bythe cards 'response
 string' which you can see in your logs e.g.
 
-dst_check_ci: recognize DST-MOT
-
-or 
+dst_get_device_id: Recognise [DSTMCI]
 
-dst_check_ci: unable to recognize DSTXCI or STXCI
 
 --
-Authors: Richard Walker, Jamie Honan, Michael Hunold
+Authors: Richard Walker, Jamie Honan, Michael Hunold, Manu Abraham

--

