Return-Path: <linux-kernel-owner+willy=40w.ods.org-S936507AbWLAOlU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936507AbWLAOlU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Dec 2006 09:41:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936511AbWLAOlU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Dec 2006 09:41:20 -0500
Received: from xdsl-664.zgora.dialog.net.pl ([81.168.226.152]:18952 "EHLO
	tuxland.pl") by vger.kernel.org with ESMTP id S936507AbWLAOlS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Dec 2006 09:41:18 -0500
From: Mariusz Kozlowski <m.kozlowski@tuxland.pl>
To: Willy Tarreau <wtarreau@hera.kernel.org>
Subject: [2.4 PATCH] net wavelan parenthesis fix
Date: Fri, 1 Dec 2006 15:40:53 +0100
User-Agent: KMail/1.9.5
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200612011540.53755.m.kozlowski@tuxland.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

	This patch adds missing parenthesis in wavelan_ioctl() code.

Signed-off-by: Mariusz Kozlowski <m.kozlowski@tuxland.pl>

 drivers/net/wavelan.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-2.4.34-pre6-a/drivers/net/wavelan.c	2003-06-13 16:51:35.000000000 +0200
+++ linux-2.4.34-pre6-b/drivers/net/wavelan.c	2006-12-01 12:13:48.000000000 +0100
@@ -2297,7 +2297,7 @@ static int wavelan_ioctl(struct net_devi
 			wv_splx(lp, &flags);
 			if (copy_to_user(wrq->u.data.pointer,
 					 lp->his_sum,
-					 sizeof(long) * lp->his_number);
+					 sizeof(long) * lp->his_number));
 				ret = -EFAULT;
 			wv_splhi(lp, &flags);
 


-- 
Regards,

	Mariusz Kozlowski
