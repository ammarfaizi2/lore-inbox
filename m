Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750965AbWHIPfX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750965AbWHIPfX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Aug 2006 11:35:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751026AbWHIPfX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Aug 2006 11:35:23 -0400
Received: from smtp.enter.net ([216.193.128.24]:1039 "EHLO smtp.enter.net")
	by vger.kernel.org with ESMTP id S1750965AbWHIPfU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Aug 2006 11:35:20 -0400
From: "D. Hazelton" <dhazelton@enter.net>
To: Matti Aarnio <matti.aarnio@zmailer.org>
Subject: Re: Time to forbid non-subscribers from posting to the list?
Date: Wed, 9 Aug 2006 11:35:17 -0400
User-Agent: KMail/1.9.3
Cc: Folkert van Heusden <folkert@vanheusden.com>,
       David Schwartz <davids@webmaster.com>,
       "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>
References: <44D871DE.1040509@garzik.org> <20060809143429.GD5815@vanheusden.com> <20060809150851.GH3021@mea-ext.zmailer.org>
In-Reply-To: <20060809150851.GH3021@mea-ext.zmailer.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608091135.18386.dhazelton@enter.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 09 August 2006 11:08, Matti Aarnio wrote:
> On Wed, Aug 09, 2006 at 04:34:30PM +0200, Folkert van Heusden wrote:
> > > > The kernel developers who need to keep the barrier to bug reports low
> > > > like the current policy.
> > > > Get a good spam filter, I only get 1-2 pieces a day in my LKML
> > > > folder.
> > >
> > > 	How is everyone individually spam filtering better than one central
> > > spam filter? More likelihood that at least one relevent person will get
> > > the bug report? Certainly a single central spam filter can get more
> > > resources aimed at it to make sure it doesn't suppress anything
> > > important.
> >
> > What about just using the spamhaus.org blocklist at vger? Stops quite a
> > bit of spam over here (http://keetweej.vanheusden.com/nspam_graph.png).
>
> I have seen these lists classify major ISP relays as spam sources(*),
> even classify VGER as one.  Their maintenance standards are varying,
> some demand ridiculous things out of DNS zone SOA timers, some are
> otherwise retarded in their "we are the world police, beware or be
> sorry"..   and then they simply evaporate into the bit heaven.

Agreed fully - I've seen this many times myself.

> (*) ISP user's main relays are spam fan-out sources way more often
> than system keepers would like, but very few MTAs provide rate-limits
> for anonymous ( = "non autenticated" ) users to keep a high-jacked
> Windows machine from being effective spam-sources and utterly killing
> the ISP relay..  (See "ASTA Recommendation".)
> (Limiting spam-sending to 60 messages per hour of 240 rcpt per hour
> can still get the relay to spam lists, but it won't flood internal
> queues as badly as completely unlimited feed rates.)

Postfix and several other MTA's (most notably sendmail) come configured to act 
as totally open MTA's. Most ISP's have locked down on this, but with zombie 
machines on the networks sending mail it doesn't work all that well. Rate 
limiting per-machine outgoing mail is a solution that can keep the servers 
functional, but I have very recently seen a lot of spam in my "spambox" email 
address that has massive TO, CC and BCC lists attached to evade the rate 
limiting.

I run spambot locally and have my local server set to filter spam at the 
server level, but I still see spam coming in from my other mail accounts - 
LKML is, by far, not the source of a lot of the spam that hit's my system. 
(Actually, the source of most of the spam are the two account I have with my 
broadband provider - and they claim to have the same level of spam-filters on 
their servers that I do locally)

The recent spate of "request to join list openbsd-xxxx" I saw seems to have 
been a childish prank from some BSD zealot. (That's a personal opinion - not 
a statement of fact. I don't need a flamewar) Seeing as this thread appears 
to have begun right after the first batch of those appeared in my inbox from 
vger I'm guessing that that might have been the "SPAM" the gentleman who 
started this thread was complaining about.

> Spamhouse and Spamcop have long(er) existence compared to most
> DNS BLs, but still I am utterly worried...
> ("Many times burned, forever distrustful..")

Exactly. My memory fails me currently, but there was also a big flap over a 
national ISP blocking all incoming mail from european domains. That was the 
sort of over-reaction you often see with DNS BL's and their kin. Truthfully, 
all a piece of mailing list software really needs is a good set of filters 
that each message must pass before being turned around and sent out to the 
people subscribed. A lot of spam has recently gotten extremely poor in it's 
spelling - so filters would miss stuff like this unless the filtering 
software itself had some excellent heuristics.

No, I didn't just propose adding filtering to LKML and VGER and then shoot it 
down - rather, I pointed out a flaw with the traditional filtering model. A 
solution to this would be to add filters that examine the mail headers 
themselves, since I am certain that some of the software used for sending 
spam does leave a signature in the headers.

One signature that comes to mind is the "Grab two words from a dictionary file 
and smash them together with a letter to form a valid looking name" tactic 
that seems to have become, lately, a preferred method for the zombie 
spambots.  To filter for those messages one just needs a good dictionary file 
(the Aspell American or British English dictionary comes to mind) and 
software that can match the two words against that list. I could *easily* 
write that in PERL in under 10 minutes.

These are suggestions only. I am most definately *not* offering to do anything 
- my plate is full and seems like it will remain that way for the forseeable 
future.

DRH
