Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263152AbVCDVXr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263152AbVCDVXr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Mar 2005 16:23:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263170AbVCDVOO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Mar 2005 16:14:14 -0500
Received: from mail.kroah.org ([69.55.234.183]:62881 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S263151AbVCDUy2 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Mar 2005 15:54:28 -0500
Cc: davej@redhat.com
Subject: [PATCH] Remove pci_dev->slot_name
In-Reply-To: <11099696352086@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Fri, 4 Mar 2005 12:53:55 -0800
Message-Id: <1109969635941@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1998.11.7, 2005/02/07 14:37:01-08:00, davej@redhat.com

[PATCH] Remove pci_dev->slot_name

This is a pointer to dev.bus_id, which is properly accessed through the
pci_name() function.

Signed-off-by: Dave Jones <davej@redhat.com>
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 include/linux/pci.h |    2 --
 1 files changed, 2 deletions(-)


diff -Nru a/include/linux/pci.h b/include/linux/pci.h
--- a/include/linux/pci.h	2005-03-04 12:43:26 -08:00
+++ b/include/linux/pci.h	2005-03-04 12:43:26 -08:00
@@ -549,8 +549,6 @@
 	unsigned int	irq;
 	struct resource resource[DEVICE_COUNT_RESOURCE]; /* I/O and memory regions + expansion ROMs */
 
-	char *		slot_name;	/* pointer to dev.bus_id */
-
 	/* These fields are used by common fixups */
 	unsigned int	transparent:1;	/* Transparent PCI bridge */
 	unsigned int	multifunction:1;/* Part of multi-function device */

