Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932234AbWCMN3w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932234AbWCMN3w (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Mar 2006 08:29:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752004AbWCMN3w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Mar 2006 08:29:52 -0500
Received: from build.arklinux.osuosl.org ([140.211.166.26]:39894 "EHLO
	mail.arklinux.org") by vger.kernel.org with ESMTP id S1752000AbWCMN3v
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Mar 2006 08:29:51 -0500
From: Bernhard Rosenkraenzer <bero@arklinux.org>
To: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] 2.6.16-rc6-mm1 fs/9p compile failure
Date: Mon, 13 Mar 2006 13:38:02 +0100
User-Agent: KMail/1.9.1
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603131338.03295.bero@arklinux.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes:

fs/9p/fcprint.c:93: error: static declaration of 'v9fs_printstat' follows 
non-static declaration
fs/9p/9p.h:377: error: previous declaration of 'v9fs_printstat' was here
fs/9p/fcprint.c:125: error: static declaration of 'v9fs_dumpdata' follows 
non-static declaration
fs/9p/9p.h:376: error: previous declaration of 'v9fs_dumpdata' was here

Signed-off-by: Bernhard Rosenkraenzer <bero@arklinux.org>

--- linux-2.6.15/fs/9p/9p.h.ark	2006-03-13 13:37:16.000000000 +0100
+++ linux-2.6.15/fs/9p/9p.h	2006-03-13 13:37:21.000000000 +0100
@@ -373,5 +373,3 @@
 		 u32 count, const char __user * data,
 		 struct v9fs_fcall **rcall);
 int v9fs_printfcall(char *, int, struct v9fs_fcall *, int);
-int v9fs_dumpdata(char *, int, u8 *, int);
-int v9fs_printstat(char *, int, struct v9fs_stat *, int);
