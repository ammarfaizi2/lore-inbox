Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261178AbUKMVMt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261178AbUKMVMt (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Nov 2004 16:12:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261176AbUKMVKV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Nov 2004 16:10:21 -0500
Received: from d063087.adsl.hansenet.de ([80.171.63.87]:24013 "EHLO ds666")
	by vger.kernel.org with ESMTP id S261173AbUKMVHk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Nov 2004 16:07:40 -0500
Subject: [PATCH] eth1394 MODULE_PARM conversion
Cc: <bcollins@debian.org>, <jdittmer@ppp0.net>
To: <linux-kernel@vger.kernel.org>
X-Mailer: mail (GNU Mailutils 0.5)
Message-Id: <E1CT57J-0006SH-00@ds666>
From: Jan Dittmer <jdittmer@sfhq.hn.org>
Date: Sat, 13 Nov 2004 22:07:29 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

# This is a BitKeeper generated diff -Nru style patch.
#
# ChangeSet
#   2004/11/13 21:45:13+01:00 jdittmer@ds666.starfleet 
#   MODULE_PARM conversion
# 
# drivers/ieee1394/eth1394.c
#   2004/11/13 21:45:05+01:00 jdittmer@ds666.starfleet +2 -2
#   Convert MODULE_PARM to module_param
# 
diff -Nru a/drivers/ieee1394/eth1394.c b/drivers/ieee1394/eth1394.c
--- a/drivers/ieee1394/eth1394.c	2004-11-13 22:07:29 +01:00
+++ b/drivers/ieee1394/eth1394.c	2004-11-13 22:07:29 +01:00
@@ -168,11 +168,11 @@
  * consume in the event that some partial datagrams are never completed.  This
  * should probably change to a sysctl item or the like if possible.
  */
-MODULE_PARM(max_partial_datagrams, "i");
+static int max_partial_datagrams = 25;
+module_param(max_partial_datagrams, int, S_IRUGO | S_IWUSR);
 MODULE_PARM_DESC(max_partial_datagrams,
 		 "Maximum number of partially received fragmented datagrams "
 		 "(default = 25).");
-static int max_partial_datagrams = 25;
 
 
 static int ether1394_header(struct sk_buff *skb, struct net_device *dev,
