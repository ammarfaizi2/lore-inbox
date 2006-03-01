Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751117AbWCAVp7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751117AbWCAVp7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Mar 2006 16:45:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751150AbWCAVp7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Mar 2006 16:45:59 -0500
Received: from dsl093-040-174.pdx1.dsl.speakeasy.net ([66.93.40.174]:59279
	"EHLO aria.kroah.org") by vger.kernel.org with ESMTP
	id S1751117AbWCAVp7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Mar 2006 16:45:59 -0500
Date: Wed, 1 Mar 2006 13:46:00 -0800
From: Greg KH <greg@kroah.com>
To: paulus@samba.org, linuxppc64-dev@ozlabs.org
Cc: torvalds@osdl.org, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: fix build breakage in eeh.c in 2.6.16-rc5-git5
Message-ID: <20060301214600.GA17702@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch should fixe a problem with eeh_add_device_late() not being
defined in the ppc64 build process, causing the build to break.

Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 include/asm-powerpc/eeh.h |    1 +
 1 files changed, 1 insertion(+)

--- linux-2.6.15.orig/include/asm-powerpc/eeh.h	2006-03-01 11:30:19.000000000 -0800
+++ linux-2.6.15/include/asm-powerpc/eeh.h	2006-03-01 12:04:25.000000000 -0800
@@ -61,6 +61,7 @@
  * to finish the eeh setup for this device.
  */
 void eeh_add_device_early(struct device_node *);
+void eeh_add_device_late(struct pci_dev *dev);
 void eeh_add_device_tree_early(struct device_node *);
 void eeh_add_device_tree_late(struct pci_bus *);
 
