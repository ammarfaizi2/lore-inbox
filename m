Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268193AbTBNBev>; Thu, 13 Feb 2003 20:34:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268194AbTBNBev>; Thu, 13 Feb 2003 20:34:51 -0500
Received: from covert.brown-ring.iadfw.net ([209.196.123.142]:27405 "EHLO
	covert.brown-ring.iadfw.net") by vger.kernel.org with ESMTP
	id <S268193AbTBNBet>; Thu, 13 Feb 2003 20:34:49 -0500
Date: Thu, 13 Feb 2003 19:41:23 -0600
From: Art Haas <ahaas@airmail.net>
To: linux-kernel@vger.kernel.org
Cc: Linus Torvalds <torvalds@transmeta.com>
Subject: [PATCH] C99 initiailzers for fs/dquot.c
Message-ID: <20030214014123.GF13561@debian>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

This patch adds C99 initializers in an effort to aid readability and to
remove warnings if '-W' is used.

Art Haas

===== fs/dquot.c 1.58 vs edited =====
--- 1.58/fs/dquot.c	Sun Feb  2 15:40:31 2003
+++ edited/fs/dquot.c	Thu Feb 13 19:37:09 2003
@@ -1382,25 +1382,93 @@
 };
 
 static ctl_table fs_dqstats_table[] = {
-	{FS_DQ_LOOKUPS, "lookups", &dqstats.lookups, sizeof(int), 0444, NULL, &proc_dointvec},
-	{FS_DQ_DROPS, "drops", &dqstats.drops, sizeof(int), 0444, NULL, &proc_dointvec},
-	{FS_DQ_READS, "reads", &dqstats.reads, sizeof(int), 0444, NULL, &proc_dointvec},
-	{FS_DQ_WRITES, "writes", &dqstats.writes, sizeof(int), 0444, NULL, &proc_dointvec},
-	{FS_DQ_CACHE_HITS, "cache_hits", &dqstats.cache_hits, sizeof(int), 0444, NULL, &proc_dointvec},
-	{FS_DQ_ALLOCATED, "allocated_dquots", &dqstats.allocated_dquots, sizeof(int), 0444, NULL, &proc_dointvec},
-	{FS_DQ_FREE, "free_dquots", &dqstats.free_dquots, sizeof(int), 0444, NULL, &proc_dointvec},
-	{FS_DQ_SYNCS, "syncs", &dqstats.syncs, sizeof(int), 0444, NULL, &proc_dointvec},
-	{},
+	{
+		.ctl_name	= FS_DQ_LOOKUPS,
+		.procname	= "lookups",
+		.data		= &dqstats.lookups,
+		.maxlen		= sizeof(int),
+		.mode		= 0444,
+		.proc_handler	= &proc_dointvec
+	},
+	{
+		.ctl_name	= FS_DQ_DROPS,
+		.procname	= "drops",
+		.data		= &dqstats.drops,
+		.maxlen		= sizeof(int),
+		.mode		= 0444,
+		.proc_handler	= &proc_dointvec
+	},
+	{
+		.ctl_name	= FS_DQ_READS,
+		.procname	= "reads",
+		.data		= &dqstats.reads,
+		.maxlen		= sizeof(int),
+		.mode		= 0444,
+		.proc_handler	= &proc_dointvec
+	},
+	{
+		.ctl_name	= FS_DQ_WRITES,
+		.procname	= "writes",
+		.data		= &dqstats.writes,
+		.maxlen		= sizeof(int),
+		.mode		= 0444,
+		.proc_handler	= &proc_dointvec
+	},
+	{
+		.ctl_name	= FS_DQ_CACHE_HITS,
+		.procname	= "cache_hits",
+		.data		= &dqstats.cache_hits,
+		.maxlen		= sizeof(int),
+		.mode		= 0444,
+		.proc_handler	= &proc_dointvec
+	},
+	{
+		.ctl_name	= FS_DQ_ALLOCATED,
+		.procname	= "allocated_dquots",
+		.data		= &dqstats.allocated_dquots,
+		.maxlen		= sizeof(int),
+		.mode		= 0444,
+		.proc_handler	= &proc_dointvec
+	},
+	{
+		.ctl_name	= FS_DQ_FREE,
+		.procname	= "free_dquots",
+		.data		= &dqstats.free_dquots,
+		.maxlen		= sizeof(int),
+		.mode		= 0444,
+		.proc_handler	= &proc_dointvec
+	},
+	{
+		.ctl_name	= FS_DQ_SYNCS,
+		.procname	= "syncs",
+		.data		= &dqstats.syncs,
+		.maxlen		= sizeof(int),
+		.mode		= 0444,
+		.proc_handler	= &proc_dointvec
+	},
+	{ .ctl_name = 0 },
 };
 
 static ctl_table fs_table[] = {
-	{FS_DQSTATS, "quota", NULL, 0, 0555, fs_dqstats_table},
-	{},
+	{
+		.ctl_name	= FS_DQSTATS,
+		.procname	= "quota",
+		.maxlen		= 0,
+		.mode		= 0555,
+		.child		= fs_dqstats_table
+	},
+	{ .ctl_name = 0 },
 };
 
 static ctl_table sys_table[] = {
-	{CTL_FS, "fs", NULL, 0, 0555, fs_table},
-	{},
+	{
+		.ctl_name	= CTL_FS,
+		.procname	= "fs",
+		.maxlen		= 0,
+		.mode		= 0555,
+		.child		= fs_table
+	},
+	{ .ctl_name = 0 },
 };
 
 /* SLAB cache for dquot structures */
-- 
They that can give up essential liberty to obtain a little temporary safety
deserve neither liberty nor safety.
 -- Benjamin Franklin, Historical Review of Pennsylvania, 1759
