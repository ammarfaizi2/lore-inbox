Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965205AbWJBSCn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965205AbWJBSCn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Oct 2006 14:02:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965207AbWJBSCn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Oct 2006 14:02:43 -0400
Received: from smtp.osdl.org ([65.172.181.4]:8928 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965205AbWJBSCm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Oct 2006 14:02:42 -0400
Date: Mon, 2 Oct 2006 11:02:36 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: "Martin J. Bligh" <mbligh@mbligh.org>, Lee Revell <rlrevell@joe-job.com>,
       Matti Aarnio <matti.aarnio@zmailer.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Spam, bogofilter, etc
In-Reply-To: <1159811392.8907.36.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.64.0610021050350.3952@g5.osdl.org>
References: <1159539793.7086.91.camel@mindpipe>  <20061002100302.GS16047@mea-ext.zmailer.org>
  <1159802486.4067.140.camel@mindpipe> <45212F39.5000307@mbligh.org> 
 <Pine.LNX.4.64.0610020933020.3952@g5.osdl.org> <1159811392.8907.36.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 2 Oct 2006, Alan Cox wrote:
>
> Ar Llu, 2006-10-02 am 09:40 -0700, ysgrifennodd Linus Torvalds:
> > If you want a yes/no kind of thing, do it on real hard issues, like not 
> > accepting email from machines that aren't registered MX gateways. Sure, 
> > that will mean that people who just set up their local sendmail thing and 
> > connect directly to port 25 will just not be able to email, but let's face 
> > it, that's why we have ISP's and DNS in the first place.
> 
> Except most of the ISPs are incompetent and many people have to run
> their own mail system in order to get mail that actually *works*. I've
> had that experience several times, although thankfully I now have a sane
> ISP.

Sure. I kind of agree - I'm just saying that if you have a _hard_ 
decision, you should base in on _hard_ data. 

The MX checking is at least hard, and is a valid reason to just deny 
email. I'm not claiming it's "perfect", but it's a hell of a lot better 
than bayes.

> MX checking is as broken or more broken than bayes.

I have to say, OSDL has been doing MX checking, and it's effective as 
hell. Most importantly, when it _does_ break, it's not because some 
"content" is considered inappropriate, it's because some ISP does 
something technically wrong.

OSDL also refused to talk to open mail relays etc. I got into something of 
a (fairly civilized) shouting match with John Gilmore over it, who used to 
send out email from a "fake open mail relay" on princuple (maybe he still 
does). He claimed I was censoring his free speech rights when I didn't 
read his emails, but I just told him that I was expressing my right to not 
listen to people who are so stupid that they can't configure their email 
servers.

(I'm not saying that John is stupid, since he did it on purpose, but he 
was also clever enough to know exactly what was involved, so it's not like 
he couldn't be heard if he wanted to - it's not "censoring" if nobody 
listens to you because you built your own sound-proof walls around you).

> There is another reason bayes is not very good too - every good spammer
> reruns their message through spamassassin adding random text till they
> get a good score *then* they spew it out.

Yes. Which is why it's better to rely on hard technical data, or on a 
large body of different small rules, including some that are personalized 
(ie white-lists and blacklists that are site-specific, including making 
things like the bayesian rules be per-site - perhaps _seeded_ by some 
common data, but updated locally).

Of course, the MX checking can also be avoided, and a lot of spam-bots 
know to use the ISP connection instead of a direct port-25 approach. But 
at least that way, the mail gateway can (and often does) notice the 
flooding, and many ISP's successfully throttle at least some spam at the 
source, so it does actually have real meaning.

		Linus
