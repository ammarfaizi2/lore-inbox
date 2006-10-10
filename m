Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030511AbWJJV6F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030511AbWJJV6F (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Oct 2006 17:58:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030500AbWJJVpa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Oct 2006 17:45:30 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:32708 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1030493AbWJJVp2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Oct 2006 17:45:28 -0400
To: torvalds@osdl.org
Subject: [PATCH] hwdep_compat missed __user annotations
Cc: linux-kernel@vger.kernel.org
Message-Id: <E1GXPPj-0007Kg-5i@ZenIV.linux.org.uk>
From: Al Viro <viro@ftp.linux.org.uk>
Date: Tue, 10 Oct 2006 22:45:27 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 sound/core/hwdep_compat.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sound/core/hwdep_compat.c b/sound/core/hwdep_compat.c
index 938f775..3827c0c 100644
--- a/sound/core/hwdep_compat.c
+++ b/sound/core/hwdep_compat.c
@@ -33,7 +33,7 @@ struct snd_hwdep_dsp_image32 {
 static int snd_hwdep_dsp_load_compat(struct snd_hwdep *hw,
 				     struct snd_hwdep_dsp_image32 __user *src)
 {
-	struct snd_hwdep_dsp_image *dst;
+	struct snd_hwdep_dsp_image __user *dst;
 	compat_caddr_t ptr;
 	u32 val;
 
-- 
1.4.2.GIT


