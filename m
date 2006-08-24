Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750765AbWHXHUP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750765AbWHXHUP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Aug 2006 03:20:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750791AbWHXHUN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Aug 2006 03:20:13 -0400
Received: from mx1.suse.de ([195.135.220.2]:43729 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1750765AbWHXHUL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Aug 2006 03:20:11 -0400
From: NeilBrown <neilb@suse.de>
To: Andrew Morton <akpm@osdl.org>
Date: Thu, 24 Aug 2006 17:20:13 +1000
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Cc: linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 000 of 2] md: Fix a bug with backward event updates.
Message-ID: <20060824171215.14077.patches@notabene>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

There is a bug in 2.6.18-rc which needs to be fixed before -final,
but there is a patch in -mm which is not scheduled for 2.6.18 which
touches the same code - so that patch has to change.

So:
 wind back to 
    md-replace-magic-numbers-in-sb_dirty-with-well-defined-bit-flags.patch
 discard that patch.
 Apply 1 of 2 following - that needs to go to Linux (or Greg)
 Then apply 2 of 2 to replace the one that was removed.
 Then you should be able to wind forwards again and everything will apply.

(If there is some other way you would like me to deal with this
 situation - just say so).

Thanks,
NeilBrown


 [PATCH 001 of 2] md: Avoid backward event updates in md superblock when degraded.
 [PATCH 002 of 2] md: replace magic numbers in sb_dirty with well defined bit flags
