Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750756AbWIMQjT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750756AbWIMQjT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Sep 2006 12:39:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750755AbWIMQjF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Sep 2006 12:39:05 -0400
Received: from mtagate3.de.ibm.com ([195.212.29.152]:28270 "EHLO
	mtagate3.de.ibm.com") by vger.kernel.org with ESMTP
	id S1750752AbWIMQis (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Sep 2006 12:38:48 -0400
Date: Wed, 13 Sep 2006 18:39:07 +0200
From: Cornelia Huck <cornelia.huck@de.ibm.com>
To: Greg K-H <greg@kroah.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [12/12] driver core fixes: sysfs_create_group() retval in
 topology.c
Message-ID: <20060913183907.44d49b85@gondolin.boeblingen.de.ibm.com>
In-Reply-To: <20060913163007.21cf10a8@gondolin.boeblingen.de.ibm.com>
References: <20060913163007.21cf10a8@gondolin.boeblingen.de.ibm.com>
X-Mailer: Sylpheed-Claws 2.5.0-rc3 (GTK+ 2.8.20; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Cornelia Huck <cornelia.huck@de.ibm.com>

Return the return value of sysfs_create_group() in topology_add_dev().

Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>

 topology.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

--- linux-2.6.18-rc6/drivers/base/topology.c	2006-09-04 04:19:48.000000000 +0200
+++ linux-2.6.18-rc6+CH/drivers/base/topology.c	2006-09-13 10:53:29.000000000 +0200
@@ -97,8 +97,7 @@ static struct attribute_group topology_a
 /* Add/Remove cpu_topology interface for CPU device */
 static int __cpuinit topology_add_dev(struct sys_device * sys_dev)
 {
-	sysfs_create_group(&sys_dev->kobj, &topology_attr_group);
-	return 0;
+	return sysfs_create_group(&sys_dev->kobj, &topology_attr_group);
 }
 
 static int __cpuinit topology_remove_dev(struct sys_device * sys_dev)
