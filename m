Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269252AbUI3NHw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269252AbUI3NHw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Sep 2004 09:07:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269255AbUI3NHw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Sep 2004 09:07:52 -0400
Received: from mx1.redhat.com ([66.187.233.31]:6031 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S269252AbUI3NHv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Sep 2004 09:07:51 -0400
Date: Thu, 30 Sep 2004 09:07:33 -0400
From: Alan Cox <alan@redhat.com>
To: linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: PATCH: fix typo in capi driver
Message-ID: <20040930130733.GA17802@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I didn't have ISDN builds on in my tree for some reason hence missing these
two from the tidy ups at the end. Marcel Holtmann also came up with the
same fixes although I didnt find that email until I did these.


--- drivers/isdn/capi/capi.c~	2004-09-30 14:00:57.638067496 +0100
+++ drivers/isdn/capi/capi.c	2004-09-30 14:00:57.639067344 +0100
@@ -646,7 +646,7 @@
 		kfree_skb(skb);
 		(void)capiminor_del_ack(mp, datahandle);
 		if (mp->tty)
-			tty_wakeup(tty);
+			tty_wakeup(mp->tty);
 		(void)handle_minor_send(mp);
 
 	} else {


Signed-off-by: Alan Cox

