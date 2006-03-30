Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751085AbWC3Fyy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751085AbWC3Fyy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Mar 2006 00:54:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751086AbWC3Fyx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Mar 2006 00:54:53 -0500
Received: from ns.suse.de ([195.135.220.2]:46769 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751091AbWC3FyZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Mar 2006 00:54:25 -0500
From: NeilBrown <neilb@suse.de>
To: Andrew Morton <akpm@osdl.org>
Date: Thu, 30 Mar 2006 16:52:47 +1100
Message-Id: <1060330055247.25295@suse.de>
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Cc: linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 003 of 3] md: Raid-6 did not create sysfs entries for stripe cache
References: <20060330164933.25210.patches@notabene>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Signed-off-by: Brad Campbell <brad@wasp.net.au>
Signed-off-by: Neil Brown <neilb@suse.de>

### Diffstat output
 ./drivers/md/raid6main.c |    2 ++
 1 file changed, 2 insertions(+)

diff ./drivers/md/raid6main.c~current~ ./drivers/md/raid6main.c
--- ./drivers/md/raid6main.c~current~	2006-03-30 16:48:30.000000000 +1100
+++ ./drivers/md/raid6main.c	2006-03-30 16:48:52.000000000 +1100
@@ -2151,6 +2151,8 @@ static int run(mddev_t *mddev)
 	}
 
 	/* Ok, everything is just fine now */
+	sysfs_create_group(&mddev->kobj, &raid6_attrs_group);
+
 	mddev->array_size =  mddev->size * (mddev->raid_disks - 2);
 
 	mddev->queue->unplug_fn = raid6_unplug_device;
