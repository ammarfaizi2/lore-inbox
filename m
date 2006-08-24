Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030335AbWHXGg2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030335AbWHXGg2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Aug 2006 02:36:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030337AbWHXGg2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Aug 2006 02:36:28 -0400
Received: from cantor.suse.de ([195.135.220.2]:32454 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1030335AbWHXGg2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Aug 2006 02:36:28 -0400
From: NeilBrown <neilb@suse.de>
To: Andrew Morton <akpm@osdl.org>
Date: Thu, 24 Aug 2006 16:36:29 +1000
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Cc: nfs@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [PATCH 000 of 11] knfsd: Introduction
Message-ID: <20060824162917.3600.patches@notabene>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Following are 11 patch for knfsd against
 2.6.18-rc4-mm2 plus  nfsd-lockdep-annotation.patch
 (the first patch being a fix for that patch).

They are all appropriate for 2.6.19, not 2.6.18.

The batch in the middle (6-9) allow nfsd to handle IO requests
of up to 1Megabyte (rather than the current limit of 32K).
This only applies on TCP connections.  This has not 
been heavily tested...
The max size to allow is configurable via the nfsd filesystem,
and defaults to something that I hope is reasonable.

This set also includes a few more scalability patches from Greg Banks.

NeilBrown


 [PATCH 001 of 11] knfsd: nfsd: lockdep annotation fix
 [PATCH 002 of 11] knfsd: Fix a botched comment from the last patchset
 [PATCH 003 of 11] knfsd: call lockd_down when closing a socket via a write to nfsd/portlist
 [PATCH 004 of 11] knfsd: Protect update to sn_nrthreads with lock_kernel
 [PATCH 005 of 11] knfsd: Fixed handling of lockd fail when adding nfsd socket.
 [PATCH 006 of 11] knfsd: Replace two page lists in struct svc_rqst with one.
 [PATCH 007 of 11] knfsd: Avoid excess stack usage in svc_tcp_recvfrom
 [PATCH 008 of 11] knfsd: Prepare knfsd for support of rsize/wsize of up to 1MB, over TCP.
 [PATCH 009 of 11] knfsd: Allow max size of NFSd payload to be configured.
 [PATCH 010 of 11] knfsd: make nfsd readahead params cache SMP-friendly
 [PATCH 011 of 11] knfsd: knfsd: cache ipmap per TCP socket
