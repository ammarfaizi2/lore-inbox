Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261642AbULFUtD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261642AbULFUtD (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Dec 2004 15:49:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261641AbULFUtD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Dec 2004 15:49:03 -0500
Received: from math.ut.ee ([193.40.5.125]:59133 "EHLO math.ut.ee")
	by vger.kernel.org with ESMTP id S261642AbULFUs6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Dec 2004 15:48:58 -0500
Date: Mon, 6 Dec 2004 22:48:56 +0200 (EET)
From: Riina Kikas <riinak@ut.ee>
To: linux-kernel@vger.kernel.org
cc: mroos@ut.ee
Subject: [PATCH 2.6] clean-up: fixes "unsigned>=0" warning
Message-ID: <Pine.SOC.4.61.0412062247160.21075@math.ut.ee>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes warning "comparison of unsigned expression >= 0 is always true"
occuring on line 38

Signed-off-by: Riina Kikas <Riina.Kikas@mail.ee>

--- a/fs/ntfs/collate.h	2004-10-18 21:53:06.000000000 +0000
+++ b/fs/ntfs/collate.h	2004-12-04 13:26:03.000000000 +0000
@@ -37,7 +37,7 @@
  	if (unlikely(cr != COLLATION_BINARY && cr != COLLATION_NTOFS_ULONG))
  		return FALSE;
  	i = le32_to_cpu(cr);
-	if (likely(((i >= 0) && (i <= 0x02)) ||
+	if (likely(cr <= 0x02 ||
  			((i >= 0x10) && (i <= 0x13))))
  		return TRUE;
  	return FALSE;
