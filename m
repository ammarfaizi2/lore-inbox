Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265208AbTLaQq1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Dec 2003 11:46:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265210AbTLaQq1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Dec 2003 11:46:27 -0500
Received: from x35.xmailserver.org ([69.30.125.51]:16771 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP id S265208AbTLaQq0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Dec 2003 11:46:26 -0500
X-AuthUser: davidel@xmailserver.org
Date: Wed, 31 Dec 2003 08:46:26 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@bigblue.dev.mdolabs.com
To: Andrew Morton <akpm@osdl.org>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Shmulik Hen <shmulik.hen@intel.com>
Subject: [patch] bonding compile fix for 2.6.1-rc1-mm1 ...
Message-ID: <Pine.LNX.4.44.0312310843510.2312-100000@bigblue.dev.mdolabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Sending this also to Hen since he has done the last major reshape.



- Davide



--- linux-2.6-rc1-mm1/drivers/net/bonding/bond_main.orig.c	2003-12-31 08:10:38.000000000 -0800
+++ linux-2.6-rc1-mm1/drivers/net/bonding/bond_main.c	2003-12-31 08:37:53.552550706 -0800
@@ -1657,8 +1657,8 @@
 		bond_change_active_slave(bond, NULL);
 	}
 
-	if ((bond->params.mode == BOND_MODE_TLB) ||
-	    (bond->params.mode == BOND_MODE_ALB)) {
+	if ((bond_mode == BOND_MODE_TLB) ||
+	    (bond_mode == BOND_MODE_ALB)) {
 		/* Must be called only after the slave has been
 		 * detached from the list and the curr_active_slave
 		 * has been cleared (if our_slave == old_current),

