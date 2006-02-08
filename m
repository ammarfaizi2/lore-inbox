Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030480AbWBHDWs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030480AbWBHDWs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Feb 2006 22:22:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030491AbWBHDUA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Feb 2006 22:20:00 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:1665 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1030479AbWBHDTh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Feb 2006 22:19:37 -0500
To: torvalds@osdl.org
Subject: [PATCH 21/29] sg gfp_t annotations
Cc: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Message-Id: <E1F6frl-0006De-4p@ZenIV.linux.org.uk>
From: Al Viro <viro@ftp.linux.org.uk>
Date: Wed, 08 Feb 2006 03:19:37 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Date: 1138793500 -0500

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

---

 drivers/scsi/sg.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

2d20eaf9426598ef156b941bcfa44e867452b770
diff --git a/drivers/scsi/sg.c b/drivers/scsi/sg.c
index 7d07000..2a54753 100644
--- a/drivers/scsi/sg.c
+++ b/drivers/scsi/sg.c
@@ -1679,7 +1679,7 @@ static int
 sg_build_sgat(Sg_scatter_hold * schp, const Sg_fd * sfp, int tablesize)
 {
 	int sg_bufflen = tablesize * sizeof(struct scatterlist);
-	unsigned int gfp_flags = GFP_ATOMIC | __GFP_NOWARN;
+	gfp_t gfp_flags = GFP_ATOMIC | __GFP_NOWARN;
 
 	/*
 	 * TODO: test without low_dma, we should not need it since
-- 
0.99.9.GIT

