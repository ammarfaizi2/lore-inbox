Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270651AbTHATcV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Aug 2003 15:32:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270676AbTHATcV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Aug 2003 15:32:21 -0400
Received: from mail.kroah.org ([65.200.24.183]:6079 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S270651AbTHATcT convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Aug 2003 15:32:19 -0400
Content-Type: text/plain; charset=US-ASCII
Message-Id: <10597663273174@kroah.com>
Subject: Re: [PATCH] PCI fixes for 2.6.0-test2
In-Reply-To: <10597663232556@kroah.com>
From: Greg KH <greg@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Fri, 1 Aug 2003 12:32:07 -0700
Content-Transfer-Encoding: 7BIT
To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1547.13.2, 2003/08/01 10:13:16-07:00, mitch@sfgoth.com

[PATCH] PCI: Trivial DMA-mapping.txt fix

As far as I can tell "pci_set_consistent()" doesn't exist - the docs probably
meant to say "pci_set_consistent_dma_mask()".


 Documentation/DMA-mapping.txt |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)


diff -Nru a/Documentation/DMA-mapping.txt b/Documentation/DMA-mapping.txt
--- a/Documentation/DMA-mapping.txt	Fri Aug  1 12:17:38 2003
+++ b/Documentation/DMA-mapping.txt	Fri Aug  1 12:17:38 2003
@@ -183,7 +183,7 @@
 pci_set_consistent_dma_mask() will always be able to set the same or a
 smaller mask as pci_set_dma_mask(). However for the rare case that a
 device driver only uses consistent allocations, one would have to
-check the return value from pci_set_consistent().
+check the return value from pci_set_consistent_dma_mask().
 
 If your 64-bit device is going to be an enormous consumer of DMA
 mappings, this can be problematic since the DMA mappings are a

