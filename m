Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261213AbUJ3QnZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261213AbUJ3QnZ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Oct 2004 12:43:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261209AbUJ3QnZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Oct 2004 12:43:25 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:27396 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261213AbUJ3QnV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Oct 2004 12:43:21 -0400
Date: Sat, 30 Oct 2004 18:42:48 +0200
From: Adrian Bunk <bunk@stusta.de>
To: linux-kernel@vger.kernel.org
Subject: [2.6 patch] binfmt_script.c: make struct script_format static
Message-ID: <20041030164248.GM4374@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The patch below makes struct script_format in fs/binfmt_script.c static.


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.10-rc1-mm2-full/fs/binfmt_script.c.old	2004-10-30 13:53:00.000000000 +0200
+++ linux-2.6.10-rc1-mm2-full/fs/binfmt_script.c	2004-10-30 13:53:25.000000000 +0200
@@ -96,7 +96,7 @@
 	return search_binary_handler(bprm,regs);
 }
 
-struct linux_binfmt script_format = {
+static struct linux_binfmt script_format = {
 	.module		= THIS_MODULE,
 	.load_binary	= load_script,
 };

