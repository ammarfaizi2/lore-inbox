Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261220AbVBJTWI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261220AbVBJTWI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Feb 2005 14:22:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261377AbVBJTVr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Feb 2005 14:21:47 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:22790 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261367AbVBJTUP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Feb 2005 14:20:15 -0500
Date: Thu, 10 Feb 2005 20:20:10 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: [2.6.11-rc3-mm2 patch] mxser.c: remove unused variable
Message-ID: <20050210192010.GH2958@stusta.de>
References: <20050210023508.3583cf87.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050210023508.3583cf87.akpm@osdl.org>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The following warning comes from Linus' tree:

<--  snip  -->

...
  CC      drivers/char/mxser.o
drivers/char/mxser.c: In function `mxser_initbrd':
drivers/char/mxser.c:551: warning: unused variable `flags'
...

<--  snip  -->


The fis is simple:

Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.11-rc3-mm2-full/drivers/char/mxser.c.old	2005-02-10 19:58:36.000000000 +0100
+++ linux-2.6.11-rc3-mm2-full/drivers/char/mxser.c	2005-02-10 19:58:56.000000000 +0100
@@ -548,7 +548,6 @@
 static int mxser_initbrd(int board, struct mxser_hwconf *hwconf)
 {
 	struct mxser_struct *info;
-	unsigned long flags;
 	int retval;
 	int i, n;
 

