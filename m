Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261684AbRE2T4c>; Tue, 29 May 2001 15:56:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261685AbRE2T4M>; Tue, 29 May 2001 15:56:12 -0400
Received: from quasar.osc.edu ([192.148.249.15]:65152 "EHLO quasar.osc.edu")
	by vger.kernel.org with ESMTP id <S261684AbRE2T4C>;
	Tue, 29 May 2001 15:56:02 -0400
Date: Tue, 29 May 2001 15:55:58 -0400
From: Pete Wyckoff <pw@osc.edu>
To: okir@monad.swb.de
Cc: linux-kernel@vger.kernel.org
Subject: [patch] minor lockd debugging typo
Message-ID: <20010529155558.C14117@osc.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rather than print proc twice, you probably intend to show the prog.
(At least, I had wanted to see the prog in the debugging output. :) )

		-- Pete

diff -X dontdiff -ruN linux-2.4.5-kdb/fs/lockd/mon.c linux-2.4.5/fs/lockd/mon.c
--- linux-2.4.5-kdb/fs/lockd/mon.c      Mon Oct 16 15:58:51 2000
+++ linux-2.4.5/fs/lockd/mon.c  Tue May 29 15:52:17 2001
@@ -146,7 +146,7 @@
        u32     addr = ntohl(argp->addr);
 
        dprintk("nsm: xdr_encode_mon(%08x, %d, %d, %d)\n",
-                       htonl(argp->addr), htonl(argp->proc),
+                       htonl(argp->addr), htonl(argp->prog),
                        htonl(argp->vers), htonl(argp->proc));
 
        /*
