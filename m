Return-Path: <linux-kernel-owner+w=401wt.eu-S932585AbWLMASX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932585AbWLMASX (ORCPT <rfc822;w@1wt.eu>);
	Tue, 12 Dec 2006 19:18:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964795AbWLMASE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Dec 2006 19:18:04 -0500
Received: from mx2.suse.de ([195.135.220.15]:52843 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964823AbWLMARt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Dec 2006 19:17:49 -0500
From: NeilBrown <neilb@suse.de>
To: Andrew Morton <akpm@osdl.org>
Date: Wed, 13 Dec 2006 10:58:34 +1100
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Cc: nfs@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [PATCH 000 of 14] knfsd: Assorted nfsd patches for 2.6.20 - prepare for IPv6 and more
Message-ID: <20061213105528.21128.patches@notabene>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Following are 14 patches for knfsd that are suitable for inclusion in 2.6.20.
First 13 are from Chuck Lever and make preparations for IPv6 support (I think we've
get them right this time).

Last is from Peter Staubach and fixes and issue with exclusive create
interacting badly with some ACLs.

Thanks,
NeilBrown


 [PATCH 001 of 14] knfsd: SUNRPC: update internal API: separate pmap register and temp sockets
 [PATCH 002 of 14] knfsd: SUNRPC: allow creating an RPC service without registering with portmapper
 [PATCH 003 of 14] knfsd: SUNRPC: Cache remote peer's address in svc_sock.
 [PATCH 004 of 14] knfsd: SUNRPC: Don't set msg_name and msg_namelen when calling sock_recvmsg
 [PATCH 005 of 14] knfsd: SUNRPC: Use sockaddr_storage to store address in svc_deferred_req
 [PATCH 006 of 14] knfsd: SUNRPC: Add a function to format the address in an svc_rqst for printing
 [PATCH 007 of 14] knfsd: SUNRPC: Provide room in svc_rqst for larger addresses
 [PATCH 008 of 14] knfsd: SUNRPC: Make rq_daddr field address-version independent
 [PATCH 009 of 14] knfsd: SUNRPC: teach svc_sendto() to deal with IPv6 addresses
 [PATCH 010 of 14] knfsd: SUNRPC: add a "generic" function to see if the peer uses a secure port
 [PATCH 011 of 14] knfsd: SUNRPC: Support IPv6 addresses in svc_tcp_accept
 [PATCH 012 of 14] knfsd: SUNRPC: support IPv6 addresses in RPC server's UDP receive path
 [PATCH 013 of 14] knfsd: SUNRPC: fix up svc_create_socket() to take a sockaddr struct + length
 [PATCH 014 of 14] knfsd: Don't mess with the 'mode' when storing a exclusive-create cookie.
