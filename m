Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131399AbRAWABc>; Mon, 22 Jan 2001 19:01:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130238AbRAWABY>; Mon, 22 Jan 2001 19:01:24 -0500
Received: from sdsl-208-184-147-195.dsl.sjc.megapath.net ([208.184.147.195]:21825
	"EHLO bitmover.com") by vger.kernel.org with ESMTP
	id <S131399AbRAWABM>; Mon, 22 Jan 2001 19:01:12 -0500
Date: Mon, 22 Jan 2001 16:01:10 -0800
From: Larry McVoy <lm@bitmover.com>
To: Anton Altaparmakov <aia21@cam.ac.uk>
Cc: Mark I Manning IV <mark4@purplecoder.com>,
        Stephen Satchell <satch@fluent-access.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [OT?] Coding Style
Message-ID: <20010122160110.K9530@work.bitmover.com>
Mail-Followup-To: Anton Altaparmakov <aia21@cam.ac.uk>,
	Mark I Manning IV <mark4@purplecoder.com>,
	Stephen Satchell <satch@fluent-access.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <4.3.2.7.2.20010122130852.00b92a80@mail.fluent-access.com> <3A6C630E.C2CB784C@purplecoder.com> <5.0.2.1.2.20010122233742.00ae5e40@pop.cus.cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0pre3i
In-Reply-To: <5.0.2.1.2.20010122233742.00ae5e40@pop.cus.cam.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 22, 2001 at 11:56:40PM +0000, Anton Altaparmakov wrote:
> At 16:42 22/01/2001, Mark I Manning IV wrote:
> >Stephen Satchell wrote:
> > >                                              I got in the habit of using
> > >  structures to minimize the number of symbols I exposed. It also
> > > disambiguates local variables and parameters from file- and program-global
> > > variables.
> >
> >explain this one to me, i think it might be usefull...
> 
> What might be meant is that instead of declaring variables my_module_var1, 
> my_module_var2, my_module_var3, etc. you declare a struct my_module { var1; 
> var2; var3; etc. }. Obviously in glorious technicolour formatting... (-;
> That's my interpretation anyway...

Mine too and I think it's a good idea.  I have code in BitKeeper where I
both did and did not do that for command line options and I much prefer
the structure version.

Another habit I used to use and have fallen out of, which is a bad idea, is
one where you use a prefix in stucture files so that you can see
the difference between

	p->st_mode
and
	p->f_mode

In other words, the prefix implies the structure name.  Early versions of the
C compiler had all structure fields (I mean _all_) in one name space so this
wasn't style, it was required.  I must say that it makes code more readable.
-- 
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm 
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
