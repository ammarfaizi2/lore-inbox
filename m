Return-Path: <linux-kernel-owner+willy=40w.ods.org-S967588AbWK2Tfa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967588AbWK2Tfa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Nov 2006 14:35:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967591AbWK2Tfa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Nov 2006 14:35:30 -0500
Received: from xdsl-664.zgora.dialog.net.pl ([81.168.226.152]:29960 "EHLO
	tuxland.pl") by vger.kernel.org with ESMTP id S967588AbWK2Tf3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Nov 2006 14:35:29 -0500
From: Mariusz Kozlowski <m.kozlowski@tuxland.pl>
To: sjhill@realitydiluted.com
Subject: [PATCH] mtd rtc_from4 brace fix
Date: Wed, 29 Nov 2006 20:34:58 +0100
User-Agent: KMail/1.9.5
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611292034.58566.m.kozlowski@tuxland.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

	Remove extra brace at the end of if (...

Signed-off-by: Mariusz Kozlowski <m.kozlowski@tuxland.pl>

 drivers/mtd/nand/rtc_from4.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-2.6.19-rc6-mm2-a/drivers/mtd/nand/rtc_from4.c	2006-11-28 12:16:40.000000000 +0100
+++ linux-2.6.19-rc6-mm2-b/drivers/mtd/nand/rtc_from4.c	2006-11-29 16:37:33.000000000 +0100
@@ -456,7 +456,7 @@ static int rtc_from4_errstat(struct mtd_
 		rtn = nand_do_read(mtd, page, len, &retlen, buf);
 
 		/* if read failed or > 1-bit error corrected */
-		if (rtn || (mtd->ecc_stats.corrected - corrected) > 1) {
+		if (rtn || (mtd->ecc_stats.corrected - corrected) > 1)
 			er_stat |= 1 << 1;
 		kfree(buf);
 	}


-- 
Regards,

	Mariusz Kozlowski
