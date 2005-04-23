Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262152AbVDWWO4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262152AbVDWWO4 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Apr 2005 18:14:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262128AbVDWWMW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Apr 2005 18:12:22 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:46863 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S262099AbVDWWK0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Apr 2005 18:10:26 -0400
Date: Sun, 24 Apr 2005 00:10:08 +0200
From: Adrian Bunk <bunk@stusta.de>
To: James.Bottomley@SteelEye.com
Cc: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [2.6 patch] drivers/scsi/NCR53C9x.c: make a struct static
Message-ID: <20050423221008.GG4355@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch makes a needlessly global struct static.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 drivers/scsi/NCR53C9x.c  |    2 +-
 drivers/scsi/sun3x_esp.c |    2 --
 2 files changed, 1 insertion(+), 3 deletions(-)

--- linux-2.6.12-rc2-mm3-full/drivers/scsi/sun3x_esp.c.old	2005-04-23 21:44:01.000000000 +0200
+++ linux-2.6.12-rc2-mm3-full/drivers/scsi/sun3x_esp.c	2005-04-23 21:44:07.000000000 +0200
@@ -23,8 +23,6 @@
 #include <asm/dvma.h>
 #include <asm/irq.h>
 
-extern struct NCR_ESP *espchain;
-
 static void dma_barrier(struct NCR_ESP *esp);
 static int  dma_bytes_sent(struct NCR_ESP *esp, int fifo_count);
 static int  dma_can_transfer(struct NCR_ESP *esp, Scsi_Cmnd *sp);
--- linux-2.6.12-rc2-mm3-full/drivers/scsi/NCR53C9x.c.old	2005-04-23 21:44:22.000000000 +0200
+++ linux-2.6.12-rc2-mm3-full/drivers/scsi/NCR53C9x.c	2005-04-23 21:44:30.000000000 +0200
@@ -94,7 +94,7 @@
 };
 
 /* The master ring of all esp hosts we are managing in this driver. */
-struct NCR_ESP *espchain;
+static struct NCR_ESP *espchain;
 int nesps = 0, esps_in_use = 0, esps_running = 0;
 
 irqreturn_t esp_intr(int irq, void *dev_id, struct pt_regs *pregs);

