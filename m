Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318627AbSIKKJU>; Wed, 11 Sep 2002 06:09:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318641AbSIKKJU>; Wed, 11 Sep 2002 06:09:20 -0400
Received: from mx2.elte.hu ([157.181.151.9]:23176 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S318627AbSIKKJU>;
	Wed, 11 Sep 2002 06:09:20 -0400
Date: Wed, 11 Sep 2002 12:19:43 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: [patch] exit.c compilation fix
Message-ID: <Pine.LNX.4.44.0209111218590.10684-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


minor patch against BK-curr attached, forgot to remove an unused label in
the deadlock fix patch.

	Ingo

--- linux/kernel/exit.c.orig	Wed Sep 11 12:19:09 2002
+++ linux/kernel/exit.c	Wed Sep 11 12:19:16 2002
@@ -567,7 +567,6 @@
 	if (current->exit_signal != -1)
 		do_notify_parent(current, current->exit_signal);
 
-zap_again:
 	while (!list_empty(&current->children))
 		zap_thread(list_entry(current->children.next,struct task_struct,sibling), current, 0);
 	while (!list_empty(&current->ptrace_children))

