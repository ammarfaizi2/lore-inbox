Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262732AbVDHIA2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262732AbVDHIA2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Apr 2005 04:00:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262754AbVDHH7o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Apr 2005 03:59:44 -0400
Received: from coderock.org ([193.77.147.115]:12512 "EHLO trashy.coderock.org")
	by vger.kernel.org with ESMTP id S262735AbVDHHvY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Apr 2005 03:51:24 -0400
Subject: [patch 6/8] printk : drivers/char/ftape/compressor/zftape-compress.c
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, domen@coderock.org, clucas@rotomalug.org
From: domen@coderock.org
Date: Fri, 08 Apr 2005 09:51:07 +0200
Message-Id: <20050408075107.EE85A1EE91@trashy.coderock.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



printk() calls should include appropriate KERN_* constant.

Signed-off-by: Christophe Lucas <clucas@rotomalug.org>
Signed-off-by: Domen Puncer <domen@coderock.org>
---


 kj-domen/drivers/char/ftape/compressor/zftape-compress.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff -puN drivers/char/ftape/compressor/zftape-compress.c~printk-drivers_char_ftape_compressor_zftape-compress drivers/char/ftape/compressor/zftape-compress.c
--- kj/drivers/char/ftape/compressor/zftape-compress.c~printk-drivers_char_ftape_compressor_zftape-compress	2005-04-05 12:58:03.000000000 +0200
+++ kj-domen/drivers/char/ftape/compressor/zftape-compress.c	2005-04-05 12:58:03.000000000 +0200
@@ -1176,8 +1176,8 @@ KERN_INFO "Compressor for zftape (lzrw3 
         }
 #else /* !MODULE */
 	/* print a short no-nonsense boot message */
-	printk("zftape compressor v1.00a 970514\n");
-	printk("For use with " FTAPE_VERSION "\n");
+	printk(KERN_INFO "zftape compressor v1.00a 970514\n");
+	printk(KERN_INFO "For use with " FTAPE_VERSION "\n");
 #endif /* MODULE */
 	TRACE(ft_t_info, "zft_compressor_init @ 0x%p", zft_compressor_init);
 	TRACE(ft_t_info, "installing compressor for zftape ...");
_
