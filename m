Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261640AbULFUrO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261640AbULFUrO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Dec 2004 15:47:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261641AbULFUrO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Dec 2004 15:47:14 -0500
Received: from math.ut.ee ([193.40.5.125]:6391 "EHLO math.ut.ee")
	by vger.kernel.org with ESMTP id S261640AbULFUrL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Dec 2004 15:47:11 -0500
Date: Mon, 6 Dec 2004 22:47:09 +0200 (EET)
From: Riina Kikas <riinak@ut.ee>
To: linux-kernel@vger.kernel.org
cc: mroos@ut.ee
Subject: [PATCH 2.6] clean-up: fixes "unsigned<0" warning
Message-ID: <Pine.SOC.4.61.0412062244480.21075@math.ut.ee>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes warning "comparison of unsigned expression < 0 is always false"
occuring on line 110

Signed-off-by: Riina Kikas <Riina.Kikas@mail.ee>

--- a/fs/ntfs/collate.c	2004-10-18 21:54:55.000000000 +0000
+++ b/fs/ntfs/collate.c	2004-12-04 13:25:02.000000000 +0000
@@ -109,7 +109,6 @@
  	 */
  	BUG_ON(cr != COLLATION_BINARY && cr != COLLATION_NTOFS_ULONG);
  	i = le32_to_cpu(cr);
-	BUG_ON(i < 0);
  	if (i <= 0x02)
  		return ntfs_do_collate0x0[i](vol, data1, data1_len,
  				data2, data2_len);
