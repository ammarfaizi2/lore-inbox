Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261397AbSIPLiX>; Mon, 16 Sep 2002 07:38:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261399AbSIPLiX>; Mon, 16 Sep 2002 07:38:23 -0400
Received: from mx2.elte.hu ([157.181.151.9]:65417 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S261397AbSIPLiS>;
	Mon, 16 Sep 2002 07:38:18 -0400
Date: Mon, 16 Sep 2002 13:50:12 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Cc: Linus Torvalds <torvalds@transmeta.com>, <linux-kernel@vger.kernel.org>,
       Daniel Jacobowitz <drow@false.org>
Subject: Re: [PATCH] Fix for ptrace breakage
In-Reply-To: <87bs6y6u25.fsf@devron.myhome.or.jp>
Message-ID: <Pine.LNX.4.44.0209161349270.29027-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 16 Sep 2002, OGAWA Hirofumi wrote:

> 	list_for_each(_p, &father->ptrace_children) {
> 		p = list_entry(_p,struct task_struct,ptrace_list);
> 		list_del_init(&p->ptrace_list);
> 		reparent_thread(p, reaper, child_reaper);
> 		if (p->parent != p->real_parent)
> 			list_add(&p->ptrace_list, &p->real_parent->ptrace_children);
> 	}
> 
> current->ptrace_children should be empty after this reparent.

oh, okay. It's also cleaner this way.

	Ingo

