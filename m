Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262116AbSIYUXf>; Wed, 25 Sep 2002 16:23:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262117AbSIYUXf>; Wed, 25 Sep 2002 16:23:35 -0400
Received: from 2-225.ctame701-1.telepar.net.br ([200.193.160.225]:45461 "EHLO
	2-225.ctame701-1.telepar.net.br") by vger.kernel.org with ESMTP
	id <S262116AbSIYUXe>; Wed, 25 Sep 2002 16:23:34 -0400
Date: Wed, 25 Sep 2002 17:28:24 -0300 (BRT)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@imladris.surriel.com
To: Daniel Jacobowitz <dan@debian.org>
cc: Ingo Molnar <mingo@elte.hu>, Linus Torvalds <torvalds@transmeta.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [patch] exit-fix-2.5.38-E3
In-Reply-To: <20020925201338.GA32366@nevyn.them.org>
Message-ID: <Pine.LNX.4.44L.0209251727380.22735-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 25 Sep 2002, Daniel Jacobowitz wrote:
> On Wed, Sep 25, 2002 at 09:20:01PM +0200, Ingo Molnar wrote:
> > @@ -57,31 +58,31 @@
> >  void release_task(struct task_struct * p)
> >  {
> >  	struct dentry *proc_dentry;
> > +	task_t *leader;
> >
> > -	if (p->state != TASK_ZOMBIE)
> > +	if (p->state < TASK_ZOMBIE)
>
> Could you check TASK_ZOMBIE and TASK_DEAD explicitly, or add a comment
> in sched.h saying that only DEAD should be above ZOMBIE?  Otherwise, if
> someone needs a new task state, this'll get out of sync.

A comment would be nice indeed.

I still have plans and (outdated) code for TASK_SWAPPED, since
I want Linux to be able to handle load spikes instead of spiralling
down thrashing ;)

cheers,

Rik
-- 
Bravely reimplemented by the knights who say "NIH".

http://www.surriel.com/		http://distro.conectiva.com/

Spamtraps of the month:  september@surriel.com trac@trac.org

