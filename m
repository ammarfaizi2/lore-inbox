Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262750AbUKMAzY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262750AbUKMAzY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Nov 2004 19:55:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262650AbUKLXow
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Nov 2004 18:44:52 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.101]:53142 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262698AbUKLXWu convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Nov 2004 18:22:50 -0500
X-Fake: the user-agent is fake
Subject: Re: [PATCH] PCI fixes for 2.6.10-rc1
User-Agent: Mutt/1.5.6i
In-Reply-To: <1100301720628@kroah.com>
Date: Fri, 12 Nov 2004 15:22:00 -0800
Message-Id: <11003017202524@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.2091.1.18, 2004/11/12 14:10:03-08:00, hannal@us.ibm.com

[PATCH] fixups-dreamcast.c: replace pci_find_device with pci_get_device

As pci_find_device is going away I've replaced it with pci_get_device
and pci_dev_put.


Signed-off-by: Hanna Linder <hannal@us.ibm.com>
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 arch/sh/drivers/pci/fixups-dreamcast.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)


diff -Nru a/arch/sh/drivers/pci/fixups-dreamcast.c b/arch/sh/drivers/pci/fixups-dreamcast.c
--- a/arch/sh/drivers/pci/fixups-dreamcast.c	2004-11-12 15:09:49 -08:00
+++ b/arch/sh/drivers/pci/fixups-dreamcast.c	2004-11-12 15:09:49 -08:00
@@ -62,7 +62,7 @@
 {
 	struct pci_dev *dev = 0;
 
-	while ((dev = pci_find_device(PCI_ANY_ID, PCI_ANY_ID, dev)) != NULL) {
+	for_each_pci_dev(dev) {
 		/*
 		 * The interrupt routing semantics here are quite trivial.
 		 *

