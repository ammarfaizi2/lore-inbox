Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261715AbUK2Mmu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261715AbUK2Mmu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Nov 2004 07:42:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261714AbUK2Ml0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Nov 2004 07:41:26 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:31507 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261704AbUK2MjH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Nov 2004 07:39:07 -0500
Date: Mon, 29 Nov 2004 13:39:04 +0100
From: Adrian Bunk <bunk@stusta.de>
To: linux-kernel@vger.kernel.org
Subject: [2.6 patch] drivers/block/umem.c: make two functions static
Message-ID: <20041129123904.GR9722@stusta.de>
References: <20041124231055.GN19873@stusta.de> <20041125101220.GC29539@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041125101220.GC29539@infradead.org>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch below makes two needlessly global functions static.


diffstat output:
 drivers/block/umem.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.10-rc1-mm3-full/drivers/block/umem.c.old	2004-11-06 20:19:51.000000000 +0100
+++ linux-2.6.10-rc1-mm3-full/drivers/block/umem.c	2004-11-06 20:20:16.000000000 +0100
@@ -1181,7 +1181,7 @@
 -----------------------------------------------------------------------------------
 */
 
-int __init mm_init(void)
+static int __init mm_init(void)
 {
 	int retval, i;
 	int err;
@@ -1232,7 +1232,7 @@
 --                             mm_cleanup
 -----------------------------------------------------------------------------------
 */
-void __exit mm_cleanup(void)
+static void __exit mm_cleanup(void)
 {
 	int i;
 

