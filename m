Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S137185AbRA1OrO>; Sun, 28 Jan 2001 09:47:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S137199AbRA1OrE>; Sun, 28 Jan 2001 09:47:04 -0500
Received: from yoda.planetinternet.be ([195.95.30.146]:16655 "EHLO
	yoda.planetinternet.be") by vger.kernel.org with ESMTP
	id <S137185AbRA1Oqp>; Sun, 28 Jan 2001 09:46:45 -0500
Date: Sun, 28 Jan 2001 15:46:38 +0100
From: Kurt Roeckx <Q@ping.be>
To: linux-kernel@vger.kernel.org
Subject: setitimer() and fork()
Message-ID: <20010128154637.A3193@ping.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0pre2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm having a problem when I try to profile a program that
fork()'s. The problem is that it does count how many times I'm in
a function, but nothing seems to use any cpu time at all.

If I call setitmer(ITIMER_PROF, ...) again after the
fork, it works as expected.  fork() doesn't seem to copy the
timer(s). On other OS's, I don't seem to have to do this.

I'm having this problem with both 2.2, and 2.4.  I think it used
to work in older versions.

Is this a bug, or is this intentional?


Kurt

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
