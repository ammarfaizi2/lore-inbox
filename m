Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269479AbUJSQOF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269479AbUJSQOF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Oct 2004 12:14:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269492AbUJSQKp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Oct 2004 12:10:45 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:28691 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S269485AbUJSQFG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Oct 2004 12:05:06 -0400
Date: Tue, 19 Oct 2004 18:04:31 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>, jgarzik@pobox.com, mikep@linuxtr.net,
       p2@ace.ulyssis.student.kuleuven.ac.be
Cc: linux-net@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [2.6 patch] net/tokenring/olympic.c: remove unused variable (fwd)
Message-ID: <20041019160431.GA1960@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The trivial patch forwarded below still applies and compiles against 
2.6.9-rc4-mm1.

Please apply.



----- Forwarded message from Adrian Bunk <bunk@stusta.de> -----

Date:	Thu, 7 Oct 2004 22:58:18 +0200
From: Adrian Bunk <bunk@stusta.de>
To: jgarzik@pobox.com, mikep@linuxtr.net,
	p2@ace.ulyssis.student.kuleuven.ac.be
Cc: linux-net@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [2.6 patch] net/tokenring/olympic.c: remove unused variable

Recent changes in Linus' tree removed all uses of a variable, resulting
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

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

----- End forwarded message -----

