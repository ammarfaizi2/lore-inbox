Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262578AbTCMVw3>; Thu, 13 Mar 2003 16:52:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262581AbTCMVw3>; Thu, 13 Mar 2003 16:52:29 -0500
Received: from inti.inf.utfsm.cl ([200.1.21.155]:37548 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id <S262578AbTCMVwW>;
	Thu, 13 Mar 2003 16:52:22 -0500
Message-Id: <200303132100.h2DL00ix005791@eeyore.valparaiso.cl>
To: Larry McVoy <lm@bitmover.com>
cc: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>,
       linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] BK->CVS (real time mirror) 
In-Reply-To: Your message of "Wed, 12 Mar 2003 14:01:56 PST."
             <20030312220156.GE30788@work.bitmover.com> 
Date: Thu, 13 Mar 2003 17:00:00 -0400
From: Horst von Brand <vonbrand@inf.utfsm.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Larry McVoy <lm@bitmover.com> said:
> On Wed, Mar 12, 2003 at 03:45:39PM -0600, Kai Germaschewski wrote:
> > On Wed, 12 Mar 2003, Larry McVoy wrote:
> > > > Larry, this brings up something I was meaning to ask you before this
> > > > thread exploded.  What happens to those "logical change" numbers over
> > > > time?
> > > 
> > > They are stable in the CVS tree because the CVS tree isn't distributed.
> > > So "Logical change 1.900" in the context of the exported CVS tree is 
> > > always the same thing.  That's one advantage centralized has, things
> > > don't shift around on you.
> > 
> > Isn't there a more general problem, though? (I hope I'm wrong)
> > 
> > You want to update the CVS tree near-realtime. However, the longest-path
> > through your graph may change with new merges, but CVS of course cannot
> > cope with already committed data changing (already committed csets may 
> > all of a sudden not be in the longest path anymore)? This is a CVS 
> > limitation, of course, but still a problem AFAICS.
> 
> Yup, you're right, there is a tradeoff between real time updates and 
> best path.  We've already seen it in incremental updates.
> 
> We were talking about this internally when your mail came in.  I suspect
> it isn't really a problem in practice because we can always redo the
> entire export from scratch and get an optimal path.

Then the CVS tree won't be stable, and so useless to remote people just
wanting to "cvs update" their stuff. Or am I missing something here?

> Wayne pointed out that in the cases where it collapses a pile of csets
> that is usually because Linus pulled some wad from somebody and one could
> argue the collapse is a good thing.  But it depends, sometimes it is and
> sometimes it isn't.  Our commercial users have frequently asked for a
> way to "collapse the tree and clean up the noise in the graphs", in fact,
> one called this morning and said "that BK to CVS thing, could that be a BK
> to cleaner-BK thing?" so opinions vary on what is the perfect
> granularity.

I'd add the possibility to group csets into super-csets (and so on, why
not?), without ever losing the individual pieces. Masoch^Wadventurous folks
could then grovel around inside as needed. Linus' 2.5.63 --> 2.5.64 would
then just be such a super-cset, separately manipulable.

No, I have no clue of how to do this.
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
