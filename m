Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964974AbVKHJ3U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964974AbVKHJ3U (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Nov 2005 04:29:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965014AbVKHJ3U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Nov 2005 04:29:20 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:14208 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S964974AbVKHJ3T (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Nov 2005 04:29:19 -0500
Date: Tue, 8 Nov 2005 10:28:48 +0100
From: Pavel Machek <pavel@suse.cz>
To: John Lenz <lenz@cs.wisc.edu>
Cc: Ben Dooks <ben@fluff.org.uk>, vojtech@suse.cz, rpurdie@rpsys.net,
       kernel list <linux-kernel@vger.kernel.org>,
       Russell King <rmk@arm.linux.org.uk>
Subject: Re: best way to handle LEDs
Message-ID: <20051108092848.GH15730@elf.ucw.cz>
References: <20051101234459.GA443@elf.ucw.cz> <20051102024755.GA14148@home.fluff.org> <20051102095139.GB30220@elf.ucw.cz> <43093.192.168.0.12.1130985101.squirrel@192.168.0.2> <20051107233000.GC2034@elf.ucw.cz> <52781.192.168.0.12.1131409634.squirrel@192.168.0.2>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <52781.192.168.0.12.1131409634.squirrel@192.168.0.2>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >> I just looked, and
> >> http://www.cs.wisc.edu/~lenz/zaurus/files/patch-2.6.7-jl2.diff.gz
> >> contins
> >> the implementation of the arm led interface for collie.... not sure if
> >> it
> >> will still work anymore, but...
> >
> > It does, after kconfig fixups. Do you think we could get that merged?
> > Some led driver is better than none at all.
> 
> I wonder, because we are exporting an API to userspace.  I don't think the
> openembedded people want to use this API, and will hold off doing anything
> with the leds till we get something else straigtend out.  If we have this
> API now, we will have issues breaking it later (or we will have to do some
> wierd locking scheme to allow both interfaces control, and crap like
> that).

* they are 9 users of "old" interface already, one more does not seem
like a big deal.

* arm maintainer does not want anything more complex than "old"
interface. And I can see his point. It is not clear if "new" interface
will get into mainline.

* there are very little users of collie, currently. Changing LED API
on myself does not seem like a big deal. [I'm trying hard to get _two
more_ users :-)]

* if openembedded people do not like current interface, they should a)
convince rmk API needs to change and b) convert all the drivers.

> Secondly, leds aren't that importent unless they are supported by the
> userspace programs (to do things like blink when email shows up).  And
> before the userspace starts using leds, I think they might want to clear
> up the interface API issue first.

I'd say charger LED is somehow important, and I liked CPU usage LED a lot.

								Pavel
-- 
Thanks, Sharp!
