Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030527AbWJJVtU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030527AbWJJVtU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Oct 2006 17:49:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030526AbWJJVss
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Oct 2006 17:48:48 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:32187 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1030518AbWJJVsS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Oct 2006 17:48:18 -0400
To: torvalds@osdl.org
Subject: [PATCH] openprom NULL noise removal
Cc: linux-kernel@vger.kernel.org
Message-Id: <E1GXPST-0007Pt-Dt@ZenIV.linux.org.uk>
From: Al Viro <viro@ftp.linux.org.uk>
Date: Tue, 10 Oct 2006 22:48:17 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 drivers/sbus/char/openprom.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/sbus/char/openprom.c b/drivers/sbus/char/openprom.c
index 2f69876..81ba2d7 100644
--- a/drivers/sbus/char/openprom.c
+++ b/drivers/sbus/char/openprom.c
@@ -630,7 +630,7 @@ static int openprom_ioctl(struct inode *
 	case OPROMPATH2NODE:
 		if ((file->f_mode & FMODE_READ) == 0)
 			return -EPERM;
-		return openprom_sunos_ioctl(inode, file, cmd, arg, 0);
+		return openprom_sunos_ioctl(inode, file, cmd, arg, NULL);
 
 	case OPIOCGET:
 	case OPIOCNEXTPROP:
-- 
1.4.2.GIT


