Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315942AbSHXJ66>; Sat, 24 Aug 2002 05:58:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315928AbSHXJ66>; Sat, 24 Aug 2002 05:58:58 -0400
Received: from ns2.sea.interquest.net ([66.135.144.2]:40364 "EHLO ns2.sea")
	by vger.kernel.org with ESMTP id <S315925AbSHXJ65>;
	Sat, 24 Aug 2002 05:58:57 -0400
Date: Sat, 24 Aug 2002 03:08:55 -0700
From: silvio@qualys.com
To: linux-kernel@vger.kernel.org
Subject: [PATCH TRIVIAL]: repost 2.4.19/drivers/atm/iphase.c
Message-ID: <20020824030855.A2399@hamsec.aurora.sfo.interquest.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="Q68bSM7Ycu6FN28Q"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Q68bSM7Ycu6FN28Q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

i must be on drugs.. forgot to attach patch! (of like 1 line!)

--
Silvio

--Q68bSM7Ycu6FN28Q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="patch.linux3"

--- linux-2.4.19/drivers/atm/iphase.c	Mon Feb 25 11:37:57 2002
+++ linux-2.4.19-dev/drivers/atm/iphase.c	Sat Aug 24 02:44:15 2002
@@ -1990,6 +1990,7 @@
             printk(KERN_ERR DEV_LABEL " couldn't get mem\n");
             return -EAGAIN;
         }
+/* XXX: memory leak on failure */
        	for (i= 0; i< iadev->num_tx_desc; i++)
        	{
  
@@ -2002,6 +2003,7 @@
         }
         iadev->desc_tbl = kmalloc(iadev->num_tx_desc *
                                    sizeof(struct desc_tbl_t), GFP_KERNEL);
+	if (iadev->desc_tbl == NULL) return -EAGAIN;
   
 	/* Communication Queues base address */  
         i = TX_COMP_Q * iadev->memSize;

--Q68bSM7Ycu6FN28Q--
