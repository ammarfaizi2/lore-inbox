Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932126AbWHPRzz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932126AbWHPRzz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Aug 2006 13:55:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932128AbWHPRzz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Aug 2006 13:55:55 -0400
Received: from natlemon.rzone.de ([81.169.145.170]:34028 "EHLO
	natlemon.rzone.de") by vger.kernel.org with ESMTP id S932126AbWHPRzy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Aug 2006 13:55:54 -0400
Date: Wed, 16 Aug 2006 19:53:50 +0200
From: Olaf Hering <olaf@aepfle.de>
To: stable@kernel.org, bunk@stusta.de, maks@sternwelten.at
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] [SERIAL] icom: select FW_LOADER
Message-ID: <20060816175350.GA9888@aepfle.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The icom driver uses request_firmware()
and thus needs to select FW_LOADER.

Signed-off-by: maximilian attems <maks@sternwelten.at>
Signed-off-by: Olaf Hering <olh@suse.de>

---
 drivers/serial/Kconfig |    1 +
 1 file changed, 1 insertion(+)

Index: linux-2.6.16.27/drivers/serial/Kconfig
===================================================================
--- linux-2.6.16.27.orig/drivers/serial/Kconfig
+++ linux-2.6.16.27/drivers/serial/Kconfig
@@ -820,6 +820,7 @@ config SERIAL_ICOM
 	tristate "IBM Multiport Serial Adapter"
 	depends on PCI && (PPC_ISERIES || PPC_PSERIES)
 	select SERIAL_CORE
+	select FW_LOADER
 	help
 	  This driver is for a family of multiport serial adapters
 	  including 2 port RVX, 2 port internal modem, 4 port internal
