Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261980AbVGKSLQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261980AbVGKSLQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Jul 2005 14:11:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261979AbVGKSK5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Jul 2005 14:10:57 -0400
Received: from silver.veritas.com ([143.127.12.111]:12183 "EHLO
	silver.veritas.com") by vger.kernel.org with ESMTP id S262065AbVGKSKp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Jul 2005 14:10:45 -0400
Date: Mon, 11 Jul 2005 19:12:04 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Andrew Morton <akpm@osdl.org>
cc: Mauricio Lin <mauriciolin@gmail.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 3/2] smaps say kB not KB
In-Reply-To: <Pine.LNX.4.61.0507090256430.15778@goblin.wat.veritas.com>
Message-ID: <Pine.LNX.4.61.0507111910410.1522@goblin.wat.veritas.com>
References: <Pine.LNX.4.61.0507090253270.15778@goblin.wat.veritas.com>
 <Pine.LNX.4.61.0507090256430.15778@goblin.wat.veritas.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 11 Jul 2005 18:10:41.0270 (UTC) FILETIME=[D9121960:01C58643]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

/proc/$pid/smaps should be reporting in "kB" not "KB"
(and pray that this doesn't start another kibibytes war ;)

Signed-off-by: Hugh Dickins <hugh@veritas.com>
---

 fs/proc/task_mmu.c |   12 ++++++------
 1 files changed, 6 insertions(+), 6 deletions(-)

--- smaps2/fs/proc/task_mmu.c	2005-07-09 02:29:33.000000000 +0100
+++ smaps3/fs/proc/task_mmu.c	2005-07-11 18:09:13.000000000 +0100
@@ -271,12 +271,12 @@ static int show_smap(struct seq_file *m,
 		seq_path(m, file->f_vfsmnt, file->f_dentry, " \t\n\\");
 
 	seq_printf(m, "\n"
-		   "Size:          %8lu KB\n"
-		   "Rss:           %8lu KB\n"
-		   "Shared_Clean:  %8lu KB\n"
-		   "Shared_Dirty:  %8lu KB\n"
-		   "Private_Clean: %8lu KB\n"
-		   "Private_Dirty: %8lu KB\n",
+		   "Size:          %8lu kB\n"
+		   "Rss:           %8lu kB\n"
+		   "Shared_Clean:  %8lu kB\n"
+		   "Shared_Dirty:  %8lu kB\n"
+		   "Private_Clean: %8lu kB\n"
+		   "Private_Dirty: %8lu kB\n",
 		   vma_len >> 10,
 		   mss.resident >> 10,
 		   mss.shared_clean  >> 10,
