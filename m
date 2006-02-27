Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751464AbWB0PcJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751464AbWB0PcJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Feb 2006 10:32:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751470AbWB0PcJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Feb 2006 10:32:09 -0500
Received: from adsl-70-250-156-241.dsl.austtx.swbell.net ([70.250.156.241]:28139
	"EHLO gw.microgate.com") by vger.kernel.org with ESMTP
	id S1751464AbWB0PcI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Feb 2006 10:32:08 -0500
Subject: [PATCH] tty buffering: comment out debug code
From: Paul Fulghum <paulkf@microgate.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Date: Mon, 27 Feb 2006 09:32:05 -0600
Message-Id: <1141054325.2884.15.camel@x2.pipehead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Comment out debug code in tty receive buffering.

Signed-off-by: Paul Fulghum <paulkf@microgate.com>

--- linux-2.6.16-rc5/drivers/char/tty_io.c	2006-02-27 09:24:26.000000000 -0600
+++ b/drivers/char/tty_io.c	2006-02-27 09:26:40.000000000 -0600
@@ -303,7 +303,7 @@ static struct tty_buffer *tty_buffer_fin
 			t->commit = 0;
 			t->read = 0;
 			/* DEBUG ONLY */
-			memset(t->data, '*', size);
+/*			memset(t->data, '*', size); */
 /* 			printk("Flip recycle %p\n", t); */
 			return t;
 		}


