Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264582AbUD1Bry@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264582AbUD1Bry (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Apr 2004 21:47:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264588AbUD1Bry
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Apr 2004 21:47:54 -0400
Received: from fw.osdl.org ([65.172.181.6]:24011 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264582AbUD1Brx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Apr 2004 21:47:53 -0400
Date: Tue, 27 Apr 2004 18:50:01 -0700
From: Dave Olien <dmo@osdl.org>
To: thornber@redhat.com
Cc: dm-devel@redhat.com, linux-kernel@vger.kernel.org
Subject: [PATCH] trivial patch to dm-linear.c
Message-ID: <20040428015001.GA19981@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


added __exit to dm_linear_exit().

diff -ur linux-2.6.6-rc2-udm1-original/drivers/md/dm-linear.c linux-2.6.6-rc2-udm1-patched/drivers/md/dm-linear.c
--- linux-2.6.6-rc2-udm1-original/drivers/md/dm-linear.c	2004-04-27 18:48:51.000000000 -0700
+++ linux-2.6.6-rc2-udm1-patched/drivers/md/dm-linear.c	2004-04-27 18:48:26.000000000 -0700
@@ -115,7 +115,7 @@
 	return r;
 }
 
-void dm_linear_exit(void)
+void __exit dm_linear_exit(void)
 {
 	int r = dm_unregister_target(&linear_target);
 
