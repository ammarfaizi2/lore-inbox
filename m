Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261569AbVCLP3T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261569AbVCLP3T (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Mar 2005 10:29:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261763AbVCLP3T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Mar 2005 10:29:19 -0500
Received: from av5-2-sn1.fre.skanova.net ([81.228.11.112]:25041 "EHLO
	av5-2-sn1.fre.skanova.net") by vger.kernel.org with ESMTP
	id S261569AbVCLP3O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Mar 2005 10:29:14 -0500
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Use __init and __exit in pktcdvd
From: Peter Osterlund <petero2@telia.com>
Date: 12 Mar 2005 16:29:11 +0100
Message-ID: <m364zw992w.fsf@telia.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds __init and __exit annotations to the pktcdvd driver.

Signed-off-by: Peter Osterlund <petero2@telia.com>
---

 linux-petero/drivers/block/pktcdvd.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff -puN drivers/block/pktcdvd.c~pktcdvd-module-init drivers/block/pktcdvd.c
--- linux/drivers/block/pktcdvd.c~pktcdvd-module-init	2005-03-11 22:23:57.000000000 +0100
+++ linux-petero/drivers/block/pktcdvd.c	2005-03-11 22:23:57.000000000 +0100
@@ -2624,7 +2624,7 @@ static struct miscdevice pkt_misc = {
 	.fops  		= &pkt_ctl_fops
 };
 
-static int pkt_init(void)
+static int __init pkt_init(void)
 {
 	int ret;
 
@@ -2660,7 +2660,7 @@ out2:
 	return ret;
 }
 
-static void pkt_exit(void)
+static void __exit pkt_exit(void)
 {
 	remove_proc_entry("pktcdvd", proc_root_driver);
 	misc_deregister(&pkt_misc);
_

-- 
Peter Osterlund - petero2@telia.com
http://web.telia.com/~u89404340
