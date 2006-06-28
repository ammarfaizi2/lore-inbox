Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751482AbWF1RBI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751482AbWF1RBI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jun 2006 13:01:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751451AbWF1Q7j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jun 2006 12:59:39 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:38660 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751440AbWF1Qyv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jun 2006 12:54:51 -0400
Date: Wed, 28 Jun 2006 18:54:50 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: Samuel Ortiz <samuel@sortiz.org>, netdev@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: [2.6 patch] drivers/net/irda/mcs7780.c: make struct mcs_driver static
Message-ID: <20060628165450.GS13915@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch makes a needlessly global struct static.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

This patch was already sent on:
- 22 Jun 2006

--- linux-2.6.17-mm1-full/drivers/net/irda/mcs7780.c.old	2006-06-22 00:38:41.000000000 +0200
+++ linux-2.6.17-mm1-full/drivers/net/irda/mcs7780.c	2006-06-22 00:38:50.000000000 +0200
@@ -101,7 +101,7 @@
 module_param(transceiver_type, int, 0444);
 MODULE_PARM_DESC(transceiver_type, "IR transceiver type, see mcs7780.h.");
 
-struct usb_driver mcs_driver = {
+static struct usb_driver mcs_driver = {
 	.name = "mcs7780",
 	.probe = mcs_probe,
 	.disconnect = mcs_disconnect,

