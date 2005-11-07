Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965172AbVKGUOk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965172AbVKGUOk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Nov 2005 15:14:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965253AbVKGUOj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Nov 2005 15:14:39 -0500
Received: from perninha.conectiva.com.br ([200.140.247.100]:31123 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id S965172AbVKGUOi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Nov 2005 15:14:38 -0500
Date: Mon, 7 Nov 2005 18:14:06 -0200
From: Luiz Fernando Capitulino <lcapitulino@mandriva.com.br>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Fix sparse warning in proc/task_mmu.c.
Message-Id: <20051107181406.010bad3c.lcapitulino@mandriva.com.br>
Organization: Mandriva
X-Mailer: Sylpheed version 0.9.10 (GTK+ 1.2.10; i386-conectiva-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The patch below fixes this sparse warning:

fs/proc/task_mmu.c:198:33: warning: Using plain integer as NULL pointer

Signed-off-by: Luiz Capitulino <lcapitulino@mandriva.com.br>

 fs/proc/task_mmu.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -195,7 +195,7 @@ static int show_map_internal(struct seq_
 
 static int show_map(struct seq_file *m, void *v)
 {
-	return show_map_internal(m, v, 0);
+	return show_map_internal(m, v, NULL);
 }
 
 static void smaps_pte_range(struct vm_area_struct *vma, pmd_t *pmd,

-- 
Luiz Fernando N. Capitulino
