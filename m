Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262127AbTFJXz4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jun 2003 19:55:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262256AbTFJXz4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jun 2003 19:55:56 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:60407 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S262127AbTFJXzz convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jun 2003 19:55:55 -0400
Content-Type: text/plain; charset=US-ASCII
Message-Id: <10552903152794@kroah.com>
Subject: Re: [PATCH] And yet more PCI fixes for 2.5.70
In-Reply-To: <1055290315109@kroah.com>
From: Greg KH <greg@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Tue, 10 Jun 2003 17:11:55 -0700
Content-Transfer-Encoding: 7BIT
To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1396, 2003/06/10 14:17:24-07:00, greg@kroah.com

[PATCH] PCI: replace usage of pci_present() in drivers/sbus/sbus.c


 drivers/sbus/sbus.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)


diff -Nru a/drivers/sbus/sbus.c b/drivers/sbus/sbus.c
--- a/drivers/sbus/sbus.c	Tue Jun 10 17:04:09 2003
+++ b/drivers/sbus/sbus.c	Tue Jun 10 17:04:09 2003
@@ -334,7 +334,7 @@
 		nd = prom_searchsiblings(topnd, "sbus");
 		if(nd == 0) {
 #ifdef CONFIG_PCI
-			if (!pci_present()) {
+			if (pci_find_device(PCI_ANY_ID, PCI_ANY_ID, NULL) == NULL) {
 				prom_printf("Neither SBUS nor PCI found.\n");
 				prom_halt();
 			} else {

