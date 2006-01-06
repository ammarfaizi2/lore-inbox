Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751491AbWAFPRN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751491AbWAFPRN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jan 2006 10:17:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750876AbWAFPQs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jan 2006 10:16:48 -0500
Received: from perninha.conectiva.com.br ([200.140.247.100]:1690 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id S1751491AbWAFPQq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jan 2006 10:16:46 -0500
Date: Fri, 6 Jan 2006 13:05:13 -0200
From: Luiz Fernando Capitulino <lcapitulino@mandriva.com.br>
To: akpm <akpm@osdl.org>
Cc: tadavis@lbl.gov, netdev@oss.sgi.com, lkml <linux-kernel@vger.kernel.org>
Subject: [PATCH] bonding: Sparse warnings fix.
Message-Id: <20060106130513.1d1ac97f.lcapitulino@mandriva.com.br>
Organization: Mandriva
X-Mailer: Sylpheed version 1.0.5 (GTK+ 1.2.10; i586-mandriva-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


 Fixes the following sparse warnings:

drivers/net/bonding/bond_sysfs.c:263:27: warning: Using plain integer as NULL pointer
drivers/net/bonding/bond_sysfs.c:998:26: warning: Using plain integer as NULL pointer
drivers/net/bonding/bond_sysfs.c:1126:26: warning: Using plain integer as NULL pointer

Signed-off-by: Luiz Capitulino <lcapitulino@mandriva.com.br>

 drivers/net/bonding/bond_sysfs.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/bonding/bond_sysfs.c b/drivers/net/bonding/bond_sysfs.c
index 32d13da..041bcc5 100644
--- a/drivers/net/bonding/bond_sysfs.c
+++ b/drivers/net/bonding/bond_sysfs.c
@@ -260,7 +260,7 @@ static ssize_t bonding_store_slaves(stru
 	char *ifname;
 	int i, res, found, ret = count;
 	struct slave *slave;
-	struct net_device *dev = 0;
+	struct net_device *dev = NULL;
 	struct bonding *bond = to_bond(cd);
 
 	/* Quick sanity check -- is the bond interface up? */
@@ -995,7 +995,7 @@ static ssize_t bonding_store_primary(str
 			printk(KERN_INFO DRV_NAME
 			       ": %s: Setting primary slave to None.\n",
 			       bond->dev->name);
-			bond->primary_slave = 0;
+			bond->primary_slave = NULL;
 				bond_select_active_slave(bond);
 		} else {
 			printk(KERN_INFO DRV_NAME
@@ -1123,7 +1123,7 @@ static ssize_t bonding_store_active_slav
 			printk(KERN_INFO DRV_NAME
 			       ": %s: Setting active slave to None.\n",
 			       bond->dev->name);
-			bond->primary_slave = 0;
+			bond->primary_slave = NULL;
 				bond_select_active_slave(bond);
 		} else {
 			printk(KERN_INFO DRV_NAME


-- 
Luiz Fernando N. Capitulino
