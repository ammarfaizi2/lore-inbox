Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750871AbWEAFbJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750871AbWEAFbJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 May 2006 01:31:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750872AbWEAFbF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 May 2006 01:31:05 -0400
Received: from ns.suse.de ([195.135.220.2]:16042 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1750871AbWEAFaT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 May 2006 01:30:19 -0400
From: NeilBrown <neilb@suse.de>
To: Andrew Morton <akpm@osdl.org>
Date: Mon, 1 May 2006 15:30:14 +1000
Message-Id: <1060501053014.22937@suse.de>
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Cc: linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 003 of 11] md: Remove useless ioctl warning.
References: <20060501152229.18367.patches@notabene>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This warning was slightly useful back in 2.2 days, but is more
an annoyance now.  It makes it awkward to add new ioctls (that we we are
likely to do that in the current climate, but it is possible).

Signed-off-by: Neil Brown <neilb@suse.de>

### Diffstat output
 ./drivers/md/md.c |    5 -----
 1 file changed, 5 deletions(-)

diff ./drivers/md/md.c~current~ ./drivers/md/md.c
--- ./drivers/md/md.c~current~	2006-05-01 15:09:20.000000000 +1000
+++ ./drivers/md/md.c	2006-05-01 15:10:17.000000000 +1000
@@ -3964,11 +3964,6 @@ static int md_ioctl(struct inode *inode,
 			goto done_unlock;
 
 		default:
-			if (_IOC_TYPE(cmd) == MD_MAJOR)
-				printk(KERN_WARNING "md: %s(pid %d) used"
-					" obsolete MD ioctl, upgrade your"
-					" software to use new ictls.\n",
-					current->comm, current->pid);
 			err = -EINVAL;
 			goto abort_unlock;
 	}
