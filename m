Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422850AbWI3AIa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422850AbWI3AIa (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Sep 2006 20:08:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422851AbWI3AGl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Sep 2006 20:06:41 -0400
Received: from www.osadl.org ([213.239.205.134]:28308 "EHLO mail.tglx.de")
	by vger.kernel.org with ESMTP id S1422850AbWI3AEN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Sep 2006 20:04:13 -0400
Message-Id: <20060929234440.751131000@cruncher.tec.linutronix.de>
References: <20060929234435.330586000@cruncher.tec.linutronix.de>
Date: Fri, 29 Sep 2006 23:58:36 -0000
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       Jim Gettys <jg@laptop.org>, John Stultz <johnstul@us.ibm.com>,
       David Woodhouse <dwmw2@infradead.org>,
       Arjan van de Ven <arjan@infradead.org>, Dave Jones <davej@redhat.com>
Subject: [patch 17/23] dyntick: add nohz stats to /proc/stat
Content-Disposition: inline; filename=hrtimer-add-stats.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

add nohz stats to /proc/stat.

Signed-off-by: Ingo Molnar <mingo@elte.hu>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
--
 fs/proc/proc_misc.c |    2 ++
 1 file changed, 2 insertions(+)

Index: linux-2.6.18-mm2/fs/proc/proc_misc.c
===================================================================
--- linux-2.6.18-mm2.orig/fs/proc/proc_misc.c	2006-09-30 01:41:10.000000000 +0200
+++ linux-2.6.18-mm2/fs/proc/proc_misc.c	2006-09-30 01:41:19.000000000 +0200
@@ -527,6 +527,8 @@ static int show_stat(struct seq_file *p,
 		nr_running(),
 		nr_iowait());
 
+	show_no_hz_stats(p);
+
 	return 0;
 }
 

--

