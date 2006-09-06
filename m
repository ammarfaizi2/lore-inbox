Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751745AbWIFWJe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751745AbWIFWJe (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Sep 2006 18:09:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751757AbWIFWJe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Sep 2006 18:09:34 -0400
Received: from relay02.pair.com ([209.68.5.16]:38661 "HELO relay02.pair.com")
	by vger.kernel.org with SMTP id S1751745AbWIFWJd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Sep 2006 18:09:33 -0400
X-pair-Authenticated: 71.197.50.189
Date: Wed, 6 Sep 2006 17:05:05 -0500 (CDT)
From: Chase Venters <chase.venters@clientec.com>
X-X-Sender: root@turbotaz.ourhouse
To: Krzysztof Halasa <khc@pm.waw.pl>
cc: Chase Venters <chase.venters@clientec.com>, ellis@spinics.net,
       w@1wt.eu (Willy Tarreau), linux-kernel@vger.kernel.org
Subject: Re: bogofilter ate 3/5
In-Reply-To: <m34pvkvhm0.fsf@defiant.localdomain>
Message-ID: <Pine.LNX.4.64.0609061658440.18840@turbotaz.ourhouse>
References: <200609061856.k86IuS61017253@no.spam>
 <Pine.LNX.4.64.0609061409360.18840@turbotaz.ourhouse> <m34pvkvhm0.fsf@defiant.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 6 Sep 2006, Krzysztof Halasa wrote:

> Chase Venters <chase.venters@clientec.com> writes:
>
>> 1. Incoming mail from subscribers is accepted
>
> How do you know if the sender is really a subscriber?

You can check the From: or envelope sender against the subscriber 
database. Forgery isn't a concern because we're not trying to stop 
forgery with this method. Subscribers subscribing one address and sending 
from another is also not a problem since a lookup failure just means you 
get to ride through the bogofilter. Note as well that #4 is a separate 
program; this lookup is likely done by the mailing list software.

#1 should significantly reduce the load on the bogofilter (not sure if 
that matters though).

>> 4. A handy Perl script subscribes to lkml, and for any message it gets
>> with an X-Bogofilter: SPAM header, it sends a notification
>> (rate-limited) to the message sender
>
> How do you know who the sender really is? IMHO bouncing anything
> (especially spam) after SMTP OK is worse than the spam itself.
>

The perl script behaves as an optional autoresponder. Autoresponders would 
respond to spam as well (well, unless you put a spam filter in front of 
them, but I assume that many don't).

Also note that a number of people (myself included, at work anyway) have 
perl scripts that respond to all incoming mail and require a reply cookie from original 
envelope senders. We do it because it almost entirely prevents spam from 
arriving in our inboxes (I say almost because there is the occasional 
spammer that doesn't forge their sender address and has some kind of 
autoresponder behind it). I had to do this for my work account to stop the
hundreds of messages I was getting each day after a co-worker "pranked me" 
by signing me up for all that crap.

Thanks,
Chase
