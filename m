Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262739AbVAKA6P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262739AbVAKA6P (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jan 2005 19:58:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262616AbVAKA5Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jan 2005 19:57:16 -0500
Received: from fw.osdl.org ([65.172.181.6]:19852 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262760AbVAKAmT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jan 2005 19:42:19 -0500
Date: Mon, 10 Jan 2005 16:42:14 -0800
From: Chris Wright <chrisw@osdl.org>
To: torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] remove duplicate rlim assignment in acct_stack_growth()
Message-ID: <20050110164214.J2357@build.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

remove duplicate rlim assignment in acct_stack_growth()

Signed-off-by: Chris Wright <chrisw@osdl.org>

===== mm/mmap.c 1.155 vs edited =====
--- 1.155/mm/mmap.c	2005-01-10 11:23:35 -08:00
+++ edited/mm/mmap.c	2005-01-10 16:29:06 -08:00
@@ -1346,7 +1346,6 @@ static int acct_stack_growth(struct vm_a
 	struct rlimit *rlim = current->signal->rlim;
 
 	/* address space limit tests */
-	rlim = current->signal->rlim;
 	if (mm->total_vm + grow > rlim[RLIMIT_AS].rlim_cur >> PAGE_SHIFT)
 		return -ENOMEM;
 
