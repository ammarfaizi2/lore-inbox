Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1759108AbWLAO1Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759108AbWLAO1Q (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Dec 2006 09:27:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759290AbWLAO1Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Dec 2006 09:27:16 -0500
Received: from xdsl-664.zgora.dialog.net.pl ([81.168.226.152]:1549 "EHLO
	tuxland.pl") by vger.kernel.org with ESMTP id S1759113AbWLAO1Q
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Dec 2006 09:27:16 -0500
From: Mariusz Kozlowski <m.kozlowski@tuxland.pl>
To: Willy Tarreau <wtarreau@hera.kernel.org>
Subject: [2.4 PATCH] serial_amba parenthesis fix
Date: Fri, 1 Dec 2006 15:26:51 +0100
User-Agent: KMail/1.9.5
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200612011526.51571.m.kozlowski@tuxland.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

	This patch adds missing parenthesis in ambauart_modem_status() code.

Signed-off-by: Mariusz Kozlowski <m.kozlowski@tuxland.pl>

 drivers/char/serial_amba.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-2.4.34-pre6-a/drivers/char/serial_amba.c	2005-01-19 15:09:50.000000000 +0100
+++ linux-2.4.34-pre6-b/drivers/char/serial_amba.c	2006-12-01 12:18:18.000000000 +0100
@@ -481,7 +481,7 @@ static void ambauart_modem_status(struct
 		icount->dcd++;
 #ifdef CONFIG_HARD_PPS
 		if ((info->flags & ASYNC_HARDPPS_CD) &&
-		    (status & AMBA_UARTFR_DCD)
+		    (status & AMBA_UARTFR_DCD))
 			hardpps();
 #endif
 		if (info->flags & ASYNC_CHECK_CD) {


-- 
Regards,

	Mariusz Kozlowski
