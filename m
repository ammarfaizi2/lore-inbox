Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265280AbTL3WIu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Dec 2003 17:08:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265820AbTL3WGf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Dec 2003 17:06:35 -0500
Received: from mail.kroah.org ([65.200.24.183]:43969 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S265351AbTL3WGY convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Dec 2003 17:06:24 -0500
Subject: Re: [PATCH] i2c driver fixes for 2.6.0
In-Reply-To: <10728219713483@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Tue, 30 Dec 2003 14:06:11 -0800
Message-Id: <10728219711046@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1496.8.38, 2003/12/30 12:10:08-08:00, khali@linux-fr.org

[PATCH] I2C: Fix SCx200 dependancies

The following patch fixes incorrect dependencies (as far as I can see)
for the SCx200 modules. A similar patch (with even more fixes) is also
needed for Linux 2.4, and will be part of my next wave to Marcelo. Note
that I don't have the necessary hardware to actually test anything, but
a quick look at the code doesn't leave much place for doubt IMHO.


 drivers/i2c/busses/Kconfig |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)


diff -Nru a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
--- a/drivers/i2c/busses/Kconfig	Tue Dec 30 12:28:44 2003
+++ b/drivers/i2c/busses/Kconfig	Tue Dec 30 12:28:44 2003
@@ -202,7 +202,7 @@
 
 config SCx200_I2C
 	tristate "NatSemi SCx200 I2C using GPIO pins"
-	depends on SCx200 && I2C_ALGOBIT
+	depends on SCx200_GPIO && I2C_ALGOBIT
 	help
 	  Enable the use of two GPIO pins of a SCx200 processor as an I2C bus.
 
@@ -229,7 +229,7 @@
 
 config SCx200_ACB
 	tristate "NatSemi SCx200 ACCESS.bus"
-	depends on I2C_ALGOBIT!=n && I2C
+	depends on I2C
 	help
 	  Enable the use of the ACCESS.bus controllers of a SCx200 processor.
 

