Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263512AbSIQC6e>; Mon, 16 Sep 2002 22:58:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263524AbSIQC6d>; Mon, 16 Sep 2002 22:58:33 -0400
Received: from mx2.elte.hu ([157.181.151.9]:19933 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S263512AbSIQC6d>;
	Mon, 16 Sep 2002 22:58:33 -0400
Date: Tue, 17 Sep 2002 05:10:16 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Jamie Lokier <lk@tantalophile.demon.co.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Question about CLONE_CLEARTID and thread group leader
In-Reply-To: <20020917034625.A22892@kushida.apsleyroad.org>
Message-ID: <Pine.LNX.4.44.0209170457530.2299-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 17 Sep 2002, Jamie Lokier wrote:

> One question has been bothering me for a while: what about the thread
> group leader's stack?  These days, isn't it the case that the group
> leader is supposed to be equivalent to the other threads?  If so, how
> does it exit and release its own stack -- or do we understand that the
> group leader, as a one-off exception, has to block signals before
> exiting?

good question. We might need a new mechanism (new syscall) for a thread to
set its own ->user_tid after it has started up. I'll code it up. The
fastest thread-startup method is still to also have this mechanism
provided by clone() as well - but oviously at exec() time we cannot know
about such issues.

	Ingo

