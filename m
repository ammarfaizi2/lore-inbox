Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268670AbTGIXiu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jul 2003 19:38:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268762AbTGIXhE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jul 2003 19:37:04 -0400
Received: from palrel13.hp.com ([156.153.255.238]:24707 "EHLO palrel13.hp.com")
	by vger.kernel.org with ESMTP id S268760AbTGIXg0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Jul 2003 19:36:26 -0400
Date: Wed, 9 Jul 2003 16:51:00 -0700
To: Jeff Garzik <jgarzik@pobox.com>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: [PATCH 2.5 IrDA] irnet cast
Message-ID: <20030709235100.GE12747@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
From: Jean Tourrilhes <jt@bougret.hpl.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ir254_irnet_cast-2.diff :
~~~~~~~~~~~~~~~~~~~~~~~
		<Suggested by David S. Miller>
	o [FEATURE] remove pointer casting in IrNET debug code missed by David.


diff -u -p linux/net/irda/irnet/irnet_irda.d1.c linux/net/irda/irnet/irnet_irda.c
--- linux/net/irda/irnet/irnet_irda.d1.c	Wed Jul  9 11:49:58 2003
+++ linux/net/irda/irnet/irnet_irda.c	Wed Jul  9 11:50:34 2003
@@ -953,7 +953,7 @@ irnet_setup_server(void)
 		      (void *) &irnet_server.s);
 #endif
 
-  DEXIT(IRDA_SERV_TRACE, " - self=0x%X\n", (unsigned int) &irnet_server.s);
+  DEXIT(IRDA_SERV_TRACE, " - self=0x%p\n", &irnet_server.s);
   return 0;
 }
 
