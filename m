Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261398AbSLJNTN>; Tue, 10 Dec 2002 08:19:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261411AbSLJNTN>; Tue, 10 Dec 2002 08:19:13 -0500
Received: from e5.ny.us.ibm.com ([32.97.182.105]:36742 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S261398AbSLJNTN>;
	Tue, 10 Dec 2002 08:19:13 -0500
Date: Tue, 10 Dec 2002 18:55:02 +0530
From: Ravikiran G Thirumalai <kiran@in.ibm.com>
To: "David S. Miller " <davem@redhat.com>
Cc: netdev <netdev@oss.sgi.com>, linux-kernel@vger.kernel.org
Subject: [trivial] Use __init and __exit for sctp_init and sctp_exit
Message-ID: <20021210185502.G17375@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

These module_init and module_exit routines should have been marked 
__init and __exit like every where else I guess... 

Please apply

Thanks,
Kiran


diff -ruN -X dontdiff linux-2.5.51/net/sctp/protocol.c sctp_fix-2.5.51/net/sctp/protocol.c
--- linux-2.5.51/net/sctp/protocol.c	Tue Dec 10 08:16:10 2002
+++ sctp_fix-2.5.51/net/sctp/protocol.c	Tue Dec 10 18:48:07 2002
@@ -598,7 +598,7 @@
 }
 
 /* Initialize the universe into something sensible.  */
-int sctp_init(void)
+int __init sctp_init(void)
 {
 	int i;
 	int status = 0;
@@ -751,7 +751,7 @@
 }
 
 /* Exit handler for the SCTP protocol.  */
-void sctp_exit(void)
+void __exit sctp_exit(void)
 {
 	/* BUG.  This should probably do something useful like clean
 	 * up all the remaining associations and all that memory.
