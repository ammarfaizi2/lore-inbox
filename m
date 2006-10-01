Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932491AbWJAXLN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932491AbWJAXLN (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Oct 2006 19:11:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932494AbWJAXH2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Oct 2006 19:07:28 -0400
Received: from www.osadl.org ([213.239.205.134]:22963 "EHLO mail.tglx.de")
	by vger.kernel.org with ESMTP id S932488AbWJAXG6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Oct 2006 19:06:58 -0400
Message-Id: <20061001225725.098974000@cruncher.tec.linutronix.de>
References: <20061001225720.115967000@cruncher.tec.linutronix.de>
Date: Sun, 01 Oct 2006 23:01:05 -0000
From: Thomas Gleixner <tglx@linutronix.de>
To: Andrew Morton <akpm@osdl.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>,
       Jim Gettys <jg@laptop.org>, John Stultz <johnstul@us.ibm.com>,
       David Woodhouse <dwmw2@infradead.org>,
       Arjan van de Ven <arjan@infradead.org>, Dave Jones <davej@redhat.com>
Subject: [patch 18/21] dyntick: add nohz stats to /proc/stat
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
--- linux-2.6.18-mm2.orig/fs/proc/proc_misc.c	2006-10-02 00:55:45.000000000 +0200
+++ linux-2.6.18-mm2/fs/proc/proc_misc.c	2006-10-02 00:55:54.000000000 +0200
@@ -527,6 +527,8 @@ static int show_stat(struct seq_file *p,
 		nr_running(),
 		nr_iowait());
 
+	show_no_hz_stats(p);
+
 	return 0;
 }
 

--

