Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278163AbRKJRrz>; Sat, 10 Nov 2001 12:47:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278403AbRKJRrp>; Sat, 10 Nov 2001 12:47:45 -0500
Received: from f139.law4.hotmail.com ([216.33.149.139]:4102 "EHLO hotmail.com")
	by vger.kernel.org with ESMTP id <S278163AbRKJRrj>;
	Sat, 10 Nov 2001 12:47:39 -0500
X-Originating-IP: [205.231.90.227]
From: "victor1 torres" <camel_3@hotmail.com>
To: linux-kernel@vger.kernel.org
Cc: camel_3@hotmail.com
Subject: [UNIFIED PATCH] loop.c for 2.4.14
Date: Sat, 10 Nov 2001 17:47:33 +0000
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="----=_NextPart_000_67ce_3dfe_1e90"
Message-ID: <F139M8pOtTTJTu0sAoY0000d3c5@hotmail.com>
X-OriginalArrivalTime: 10 Nov 2001 17:47:34.0006 (UTC) FILETIME=[C7132960:01C16A0F]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

------=_NextPart_000_67ce_3dfe_1e90
Content-Type: text/plain; format=flowed



_________________________________________________________________
Get your FREE download of MSN Explorer at http://explorer.msn.com/intl.asp

------=_NextPart_000_67ce_3dfe_1e90
Content-Type: text/plain; name="2.4.14.diff.txt"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment; filename="2.4.14.diff.txt"

diff -urN linux/drivers/block/loop.c~ linux/drivers/block/loop.c
--- linux/drivers/block/loop.c~	Mon Nov  5 07:29:16 2001
+++ linux/drivers/block/loop.c	Tue Nov  6 22:14:24 2001
@@ -207,7 +207,6 @@
		index++;
		pos += size;
		UnlockPage(page);
-		deactivate_page(page);
		page_cache_release(page);
	}
	return 0;
@@ -218,7 +217,6 @@
	kunmap(page);
unlock:
	UnlockPage(page);
-	deactivate_page(page);
	page_cache_release(page);
fail:
	return -1;


------=_NextPart_000_67ce_3dfe_1e90--
