Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265098AbTBOUeN>; Sat, 15 Feb 2003 15:34:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265114AbTBOUeN>; Sat, 15 Feb 2003 15:34:13 -0500
Received: from covert.black-ring.iadfw.net ([209.196.123.142]:37125 "EHLO
	covert.brown-ring.iadfw.net") by vger.kernel.org with ESMTP
	id <S265098AbTBOUeI>; Sat, 15 Feb 2003 15:34:08 -0500
Date: Sat, 15 Feb 2003 14:42:03 -0600
From: Art Haas <ahaas@airmail.net>
To: linux-kernel@vger.kernel.org
Cc: Linus Torvalds <torvalds@transmeta.com>
Subject: [PATCH] C99 initializers for drivers/net/aironet4500_proc.c
Message-ID: <20030215204203.GE20146@debian>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

This patch converts the file to use C99 initializers to improve
readability and remove warnings if '-W' is used.

Art Haas

===== drivers/net/aironet4500_proc.c 1.12 vs edited =====
--- 1.12/drivers/net/aironet4500_proc.c	Fri Jan 10 23:06:26 2003
+++ edited/drivers/net/aironet4500_proc.c	Sat Feb 15 13:43:16 2003
@@ -356,41 +356,160 @@
 
 
 ctl_table awc_exdev_table[] = {
-       {0, NULL, NULL,0, 0400, NULL},
-       {0}
+	{
+	       .ctl_name	= 0,
+	       .maxlen		= 0,
+	       .mode		= 0400,
+       },
+	{ .ctl_name = 0 }
 };
 ctl_table awc_exroot_table[] = {
-        {254, "aironet4500", NULL, 0, 0555, NULL},
-        {0}
+	{
+		.ctl_name	= 254,
+		.procname	= "aironet4500",
+		.maxlen		= 0,
+		.mode		= 0555,
+	},
+	{ .ctl_name = 0 }
 };
 
 ctl_table awc_driver_proc_table[] = {
-        {1, "debug"			, &awc_debug, sizeof(awc_debug), 0600,NULL, proc_dointvec},
-        {2, "bap_sleep"			, &bap_sleep, sizeof(bap_sleep), 0600,NULL, proc_dointvec},
-        {3, "bap_sleep_after_setup"	, &bap_sleep_after_setup, sizeof(bap_sleep_after_setup), 0600,NULL, proc_dointvec},
-        {4, "sleep_before_command"	, &sleep_before_command, sizeof(sleep_before_command), 0600,NULL, proc_dointvec},
-        {5, "bap_sleep_before_write"	, &bap_sleep_before_write, sizeof(bap_sleep_before_write), 0600,NULL, proc_dointvec},
-        {6, "sleep_in_command"		, &sleep_in_command	, sizeof(sleep_in_command), 0600,NULL, proc_dointvec},
-        {7, "both_bap_lock"		, &both_bap_lock	, sizeof(both_bap_lock), 0600,NULL, proc_dointvec},
-        {8, "bap_setup_spinlock"	, &bap_setup_spinlock	, sizeof(bap_setup_spinlock), 0600,NULL, proc_dointvec},
-        {0}
+	{
+		.ctl_name	= 1,
+		.procname	= "debug",
+		.data		= &awc_debug,
+		.maxlen		= sizeof(awc_debug),
+		.mode		= 0600,
+		.proc_handler	= proc_dointvec,
+	},
+	{
+		.ctl_name	= 2,
+		.procname	= "bap_sleep",
+		.data		= &bap_sleep,
+		.maxlen		= sizeof(bap_sleep),
+		.mode		= 0600,
+		.proc_handler	= proc_dointvec,
+	},
+	{
+		.ctl_name	= 3,
+		.procname	= "bap_sleep_after_setup",
+		.data		= &bap_sleep_after_setup,
+		.maxlen		= sizeof(bap_sleep_after_setup),
+		.mode		= 0600,
+		.proc_handler	= proc_dointvec,
+	},
+	{
+		.ctl_name	= 4,
+		.procname	= "sleep_before_command",
+		.data		= &sleep_before_command,
+		.maxlen		= sizeof(sleep_before_command),
+		.mode		= 0600,
+		.proc_handler	= proc_dointvec,
+	},
+	{ 
+		.ctl_name	= 5,
+		.procname	= "bap_sleep_before_write",
+		.data		= &bap_sleep_before_write,
+		.maxlen		= sizeof(bap_sleep_before_write),
+		.mode		= 0600,
+		.proc_handler	= proc_dointvec,
+	},
+	{
+		.ctl_name	= 6,
+		.procname	= "sleep_in_command",
+		.data		= &sleep_in_command,
+		.maxlen		= sizeof(sleep_in_command),
+		.mode		= 0600,
+		.proc_handler	= proc_dointvec,
+	},
+	{
+		.ctl_name	= 7,
+		.procname	= "both_bap_lock",
+		.data		= &both_bap_lock,
+		.maxlen		= sizeof(both_bap_lock),
+		.mode		= 0600,
+		.proc_handler	= proc_dointvec
+	},
+	{
+		.ctl_name	= 8,
+		.procname	= "bap_setup_spinlock",
+		.data		= &bap_setup_spinlock,
+		.maxlen		= sizeof(bap_setup_spinlock),
+		.mode		= 0600,
+		.proc_handler	= proc_dointvec,
+	},
+	{ .ctl_name = 0 }
 };
 
 ctl_table awc_driver_level_ctable[] = {
-        {1, "force_rts_on_shorter"	, NULL, sizeof(int), 0600,NULL, proc_dointvec},
-        {2, "force_tx_rate"		, NULL, sizeof(int), 0600,NULL, proc_dointvec},
-        {3, "ip_tos_reliability_rts"	, NULL, sizeof(int), 0600,NULL, proc_dointvec},
-        {4, "ip_tos_troughput_no_retries", NULL, sizeof(int), 0600,NULL, proc_dointvec},
-        {5, "debug"			, NULL, sizeof(int), 0600,NULL, proc_dointvec},
-        {6, "simple_bridge"		, NULL, sizeof(int), 0600,NULL, proc_dointvec},
-        {7, "p802_11_send"		, NULL, sizeof(int), 0600,NULL, proc_dointvec},
-        {8, "full_stats"		, NULL, sizeof(int), 0600,NULL, proc_dointvec},
-        {0}
+	{
+		.ctl_name	= 1,
+		.procname	= "force_rts_on_shorter",
+		.maxlen		= sizeof(int),
+		.mode		= 0600,
+		.proc_handler	= proc_dointvec,
+	},
+	{
+		.ctl_name	= 2,
+		.procname	= "force_tx_rate",
+		.maxlen		= sizeof(int),
+		.mode		= 0600,
+		.proc_handler	= proc_dointvec,
+	},
+	{
+		.ctl_name	= 3,
+		.procname	= "ip_tos_reliability_rts",
+		.maxlen		= sizeof(int),
+		.mode		= 0600,
+		.proc_handler	= proc_dointvec,
+	},
+	{
+		.ctl_name	= 4,
+		.procname	= "ip_tos_troughput_no_retries",
+		.maxlen		= sizeof(int),
+		.mode		= 0600,
+		.proc_handler	= proc_dointvec,
+	},
+	{
+		.ctl_name	= 5,
+		.procname	= "debug",
+		.maxlen		= sizeof(int),
+		.mode		= 0600,
+		.proc_handler	= proc_dointvec,
+	},
+	{
+		.ctl_name	= 6,
+		.procname	= "simple_bridge",
+		.maxlen		= sizeof(int),
+		.mode		= 0600,
+		.proc_handler	= proc_dointvec,
+	},
+	{
+		.ctl_name	= 7,
+		.procname	= "p802_11_send",
+		.maxlen		= sizeof(int),
+		.mode		= 0600,
+		.proc_handler	= proc_dointvec,
+	},
+	{
+		.ctl_name	= 8,
+		.procname	= "full_stats",
+		.maxlen		= sizeof(int),
+		.mode		= 0600,
+		.proc_handler	= proc_dointvec,
+	},
+	{ .ctl_name = 0 }
 };
 
 ctl_table awc_root_table[] = {
-        {254, "aironet4500", NULL, 0, 0555, awc_driver_proc_table},
-        {0}
+	{
+		.ctl_name	= 254,
+		.procname	= "aironet4500",
+		.maxlen		= 0,
+		.mode		= 0555,
+		.child		= awc_driver_proc_table,
+	},
+	{ .ctl_name = 0 }
 };
 
 struct ctl_table_header * awc_driver_sysctl_header;
-- 
They that can give up essential liberty to obtain a little temporary safety
deserve neither liberty nor safety.
 -- Benjamin Franklin, Historical Review of Pennsylvania, 1759
