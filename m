Return-Path: <linux-kernel-owner+w=401wt.eu-S932078AbWLNIsw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932078AbWLNIsw (ORCPT <rfc822;w@1wt.eu>);
	Thu, 14 Dec 2006 03:48:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932082AbWLNIsw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Dec 2006 03:48:52 -0500
Received: from ns2.suse.de ([195.135.220.15]:33470 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932078AbWLNIsw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Dec 2006 03:48:52 -0500
Date: Thu, 14 Dec 2006 00:48:20 -0800
From: Greg KH <gregkh@suse.de>
To: Jonathan Corbet <corbet@lwn.net>, Andrew Morton <akpm@osdl.org>,
       Martin Bligh <mbligh@mbligh.org>,
       "Michael K. Edwards" <medwards.linux@gmail.com>,
       Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: GPL only modules [was Re: [GIT PATCH] more Driver core patches for 2.6.19]
Message-ID: <20061214084820.GA29311@suse.de>
References: <20061214003246.GA12162@suse.de> <22299.1166057009@lwn.net> <20061214005532.GA12790@suse.de> <20061214051015.GA3506@nostromo.devel.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061214051015.GA3506@nostromo.devel.redhat.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 14, 2006 at 12:10:15AM -0500, Bill Nottingham wrote:
> 
> Greg KH (gregkh@suse.de) said: 
> > An updated version is below.
> 
> If you're adding this, you should probably schedule EXPORT_SYMBOL_GPL
> for removal at the same time, as this essentially renders that irrelevant.
> 
> That being said...
> 
> First, this is adding the measure at module load time. Any copyright
> infringment happens on distribution; module load isn't (necessarily)
> that; if I write random code and load it, without ever sending it
> to anyone, I'm not violating the license, and this would prevent that.
> So it seems somewhat misplaced.

Yes, as Linus points out, this is the main point here, my apologies.
GPL covers distribution, not usage, no matter how much the people
working on v3 want to change that :)

Even if we change the kernel this way, it prevents valid and legal
usages of the kernel.  So I am wrong, sorry.

> Secondly...
> 
> > Oh, and for those who have asked me how we would enforce this after this
> > date if this decision is made, I'd like to go on record that I will be
> > glad to take whatever legal means necessary to stop people from
> > violating this.
> 
> There's nothing stopping you undertaking these means now. Addition of
> this measure doesn't change the copyright status of any code - what was
> a violation before would still be a violation.

Agreed, and I have done this in the past.  I only stated this because it
seems that some people keep just wishing this whole issue would go away
if they ignore it.

> Hence, the only purpose of a clause like this legally would seem to be
> to *intentionally* go after people using the DMCA. Which seems... tacky.

Despite my wardrobe consisting mainly of old t-shirts and jeans, I still
never want to be called tacky :)

It's just that I'm so damn tired of this whole thing.  I'm tired of
people thinking they have a right to violate my copyright all the time.
I'm tired of people and companies somehow treating our license in ways
that are blatantly wrong and feeling fine about it.  Because we are a
loose band of a lot of individuals, and not a company or legal entity,
it seems to give companies the chutzpah to feel that they can get away
with violating our license.

So when someone like Andrew gives me the opportunity to put a stop to
all of the crap that I have to put up with each and every day with a
tiny 2 line patch, I jumped in and took it.  I need to sit back and
remember to see the bigger picture some times, so I apologize to
everyone here.

And yes, it is crap that I deal with every day due to the lovely grey
area that is Linux kernel module licensing these days.  I have customers
that demand we support them despite them mixing three and more different
closed source kernel modules at once and getting upset that I have no
way to help them out.  I have loony video tweakers that hand edit kernel
oopses to try to hide the fact that they are using a binary module
bigger than the sum of the whole kernel and demand that our group fix
their suspend/resume issue for them.  I see executives who say one thing
to the community and then turn around and overrule them just because
someone made a horrible purchasing decision on the brand of laptop wifi
card that they purchased.  I see lawyers who have their hands tied by
attorney-client rules and can not speak out in public for how they
really feel about licenses and how to interpret them.

And in the midst of all of that are the poor users who have no idea who
to listen to.  They don't know what is going on, they "just want to use
their hardware" and don't give a damm about anyone's license.  And then
there's the distros out there that listen to those users and give them
the working distro as they see a market for it, and again, as a company,
justify to themselves that it must be ok to violate those kernel
developers rights because no one seems to be stopping them so far.

[side diversion, it's not the video drivers that really matter here
everyone, those are just so obvious.  It's the hundreds of other
blatantly infringing binary kernel modules out there that really matter.
The ones that control filesystems, cluster interconnects, disk arrays,
media codecs, and a whole host of custom hardware.  That's the real
problem that Linux faces now and will only get worse in the future.
It's not two stupid little video drivers, I could honestly care less
about them...]

But it's all part of the process, and I can live with it, even if at
times it drives me crazy.

But I know we will succeed, it will just take us a little longer to get
there, so I might as well learn to enjoy the view more.

Even though I really think I can get that patch by the Novell lawyers
and convince management there that it is something we can do, it's not
something that I want to take on, as I think my time can be better spent
coding to advance Linux technically, not fight legal battles.

I'll go delete that module.c patch from my tree now.

thanks,

greg k-h

p.s. I still think the UIO interface is a valid and good one.  And yes,
it might cause people to move stuff to userspace that they really should
not be just to get around the GPL issues.  But like loots of tools, it
can be used in good and bad ways, we shouldn't prevent the good usages
of it.  I'll work to get more real examples using it before
resubmitting.
