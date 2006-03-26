Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751206AbWCZRLR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751206AbWCZRLR (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Mar 2006 12:11:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751253AbWCZRLR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Mar 2006 12:11:17 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:63238 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751206AbWCZRLQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Mar 2006 12:11:16 -0500
Date: Sun, 26 Mar 2006 19:11:14 +0200
From: Adrian Bunk <bunk@stusta.de>
To: linux-m68k@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Alexey Dobriyan <adobriyan@mail.ru>
Subject: [2.6 patch] drivers/block/acsi_slm.c: size_t can't be < 0
Message-ID: <20060326171114.GP4053@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexey Dobriyan <adobriyan@mail.ru>

A size_t can't be < 0.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.14-rc3-git3/drivers/block/acsi_slm.c	2005-10-04 19:24:01.000000000 +1000
+++ .6877.trivial/drivers/block/acsi_slm.c	2005-10-04 19:29:51.000000000 +1000
@@ -369,8 +369,6 @@ static ssize_t slm_read( struct file *fi
 	int length;
 	int end;
 
-	if (count < 0)
-		return( -EINVAL );
 	if (!(page = __get_free_page( GFP_KERNEL )))
 		return( -ENOMEM );
 	

