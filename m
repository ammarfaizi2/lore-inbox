Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262385AbTCIDeL>; Sat, 8 Mar 2003 22:34:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262387AbTCIDeL>; Sat, 8 Mar 2003 22:34:11 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:4625 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S262385AbTCIDeK>; Sat, 8 Mar 2003 22:34:10 -0500
Date: Sat, 8 Mar 2003 19:42:24 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Roman Zippel <zippel@linux-m68k.org>
cc: Zack Brown <zbrown@tumblerings.org>, Larry McVoy <lm@work.bitmover.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: BitBucket: GPL-ed KitBeeper clone
In-Reply-To: <Pine.LNX.4.44.0303090401160.32518-100000@serv>
Message-ID: <Pine.LNX.4.44.0303081936400.27974-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 9 Mar 2003, Roman Zippel wrote:
> On Sat, 8 Mar 2003, Zack Brown wrote:
> 
> >   * Distributed rename handling.
> 
> This actually a very bk specific problem, because the real problem under 
> bk there can be only one src/SCCS/s.foo.c.

I don't think that is the issue.

[ Well, yes, I agree that the SCCS format is bad, but for other reasons ]

> A separate repository doesn't have this problem

You're wrong.

The problem is _distribution_. In other words, two people rename the same 
file. Or two people rename two _different_ files to the same name. Or two 
people create two different files with the same name. What happens when 
you merge?

None of these are issues for broken systems like CVS or SVN, since they 
have a central repository, so there _cannot_ be multiple concurrent 
renames that have to be merged much later (well, CVS cannot handle renames 
at all, but the "same name creation" issue you can see even with CVS). 

With a central repostory, you avoid a lot of the problems, because the 
conflicts must have been resolved _before_ the commit ever happens - put 
another way, you can never have a conflict in the revision history.

Sepoarate repostitories and SCCS file formats have nothing to do with the 
real problem. Distribution is key, not the repository format.

		Linus

