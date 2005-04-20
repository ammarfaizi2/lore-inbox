Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261688AbVDTTQq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261688AbVDTTQq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Apr 2005 15:16:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261692AbVDTTQq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Apr 2005 15:16:46 -0400
Received: from ns1.coraid.com ([65.14.39.133]:47017 "EHLO coraid.com")
	by vger.kernel.org with ESMTP id S261688AbVDTTQm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Apr 2005 15:16:42 -0400
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: linux-kernel@vger.kernel.org, greg@kroah.com
Subject: Re: [PATCH 2.6.12-rc2] aoe [5/6]: add firmware version to info in
 sysfs
References: <874qe1pejv.fsf@coraid.com> <87d5spnzsz.fsf@coraid.com>
	<20050420103723.52598eb8.rddunlap@osdl.org>
From: Ed L Cashin <ecashin@coraid.com>
Date: Wed, 20 Apr 2005 15:13:03 -0400
In-Reply-To: <20050420103723.52598eb8.rddunlap@osdl.org> (Randy Dunlap's
 message of "Wed, 20 Apr 2005 10:37:23 -0700")
Message-ID: <877jixmfcw.fsf@coraid.com>
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=

"Randy.Dunlap" <rddunlap@osdl.org> writes:

...
> so something like 'firmware-version' would be appreciated
> (for the sysfs filename).

Fair enough.  This patch follows and depends on the fifth patch of the
six.


use a more explicit filename for sysfs firmware version info

Signed-off-by: Ed L. Cashin <ecashin@coraid.com>


--=-=-=
Content-Disposition: inline; filename=patch-135

diff -urNp a-exp/linux/drivers/block/aoe/aoeblk.c b-exp/linux/drivers/block/aoe/aoeblk.c
--- a-exp/linux/drivers/block/aoe/aoeblk.c	2005-04-20 15:09:13.000000000 -0400
+++ b-exp/linux/drivers/block/aoe/aoeblk.c	2005-04-20 15:09:13.000000000 -0400
@@ -58,7 +58,7 @@ static struct disk_attribute disk_attr_n
 	.show = aoedisk_show_netif
 };
 static struct disk_attribute disk_attr_fwver = {
-	.attr = {.name = "fwver", .mode = S_IRUGO },
+	.attr = {.name = "firmware-version", .mode = S_IRUGO },
 	.show = aoedisk_show_fwver
 };
 
@@ -76,7 +76,7 @@ aoedisk_rm_sysfs(struct aoedev *d)
 	sysfs_remove_link(&d->gd->kobj, "state");
 	sysfs_remove_link(&d->gd->kobj, "mac");
 	sysfs_remove_link(&d->gd->kobj, "netif");
-	sysfs_remove_link(&d->gd->kobj, "fwver");
+	sysfs_remove_link(&d->gd->kobj, "firmware-version");
 }
 
 static int

--=-=-=




-- 
  Ed L Cashin <ecashin@coraid.com>

--=-=-=--

