Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932718AbWCQHXM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932718AbWCQHXM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Mar 2006 02:23:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752561AbWCQHXI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Mar 2006 02:23:08 -0500
Received: from cantor.suse.de ([195.135.220.2]:52360 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1752560AbWCQHXC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Mar 2006 02:23:02 -0500
From: NeilBrown <neilb@suse.de>
To: Andrew Morton <akpm@osdl.org>
Date: Fri, 17 Mar 2006 18:21:46 +1100
Message-Id: <1060317072146.28668@suse.de>
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Cc: linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 005 of 6] md: Remove some stray semi-colons after functions called in macro....
References: <20060317181912.28543.patches@notabene>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


wait_event_lock_irq puts a ';' after its usage of the 4th arg, so we
don't need to.

Signed-off-by: Neil Brown <neilb@suse.de>

### Diffstat output
 ./drivers/md/raid5.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff ./drivers/md/raid5.c~current~ ./drivers/md/raid5.c
--- ./drivers/md/raid5.c~current~	2006-03-17 18:18:44.000000000 +1100
+++ ./drivers/md/raid5.c	2006-03-17 18:18:48.000000000 +1100
@@ -262,7 +262,7 @@ static struct stripe_head *get_active_st
 						     < (conf->max_nr_stripes *3/4)
 						     || !conf->inactive_blocked),
 						    conf->device_lock,
-						    unplug_slaves(conf->mddev);
+						    unplug_slaves(conf->mddev)
 					);
 				conf->inactive_blocked = 0;
 			} else
@@ -405,7 +405,7 @@ static int resize_stripes(raid5_conf_t *
 		wait_event_lock_irq(conf->wait_for_stripe,
 				    !list_empty(&conf->inactive_list),
 				    conf->device_lock,
-				    unplug_slaves(conf->mddev);
+				    unplug_slaves(conf->mddev)
 			);
 		osh = get_free_stripe(conf);
 		spin_unlock_irq(&conf->device_lock);
