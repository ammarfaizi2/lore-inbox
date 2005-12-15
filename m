Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422661AbVLOJTt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422661AbVLOJTt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Dec 2005 04:19:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422645AbVLOJTH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Dec 2005 04:19:07 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:62595 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1422657AbVLOJTA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Dec 2005 04:19:00 -0500
To: torvalds@osdl.org
Subject: [PATCH] mwave: missing __user in ioctl struct declaration
Cc: linux-kernel@vger.kernel.org
Message-Id: <E1EmpGO-00080s-49@ZenIV.linux.org.uk>
From: Al Viro <viro@ftp.linux.org.uk>
Date: Thu, 15 Dec 2005 09:19:00 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>


---

 drivers/char/mwave/mwavepub.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

905ac4d19777f529814885cdb3fa2c5ce2fb7fcd
diff --git a/drivers/char/mwave/mwavepub.h b/drivers/char/mwave/mwavepub.h
index f1f9da7..60c961a 100644
--- a/drivers/char/mwave/mwavepub.h
+++ b/drivers/char/mwave/mwavepub.h
@@ -69,7 +69,7 @@ typedef struct _MW_ABILITIES {
 typedef struct _MW_READWRITE {
 	unsigned short usDspAddress;	/* The dsp address */
 	unsigned long ulDataLength;	/* The size in bytes of the data or user buffer */
-	void *pBuf;		/* Input:variable sized buffer */
+	void __user *pBuf;		/* Input:variable sized buffer */
 } MW_READWRITE, *pMW_READWRITE;
 
 #define IOCTL_MW_RESET           _IO(MWAVE_MINOR,1)
-- 
0.99.9.GIT

