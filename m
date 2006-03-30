Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751070AbWC3FyS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751070AbWC3FyS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Mar 2006 00:54:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751083AbWC3FyS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Mar 2006 00:54:18 -0500
Received: from cantor2.suse.de ([195.135.220.15]:11680 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751070AbWC3FyR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Mar 2006 00:54:17 -0500
From: NeilBrown <neilb@suse.de>
To: Andrew Morton <akpm@osdl.org>
Date: Thu, 30 Mar 2006 16:52:33 +1100
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Cc: linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 000 of 3] md: Introduction - assorted fixed for 2.6.16
Message-ID: <20060330164933.25210.patches@notabene>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Following are three patches for md.  The first fixes a problem that
can cause corruption in fairly unusual circumstances (re-adding a
device to a raid1 and suffering write-errors that are subsequntly
fixed and the device is re-added again).

The other two fix minor problems

The are suitable to go straight in to 2.6.17-rc.

NeilBrown

 [PATCH 001 of 3] md: Don't clear bits in bitmap when writing to one device fails during recovery.
 [PATCH 002 of 3] md: Remove some code that can sleep from under a spinlock.
 [PATCH 003 of 3] md: Raid-6 did not create sysfs entries for stripe cache
