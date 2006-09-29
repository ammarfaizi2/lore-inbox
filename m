Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161111AbWI2Cy3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161111AbWI2Cy3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Sep 2006 22:54:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964948AbWI2Cxv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Sep 2006 22:53:51 -0400
Received: from mx2.suse.de ([195.135.220.15]:60087 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751023AbWI2CxQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Sep 2006 22:53:16 -0400
From: NeilBrown <neilb@suse.de>
To: Andrew Morton <akpm@osdl.org>
Date: Fri, 29 Sep 2006 12:53:10 +1000
Message-Id: <1060929025310.15229@suse.de>
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Cc: linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 003 of 6] md: Remove 'experimental' classification from raid5 reshape.
References: <20060929125047.14064.patches@notabene>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I have had enough success reports not to believe that this 
is safe for 2.6.19.


Signed-off-by: Neil Brown <neilb@suse.de>

### Diffstat output
 ./drivers/md/Kconfig |   10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff .prev/drivers/md/Kconfig ./drivers/md/Kconfig
--- .prev/drivers/md/Kconfig	2006-09-29 11:38:03.000000000 +1000
+++ ./drivers/md/Kconfig	2006-09-29 11:49:16.000000000 +1000
@@ -138,16 +138,16 @@ config MD_RAID456
 	  If unsure, say Y.
 
 config MD_RAID5_RESHAPE
-	bool "Support adding drives to a raid-5 array (experimental)"
-	depends on MD_RAID456 && EXPERIMENTAL
+	bool "Support adding drives to a raid-5 array"
+	depends on MD_RAID456
+	default y
 	---help---
 	  A RAID-5 set can be expanded by adding extra drives. This
 	  requires "restriping" the array which means (almost) every
 	  block must be written to a different place.
 
           This option allows such restriping to be done while the array
-	  is online.  However it is still EXPERIMENTAL code.  It should
-	  work, but please be sure that you have backups.
+	  is online.
 
 	  You will need mdadm version 2.4.1 or later to use this
 	  feature safely.  During the early stage of reshape there is
@@ -164,6 +164,8 @@ config MD_RAID5_RESHAPE
 	  There should be enough spares already present to make the new
 	  array workable.
 
+	  In unsure, say Y.
+
 config MD_MULTIPATH
 	tristate "Multipath I/O support"
 	depends on BLK_DEV_MD
