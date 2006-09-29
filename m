Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751375AbWI2CxI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751375AbWI2CxI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Sep 2006 22:53:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751381AbWI2CxI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Sep 2006 22:53:08 -0400
Received: from ns2.suse.de ([195.135.220.15]:58039 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751372AbWI2CxG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Sep 2006 22:53:06 -0400
From: NeilBrown <neilb@suse.de>
To: Andrew Morton <akpm@osdl.org>
Date: Fri, 29 Sep 2006 12:52:52 +1000
Message-Id: <1060929025252.15187@suse.de>
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Cc: linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Christian Kujau <evil@g-house.de>
Subject: [PATCH 001 of 6] md: Fix duplicity of levels in md.txt
References: <20060929125047.14064.patches@notabene>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


md.txt has two sections describing the 'level'
sysfs attribute, and some of the text is out-of-date.
So make just one section, and make it right.

Cc: Christian Kujau <evil@g-house.de>
Signed-off-by: Neil Brown <neilb@suse.de>

### Diffstat output
 ./Documentation/md.txt |   17 +++++------------
 1 file changed, 5 insertions(+), 12 deletions(-)

diff .prev/Documentation/md.txt ./Documentation/md.txt
--- .prev/Documentation/md.txt	2006-09-29 11:44:38.000000000 +1000
+++ ./Documentation/md.txt	2006-09-29 11:48:54.000000000 +1000
@@ -154,11 +154,12 @@ contains further md-specific information
 
 All md devices contain:
   level
-     a text file indicating the 'raid level'.  This may be a standard
-     numerical level prefixed by "RAID-" - e.g. "RAID-5", or some
-     other name such as "linear" or "multipath".
+     a text file indicating the 'raid level'. e.g. raid0, raid1,
+     raid5, linear, multipath, faulty.
      If no raid level has been set yet (array is still being
-     assembled), this file will be empty.
+     assembled), the value will reflect whatever has been written
+     to it, which may be a name like the above, or may be a number
+     such as '0', '5', etc.
 
   raid_disks
      a text file with a simple number indicating the number of devices
@@ -192,14 +193,6 @@ All md devices contain:
      1.2 (newer format in varying locations) or "none" indicating that
      the kernel isn't managing metadata at all.
 
-  level
-     The raid 'level' for this array.  The name will often (but not
-     always) be the same as the name of the module that implements the
-     level.  To be auto-loaded the module must have an alias
-        md-$LEVEL  e.g. md-raid5
-     This can be written only while the array is being assembled, not
-     after it is started.
-
   layout
      The "layout" for the array for the particular level.  This is
      simply a number that is interpretted differently by different
