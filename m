Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751840AbWGAPLI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751840AbWGAPLI (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Jul 2006 11:11:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751904AbWGAPLG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Jul 2006 11:11:06 -0400
Received: from www.osadl.org ([213.239.205.134]:52644 "EHLO mail.tglx.de")
	by vger.kernel.org with ESMTP id S1751840AbWGAO5X (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Jul 2006 10:57:23 -0400
Message-Id: <20060701145226.582024000@cruncher.tec.linutronix.de>
References: <20060701145211.856500000@cruncher.tec.linutronix.de>
Date: Sat, 01 Jul 2006 14:54:53 -0000
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       David Miller <davem@davemloft.net>, arlied@linux.ie
Subject: [RFC][patch 29/44] drivers/drm: Use the new IRQF_ constansts
Content-Disposition: inline; filename=irqflags-drivers-drm.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
 drivers/char/drm/drm_irq.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: linux-2.6.git/drivers/char/drm/drm_irq.c
===================================================================
--- linux-2.6.git.orig/drivers/char/drm/drm_irq.c	2006-07-01 16:51:19.000000000 +0200
+++ linux-2.6.git/drivers/char/drm/drm_irq.c	2006-07-01 16:51:40.000000000 +0200
@@ -130,7 +130,7 @@ static int drm_irq_install(drm_device_t 
 
 	/* Install handler */
 	if (drm_core_check_feature(dev, DRIVER_IRQ_SHARED))
-		sh_flags = SA_SHIRQ;
+		sh_flags = IRQF_SHARED;
 
 	ret = request_irq(dev->irq, dev->driver->irq_handler,
 			  sh_flags, dev->devname, dev);

--

