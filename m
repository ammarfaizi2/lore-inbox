Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319451AbSH3GmV>; Fri, 30 Aug 2002 02:42:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319453AbSH3GmU>; Fri, 30 Aug 2002 02:42:20 -0400
Received: from dp.samba.org ([66.70.73.150]:25537 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S319451AbSH3GmS>;
	Fri, 30 Aug 2002 02:42:18 -0400
Date: Fri, 30 Aug 2002 16:46:38 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: george anzinger <george@mvista.com>
Cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][2.5.32] CPU frequency and voltage scaling (0/4)
Message-ID: <20020830064638.GJ31752@zax>
Mail-Followup-To: David Gibson <david@gibson.dropbear.id.au>,
	george anzinger <george@mvista.com>,
	Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44.0208281649540.27728-100000@home.transmeta.com> <1030618420.7290.112.camel@irongate.swansea.linux.org.uk> <aklq8b$220$1@penguin.transmeta.com> <3D6E90AB.FBA3BDE6@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3D6E90AB.FBA3BDE6@mvista.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 29, 2002 at 02:22:51PM -0700, george anzinger wrote:
> Linus Torvalds wrote:
> > 
> > In article <1030618420.7290.112.camel@irongate.swansea.linux.org.uk>,
> > Alan Cox  <alan@lxorguk.ukuu.org.uk> wrote:
> > >>  { min-Hz, max-Hz, policy }
> > >>
> > >
> > >For a few of the processors "event-hz" or similar would be nice. The
> > >Geode supports hardware assisted bursting to full processor speed when
> > >doing SMM, I/O and IRQ handling.
> > 
> > Hmm.. I would assume that you'd just use the high frequency for that?
> > So, for example, assuming you have a 600/300 Geode, when you do
> > 
> >         { 0, ~0UL, "power-save" }
> > 
> > that would tell the Geode driver to run at 300MHz normally
> > ("power-save"), and at 600Mhz when doing critical events.
> > 
> > In contrast, a
> > 
> >         { 0, ~0UL, "performance" }
> > 
> > mode would mean that it always runs at 600MHz (modulo heat throttling,
> > of course).
> > 
> > And a
> > 
> >         { 300, 300, "power-save" }
> 
> How about { 50, 50, "power-save" }  where the number refers
> to percent of full?
> I.e. same meaning IFF full is 600, but suppose it is 800.

Um... how about not.  I can't think of a single situation in which
specifying this as a percentage of full speed is useful.  It's even
less useful than raw MHz.

-- 
David Gibson			| For every complex problem there is a
david@gibson.dropbear.id.au	| solution which is simple, neat and
				| wrong.
http://www.ozlabs.org/people/dgibson
