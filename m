Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262807AbVDAXzW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262807AbVDAXzW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Apr 2005 18:55:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262961AbVDAXta
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Apr 2005 18:49:30 -0500
Received: from mail.kroah.org ([69.55.234.183]:27868 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262809AbVDAXsK convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Apr 2005 18:48:10 -0500
Cc: prarit@sgi.com
Subject: [PATCH] PCI Hotplug: add documentation about release pointer.
In-Reply-To: <11123992732278@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Fri, 1 Apr 2005 15:47:53 -0800
Message-Id: <1112399273300@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.2181.16.18, 2005/03/28 15:09:31-08:00, prarit@sgi.com

[PATCH] PCI Hotplug: add documentation about release pointer.

Adds "release" func pointer comments to nano-doc.

Signed-off-by: Prarit Bhargava <prarit@sgi.com>

Index: hp/drivers/pci/hotplug/pci_hotplug.h
===================================================================
RCS file: /usr/local/src/cvsroot/bk/linux-2.5/drivers/pci/hotplug/pci_hotplug.h,v
retrieving revision 1.1.1.1


 drivers/pci/hotplug/pci_hotplug.h |    2 ++
 1 files changed, 2 insertions(+)


diff -Nru a/drivers/pci/hotplug/pci_hotplug.h b/drivers/pci/hotplug/pci_hotplug.h
--- a/drivers/pci/hotplug/pci_hotplug.h	2005-04-01 15:33:50 -08:00
+++ b/drivers/pci/hotplug/pci_hotplug.h	2005-04-01 15:33:50 -08:00
@@ -152,6 +152,8 @@
  * @ops: pointer to the &struct hotplug_slot_ops to be used for this slot
  * @info: pointer to the &struct hotplug_slot_info for the inital values for
  * this slot.
+ * @release: called during pci_hp_deregister to free memory allocated in a
+ * hotplug_slot structure.
  * @private: used by the hotplug pci controller driver to store whatever it
  * needs.
  */

