Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933875AbWKTCYy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933875AbWKTCYy (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Nov 2006 21:24:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933876AbWKTCYU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Nov 2006 21:24:20 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:40721 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S933874AbWKTCXz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Nov 2006 21:23:55 -0500
Date: Mon, 20 Nov 2006 03:23:54 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Tony Olech <tony.olech@elandigitalsystems.com>
Cc: gregkh@suse.de, linux-usb-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: [2.6 patch] make drivers/usb/host/u132-hcd.c:u132_hcd_wait static
Message-ID: <20061120022354.GI31879@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch makes the needlessly global "u132_hcd_wait" static.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.19-rc5-mm2/drivers/usb/host/u132-hcd.c.old	2006-11-20 01:01:43.000000000 +0100
+++ linux-2.6.19-rc5-mm2/drivers/usb/host/u132-hcd.c	2006-11-20 01:02:00.000000000 +0100
@@ -71,7 +71,7 @@
 module_param(distrust_firmware, bool, 0);
 MODULE_PARM_DESC(distrust_firmware, "true to distrust firmware power/overcurren"
         "t setup");
-DECLARE_WAIT_QUEUE_HEAD(u132_hcd_wait);
+static DECLARE_WAIT_QUEUE_HEAD(u132_hcd_wait);
 /*
 * u132_module_lock exists to protect access to global variables
 *

