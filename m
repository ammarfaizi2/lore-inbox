Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130204AbRAKXIC>; Thu, 11 Jan 2001 18:08:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131235AbRAKXHp>; Thu, 11 Jan 2001 18:07:45 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:39674 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S130204AbRAKXHe>;
	Thu, 11 Jan 2001 18:07:34 -0500
Date: Thu, 11 Jan 2001 18:07:31 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Trond Myklebust <trond.myklebust@fys.uio.no>, linux-kernel@vger.kernel.org
Subject: [PATCH] missing export in sunrpc_syms.c
Message-ID: <Pine.GSO.4.21.0101111802500.17363-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	rpc_release_task is required by nfs.o.

--- net/sunrpc/sunrpc_syms.c        Fri Apr 21 19:08:52 2000
+++ net/sunrpc/sunrpc_syms.c    Thu Jan 11 18:01:50 2001
@@ -36,6 +36,7 @@
 EXPORT_SYMBOL(rpciod_up);
 EXPORT_SYMBOL(rpc_new_task);
 EXPORT_SYMBOL(rpc_wake_up_status);
+EXPORT_SYMBOL(rpc_release_task);

 /* RPC client functions */
 EXPORT_SYMBOL(rpc_create_client);


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
