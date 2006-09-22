Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751130AbWIVJit@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751130AbWIVJit (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Sep 2006 05:38:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751133AbWIVJh2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Sep 2006 05:37:28 -0400
Received: from mtagate4.de.ibm.com ([195.212.29.153]:46927 "EHLO
	mtagate4.de.ibm.com") by vger.kernel.org with ESMTP
	id S1751130AbWIVJhK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Sep 2006 05:37:10 -0400
Date: Fri, 22 Sep 2006 11:37:32 +0200
From: Cornelia Huck <cornelia.huck@de.ibm.com>
To: Greg K-H <greg@kroah.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [9/9] driver core fixes: sysfs_create_group() retval in topology.c
Message-ID: <20060922113732.2aa3eabb@gondolin.boeblingen.de.ibm.com>
X-Mailer: Sylpheed-Claws 2.5.0-rc3 (GTK+ 2.8.20; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Cornelia Huck <cornelia.huck@de.ibm.com>

Return the return value of sysfs_create_group() in topology_add_dev().

Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>

---
 drivers/base/topology.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

--- linux-2.6-CH.orig/drivers/base/topology.c
+++ linux-2.6-CH/drivers/base/topology.c
@@ -97,8 +97,7 @@ static struct attribute_group topology_a
 /* Add/Remove cpu_topology interface for CPU device */
 static int __cpuinit topology_add_dev(struct sys_device * sys_dev)
 {
-	sysfs_create_group(&sys_dev->kobj, &topology_attr_group);
-	return 0;
+	return sysfs_create_group(&sys_dev->kobj, &topology_attr_group);
 }
 
 static int __cpuinit topology_remove_dev(struct sys_device * sys_dev)
