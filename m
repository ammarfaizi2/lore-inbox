Return-Path: <linux-kernel-owner+willy=40w.ods.org-S936452AbWLAPTa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936452AbWLAPTa (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Dec 2006 10:19:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936471AbWLAPTa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Dec 2006 10:19:30 -0500
Received: from xdsl-664.zgora.dialog.net.pl ([81.168.226.152]:62726 "EHLO
	tuxland.pl") by vger.kernel.org with ESMTP id S936452AbWLAPT3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Dec 2006 10:19:29 -0500
From: Mariusz Kozlowski <m.kozlowski@tuxland.pl>
To: Willy Tarreau <wtarreau@hera.kernel.org>
Subject: [2.4 PATCH] fs ufs macro parenthesis fix
Date: Fri, 1 Dec 2006 16:19:04 +0100
User-Agent: KMail/1.9.5
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200612011619.04623.m.kozlowski@tuxland.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

	This patch fixes parenthesis stuff in ubh_get_addr16() macro code.

Signed-off-by: Mariusz Kozlowski <m.kozlowski@tuxland.pl>

 fs/ufs/util.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-2.4.34-pre6-a/fs/ufs/util.h	2002-02-25 20:38:09.000000000 +0100
+++ linux-2.4.34-pre6-b/fs/ufs/util.h	2006-12-01 11:51:08.000000000 +0100
@@ -273,7 +273,7 @@ extern void _ubh_memcpyubh_(struct ufs_s
 
 #define ubh_get_addr16(ubh,begin) \
 	(((u16*)((ubh)->bh[(begin) >> (uspi->s_fshift-1)]->b_data)) + \
-	((begin) & (uspi->fsize>>1) - 1)))
+	((begin) & ((uspi->fsize>>1) - 1)))
 
 #define ubh_get_addr32(ubh,begin) \
 	(((u32*)((ubh)->bh[(begin) >> (uspi->s_fshift-2)]->b_data)) + \


-- 
Regards,

	Mariusz Kozlowski
