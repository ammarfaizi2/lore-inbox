Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261754AbTJFW54 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Oct 2003 18:57:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261764AbTJFW54
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Oct 2003 18:57:56 -0400
Received: from f21.mail.ru ([194.67.57.54]:32269 "EHLO f21.mail.ru")
	by vger.kernel.org with ESMTP id S261754AbTJFW5z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Oct 2003 18:57:55 -0400
From: =?koi8-r?Q?=22?=Alexey Dobriyan=?koi8-r?Q?=22=20?= 
	<adobriyan@mail.ru>
To: jes@trained-monkey.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] drivers/net/acenic.c '< 0' comparison make sense only with signed variable.
Mime-Version: 1.0
X-Mailer: mPOP Web-Mail 2.19
X-Originating-IP: [194.85.64.37]
Date: Tue, 07 Oct 2003 03:00:34 +0400
Reply-To: =?koi8-r?Q?=22?=Alexey Dobriyan=?koi8-r?Q?=22=20?= 
	  <adobriyan@mail.ru>
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Message-Id: <E1A6eLC-000Ata-00.adobriyan-mail-ru@f21.mail.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -urN a/drivers/net/acenic.c b/drivers/net/acenic.c
--- a/drivers/net/acenic.c	2003-09-28 04:50:18.000000000 +0400
+++ b/drivers/net/acenic.c	2003-10-07 00:20:40.000000000 +0400
@@ -1162,7 +1162,8 @@
 	struct pci_dev *pdev;
 	unsigned long myjif;
 	u64 tmp_ptr;
-	u32 tig_ver, mac1, mac2, tmp, pci_state;
+	u32 tig_ver, mac1, mac2, pci_state;
+	s32 tmp;
 	int board_idx, ecode = 0;
 	short i;
 	unsigned char cache_size;

