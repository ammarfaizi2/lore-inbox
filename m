Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261784AbVACVAL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261784AbVACVAL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jan 2005 16:00:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261787AbVACVAL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jan 2005 16:00:11 -0500
Received: from av3-2-sn3.vrr.skanova.net ([81.228.9.110]:56464 "EHLO
	av3-2-sn3.vrr.skanova.net") by vger.kernel.org with ESMTP
	id S261784AbVACU7z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jan 2005 15:59:55 -0500
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] pktcdvd: make two functions static
References: <20050103011113.6f6c8f44.akpm@osdl.org>
From: Peter Osterlund <petero2@telia.com>
Date: 03 Jan 2005 21:42:09 +0100
In-Reply-To: <20050103011113.6f6c8f44.akpm@osdl.org>
Message-ID: <m3acrqutwe.fsf@telia.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Make two needlessly global functions static.

Signed-off-by: Adrian Bunk <bunk@stusta.de>
Signed-off-by: Peter Osterlund <petero2@telia.com>
---

 linux-petero/drivers/block/pktcdvd.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff -puN drivers/block/pktcdvd.c~pktcdvd-static drivers/block/pktcdvd.c
--- linux/drivers/block/pktcdvd.c~pktcdvd-static	2005-01-02 22:27:26.000000000 +0100
+++ linux-petero/drivers/block/pktcdvd.c	2005-01-03 21:39:56.985007024 +0100
@@ -2627,7 +2627,7 @@ static struct miscdevice pkt_misc = {
 	.fops  		= &pkt_ctl_fops
 };
 
-int pkt_init(void)
+static int pkt_init(void)
 {
 	int ret;
 
@@ -2663,7 +2663,7 @@ out2:
 	return ret;
 }
 
-void pkt_exit(void)
+static void pkt_exit(void)
 {
 	remove_proc_entry("pktcdvd", proc_root_driver);
 	misc_deregister(&pkt_misc);
_

-- 
Peter Osterlund - petero2@telia.com
http://web.telia.com/~u89404340
