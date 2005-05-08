Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262926AbVEHUYR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262926AbVEHUYR (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 May 2005 16:24:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262927AbVEHUWs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 May 2005 16:22:48 -0400
Received: from ipx10786.ipxserver.de ([80.190.251.108]:64150 "EHLO
	allen.werkleitz.de") by vger.kernel.org with ESMTP id S262926AbVEHTKA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 May 2005 15:10:00 -0400
Message-Id: <20050508184348.750265000@abc>
References: <20050508184229.957247000@abc>
Date: Sun, 08 May 2005 20:42:56 +0200
From: Johannes Stezenbach <js@linuxtv.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Content-Disposition: inline; filename=dvb-bt8xx-doc.patch
X-SA-Exim-Connect-IP: 217.231.45.168
Subject: [DVB patch 27/37] bt8xx: update documentation
X-SA-Exim-Version: 4.2 (built Thu, 03 Mar 2005 10:44:12 +0100)
X-SA-Exim-Scanned: Yes (on allen.werkleitz.de)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

update bt8xx documentation (Uwe Bugla)

Signed-off-by: Johannes Stezenbach <js@linuxtv.org>
---

 Documentation/dvb/bt8xx.txt |   29 +++++++++--------------------
 1 files changed, 9 insertions(+), 20 deletions(-)

Index: linux-2.6.12-rc4/Documentation/dvb/bt8xx.txt
===================================================================
--- linux-2.6.12-rc4.orig/Documentation/dvb/bt8xx.txt	2005-05-08 18:09:01.000000000 +0200
+++ linux-2.6.12-rc4/Documentation/dvb/bt8xx.txt	2005-05-08 18:13:24.000000000 +0200
@@ -17,34 +17,23 @@ Because of this, you need to enable
 "Device drivers" => "Multimedia devices"
   => "Video For Linux" => "BT848 Video For Linux"
 
+Furthermore you need to enable
+"Device drivers" => "Multimedia devices" => "Digital Video Broadcasting Devices"
+  => "DVB for Linux" "DVB Core Support" "Nebula/Pinnacle PCTV/TwinHan PCI Cards"
+
 2) Loading Modules
 ==================
 
 In general you need to load the bttv driver, which will handle the gpio and
-i2c communication for us. Next you need the common dvb-bt8xx device driver
-and one frontend driver.
-
-The bttv driver will HANG YOUR SYSTEM IF YOU DO NOT SPECIFY THE CORRECT 
-CARD ID!
-
-(If you don't get your card running and you suspect that the card id you're
-using is wrong, have a look at "bttv-cards.c" for a list of possible card
-ids.)
-
-Pay attention to failures when you load the frontend drivers
-(e.g. dmesg, /var/log/messages).
+i2c communication for us, plus the common dvb-bt8xx device driver.
+The frontends for Nebula (nxt6000), Pinnacle PCTV (cx24110) and
+TwinHan (dst) are loaded automatically by the dvb-bt8xx device driver.
 
 3a) Nebula / Pinnacle PCTV
 --------------------------
 
-   $ modprobe bttv i2c_hw=1 card=0x68
-   $ modprobe dvb-bt8xx
-   
-For Nebula cards use the "nxt6000" frontend driver:
-   $ modprobe nxt6000
-
-For Pinnacle PCTV cards use the "cx24110" frontend driver:
-   $ modprobe cx24110
+   $ modprobe bttv (normally bttv is being loaded automatically by kmod)
+   $ modprobe dvb-bt8xx (or just place dvb-bt8xx in /etc/modules for automatic loading)
 
 3b) TwinHan
 -----------

--

