Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751123AbWH2FjY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751123AbWH2FjY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Aug 2006 01:39:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751124AbWH2FjY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Aug 2006 01:39:24 -0400
Received: from ns2.suse.de ([195.135.220.15]:17110 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751123AbWH2FjX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Aug 2006 01:39:23 -0400
From: NeilBrown <neilb@suse.de>
To: Andrew Morton <akpm@osdl.org>
Date: Tue, 29 Aug 2006 15:39:11 +1000
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Cc: linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 000 of 4] md: Introduction
Message-ID: <20060829153414.6475.patches@notabene>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Following are 4 patches for md, suitable for 2.6.19.

The first three define "congested_fn" functions for various raid level -
I all just found out about the need for these.  These could address 
responsiveness problems that some people have reported, particularly
while resync is running.

The last improves some messages when resync happens so e.g. it doesn't
like your array is being resynced when you only asked for it to be checked.

Thanks,
NeilBrown


 [PATCH 001 of 4] md: Define backing_dev_info.congested_fn for raid0 and linear
 [PATCH 002 of 4] md: Define ->congested_fn for raid1, raid10, and multipath
 [PATCH 003 of 4] md: Add a ->congested_fn function for raid5/6
 [PATCH 004 of 4] md: Make messages about resync/recovery etc more specific.
