Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1757666AbWKXJdD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757666AbWKXJdD (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Nov 2006 04:33:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757651AbWKXJc2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Nov 2006 04:32:28 -0500
Received: from mx1.redhat.com ([66.187.233.31]:61140 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1757546AbWKXJcE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Nov 2006 04:32:04 -0500
Subject: [GFS2] Fix Kconfig wrt CRC32 [8/9]
From: Steven Whitehouse <swhiteho@redhat.com>
To: linux-kernel@vger.kernel.org, cluster-devel@redhat.com
Cc: Toralf =?ISO-8859-1?Q?F=F6rster?= <toralf.foerster@gmx.de>
Content-Type: text/plain; charset=UTF-8
Organization: Red Hat (UK) Ltd
Date: Fri, 24 Nov 2006 09:34:49 +0000
Message-Id: <1164360889.3392.146.camel@quoit.chygwyn.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>From 6f788fd00c82533d4cd5587a9706f8468658a24d Mon Sep 17 00:00:00 2001
From: Steven Whitehouse <swhiteho@redhat.com>
Date: Mon, 20 Nov 2006 10:04:49 -0500
Subject: [PATCH] [GFS2] Fix Kconfig wrt CRC32
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

GFS2 requires the CRC32 library function. This was reported by
Toralf Förster.

Cc: Toralf Förster <toralf.foerster@gmx.de>
Signed-off-by: Steven Whitehouse <swhiteho@redhat.com>
---
 fs/gfs2/Kconfig |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/fs/gfs2/Kconfig b/fs/gfs2/Kconfig
index 8c27de8..c0791cb 100644
--- a/fs/gfs2/Kconfig
+++ b/fs/gfs2/Kconfig
@@ -2,6 +2,7 @@ config GFS2_FS
 	tristate "GFS2 file system support"
 	depends on EXPERIMENTAL
 	select FS_POSIX_ACL
+	select CRC32
 	help
 	A cluster filesystem.
 
-- 
1.4.1



