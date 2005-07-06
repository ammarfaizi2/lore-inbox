Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262134AbVGGD32@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262134AbVGGD32 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Jul 2005 23:29:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262471AbVGFT5z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Jul 2005 15:57:55 -0400
Received: from mail.kroah.org ([69.55.234.183]:52921 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262171AbVGFQJm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Jul 2005 12:09:42 -0400
Date: Wed, 6 Jul 2005 09:09:38 -0700
From: Greg KH <gregkh@suse.de>
To: torvalds@osdl.org, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz
Subject: [PATCH] PCI: fix !CONFIG_HOTPLUG pci build problem
Message-ID: <20050706160938.GD13115@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here's a patch to fix the build issue when CONFIG_HOTPLUG is not enabled
in 2.6.13-rc2.

Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 drivers/pci/pci-driver.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

--- gregkh-2.6.orig/drivers/pci/pci-driver.c	2005-07-06 01:03:26.000000000 -0700
+++ gregkh-2.6/drivers/pci/pci-driver.c	2005-07-06 09:07:09.000000000 -0700
@@ -17,13 +17,13 @@
  * Dynamic device IDs are disabled for !CONFIG_HOTPLUG
  */
 
-#ifdef CONFIG_HOTPLUG
-
 struct pci_dynid {
 	struct list_head node;
 	struct pci_device_id id;
 };
 
+#ifdef CONFIG_HOTPLUG
+
 /**
  * store_new_id
  *
