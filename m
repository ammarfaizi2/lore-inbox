Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752514AbWAFRlI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752514AbWAFRlI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jan 2006 12:41:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752513AbWAFRlI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jan 2006 12:41:08 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:8973 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1752514AbWAFRlH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jan 2006 12:41:07 -0500
Date: Fri, 6 Jan 2006 18:41:01 +0100
From: Adrian Bunk <bunk@stusta.de>
To: johnpol@2ka.mipt.ru, gregkh@suse.de
Cc: lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org
Subject: [-mm patch] fix W1_MASTER_DS9490_BRIDGE dependencies
Message-ID: <20060106174101.GT12131@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

W1_DS9490 was renamed to W1_MASTER_DS9490, but the entry in the 
dependencies of W1_MASTER_DS9490_BRIDGE was forgotten.


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.15-mm1-full/drivers/w1/masters/Kconfig.old	2006-01-06 18:17:23.000000000 +0100
+++ linux-2.6.15-mm1-full/drivers/w1/masters/Kconfig	2006-01-06 18:17:53.000000000 +0100
@@ -26,7 +26,7 @@
 
 config W1_MASTER_DS9490_BRIDGE
 	tristate "DS9490R USB <-> W1 transport layer for 1-wire"
-	depends on W1_DS9490
+	depends on W1_MASTER_DS9490
 	help
 	  Say Y here if you want to communicate with your 1-wire devices
 	  using DS9490R USB bridge.

