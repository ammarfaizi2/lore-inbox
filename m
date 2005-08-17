Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751282AbVHQVSE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751282AbVHQVSE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Aug 2005 17:18:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751285AbVHQVSD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Aug 2005 17:18:03 -0400
Received: from kirby.webscope.com ([204.141.84.57]:49282 "EHLO
	kirby.webscope.com") by vger.kernel.org with ESMTP id S1751282AbVHQVSB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Aug 2005 17:18:01 -0400
Message-ID: <4303A958.4010208@m1k.net>
Date: Wed, 17 Aug 2005 17:17:12 -0400
From: Michael Krufky <mkrufky@m1k.net>
Reply-To: mkrufky@m1k.net
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-dvb-maintainer@linuxtv.org,
       linux-kernel <linux-kernel@vger.kernel.org>,
       patrick.keane@btinternet.com, mkrufky@linuxtv.org
Subject: [PATCH] DVB: Clarify description text for dvb-bt8xx in Kconfig
Content-Type: multipart/mixed;
 boundary="------------080105090000090501030903"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------080105090000090501030903
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Sorry for sending this twice... The first time I cc'd the wrong email 
address for LKML...

Patrick Keene wrote to the linux-dvb list, asking where in menuconfig he 
can enable dvb-bt8xx for his AVerMedia DVB card.  I pointed the 
following out to him:

config DVB_BT8XX
       tristate "Nebula/Pinnacle PCTV/Twinhan PCI cards"

It has been agreed upon that this description is extremely misleading.

This patch changes the one-liner description text of dvb-bt8xx to 
something more meaningful, and adds AVerMedia to the detailed description.

Signed-off-by: Michael Krufky <mkrufky@m1k.net>



--------------080105090000090501030903
Content-Type: text/plain;
 name="kconfig-dvb-bt8xx.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="kconfig-dvb-bt8xx.patch"

 linux/drivers/media/dvb/bt8xx/Kconfig |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff -u linux-2.6.13-rc6-git8/drivers/media/dvb/bt8xx/Kconfig linux/drivers/media/dvb/bt8xx/Kconfig
--- linux-2.6.13-rc6-git8/drivers/media/dvb/bt8xx/Kconfig	2005-06-17 19:48:29.000000000 +0000
+++ linux/drivers/media/dvb/bt8xx/Kconfig	2005-08-17 00:34:57.000000000 +0000
@@ -1,5 +1,5 @@
 config DVB_BT8XX
-	tristate "Nebula/Pinnacle PCTV/Twinhan PCI cards"
+	tristate "BT8xx based PCI cards"
 	depends on DVB_CORE && PCI && VIDEO_BT848
 	select DVB_MT352
 	select DVB_SP887X
@@ -8,8 +8,8 @@
 	select DVB_OR51211
 	help
 	  Support for PCI cards based on the Bt8xx PCI bridge. Examples are
-	  the Nebula cards, the Pinnacle PCTV cards, the Twinhan DST cards and
-	  pcHDTV HD2000 cards.
+	  the Nebula cards, the Pinnacle PCTV cards, the Twinhan DST cards,
+	  the pcHDTV HD2000 cards, and certain AVerMedia cards.
 
 	  Since these cards have no MPEG decoder onboard, they transmit
 	  only compressed MPEG data over the PCI bus, so you need

--------------080105090000090501030903--

