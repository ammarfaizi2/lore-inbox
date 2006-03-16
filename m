Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932254AbWCPD3F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932254AbWCPD3F (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Mar 2006 22:29:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932255AbWCPD3E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Mar 2006 22:29:04 -0500
Received: from fgwmail7.fujitsu.co.jp ([192.51.44.37]:6566 "EHLO
	fgwmail7.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S932254AbWCPD3C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Mar 2006 22:29:02 -0500
Date: Thu, 16 Mar 2006 12:27:48 +0900
From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>
Subject: [PATCH] for_each_possible_cpu [7/19] scsi
Message-Id: <20060316122748.4a603585.kamezawa.hiroyu@jp.fujitsu.com>
Organization: Fujitsu
X-Mailer: Sylpheed version 2.2.0 (GTK+ 2.6.7; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch replaces for_each_cpu with for_each_possible_cpu.

Signed-Off-By: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>

Index: linux-2.6.16-rc6-mm1/drivers/scsi/scsi.c
===================================================================
--- linux-2.6.16-rc6-mm1.orig/drivers/scsi/scsi.c
+++ linux-2.6.16-rc6-mm1/drivers/scsi/scsi.c
@@ -1334,7 +1334,7 @@ static int __init init_scsi(void)
 	if (error)
 		goto cleanup_sysctl;
 
-	for_each_cpu(i)
+	for_each_possible_cpu(i)
 		INIT_LIST_HEAD(&per_cpu(scsi_done_q, i));
 
 	printk(KERN_NOTICE "SCSI subsystem initialized\n");
