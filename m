Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318917AbSIIUxA>; Mon, 9 Sep 2002 16:53:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318901AbSIIUvm>; Mon, 9 Sep 2002 16:51:42 -0400
Received: from mx2.elte.hu ([157.181.151.9]:43676 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S318912AbSIIUvf>;
	Mon, 9 Sep 2002 16:51:35 -0400
Date: Mon, 9 Sep 2002 23:00:55 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Daniel Jacobowitz <dan@debian.org>
Cc: Linus Torvalds <torvalds@transmeta.com>, <linux-kernel@vger.kernel.org>
Subject: Re: do_syslog/__down_trylock lockup in current BK
In-Reply-To: <20020909205043.GA9099@nevyn.them.org>
Message-ID: <Pine.LNX.4.44.0209092300120.26702-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 9 Sep 2002, Daniel Jacobowitz wrote:

> When is this happening?  It's not necessarily a bug.  If the process was
> traced, then __ptrace_unlink will set p->parent = p->real_parent when it
> unlinks.

it's not traced. And if you look at the patch i've put the assert into the
!traced branch ...

	Ingo

