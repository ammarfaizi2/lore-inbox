Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261478AbVCCGSp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261478AbVCCGSp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Mar 2005 01:18:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261489AbVCCGQg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Mar 2005 01:16:36 -0500
Received: from fire.osdl.org ([65.172.181.4]:43728 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261504AbVCCGKH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Mar 2005 01:10:07 -0500
Date: Wed, 2 Mar 2005 21:50:05 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: kkeil@suse.de, akpm <akpm@osdl.org>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: [PATCH] isdn: fix gcc data type/size warning
Message-Id: <20050302215005.690e2daf.rddunlap@osdl.org>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(resend)

Fix gcc warning:
drivers/isdn/i4l/isdn_ppp.c:1581: warning: large integer implicitly truncated to unsigned type
<seq> is unsigned int.

Signed-off-by: Randy Dunlap <rddunlap@osdl.org>

diffstat:=
 drivers/isdn/i4l/isdn_ppp.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

diff -Naurp ./drivers/isdn/i4l/isdn_ppp.c~isdn_types ./drivers/isdn/i4l/isdn_ppp.c
--- ./drivers/isdn/i4l/isdn_ppp.c~isdn_types	2004-12-24 13:35:01.000000000 -0800
+++ ./drivers/isdn/i4l/isdn_ppp.c	2005-01-10 12:27:37.645551176 -0800
@@ -1578,7 +1578,7 @@ static int isdn_ppp_mp_init( isdn_net_lo
 		lp->next = lp->last = lp;	/* nobody else in a queue */
 		lp->netdev->pb->frags = NULL;
 		lp->netdev->pb->frames = 0;
-		lp->netdev->pb->seq = LONG_MAX;
+		lp->netdev->pb->seq = UINT_MAX;
 	}
 	lp->netdev->pb->ref_ct++;
 	


---
