Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261188AbVC1Fst@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261188AbVC1Fst (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Mar 2005 00:48:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261195AbVC1FrV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Mar 2005 00:47:21 -0500
Received: from fire.osdl.org ([65.172.181.4]:21987 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261188AbVC1Fqr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Mar 2005 00:46:47 -0500
Date: Sun, 27 Mar 2005 21:43:54 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: kkeil@suse.de
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: [PATCH] isdn: hfc4s8s_ll sparse cleanups
Message-Id: <20050327214354.7fd54e62.rddunlap@osdl.org>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


drivers/isdn/hisax/hfc4s8s_l1.c:1661:7: warning: obsolete struct initializer, us
e C99 syntax
drivers/isdn/hisax/hfc4s8s_l1.c:1662:7: warning: obsolete struct initializer, us
e C99 syntax
drivers/isdn/hisax/hfc4s8s_l1.c:1663:7: warning: obsolete struct initializer, us
e C99 syntax
drivers/isdn/hisax/hfc4s8s_l1.c:1664:7: warning: obsolete struct initializer, us
e C99 syntax
drivers/isdn/hisax/hfc4s8s_l1.c:1065:18: warning: Using plain integer as NULL po
inter

Signed-off-by: Randy Dunlap <rddunlap@osdl.org>

diffstat:=
 drivers/isdn/hisax/hfc4s8s_l1.c |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

diff -Naurp ./drivers/isdn/hisax/hfc4s8s_l1.c~isdn_hfcssll_clean ./drivers/isdn/hisax/hfc4s8s_l1.c
--- ./drivers/isdn/hisax/hfc4s8s_l1.c~isdn_hfcssll_clean	2005-03-26 21:48:11.000000000 -0800
+++ ./drivers/isdn/hisax/hfc4s8s_l1.c	2005-03-27 21:17:01.000000000 -0800
@@ -1062,7 +1062,7 @@ tx_b_frame(struct hfc4s8s_btype *bch)
 				Write_hfc8(l1->hw, A_INC_RES_FIFO, 1);
 			}
 			ack_len += skb->truesize;
-			bch->tx_skb = 0;
+			bch->tx_skb = NULL;
 			bch->tx_cnt = 0;
 			dev_kfree_skb(skb);
 		} else
@@ -1658,10 +1658,10 @@ hfc4s8s_remove(struct pci_dev *pdev)
 }
 
 static struct pci_driver hfc4s8s_driver = {
-      name:"hfc4s8s_l1",
-      probe:hfc4s8s_probe,
-      remove:__devexit_p(hfc4s8s_remove),
-      id_table:hfc4s8s_ids,
+      .name	= "hfc4s8s_l1",
+      .probe	= hfc4s8s_probe,
+      .remove	= __devexit_p(hfc4s8s_remove),
+      .id_table	= hfc4s8s_ids,
 };
 
 /**********************/


---
