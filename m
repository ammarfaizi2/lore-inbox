Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266748AbUHOOzh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266748AbUHOOzh (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Aug 2004 10:55:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266796AbUHOOwl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Aug 2004 10:52:41 -0400
Received: from mx1.redhat.com ([66.187.233.31]:55514 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S266737AbUHOOv7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Aug 2004 10:51:59 -0400
Date: Sun, 15 Aug 2004 10:51:02 -0400
From: Alan Cox <alan@redhat.com>
To: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: PATCH: ide-probe language bugs and mark a fix me
Message-ID: <20040815145102.GA9579@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.8-rc3/drivers/ide/ide-probe.c linux-2.6.8-rc3/drivers/ide/ide-probe.c
--- linux.vanilla-2.6.8-rc3/drivers/ide/ide-probe.c	2004-08-09 15:51:00.000000000 +0100
+++ linux-2.6.8-rc3/drivers/ide/ide-probe.c	2004-08-14 21:03:03.000000000 +0100
@@ -906,11 +961,11 @@
 	/* When we have an IOMMU, we may have a problem where pci_map_sg()
 	 * creates segments that don't completely match our boundary
 	 * requirements and thus need to be broken up again. Because it
-	 * doesn't align properly neither, we may actually have to break up
+	 * doesn't align properly either, we may actually have to break up
 	 * to more segments than what was we got in the first place, a max
 	 * worst case is twice as many.
 	 * This will be fixed once we teach pci_map_sg() about our boundary
-	 * requirements, hopefully soon
+	 * requirements, hopefully soon  *FIXME*
 	 */
 	if (!PCI_DMA_BUS_IS_PHYS)
 		max_sg_entries >>= 1;

Signed-off-by: Alan Cox <alan@redhat.com>

