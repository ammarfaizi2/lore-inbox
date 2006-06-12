Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750923AbWFLJF1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750923AbWFLJF1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jun 2006 05:05:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750916AbWFLJF0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jun 2006 05:05:26 -0400
Received: from mail.gmx.de ([213.165.64.20]:50643 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1750809AbWFLJF0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jun 2006 05:05:26 -0400
X-Authenticated: #428038
Date: Mon, 12 Jun 2006 11:05:21 +0200
From: Matthias Andree <matthias.andree@gmx.de>
To: Matti Aarnio <matti.aarnio@zmailer.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: VGER does gradual SPF activation  (FAQ matter)
Message-ID: <20060612090521.GE11649@merlin.emma.line.org>
Mail-Followup-To: Matti Aarnio <matti.aarnio@zmailer.org>,
	linux-kernel@vger.kernel.org
References: <20060610222734.GZ27502@mea-ext.zmailer.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060610222734.GZ27502@mea-ext.zmailer.org>
X-PGP-Key: http://home.pages.de/~mandree/keys/GPGKEY.asc
User-Agent: Mutt/1.5.11-2006-06-08
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 11 Jun 2006, Matti Aarnio wrote:

> Now that there is even an RFC published about SPF...
> 
> 
> What is SPF ?
> 
> It is one way to to ensure that at SMTP transport level the claimed
> message source domain is valid, and message is coming from place
> where origination domain's administrator has declared that are valid
> source servers for emails claiming to be of that domain.

So the spammers declare valid sending sites (0.0.0.0/0 anyone) for their
botnet in a particular domain. The domain is registered via anonymizing
proxy and long gone by the time it appears in black lists. What did you
gain?

> It does NOT verify that SMTP origination local part is true. 

Good. But what's the cause for SPF then?

> It does NOT verify message visible headers.

SPF isn't meant to.

> What it gives ?
> 
> It gives us a way to tell the world, that emails claiming to be
> coming from VGER should be accepted only when they really are
> coming from vger.

No, it doesn't. It gives vger admins a way to tell the world what the
vger outgoing MXs are. vger is *NOT* in a position to set end site
policies, and shouldn't claim so.

> (Complications like recipients incoming MX
> relays are not _our_ problem..)

Right. Shift the blame on those over whom you claimed sovereignty over
their policies one breath before. Is that how SPF adoption policy works?
If so, I'd consider that a pretty dirty way of doing things and I'd
rather wash my hands clean of such policies if my name were Matti
Aarnio.

> We might get slight reduction of back falling junk at vger with
> that - reduction increases when people begin to deploy the SPF
> verification more and more widely into their receiving email servers.

I believe checking Received: headers of backscatter (that term is used
in Postfix discussions for "back falling junk") catches a fair amount of
that junk.

> Will VGER begin to verify SPF in incoming email ?
> 
> Yes, sometime this summer.

I suggest not.

> You really should go and read SPF documents and guides and FAQs at:
>     http://spf.pobox.com/
> 
> Very little will break,

Mail forwarding breaks, massively. The costly SRS workaround just adds
new problems without coming to a real solution.

Perhaps you might want to remove vger from doing mail altogether and
switch to Usenet news. Admins cancel obvious spam and that's it.

> In longer run the amount of irresponsible (incurable) network security
> holes (known as Windows)

So refuse mail from Windows sites. p0f can do it. PF (a packet filter
offered by some BSD systems) can do it.

> shows no sign of becoming extinct at adsl -lines,
> so there will be increased pressure to demand sender identification
> (and verification) during email sending - viruses can't do that yet...

So you think? Have you counted sites that have deployed DRAC and other
pop-before-smtp junk? Viruses can easily bypass those and get the
"verified" tag from SPF. How /very/ useful SPF is.

> And when they learn, user with infection can be trivially identified
> and contacted/blocked.

They could do that today if they so desired. They don't care, and they
won't care in the future.

> At the same time I do find it most likely that
> ADSL-lines (and modems) will no longer be allowed to send _anywhere_
> over plain SMTP.

So you'd reject my validly GnuPG signed messages just because I'm
sending from a BSD or Linux or Solaris ADSL? What a disruption of
service.

SPF is a non-starter.

Perhaps you should consider having filters look at the *content* of
messages. Does it fit how common messages look on vger lists? Or does it
look like the usual spam? bogofilter can to it. qsf can do it. spamprobe
can do it.  crm114 can do it.  Some of these (bogofilter for instance)
can ascertain how much it's spam, how much it's wanted, or if it's
undecided.

-- 
Matthias Andree
