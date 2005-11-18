Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932291AbVKRDdo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932291AbVKRDdo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Nov 2005 22:33:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751519AbVKRDdW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Nov 2005 22:33:22 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:54790 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751528AbVKRDdS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Nov 2005 22:33:18 -0500
Date: Fri, 18 Nov 2005 04:33:17 +0100
From: Adrian Bunk <bunk@stusta.de>
To: ctindel@users.sourceforge.net, fubar@us.ibm.com
Cc: bonding-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org
Subject: [2.6 patch] drivers/net/bonding/bonding.h: "extern inline" -> "static inline"
Message-ID: <20051118033317.GS11494@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"extern inline" doesn't make much sense.


Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 drivers/net/bonding/bonding.h |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

--- linux-2.6.15-rc1-mm1-full/drivers/net/bonding/bonding.h.old	2005-11-18 02:36:37.000000000 +0100
+++ linux-2.6.15-rc1-mm1-full/drivers/net/bonding/bonding.h	2005-11-18 02:37:05.000000000 +0100
@@ -218,7 +218,7 @@
  *
  * Caller must hold bond lock for read
  */
-extern inline struct slave *bond_get_slave_by_dev(struct bonding *bond, struct net_device *slave_dev)
+static inline struct slave *bond_get_slave_by_dev(struct bonding *bond, struct net_device *slave_dev)
 {
 	struct slave *slave = NULL;
 	int i;
@@ -232,7 +232,7 @@
 	return slave;
 }
 
-extern inline struct bonding *bond_get_bond_by_slave(struct slave *slave)
+static inline struct bonding *bond_get_bond_by_slave(struct slave *slave)
 {
 	if (!slave || !slave->dev->master) {
 		return NULL;
@@ -241,13 +241,13 @@
 	return (struct bonding *)slave->dev->master->priv;
 }
 
-extern inline void bond_set_slave_inactive_flags(struct slave *slave)
+static inline void bond_set_slave_inactive_flags(struct slave *slave)
 {
 	slave->state = BOND_STATE_BACKUP;
 	slave->dev->flags |= IFF_NOARP;
 }
 
-extern inline void bond_set_slave_active_flags(struct slave *slave)
+static inline void bond_set_slave_active_flags(struct slave *slave)
 {
 	slave->state = BOND_STATE_ACTIVE;
 	slave->dev->flags &= ~IFF_NOARP;

