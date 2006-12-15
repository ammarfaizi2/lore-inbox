Return-Path: <linux-kernel-owner+w=401wt.eu-S1752113AbWLONUF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752113AbWLONUF (ORCPT <rfc822;w@1wt.eu>);
	Fri, 15 Dec 2006 08:20:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752115AbWLONUF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Dec 2006 08:20:05 -0500
Received: from rtsoft2.corbina.net ([85.21.88.2]:40502 "HELO
	mail.dev.rtsoft.ru" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
	with SMTP id S1752113AbWLONUE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Dec 2006 08:20:04 -0500
Date: Fri, 15 Dec 2006 16:13:28 +0300
From: Vitaly Wool <vitalywool@gmail.com>
To: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] smc911x: fix netpoll compilation faliure
Message-Id: <20061215161328.9797232d.vitalywool@gmail.com>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.20; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello folks,

the trivial patch below fixes the compilation failure for smc911x.c when NET_POLL_CONTROLLER is set.

 drivers/net/smc911x.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Signed-off-by: Vitaly Wool <vitalywool@gmail.com>

diff --git a/drivers/net/smc911x.c b/drivers/net/smc911x.c
index 2c43433..797ab91 100644
--- a/drivers/net/smc911x.c
+++ b/drivers/net/smc911x.c
@@ -1331,7 +1331,7 @@ smc911x_rx_dma_irq(int dma, void *data)
 static void smc911x_poll_controller(struct net_device *dev)
 {
 	disable_irq(dev->irq);
-	smc911x_interrupt(dev->irq, dev, NULL);
+	smc911x_interrupt(dev->irq, dev);
 	enable_irq(dev->irq);
 }
 #endif
