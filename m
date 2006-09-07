Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751763AbWIGNyl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751763AbWIGNyl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Sep 2006 09:54:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751764AbWIGNyl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Sep 2006 09:54:41 -0400
Received: from relay03.pair.com ([209.68.5.17]:40204 "HELO relay03.pair.com")
	by vger.kernel.org with SMTP id S1751763AbWIGNyk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Sep 2006 09:54:40 -0400
X-pair-Authenticated: 71.197.50.189
Date: Thu, 7 Sep 2006 08:46:56 -0500 (CDT)
From: Chase Venters <chase.venters@clientec.com>
X-X-Sender: root@turbotaz.ourhouse
To: Krzysztof Halasa <khc@pm.waw.pl>
cc: Chase Venters <chase.venters@clientec.com>, ellis@spinics.net,
       w@1wt.eu (Willy Tarreau), linux-kernel@vger.kernel.org
Subject: Re: bogofilter ate 3/5
In-Reply-To: <m37j0fvqkq.fsf@defiant.localdomain>
Message-ID: <Pine.LNX.4.64.0609070834180.31500@turbotaz.ourhouse>
References: <200609061856.k86IuS61017253@no.spam>
 <Pine.LNX.4.64.0609061409360.18840@turbotaz.ourhouse> <m34pvkvhm0.fsf@defiant.localdomain>
 <Pine.LNX.4.64.0609061658440.18840@turbotaz.ourhouse> <m37j0fvqkq.fsf@defiant.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 7 Sep 2006, Krzysztof Halasa wrote:

> Chase Venters <chase.venters@clientec.com> writes:
>
>> You can check the From: or envelope sender against the subscriber
>> database. Forgery isn't a concern because we're not trying to stop
>> forgery with this method.
>
> That's the first problem.
>

The problem with trying to stop forgery is that there is not yet a 
foolproof or reasonably foolproof method of doing so. All available 
options require cooperation from other MTAs, MUAs, users or 
administrators; hence, they're only good at increasing 'HAM' score.

It is also at least partially unapplicable to LKML since this list 
deliberately allows anyone to post.

>> The perl script behaves as an optional autoresponder. Autoresponders
>> would respond to spam as well (well, unless you put a spam filter in
>> front of them, but I assume that many don't).
>
> Yep. Sending their "responses" to innocent people, instead of spam
> senders. That's what many "antivirus" do.
>
>> Also note that a number of people (myself included, at work anyway)
>> have perl scripts that respond to all incoming mail and require a
>> reply cookie from original envelope senders. We do it because it
>> almost entirely prevents spam from arriving in our inboxes
>
> Sure. Don't you think is also prevents a lot of legitimate mail?
> Hope that all addresses you send mail to are automatically added
> to a white list? (I'm especially annoyed with people asking me for
> something, and then my answer bounces with "click somewhere"
> response).
>

Yeah, I whitelist on that address as well. And if someone does respond to 
the challenge (all it takes is reply/send, as I've used a signed VERP as 
the Reply-To), they get whitelisted. If the challenge bounces, it bounces 
to the envelope sender (a different signed VERP) which increases their 
blacklist score by 1. Get a blacklist score of 3 and I'll silently ignore 
your mail for 6 months.

Thanks,
Chase
