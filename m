Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261932AbULGTsd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261932AbULGTsd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Dec 2004 14:48:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261917AbULGTid
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Dec 2004 14:38:33 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:41227 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261904AbULGTf1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Dec 2004 14:35:27 -0500
Date: Tue, 7 Dec 2004 20:35:18 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] binfmt_script.c: make struct script_format static (fwd)
Message-ID: <20041207193518.GB7250@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch forwarded below still applies and compiles against 
2.6.10-rc2-mm4.

Please apply.



----- Forwarded message from Adrian Bunk <bunk@stusta.de> -----

Date:	Sat, 30 Oct 2004 18:42:48 +0200
From: Adrian Bunk <bunk@stusta.de>
To: linux-kernel@vger.kernel.org
Subject: [2.6 patch] binfmt_script.c: make struct script_format static


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

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

----- End forwarded message -----

