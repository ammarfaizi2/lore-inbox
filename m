Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268682AbUH3S14@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268682AbUH3S14 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Aug 2004 14:27:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268894AbUH3S0m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Aug 2004 14:26:42 -0400
Received: from h001061b078fa.ne.client2.attbi.com ([24.91.86.110]:17038 "EHLO
	linuxfarms.com") by vger.kernel.org with ESMTP id S268786AbUH3SMy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Aug 2004 14:12:54 -0400
Date: Mon, 30 Aug 2004 14:13:45 -0400 (EDT)
From: Arthur Perry <kernel@linuxfarms.com>
X-X-Sender: kernel@tiamat.perryconsulting.net
To: "Richard B. Johnson" <root@chaos.analogic.com>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Celistica with AMD chip-set
In-Reply-To: <Pine.LNX.4.53.0408301306020.22149@chaos>
Message-ID: <Pine.LNX.4.58.0408301351530.23343@tiamat.perryconsulting.net>
References: <Pine.LNX.4.53.0408300955470.21607@chaos>
 <1093871709.30082.11.camel@localhost.localdomain>
 <Pine.LNX.4.58.0408301052030.23343@tiamat.perryconsulting.net>
 <Pine.LNX.4.53.0408301306020.22149@chaos>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Richard,

Look, I think you are taking this the wrong way.
I am not trying to banter you, I was just advising caution in
the manner which this "fix" was being implemented.
Perhaps I did not understand exactly how you were trying to implement it.

I apologise if I had belittled you in any way, as this was not my
intention. I know I sound somewhat caustic at times, but that is just my
writing style. I am not out to publicly humiliate you.
I do think however, that your response was rather unprofessional.

My argument was simply that I don't believe that we should have the kernel
set this prefetch register up, just because it is an 8131, or just because
it is a "Celestica" server.
Just because it works better for your card, does not mean it won't have
any kind of performance hit for other people's cards.
What would you do if this change was put into the kernel, assuming this
should be set, then down the line someone discovers that they have to set
it the other way to negate your change. I would think that would be rather
embarrasing.

I am just trying to take the more conservative approach and with testing,
determine if this is indeed the correct fix.

In the meantime, a simple 5-10 line shell script launched at boot time
could even provide the immediate "fix" that everyone is looking for.

And I do think you took that email from Celestica too personally.
I believe the intention of getting the source code was not to see if you
screwed up, but rather get the source needed to compile for different
platforms. I think we were only supplied with a 32 bit Fedora OS
from you guys, and whatever came on it, to test with.

Now if you don't mind, I think it would be in both of our best interest to
take the rest of this offline, seeing that things are getting as heated,
and there may be little value in this to the rest of the Linux
community at this phase.


Thanks.

Best Regards,
Art Perry




On Mon, 30 Aug 2004, Richard B. Johnson wrote:

> On Mon, 30 Aug 2004, Arthur Perry wrote:
>
> > Hello Alan and Richard,
> >
> > I have to advise caution here, as it is currently unconfirmed whether or
> > not the PCI bridge configuration is "incorrect", and that it has "very
> > poor PCI performance".
>
> The crapiest 33MHz, 32-bit PCI/Bus in lowly '486 machines hanging
> around the lab will beat the Celistia hands-down.
>
> > Unless everyone in the whole wide world is setting this value and we are
> > the only ones who are not, I find it hard to believe that this statement
> > is not overspeculative.
> >
>
> Really?  Well somebody from Salem New Hampshire wrote email to
> one of my zillions of managers claiming that this was the "fix".
>
> I was forced to make this "fix" and it "fixed" it. Further,
> every "^!&@*$%^!_*(@" so called software, hardware, and whatever
> "Engineer......" If that's the correct word, required (demanded)
> to see the source code because they were "sure" that " had screwed
> up.
>
> To date, there has been no such finding of screw-ups on my part.
> FYI, it's really difficult to screw up a "(@#%^P_*!@&#" DMA!
>
> Other machines are able to DMA at over 130 megabytes/second. The
> boxes in question run at only 50 megabytes/second.
>
> > The proper place for this should be in the BIOS, if it is indeed a true
> > optimization point.
> > But until that is positively identified, we should not assume that
> > applying this globally for everyone is the right thing to do.
> > As in any assumed optimization for a simgle case, it could potentially
> > cause performance degradation in somebody else's HBA.
> >
>
> Not so.
>
> > This is a cache optimization.
> >
> > Have you considered the possibility of this "optimization" causing a
> > performance hit with Mellanox's PCI implementation?
> >
>
> I published a "fix" for the abysimal PCI performance on that
> piece of crap. If you don't like it then so what. Fix the
> damn box.
>
> > What about people who have already tailored their device driver to work
> > well in on this chipset and currently use "read multiple" rather than
> > "read cacheline". This optimization could potentially cause a slight
> > degradation of performance for them.
> >
>
> I don't give a damn.  The box has no DMA capability as it is.
> One might as well just use a wet string top communicate with
> the PCI boards. The "fix" forced upon me by you guys is now
> somehow incorrect?
>
> Go to hell.
>
> >
> > Arthur Perry
> > Linux Systems/Software Architect
> > Lead Linux Engineer
> > CSU Validation Group
> > Celestica, Salem, NH
> > aperry@celestica.com
> >
>
>
> Cheers,
> Dick Johnson
> Penguin : Linux version 2.4.26 on an i686 machine (5570.56 BogoMips).
>             Note 96.31% of all statistics are fiction.
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>


