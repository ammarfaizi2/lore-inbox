Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266371AbUFQF2U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266371AbUFQF2U (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jun 2004 01:28:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266376AbUFQF2U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jun 2004 01:28:20 -0400
Received: from fw.osdl.org ([65.172.181.6]:12447 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266371AbUFQF2T (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jun 2004 01:28:19 -0400
Date: Wed, 16 Jun 2004 22:23:35 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: lkml <linux-kernel@vger.kernel.org>
Cc: akpm <akpm@osdl.org>
Subject: [PATCH] remove blank line in show_trace()
Message-Id: <20040616222335.027f001c.rddunlap@osdl.org>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.8a (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Delete a blank line for more error reporting on-screen.

A couple of days ago, Norm Diamond reported some instances
of newlines taking up valuable screen space instead of those
lines containing useful registers/stack/messages.
This removes one instance of an unneeded blank line.

Signed-off-by: Randy Dunlap <rddunlap@osdl.org>


diffstat:=
 arch/i386/kernel/traps.c |    1 -
 1 files changed, 1 deletion(-)

diff -Naurp ./arch/i386/kernel/traps.c~stack_newline ./arch/i386/kernel/traps.c
--- ./arch/i386/kernel/traps.c~stack_newline	2004-06-15 22:19:01.000000000 -0700
+++ ./arch/i386/kernel/traps.c	2004-06-16 21:48:15.000000000 -0700
@@ -163,7 +163,6 @@ void show_trace(struct task_struct *task
 			break;
 		printk(" =======================\n");
 	}
-	printk("\n");
 }
 
 void show_stack(struct task_struct *task, unsigned long *esp)


--
~Randy
