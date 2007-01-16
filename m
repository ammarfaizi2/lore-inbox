Return-Path: <linux-kernel-owner+w=401wt.eu-S1750853AbXAPSqW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750853AbXAPSqW (ORCPT <rfc822;w@1wt.eu>);
	Tue, 16 Jan 2007 13:46:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750863AbXAPSqW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Jan 2007 13:46:22 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:60936 "EHLO
	ebiederm.dsl.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750849AbXAPSqV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Jan 2007 13:46:21 -0500
From: ebiederm@xmission.com (Eric W. Biederman)
To: Alexey Dobriyan <adobriyan@gmail.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, xfs-masters@oss.sgi.com,
       xfs@oss.sgi.com
Subject: [PATCH] sysctl: fixes for my C99 converion xfs ctl_tables
References: <m1ac0jc4no.fsf@ebiederm.dsl.xmission.com>
	<11689656301563-git-send-email-ebiederm@xmission.com>
	<20070116181651.GA5028@martell.zuzino.mipt.ru>
Date: Tue, 16 Jan 2007 11:45:35 -0700
In-Reply-To: <20070116181651.GA5028@martell.zuzino.mipt.ru> (Alexey Dobriyan's
	message of "Tue, 16 Jan 2007 21:16:51 +0300")
Message-ID: <m1ejpubyk0.fsf_-_@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This kills the extra NULLs and spaces, I missed.

Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
---
 fs/xfs/linux-2.6/xfs_sysctl.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/xfs/linux-2.6/xfs_sysctl.c b/fs/xfs/linux-2.6/xfs_sysctl.c
index 3ac4dab..0dc3b59 100644
--- a/fs/xfs/linux-2.6/xfs_sysctl.c
+++ b/fs/xfs/linux-2.6/xfs_sysctl.c
@@ -94,7 +94,7 @@ STATIC ctl_table xfs_table[] = {
 		.data		= &xfs_params.panic_mask.val,
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
-		.proc_handler	=  &proc_dointvec_minmax,
+		.proc_handler	= &proc_dointvec_minmax,
 		.strategy	= &sysctl_intvec,
 		.extra1		= &xfs_params.panic_mask.min,
 		.extra2		= &xfs_params.panic_mask.max
@@ -140,7 +140,7 @@ STATIC ctl_table xfs_table[] = {
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
 		.proc_handler	= &proc_dointvec_minmax,
-		.strategy	= &sysctl_intvec, NULL,
+		.strategy	= &sysctl_intvec,
 		.extra1		= &xfs_params.inherit_nodump.min,
 		.extra2		= &xfs_params.inherit_nodump.max
 	},
@@ -151,7 +151,7 @@ STATIC ctl_table xfs_table[] = {
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
 		.proc_handler	= &proc_dointvec_minmax,
-		.strategy	= &sysctl_intvec, NULL,
+		.strategy	= &sysctl_intvec,
 		.extra1		= &xfs_params.inherit_noatim.min,
 		.extra2		= &xfs_params.inherit_noatim.max
 	},
@@ -218,7 +218,7 @@ STATIC ctl_table xfs_table[] = {
 		.data		= &xfs_params.stats_clear.val,
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
-		.proc_handler	=  &xfs_stats_clear_proc_handler,
+		.proc_handler	= &xfs_stats_clear_proc_handler,
 		.strategy	= &sysctl_intvec,
 		.extra1		= &xfs_params.stats_clear.min,
 		.extra2		= &xfs_params.stats_clear.max
-- 
1.4.4.1.g278f

