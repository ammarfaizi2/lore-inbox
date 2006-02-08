Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030482AbWBHDY1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030482AbWBHDY1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Feb 2006 22:24:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030488AbWBHDTN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Feb 2006 22:19:13 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:63360 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1030484AbWBHDTC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Feb 2006 22:19:02 -0500
To: torvalds@osdl.org
Subject: [PATCH 14/29] kernel/sys.c NULL noise removal
Cc: linux-kernel@vger.kernel.org
Message-Id: <E1F6frC-0006Cs-2k@ZenIV.linux.org.uk>
From: Al Viro <viro@ftp.linux.org.uk>
Date: Wed, 08 Feb 2006 03:19:02 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Date: 1138791452 -0500

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

---

 kernel/sys.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

4bb8089c86b95b4f6bbd839cb83ca4556b06a031
diff --git a/kernel/sys.c b/kernel/sys.c
index 0929c69..f91218a 100644
--- a/kernel/sys.c
+++ b/kernel/sys.c
@@ -428,7 +428,7 @@ void kernel_kexec(void)
 {
 #ifdef CONFIG_KEXEC
 	struct kimage *image;
-	image = xchg(&kexec_image, 0);
+	image = xchg(&kexec_image, NULL);
 	if (!image) {
 		return;
 	}
-- 
0.99.9.GIT

