Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751808AbWCDMPW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751808AbWCDMPW (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Mar 2006 07:15:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751850AbWCDMOy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Mar 2006 07:14:54 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:23824 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751830AbWCDMOp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Mar 2006 07:14:45 -0500
Date: Sat, 4 Mar 2006 13:14:44 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [-mm patch] NFS: make 2 functions static
Message-ID: <20060304121444.GR9295@stusta.de>
References: <20060303045651.1f3b55ec.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060303045651.1f3b55ec.akpm@osdl.org>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 03, 2006 at 04:56:51AM -0800, Andrew Morton wrote:
>...
> Changes since 2.6.16-rc5-mm1:
>...
>  git-nfs.patch
>...
>  git trees
>...

This introduces two needlessly global functions.


Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 fs/lockd/svclock.c |    2 +-
 net/sunrpc/stats.c |    3 ++-
 2 files changed, 3 insertions(+), 2 deletions(-)

--- linux-2.6.16-rc5-mm2-full/fs/lockd/svclock.c.old	2006-03-03 18:14:09.000000000 +0100
+++ linux-2.6.16-rc5-mm2-full/fs/lockd/svclock.c	2006-03-03 18:14:17.000000000 +0100
@@ -636,7 +636,7 @@
 	svc_wake_up(block->b_daemon);
 }
 
-void nlmsvc_grant_release(void *data)
+static void nlmsvc_grant_release(void *data)
 {
 	nlmsvc_release_block(data);
 }
--- linux-2.6.16-rc5-mm2-full/net/sunrpc/stats.c.old	2006-03-03 18:24:48.000000000 +0100
+++ linux-2.6.16-rc5-mm2-full/net/sunrpc/stats.c	2006-03-03 18:25:10.000000000 +0100
@@ -176,7 +176,8 @@
 	op_metrics->om_execute += execute;
 }
 
-void _print_name(struct seq_file *seq, unsigned int op, struct rpc_procinfo *procs)
+static void _print_name(struct seq_file *seq, unsigned int op,
+			struct rpc_procinfo *procs)
 {
 	if (procs[op].p_name)
 		seq_printf(seq, "\t%12s: ", procs[op].p_name);
