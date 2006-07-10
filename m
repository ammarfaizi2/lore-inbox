Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965273AbWGJWnU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965273AbWGJWnU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jul 2006 18:43:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965296AbWGJWnU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jul 2006 18:43:20 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:17316 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S965273AbWGJWnT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jul 2006 18:43:19 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Andrew Morton <akpm@osdl.org>
Subject: [PATCH] pid: Remove temporary debug code in attach_pid
CC: <linux-kernel@vger.kernel.org>, Oleg Nesterov <oleg@tv-sign.ru>
Date: Mon, 10 Jul 2006 16:42:31 -0600
Message-ID: <m1hd1pkroo.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


With the patches flying between Oleg and myself somehow this temporary
debug code got left in pid.c.  It was never intended to make it to
the stable kernel.

Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
---
 kernel/pid.c |    3 ---
 1 files changed, 0 insertions(+), 3 deletions(-)

diff --git a/kernel/pid.c b/kernel/pid.c
index 3153e96..9d56720 100644
--- a/kernel/pid.c
+++ b/kernel/pid.c
@@ -224,9 +224,6 @@ int fastcall attach_pid(struct task_stru
 	struct pid_link *link;
 	struct pid *pid;
 
-	WARN_ON(!task->pid); /* to be removed soon */
-	WARN_ON(!nr); /* to be removed soon */
-
 	link = &task->pids[type];
 	link->pid = pid = find_pid(nr);
 	hlist_add_head_rcu(&link->node, &pid->tasks[type]);
-- 
1.4.1.gac83a

