Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261750AbTI3Wst (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Sep 2003 18:48:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261797AbTI3WsJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Sep 2003 18:48:09 -0400
Received: from mail.kroah.org ([65.200.24.183]:36315 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261825AbTI3WrX convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Sep 2003 18:47:23 -0400
Content-Type: text/plain; charset=US-ASCII
Message-Id: <1064961349577@kroah.com>
Subject: Re: [PATCH] PCI fixes for 2.6.0-test6
In-Reply-To: <10649613493963@kroah.com>
From: Greg KH <greg@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Tue, 30 Sep 2003 15:35:49 -0700
Content-Transfer-Encoding: 7BIT
To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1345, 2003/09/26 16:34:09-07:00, mochel@osdl.org

[PATCH] Remove ->save_state() from vlsi_ir.c

Remove the unneeded and uncalled struct pci_driver::save_state().


 drivers/net/irda/vlsi_ir.c |   10 ----------
 1 files changed, 10 deletions(-)


diff -Nru a/drivers/net/irda/vlsi_ir.c b/drivers/net/irda/vlsi_ir.c
--- a/drivers/net/irda/vlsi_ir.c	Tue Sep 30 15:20:50 2003
+++ b/drivers/net/irda/vlsi_ir.c	Tue Sep 30 15:20:50 2003
@@ -1859,15 +1859,6 @@
  * otherwise we might get cheated by pci-pm.
  */
 
-static int vlsi_irda_save_state(struct pci_dev *pdev, u32 state)
-{
-	if (state < 1 || state > 3 ) {
-		ERROR("%s - %s: invalid pm state request: %u\n",
-			__FUNCTION__, PCIDEV_NAME(pdev), state);
-		return -1;
-	}
-	return 0;
-}
 
 static int vlsi_irda_suspend(struct pci_dev *pdev, u32 state)
 {
@@ -1970,7 +1961,6 @@
 	.probe		= vlsi_irda_probe,
 	.remove		= __devexit_p(vlsi_irda_remove),
 #ifdef CONFIG_PM
-	.save_state	= vlsi_irda_save_state,
 	.suspend	= vlsi_irda_suspend,
 	.resume		= vlsi_irda_resume,
 #endif

