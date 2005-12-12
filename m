Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750864AbVLLGwg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750864AbVLLGwg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Dec 2005 01:52:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751086AbVLLGwg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Dec 2005 01:52:36 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:150 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1750864AbVLLGwf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Dec 2005 01:52:35 -0500
Date: Mon, 12 Dec 2005 07:51:50 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Helge Hafting <helgehaf@aitel.hist.no>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.6.15-rc5: multiuser scheduling trouble
Message-ID: <20051212065150.GA8187@elte.hu>
References: <Pine.LNX.4.64.0512032155290.3099@g5.osdl.org> <20051210162759.GA15986@aitel.hist.no> <Pine.LNX.4.64.0512111607040.15597@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0512111607040.15597@g5.osdl.org>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -1.7
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-1.7 required=5.9 tests=ALL_TRUSTED,AWL autolearn=no SpamAssassin version=3.0.3
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
	1.2 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Helge,

* Linus Torvalds <torvalds@osdl.org> wrote:

> Also, the most common case is that somebody has reniced the X server, 
> which is just _wrong_.  It used to be done by some distributions to 
> try to help the scheduler make the right choices, but we've fixed the 
> scheduler and it doesn't need it or want it.

> > Knowing the root password I renices his Xorg and firefox by 10, and 
> > then everything is fine.  His games are still ok, and my xterms are 
> > snappy again.

does this mean X defaults to nice level 0, and then if you renice
Firefox and X by +10, everything is fine? Or is Linus' suspicion, and X
defaults to something like nice -5? (e.g. on Debian type of systems)

but ... i havent seen problems with Firefox and flash myself. My 3 years
old son's favorite kid's site is fully based on flash, and the 833 MHz
laptop is still usable remotely while he browses around on it. It's
Fedora Core 4, and X is not reniced.

but if the X server is not reniced then it would be nice if i could
reproduce the starvation ... which site is the one triggering it? (and
could you check www.egyszervolt.hu, and click around on it, does it
trigger similar starvation problems too?)

	Ingo
