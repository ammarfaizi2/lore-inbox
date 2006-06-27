Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030703AbWF0HTm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030703AbWF0HTm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 03:19:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030714AbWF0HTm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 03:19:42 -0400
Received: from ns2.suse.de ([195.135.220.15]:53414 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1030703AbWF0HTk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 03:19:40 -0400
From: NeilBrown <neilb@suse.de>
To: Andrew Morton <akpm@osdl.org>
Date: Tue, 27 Jun 2006 17:19:34 +1000
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Cc: nfs@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [PATCH 000 of 14] knfsd: Introduction
Message-ID: <20060627171533.26405.patches@notabene>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Following are 14 assorted patches for nfsd.
Patches are against 2.6.17-mm2 and are suitable for inclusion in 2.6.18.

Primarily minor bug fixes.

Last three patches are initial support for RPC privacy (i.e. decrypt
the RPC request and encrypt the reply).  This code is sub-optimal in
several ways (memcopys ...) which will probably get tidied up once we
determine the best way to do so.

Thanks,
NeilBrown

 [PATCH 001 of 14] knfsd: Improve the test for cross-device-rename in nfsd
 [PATCH 002 of 14] knfsd: Fixing missing 'expkey' support for fsid type 3
 [PATCH 003 of 14] knfsd: Remove noise about filehandle being uptodate.
 [PATCH 004 of 14] knfsd: Ignore ref_fh when crossing a mountpoint.
 [PATCH 005 of 14] knfsd: nfsd4: fix open_confirm locking
 [PATCH 006 of 14] knfsd: nfsd: call nfsd_setuser() on fh_compose(), fix nfsd4 permissions problem
 [PATCH 007 of 14] knfsd: nfsd4: remove superfluous grace period checks
 [PATCH 008 of 14] knfsd: nfsd: fix misplaced fh_unlock() in nfsd_link()
 [PATCH 009 of 14] knfsd: svcrpc: gss: simplify rsc_parse()
 [PATCH 010 of 14] knfsd: nfsd4: fix some open argument tests
 [PATCH 011 of 14] knfsd: nfsd4: fix open flag passing
 [PATCH 012 of 14] knfsd: svcrpc: Simplify nfsd rpcsec_gss integrity code
 [PATCH 013 of 14] knfsd: nfsd: mark rqstp to prevent use of sendfile in privacy case
 [PATCH 014 of 14] knfsd: svcrpc: gss: server-side implementation of rpcsec_gss privacy.
