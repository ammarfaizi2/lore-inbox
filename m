Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750931AbVKIOYj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750931AbVKIOYj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Nov 2005 09:24:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750958AbVKIOYi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Nov 2005 09:24:38 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:4994 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1750931AbVKIOYh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Nov 2005 09:24:37 -0500
Date: Tue, 8 Nov 2005 14:14:45 +0100
From: Pavel Machek <pavel@suse.cz>
To: Richard Purdie <rpurdie@rpsys.net>
Cc: John Lenz <lenz@cs.wisc.edu>, Ben Dooks <ben@fluff.org.uk>,
       vojtech@suse.cz, kernel list <linux-kernel@vger.kernel.org>,
       Russell King <rmk@arm.linux.org.uk>
Subject: Re: best way to handle LEDs
Message-ID: <20051108131444.GA31883@elf.ucw.cz>
References: <20051101234459.GA443@elf.ucw.cz> <20051102024755.GA14148@home.fluff.org> <20051102095139.GB30220@elf.ucw.cz> <43093.192.168.0.12.1130985101.squirrel@192.168.0.2> <20051107233000.GC2034@elf.ucw.cz> <52781.192.168.0.12.1131409634.squirrel@192.168.0.2> <20051108092848.GH15730@elf.ucw.cz> <1131451660.8350.63.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1131451660.8350.63.camel@localhost.localdomain>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > * they are 9 users of "old" interface already, one more does not seem
> > like a big deal.
> > 
> > * arm maintainer does not want anything more complex than "old"
> > interface. And I can see his point. It is not clear if "new" interface
> > will get into mainline.
> > 
> > * there are very little users of collie, currently. Changing LED API
> > on myself does not seem like a big deal. [I'm trying hard to get _two
> > more_ users :-)]
> > 
> > * if openembedded people do not like current interface, they should a)
> > convince rmk API needs to change and b) convert all the drivers.
> > 
> > > Secondly, leds aren't that importent unless they are supported by the
> > > userspace programs (to do things like blink when email shows up).  And
> > > before the userspace starts using leds, I think they might want to clear
> > > up the interface API issue first.
> > 
> > I'd say charger LED is somehow important, and I liked CPU usage LED a lot.
> 
> You can implement the charger LED without needing to implement any led
> interface, as the sharpsl_pm charger code does. For now the charge led
> is hard coded (but easily changed later to become a trigger).

Yes, it can be done.

> My rough plan is to implement the led trigger code and present this
> along with a modified version of John's sysfs class code to LKML. If
> accepted, great (and there was a demand for a standard interface from
> various quarters). If not, I'll offer it as a patch series outside of
> the kernel as openembedded, opie, gpe and handhelds.org are likely to
> use it regardless of what LKML thinks. We can then see how its usage
> becomes. The only change I will ask for is that the CONFIG_LEDS
> namespace as used by ARM is reconsidered.

Well, if it is accepted by LKML, fine. [I did not realize someone is
actually working on it].

If it is rejected, tough, I believe openembedded etc. should just use
official interface.

> Both John and myself have resisted putting any LED code into mainline as
> we don't feel the existing interfaces match Zaurus developer's and
> user's needs. To submit such patches would suggest we planned to support
> the existing interfaces which we do not.

Ok, I guess it all depends on LMKL and rmk's reaction. If LED layer is
rejected, I'd rather have something that can handle the simple
case. Hopefully enough cases (handhelds, IBM special leds, ...) are
there and LED layer gets accepted.
								Pavel
-- 
Thanks, Sharp!
