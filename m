Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288205AbSATLSo>; Sun, 20 Jan 2002 06:18:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288238AbSATLSe>; Sun, 20 Jan 2002 06:18:34 -0500
Received: from mx2.elte.hu ([157.181.151.9]:27312 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S288205AbSATLSV>;
	Sun, 20 Jan 2002 06:18:21 -0500
Date: Sun, 20 Jan 2002 14:15:47 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: [sched] [patch] activate-task-speedup-2.5.3-pre2-A0
Message-ID: <Pine.LNX.4.33.0201201414080.7972-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


the attached patch against 2.5.3-pre2 is an optimization of
activate_task(), to not call effective_prio() if no jiffy passed since
->sleep_timestamp was updated. This optimizes high-frequency wakeups.

	Ingo

