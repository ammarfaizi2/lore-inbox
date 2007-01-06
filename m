Return-Path: <linux-kernel-owner+w=401wt.eu-S1751114AbXAFC3X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751114AbXAFC3X (ORCPT <rfc822;w@1wt.eu>);
	Fri, 5 Jan 2007 21:29:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751106AbXAFC3H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Jan 2007 21:29:07 -0500
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:36426 "EHLO
	sous-sol.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751088AbXAFC2p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Jan 2007 21:28:45 -0500
Message-Id: <20070106023250.569101000@sous-sol.org>
References: <20070106022753.334962000@sous-sol.org>
User-Agent: quilt/0.45-1
Date: Fri, 05 Jan 2007 18:28:14 -0800
From: Chris Wright <chrisw@sous-sol.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org, torvalds@osdl.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>,
       Michael Krufky <mkrufky@linuxtv.org>, akpm@osdl.org,
       alan@lxorguk.ukuu.org.uk, jeff@garzik.org, vitalywool@gmail.com
Subject: [patch 21/50] smc911x: fix netpoll compilation faliure
Content-Disposition: inline; filename=smc911x-fix-netpoll-compilation-faliure.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.
------------------

From: Vitaly Wool <vitalywool@gmail.com>

Fix the compilation failure for smc911x.c when NET_POLL_CONTROLLER is set.

Signed-off-by: Vitaly Wool <vitalywool@gmail.com>
Cc: Jeff Garzik <jeff@garzik.org>
Cc: <stable@kernel.org>
Signed-off-by: Andrew Morton <akpm@osdl.org>
Signed-off-by: Chris Wright <chrisw@sous-sol.org>
---

 drivers/net/smc911x.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-2.6.19.1.orig/drivers/net/smc911x.c
+++ linux-2.6.19.1/drivers/net/smc911x.c
@@ -1331,7 +1331,7 @@ smc911x_rx_dma_irq(int dma, void *data)
 static void smc911x_poll_controller(struct net_device *dev)
 {
 	disable_irq(dev->irq);
-	smc911x_interrupt(dev->irq, dev, NULL);
+	smc911x_interrupt(dev->irq, dev);
 	enable_irq(dev->irq);
 }
 #endif

--
