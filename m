Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751131AbVKKUGK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751131AbVKKUGK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Nov 2005 15:06:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751130AbVKKUGJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Nov 2005 15:06:09 -0500
Received: from e34.co.us.ibm.com ([32.97.110.152]:10944 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751128AbVKKUGI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Nov 2005 15:06:08 -0500
Subject: [PATCH 1 of 2] tpm: necessary PPC64 function exports
From: Kylene Jo Hall <kjhall@us.ibm.com>
To: linuxppc64-dev@ozlabs.org
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org,
       Jake Moilanen <moilanen@us.ibm.com>, Tom Lendacky <toml@us.ibm.com>
Content-Type: text/plain
Date: Fri, 11 Nov 2005 14:06:33 -0600
Message-Id: <1131739594.5048.14.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-7) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Some work is needed in the tpm device driver to discover the TPM out of
the device tree rather than based on set address on Power PPC.  This
patch exports a couple of functions for the parsing.

Signed-off-by: Kylene Hall <kjhall@us.ibm.com>
---

--- linux-2.6.14/arch/ppc64/kernel/prom.c.orig	2005-11-11 13:50:50.000000000 -0600
+++ linux-2.6.14/arch/ppc64/kernel/prom.c	2005-11-11 13:51:42.000000000 -0600
@@ -1261,6 +1261,7 @@ prom_n_addr_cells(struct device_node* np
 	/* No #address-cells property for the root node, default to 1 */
 	return 1;
 }
+EXPORT_SYMBOL_GPL(prom_n_addr_cells);
 
 int
 prom_n_size_cells(struct device_node* np)
@@ -1276,6 +1277,7 @@ prom_n_size_cells(struct device_node* np
 	/* No #size-cells property for the root node, default to 1 */
 	return 1;
 }
+EXPORT_SYMBOL_GPL(prom_n_size_cells);
 
 /**
  * Work out the sense (active-low level / active-high edge)


