Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262510AbTCINYb>; Sun, 9 Mar 2003 08:24:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262514AbTCINYb>; Sun, 9 Mar 2003 08:24:31 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:13866 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP
	id <S262510AbTCINY0>; Sun, 9 Mar 2003 08:24:26 -0500
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Zack Brown <zbrown@tumblerings.org>, Larry McVoy <lm@work.bitmover.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: BitBucket: GPL-ed KitBeeper clone
References: <Pine.LNX.4.44.0303081936400.27974-100000@home.transmeta.com>
	<Pine.LNX.4.44.0303090504140.32518-100000@serv>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 09 Mar 2003 06:34:30 -0700
In-Reply-To: <Pine.LNX.4.44.0303090504140.32518-100000@serv>
Message-ID: <m14r6ck6jd.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roman Zippel <zippel@linux-m68k.org> writes:

> Hi,
> 
> On Sat, 8 Mar 2003, Linus Torvalds wrote:
> 
> > None of these are issues for broken systems like CVS or SVN, since they
> > have a central repository, so there _cannot_ be multiple concurrent
> > renames that have to be merged much later.
> 
> It is possible, you only have to remember that the file foo.c doesn't have 
> to be called foo.c,v in the repository. SVN should be able to handle this, 
> it's just lacking important merging mechanisms.
> This is actually a key feature I want to see in a SCM system - the ability 
> to keep multiple developments within the same repository. I want to pull 
> other source tress into a branch and compare them with other branches and 
> merge them into new branches.

In a distributed system everything happens on a branch.

> > Sepoarate repostitories and SCCS file formats have nothing to do with the 
> > real problem. Distribution is key, not the repository format.
> 
> I agree, what I was trying to say is that the SCCS format makes a few 
> things more complex than they had to be.

I don't know, if the problem really changes that much.  How do
you pick a globally unique inode number for a file?  And then
how do you reconcile this when people on 2 different branches create
the same file and want to merge their versions together?

So as a very rough approximation.
- Distribution is the problem.
- Powerful branching is the only thing that helps this
- Non branch local data (labels/tags) is very difficult.

Eric
