Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1759187AbWK3JDa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759187AbWK3JDa (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Nov 2006 04:03:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759190AbWK3JD3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Nov 2006 04:03:29 -0500
Received: from xdsl-664.zgora.dialog.net.pl ([81.168.226.152]:8967 "EHLO
	tuxland.pl") by vger.kernel.org with ESMTP id S1759187AbWK3JD0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Nov 2006 04:03:26 -0500
From: Mariusz Kozlowski <m.kozlowski@tuxland.pl>
To: Daniel Pirkl <daniel.pirkl@email.cz>
Subject: [PATCH] fs: ufs add missing bracket
Date: Thu, 30 Nov 2006 10:02:56 +0100
User-Agent: KMail/1.9.5
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611301002.56569.m.kozlowski@tuxland.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

	This patch adds missing bracket.

Signed-off-by: Mariusz Kozlowski <m.kozlowski@tuxland.pl>

 fs/ufs/util.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-2.6.19-rc6-mm2-a/fs/ufs/util.h	2006-11-30 09:52:14.000000000 +0100
+++ linux-2.6.19-rc6-mm2-b/fs/ufs/util.h	2006-11-30 09:52:37.000000000 +0100
@@ -299,7 +299,7 @@ static inline void *get_usb_offset(struc
 
 #define ubh_get_addr16(ubh,begin) \
 	(((__fs16*)((ubh)->bh[(begin) >> (uspi->s_fshift-1)]->b_data)) + \
-	((begin) & (uspi->fsize>>1) - 1)))
+	((begin) & ((uspi->fsize>>1) - 1)))
 
 #define ubh_get_addr32(ubh,begin) \
 	(((__fs32*)((ubh)->bh[(begin) >> (uspi->s_fshift-2)]->b_data)) + \


-- 
Regards,

	Mariusz Kozlowski
