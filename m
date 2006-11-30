Return-Path: <linux-kernel-owner+willy=40w.ods.org-S936340AbWK3MbQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936340AbWK3MbQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Nov 2006 07:31:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936344AbWK3Man
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Nov 2006 07:30:43 -0500
Received: from mx1.redhat.com ([66.187.233.31]:48269 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S936342AbWK3MVc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Nov 2006 07:21:32 -0500
Subject: [GFS2] Fix Kconfig wrt CRC32 [52/70]
From: Steven Whitehouse <swhiteho@redhat.com>
To: cluster-devel@redhat.com, linux-kernel@vger.kernel.org
Cc: Toralf =?ISO-8859-1?Q?F=F6rster?= <toralf.foerster@gmx.de>
Content-Type: text/plain; charset=UTF-8
Organization: Red Hat (UK) Ltd
Date: Thu, 30 Nov 2006 12:21:27 +0000
Message-Id: <1164889287.3752.409.camel@quoit.chygwyn.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>From fa2ecfc5e11b12f25b67f9c84ac6b0e74a6a0115 Mon Sep 17 00:00:00 2001
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



