Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262585AbTCZVWf>; Wed, 26 Mar 2003 16:22:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262587AbTCZVWf>; Wed, 26 Mar 2003 16:22:35 -0500
Received: from twinlark.arctic.org ([208.44.199.239]:53668 "EHLO
	twinlark.arctic.org") by vger.kernel.org with ESMTP
	id <S262585AbTCZVWd>; Wed, 26 Mar 2003 16:22:33 -0500
Date: Wed, 26 Mar 2003 13:33:45 -0800 (PST)
From: Jauder Ho <jauderho@carumba.com>
X-X-Sender: jauderho@twinlark.arctic.org
To: Jeff Garzik <jgarzik@pobox.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: BK-kernel-tools/shortlog update
In-Reply-To: <20030326211508.GD16662@gtf.org>
Message-ID: <Pine.LNX.4.50.0303261331540.1391-100000@twinlark.arctic.org>
References: <20030326103036.064147C8DD@merlin.emma.line.org>
 <Pine.LNX.4.44.0303260917320.15530-100000@home.transmeta.com>
 <20030326201031.GA29746@merlin.emma.line.org> <20030326211508.GD16662@gtf.org>
X-Mailer: UW Pine 4.44 + a bunch of schtuff
X-There-Is-No-Hidden-Message-In-This-Email: There are no tyops either
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


one suggestion I would make would be to break out the regex into a
seperate file, that way you will no longer need to touch the script once
the core logic is correct.

got this working nicely to count users based upon patterns.

--jauder

On Wed, 26 Mar 2003, Jeff Garzik wrote:

> On Wed, Mar 26, 2003 at 09:10:31PM +0100, Matthias Andree wrote:
> > On Wed, 26 Mar 2003, Linus Torvalds wrote:
> >
> > > Btw, one feature I'd like to see in shortlog is the ability to use
> > > regexps for email address matching, ie something like
> > >
> > > 	'torvalds@.*transmeta.com' => 'Linus Torvalds'
> > > 	...
> > > 	'alan@.*swansea.linux.org.uk' => 'Alan Cox'
> > > 	...
> > > 	'bcrl@redhat.com' => 'Benjamin LaHaise',
> > > 	'bcrl@.*' => '?? Benjamin LaHaise',
> > > 	..
> > >
> > > I don't know whether you can force perl to do something like this, but if
> > > somebody were to try...
>
> Perl is very regex-friendly.  Sure it can do this :)
>
>
> > I'd like to keep the hash for all those addresses that aren't wildcards
> > and that aren't regexps -- we have fast, that is O(1) to O(log n),
> > access to the hash (depending on Perl's implementation) and we have
> > worse than O(n) for regexp, where n is the count of address strings or
> > regexps.
> >
> > Would you agree to a version that has a set of fixed addresses and a
> > separate list of regexps, tries the hash first and then a list of
> > regexps?  That sounds like a) easy addition, b) good performance to me
> > (before implementing it). If so, I could add some code for that feature.
>
> Do we really care about performance here?
>
> I think maintain-ability is probably more important.
>
> In any case, splitting the lists into "fixed" and "regex" doesn't seem
> like a bad idea, provided that the change was fairly easy and
> self-contained.
>
> 	Jeff
>
>
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
>
