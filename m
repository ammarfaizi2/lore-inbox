Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751000AbWEPMhw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751000AbWEPMhw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 May 2006 08:37:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751815AbWEPMhw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 May 2006 08:37:52 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:7428 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751010AbWEPMhv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 May 2006 08:37:51 -0400
Date: Tue, 16 May 2006 14:37:50 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>, dwmw2@infradead.org
Cc: linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org
Subject: [-mm patch] make drivers/mtd/nand/cs553x_nand.c:cs553x_init() static
Message-ID: <20060516123750.GS6931@stusta.de>
References: <20060515005637.00b54560.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060515005637.00b54560.akpm@osdl.org>
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 15, 2006 at 12:56:37AM -0700, Andrew Morton wrote:
>...
> Changes since 2.6.17-rc3-mm1:
>...
>  git-mtd.patch
>...
>  git trees
>...

This patch makes the needlessly global cs553x_init() static.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.17-rc4-mm1-full/drivers/mtd/nand/cs553x_nand.c.old	2006-05-16 13:02:13.000000000 +0200
+++ linux-2.6.17-rc4-mm1-full/drivers/mtd/nand/cs553x_nand.c	2006-05-16 13:02:24.000000000 +0200
@@ -267,7 +267,7 @@
 	return err;
 }
 
-int __init cs553x_init(void)
+static int __init cs553x_init(void)
 {
 	int err = -ENXIO;
 	int i;
