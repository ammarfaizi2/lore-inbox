Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290103AbSA3RM4>; Wed, 30 Jan 2002 12:12:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290203AbSA3RMo>; Wed, 30 Jan 2002 12:12:44 -0500
Received: from dsl-213-023-038-145.arcor-ip.net ([213.23.38.145]:52883 "EHLO
	starship.berlin") by vger.kernel.org with ESMTP id <S290231AbSA3RMV>;
	Wed, 30 Jan 2002 12:12:21 -0500
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: grumph@pakistanmail.com, linux-kernel@vger.kernel.org
Subject: Re: Wanted: Volunteer to code a Patchbot
Date: Wed, 30 Jan 2002 18:17:16 +0100
X-Mailer: KMail [version 1.3.2]
Cc: torvalds@transmeta.com, hpa@zytor.com
In-Reply-To: <3c580adc.3d7c.0@pakistanmail.com>
In-Reply-To: <3c580adc.3d7c.0@pakistanmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E16VyMG-0000G7-00@starship.berlin>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On January 30, 2002 06:09 pm, grumph@pakistanmail.com wrote:
> I did some thinking just before this thread surfaced.
> 
> What can a patchbot be trusted to do properly?  (see below)
> ---------------------------------------------------
> Linus got his style of working and he's got no intention whatsoever to
> change that. So what is needed is a bot that works according to Linus' 
> taste, but goes behind his back when it comes to informing the poor 
> patch submitters....
> 
> As always, simplicity rules. 
> 
> None of this relies on a bot handling actual patching of code in the
> tree. A live, human (most of you, I assume) being will have to review
> and manually apply the patch.
> 
> None of this requires Linus to change his habits, he could still apply
> any patches sent to torvalds@transmeta. Trusted people could still send
> Linus patches directly.
> 
> But the newbies and untrusted guys without an established relationship to
> a trusted kernel developer get a little help to keep their patch updated. 
> 
> It is not going to help on bad person chemistry or bad code. But it
> could weed out the obvious non-starters and help people get it right,
> without bothering busy kernel developers.
> 
> 
> What can a patchbot be trusted to do properly?
> ---------------------------------------------------
> - receive mail sent to: patch-2.5-linus@kernel or patch-2.4-marcelo@kernel
>  (you get the idea; version and tree)
> - patch-id assignment for tracking of patches accepted by bot
> - sender authentication/confirmation, as for mailing list subscriptions
> - verify that patch 
> 	- applies to latest tree
> 	- isn't oversized (by some definition)
> 	- is correctly formatted
> 	- contains a rationale (in some predefined format)
> - route patch to correct maintainer(s), based on the files it touches
> 	(may require some initial work)
> - inform sender that patch was forwarded to <maintainer>
> - inform sender that patch was automatically rejected because it:
> 	- does not apply to latest tree
> 	- is too big/touches too many files
> 	- does not compile (hardware reqs.? OSD labs?)
> 	- does not contain aforementioned rationale
> 	- isn't formatted according to CodingStyle (Does current code?)
> - inform sender that patch did not end up in next snap of tree, 
> 	possibly because of:
> 	- conflict with other patch
> 	- a human didn't like the taste of it (-EBADTASTE)
> 	- maintainer has not reviewed the patch yet
> 	(use the above assigned patch-id to detect if patch was applied)
> - ask sender to rediff, review and resubmit patch 
>   The bot could do this by itself. But it isn't linus-style.
>   The sender should maintain his own patch.
> - inform the sender how to kill a patch-id from being processed	
> - automatically kill patch-ids from being processed if sender does not 
>   respond within <time>
> - killfile abusers (needs policy)
> - publish patches on kernel.org and linux-kernel as they come in.
> ----------------------------------------------------------

Yes, you have the idea most precisely.  You left out:

  - post the patch to the respective mailing list (the one the patch
    was sent to)

> Will Linus immediately killfile mail sent from this bot?

I don't think so, unless the bot is really poorly designed.  This is *not* 
going to be a spambot.  When the time comes, i.e., when the bot is designed 
in detail, or better, function, we'll ask him, ok?  Or, if he so much as 
scowls in this direction, work stops right now ;-)

> Will hpa host it at kernel.org?

Again, once we know what the details of the bot are we'll ask him, i.e., how 
heavy a resource user it's expected to be, if he even thinks the idea is 
sound, etc.  Right now he could only answer in general terms, so the thing to 
do is produce something concrete, not theoretical.

> Will someone write the code if it gets thumbs up from linus/hpa?

Somewhat unexpectedly, three coders responded to my call for volunteers:
   
   Kalle Kivimaa <killer@iki.fi>
   Rasmus Andersen <rasmus@jaquet.dk>
   Giacomo Catenazzi <cate@debian.org>

I must say, I've been impressed with the insight of all three.  Would you be 
a fourth?  A mailing list has been set up (by Giacomo):

   http://killeri.net/cgi-bin/alias/ezmlm-cgi

> Is it going to make a difference?

Yes, I think it is.  At the very least it will give Linux users a place to go 
and troll for interesting patches, sort of like Freshmeat.  I'm expecting a 
considerably more from it though.  Look no further than your own list above 
to see what it can do.  Which, by the way, bears a remarkable resemblance to 
the list we just hashed out a few minutes ago.

-- 
Daniel
