Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262812AbUCOVrc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Mar 2004 16:47:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262813AbUCOVrc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Mar 2004 16:47:32 -0500
Received: from delerium.kernelslacker.org ([81.187.208.145]:45791 "EHLO
	delerium.codemonkey.org.uk") by vger.kernel.org with ESMTP
	id S262812AbUCOVra (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Mar 2004 16:47:30 -0500
Date: Mon, 15 Mar 2004 21:46:59 GMT
Message-Id: <200403152146.i2FLkx8r002930@delerium.codemonkey.org.uk>
To: linux-kernel@vger.kernel.org
From: davej@redhat.com
Cc: torvalds@osdl.org, akpm@osdl.org, jgarzik@pobox.com
Subject: [3C509] Remove unneeded cast.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--- linux-2.6.4/drivers/net/3c509.c~	2004-03-15 20:21:16.000000000 +0000
+++ linux-2.6.4/drivers/net/3c509.c	2004-03-15 20:22:18.000000000 +0000
@@ -1678,7 +1678,7 @@
 	struct net_device *next_dev;
 
 	while (el3_root_dev) {
-		struct el3_private *lp = (struct el3_private *)el3_root_dev->priv;
+		struct el3_private *lp = el3_root_dev->priv;
 
 		next_dev = lp->next_dev;
 		el3_common_remove (el3_root_dev);

