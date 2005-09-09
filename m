Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964911AbVIIPgt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964911AbVIIPgt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Sep 2005 11:36:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964921AbVIIPgt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Sep 2005 11:36:49 -0400
Received: from colino.net ([213.41.131.56]:23293 "EHLO paperstreet.colino.net")
	by vger.kernel.org with ESMTP id S964911AbVIIPgs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Sep 2005 11:36:48 -0400
Date: Fri, 9 Sep 2005 17:36:42 +0200
From: Colin Leroy <colin@colino.net>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fix oom_kill_task
X-Mailer: Sylpheed-Claws 1.9.14cvs11 (GTK+ 2.6.9; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <20050909153642.1D5CE101D8@paperstreet.colino.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Alternatively, if sending SIGKILL is intended, here's the patch that fixes the 
comment.

Thanks,

Signed-Off-By: Colin Leroy <colin@colino.net>
--- a/mm/oom_kill.c	2005-09-09 17:29:08.000000000 +0200
+++ b/mm/oom_kill.c	2005-09-09 17:32:47.000000000 +0200
@@ -168,11 +168,6 @@ static struct task_struct * select_bad_p
 	return chosen;
 }
 
-/**
- * We must be careful though to never send SIGKILL a process with
- * CAP_SYS_RAW_IO set, send SIGTERM instead (but it's unlikely that
- * we select a process with CAP_SYS_RAW_IO set).
- */
 static void __oom_kill_task(task_t *p)
 {
 	if (p->pid == 1) {
