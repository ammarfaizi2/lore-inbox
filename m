Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289353AbSAOBwz>; Mon, 14 Jan 2002 20:52:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289355AbSAOBwp>; Mon, 14 Jan 2002 20:52:45 -0500
Received: from x35.xmailserver.org ([208.129.208.51]:9733 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP
	id <S289353AbSAOBwl>; Mon, 14 Jan 2002 20:52:41 -0500
X-AuthUser: davidel@xmailserver.org
Date: Mon, 14 Jan 2002 17:58:33 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: Ed Tomlinson <tomlins@cam.org>
cc: Ingo Molnar <mingo@elte.hu>, lkml <linux-kernel@vger.kernel.org>,
        Dave Jones <davej@suse.de>
Subject: Re: [patch] O(1) scheduler-H6/H7 and nice +19
In-Reply-To: <Pine.LNX.4.40.0201141748570.1233-100000@blue1.dev.mcafeelabs.com>
Message-ID: <Pine.LNX.4.40.0201141754230.1233-100000@blue1.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 14 Jan 2002, Davide Libenzi wrote:

On Mon, 14 Jan 2002, Ed Tomlinson wrote:

> On January 13, 2002 10:45 pm, Davide Libenzi wrote:
> > On Sun, 13 Jan 2002, Ed Tomlinson wrote:
> > > With pre3+H7, kernel compiles still take 40% longer with a setiathome
> > > process running at nice +19.  This is _not_ the case with the old
> > > scheduler.
> >
> > Did you try to set MIN_TIMESLICE to 10 ( sched.h ) ?make bzImage with setiathome running nice +19
>
> This makes things a worst - note the decreased cpu utilizaton...
>
> make bzImage  424.33s user 32.21s system 48% cpu 15:48.69 total
>
> What is this telling us?

I got it, the new scheduler assign time slices depending on priority.
Maybe Ingo it's better to assign them depending on nice since we already
have different time slices based on priority ( interactive handling in
expire_task() ).




- Davide


