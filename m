Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262513AbTENQ1Q (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 May 2003 12:27:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262526AbTENQ1Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 May 2003 12:27:16 -0400
Received: from meryl.it.uu.se ([130.238.12.42]:25776 "EHLO meryl.it.uu.se")
	by vger.kernel.org with ESMTP id S262513AbTENQ1P (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 May 2003 12:27:15 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16066.29023.973080.985528@gargle.gargle.HOWL>
Date: Wed, 14 May 2003 18:39:59 +0200
From: mikpe@csd.uu.se
To: jgarzik@pobox.com
CC: linux-kernel@vger.kernel.org
Subject: 2.5.69: trivial tulip Kconfig correction
X-Mailer: VM 6.90 under Emacs 20.7.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

While there is a separate driver for 2104x tulips (CONFIG_DE2104X),
drivers/net/tulip/Kconfig states that CONFIG_TULIP also supports
2104x tulips. This is not the case since that support was removed
in December 2001. A user with an old tulip may thus be tricked into
configuring the wrong driver. (I was, on my PMac 4400.)

The patch below removes this misinformation from tulip's Kconfig.

/Mikael

--- linux-2.5.69/drivers/net/tulip/Kconfig.~1~	2003-05-05 22:56:29.000000000 +0200
+++ linux-2.5.69/drivers/net/tulip/Kconfig	2003-05-14 18:27:19.000000000 +0200
@@ -37,7 +37,7 @@
 	---help---
 	  This driver is developed for the SMC EtherPower series Ethernet
 	  cards and also works with cards based on the DECchip 
-	  21040/21041/21140 (Tulip series) chips.  Some LinkSys PCI cards are
+	  21140 (Tulip series) chips.  Some LinkSys PCI cards are
 	  of this type.  (If your card is NOT SMC EtherPower 10/100 PCI
 	  (smc9332dst), you can also try the driver for "Generic DECchip"
 	  cards, above.  However, most people with a network card of this type
