Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932260AbVKLNA0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932260AbVKLNA0 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Nov 2005 08:00:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932265AbVKLNA0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Nov 2005 08:00:26 -0500
Received: from [195.144.244.147] ([195.144.244.147]:41398 "EHLO
	amanaus.varma-el.com") by vger.kernel.org with ESMTP
	id S932260AbVKLNAZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Nov 2005 08:00:25 -0500
Message-ID: <4375E765.4000207@varma-el.com>
Date: Sat, 12 Nov 2005 16:00:21 +0300
From: Andrey Volkov <avolkov@varma-el.com>
User-Agent: Mozilla Thunderbird 1.0.7 (Windows/20050923)
X-Accept-Language: ru-ru, ru
MIME-Version: 1.0
To: Russell King <rmk@dyn-67.arm.linux.org.uk>,
       ML linuxppc-embedded <linuxppc-embedded@ozlabs.org>
Cc: Greg KH <gregkh@suse.de>, linux-kernel@vger.kernel.org
Subject: [PATCH 1/1 kernel 2.6.15-rc1]  Fix copy-paste bug in mpc52xx_uart.c
 (pdev<->dev)
Content-Type: multipart/mixed;
 boundary="------------020507000008020400060502"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------020507000008020400060502
Content-Type: text/plain; charset=KOI8-R
Content-Transfer-Encoding: 7bit

Russel, in future, please CC such patches
([DRIVER MODEL] Convert platform drivers to use struct platform_driver)
to Sylvain Munaut (as MPC52xx mainteiner) too.

---
Regards
Andrey Volkov

--------------020507000008020400060502
Content-Type: text/plain;
 name="mpc52xx_uart_copy_paste_bug.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="mpc52xx_uart_copy_paste_bug.diff"

Fix copy-paste bug in mpc52xx_uart.c (pdev<->dev)

Signed-off-by: Andrey Volkov <avolkov@varma-el.com>
---

 drivers/serial/mpc52xx_uart.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/serial/mpc52xx_uart.c b/drivers/serial/mpc52xx_uart.c
index 5d3cb84..b8727d9 100644
--- a/drivers/serial/mpc52xx_uart.c
+++ b/drivers/serial/mpc52xx_uart.c
@@ -725,7 +725,7 @@ mpc52xx_uart_probe(struct platform_devic
 	int i, idx, ret;
 
 	/* Check validity & presence */
-	idx = pdev->id;
+	idx = dev->id;
 	if (idx < 0 || idx >= MPC52xx_PSC_MAXNUM)
 		return -EINVAL;
 
@@ -748,7 +748,7 @@ mpc52xx_uart_probe(struct platform_devic
 	port->ops	= &mpc52xx_uart_ops;
 
 	/* Search for IRQ and mapbase */
-	for (i=0 ; i<pdev->num_resources ; i++, res++) {
+	for (i=0 ; i<dev->num_resources ; i++, res++) {
 		if (res->flags & IORESOURCE_MEM)
 			port->mapbase = res->start;
 		else if (res->flags & IORESOURCE_IRQ)

--------------020507000008020400060502--
