Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750883AbWH2BaV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750883AbWH2BaV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Aug 2006 21:30:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750905AbWH2BaU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Aug 2006 21:30:20 -0400
Received: from ns1.suse.de ([195.135.220.2]:904 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1750867AbWH2BaU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Aug 2006 21:30:20 -0400
From: NeilBrown <neilb@suse.de>
To: Andrew Morton <akpm@osdl.org>
Date: Tue, 29 Aug 2006 11:30:15 +1000
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Cc: v9fs-developer@lists.sourceforge.net, trond.myklebust@fys.uio.no,
       Andrea Arcangeli <andrea@suse.de>, linux-kernel@vger.kernel.org
Subject: [PATCH 000 of 2] Invalidate_inode_pages2 changes.
Message-ID: <20060829111641.18391.patches@notabene>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,
 I'm picking up on a conversation that was started in late March
 this year, and which didn't get anywhere much.
 See
   http://lkml.org/lkml/2006/3/31/93
 and following.

 The issue is that it is possible for an NFS client to lose writes
 if a particular race is lost - and this has been seen in real life.

 The patch discussed in the above mentioned converstation made two
 changes, one of which was completely right.  The over was slightly wrong. 

 Having explored the issue in some depth I now see how it was wrong
 and present below for your enjoyment two patches.  One which makes 
 and justifies the first change.  One which makes and justifies a
 revised version of the second change.

Thanks,
NeilBrown


 [PATCH 001 of 2] Invalidate_inode_pages2 shouldn't abort on first error.
 [PATCH 002 of 2] Make data destruction in invalidate_inode_pages2 optional.
