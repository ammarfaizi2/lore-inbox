Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318973AbSHSSbJ>; Mon, 19 Aug 2002 14:31:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318974AbSHSSbJ>; Mon, 19 Aug 2002 14:31:09 -0400
Received: from mx1.elte.hu ([157.181.1.137]:3773 "HELO mx1.elte.hu")
	by vger.kernel.org with SMTP id <S318973AbSHSSbJ>;
	Mon, 19 Aug 2002 14:31:09 -0400
Date: Mon, 19 Aug 2002 20:36:24 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Dave McCracken <dmccr@us.ibm.com>
Cc: Linus Torvalds <torvalds@transmeta.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [patch] O(1) sys_exit(), threading, scalable-exit-2.5.31-A6
In-Reply-To: <61100000.1029781898@baldur.austin.ibm.com>
Message-ID: <Pine.LNX.4.44.0208192034260.30906-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 19 Aug 2002, Dave McCracken wrote:

> It seems to me it would be worth adding list_heads in the task struct
> for ptraced tasks and ptraced siblings if it gets rid of the
> reparenting.

well, this means that we'd still have to iterate through both lists in
wait4(), and we'd have to maintain the ptrace list(s) in all the relevant
codepaths - does this buy us anything relative to -B4?

	Ingo

