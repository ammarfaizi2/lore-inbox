Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751617AbWDOVRM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751617AbWDOVRM (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Apr 2006 17:17:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751618AbWDOVRM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Apr 2006 17:17:12 -0400
Received: from ogre.sisk.pl ([217.79.144.158]:12168 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S1751612AbWDOVRL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Apr 2006 17:17:11 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Andrew Morton <akpm@osdl.org>
Subject: [PATCH] pnp: fix two messages in manager.c
Date: Sat, 15 Apr 2006 23:15:53 +0200
User-Agent: KMail/1.9.1
Cc: LKML <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@suse.cz>,
       Jan Engelhardt <jengelh@linux01.gwdg.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200604152315.54088.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jan Engelhardt <jengelh@gmx.de>

The wording of two messages in drivers/pnp/manager.c is incorrect.  Fix that.

Signed-off-by: Jan Engelhardt <jengelh@gmx.de>
Acked-by: Pavel Machek <pavel@suse.cz>
Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 drivers/pnp/manager.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

Index: linux-2.6.17-rc1-mm2/drivers/pnp/manager.c
===================================================================
--- linux-2.6.17-rc1-mm2.orig/drivers/pnp/manager.c
+++ linux-2.6.17-rc1-mm2/drivers/pnp/manager.c
@@ -483,7 +483,7 @@ int pnp_auto_config_dev(struct pnp_dev *
 int pnp_start_dev(struct pnp_dev *dev)
 {
 	if (!pnp_can_write(dev)) {
-		pnp_info("Device %s does not supported activation.", dev->dev.bus_id);
+		pnp_info("Device %s does not support activation.", dev->dev.bus_id);
 		return -EINVAL;
 	}
 
@@ -507,7 +507,7 @@ int pnp_start_dev(struct pnp_dev *dev)
 int pnp_stop_dev(struct pnp_dev *dev)
 {
 	if (!pnp_can_disable(dev)) {
-		pnp_info("Device %s does not supported disabling.", dev->dev.bus_id);
+		pnp_info("Device %s does not support disabling.", dev->dev.bus_id);
 		return -EINVAL;
 	}
 	if (dev->protocol->disable(dev)<0) {
