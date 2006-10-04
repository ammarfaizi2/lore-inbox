Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161918AbWJDRiW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161918AbWJDRiW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Oct 2006 13:38:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161930AbWJDRiQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Oct 2006 13:38:16 -0400
Received: from www.osadl.org ([213.239.205.134]:43493 "EHLO mail.tglx.de")
	by vger.kernel.org with ESMTP id S1161918AbWJDRiH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Oct 2006 13:38:07 -0400
Message-Id: <20061004172224.036452000@cruncher.tec.linutronix.de>
References: <20061004172217.092570000@cruncher.tec.linutronix.de>
Date: Wed, 04 Oct 2006 17:31:50 -0000
From: Thomas Gleixner <tglx@linutronix.de>
To: Andrew Morton <akpm@osdl.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>,
       John Stultz <johnstul@us.ibm.com>,
       Valdis Kletnieks <valdis.kletnieks@vt.edu>,
       Arjan van de Ven <arjan@infradead.org>, Dave Jones <davej@redhat.com>,
       David Woodhouse <dwmw2@infradead.org>, Jim Gettys <jg@laptop.org>,
       Roman Zippel <zippel@linux-m68k.org>
Subject: [patch 19/22] dyntick: add nohz stats to /proc/stat
Content-Disposition: inline; filename=dyntick-add-nohz-stats-to-proc-stat.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

Add nohz stats to /proc/stat.

Signed-off-by: Ingo Molnar <mingo@elte.hu>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
 fs/proc/proc_misc.c |    2 ++
 1 file changed, 2 insertions(+)

Index: linux-2.6.18-mm3/fs/proc/proc_misc.c
===================================================================
--- linux-2.6.18-mm3.orig/fs/proc/proc_misc.c	2006-10-04 18:13:48.000000000 +0200
+++ linux-2.6.18-mm3/fs/proc/proc_misc.c	2006-10-04 18:13:58.000000000 +0200
@@ -527,6 +527,8 @@ static int show_stat(struct seq_file *p,
 		nr_running(),
 		nr_iowait());
 
+	show_no_hz_stats(p);
+
 	return 0;
 }
 

--

