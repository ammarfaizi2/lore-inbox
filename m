Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262325AbSJKBbY>; Thu, 10 Oct 2002 21:31:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262302AbSJKB3w>; Thu, 10 Oct 2002 21:29:52 -0400
Received: from nwkea-mail-1.sun.com ([192.18.42.13]:64473 "EHLO
	nwkea-mail-1.sun.com") by vger.kernel.org with ESMTP
	id <S262265AbSJKB2O>; Thu, 10 Oct 2002 21:28:14 -0400
From: Timothy Hockin <th122948@scl2.sfbay.sun.com>
Message-Id: <200210110133.g9B1Xot18453@scl2.sfbay.sun.com>
Subject: [BK PATCH 4/4] fix NGROUPS hard limit
To: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Date: Thu, 10 Oct 2002 18:33:50 -0700 (PDT)
Reply-To: thockin@sun.com
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.741   -> 1.742  
#	include/linux/nfsiod.h	1.1     -> 1.2    
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/10/10	thockin@freakshow.cobalt.com	1.742
# convert nfsiod to use OLD_NGROUPS - does anyone _use_ this file anymore?
# --------------------------------------------
#
diff -Nru a/include/linux/nfsiod.h b/include/linux/nfsiod.h
--- a/include/linux/nfsiod.h	Thu Oct 10 18:19:48 2002
+++ b/include/linux/nfsiod.h	Thu Oct 10 18:19:48 2002
@@ -10,6 +10,7 @@
 
 #include <linux/rpcsock.h>
 #include <linux/nfs_fs.h>
+#include <linux/limits.h>
 
 #ifdef __KERNEL__
 
@@ -36,7 +37,7 @@
 	/* user creds */
 	uid_t			rq_fsuid;
 	gid_t			rq_fsgid;
-	int			rq_groups[NGROUPS];
+	int			rq_groups[OLD_NGROUPS];
 
 	/* retry handling */
 	int			rq_retries;
