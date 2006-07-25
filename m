Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932388AbWGYBzE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932388AbWGYBzE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jul 2006 21:55:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932389AbWGYBzE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jul 2006 21:55:04 -0400
Received: from cantor.suse.de ([195.135.220.2]:2284 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932388AbWGYBzB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jul 2006 21:55:01 -0400
From: NeilBrown <neilb@suse.de>
To: Andrew Morton <akpm@osdl.org>
Date: Tue, 25 Jul 2006 11:54:21 +1000
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Cc: nfs@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [PATCH 000 of 9] knfsd: Introduction
Message-ID: <20060725114207.21779.patches@notabene>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Following are 9 patches for knfsd in 2.6-18-rc1-mm2
They should be held for 2.6.19.

They comprise
 3 trivial cleanups from Greg Banks
 Some fixes/cleanups to socket/version selection code.
 Adding a 'portlist' file to the 'nfsd' filesystem.
  This can be used to open and close sockets used by the nfs server.
  New sockets are created in user-space and passed down by writing
   an 'fd' number.
  Old sockets are closed by finding the appropriate name in 'portlist'
  and writing it back to 'portlist' preceded by a '-'.

nfs-utils-1.0.9 can work with 'portlist' to e.g. control which
protocol (udp or tcp) is used.  However it has other problems:
 rpc.nfsd 0
will no longer stop all nfsd threads.  So there will be a 1.0.10 shortly.

NeilBrown

 [PATCH 001 of 9] knfsd: knfsd: Add some missing newlines in printks
 [PATCH 002 of 9] knfsd: knfsd: Remove an unused variable from e_show().
 [PATCH 003 of 9] knfsd: knfsd: Remove an unused variable from auth_unix_lookup()
 [PATCH 004 of 9] knfsd: Add a callback for when last rpc thread finishes.
 [PATCH 005 of 9] knfsd: Be more selective in which sockets lockd listens on.
 [PATCH 006 of 9] knfsd: Remove nfsd_versbits as intermediate storage for desired versions.
 [PATCH 007 of 9] knfsd: Separate out some parts of nfsd_svc, which start nfs servers.
 [PATCH 008 of 9] knfsd: Define new nfsdfs file: portlist - contains list of ports.
 [PATCH 009 of 9] knfsd: Allow sockets to be passed to nfsd via 'portlist'
