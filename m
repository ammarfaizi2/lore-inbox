Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751066AbVIGRhd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751066AbVIGRhd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Sep 2005 13:37:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751067AbVIGRhd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Sep 2005 13:37:33 -0400
Received: from adsl-70-250-156-241.dsl.austtx.swbell.net ([70.250.156.241]:64971
	"EHLO gw.microgate.com") by vger.kernel.org with ESMTP
	id S1751033AbVIGRhc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Sep 2005 13:37:32 -0400
Subject: [patch] synclinkmp.c disable burst transfers
From: Paul Fulghum <paulkf@microgate.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1126114648.4056.7.camel@deimos.microgate.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Wed, 07 Sep 2005 12:37:29 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[patch] synclinkmp.c disable burst transfers

From: Paul Fulghum <paulkf@microgate.com>

Disable burst transfers on adapter local bus.
Hardware feature does not work on latest
version of adapter.

Signed-off-by: Paul Fulghum <paulkf@microgate.com>

--- linux-2.6.13/drivers/char/synclinkmp.c	2005-08-28 18:41:01.000000000 -0500
+++ linux-2.6.13-mg/drivers/char/synclinkmp.c	2005-09-07 12:24:21.000000000 -0500
@@ -645,7 +645,7 @@ static unsigned char tx_active_fifo_leve
 static unsigned char tx_negate_fifo_level = 32;	// tx request FIFO negation level in bytes
 
 static u32 misc_ctrl_value = 0x007e4040;
-static u32 lcr1_brdr_value = 0x00800029;
+static u32 lcr1_brdr_value = 0x00800028;
 
 static u32 read_ahead_count = 8;
 


