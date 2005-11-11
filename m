Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750986AbVKKR7i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750986AbVKKR7i (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Nov 2005 12:59:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750987AbVKKR7i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Nov 2005 12:59:38 -0500
Received: from e3.ny.us.ibm.com ([32.97.182.143]:42406 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1750985AbVKKR7i (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Nov 2005 12:59:38 -0500
Date: Fri, 11 Nov 2005 11:59:04 -0600
From: Serge Hallyn <serue@us.ibm.com>
To: Linda Xie <lxie@us.ibm.com>
Cc: Andrew Morton <akpm@osdl.org>, gregkh@suse.de,
       John Rose <johnrose@austin.ibm.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.14-mm1
Message-ID: <20051111175904.GA21272@sergelap.austin.ibm.com>
References: <20051110130626.GA7966@sergelap.austin.ibm.com> <OFE00FE25C.725B5669-ON872570B5.0066EFF0-862570B5.00679646@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OFE00FE25C.725B5669-ON872570B5.0066EFF0-862570B5.00679646@us.ibm.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Linda Xie (lxie@us.ibm.com):
> Hi Andrew,
> 
> It seems that the latest mm1 doesn't have  the following patch that John 
> Rose sent on last Friday.

One more thing seems to be missing.  -mm2 compiles and boots if
i add:

Signed-off-by: Serge Hallyn <serue@us.ibm.com>
---

Index: linux-2.6.14-mm2/drivers/pci/hotplug/rpaphp_pci.c
===================================================================
--- linux-2.6.14-mm2.orig/drivers/pci/hotplug/rpaphp_pci.c	2005-11-11 11:42:21.000000000 -0600
+++ linux-2.6.14-mm2/drivers/pci/hotplug/rpaphp_pci.c	2005-11-11 11:48:40.000000000 -0600
@@ -253,7 +253,7 @@ rpaphp_pci_config_slot(struct pci_bus *b
 	if (!dn || !dn->child)
 		return NULL;
 
-	if (systemcfg->platform == PLATFORM_PSERIES_LPAR) {
+	if (_machine == PLATFORM_PSERIES_LPAR) {
 		of_scan_bus(dn, bus);
 		if (list_empty(&bus->devices)) {
 			err("%s: No new device found\n", __FUNCTION__);
