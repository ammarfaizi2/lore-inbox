Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264588AbUD1Bwg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264588AbUD1Bwg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Apr 2004 21:52:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264592AbUD1Bwf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Apr 2004 21:52:35 -0400
Received: from fw.osdl.org ([65.172.181.6]:29646 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264588AbUD1Bwe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Apr 2004 21:52:34 -0400
Date: Tue, 27 Apr 2004 18:54:42 -0700
From: Dave Olien <dmo@osdl.org>
To: thornber@redhat.com
Cc: dm-devel@redhat.com, linux-kernel@vger.kernel.org
Subject: [PATCH] trivial patch to dm-strip.e
Message-ID: <20040428015442.GA20444@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


add __exit to dm_stripe_exit().


diff -ur linux-2.6.6-rc2-udm1-original/drivers/md/dm-stripe.c linux-2.6.6-rc2-udm1-patched/drivers/md/dm-stripe.c
--- linux-2.6.6-rc2-udm1-original/drivers/md/dm-stripe.c	2004-04-27 18:53:14.000000000 -0700
+++ linux-2.6.6-rc2-udm1-patched/drivers/md/dm-stripe.c	2004-04-27 18:53:06.000000000 -0700
@@ -232,7 +232,7 @@
 	return r;
 }
 
-void dm_stripe_exit(void)
+void __exit dm_stripe_exit(void)
 {
 	if (dm_unregister_target(&stripe_target))
 		DMWARN("striped target unregistration failed");
