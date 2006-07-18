Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932135AbWGRVbP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932135AbWGRVbP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Jul 2006 17:31:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932138AbWGRVbP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Jul 2006 17:31:15 -0400
Received: from rgminet01.oracle.com ([148.87.113.118]:29583 "EHLO
	rgminet01.oracle.com") by vger.kernel.org with ESMTP
	id S932135AbWGRVbD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Jul 2006 17:31:03 -0400
Message-ID: <44BD539C.6030606@oracle.com>
Date: Tue, 18 Jul 2006 14:33:16 -0700
From: Randy Dunlap <randy.dunlap@oracle.com>
User-Agent: Thunderbird 1.5 (X11/20051201)
MIME-Version: 1.0
To: linux-pci@atrey.karlin.mff.cuni.cz, lkml <linux-kernel@vger.kernel.org>,
       gregkh@suse.de
Subject: [PATCH 3/3] pci/search: EXPORTs cannot be __devinit
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@xenotime.net>

EXPORTed symbols cannot be __init/__devinit.

Signed-off-by: Randy Dunlap <rdunlap@xenotime.net>
---
 drivers/pci/search.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-2618-rc2.orig/drivers/pci/search.c
+++ linux-2618-rc2/drivers/pci/search.c
@@ -41,7 +41,7 @@ pci_do_find_bus(struct pci_bus* bus, uns
  * in the global list of PCI buses.  If the bus is found, a pointer to its
  * data structure is returned.  If no bus is found, %NULL is returned.
  */
-struct pci_bus * __devinit pci_find_bus(int domain, int busnr)
+struct pci_bus * pci_find_bus(int domain, int busnr)
 {
 	struct pci_bus *bus = NULL;
 	struct pci_bus *tmp_bus;



