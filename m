Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750963AbWHGUSE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750963AbWHGUSE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Aug 2006 16:18:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750971AbWHGUSD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Aug 2006 16:18:03 -0400
Received: from e36.co.us.ibm.com ([32.97.110.154]:29071 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S1750875AbWHGUSB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Aug 2006 16:18:01 -0400
Date: Mon, 7 Aug 2006 15:16:58 -0500
To: Jeff Garzik <jgarzik@pobox.com>, netdev@vger.kernel.org,
       Auke Kok <sofar@foo-projects.org>
Cc: linux-kernel@vger.kernel.org, john.ronciak@intel.com,
       jesse.brandeburg@intel.com, jeffrey.t.kirsher@intel.com,
       "Zhang, Yanmin" <yanmin.zhang@intel.com>
Subject: [PATCH]: e1000: Janitor: Use #defined values for literals
Message-ID: <20060807201658.GP10638@austin.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
From: linas@austin.ibm.com (Linas Vepstas)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Resending patch from 23 June 2006; there was some confusion about
whether a similar patch had already been applied; seems it wasn't.

Minor janitorial patch: use #defines for literal values.

Signed-off-by: Linas Vepstas <linas@austin.ibm.com>

----
 drivers/net/e1000/e1000_main.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

Index: linux-2.6.18-rc3-mm2/drivers/net/e1000/e1000_main.c
===================================================================
--- linux-2.6.18-rc3-mm2.orig/drivers/net/e1000/e1000_main.c	2006-08-07 14:39:37.000000000 -0500
+++ linux-2.6.18-rc3-mm2/drivers/net/e1000/e1000_main.c	2006-08-07 15:06:31.000000000 -0500
@@ -4955,8 +4955,8 @@ static pci_ers_result_t e1000_io_slot_re
 	}
 	pci_set_master(pdev);
 
-	pci_enable_wake(pdev, 3, 0);
-	pci_enable_wake(pdev, 4, 0); /* 4 == D3 cold */
+	pci_enable_wake(pdev, PCI_D3hot, 0);
+	pci_enable_wake(pdev, PCI_D3cold, 0);
 
 	/* Perform card reset only on one instance of the card */
 	if (PCI_FUNC (pdev->devfn) != 0)
