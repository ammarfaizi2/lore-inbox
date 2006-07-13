Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161045AbWGMXU7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161045AbWGMXU7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jul 2006 19:20:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161049AbWGMXU7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jul 2006 19:20:59 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:60637 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1161045AbWGMXU6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jul 2006 19:20:58 -0400
Date: Fri, 14 Jul 2006 01:20:26 +0200
From: Pavel Machek <pavel@ucw.cz>
To: andrea@cpushare.com
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       ajwade@cpe001346162bf9-cm0011ae8cd564.cpe.net.cable.rogers.com,
       Lee Revell <rlrevell@joe-job.com>,
       "Randy.Dunlap" <rdunlap@xenotime.net>, Andrew Morton <akpm@osdl.org>,
       bunk@stusta.de, linux-kernel@vger.kernel.org, mingo@elte.hu
Subject: Re: [2.6 patch] let CONFIG_SECCOMP default to n
Message-ID: <20060713232026.GA6117@elf.ucw.cz>
References: <20060629192121.GC19712@stusta.de> <200607102159.11994.ajwade@cpe001346162bf9-cm0011ae8cd564.cpe.net.cable.rogers.com> <20060711041600.GC7192@opteron.random> <200607111619.37607.ajwade@cpe001346162bf9-cm0011ae8cd564.cpe.net.cable.rogers.com> <20060712210545.GB24367@opteron.random> <1152741776.22943.103.camel@localhost.localdomain> <20060712234441.GA9102@opteron.random> <20060713212940.GB4101@ucw.cz> <20060713231118.GA1913@opteron.random>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060713231118.GA1913@opteron.random>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

I do not want to enter seccomp flamewar, and that's why I did not
answer to Ingo.

> > Actually random delays are unlike to help (much). You have just added
> > noise, but you can still decode original signal...
> 
> You're wrong, the random delays added to every packet will definitely
> wipe out any signal.

Strictly speaking, this is wrong. This is like adding noise into the
room. You have to pick up maximum delay (ammount of noise), and you
clearly can't override signal that's longer than maximum delay. But
you also can't override signal that's half the maximum delay, given
that transmitter will retransmit it 4-or-so times. Just average 4
samples, and your random delays will cancel out.

No, this probably does not apply to seccomp, because we are picking
unintended noise from affected computer.

OTOH I'm pretty sure I could communicate from seccomp process by
sending zeros alone, and I cound communicate from another process on
box running seccomp through your randomizing packetizer to my machine.

								Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
