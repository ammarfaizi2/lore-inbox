Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317685AbSFSAFK>; Tue, 18 Jun 2002 20:05:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317686AbSFSAFJ>; Tue, 18 Jun 2002 20:05:09 -0400
Received: from air-2.osdl.org ([65.172.181.6]:6151 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S317685AbSFSAFI>;
	Tue, 18 Jun 2002 20:05:08 -0400
Subject: [ERROR][PATCH] smbfs compilation in 2.5.22 [ChangeSet@1.545]
From: Andy Pfiffer <andyp@osdl.org>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.5 
Date: 18 Jun 2002 17:05:20 -0700
Message-Id: <1024445120.1019.6.camel@andyp>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes a compilation problem with 2.5.22 [ChangeSet@1.545]

<linux/tqueue.h> needs to be included by fs/smbfs/sock.c
Compiles for me, not run tested.

Andy Pfiffer

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.545   -> 1.546  
#	     fs/smbfs/sock.c	1.7     -> 1.8    
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/06/18	andyp@andyp.pdx.osdl.net	1.546
# Compilation fix for fs/smbfs/sock.c (tqueue.h wasn't included).
# --------------------------------------------
#
diff -Nru a/fs/smbfs/sock.c b/fs/smbfs/sock.c
--- a/fs/smbfs/sock.c	Tue Jun 18 16:59:23 2002
+++ b/fs/smbfs/sock.c	Tue Jun 18 16:59:23 2002
@@ -18,6 +18,7 @@
 #include <linux/mm.h>
 #include <linux/netdevice.h>
 #include <linux/smp_lock.h>
+#include <linux/tqueue.h>
 #include <net/scm.h>
 #include <net/ip.h>
 



