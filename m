Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422683AbWJLBtV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422683AbWJLBtV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Oct 2006 21:49:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422686AbWJLBtV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Oct 2006 21:49:21 -0400
Received: from havoc.gtf.org ([69.61.125.42]:11744 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S1422683AbWJLBtU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Oct 2006 21:49:20 -0400
Date: Wed, 11 Oct 2006 21:49:20 -0400
From: Jeff Garzik <jeff@garzik.org>
To: dbrownell@users.sourceforge.net, Andrew Morton <akpm@osdl.org>,
       LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] SPI: improve sysfs compiler complaint handling
Message-ID: <20061012014920.GA13000@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Signed-off-by: Jeff Garzik <jeff@garzik.org>

---

Pointless?  I leave it up to the maintainer(s) to decide.

The compiler complains, even with the "(void)".

 drivers/spi/spi.c            |    4 +++-

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 146298a..085d4fa 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -448,7 +448,9 @@ static int __unregister(struct device *d
  */
 void spi_unregister_master(struct spi_master *master)
 {
-	(void) device_for_each_child(master->cdev.dev, NULL, __unregister);
+	int dummy;
+	
+	dummy = device_for_each_child(master->cdev.dev, NULL, __unregister);
 	class_device_unregister(&master->cdev);
 }
 EXPORT_SYMBOL_GPL(spi_unregister_master);
