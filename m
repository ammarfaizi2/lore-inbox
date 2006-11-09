Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1424283AbWKIXmv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424283AbWKIXmv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Nov 2006 18:42:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424258AbWKIXjr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Nov 2006 18:39:47 -0500
Received: from www.osadl.org ([213.239.205.134]:2461 "EHLO mail.tglx.de")
	by vger.kernel.org with ESMTP id S1161876AbWKIXjQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Nov 2006 18:39:16 -0500
Message-Id: <20061109233035.797724000@cruncher.tec.linutronix.de>
References: <20061109233030.915859000@cruncher.tec.linutronix.de>
Date: Thu, 09 Nov 2006 23:38:32 -0000
From: Thomas Gleixner <tglx@linutronix.de>
To: Andrew Morton <akpm@osdl.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>,
       Len Brown <lenb@kernel.org>, John Stultz <johnstul@us.ibm.com>,
       Arjan van de Ven <arjan@infradead.org>, Andi Kleen <ak@suse.de>,
       Roman Zippel <zippel@linux-m68k.org>
Subject: [patch 15/19] dyntick: add nohz stats to /proc/stat
Content-Disposition: inline;
	filename=dynticks-add-nohz-stats-to-proc-stat.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

Add nohz stats to /proc/stat.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Ingo Molnar <mingo@elte.hu>

diff -puN fs/proc/proc_misc.c~dynticks-add-nohz-stats-to-proc-stat fs/proc/proc_misc.c
--- a/fs/proc/proc_misc.c~dynticks-add-nohz-stats-to-proc-stat
+++ a/fs/proc/proc_misc.c
@@ -527,6 +527,8 @@ static int show_stat(struct seq_file *p,
 		nr_running(),
 		nr_iowait());
 
+	show_no_hz_stats(p);
+
 	return 0;
 }
 
_

--

