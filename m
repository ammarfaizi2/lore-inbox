Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316993AbSEWTeC>; Thu, 23 May 2002 15:34:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316994AbSEWTeB>; Thu, 23 May 2002 15:34:01 -0400
Received: from wsip68-14-236-254.ph.ph.cox.net ([68.14.236.254]:41871 "EHLO
	mail.labsysgrp.com") by vger.kernel.org with ESMTP
	id <S316993AbSEWTeB>; Thu, 23 May 2002 15:34:01 -0400
Message-ID: <02c401c20290$cd7813a0$6aaca8c0@kpfhome>
From: "Kevin P. Fleming" <kevin@labsysgrp.com>
To: <linux-kernel@vger.kernel.org>
Cc: <trond.myklebust@fys.uio.no>
Subject: [PATCH] patch for 2.4.19-pre8 nfsroot.c to compile
Date: Thu, 23 May 2002 12:34:06 -0700
Organization: Laboratory Systems Group, Inc.
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch below is required for fs/nfs/nfsroot.c to compile in 2.4.19-pre8:

diff -X dontdiff -urN linux/fs/nfs/nfsroot.c linux-nfsroot/fs/nfs/nfsroot.c
--- linux/fs/nfs/nfsroot.c Thu May 23 12:04:17 2002
+++ linux-nfsroot/fs/nfs/nfsroot.c Thu May 23 12:10:11 2002
@@ -344,7 +344,7 @@
  struct sockaddr_in sin;
 
  printk(KERN_NOTICE "Looking up port of RPC %d/%d on %s\n",
-  program, version, in_ntoa(servaddr));
+  program, version, NIPQUAD(servaddr));
  set_sockaddr(&sin, servaddr, 0);
  return rpc_getport_external(&sin, program, version, proto);
 }


