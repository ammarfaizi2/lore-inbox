Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269248AbUINJxs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269248AbUINJxs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Sep 2004 05:53:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269249AbUINJxr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Sep 2004 05:53:47 -0400
Received: from rdrz.de ([217.160.107.209]:7582 "HELO rdrz.de")
	by vger.kernel.org with SMTP id S269248AbUINJxc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Sep 2004 05:53:32 -0400
Date: Tue, 14 Sep 2004 11:53:30 +0200
From: Raphael Zimmerer <killekulla@rdrz.de>
To: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: akpm@osdl.org
Subject: [PATCH 1/2] ide: remove obsolete CONFIG_BLK_DEV_ADMA
Message-ID: <20040914095330.GF9994@rdrz.de>
Reply-To: linux-ide@vger.kernel.org, Raphael Zimmerer <killekulla@rdrz.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Raphael Zimmerer <killekulla@rdrz.de>

In drivers/ide/Kconfig there's a hidden config-item named BLK_DEV_ADMA.
Nowhere in the sources are any references to this item, so this option
simply is obsolete.

This patch removes the according item from drivers/ide/Kconfig.

Signed-off-by: Raphael Zimmerer <killekulla@rdrz.de>
---

 drivers/ide/Kconfig |    5 -----
 1 files changed, 5 deletions(-)

--- linux-2.6.8.1/drivers/ide/Kconfig	2004-08-16 10:00:50.000000000 +0200
+++ linux-2.6.8.1-no-BLK_DEV_ADMA/drivers/ide/Kconfig	2004-09-13 17:37:51.000000000 +0200
@@ -457,11 +457,6 @@ config IDEDMA_ONLYDISK
 
 	  Generally say N here.
 
-config BLK_DEV_ADMA
-	bool
-	depends on PCI && BLK_DEV_IDEPCI
-	default BLK_DEV_IDEDMA_PCI
-
 config BLK_DEV_AEC62XX
 	tristate "AEC62XX chipset support"
 	help
