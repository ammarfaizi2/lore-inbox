Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262502AbTCZVEJ>; Wed, 26 Mar 2003 16:04:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262495AbTCZVEJ>; Wed, 26 Mar 2003 16:04:09 -0500
Received: from havoc.daloft.com ([64.213.145.173]:9707 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id <S262502AbTCZVEC>;
	Wed, 26 Mar 2003 16:04:02 -0500
Date: Wed, 26 Mar 2003 16:15:08 -0500
From: Jeff Garzik <jgarzik@pobox.com>
To: linux-kernel@vger.kernel.org
Subject: Re: BK-kernel-tools/shortlog update
Message-ID: <20030326211508.GD16662@gtf.org>
References: <20030326103036.064147C8DD@merlin.emma.line.org> <Pine.LNX.4.44.0303260917320.15530-100000@home.transmeta.com> <20030326201031.GA29746@merlin.emma.line.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030326201031.GA29746@merlin.emma.line.org>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 26, 2003 at 09:10:31PM +0100, Matthias Andree wrote:
> On Wed, 26 Mar 2003, Linus Torvalds wrote:
> 
> > Btw, one feature I'd like to see in shortlog is the ability to use 
> > regexps for email address matching, ie something like
> > 
> > 	'torvalds@.*transmeta.com' => 'Linus Torvalds'
> > 	... 
> > 	'alan@.*swansea.linux.org.uk' => 'Alan Cox'
> > 	...
> > 	'bcrl@redhat.com' => 'Benjamin LaHaise',
> > 	'bcrl@.*' => '?? Benjamin LaHaise',
> > 	..
> > 
> > I don't know whether you can force perl to do something like this, but if 
> > somebody were to try...

Perl is very regex-friendly.  Sure it can do this :)


> I'd like to keep the hash for all those addresses that aren't wildcards
> and that aren't regexps -- we have fast, that is O(1) to O(log n),
> access to the hash (depending on Perl's implementation) and we have
> worse than O(n) for regexp, where n is the count of address strings or
> regexps.
> 
> Would you agree to a version that has a set of fixed addresses and a
> separate list of regexps, tries the hash first and then a list of
> regexps?  That sounds like a) easy addition, b) good performance to me
> (before implementing it). If so, I could add some code for that feature.

Do we really care about performance here?

I think maintain-ability is probably more important.

In any case, splitting the lists into "fixed" and "regex" doesn't seem
like a bad idea, provided that the change was fairly easy and
self-contained.

	Jeff



