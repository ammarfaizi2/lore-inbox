Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422992AbWBBGCM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422992AbWBBGCM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Feb 2006 01:02:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422991AbWBBGCM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Feb 2006 01:02:12 -0500
Received: from ns1.suse.de ([195.135.220.2]:38882 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1422986AbWBBGCL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Feb 2006 01:02:11 -0500
From: NeilBrown <neilb@suse.de>
To: Andrew Morton <akpm@osdl.org>
Date: Thu, 2 Feb 2006 17:02:01 +1100
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Cc: linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 000 of 3] md: Introduction
Message-ID: <20060202165638.15890.patches@notabene>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Three patches for 2.6.lastest. All should go in 2.6.16.
One won't apply against -rc1-git5 as it fixes a bug in a patch
in -mm that hasn't quite got to -linus yes.

They are mostly little fixes.  I've been doing some more testing,
particularly creating a raid1 over 2 6TB arrays.  This requires
version-1 superblocks, so they have had a bit more testing too.

(No, I didn't try to resync the 6TB raid1.  I created it 
--assume-clean and gave it a write-intent bitmap so a full resync
would never be needed.  If one side died, a recovery would take
ages!!!! but for me it was only an experiment, not a serious configuration).
(You will need mdadm-2.3 if you too want a 6TB raid1).


 [PATCH 001 of 3] md: Handle overflow of mdu_array_info_t->size better.
 [PATCH 002 of 3] md: Assorted little md fixes:
 [PATCH 003 of 3] md: Make sure rdev->size gets set for version-1 superblocks.
