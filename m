Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262663AbUBZDWD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Feb 2004 22:22:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262665AbUBZDVG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Feb 2004 22:21:06 -0500
Received: from palrel12.hp.com ([156.153.255.237]:31105 "EHLO palrel12.hp.com")
	by vger.kernel.org with ESMTP id S262661AbUBZDSH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Feb 2004 22:18:07 -0500
Date: Wed, 25 Feb 2004 19:18:06 -0800
To: "David S. Miller" <davem@redhat.com>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: [PATCH 2.6 IrDA] ircomm_flags
Message-ID: <20040226031806.GK32263@bougret.hpl.hp.com>
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

irXXX_ircomm_flags.diff :
~~~~~~~~~~~~~~~~~~~~~~~
		<Patch from Stephen Hemminger>
	o [FEATURE] volatile not needed, always use set/test_bit


diff -Nru a/include/net/irda/ircomm_tty.h b/include/net/irda/ircomm_tty.h
--- a/include/net/irda/ircomm_tty.h	Mon Feb 16 10:29:07 2004
+++ b/include/net/irda/ircomm_tty.h	Mon Feb 16 10:29:07 2004
@@ -80,7 +80,7 @@
 	LOCAL_FLOW flow;          /* IrTTP flow status */
 
 	int line;
-	volatile unsigned long flags;
+	unsigned long flags;
 
 	__u8 dlsap_sel;
 	__u8 slsap_sel;
