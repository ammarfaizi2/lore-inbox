Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290653AbSAYMas>; Fri, 25 Jan 2002 07:30:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290655AbSAYMaX>; Fri, 25 Jan 2002 07:30:23 -0500
Received: from mx2.elte.hu ([157.181.151.9]:39833 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S290651AbSAYM24>;
	Fri, 25 Jan 2002 07:28:56 -0500
Date: Fri, 25 Jan 2002 15:26:28 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: [patch] [sched] compiler warning fix, 2.5.3-pre3
Message-ID: <Pine.LNX.4.33.0201251525130.7457-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


the attached fix from Rusty Russell adds a semicolon, to avoid the
"deprecated use of label at end of compound statement" warning of certain
gcc versions.

	Ingo

--- linux/kernel/sched.c.orig	Fri Jan 25 10:44:18 2002
+++ linux/kernel/sched.c	Fri Jan 25 12:06:36 2002
@@ -597,6 +628,7 @@
 	default:
 		deactivate_task(prev, rq);
 	case TASK_RUNNING:
+		;
 	}
 pick_next_task:
 	if (unlikely(!rq->nr_running)) {

