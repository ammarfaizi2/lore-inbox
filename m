Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318919AbSIITIy>; Mon, 9 Sep 2002 15:08:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318920AbSIITIy>; Mon, 9 Sep 2002 15:08:54 -0400
Received: from mx2.elte.hu ([157.181.151.9]:34196 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S318919AbSIITIy>;
	Mon, 9 Sep 2002 15:08:54 -0400
Date: Mon, 9 Sep 2002 21:18:07 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: do_syslog/__down_trylock lockup in current BK
In-Reply-To: <Pine.LNX.4.44.0209092104450.1338-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.44.0209092117490.4363-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


it's locking up here:

416             struct task_struct *p, *reaper = father;
417             struct list_head *_p;
418
419             write_lock_irq(&tasklist_lock);
420
421             if (father->exit_signal != -1)
422                     reaper = prev_thread(reaper);

(unfortunately i dont know what happened on the other CPU.)

	Ingo

