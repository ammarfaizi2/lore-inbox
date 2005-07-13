Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261360AbVGMSDa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261360AbVGMSDa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Jul 2005 14:03:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261691AbVGMSD3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Jul 2005 14:03:29 -0400
Received: from [151.97.230.9] ([151.97.230.9]:12780 "EHLO ssc.unict.it")
	by vger.kernel.org with ESMTP id S261510AbVGMSA2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Jul 2005 14:00:28 -0400
Subject: [patch 9/9] remove EXPORT_SYMBOL for root_dev
To: akpm@osdl.org
Cc: jdike@addtoit.com, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net, blaisorblade@yahoo.it,
       hch@infradead.org
From: blaisorblade@yahoo.it
Date: Wed, 13 Jul 2005 20:02:42 +0200
Message-Id: <20050713180243.013CF21E73D@zion.home.lan>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
CC: Christoph Hellwig <hch@infradead.org>

Remove ROOT_DEV after unexporting it in the previous patch, as requested time
ago by Christoph Hellwig.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 linux-2.6.git-broken-paolo/init/do_mounts.c |    2 --
 1 files changed, 2 deletions(-)

diff -puN init/do_mounts.c~remove-export-root_dev init/do_mounts.c
--- linux-2.6.git-broken/init/do_mounts.c~remove-export-root_dev	2005-07-13 19:59:50.000000000 +0200
+++ linux-2.6.git-broken-paolo/init/do_mounts.c	2005-07-13 19:59:50.000000000 +0200
@@ -25,8 +25,6 @@ static char __initdata saved_root_name[6
 /* this is initialized in init/main.c */
 dev_t ROOT_DEV;
 
-EXPORT_SYMBOL(ROOT_DEV);
-
 static int __init load_ramdisk(char *str)
 {
 	rd_doload = simple_strtol(str,NULL,0) & 3;
_
