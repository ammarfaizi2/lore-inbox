Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751788AbWFAFNj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751788AbWFAFNj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jun 2006 01:13:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751475AbWFAFNj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jun 2006 01:13:39 -0400
Received: from cantor2.suse.de ([195.135.220.15]:10153 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751229AbWFAFNh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jun 2006 01:13:37 -0400
From: NeilBrown <neilb@suse.de>
To: Andrew Morton <akpm@osdl.org>
Date: Thu, 1 Jun 2006 15:13:27 +1000
Message-Id: <1060601051327.27557@suse.de>
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Cc: linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 002 of 10] md: Fix Kconfig error
References: <20060601150955.27444.patches@notabene>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


RAID5 recently changed to RAID456

Signed-off-by: Neil Brown <neilb@suse.de>

### Diffstat output
 ./drivers/md/Kconfig |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff ./drivers/md/Kconfig~current~ ./drivers/md/Kconfig
--- ./drivers/md/Kconfig~current~	2006-06-01 15:04:25.000000000 +1000
+++ ./drivers/md/Kconfig	2006-06-01 15:05:17.000000000 +1000
@@ -137,7 +137,7 @@ config MD_RAID456
 
 config MD_RAID5_RESHAPE
 	bool "Support adding drives to a raid-5 array (experimental)"
-	depends on MD_RAID5 && EXPERIMENTAL
+	depends on MD_RAID456 && EXPERIMENTAL
 	---help---
 	  A RAID-5 set can be expanded by adding extra drives. This
 	  requires "restriping" the array which means (almost) every
