Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965185AbWD1Cvj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965185AbWD1Cvj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Apr 2006 22:51:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965192AbWD1Cvj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Apr 2006 22:51:39 -0400
Received: from mx1.suse.de ([195.135.220.2]:13443 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S965185AbWD1Cvi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Apr 2006 22:51:38 -0400
From: NeilBrown <neilb@suse.de>
To: Andrew Morton <akpm@osdl.org>
Date: Fri, 28 Apr 2006 12:51:33 +1000
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Cc: linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
       stable@kernel.org
Subject: [PATCH 000 of 5] md: Introduction - assorted raid10/raid1 fixes
Message-ID: <20060428124313.29510.patches@notabene>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Following are 5 patches to md that are suitable for 2.6.17.

The first is also suitable for 2.6.16.something as it is an obvious
trivial fix for an oops. So it and this are cc:ed to stable@kernel.org

The first two fix problems with the attempt-to-fix-read-errors code in raid10.
The next three fix problems with the handling of BIO_RW_BARRIER requests in raid1.

All patches created against 2.6.17-rc2-mm1. First patch checked to apply to 2.6.16.11.

Thanks,
NeilBrown


 [PATCH 001 of 5] md: Avoid oops when attempting to fix read errors on raid10
 [PATCH 002 of 5] md: Fixed refcounting/locking when attempting read error correction in raid10
 [PATCH 003 of 5] md: Change ENOTSUPP to EOPNOTSUPP
 [PATCH 004 of 5] md: Improve detection of lack of barrier support in raid1
 [PATCH 005 of 5] md: Fix 'rdev->nr_pending' count when retrying barrier requests.
