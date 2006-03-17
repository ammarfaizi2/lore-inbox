Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751311AbWCQEso@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751311AbWCQEso (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Mar 2006 23:48:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751340AbWCQEsn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Mar 2006 23:48:43 -0500
Received: from mx1.suse.de ([195.135.220.2]:42985 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751305AbWCQEsm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Mar 2006 23:48:42 -0500
From: NeilBrown <neilb@suse.de>
To: Andrew Morton <akpm@osdl.org>
Date: Fri, 17 Mar 2006 15:47:26 +1100
Message-Id: <1060317044726.16023@suse.de>
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Cc: linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 001 of 13] md: Add '4' to the list of levels for which bitmaps are supported.
References: <20060317154017.15880.patches@notabene>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I really should make this a function of the personality....


Signed-off-by: Neil Brown <neilb@suse.de>

### Diffstat output
 ./drivers/md/md.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff ./drivers/md/md.c~current~ ./drivers/md/md.c
--- ./drivers/md/md.c~current~	2006-03-17 11:45:43.000000000 +1100
+++ ./drivers/md/md.c	2006-03-17 11:48:08.000000000 +1100
@@ -763,7 +763,8 @@ static int super_90_validate(mddev_t *md
 
 		if (sb->state & (1<<MD_SB_BITMAP_PRESENT) &&
 		    mddev->bitmap_file == NULL) {
-			if (mddev->level != 1 && mddev->level != 5 && mddev->level != 6
+			if (mddev->level != 1 && mddev->level != 4
+			    && mddev->level != 5 && mddev->level != 6
 			    && mddev->level != 10) {
 				/* FIXME use a better test */
 				printk(KERN_WARNING "md: bitmaps not supported for this level.\n");
