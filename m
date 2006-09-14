Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750863AbWINOfX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750863AbWINOfX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Sep 2006 10:35:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750858AbWINOfW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Sep 2006 10:35:22 -0400
Received: from nat-132.atmel.no ([80.232.32.132]:1227 "EHLO relay.atmel.no")
	by vger.kernel.org with ESMTP id S1750823AbWINOfN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Sep 2006 10:35:13 -0400
Date: Thu, 14 Sep 2006 16:31:21 +0200
From: Haavard Skinnemoen <hskinnemoen@atmel.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [-mm patch 2/4] AVR32 MTD: Define struct flash_platform_data
Message-ID: <20060914163121.241dec3e@cad-250-152.norway.atmel.com>
In-Reply-To: <20060914163026.49766346@cad-250-152.norway.atmel.com>
References: <20060914162926.6c117b36@cad-250-152.norway.atmel.com>
	<20060914163026.49766346@cad-250-152.norway.atmel.com>
Organization: Atmel Norway
X-Mailer: Sylpheed-Claws 2.5.0-rc2 (GTK+ 2.8.20; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Define a data structure for passing board-specific information to an
MTD mapping driver. For now it specifies a default partition layout.

Signed-off-by: Haavard Skinnemoen <hskinnemoen@atmel.com>
---
 include/asm-avr32/arch-at32ap/board.h |    7 +++++++
 1 file changed, 7 insertions(+)

Index: linux-2.6.18-rc5-mm1/include/asm-avr32/arch-at32ap/board.h
===================================================================
--- linux-2.6.18-rc5-mm1.orig/include/asm-avr32/arch-at32ap/board.h	2006-09-07 15:14:20.000000000 +0200
+++ linux-2.6.18-rc5-mm1/include/asm-avr32/arch-at32ap/board.h	2006-09-07 15:19:08.000000000 +0200
@@ -6,6 +6,13 @@
 
 #include <linux/types.h>
 
+struct mtd_partition;
+
+struct flash_platform_data {
+	unsigned int nr_parts;
+	struct mtd_partition *parts;
+};
+
 /* Add basic devices: system manager, interrupt controller, portmuxes, etc. */
 void at32_add_system_devices(void);
 
