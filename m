Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261254AbVDICJK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261254AbVDICJK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Apr 2005 22:09:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261258AbVDICJK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Apr 2005 22:09:10 -0400
Received: from mail.dif.dk ([193.138.115.101]:44177 "EHLO saerimmer.dif.dk")
	by vger.kernel.org with ESMTP id S261254AbVDICJD convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Apr 2005 22:09:03 -0400
Date: Sat, 9 Apr 2005 04:11:37 +0200 (CEST)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
Cc: Roland Dreier <roland@topspin.com>, Paulo Marques <pmarques@grupopie.com>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: RFC: turn kmalloc+memset(,0,) into kcalloc
In-Reply-To: <20050406112837.GC7031@wohnheim.fh-wedel.de>
Message-ID: <Pine.LNX.4.62.0504090409520.2455@dragon.hyggekrogen.localhost>
References: <4252BC37.8030306@grupopie.com>
 <Pine.LNX.4.62.0504052052230.2444@dragon.hyggekrogen.localhost>
 <521x9pc9o6.fsf@topspin.com> <Pine.LNX.4.62.0504052148480.2444@dragon.hyggekrogen.localhost>
 <20050406112837.GC7031@wohnheim.fh-wedel.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 6 Apr 2005, Jörn Engel wrote:

> On Tue, 5 April 2005 22:01:49 +0200, Jesper Juhl wrote:
> > On Tue, 5 Apr 2005, Roland Dreier wrote:
> > 
> > >     > or simply
> > >     > 	if (!(ptr = kcalloc(n, size, ...)))
> > >     > 		goto out;
> > >     > and save an additional line of screen realestate while you are at it...
> > > 
> > > No, please don't do that.  The general kernel style is to avoid
> > > assignments within conditionals.
> > > 
> > It may be the prefered style to avoid assignments in conditionals, but in 
> > that case we have a lot of cleanup to do. What I wrote above is quite 
> > common in the current tree - a simple  egrep -r "if\ *\(\!\(.+=" *  in 
> > 2.6.12-rc2-mm1 will find you somewhere between 1000 and 2000 cases 
> > scattered all over the tree.
> > 
> > Personally I don't see why thy should not be used. They are short, not any 
> > harder to read (IMHO), save screen space & are quite common in userspace 
> > code as well (so people should be used to seeing them).
> > 
> > If such statements are generally frawned upon then I'd suggest an addition 
> > be made to Documentation/CodingStyle mentioning that fact, and I wonder if 
> > patches to clean up current users would be welcome?
> 
> I _do_ change them whenever they occur in code I maintain.  And each
> time, it is an improvement.
> 
> o Functional code always has the same indentation.  I can mentally
>   ignore the error path by ignoring all indented code.  Getting a
>   quick overview is quite nice.
> 
> o Rather often, your preferred variant violates the 80 columns rule.
>   If I need the line break anyway,...
> 
> o Keeping condition and functional code seperate avoids the Lisp-style
>   bracket maze.  Some editors can help you here, but not needing any
>   help would be even better, no?
> 
Ok, I accept those arguments, they make sense. I may still have a personal 
preference that differ slightly, but I see your point(s).

-- 
Jesper

