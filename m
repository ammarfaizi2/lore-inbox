Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262499AbTFJSg6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jun 2003 14:36:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263152AbTFJSg6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jun 2003 14:36:58 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:61851 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S262499AbTFJSgt convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jun 2003 14:36:49 -0400
Content-Type: text/plain; charset=US-ASCII
Message-Id: <10552709703450@kroah.com>
Subject: Re: [PATCH] Yet more PCI fixes for 2.5.70
In-Reply-To: <10552709701662@kroah.com>
From: Greg KH <greg@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Tue, 10 Jun 2003 11:49:30 -0700
Content-Transfer-Encoding: 7BIT
To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1387, 2003/06/10 10:30:44-07:00, greg@kroah.com

[PATCH] PCI: remove pci_for_each_bus() usage from arch/ia64/hp/common/sba_iommu.c


 arch/ia64/hp/common/sba_iommu.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)


diff -Nru a/arch/ia64/hp/common/sba_iommu.c b/arch/ia64/hp/common/sba_iommu.c
--- a/arch/ia64/hp/common/sba_iommu.c	Tue Jun 10 11:15:47 2003
+++ b/arch/ia64/hp/common/sba_iommu.c	Tue Jun 10 11:15:47 2003
@@ -1939,8 +1939,8 @@
 
 #ifdef CONFIG_PCI
 	{
-		struct pci_bus *b;
-		pci_for_each_bus(b)
+		struct pci_bus *b = NULL;
+		while ((b = pci_find_next_bus(b)) != NULL)
 			sba_connect_bus(b);
 	}
 #endif

