Return-Path: <linux-kernel-owner+willy=40w.ods.org-S936325AbWK3MSW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936325AbWK3MSW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Nov 2006 07:18:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936301AbWK3MSF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Nov 2006 07:18:05 -0500
Received: from mx1.redhat.com ([66.187.233.31]:23178 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S936303AbWK3MRh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Nov 2006 07:17:37 -0500
Subject: [GFS2] Remove unused GL_DUMP flag [31/70]
From: Steven Whitehouse <swhiteho@redhat.com>
To: cluster-devel@redhat.com, linux-kernel@vger.kernel.org
Content-Type: text/plain
Organization: Red Hat (UK) Ltd
Date: Thu, 30 Nov 2006 12:17:15 +0000
Message-Id: <1164889035.3752.366.camel@quoit.chygwyn.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>From c594d8866460a2710c436839d79f334a0714a2a7 Mon Sep 17 00:00:00 2001
From: Steven Whitehouse <swhiteho@redhat.com>
Date: Wed, 8 Nov 2006 09:01:13 -0500
Subject: [PATCH] [GFS2] Remove unused GL_DUMP flag

There is no way to set the GL_DUMP flag, and in any case the
same thing can be done with systemtap if required for debugging,
so this removes it.

Signed-off-by: Steven Whitehouse <swhiteho@redhat.com>
---
 fs/gfs2/glock.c |    3 ---
 fs/gfs2/glock.h |    1 -
 2 files changed, 0 insertions(+), 4 deletions(-)

diff --git a/fs/gfs2/glock.c b/fs/gfs2/glock.c
index 44633c4..746347a 100644
--- a/fs/gfs2/glock.c
+++ b/fs/gfs2/glock.c
@@ -1244,9 +1244,6 @@ restart:
 
 	clear_bit(GLF_PREFETCH, &gl->gl_flags);
 
-	if (error == GLR_TRYFAILED && (gh->gh_flags & GL_DUMP))
-		dump_glock(gl);
-
 	return error;
 }
 
diff --git a/fs/gfs2/glock.h b/fs/gfs2/glock.h
index 2b2a889..b985627 100644
--- a/fs/gfs2/glock.h
+++ b/fs/gfs2/glock.h
@@ -28,7 +28,6 @@ #define GL_ATIME		0x00000200
 #define GL_NOCACHE		0x00000400
 #define GL_NOCANCEL		0x00001000
 #define GL_AOP			0x00004000
-#define GL_DUMP			0x00008000
 
 #define GLR_TRYFAILED		13
 #define GLR_CANCELED		14
-- 
1.4.1



