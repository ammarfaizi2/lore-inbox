Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261836AbUKHN6e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261836AbUKHN6e (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Nov 2004 08:58:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261840AbUKHN6e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Nov 2004 08:58:34 -0500
Received: from hera.cwi.nl ([192.16.191.8]:14298 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id S261836AbUKHN6H (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Nov 2004 08:58:07 -0500
Date: Mon, 8 Nov 2004 14:57:59 +0100
From: Andries Brouwer <Andries.Brouwer@cwi.nl>
To: torvalds@osdl.org, akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] ufs docs
Message-ID: <20041108135758.GA2523@apps.cwi.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Added the hp and 5xbsd flavors of ufstype.

diff -uprN -X /linux/dontdiff a/Documentation/filesystems/ufs.txt b/Documentation/filesystems/ufs.txt
--- a/Documentation/filesystems/ufs.txt	2004-04-08 13:17:35.000000000 +0200
+++ b/Documentation/filesystems/ufs.txt	2004-11-08 13:39:43.000000000 +0100
@@ -15,13 +15,15 @@ ufstype=type_of_ufs
 	ufs manually by mount option ufstype. Possible values are:
 
 	old	old format of ufs
-		default value, supported os read-only
+		default value, supported as read-only
 
 	44bsd	used in FreeBSD, NetBSD, OpenBSD
-		supported os read-write
+		supported as read-write
+
+	ufs2    used in FreeBSD 5.x
+		supported as read-only
 
-       ufs2    used in FreeBSD 5.x
-               supported os read-only
+	5xbsd	synonym for ufs2
 
 	sun	used in SunOS (Solaris)
 		supported as read-write
@@ -29,6 +31,9 @@ ufstype=type_of_ufs
 	sunx86	used in SunOS for Intel (Solarisx86)
 		supported as read-write
 
+	hp	used in HP-UX
+		supported as read-only
+
 	nextstep
 		used in NextStep
 		supported as read-only
@@ -46,7 +51,7 @@ POSSIBLE PROBLEMS
 =================
 
 There is still bug in reallocation of fragment, in file fs/ufs/balloc.c, 
-line 364. But it seem working on current buffer cache configuration.
+line 364. But it seems working on current buffer cache configuration.
 
 
 BUG REPORTS
