Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265520AbTIJTNP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Sep 2003 15:13:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265563AbTIJTNO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Sep 2003 15:13:14 -0400
Received: from xs4all.vs19.net ([213.84.236.198]:15177 "EHLO spaans.vs19.net")
	by vger.kernel.org with ESMTP id S265520AbTIJTMO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Sep 2003 15:12:14 -0400
Date: Wed, 10 Sep 2003 21:12:09 +0200
From: Jasper Spaans <jasper@vs19.net>
To: torvalds@osdl.org, linux-kernel@vger.kernel.org
Message-ID: <20030910191209.GA24609@spaans.vs19.net>
Mime-Version: 1.0
Content-Disposition: inline
Attach: /home/spaans/JasperSpaans.vcf
Organization: http://www.insultant.nl/
X-Copyright: Copyright 2003 C. Jasper Spaans - All Rights Reserved
User-Agent: Mutt/1.5.4i
X-SA-Exim-Rcpt-To: torvalds@osdl.org, linux-kernel@vger.kernel.org
X-SA-Exim-Mail-From: spaans@spaans.vs19.net
Subject: [patch] net/appletalk/aarp.c typo
Content-Type: text/plain; charset=utf-8
X-SA-Exim-Version: 3.0+cvs (built Mon Jul 28 22:52:54 EDT 2003)
X-SA-Exim-Scanned: Yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

The patch recently applied to net/appletalk/aarp.c has a typo in it; line
944 in bk currently reads 

      return *pos ? iter_next(iter, pos) : SEQ_START_TOKEN);

which will not compile.

The following patch fixes that; please apply.

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.1175  -> 1.1176 
#	net/appletalk/aarp.c	1.17    -> 1.18   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 03/09/10	jasper@vs19.net	1.1176
# Fix up typo in net/appletalk/aarp.c to make it compile again.
# --------------------------------------------
#
diff -Nru a/net/appletalk/aarp.c b/net/appletalk/aarp.c
--- a/net/appletalk/aarp.c	Wed Sep 10 21:09:52 2003
+++ b/net/appletalk/aarp.c	Wed Sep 10 21:09:52 2003
@@ -941,7 +941,7 @@
 	iter->table     = resolved;
 	iter->bucket    = 0;
 
-	return *pos ? iter_next(iter, pos) : SEQ_START_TOKEN);
+	return *pos ? iter_next(iter, pos) : SEQ_START_TOKEN;
 }
 
 static void *aarp_seq_next(struct seq_file *seq, void *v, loff_t *pos)


Bye,
-- 
Jasper Spaans                http://jsp.vs19.net/
 21:03:46 up 9702 days, 11:50, 0 users, load average: 12.41 6.76 3.53
