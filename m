Return-Path: <linux-kernel-owner+w=401wt.eu-S1754676AbWLRWG6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754676AbWLRWG6 (ORCPT <rfc822;w@1wt.eu>);
	Mon, 18 Dec 2006 17:06:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754679AbWLRWG6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Dec 2006 17:06:58 -0500
Received: from nic.NetDirect.CA ([216.16.235.2]:53646 "EHLO
	rubicon.netdirect.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754676AbWLRWG5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Dec 2006 17:06:57 -0500
X-Originating-Ip: 24.148.236.183
Date: Mon, 18 Dec 2006 17:02:15 -0500 (EST)
From: "Robert P. J. Day" <rpjday@mindspring.com>
X-X-Sender: rpjday@localhost.localdomain
To: Linux kernel mailing list <linux-kernel@vger.kernel.org>
cc: trivial@kernel.org
Subject: [PATCH] ppc : Use syslog macro for the printk log level.
Message-ID: <Pine.LNX.4.64.0612181658070.8277@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Net-Direct-Inc-MailScanner-Information: Please contact the ISP for more information
X-Net-Direct-Inc-MailScanner: Found to be clean
X-Net-Direct-Inc-MailScanner-SpamCheck: not spam, SpamAssassin (not cached,
	score=-14.754, required 5, ALL_TRUSTED -1.80, BAYES_00 -15.00,
	RCVD_IN_SORBS_DUL 2.05)
X-Net-Direct-Inc-MailScanner-From: rpjday@mindspring.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


  Use the appropriate logging macro for the priority level for that
printk call.

Signed-off-by: Robert P. J. Day <rpjday@mindspring.com>

---

  this appears to be the only instance in the entire tree of
hard-coding the log level in a printk.


diff --git a/arch/ppc/syslib/m8260_pci_erratum9.c b/arch/ppc/syslib/m8260_pci_erratum9.c
index 5475709..041c017 100644
--- a/arch/ppc/syslib/m8260_pci_erratum9.c
+++ b/arch/ppc/syslib/m8260_pci_erratum9.c
@@ -105,7 +105,8 @@ void idma_pci9_init(void)
 	idma_reg[IDMA_CHAN].idmr = 0;		/* mask all IDMA interrupts */
 	idma_reg[IDMA_CHAN].idsr = 0xff;	/* clear all event flags */

-	printk("<4>Using IDMA%d for MPC8260 device erratum PCI 9 workaround\n",
+	printk(	KERN_WARNING
+		"Using IDMA%d for MPC8260 device erratum PCI 9 workaround\n",
 		IDMA_CHAN + 1);

 	return;
