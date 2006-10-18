Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422815AbWJRURr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422815AbWJRURr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Oct 2006 16:17:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422634AbWJRUQ3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Oct 2006 16:16:29 -0400
Received: from cantor2.suse.de ([195.135.220.15]:40682 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1422864AbWJRUJn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Oct 2006 16:09:43 -0400
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Cc: Cornelia Huck <cornelia.huck@de.ibm.com>,
       Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 12/16] driver core fixes: sysfs_create_group() retval in topology.c
Date: Wed, 18 Oct 2006 13:09:03 -0700
Message-Id: <11612021841579-git-send-email-greg@kroah.com>
X-Mailer: git-send-email 1.4.2.4
In-Reply-To: <11612021801495-git-send-email-greg@kroah.com>
References: <20061018195833.GA21808@kroah.com> <1161202147758-git-send-email-greg@kroah.com> <11612021503109-git-send-email-greg@kroah.com> <1161202153578-git-send-email-greg@kroah.com> <11612021563449-git-send-email-greg@kroah.com> <11612021603361-git-send-email-greg@kroah.com> <1161202163247-git-send-email-greg@kroah.com> <1161202166551-git-send-email-greg@kroah.com> <11612021701905-git-send-email-greg@kroah.com> <11612021733101-git-send-email-greg@kroah.com> <11612021771048-git-send-email-greg@kroah.com> <11612021801495-git-send-email-greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Cornelia Huck <cornelia.huck@de.ibm.com>

Return the return value of sysfs_create_group() in topology_add_dev().

Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 drivers/base/topology.c |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/drivers/base/topology.c b/drivers/base/topology.c
index 3ef9d51..28dccb7 100644
--- a/drivers/base/topology.c
+++ b/drivers/base/topology.c
@@ -97,8 +97,7 @@ static struct attribute_group topology_a
 /* Add/Remove cpu_topology interface for CPU device */
 static int __cpuinit topology_add_dev(struct sys_device * sys_dev)
 {
-	sysfs_create_group(&sys_dev->kobj, &topology_attr_group);
-	return 0;
+	return sysfs_create_group(&sys_dev->kobj, &topology_attr_group);
 }
 
 static int __cpuinit topology_remove_dev(struct sys_device * sys_dev)
-- 
1.4.2.4

