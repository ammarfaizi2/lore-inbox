Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964959AbWFSWll@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964959AbWFSWll (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jun 2006 18:41:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964960AbWFSWll
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jun 2006 18:41:41 -0400
Received: from mx1.redhat.com ([66.187.233.31]:33472 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S964959AbWFSWll (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jun 2006 18:41:41 -0400
Date: Mon, 19 Jun 2006 18:41:30 -0400
From: Dave Jones <davej@redhat.com>
To: Pavel Machek <pavel@ucw.cz>
Cc: "linux-os (Dick Johnson)" <linux-os@analogic.com>,
       Andreas Mohr <andi@rhlx01.fht-esslingen.de>,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC/SERIOUS] grilling troubled CPUs for fun and profit?
Message-ID: <20060619224130.GA17134@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Pavel Machek <pavel@ucw.cz>,
	"linux-os (Dick Johnson)" <linux-os@analogic.com>,
	Andreas Mohr <andi@rhlx01.fht-esslingen.de>,
	linux-kernel@vger.kernel.org
References: <20060619191543.GA17187@rhlx01.fht-esslingen.de> <Pine.LNX.4.61.0606191542050.4926@chaos.analogic.com> <20060619202354.GD26759@redhat.com> <20060619222528.GC1648@openzaurus.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060619222528.GC1648@openzaurus.ucw.cz>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 20, 2006 at 12:25:29AM +0200, Pavel Machek wrote:
 
 > > Another anecdote: Upon fan failure, I once had an athlon MP *completely shatter*
 > > (as in broke in two pieces) under extreme heat.
 > > 
 > > This _does_ happen.
 > 
 > If it happens to you... you needed a new cpu anyway. Anything non-historical
 > *has* thermal protection.

That's the single dumbest thing I've read today.

newsflash: you don't get to dictate when I (or anyone else) buys new hardware.
Before its accident, that box happily was my home firewall for 3 years, and
its replacement is actually an /older/ box.  I didn't "need a new cpu" at all.

(incidentally, it was replaced with a VIA C3 that doesn't need a fan :)

 > BTW I doubt those old athlons can be saved by cli; hlt . (Someone willing to try if old
 > athlon can run cli; hlt code w/o heatsink?).

you snipped the important part of my mail.

"cpu_relax() and friends aren't going to save a box"

We have two completely different things being discussed in this thread.

1. Fan failure, and the possibility to keep running.
IMO, there's nothing we can do here, and nor should we try.

2. Situations where we forcibly lock up and spin the CPU in a tight loop,
producing heat.  Given there are CPUs that benefit from cpu_relax()
in such places, adding them so that they don't unnecessarily sit there
sucking power until someone gets to the datacenter to investigate
can only be a good thing.

 > And no, we probably do not want to enter C2 or C3 from doublefault handler.

I didn't see that being proposed.

		Dave

-- 
http://www.codemonkey.org.uk
