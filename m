Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261710AbUK2MgZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261710AbUK2MgZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Nov 2004 07:36:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261706AbUK2Me5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Nov 2004 07:34:57 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:4115 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261705AbUK2MdJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Nov 2004 07:33:09 -0500
Date: Mon, 29 Nov 2004 13:33:07 +0100
From: Adrian Bunk <bunk@stusta.de>
To: axboe@suse.de, Peter Osterlund <petero2@telia.com>,
       linux-kernel@vger.kernel.org
Subject: [2.6 patch] drivers/block/pktcdvd.c: make two functions static
Message-ID: <20041129123307.GN9722@stusta.de>
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
 drivers/block/pktcdvd.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.10-rc1-mm3-full/drivers/block/pktcdvd.c.old	2004-11-06 20:16:55.000000000 +0100
+++ linux-2.6.10-rc1-mm3-full/drivers/block/pktcdvd.c	2004-11-06 20:17:22.000000000 +0100
@@ -2627,7 +2627,7 @@
 	.fops  		= &pkt_ctl_fops
 };
 
-int pkt_init(void)
+static int pkt_init(void)
 {
 	int ret;
 
@@ -2663,7 +2663,7 @@
 	return ret;
 }
 
-void pkt_exit(void)
+static void pkt_exit(void)
 {
 	remove_proc_entry("pktcdvd", proc_root_driver);
 	misc_deregister(&pkt_misc);

