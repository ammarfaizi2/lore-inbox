Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263931AbRFMMHk>; Wed, 13 Jun 2001 08:07:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263932AbRFMMHb>; Wed, 13 Jun 2001 08:07:31 -0400
Received: from firewall.ocs.com.au ([203.34.97.9]:52723 "EHLO ocs4.ocs-net")
	by vger.kernel.org with ESMTP id <S263931AbRFMMHL>;
	Wed, 13 Jun 2001 08:07:11 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: torvalds@transmeta.com
cc: linux-kernel@vger.kernel.org
Subject: [patch] 2.4.6-pre3 unresolved symbol do_softirq
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 13 Jun 2001 22:07:00 +1000
Message-ID: <8272.992434020@ocs4.ocs-net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

do_softirq is called from asm code which does not get preprocessed.
It needs to be exported with no version.

Against 2.4.6-pre3.  Note to users: you must run make mrproper after
applying this patch.

Index: 6-pre3.1/kernel/ksyms.c
--- 6-pre3.1/kernel/ksyms.c Sat, 09 Jun 2001 11:25:53 +1000 kaos (linux-2.4/j/46_ksyms.c 1.1.2.2.1.1.2.1.1.8.2.1.2.1 644)
+++ 6-pre3.1(w)/kernel/ksyms.c Wed, 13 Jun 2001 22:04:07 +1000 kaos (linux-2.4/j/46_ksyms.c 1.1.2.2.1.1.2.1.1.8.2.1.2.1 644)
@@ -536,7 +536,7 @@ EXPORT_SYMBOL(remove_bh);
 EXPORT_SYMBOL(tasklet_init);
 EXPORT_SYMBOL(tasklet_kill);
 EXPORT_SYMBOL(__run_task_queue);
-EXPORT_SYMBOL(do_softirq);
+EXPORT_SYMBOL_NOVERS(do_softirq);
 EXPORT_SYMBOL(tasklet_schedule);
 EXPORT_SYMBOL(tasklet_hi_schedule);
 

