Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932400AbWFLVvG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932400AbWFLVvG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jun 2006 17:51:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932403AbWFLVvG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jun 2006 17:51:06 -0400
Received: from ns.firmix.at ([62.141.48.66]:8864 "EHLO ns.firmix.at")
	by vger.kernel.org with ESMTP id S932400AbWFLVvE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jun 2006 17:51:04 -0400
Subject: Re: VGER does gradual SPF activation (FAQ matter)
From: Bernd Petrovitsch <bernd@firmix.at>
To: Horst von Brand <vonbrand@inf.utfsm.cl>
Cc: marty fouts <mf.danger@gmail.com>, David Woodhouse <dwmw2@infradead.org>,
       Matti Aarnio <matti.aarnio@zmailer.org>, linux-kernel@vger.kernel.org
In-Reply-To: <200606122025.k5CKPTGB005597@laptop11.inf.utfsm.cl>
References: <200606122025.k5CKPTGB005597@laptop11.inf.utfsm.cl>
Content-Type: text/plain
Organization: http://www.firmix.at/
Date: Mon, 12 Jun 2006 23:43:11 +0200
Message-Id: <1150148591.3107.16.camel@gimli.at.home>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: -2.333 () AWL,BAYES_00,FORGED_RCVD_HELO
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-06-12 at 16:25 -0400, Horst von Brand wrote:
> Bernd Petrovitsch <bernd@firmix.at> wrote:
[...]
> > The "problem" is that postmasters on the Net must do something
> 
> It took /years/ until open relays weren't common anymore... and that is a

ACK. And it will take years to somwhat get a grip on the the spam
problem. And will take more "tools" than SPF.

> /simple/ measure, on by default in newer upstream packages, no admin
> intervention required. DNS works badly, here in Chile a mayor ISP had a

Well, the only necessary admin intervention was "update that MTA
package". This seems trivial and no work for people used to
yum/apt-get/urpmi/red-carpet/... but it looked quite differently 10
years ago for other OSs (Win*, Solaris 2.5, etc., hell, I knew of a
third-party MTA on Novell 3.12 where it was not even possible to
deactivate relaying).

> totally broken setup for many years.

It was an interesting experience in Austria for (mostly small) ISPs that
from one day to another email delivery didn't work anymore. No wonder
since they had almost no reverse DNS zones .... 

> >                                                                (namely
> > 1) define if they want to allow others to detect forged emails claimed
> > to come from their domain
> 
> They have /very/ little to gain by that, and setting it up correctly is a
> mayor hassle. It breaks people sending mail "from" the domain when they
> aren't there (this is rather common for people on the road), and has no
> real fix. I.e., it won't ever be done. Or it will be tried, some email from

Use secure authenticated mail submission on a known good MTA of said
domain (and even the smallest ISP should be able to set that up).
Yes, this seems like a waste of everything - but IMHO neglectable
compared to the ressources wasted by spam.

> Big Cheese doesn't go through, and it will be axed.
> 
> >                           and 2) - if yes to 1) - to get appropriate SPF
> > records into DNS)
> 
> Many people have no (or very little) control over their DNS data. A spammer
> can then just claim it comes from one of the millions of SPF-less domains
> in the world (if they don't set up their own SPFied one...). Besides,
> discussions on the spamassassin lists show that SPFied email is a rather
> reliable indicator of spam as things stand today...

Apparently spammers are faster to adopt new developments and standards
than others. SCNR ...

> >                   and people must either use a "good" mail relay (and
> > not just the one next door) or convince postmasters to change the SPF
> > records.
> 
> Won't happen.
> 
> > > It'll break standard-abiding email.
> 
> > As you see, standards change.
> 
> Yep. But SPF breaks email, not just changes the standard. For no gain at all.

Well, if you run a mail server behind a quite small line and some
spammer really forges your domain in the From: so that it takes 4 days
(yes, 96 hours) so that the bounce storm calms down and legitimate mail
can be processed again, means against trivial domain forgeries make
sense.

> > > Do you really want that?
> 
> > Yes. Especially gmail.com should do such a thing - there is such a lot
> > of - presumbly forged - @gmail.com mails in my mailboxes that
> > blacklisting the whole domain causes probably more good than bad (for
> > me, of course).
> 
> There is spam that really comes from gmail...

Probably. But this is a problem gmail must (and only can) solve.

	Bernd
-- 
Firmix Software GmbH                   http://www.firmix.at/
mobil: +43 664 4416156                 fax: +43 1 7890849-55
          Embedded Linux Development and Services

