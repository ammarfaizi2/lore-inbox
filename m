Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965245AbWBISZr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965245AbWBISZr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Feb 2006 13:25:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965244AbWBISZr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Feb 2006 13:25:47 -0500
Received: from mail.tv-sign.ru ([213.234.233.51]:50093 "EHLO several.ru")
	by vger.kernel.org with ESMTP id S965242AbWBISZq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Feb 2006 13:25:46 -0500
Message-ID: <43EB9B53.C96196D6@tv-sign.ru>
Date: Thu, 09 Feb 2006 22:43:15 +0300
From: Oleg Nesterov <oleg@tv-sign.ru>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] wait_for_helper: trivial style cleanup
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Use NULL instead of (... *)0

Signed-off-by: Oleg Nesterov <oleg@tv-sign.ru>

--- RC-1/kernel/kmod.c~	2005-11-22 19:35:32.000000000 +0300
+++ RC-1/kernel/kmod.c	2006-02-10 00:44:58.000000000 +0300
@@ -170,7 +170,7 @@ static int wait_for_helper(void *data)
 	sa.sa.sa_handler = SIG_IGN;
 	sa.sa.sa_flags = 0;
 	siginitset(&sa.sa.sa_mask, sigmask(SIGCHLD));
-	do_sigaction(SIGCHLD, &sa, (struct k_sigaction *)0);
+	do_sigaction(SIGCHLD, &sa, NULL);
 	allow_signal(SIGCHLD);
 
 	pid = kernel_thread(____call_usermodehelper, sub_info, SIGCHLD);
