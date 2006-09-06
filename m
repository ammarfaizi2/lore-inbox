Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751600AbWIFQbx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751600AbWIFQbx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Sep 2006 12:31:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751599AbWIFQbx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Sep 2006 12:31:53 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:53475 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1751502AbWIFQbw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Sep 2006 12:31:52 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Andrew Morton <akpm@osdl.org>
Cc: <linux-kernel@vger.kernel.org>
Subject: [PATCH 5/5] proc: Use pid_task instead of open coding it
References: <m1odttx8uz.fsf@ebiederm.dsl.xmission.com>
	<m1k64hx8rx.fsf@ebiederm.dsl.xmission.com>
	<m1fyf5x8ny.fsf_-_@ebiederm.dsl.xmission.com>
	<m1bqptx8lm.fsf_-_@ebiederm.dsl.xmission.com>
Date: Wed, 06 Sep 2006 10:31:12 -0600
In-Reply-To: <m1bqptx8lm.fsf_-_@ebiederm.dsl.xmission.com> (Eric
	W. Biederman's message of "Wed, 06 Sep 2006 10:28:37 -0600")
Message-ID: <m14pvlx8hb.fsf_-_@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
---
 fs/proc/base.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/fs/proc/base.c b/fs/proc/base.c
index 5500ff6..5da5f5f 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -958,7 +958,7 @@ static struct inode *proc_pid_make_inode
 	/*
 	 * grab the reference to task.
 	 */
-	ei->pid = get_pid(task->pids[PIDTYPE_PID].pid);
+	ei->pid = get_pid(task_pid(task));
 	if (!ei->pid)
 		goto out_unlock;
 
-- 
1.4.2.rc3.g7e18e-dirty

