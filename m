Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317043AbSEWXFF>; Thu, 23 May 2002 19:05:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317044AbSEWXFF>; Thu, 23 May 2002 19:05:05 -0400
Received: from wsip68-14-236-254.ph.ph.cox.net ([68.14.236.254]:37530 "EHLO
	mail.labsysgrp.com") by vger.kernel.org with ESMTP
	id <S317043AbSEWXFE>; Thu, 23 May 2002 19:05:04 -0400
Message-ID: <006101c202ae$47b1e0c0$6aaca8c0@kpfhome>
From: "Kevin P. Fleming" <kevin@labsysgrp.com>
To: <dank@kegel.com>, <linux-kernel@vger.kernel.org>
Cc: <trond.myklebust@fys.uio.no>
In-Reply-To: <3CED6E0F.215BF408@kegel.com>
Subject: Re: [PATCH] patch for 2.4.19-pre8 nfsroot.c to compile
Date: Thu, 23 May 2002 16:05:06 -0700
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

Doh! Here's a corrected patch (other places in the kernel use %u instead of
%d, so that's what I used):

--- linux/fs/nfs/nfsroot.c Thu May 23 12:04:17 2002
+++ linux-nfsroot/fs/nfs/nfsroot.c Thu May 23 16:02:29 2002
@@ -343,8 +343,8 @@
 {
  struct sockaddr_in sin;

- printk(KERN_NOTICE "Looking up port of RPC %d/%d on %s\n",
-  program, version, in_ntoa(servaddr));
+ printk(KERN_NOTICE "Looking up port of RPC %d/%d on %u.%u.%u.%u\n",
+  program, version, NIPQUAD(servaddr));
  set_sockaddr(&sin, servaddr, 0);
  return rpc_getport_external(&sin, program, version, proto);
 }

----- Original Message -----
From: "Dan Kegel" <dank@kegel.com>
To: "Kevin P. Fleming" <kevin@labsysgrp.com>; <linux-kernel@vger.kernel.org>
Sent: Thursday, May 23, 2002 03:32 PM
Subject: re: [PATCH] patch for 2.4.19-pre8 nfsroot.c to compile


<snip>

> Er, shouldn't you change the %s to a %d.%d.%d.%d?
> - Dan
>
>

