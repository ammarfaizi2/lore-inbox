Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261283AbVAaRkQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261283AbVAaRkQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jan 2005 12:40:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261277AbVAaRju
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jan 2005 12:39:50 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:2060 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261276AbVAaRin (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jan 2005 12:38:43 -0500
Date: Mon, 31 Jan 2005 18:38:41 +0100
From: Adrian Bunk <bunk@stusta.de>
To: paulkf@microgate.com
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] drivers/char/synclinkmp.c: make 3 functions static
Message-ID: <20050131173841.GU18316@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch makes three needlessly global functions static.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 drivers/char/synclinkmp.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

--- linux-2.6.11-rc2-mm2-full/drivers/char/synclinkmp.c.old	2005-01-31 15:38:23.000000000 +0100
+++ linux-2.6.11-rc2-mm2-full/drivers/char/synclinkmp.c	2005-01-31 15:41:34.000000000 +0100
@@ -2313,7 +2313,7 @@
 		tty_flip_buffer_push(tty);
 }
 
-void isr_txeom(SLMP_INFO * info, unsigned char status)
+static void isr_txeom(SLMP_INFO * info, unsigned char status)
 {
 	if ( debug_level >= DEBUG_LEVEL_ISR )
 		printk("%s(%d):%s isr_txeom status=%02x\n",
@@ -3815,7 +3815,7 @@
  *
  * Return Value:	pointer to SLMP_INFO if success, otherwise NULL
  */
-SLMP_INFO *alloc_dev(int adapter_num, int port_num, struct pci_dev *pdev)
+static SLMP_INFO *alloc_dev(int adapter_num, int port_num, struct pci_dev *pdev)
 {
 	SLMP_INFO *info;
 
@@ -5205,7 +5205,7 @@
 
 /* initialize individual SCA device (2 ports)
  */
-int sca_init(SLMP_INFO *info)
+static int sca_init(SLMP_INFO *info)
 {
 	/* set wait controller to single mem partition (low), no wait states */
 	write_reg(info, PABR0, 0);	/* wait controller addr boundary 0 */

