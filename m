Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268236AbUIGPBl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268236AbUIGPBl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Sep 2004 11:01:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267720AbUIGPAT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Sep 2004 11:00:19 -0400
Received: from verein.lst.de ([213.95.11.210]:18074 "EHLO mail.lst.de")
	by vger.kernel.org with ESMTP id S268213AbUIGO42 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Sep 2004 10:56:28 -0400
Date: Tue, 7 Sep 2004 16:56:23 +0200
From: Christoph Hellwig <hch@lst.de>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] unexport devfs_mk_symlink
Message-ID: <20040907145623.GB9109@lst.de>
Mail-Followup-To: Christoph Hellwig <hch>, akpm@osdl.org,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Spam-Score: -4.901 () BAYES_00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Only legit user is the partitioning code, in addition some uml code is
still using despite the uml people beeing told to fix it at least two
times.


--- 1.113/fs/devfs/base.c	2004-08-08 23:07:47 +02:00
+++ edited/fs/devfs/base.c	2004-09-07 13:26:47 +02:00
@@ -1802,7 +1802,6 @@
 
 __setup("devfs=", devfs_setup);
 
-EXPORT_SYMBOL(devfs_mk_symlink);
 EXPORT_SYMBOL(devfs_mk_dir);
 EXPORT_SYMBOL(devfs_remove);
 
