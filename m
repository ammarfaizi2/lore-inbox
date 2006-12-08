Return-Path: <linux-kernel-owner+willy=40w.ods.org-S938052AbWLHMBi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S938052AbWLHMBi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Dec 2006 07:01:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S938056AbWLHMBi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Dec 2006 07:01:38 -0500
Received: from mail.suse.de ([195.135.220.2]:40758 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S938052AbWLHMBh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Dec 2006 07:01:37 -0500
From: NeilBrown <neilb@suse.de>
To: Andrew Morton <akpm@osdl.org>
Date: Fri, 8 Dec 2006 23:01:47 +1100
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Cc: nfs@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [PATCH 000 of 13] knfsd: Preparation for IPv6 support
Message-ID: <20061208225655.17970.patches@notabene>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Following are 13 patches for nfsd/sunrpc that are suitabble for
2.6.20.  They are from Chuck Lever and generalise some dependancies on
IPv4 to prepare the way for IPv6.  There is still a lot of work to do
before we can actually use IPv6 to talk to NFSD, but this removes some
barriers.

Thanks,
NeilBrown

 [PATCH 001 of 13] knfsd: SUNRPC: update internal API: separate pmap register and temp sockets
 [PATCH 002 of 13] knfsd: SUNRPC: allow creating an RPC service without registering with portmapper
 [PATCH 003 of 13] knfsd: SUNRPC: Cache remote peer's address in svc_sock.
 [PATCH 004 of 13] knfsd: SUNRPC: Don't set msg_name and msg_namelen when calling sock_recvmsg
 [PATCH 005 of 13] knfsd: SUNRPC: Use sockaddr_storage to store address in svc_deferred_req
 [PATCH 006 of 13] knfsd: SUNRPC: Add a function to format the address in an svc_rqst for printing
 [PATCH 007 of 13] knfsd: SUNRPC: Provide room in svc_rqst for larger addresses
 [PATCH 008 of 13] knfsd: SUNRPC: Make rq_daddr field address-version independent
 [PATCH 009 of 13] knfsd: SUNRPC: teach svc_sendto() to deal with IPv6 addresses
 [PATCH 010 of 13] knfsd: SUNRPC: add a "generic" function to see if the peer uses a secure port
 [PATCH 011 of 13] knfsd: SUNRPC: Support IPv6 addresses in svc_tcp_accept
 [PATCH 012 of 13] knfsd: SUNRPC: support IPv6 addresses in RPC server's UDP receive path
 [PATCH 013 of 13] knfsd: SUNRPC: fix up svc_create_socket() to take a sockaddr struct + length
