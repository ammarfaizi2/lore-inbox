Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266289AbUAIFek (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jan 2004 00:34:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266283AbUAIFek
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jan 2004 00:34:40 -0500
Received: from web12609.mail.yahoo.com ([216.136.173.179]:16767 "HELO
	web12609.mail.yahoo.com") by vger.kernel.org with SMTP
	id S266277AbUAIFeh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jan 2004 00:34:37 -0500
Message-ID: <20040109053433.3812.qmail@web12609.mail.yahoo.com>
Date: Thu, 8 Jan 2004 21:34:33 -0800 (PST)
From: Joilnen Leite <pidhash@yahoo.com>
Subject: about ipmr
To: linux-net@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: davem@redhat.com
In-Reply-To: <200401071534.i07FY8IY032449@green.mif.pg.gda.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

excuse me for my english bad :) !

alloc_netdev func can return NULL and I think that is
not right to use dev pointer in this case without a
test.
so maybe it is better ? !

---------------------------------------------

--- knl_src/net/ipv4/ipmr.c	2003-11-25
16:02:59.000000000 -0300
+++ ipmr_patch.c	2004-01-08 10:21:22.000000000 -0300
@@ -205,7 +205,7 @@
 	dev = alloc_netdev(sizeof(struct net_device_stats),
"pimreg",
 			   reg_vif_setup);
 
-	if (register_netdevice(dev)) {
+	if (dev&&register_netdevice(dev)) {
 		kfree(dev);
 		return NULL;
 	}

----------------------------------------------

sorry if is a dumb question and thanks for atention

pub  1024D/5139533E Joilnen Batista Leite 
F565 BD0B 1A39 390D 827E  03E5 0CD4 0F20 5139 533E


__________________________________
Do you Yahoo!?
Yahoo! Hotjobs: Enter the "Signing Bonus" Sweepstakes
http://hotjobs.sweepstakes.yahoo.com/signingbonus
