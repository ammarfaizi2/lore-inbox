Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964799AbWEBNAB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964799AbWEBNAB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 May 2006 09:00:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964801AbWEBNAB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 May 2006 09:00:01 -0400
Received: from pat.uio.no ([129.240.10.6]:25243 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S964799AbWEBNAA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 May 2006 09:00:00 -0400
Mime-Version: 1.0 (Apple Message framework v749.3)
Content-Transfer-Encoding: 7bit
Message-Id: <53616A3D-8CC7-4898-A7CA-16212D51FEDA@usit.uio.no>
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
To: linux-kernel@vger.kernel.org
From: Hans A Eide <haeide@usit.uio.no>
Subject: [PATCH] block/ub.c: Increase number of partitions for usb storage
Date: Tue, 2 May 2006 14:59:52 +0200
X-Mailer: Apple Mail (2.749.3)
X-UiO-Spam-info: not spam, SpamAssassin (score=-4.932, required 12,
	autolearn=disabled, AWL 0.07, UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

I do backups to external USB storage and hit the 8 partitions limit  
of ub.c
This could also be a problem for others (HFS+ formatted iPods?)

Any reason for not increasing the partitions limit to 16?

Thanks,

Hans

diff -u drivers/block/ub.c.orig drivers/block/ub.c
--- drivers/block/ub.c.orig     2006-05-02 09:16:22.000000000 +0200
+++ drivers/block/ub.c  2006-04-30 13:37:34.000000000 +0200
@@ -113,7 +113,7 @@
/*
   */
-#define UB_PARTS_PER_LUN      8
+#define UB_PARTS_PER_LUN      16
#define UB_MAX_CDB_SIZE      16                /* Corresponds to Bulk */



--
Hans A. Eide
University of Oslo, Norway


