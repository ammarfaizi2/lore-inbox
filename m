Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751332AbWAVUIS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751332AbWAVUIS (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Jan 2006 15:08:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751333AbWAVUHz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Jan 2006 15:07:55 -0500
Received: from xenotime.net ([66.160.160.81]:43938 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1751332AbWAVUHy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Jan 2006 15:07:54 -0500
Date: Sun, 22 Jan 2006 12:04:57 -0800
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: pj@sgi.com, akpm <akpm@osdl.org>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: [PATCH] cpuset: fix sparse warning
Message-Id: <20060122120457.0b6a14c1.rdunlap@xenotime.net>
Organization: YPO4
X-Mailer: Sylpheed version 2.0.4 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@xenotime.net>

fix sparse warning:
kernel/cpuset.c:644:38: warning: non-ANSI function declaration of function 'cpuset_update_task_memory_state'

Signed-off-by: Randy Dunlap <rdunlap@xenotime.net>
---
 kernel/cpuset.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

--- linux-2616-rc1g4.orig/kernel/cpuset.c
+++ linux-2616-rc1g4/kernel/cpuset.c
@@ -641,7 +641,7 @@ static void guarantee_online_mems(const 
  * task has been modifying its cpuset.
  */
 
-void cpuset_update_task_memory_state()
+void cpuset_update_task_memory_state(void)
 {
 	int my_cpusets_mem_gen;
 	struct task_struct *tsk = current;


---
