Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269787AbUJGVVH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269787AbUJGVVH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Oct 2004 17:21:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262329AbUJGVR6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Oct 2004 17:17:58 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:12816 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S268089AbUJGU6x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Oct 2004 16:58:53 -0400
Date: Thu, 7 Oct 2004 22:58:18 +0200
From: Adrian Bunk <bunk@stusta.de>
To: jgarzik@pobox.com, mikep@linuxtr.net,
       p2@ace.ulyssis.student.kuleuven.ac.be
Cc: linux-net@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [2.6 patch] net/tokenring/olympic.c: remove unused variable
Message-ID: <20041007205818.GB4493@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Recent changes in Linus' tree removed all uses of a variable, resulteing
in the following warning:

<--  snip  -->

...
  CC      drivers/net/tokenring/olympic.o
drivers/net/tokenring/olympic.c: In function `olympic_arb_cmd':
drivers/net/tokenring/olympic.c:1404: warning: unused variable `i'
...

<--  snip  -->


The following patch removes this unused variable:


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.9-rc3-mm3/drivers/net/tokenring/olympic.c.old	2004-10-07 22:52:02.000000000 +0200
+++ linux-2.6.9-rc3-mm3/drivers/net/tokenring/olympic.c	2004-10-07 22:53:15.000000000 +0200
@@ -1401,7 +1401,6 @@
 	u16 lan_status = 0, lan_status_diff  ; /* Initialize to stop compiler warning */
 	u8 fdx_prot_error ; 
 	u16 next_ptr;
-	int i ; 
 
 	arb_block = (olympic_priv->olympic_lap + olympic_priv->arb) ; 
 	asb_block = (olympic_priv->olympic_lap + olympic_priv->asb) ; 

