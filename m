Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266263AbUHYWxL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266263AbUHYWxL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Aug 2004 18:53:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266341AbUHYWwo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Aug 2004 18:52:44 -0400
Received: from mail.kroah.org ([69.55.234.183]:29339 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S266126AbUHYWgz convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Aug 2004 18:36:55 -0400
X-Donotread: and you are reading this why?
Subject: Re: [PATCH] Driver Core patches for 2.6.9-rc1
In-Reply-To: <10934733881526@kroah.com>
X-Patch: quite boring stuff, it's just source code...
Date: Wed, 25 Aug 2004 15:36:29 -0700
Message-Id: <10934733882615@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1876, 2004/08/25 13:23:15-07:00, romieu@fr.zoreil.com

[PATCH] pci-driver: function documentation fix

The returned value can not be null. Yet its description suggests differently.

From: Francois Romieu <romieu@fr.zoreil.com>
Signed-off-by: Andrew Morton <akpm@osdl.org>
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 drivers/pci/pci-driver.c |    7 +++----
 1 files changed, 3 insertions(+), 4 deletions(-)


diff -Nru a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
--- a/drivers/pci/pci-driver.c	2004-08-25 14:52:14 -07:00
+++ b/drivers/pci/pci-driver.c	2004-08-25 14:52:14 -07:00
@@ -390,10 +390,9 @@
  * pci_register_driver - register a new pci driver
  * @drv: the driver structure to register
  * 
- * Adds the driver structure to the list of registered drivers
- * Returns the number of pci devices which were claimed by the driver
- * during registration.  The driver remains registered even if the
- * return value is zero.
+ * Adds the driver structure to the list of registered drivers.
+ * Returns a negative value on error. The driver remains registered
+ * even if no device was claimed during registration.
  */
 int
 pci_register_driver(struct pci_driver *drv)

