Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272136AbTHDVfr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Aug 2003 17:35:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272264AbTHDVfq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Aug 2003 17:35:46 -0400
Received: from rj.sgi.com ([192.82.208.96]:53968 "EHLO rj.sgi.com")
	by vger.kernel.org with ESMTP id S272136AbTHDVfq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Aug 2003 17:35:46 -0400
Date: Mon, 4 Aug 2003 14:35:43 -0700
To: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] make lookup_create non-static
Message-ID: <20030804213543.GA1697@sgi.com>
Mail-Followup-To: akpm@osdl.org, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
From: jbarnes@sgi.com (Jesse Barnes)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Make lookup_create non-static for use by certain pseudofilesystems (e.g.
hwgfs).

Thanks,
Jesse

===== fs/namei.c 1.81 vs edited =====
--- 1.81/fs/namei.c	Thu Jul 10 22:23:45 2003
+++ edited/fs/namei.c	Mon Aug  4 14:32:19 2003
@@ -1376,7 +1376,7 @@
 }
 
 /* SMP-safe */
-static struct dentry *lookup_create(struct nameidata *nd, int is_dir)
+struct dentry *lookup_create(struct nameidata *nd, int is_dir)
 {
 	struct dentry *dentry;
 
