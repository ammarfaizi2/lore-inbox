Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262715AbUKLXby@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262715AbUKLXby (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Nov 2004 18:31:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262690AbUKLX0V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Nov 2004 18:26:21 -0500
Received: from e5.ny.us.ibm.com ([32.97.182.105]:38115 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262683AbUKLXWl convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Nov 2004 18:22:41 -0500
X-Fake: the user-agent is fake
Subject: Re: [PATCH] PCI fixes for 2.6.10-rc1
User-Agent: Mutt/1.5.6i
In-Reply-To: <11003017181589@kroah.com>
Date: Fri, 12 Nov 2004 15:21:58 -0800
Message-Id: <11003017184012@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.2091.1.6, 2004/11/12 14:02:20-08:00, hannal@us.ibm.com

[PATCH] gemini_pci.c: replace pci_find_device with for_each_pci_dev

Signed-off-by: Hanna Linder <hannal@us.ibm.com>
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 arch/ppc/platforms/gemini_pci.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)


diff -Nru a/arch/ppc/platforms/gemini_pci.c b/arch/ppc/platforms/gemini_pci.c
--- a/arch/ppc/platforms/gemini_pci.c	2004-11-12 15:11:19 -08:00
+++ b/arch/ppc/platforms/gemini_pci.c	2004-11-12 15:11:19 -08:00
@@ -15,7 +15,7 @@
 	int i;
 	struct pci_dev *dev = NULL;
 	
-	while ((dev = pci_find_device(PCI_ANY_ID, PCI_ANY_ID, dev)) != NULL) {
+	for_each_pci_dev(dev) {
 		for(i = 0; i < 6; i++) {
 			if (dev->resource[i].flags & IORESOURCE_IO) {
 				dev->resource[i].start |= (0xfe << 24);

