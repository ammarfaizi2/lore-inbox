Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261868AbTFJS7w (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jun 2003 14:59:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262409AbTFJSnC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jun 2003 14:43:02 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:36015 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S262763AbTFJShc convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jun 2003 14:37:32 -0400
Content-Type: text/plain; charset=US-ASCII
Message-Id: <10552709651472@kroah.com>
Subject: Re: [PATCH] Yet more PCI fixes for 2.5.70
In-Reply-To: <10552709651938@kroah.com>
From: Greg KH <greg@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Tue, 10 Jun 2003 11:49:25 -0700
Content-Transfer-Encoding: 7BIT
To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1326, 2003/06/09 15:34:46-07:00, greg@kroah.com

PCI: remove pci_present() from drivers/char/rocket.c


 drivers/char/rocket.c |    8 ++------
 1 files changed, 2 insertions(+), 6 deletions(-)


diff -Nru a/drivers/char/rocket.c b/drivers/char/rocket.c
--- a/drivers/char/rocket.c	Tue Jun 10 11:21:54 2003
+++ b/drivers/char/rocket.c	Tue Jun 10 11:21:54 2003
@@ -2713,12 +2713,8 @@
 	}
 
 #ifdef CONFIG_PCI
-	if (pci_present()) {
-		if (isa_boards_found < NUM_BOARDS)
-			pci_boards_found = init_PCI(isa_boards_found);
-	} else {
-		printk(KERN_INFO "No PCI BIOS found\n");
-	}
+	if (isa_boards_found < NUM_BOARDS)
+		pci_boards_found = init_PCI(isa_boards_found);
 #endif
 
 	max_board = pci_boards_found + isa_boards_found;

