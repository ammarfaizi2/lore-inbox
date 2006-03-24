Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423157AbWCXGAz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423157AbWCXGAz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Mar 2006 01:00:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423155AbWCXGAz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Mar 2006 01:00:55 -0500
Received: from mx2.suse.de ([195.135.220.15]:24474 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1423154AbWCXGAy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Mar 2006 01:00:54 -0500
From: NeilBrown <neilb@suse.de>
To: Andrew Morton <akpm@osdl.org>
Date: Fri, 24 Mar 2006 16:58:57 +1100
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Cc: linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 000 of 3] md: Introduction - 3 assorted md fixes
Message-ID: <20060324165531.2372.patches@notabene>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Three little fixes.
The last is possibly most interesting as it highlight how wrong I managed
to get the BIO_BARRIER stuff in raid1, which I really thought I had tested.

I'm happy of this and the previous collection of raid5-growth patches
to be merged into 2.6.17-rc1.  I had hoped the raid5-growth could sit
in -mm a bit longer, but I didn't get them there in time, and I'd
rather not wait until after 2.6.17.  They have received a reasonable
amount of testing both by me and others and appear to be safe.

Thanks,
NeilBrown

 [PATCH 001 of 3] md: Remove bi_end_io call out from under a spinlock.
 [PATCH 002 of 3] md: Fix md grow/size code to correctly find the maximum available space.
 [PATCH 003 of 3] md: Restore 'remaining' count when retrying an write operation.
