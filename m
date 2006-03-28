Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932142AbWC1ALt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932142AbWC1ALt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Mar 2006 19:11:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932144AbWC1ALt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Mar 2006 19:11:49 -0500
Received: from xenotime.net ([66.160.160.81]:4517 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S932142AbWC1ALt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Mar 2006 19:11:49 -0500
Date: Mon, 27 Mar 2006 16:14:02 -0800
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: dwmw2@infradead.org, akpm <akpm@osdl.org>
Cc: lkml <linux-kernel@vger.kernel.org>, linux-mtd@lists.infradead.org
Subject: [PATCH] MTD: m25p80: fix printk format warning
Message-Id: <20060327161402.06eaa84b.rdunlap@xenotime.net>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.3 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@xenotime.net>

Fix printk format warning:
drivers/mtd/devices/m25p80.c:189: warning: format '%zd' expects type 'signed size_t', but argument 6 has type 'u_int32_t'

Signed-off-by: Randy Dunlap <rdunlap@xenotime.net>
---
 drivers/mtd/devices/m25p80.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

--- linux-2616-g13.orig/drivers/mtd/devices/m25p80.c
+++ linux-2616-g13/drivers/mtd/devices/m25p80.c
@@ -186,7 +186,7 @@ static int m25p80_erase(struct mtd_info 
 	struct m25p *flash = mtd_to_m25p(mtd);
 	u32 addr,len;
 
-	DEBUG(MTD_DEBUG_LEVEL2, "%s: %s %s 0x%08x, len %zd\n",
+	DEBUG(MTD_DEBUG_LEVEL2, "%s: %s %s 0x%08x, len %d\n",
 			flash->spi->dev.bus_id, __FUNCTION__, "at",
 			(u32)instr->addr, instr->len);
 


---
