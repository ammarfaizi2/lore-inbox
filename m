Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268523AbTBWSjn>; Sun, 23 Feb 2003 13:39:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268524AbTBWSjn>; Sun, 23 Feb 2003 13:39:43 -0500
Received: from mx1.elte.hu ([157.181.1.137]:6851 "HELO mx1.elte.hu")
	by vger.kernel.org with SMTP id <S268523AbTBWSjm>;
	Sun, 23 Feb 2003 13:39:42 -0500
Date: Sun, 23 Feb 2003 19:49:41 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: procps-list@redhat.com
Cc: Linus Torvalds <torvalds@transmeta.com>, <linux-kernel@vger.kernel.org>,
       Alex Larsson <alexl@redhat.com>, Alexander Viro <viro@math.psu.edu>
Subject: Re: [patch] procfs/procps threading performance speedup, 2.5.62
In-Reply-To: <1045947170.19445.57.camel@cube>
Message-ID: <Pine.LNX.4.44.0302231935350.6674-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 22 Feb 2003, Albert Cahalan wrote:

> > architecture-wise there is a difference, and i'd be
> > the last one arguing against a tree-based approach to
> > thread groups. It's much easier to find threads belonging
> > to a single 'process' via /proc this way - although no
> > functionality in procps has or requires such a feature currently.
> 
> Nope, the /proc/123/threads/246/stat approach is required. Without this,
> procps is forced to read _all_ tasks to group threads together. This is
> slow, prone to race conditions, more vulnerable to kernel bugs, and a
> memory hog.

actually, what you mention does not happen in practice. We coded it up and
it works, and with tons of threads around it performs a few orders of
magnitudes faster than any other stuff available so far. So the question
here is 'only' interface/approach cleanliness, not actual performance
difference. Sure, we could shave off another millisec or two, but the
performance problems are off the radar already.

> Note that the recent /proc/*/wchan addition was botched.

(fyi, i have nothing to do with that change, so spare your insults for
someone else.)

> (next time, discuss such changes with an experienced procps developer
> first)

(given that this whole area was left alone in a state like this for years
i'm not quite sure how you can still sit so high on your horse.)

	Ingo

