Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262641AbUKLWUA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262641AbUKLWUA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Nov 2004 17:20:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262636AbUKLWTJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Nov 2004 17:19:09 -0500
Received: from fw.osdl.org ([65.172.181.6]:11396 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262642AbUKLWRs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Nov 2004 17:17:48 -0500
Date: Fri, 12 Nov 2004 14:17:43 -0800
From: Chris Wright <chrisw@osdl.org>
To: axboe@suse.de
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Mark cfq_exit as an exit function
Message-ID: <20041112141743.U2357@build.pdx.osdl.net>
References: <20041112141556.S14339@build.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20041112141556.S14339@build.pdx.osdl.net>; from chrisw@osdl.org on Fri, Nov 12, 2004 at 02:15:57PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mark cfq_exit function as and exit function, and make it static.

Signed-off-by: Chris Wright <chris@osdl.org>

 cfq-iosched.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

===== drivers/block/cfq-iosched.c 1.12 vs edited =====
--- 1.12/drivers/block/cfq-iosched.c	2004-10-28 00:40:02 -07:00
+++ edited/drivers/block/cfq-iosched.c	2004-10-29 16:35:21 -07:00
@@ -1920,7 +1920,7 @@ int cfq_init(void)
 	return ret;
 }
 
-void cfq_exit(void)
+static void __exit cfq_exit(void)
 {
 	cfq_slab_kill();
 	elv_unregister(&iosched_cfq);
