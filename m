Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262684AbUBZDWB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Feb 2004 22:22:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262649AbUBZDUm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Feb 2004 22:20:42 -0500
Received: from palrel12.hp.com ([156.153.255.237]:2798 "EHLO palrel12.hp.com")
	by vger.kernel.org with ESMTP id S262660AbUBZDQJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Feb 2004 22:16:09 -0500
Date: Wed, 25 Feb 2004 19:16:07 -0800
To: "David S. Miller" <davem@redhat.com>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: [PATCH 2.6 IrDA] static_irtty-sir
Message-ID: <20040226031607.GH32263@bougret.hpl.hp.com>
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

irXXX_static_irtty-sir.diff :
~~~~~~~~~~~~~~~~~~~~~~~~~~~
		<Patch from Stephen Hemminger>
	o [FEATURE] make more symbol static (namespace pollution)


diff -Nru a/drivers/net/irda/irtty-sir.c b/drivers/net/irda/irtty-sir.c
--- a/drivers/net/irda/irtty-sir.c	Mon Jan 26 14:37:09 2004
+++ b/drivers/net/irda/irtty-sir.c	Mon Jan 26 14:37:09 2004
@@ -353,7 +353,8 @@
 
 /*****************************************************************/
 
-DECLARE_MUTEX(irtty_sem);		/* serialize ldisc open/close with sir_dev */
+/* serialize ldisc open/close with sir_dev */
+static DECLARE_MUTEX(irtty_sem);
 
 /* notifier from sir_dev when irda% device gets opened (ifup) */
 
