Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750722AbWIMQiM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750722AbWIMQiM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Sep 2006 12:38:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750721AbWIMQiM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Sep 2006 12:38:12 -0400
Received: from mtagate3.de.ibm.com ([195.212.29.152]:24942 "EHLO
	mtagate3.de.ibm.com") by vger.kernel.org with ESMTP
	id S1750722AbWIMQiL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Sep 2006 12:38:11 -0400
Date: Wed, 13 Sep 2006 18:38:27 +0200
From: Cornelia Huck <cornelia.huck@de.ibm.com>
To: Greg K-H <greg@kroah.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [00/12] driver core fixes
Message-ID: <20060913183827.74530896@gondolin.boeblingen.de.ibm.com>
X-Mailer: Sylpheed-Claws 2.5.0-rc3 (GTK+ 2.8.20; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

following are hacked-up versions of the -mm patches

	more-driver-core-fixes-for-mm.patch
	yet-further-driver-core-fixes-for-mm.patch
	return-code-checking-for-make_class_name.patch

rebased against your kernel tree (as of yesterday).

Except for the rebase, they are basically unchanged from the version in
-mm (some things like bus_attach_device() no longer being tristate, and
class_device_rename() being gone). Patches 11 and 12 are new.

 [01/12] driver core fixes: make_class_name() retval check
 [02/12] driver core fixes: device_register() retval check in platform.c
 [03/12] driver core fixes: fixup platform_device_register_simple()
 [04/12] driver core fixes: retval check in class_register()
 [05/12] driver core fixes: sysfs_create_link() retval check in class.c
 [06/12] driver core fixes: bus_add_attrs() retval check
 [07/12] driver core fixes: bus_add_device() cleanup on error
 [08/12] driver core fixes: device_add() cleanup on error
 [09/12] driver core fixes: bus_attach_device() retval check
 [10/12] driver core fixes: sysfs_create_link() retval check in core.c
 [11/12] driver core fixes: device_create_file() retval check in dmapool.c
 [12/12] driver core fixes: sysfs_create_group() retval in topology.c

Most of the patches but 1, 8, 9 and 10 should be pretty independent of
each other. I'm not sure about patch 12, since the calling function
does not check the return code of topology_add_dev() (but what should
it do if it fails?).

-- 
Cornelia Huck
Linux for zSeries Developer
Tel.: +49-7031-16-4837, Mail: cornelia.huck@de.ibm.com
